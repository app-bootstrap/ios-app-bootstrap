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
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry

    var body: some View {
        switch family {
        case .systemSmall:
            Text("Not implemented")
        case .accessoryRectangular:
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    Image("Icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 14)
                        .padding(.top, 2)
                    Text("文字文字")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.leading, 8)
                }.padding(.horizontal, 6)
                Spacer()
                HStack(spacing: 0) {
                    Text("01")
                        .font(.system(size: 20, weight: .bold, design: .default))
                    Text("文字二")
                        .font(.system(size: 12, weight: .regular))
                        .frame(minWidth: 38)
                        .padding(.leading, 3)
                        .padding(.top, 2)
                    Spacer()
                    Text("11")
                        .font(.system(size: 20, weight: .bold, design: .default))
                    Text("文字三")
                        .font(.system(size: 12, weight: .regular))
                        .frame(minWidth: 38)
                        .padding(.leading, 3)
                        .padding(.top, 2)
                }.padding(.horizontal, 6)
            }
            .padding(.vertical, 8)
            .edgesIgnoringSafeArea(.all)
            .background(Color.clear)
            .cornerRadius(16)

        default:
            Text("Not implemented")
        }
    }
    
}

@main
struct Widget1: Widget {
    let kind: String = "Widget1"

    private var supportedFamilies: [WidgetFamily] {
        var supportedFamilies: [WidgetFamily] = [.systemSmall, .systemMedium]
        if #available(iOSApplicationExtension 16.0, *) {
            supportedFamilies.append(.accessoryRectangular)
        }
        return supportedFamilies
    }

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) {
            entry in Widget1EntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an sample1 widget.")
        .supportedFamilies(supportedFamilies)
    }
}

struct Widget1_Previews: PreviewProvider {
    static var previews: some View {
        Widget1EntryView(entry: Simple1Entry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
