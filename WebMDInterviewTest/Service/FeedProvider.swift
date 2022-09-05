import Foundation

/**
 1. Create a function that will use the ResourceReader to read the data.json file and map the data to the corresponding models.
 2. Any feed items with the same title are considered duplicates and should be removed.
 3. Sort the FeedItem objects in alphabetical order by title.
 4. Make sure not to block the main thread when this task is performed.
 Note that this function should be used by FeedViewController to get the array of filtered and sorted FeedItem objects.
 */

struct FeedProvider {
	
	func getFeed() -> FeedResponseModel {
		let resourceReaderData: FeedResponseModel = try! ResourceReader.read(resource: "data", ofType: "json")
		return resourceReaderData
	}
	
	func filterDuplicate() -> [FeedItem] {
		var feedItem = [FeedItem]()

		if let items = getFeed().items {
			for item in items {
				let itemModel = FeedItem.init(imageURL: item.imageURL,
											  title: item.title,
											  itemDescription: item.itemDescription,
											  detail: item.detail)
				if !feedItem.contains(where: { $0.title == item.title }) {
					feedItem.append(itemModel)
				}
			}
		}
		return feedItem
	}
	
	func sortTitle() -> [FeedItem] {
		let sortedFeedItem: [FeedItem] = filterDuplicate().sorted(by: { $0.title! < $1.title! })
		return sortedFeedItem
	}
}
