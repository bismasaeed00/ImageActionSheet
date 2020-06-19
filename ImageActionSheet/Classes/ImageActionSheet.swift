//
//  ImageActionSheet.swift
//  ImageActionSheet
//
//  Created by Bisma Saeed on 21.05.20.
//  Copyright © 2020 Bisma Saeed. All rights reserved.
//

import UIKit
import Foundation

public class ImageActionSheet: UIViewController {
    var configuration = ActionSheetConfiguration()
    
    private var message: String?
    private var alertTitle: String?
    private var containerView = UIView()
    private var actions = [AlertAction]()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing   = 8
        return stackView
    }()
    
    private var cancelButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(dismissSheet), for: .touchUpInside)
        return button
    }()
    
    private var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    //MARK: Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        view.frame = UIScreen.main.bounds
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -configuration.viewPadding)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(title:String?, message:String?) {
        self.init()
        self.alertTitle = title
        self.message = message
    }
    
    //MARK: Public
    public func add(action: AlertAction) {
        actions.append(action)
    }
    
    public func show(in view: UIViewController) {
        configureView()
        modalPresentationStyle = .overFullScreen
        view.present(self, animated: true, completion: nil)
    }
    
    //MARK: Private
    private func configureView() {
        addCancelButton()
        addActionsBackgroundView()
        if message?.isEmpty == false || title?.isEmpty == false {
            addActionSheetInfo()
        }
        addActions()
    }
    
    private func addActionsBackgroundView() {
        let actionBackgroundView = UIView()
        actionBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        actionBackgroundView.backgroundColor = .white
        actionBackgroundView.clipsToBounds = true
        actionBackgroundView.layer.cornerRadius = 16
        containerView.addSubview(actionBackgroundView)
        
        NSLayoutConstraint.activate([
            actionBackgroundView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: configuration.viewPadding),
            actionBackgroundView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: configuration.seperationPadding),
            actionBackgroundView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -configuration.seperationPadding),
            actionBackgroundView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -configuration.seperationPadding)
        ])
        
        actionBackgroundView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: actionBackgroundView.topAnchor, constant: 0),
            stackView.leftAnchor.constraint(equalTo: actionBackgroundView.leftAnchor, constant: 0),
            stackView.rightAnchor.constraint(equalTo: actionBackgroundView.rightAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: actionBackgroundView.bottomAnchor, constant: -configuration.viewPadding)
        ])
    }
    
    private func addActionSheetInfo() {
        let messageBackgroundView = UIView()
        messageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(messageBackgroundView)
        
        messageBackgroundView.addSubview(titleLabel)
        messageBackgroundView.addSubview(messageLabel)
        
        titleLabel.text = alertTitle
        titleLabel.textColor = configuration.infoColor
        titleLabel.font = UIFont.systemFont(ofSize: configuration.titleFontSize, weight: .medium)
        
        messageLabel.text = message
        messageLabel.textColor = configuration.infoColor
        messageLabel.font = UIFont.systemFont(ofSize: configuration.messageFontSize)
        
        NSLayoutConstraint.activate([
            messageBackgroundView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0),
            messageBackgroundView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: messageBackgroundView.topAnchor, constant: configuration.viewPadding),
            titleLabel.leftAnchor.constraint(equalTo: messageBackgroundView.leftAnchor, constant: configuration.viewPadding),
            titleLabel.rightAnchor.constraint(equalTo: messageBackgroundView.rightAnchor, constant: -configuration.viewPadding)
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: configuration.viewPadding),
            messageLabel.leftAnchor.constraint(equalTo: messageBackgroundView.leftAnchor, constant: configuration.viewPadding),
            messageLabel.rightAnchor.constraint(equalTo: messageBackgroundView.rightAnchor, constant: -configuration.viewPadding),
            messageLabel.bottomAnchor.constraint(equalTo: messageBackgroundView.bottomAnchor, constant: -configuration.viewPadding)
        ])
    }
    
    private func addActions() {
        actions.forEach { addAction($0) }
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { timer in
            self.view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        }
    }
    
    private func addAction(_ action: AlertAction ) {
        guard let title = action.title else { return }
        addSeparater(in: stackView)
        
        let horizontalStackView = UIStackView()
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis  = NSLayoutConstraint.Axis.horizontal
        horizontalStackView.distribution  = UIStackView.Distribution.fill
        horizontalStackView.alignment = UIStackView.Alignment.center
        horizontalStackView.spacing   = 12
        stackView.addArrangedSubview(horizontalStackView)
        
        NSLayoutConstraint.activate([
            horizontalStackView.heightAnchor.constraint(equalToConstant: 50),
            horizontalStackView.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: configuration.viewPadding)
        ])
        
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(configuration.tintColor, for: .normal)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: configuration.viewPadding, bottom: 0, right: 0)
        if let action = action.action {
            button.actionHandler(controlEvents: .touchUpInside, ForAction: action)
        }
        
        button.setImage(action.icon, for: .normal)
        horizontalStackView.addArrangedSubview(button)
    }
    
    private func addSeparater(in stackView: UIStackView) {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 1)
        ])
        stackView.addArrangedSubview(view)
    }
    
    private func addCancelButton() {
        containerView.addSubview(cancelButton)
        cancelButton.setTitle(configuration.cancelButtonTitle, for: .normal)
        
        NSLayoutConstraint.activate([
            cancelButton.heightAnchor.constraint(equalToConstant: configuration.elementHeight + 8),
            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: configuration.seperationPadding),
            cancelButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -configuration.seperationPadding),
            cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -configuration.seperationPadding)
        ])
    }
    
    @objc private func dismissSheet() {
        dismiss(animated: true, completion: nil)
    }
}
