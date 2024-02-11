//
//  Models+DelayPrediction.swift
//  AmadeusBookingApp
//
//  Created by Margels on 08/02/24.
//

import Foundation

struct DelayPredictionResponse: Decodable {
    let data: [DelayPrediction]
}

struct DelayPrediction: Decodable {
    let type: String
    let subType: String
    let id: String
    let result: PredictionResultType
    let probability: String
}

enum PredictionResultType: String, Decodable {
    case LESS_THAN_30_MINUTES
    case BETWEEN_30_AND_60_MINUTES
    case BETWEEN_60_AND_120_MINUTES
    case OVER_120_MINUTES_OR_CANCELLED
    
    var description: String {
        switch self {
        case .LESS_THAN_30_MINUTES:
            "on time"
        case .BETWEEN_30_AND_60_MINUTES:
            "delayed between 30 and 60 minutes"
        case .BETWEEN_60_AND_120_MINUTES:
            "delayed between 60 and 120 minutes"
        case .OVER_120_MINUTES_OR_CANCELLED:
            "delayed by over 120 minutes or cancelled"
        }
    }
    
}
