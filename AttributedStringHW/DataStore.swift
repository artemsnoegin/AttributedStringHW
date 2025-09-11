//
//  DataStore.swift
//  AttributedStringHW
//
//  Created by Артём Сноегин on 10.09.2025.
//

import UIKit

class DataStore {
    
    var products: [Product] = [
        Product(name: "Pro",
                description: "The most powerful iPhone ever. Breakthrough battery life. Our best display ever with Ceramic Shield 2 on the front, the powerful A19 Pro chip, all 48MP rear cameras, and the new Center Stage front camera.\nPre-order starting 5:00 a.m. PT on 9.12\nAvailable starting 9.19",
                imageString: "iphone_17_pro_logo_medium_2x",
                urlString: "https://www.apple.com/shop/buy-iphone/iphone-17-pro",
                keyWords: ["Ceramic Shield 2",
                           "A19 Pro chip",
                           "48MP rear cameras",
                           "Center Stage front camera"],
                keyWordColor: UIColor.systemOrange,
                preferredUserInterfaceStyle: .dark
               ),
        
        Product(name: "Air",
                description: "The thinnest iPhone ever with the power of pro inside. More durable than any previous iPhone. Our best display ever with Ceramic Shield 2 on the front. The powerful A19 Pro chip. An advanced 48MP Fusion camera system. And the new Center Stage front camera.\nPre-order starting 5:00 a.m. PT on 9.12\nAvailable starting 9.19",
                imageString: "iphone_air_logo_medium_2x",
                urlString: "https://www.apple.com/us/shop/goto/buy_iphone/iphone_air",
                keyWords: ["Ceramic Shield 2",
                           "A19 Pro chip",
                           "48MP rear cameras",
                           "Center Stage front camera"],
                keyWordColor: UIColor.systemCyan,
                preferredUserInterfaceStyle: .light
               ),
        
        Product(name: "Watch",
                description: "All-new essentials for a great value. Now you can track your sleep score. Get richer health insights in the Vitals app. Charge up to 2x faster with new fast charging. And see your info at a glance with the Always‑On display.\nAvailable starting 9.19\nPre-order",
                imageString: "apple_watch_se_3_logo_medium_2x",
                urlString: "https://www.apple.com/us/shop/goto/buy_watch/apple_watch_se",
                keyWords: ["track your sleep score",
                           "Vitals app",
                           "new fast charging",
                           "Always‑On display"],
                keyWordColor: UIColor.systemGreen,
                preferredUserInterfaceStyle: .light
               ),
    ]
    
}

