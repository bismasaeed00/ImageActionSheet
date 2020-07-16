//
//  BSImageActionSheet.swift
//  BSImageActionSheet
//
//  Created by Bisma Saeed on 21.05.20.
//  Copyright © 2020 Bisma Saeed. All rights reserved.
//

import UIKit
import Foundation

public class BSImageActionSheet: UIViewController {
    var configuration = BSActionSheetConfiguration()
    
    private var message: String?
    private var alertTitle: String?
    private var containerView = UIView()
    private let cancelButton = UIButton()
    private var presenterView: BSActionSheetViewController?
    private var actions = [BSAlertAction]()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing   = 8
        return stackView
    }()
    
    // MARK: Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSheet)))
        
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -configuration.viewPadding)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(title: String?, message: String?) {
        self.init()
        self.alertTitle = title
        self.message = message
    }
    
    // MARK: Public
    public func add(action: BSAlertAction) {
        actions.append(action)
    }
    
    public func show() {
        configureView()
        let actionSheetViewController = BSActionSheetViewController(actionSheet: self)
        actionSheetViewController.modalTransitionStyle = .crossDissolve
        actionSheetViewController.modalPresentationStyle = .overFullScreen
        UIApplication.shared.windows.first?.rootViewController?.present(actionSheetViewController, animated: false, completion: nil)
        presenterView = actionSheetViewController
    }
    
    // MARK: Private
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
    
    private func getLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = configuration.infoColor
        return label
    }
    
    private func addActionSheetInfo() {
        let messageBackgroundView = UIView()
        messageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(messageBackgroundView)
        
        let titleLabel = getLabel()
        let messageLabel = getLabel()
        messageBackgroundView.addSubview(titleLabel)
        messageBackgroundView.addSubview(messageLabel)
        
        titleLabel.text = alertTitle
        titleLabel.font = UIFont.systemFont(ofSize: configuration.titleFontSize, weight: .medium)
        messageLabel.text = message
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
    }
    
    private func addAction(_ action: BSAlertAction ) {
        guard let title = action.title else { return }
        addSeparater(in: stackView)
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(configuration.tintColor, for: .normal)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: configuration.viewPadding, bottom: 0, right: 0)
        button.addAction(for: .touchUpInside) { [weak self] in
            self?.dismissSheet(completion: {
                action.action?()
            })
        }
        button.setImage(action.icon, for: .normal)
        stackView.addArrangedSubview(button)
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 50),
            button.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: configuration.viewPadding)
        ])
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
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.backgroundColor = .white
        cancelButton.layer.cornerRadius = 16
        cancelButton.clipsToBounds = true
        cancelButton.addTarget(self, action: #selector(dismissSheet), for: .touchUpInside)
        cancelButton.setTitle(configuration.cancelButtonTitle, for: .normal)
        cancelButton.setTitleColor(configuration.tintColor, for: .normal)
        containerView.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            cancelButton.heightAnchor.constraint(equalToConstant: configuration.elementHeight + 8),
            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: configuration.seperationPadding),
            cancelButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -configuration.seperationPadding),
            cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -configuration.seperationPadding)
        ])
    }
    
    @objc private func dismissSheet(completion: (() -> Void)? = nil) {
        self.presenterView?.removeBackground()
        dismiss(animated: true, completion: {
            self.presenterView?.dismiss(animated: false, completion: completion)
        })
    }
}
