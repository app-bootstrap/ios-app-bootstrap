//
//  Widget1.swift
//  Widget1
//
//  Created by xdf on 2022/9/14.
//  Copyright © 2022 open source. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> Simple1Entry {
        Simple1Entry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Simple1Entry) -> ()) {
        let entry = Simple1Entry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [Simple1Entry] = []
        let currentDate = Date()
        let entryDate = Calendar.current.date(byAdding: .hour, value: 0, to: currentDate)!
        let entry = Simple1Entry(date: entryDate, configuration: configuration)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct Simple1Entry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct Widget1EntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
        Text("string demo")
    }
}

@main
struct Widget1: Widget {
    let kind: String = "Widget2"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) {
            entry in Widget1EntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an sample1 widget.")
    }
}

struct Widget1_Previews: PreviewProvider {
    static var previews: some View {
        Widget1EntryView(entry: Simple1Entry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
