//
//  BlurView.swift
//  Task
//
//  Created by Andrey on 22.06.2023.
//

import SwiftUI

struct BlurView: UIViewRepresentable {

    let style: UIBlurEffect.Style

    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        containerView.insertSubview(blurView, at: 0)
        blurView.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        blurView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        return containerView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {}

}

