//
//  CustomHeaderView.swift
//  AmadeusBookingApp
//
//  Created by Margels on 09/02/24.
//

import Foundation
import UIKit

final class CustomHeaderView: UIView {
    
    private lazy var warningLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        l.textColor = .secondaryLabel
        l.text = initialText
        l.numberOfLines = 0
        l.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return l
    }()
    
    var initialText = "No delay prediction available for this flight."
    var finalPrediction = ""
    var probabilityAndResult: (Int, String, PredictionResultType) = (0, "", .LESS_THAN_30_MINUTES) { didSet { didUpdateProbabilityAndResult() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetText() {
        warningLabel.text = initialText
    }
    
    private func setUpLayout() {
        addSubview(warningLabel)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
        
            warningLabel.topAnchor.constraint(equalTo: topAnchor),
            warningLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            trailingAnchor.constraint(equalTo: warningLabel.trailingAnchor, constant: 30),
            bottomAnchor.constraint(equalTo: warningLabel.bottomAnchor)
            
        ])
    }
    
    private func didUpdateProbabilityAndResult() {
        
        let index = probabilityAndResult.0
        let probability = probabilityAndResult.1.integerValue
        let result = probabilityAndResult.2
        
        DispatchQueue.main.async {
            let newLine = self.finalPrediction == "" ? "" : "\n"
            var prediction = "\(newLine)Flight no. \(index) has \(probability)% chance of being \(result.description)"
            
            switch (probability, result) {
            case (_, .LESS_THAN_30_MINUTES):
                prediction = "\(newLine)Flight no. \(index) is usually on time"
                self.warningLabel.textColor = .systemGreen
            case ((0...29), .BETWEEN_30_AND_60_MINUTES):
                self.warningLabel.textColor = .systemOrange
            default:
                self.warningLabel.textColor = .systemRed
            }
            
            self.finalPrediction.append(prediction)
            self.warningLabel.text = self.finalPrediction
        }
    }
    
}
