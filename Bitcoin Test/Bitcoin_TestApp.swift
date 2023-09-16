//
//  Bitcoin_TestApp.swift
//  Bitcoin Test
//
//  Created by Javier on 16/09/23.
//

import SwiftUI

@main
struct Bitcoin_TestApp: App {
    var body: some Scene {
        WindowGroup {
            BitcoinPriceView(viewModel: BitcoinPriceViewModel())
        }
    }
}
