//
//  MonthlyWidget.swift
//  MonthlyWidget
//
//  Created by Vito Borghi on 25/01/2024.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: Date(), emoji: "⛄️")
    }

    func getSnapshot(in context: Context, completion: @escaping (DayEntry) -> ()) {
        let entry = DayEntry(date: Date(), emoji: "⛄️")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [DayEntry] = []

        // Generate a timeline consisting of seven entries a day apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startDate = Calendar.current.startOfDay(for: entryDate)
            let entry = DayEntry(date: startDate, emoji: "⛄️")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct DayEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct MonthlyWidgetEntryView : View {
    var entry: Provider.Entry
    let monthConfig: MonthConfig
    
    init(entry: DayEntry) {
        self.entry = entry
        self.monthConfig = .determineConfig(from: entry.date)
    }

    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(monthConfig.backgroundColor)
                
            VStack {
                HStack(spacing: 4) {
                    Text(monthConfig.emojiText)
                        .font(.title)
                    
                    Text(entry.date.weekdayDisplayFormat)
                        .font(.headline)
                        .bold()
                        .minimumScaleFactor(0.6)
                        .foregroundStyle(monthConfig.weekdayTextColor)
                    
                    Spacer()
                }
                Text(entry.date.dayDisplayFormat)
                    .font(.system(size: 80, weight: .heavy))
                    .foregroundStyle(monthConfig.dayTextColor)
            }
        }
    }
}

struct MonthlyWidget: Widget {
    let kind: String = "MonthlyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MonthlyWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                MonthlyWidgetEntryView(entry: entry)
            }
        }
        .configurationDisplayName("Monthly Style Widget")
        .description("The theme of the widget changes based on the month.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    MonthlyWidget()
    
} timeline: {
    DayEntry(date: .now, emoji: MonthConfig.determineConfig(from: .now).emojiText)
    DayEntry(date: .now, emoji: MonthConfig.determineConfig(from: .now).emojiText)
}


extension Date {
    var weekdayDisplayFormat: String {
        self.formatted(.dateTime.weekday(.wide))
    }
    
    var dayDisplayFormat: String {
        self.formatted(.dateTime.day())
    }
}
