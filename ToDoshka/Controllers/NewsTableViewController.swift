//
//  NewsTableViewController.swift
//  ToDoshka
//
//  Created by Bhavananda Das on 10.03.2024.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var articlesIn = APIRes(articles: [Article]())
   
    
    let newsURL = "https://newsapi.org/v2/everything?q=apple&from=2024-03-10&to=2024-03-10&sortBy=popularity&apiKey=4e17082ef3a9499aa8b40698e10245b2"
    
    @IBOutlet var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
        NewsManager().fetchAPIData(URL: newsURL) {result in
            self.articlesIn = result
            DispatchQueue.main.async {
                self.newsTableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let articles = articlesIn.articles
            return articles.count
    
        }
    
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
            let articles = articlesIn.articles
            cell.titleLable?.text = articles[indexPath.row].title
            cell.descriptionLable?.text = articles[indexPath.row].description
            cell.imageURL.load(url: articles[indexPath.row].urlToImage ?? URL(string: "")!)
            
            

            return cell
        }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

