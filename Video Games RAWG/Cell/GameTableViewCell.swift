//
//  GameTableViewCell.swift
//  Video Games RAWG
//
//  Created by klikdokter on 26/03/23.
//

import UIKit

final class GameTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind(data: Game) {
        if let backgroundImage = data.backgroundImage {
            if let backgroundImageUrl = URL(string: backgroundImage) {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: backgroundImageUrl)
                    DispatchQueue.main.async {
                        self.coverImageView.layer.cornerRadius = 8
                        self.coverImageView.layer.masksToBounds = true
                        self.coverImageView.image = UIImage(data: data!)
                    }
                }
            }
        }
        
        DispatchQueue.main.async {
            self.titleLabel.text = data.name
            self.subtitleLabel.text = "Released date \(data.released ?? "")"
            self.ratingLabel.text = "\(data.rating ?? 0.0)"
        }
    }
    
}
