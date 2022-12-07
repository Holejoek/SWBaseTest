//
//  CollectionWithPagination.swift
//  iOSDepartment
//
//  Created by Александр Строев on 06.09.2021.
//  Copyright © 2021 Stroev. All rights reserved.
//

import UIKit

public protocol CollectionWithPaginationDelegate {
    func reloadData()
    func setPaginationManagerDelegate(delegate: PaginationManagerDelegate)
    func setWillDisplayLogic(_ willDisplayLogic: @escaping (UICollectionView, UICollectionViewCell, IndexPath) -> ())
    func endRefreshing()
    func setData(_ newData: [Decodable])
    func appendData(_ newData: [Decodable])
    func getData() -> [Decodable]
}

open class CollectionWithPagination<PaginationData: Decodable>: BaseCollectionView {
    
    private var paginationManagerDelegate: PaginationManagerDelegate!
    
    var data: [PaginationData] = [] {
        didSet {
            reloadData()
        }
    }
    
    var cellForItemAtWithData: ((BaseCollectionView, IndexPath, PaginationData) -> UICollectionViewCell)?
    
    var sizeForItemAtWithData: ((BaseCollectionView, UICollectionViewLayout, IndexPath, PaginationData) -> CGSize)?
    
    func setup() {
        numberOfItemsInSection = {
            [weak self] _, _ in
            guard let self = self else { return 0 }
            return self.data.count
        }

        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl = refresher
        addSubview(refreshControl!)
    }
    
    @objc func refresh() {
        paginationManagerDelegate.refresh()
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellForItemAtWithData?(collectionView as! BaseCollectionView, indexPath, data[indexPath.row]) ?? UICollectionViewCell()
    }
    
    public override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeForItemAtWithData?(collectionView as! BaseCollectionView, collectionViewLayout, indexPath, data[indexPath.row]) ?? CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 5)//Значение по умолчанию, параметры ширины и высоты не несут смысловой нагрузки
    }
    
}

extension CollectionWithPagination: CollectionWithPaginationDelegate {
    
    public func setPaginationManagerDelegate(delegate: PaginationManagerDelegate) {
        paginationManagerDelegate = delegate
    }
    
    public func setWillDisplayLogic(_ willDisplayLogic: @escaping (UICollectionView, UICollectionViewCell, IndexPath) -> ()) {
        willDisplay.append(willDisplayLogic)
    }
    
    public func endRefreshing() {
        refreshControl?.endRefreshing()
    }
    
    public func setData(_ newData: [Decodable]) {
        self.data = newData as? [PaginationData] ?? []
    }
    
    public func appendData(_ newData: [Decodable]) {
        self.data.append(contentsOf: newData as? [PaginationData] ?? [])
    }
    
    public func getData() -> [Decodable] {
        return data
    }
}
