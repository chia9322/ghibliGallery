//
//  DetailViewController.swift
//  ghibliGallery
//
//  Created by Chia on 2022/01/26.
//

import UIKit

class DetailViewController: UIViewController {
    
    var image: UIImage
    
    @IBOutlet var imageView: UIImageView!
    
    init?(coder: NSCoder, image: UIImage) {
        self.image = image
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
}
