//
//  NewsTableViewController.swift
//  News
//
//  Created by Jacksons MacBook on 28.03.2021.
//


import UIKit

class NewsTableViewController: UITableViewController {
        
    private var newsClient = NewsClient()
    
     private var posts = [Post]() {
        didSet {
            self.tableView.reloadData()
        }
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStarView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
        
        
    
    //MARK: -Protocol
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let urlString = posts[indexPath.row].url else { return }
        openInBrowser(with: urlString)
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as!  PostTableViewCell
            
        let post = posts[indexPath.row]
        cell.authorLabel.text = post.author
        cell.sourceLabel.text = post.source
        cell.descriptionLabel.text = post.description
        cell.titleLabel.text = post.title
        cell.imageURL.text = post.urlToImage
        cell.getImage { (data, error) in
            DispatchQueue.main.async {
                cell.imageArea.image = UIImage(data: data!)
            }
        }
        return cell 
    }
    
    
    
    //MARK: -Function(s)
    
    func openInBrowser(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        guard let vc = storyboard?.instantiateViewController(identifier: "WebKitViewController") as? WebKitViewController else {return}
        vc.url = url
        vc.title = "read more"
        navigationController?.pushViewController(vc, animated: true)
        //present(vc, animated: true, completion: nil)
    }
    
    
    
    func configureStarView() {
        title = "News"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostTableViewCell.nib(), forCellReuseIdentifier: PostTableViewCell.identifier)
        navigationController?.navigationBar.prefersLargeTitles = true
        //UIRefreshControll
        tableView.refreshControl = UIRefreshControl()
        tableView.tableFooterView = UIView()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshView), for: .valueChanged)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
    }
    
    
    
    
    @objc func refreshView() {
        posts.removeAll()
        DispatchQueue.main.async() {
            self.tableView.refreshControl?.endRefreshing()
            self.fetchData()
        }
    }

    
    
    
    func fetchData() {
        newsClient.getLatestNewsUsing { posts in
            for post in posts {
                DispatchQueue.main.async {
                    self.posts.append(post)
                }
            }
        }
    }
    
    
    
    
    @objc func search() {
        let ac = UIAlertController(title: "Search", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "search", style: .default, handler: { (action) in
            NewsClient.word = ac.textFields![0].text!
            self.refreshView()                                                                   
        }))
        present(ac, animated: true)
    }
    
    
}
