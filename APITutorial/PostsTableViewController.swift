//
//  PostsTableViewController.swift
//  APITutorial
//
//  Created by Morgan Davison on 1/21/20.
//  Copyright © 2020 Morgan Davison. All rights reserved.
//

import UIKit

class PostsTableViewController: UITableViewController {
    
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPosts()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)

        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title

        return cell
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let postDetailViewController = segue.destination as? PostDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow
            else {
                return
        }
        
        let post = posts[indexPath.row]
        postDetailViewController.postId = post.id
    }
    
    
    // MARK: - Helpers
    
    private func fetchPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            print("Failed to create a URL from the string.")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data")
                return
            }

            let decoder = JSONDecoder()

            do {
                self?.posts = try decoder.decode([Post].self, from: data)
            } catch {
                print("Failed to decode data: \(error.localizedDescription)")
            }

            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        task.resume()
    }
    


}
