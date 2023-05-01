//
//  LocalFileManager.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 02/05/2023.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()

    private init() {}

    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        createFolder(folderName: folderName)
        
        //get path for image
        guard let data = image.pngData(),
              let url = getURLForImage(imageName: imageName, folderName: folderName)
        else {
            return
        }
        
        //save image
        do {
            try data.write(to: url)
        } catch let error {
            print("error saving image ImageName: \(imageName) \(error.localizedDescription)")
        }
    }

    // MARK: folder url

    private func getUrlForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }

        return url.appendingPathComponent(folderName)
    }

    // MARK: image url

    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getUrlForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }

    // MARK: Create folder

    private func createFolder(folderName: String) {
        guard let folderURL = getUrlForFolder(folderName: folderName) else {
            return
        }

        if !FileManager.default.fileExists(atPath: folderURL.path) {
            do {
                try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
            } catch let error {
                print("Error creating directory FolderName: \(folderName) \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: Get image
    
    func getImage(imageName: String, folderName: String) -> UIImage?{
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path)
        else{
            return nil
        }
        
        return UIImage(contentsOfFile: url.path)
    }
}
