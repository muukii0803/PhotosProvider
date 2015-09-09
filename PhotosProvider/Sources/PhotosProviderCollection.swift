//
//  Collection.swift
//  PhotosProvider
//
//  Created by Muukii on 8/7/15.
//  Copyright © 2015 muukii. All rights reserved.
//

import Foundation

public struct PhotosProviderCollection {
    
    public private(set) var title: String
    public private(set) var group: PhotosProviderAssetsGroup
    
    public init(title: String, group: PhotosProviderAssetsGroup, buildByDay: Bool = false) {
        
        self.title = title
        self.group = group

        if buildByDay {
            self.group.requestAssetsGroupByDays { groupByDay in
                self.groupByDay = groupByDay
            }
        }
    }
    
    mutating func requestGroupByDay(completion: (groupByDay: PhotosProviderAssetsGroupByDay) -> Void) {
        
        if let groupByDay = self.groupByDay {
            completion(groupByDay: groupByDay)
            return
        }
        
        self.group.requestAssetsGroupByDays { _groupByDay in
            
            self.groupByDay = _groupByDay
            completion(groupByDay: _groupByDay)
        }
    }
    
    private var groupByDay: PhotosProviderAssetsGroupByDay?
}