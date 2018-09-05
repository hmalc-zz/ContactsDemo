//
//  MasterViewController.swift
//  ShowbieCodingChallenge
//
//  Created by Hayden Malcomson on 2018-09-04.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

import UIKit

enum MasterVCSegue: String {
    case showDetail = "showDetail"
}

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    
    fileprivate lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.activityIndicatorViewStyle = .whiteLarge
        activityIndicatorView.color = UIColor.black
        activityIndicatorView.hidesWhenStopped = true

        var center = self.view.center
        if let navigationBarFrame = self.navigationController?.navigationBar.frame {
            center.y -= (navigationBarFrame.origin.y + navigationBarFrame.size.height)
        }
        activityIndicatorView.center = center
        self.view.addSubview(activityIndicatorView)
        return activityIndicatorView
    }()
    
    var users = [RandomUser]() {
        didSet {
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchData()
        activityIndicatorView.startAnimating()
    }
    
    @objc func fetchData(){
        RandomUserAPIService.fetchCanadianRandomUsers { (response, error) in
            guard let fetchedUsers = response?.results else { self.handleFetchDataError(); return }
            self.users = fetchedUsers
        }
    }
    
    func handleFetchDataError(){
        // TODO: Handle it
    }
    
    func configureUI(){
        configureTableView()
        configureRefreshView()
        navigationItem.leftBarButtonItem = editButtonItem
        //let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        //navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    func configureTableView(){
        let randomUserTableCell = UINib(nibName: "RandomUserTableCell", bundle: nil)
        self.tableView.register(randomUserTableCell, forCellReuseIdentifier: "RandomUserTableCell")
    }
    
    func configureRefreshView(){
        self.refreshControl = UIRefreshControl()
        self.tableView.alwaysBounceVertical = true
        self.refreshControl?.tintColor = UIColor.black
        self.refreshControl?.addTarget(self, action: #selector(fetchData), for: .valueChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MasterVCSegue.showDetail.rawValue {
            if let indexPath = tableView.indexPathForSelectedRow {
                let user = users[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.user = user
                controller.userDataEntryDelegate = self
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RandomUserTableCell", for: indexPath) as? RandomUserTableCell {
            cell.configure(with: users[indexPath.row])
            return cell
        }
        fatalError("RandomUserTableCell did not cast")
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: MasterVCSegue.showDetail.rawValue, sender: nil)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }


}

extension MasterViewController: UserDataEntryDelegate {
    
    func shouldUpdateValidEmail(emailString: String) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let cell = tableView.cellForRow(at: indexPath) as? RandomUserTableCell else { return }
        cell.emailLabel.text = emailString
    }
    
    func shouldResetEmail() {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let cell = tableView.cellForRow(at: indexPath) as? RandomUserTableCell else { return }
        cell.emailLabel.text = users[indexPath.row].email
    }
    
}

