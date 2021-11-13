//
//  CASecondaryTitle.swift
//  CashApp
//
//  Created by Ahmet Yusuf Yuksek on 10/29/21.
//

import UIKit

class CashAppSecondaryTitle: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    init(textAlignment: NSTextAlignment, size: CGFloat) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: size, weight: .medium)
        self.textAlignment = textAlignment
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        textColor = .white
        adjustsFontSizeToFitWidth = true
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}
