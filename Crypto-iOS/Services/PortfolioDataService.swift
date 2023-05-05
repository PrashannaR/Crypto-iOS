//
//  PortfolioDataService.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 06/05/2023.
//

import CoreData
import Foundation

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities : [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores {[weak self] _, error in
            if let error = error {
                print("Error loading CoreData : \(error)")
            }
            self?.getPortfolio()
        }
    }
    
    //MARK: Public
    
    func updatePortfolio(coin: CoinModel, amount: Double){
        
        //checks if item is already present
        if let entity = savedEntities.first(where: { savedEntity in
            return savedEntity.coinID == coin.id
        }){
            if amount > 0{
                update(entity: entity, amount: amount)
            }else{
                remove(entity: entity)
            }
        }else{
            add(coin: coin, amount: amount )
        }
    }
    
    //MARK: Private
    private func getPortfolio(){
        let req = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do{
            savedEntities = try container.viewContext.fetch(req)
        }catch let error{
            print("Error fetching portfolio entities: \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double){
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func save(){
        do{
            try container.viewContext.save()
            
        }catch let error{
            print("Error saving to core data: \(error)")
        }
    }
    
    private func applyChanges(){
        save()
        getPortfolio()
    }
    
    private func update(entity: PortfolioEntity, amount: Double){
        entity.amount = amount
        applyChanges()
    }
    
    private func remove(entity: PortfolioEntity){
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    
    
}
