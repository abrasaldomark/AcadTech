import XCTest
@testable import WebMDInterviewTest

class WebMDInterviewTest_UnitTests: XCTestCase {
    
    /**
     1. Write 2 unit tests for the FeedItem model (valid decoding, invalid decoding)
     2. Write unit test for validating the filtering and sorting of the feed items.
     3. OPTIONAL: Write at least 1 unit test for a functionality you think that it needs to be covered by tests.
     */
	
	func testCanParseData() {
		
	}
	
	
	func testCanParseDataViaJSONFile() throws {
		guard let pathString = Bundle(for: type(of: self)).path(forResource: "data", ofType: "json") else {
			fatalError("data.json not found")
		}

		guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
			fatalError("Unable to convert data.json to String")
		}

		print("The JSON string is: \(jsonString)")

		guard let jsonData = jsonString.data(using: .utf8) else {
			fatalError("Unable to convert data.json to Data")
		}

		guard let jsonDictionary = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:Any] else {
			fatalError("Unable to convert data.json to JSON dictionary")
		}

		print("The JSON dictionary is: \(jsonDictionary)")
		
		let feedItemData = try! JSONDecoder().decode(FeedItem.self, from: jsonData)
		
		XCTAssertEqual("Biotin Can Distort Lab Tests", feedItemData.title)
	}
}
