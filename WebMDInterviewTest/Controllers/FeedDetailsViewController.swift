//
//  FeedDetailsViewController.swift
//  WebMDInterviewTest
//
//  Created by Mark Abrasaldo on 9/3/22.
//

import UIKit
import SDWebImage

class FeedDetailsViewController: UIViewController {
	
	@IBOutlet weak var itemImageView: UIImageView!
	@IBOutlet weak var itemDescriptionLabel: UILabel!
	@IBOutlet weak var itemDetailLabel: UILabel!
	@IBOutlet weak var scrollView: UIScrollView!
	
	var itemTitle: String?
	var itemImageURL: String?
	var itemDescription: String?
	var itemDetail: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.title = itemTitle
		
		itemImageView.sd_setImage(with: URL(string: itemImageURL ?? ""))
		itemDescriptionLabel.text = itemDescription
		itemDetailLabel.text = itemDetail
		
		if itemImageURL == nil {
			itemImageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
		}
		
		if itemDescription == "" {
			itemDescriptionLabel.isHidden = true
		}
		
		if itemDetail == "" {
			itemDetailLabel.isHidden = true
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		scrollView.contentSize = CGSize(width: view.frame.size.width, height: UIScreen.main.bounds.height)
		scrollView.automaticallyAdjustsScrollIndicatorInsets = false
	}
}

extension FeedDetailsViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		scrollView.contentOffset.x = 0.0
	}
}

