import Foundation

/**
 1. Create a function that will use the ResourceReader to read the data.json file and map the data to the corresponding models. - done
 2. Any feed items with the same title are considered duplicates and should be removed. - done
 3. Sort the FeedItem objects in alphabetical order by title. - done
 4. Make sure not to block the main thread when this task is performed. - 
 Note that this function should be used by FeedViewController to get the array of filtered and sorted FeedItem objects.
 */

struct FeedProvider {
	
	func getFeed(getFeedCompletion: @escaping([FeedItem]?) -> Void) {
		
		var feedItem = [FeedItem]()

		let resourceReaderData: FeedResponseModel = try! ResourceReader.read(resource: "data", ofType: "json")
		
		if let items = resourceReaderData.items {
			for item in items {
				let itemModel = FeedItem.init(imageURL: item.imageURL,
											  title: item.title,
											  itemDescription: item.itemDescription,
											  detail: item.detail)
				// check if exists
				if !feedItem.contains(where: { $0.title == item.title }) {
					feedItem.append(itemModel)
				}
			}
		}
		
		// sort alphabetical order by title
		let sortedFeedItem: [FeedItem] = feedItem.sorted(by: { $0.title! < $1.title! })
		
		for sortedFeedItem in sortedFeedItem {
			print("sortedFeedItem.imageURL \(sortedFeedItem.imageURL)")
			print("sortedFeedItem.title \(sortedFeedItem.title)")
			print("sortedFeedItem.itemDescription \(sortedFeedItem.itemDescription)")
			print("sortedFeedItem.detail \(sortedFeedItem.detail)")
			print("sortedFeedItem.#######################################")
		}

		getFeedCompletion(sortedFeedItem)
	}
}
