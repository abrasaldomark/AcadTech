/**
 1. Load the feed items using the FeedProvider.
 2. Display the feed items using a table view (following best practices for design). Each feed item should be contain the followings:
	a. An image loaded from the FeedItem imageUrl param (you can use the Foundation framework or any open source technology to load the image).
	b. If the imageUrl param is nil, you should only show the FeedItem's title and description.
	c. The FeedItem's title param below the image. This text should be a bit larger and bold.
	d. The FeedItem's description param below the title. This text should be a standard, but readable text size.
 3. Each feed item, when tapped, should push a new controller (you must create this new controller) that displays the corresponding FeedItem's parameters:
	a. The FeedItem's title param should be used as navigation bar title.
	b. At the top of the page, an image loaded from the FeedItem imageUrl param. (You can use the Foundation framework or any open source technology to load the image.)
	c. If the imageUrl param is nil, you should only show the FeedItem's title, description and details.
	d. The FeedItem's description parameter below the image. This text should be a standard, but readable text size.
	e. The FeedItem's detail parameter below the description. This text should be a standard, but readable text size.
		
 */

import UIKit
import SDWebImage

class ItemsTableViewCell: UITableViewCell {
	@IBOutlet weak var itemImageView: UIImageView!
	@IBOutlet weak var itemTitle: UILabel!
	@IBOutlet weak var itemDescription: UILabel!
}

class FeedTableViewController: UITableViewController {
	
	var itemList = [FeedItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		getFeedProviderData()
    }
	
	func getFeedProviderData() {
		self.itemList = FeedProvider.init().sortTitle()
	}
}

extension FeedTableViewController {
	// MARK: - TableView DataSsource
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemList.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "itemsTableViewCell", for: indexPath) as! ItemsTableViewCell
		
		cell.itemImageView.sd_setImage(with: URL(string: itemList[indexPath.row].imageURL ?? ""))
		cell.itemTitle.text = itemList[indexPath.row].title ?? ""
		cell.itemDescription.text = itemList[indexPath.row].itemDescription ?? ""
		
		if itemList[indexPath.row].imageURL == nil {
			cell.itemImageView.isHidden = true
		}
		
		if itemList[indexPath.row].title == "" {
			cell.itemTitle.isHidden = true
		}
		
		if itemList[indexPath.row].itemDescription == "" {
			cell.itemDescription.isHidden = true
		}
		return cell
	}
	
	// MARK: - TableView Delegate
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let sb = UIStoryboard(name: "Main", bundle: nil)
		let vc = sb.instantiateViewController(withIdentifier: "feedDetailsViewController") as! FeedDetailsViewController
		vc.itemTitle = itemList[indexPath.row].title
		vc.itemImageURL = itemList[indexPath.row].imageURL
		vc.itemDescription = itemList[indexPath.row].itemDescription
		vc.itemDetail = itemList[indexPath.row].detail
		navigationController?.pushViewController(vc, animated: true)
	}
}

