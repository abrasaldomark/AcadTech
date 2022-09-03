/**
 Create a model that will represent the feed item from the data.json file.
 */

import Foundation

struct FeedItem: Codable {
	let imageURL: String?
	let title: String?
	let itemDescription: String?
	let detail: String?
}
