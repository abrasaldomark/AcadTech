/**
 Create a model that will represent the top-level structure of the data.json file (i.e will hold the list of feed items).
 */

import Foundation

// MARK: - FeedResponseModel
struct FeedResponseModel: Codable {
	let items: [Item]?
}

// MARK: - Item
struct Item: Codable {
	let title: String?
	let itemDescription: String?
	let imageURL: String?
	let detail: String?

	enum CodingKeys: String, CodingKey {
		case title
		case itemDescription = "description"
		case imageURL = "image_url"
		case detail
	}
}
