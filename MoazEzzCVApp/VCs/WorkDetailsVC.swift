//
//  WorkDetailsVC.swift
//  MoazEzzCVApp
//
//  Created by Moaz Ezz on 5/1/18.
//  Copyright © 2018 Moaz Ezz. All rights reserved.
//

import UIKit
import Hero

class WorkDetailsVC: TransitionBaseViewController {
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    let contentCard = UIView()
    let cardView = CardView()
    let contentView = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        view.addSubview(visualEffectView)
        
        cardView.titleLabel.text = "Hero 2"
        cardView.subtitleLabel.text = "App Store Card Transition"
        
        contentView.numberOfLines = 0
        contentView.text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent neque est, hendrerit vitae nibh ultrices, accumsan elementum ante. Phasellus fringilla sapien non lorem consectetur, in ullamcorper tortor condimentum. Nulla tincidunt iaculis maximus. Sed ut urna urna. Nulla at sem vel neque scelerisque imperdiet. Donec ornare luctus dapibus. Donec aliquet ante augue, at pellentesque ipsum mollis eget. Cras vulputate mauris ac eleifend sollicitudin. Vivamus ut posuere odio. Suspendisse vulputate sem vel felis vehicula iaculis. Fusce sagittis, eros quis consequat tincidunt, arcu nunc ornare nulla, non egestas dolor ex at ipsum. Cras et massa sit amet quam imperdiet viverra. Mauris vitae finibus nibh, ac vulputate sapien.
        """
        
        contentCard.backgroundColor = .white
        contentCard.clipsToBounds = true
        
        contentCard.addSubview(contentView)
        contentCard.addSubview(cardView)
        view.addSubview(contentCard)
        
        // add a pan gesture recognizer for the interactive dismiss transition
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(gr:))))
    }
    @objc func handlePan(gr: UIPanGestureRecognizer) {
        let translation = gr.translation(in: view)
        switch gr.state {
        case .began:
            dismiss(animated: true, completion: nil)
        case .changed:
            Hero.shared.update(translation.y / view.bounds.height)
        default:
            let velocity = gr.velocity(in: view)
            if ((translation.y + velocity.y) / view.bounds.height) > 0.5 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let bounds = view.bounds
        visualEffectView.frame  = bounds
        contentCard.frame  = bounds
        cardView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.width)
        contentView.frame = CGRect(x: 20, y: bounds.width + 20, width: bounds.width - 40, height: bounds.height - bounds.width - 20)
    }
}
