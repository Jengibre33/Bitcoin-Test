//
//  BitcoinPriceViewModel.swift
//  Bitcoin Test
//
//  Created by Javier on 16/09/23.
//

import Combine
import Foundation

class BitcoinPriceViewModel: ObservableObject {
    @Published public private(set) var lastUpdate: String = ""
    @Published public private(set) var priceDetails: [PriceDetails] = Currency.allCases.map {
        PriceDetails(currency: $0)
    }
    
    private var subscription: AnyCancellable?
    
    
    public func onAppear() {
        // Obtener los datos del API
        subscription = CoindeskAPIService.shared.fetchBitcoinPrice()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("o pai ta on!")
            }
        }, receiveValue: { [weak self] value in
            guard let self = self else { return }
            self.lastUpdate = value.time.updated
            self.priceDetails = [
                PriceDetails(currency: .usd, rate: value.bpi.USD.rate),
                PriceDetails(currency: .gbp, rate: value.bpi.GBP.rate),
                PriceDetails(currency: .eur, rate: value.bpi.EUR.rate),
            ]
        })
    }
}
