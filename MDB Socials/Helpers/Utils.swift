//
//  Utils.swift
//  MDB Socials
//
//  Created by Natasha Wong on 3/2/18.
//  Copyright © 2018 Natasha Wong. All rights reserved.
//

import UIKit

class Utils {
    
    static func sortPosts(posts: [Post]) -> [Post] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMMd h:mm a"
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        
        var sorted = posts.sorted(by: { (post1, post2) in
            let dateStr1 = post1.date?.replacingOccurrences(of: "\n", with: " ")
            let dateStr2 = post2.date?.replacingOccurrences(of: "\n", with: " ")
            let date1 = dateFormatter.date(from: dateStr1!)
            let date2 = dateFormatter.date(from: dateStr2!)
            return date1! < date2!
        })
        
        for post in sorted {
            let date = dateFormatter.date(from: (post.date?.replacingOccurrences(of: "\n", with: " "))!)!
            let now = Date()
            
            let calendar = Calendar.current
            var dateComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: date)
            dateComponents.year = 2018
            let fdate = calendar.date(from: dateComponents)!
            
            if fdate.timeIntervalSince1970 < now.timeIntervalSince1970 {
                sorted.remove(at: sorted.index(where: { i in
                    return post.id == i.id
                })!)
            }
        }
        return sorted
    }
}
