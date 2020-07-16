//
//  BSActionSheetViewController.swift
//  C24Profis
//
//  Created by Bisma Saeed on 15.07.20.
//

class BSActionSheetViewController: UIViewController {
    let actionSheet: BSImageActionSheet
    init(actionSheet: BSImageActionSheet) {
        self.actionSheet = actionSheet
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3) {
           self.view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        }
        actionSheet.modalTransitionStyle = .coverVertical
        actionSheet.modalPresentationStyle = .overFullScreen
        present(actionSheet, animated: true, completion: nil)
    }
    
    func removeBackground() {
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = .clear
        }
    }
}
