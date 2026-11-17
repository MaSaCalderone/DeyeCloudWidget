import WidgetKit
import SwiftUI

@main
struct DeyeCloudWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        DeyeCloudSmallWidget()
        DeyeCloudMediumWidget()
    }
}

struct DeyeCloudSmallWidget: Widget {
    let kind: String = "com.deyecloud.widget.small"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: DeyeCloudProvider()) { entry in
            DeyeCloudWidgetSmall(entry: entry)
                .containerBackground(.fill, for: .widget)
        }
        .configurationDisplayName("Deye Cloud (Compacto)")
        .description("Visualización rápida de potencia generada y consumida")
        .supportedFamilies([.systemSmall])
    }
}

struct DeyeCloudMediumWidget: Widget {
    let kind: String = "com.deyecloud.widget.medium"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: DeyeCloudProvider()) { entry in
            DeyeCloudWidgetMedium(entry: entry)
                .containerBackground(.fill, for: .widget)
        }
        .configurationDisplayName("Deye Cloud (Normal)")
        .description("Visualización completa del sistema solar")
        .supportedFamilies([.systemMedium])
    }
}
