//
//  NewsListTableViewController.swift
//  TinkoffNews
//
//  Created by Aleksandr X on 27.08.17.
//  Copyright © 2017 Khlebnikov. All rights reserved.
//

import UIKit

class NewsListTableViewController: UITableViewController, NewsListView {
    
    var presenter: NewsListPresenter?
    
    @IBOutlet private weak var emptyView: UIView!
    
    private var newsTitles = [NewsViewData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = NewsListPresenter(view: self, newsService: NewsService())
        presenter?.provider = Provider(navigationController: navigationController!)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40
        addPullToRefresh()
        reload()
    }
    
    func addPullToRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(NewsListTableViewController.reload), for: .valueChanged)
        tableView.addSubview(refreshControl!)
    }
    
    func reload() {
        presenter?.update()
    }
    
    //MARK: - NewsListView realisation
    func startLoading() {

    }
    
    func stopLoading() {
        OperationQueue.main.addOperation {
            self.refreshControl?.endRefreshing()
        }
    }
    
    func set(titles: [NewsViewData]) {
        emptyView.bounds = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 0)
        newsTitles = titles
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsTitles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsTitleCell", for: indexPath) as! NewsTitleTableViewCell
        cell.fill(data: newsTitles[indexPath.row])
        return cell
    }
    
    //MARK: - Table view delegate 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter?.selectNews(withIndex: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 300))
        footer.backgroundColor = .lightGray
        return footer
    }
 
}
