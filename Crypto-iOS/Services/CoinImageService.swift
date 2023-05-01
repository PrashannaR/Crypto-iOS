//
//  CoinImageService.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 01/05/2023.
//

import Combine
import Foundation
import SwiftUI

class CoinImageService {
    @Published var image: UIImage? = nil

    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel

    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String

    init(coin: CoinModel) {
        self.coin = coin
        imageName = coin.id
        getCoinImage()
    }

    
    private func getCoinImage() {
        //checks if the image is already cached
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("Image fetched from file manager")
        } else {
            //else fetches form the url
            downloadCoinImage()
            print("Downloading Image")
        }
    }

    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }

        imageSubscription =
            NetworkingManager.download(url: url)
                .tryMap({ data -> UIImage? in
                    UIImage(data: data)
                })
                .sink(receiveCompletion: NetworkingManager.handleCompletion,
                      receiveValue: { [weak self] returnedImage in

                          guard let self = self,
                                let downloadedImage = returnedImage
                          else { return }

                          self.image = downloadedImage
                          self.imageSubscription?.cancel()
                    self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
                      })
    }
}
