//
//  MonthConfig.swift
//  MonthlyWidgetExtension
//
//  Created by Vito Borghi on 25/01/2024.
//

import SwiftUI

struct MonthConfig {
    let bgColor: Color
    let emojiText: String
    let weekdayTextColor: Color
    let dayTextColor: Color
    
    static func determinConfig(from date: Date) -> MonthConfig {
        let month = Calendar.current.component(.month, from: date)
        
        switch month {
        case 1:
            return MonthConfig(bgColor: .gray,
                        emojiText: "☃️",
                        weekdayTextColor: .black.opacity(0.6),
                        dayTextColor: .white.opacity(0.8)
            )
        case 2:
            return MonthConfig(bgColor: .gray,
                        emojiText: "☃️",
                        weekdayTextColor: .black.opacity(0.6),
                        dayTextColor: .white.opacity(0.8)
            )
        default:
            fatalError() //needs actually implementing
        }
    }
}
