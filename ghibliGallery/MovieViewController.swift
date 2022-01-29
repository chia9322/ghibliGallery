//
//  MovieViewController.swift
//  ghibliGallery
//
//  Created by Chia on 2022/01/26.
//

import UIKit

class MovieViewController: UIViewController {
    
    var movieTitle: String = ""
    var imgName: String = ""
    
    let movies: [String: String] = ["ハウルの動く城": "howl", "千と千尋の神隠し": "chihiro", "もののけ姫": "mononoke", "魔女の宅急便": "majo", "となりのトトロ": "totoro"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        movieTitle = sender.titleLabel!.text!
        imgName = movies[movieTitle] ?? ""
        performSegue(withIdentifier: "showGallery", sender: nil)
    }
    
    @IBSegueAction func showGallery(_ coder: NSCoder) -> GalleryCollectionViewController? {
        return GalleryCollectionViewController(coder: coder, movieTitle: movieTitle, imgName: imgName)
    }
    
}
