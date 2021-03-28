//
//  PostTableViewCell.swift
//  News
//
//  Created by Jacksons MacBook on 28.03.2021.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    static let identifier = "PostTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageURL: UILabel! {
        didSet{
            imageURL.textColor = .blue
        }
    }
    
    //Name "imageArea" because of the "imageView" will conflict with its super class(UITableViewCell)
    @IBOutlet weak var imageArea: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.imageArea.contentMode = .scaleToFill
    }
    
    
    
    //MARK: -Function(s)
    func getImage(handler: @escaping (Data?, Error?) -> ()) {
        let urlString = imageURL.text ?? ""
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil, data != nil {
                handler(data, error)
            }
        }.resume()
    }
}
