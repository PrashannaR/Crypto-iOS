//
//  NetworkingManager.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 29/04/2023.
//

import Foundation

import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError{
        case badURLResponse
        case unknown
        
        var errorDescription: String?{
            switch self{
            case .badURLResponse:
                return "[🔥] Bad response from the URL"
            case .unknown:
                return "[⚠️] Unknown error occurred"
            }
        }
    }
    
    
    static func download(url: URL) -> AnyPublisher<Data, any Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher() // converts the big data type
    }

    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse
            
        }

        return output.data
    }

    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:

            break
        case let .failure(error):
            print("Coin Data Service")
            print(error.localizedDescription)
        }
    }
}
