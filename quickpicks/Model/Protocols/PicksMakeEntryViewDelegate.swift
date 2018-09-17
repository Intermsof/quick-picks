//
//  PicksMakeEntryViewDelegate.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 9/2/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation

protocol PicksMakeEntryViewDelegate {
    func infoButtonClicked()
    func submitResults(contestEntry : ContestEntry)
}
