//
//  GalleryCollectionViewController.swift
//  ghibliGallery
//
//  Created by Chia on 2022/01/26.
//

import UIKit

class GalleryCollectionViewController: UICollectionViewController {
    
    let movieTitle: String
    let imgName: String
    
    var images: [UIImage] = []
    
    
    let loadingIndicator = UIActivityIndicatorView()
    let loadingView = UIView()
    
    
    init?(coder: NSCoder, movieTitle: String, imgName: String) {
        self.movieTitle = movieTitle
        self.imgName = imgName
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = movieTitle
        configureCellSize()
        addLoadingView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getImages()
        loadingView.removeFromSuperview()
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(GalleryCollectionViewCell.self)", for: indexPath) as! GalleryCollectionViewCell
        cell.imageView.image = images[indexPath.row]
        return cell
    }
    
    // MARK: - Show Detail
    @IBSegueAction func showDetail(_ coder: NSCoder) -> DetailViewController? {
        guard let indexPath = collectionView.indexPathsForSelectedItems else { return DetailViewController(coder: coder, image: UIImage()) }
        let index = indexPath[0][1]
        let imageNo = String(format: "%03d", index+1)
        if let url = URL(string: "https://www.ghibli.jp/gallery/\(imgName)\(imageNo).jpg") {
            return DetailViewController(coder: coder, image: getImageFromUrl(url: url))
        } else {
            return DetailViewController(coder: coder, image: UIImage())
        }
    }
    
    // MARK: - CollectionViewCell Size
    func configureCellSize() {
        let itemSpace: CGFloat = 3    // cell間距
        let columnCount: CGFloat = 3  // 每行顯示cell數
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let width = floor((collectionView.bounds.width - itemSpace * (columnCount-1)) / columnCount)
        flowLayout?.itemSize = CGSize(width: width, height: width)
        flowLayout?.estimatedItemSize = .zero           // 讓cell尺寸依據設定的itemSize顯示
        flowLayout?.minimumInteritemSpacing = itemSpace // 設定cell左右間距
        flowLayout?.minimumLineSpacing = itemSpace      // 設定上下間距
    }
    
    // MARK: - Loading View
    func addLoadingView() {
        loadingView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        loadingIndicator.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        loadingIndicator.startAnimating()
        loadingIndicator.style = .large
        loadingView.addSubview(loadingIndicator)
        view.addSubview(loadingView)
    }
    
    // MARK: - Get Images
    func getImages() {
        for imageNo in 1...20 {
            let imageNoString = String(format: "%03d", imageNo)
            if let url = URL(string: "https://www.ghibli.jp/gallery/\(imgName)\(imageNoString).jpg") {
                images += [getImageFromUrl(url: url)]
            }
        }
        collectionView.reloadData()
    }
    
    func getImageFromUrl(url: URL) -> UIImage {
        do {
            let data = try Data(contentsOf: url)
            return UIImage(data: data)!
        } catch {
            return UIImage()
        }
    }

}
