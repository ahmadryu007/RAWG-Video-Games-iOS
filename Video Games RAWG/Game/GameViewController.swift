//
//  GameViewController.swift
//  Video Games RAWG
//
//  Created by klikdokter on 26/03/23.
//

import UIKit

final class GameViewController: UIViewController {
    
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var countPlayedLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var presenter: GamePresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadDetailGame()
        
        if let backgroundImage = presenter.game.backgroundImage {
            if let backgroundImageUrl = URL(string: backgroundImage) {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: backgroundImageUrl)
                    DispatchQueue.main.async {
                        self.coverImageView.image = UIImage(data: data!)
                    }
                }
            }
        }
        
        titleLabel.text = presenter.game.name
        subtitleLabel.text = "Released date \(presenter.game.released ?? "")"
        ratingLabel.text = "\(presenter.game.rating ?? 0.0)"
        publisherLabel.text = ""
        descriptionTextView.text = ""
        countPlayedLabel.text = ""
    }

}

extension GameViewController: GameViewInterface {
    func bind(detail: GameDetail) {
        DispatchQueue.main.async { [weak self] in
            self?.publisherLabel.text = detail.publishers?.first?.name
            self?.descriptionTextView.attributedText = detail.description?.htmlToAttributedString
            self?.countPlayedLabel.text = "\(detail.metacritic ?? 0) played"
        }
    }
    
    func showError(message: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(action)
            self?.present(alert, animated: true)
        }
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
