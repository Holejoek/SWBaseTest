//
//  BaseCollectionView.swift
//  SWBaseTest
//
//  Created by Иван Тиминский on 06.12.2022.
//

import UIKit

open class BaseCollectionView: UICollectionView {
    
    public var isAutoDimensionHeight: Bool = false
    
    public var sizeForItemAt: ((UICollectionView, UICollectionViewLayout, IndexPath) -> CGSize)?
    public var numberOfItemsInSection: ((UICollectionView, Int) -> Int)?
    public var cellForItemAt: ((UICollectionView, IndexPath) -> UICollectionViewCell)?
    public var willDisplay: [(UICollectionView, UICollectionViewCell, IndexPath) -> ()] = []
    public var didSelectItemAt: ((BaseCollectionView, IndexPath) -> ())?
    public var insetForSection: ((UICollectionView, UICollectionViewLayout, Int)  -> UIEdgeInsets)?
    
    open override var contentSize: CGSize {
        didSet {
            guard isAutoDimensionHeight else { return }
            invalidateIntrinsicContentSize()
        }
    }
    
    open override var intrinsicContentSize: CGSize {
        guard isAutoDimensionHeight else { return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric) }
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
    public init(frame: CGRect, collectionViewLayout: UICollectionViewLayout, cellsForRegistration: [BaseCollectionCell.Type] = []) {
        super.init(frame: frame, collectionViewLayout: collectionViewLayout)
        delegate = self
        dataSource = self
        
        cellsForRegistration.forEach({ register($0) })
        reloadData()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func registerNib(_ cellType: BaseCollectionCell.Type) {
        register(UINib(nibName: cellType.className, bundle: nil), forCellWithReuseIdentifier: cellType.className)
    }

    open func register<Cell: BaseCollectionCell>(_ type: Cell.Type) {
        register(type, forCellWithReuseIdentifier: type.className)
    }

    open func register<HeaderFooter: UITableViewHeaderFooterView>(headerFooter type: HeaderFooter.Type) {
        register(type, forCellWithReuseIdentifier: type.className)
    }

    open func registerNib<HeaderFooter: UITableViewHeaderFooterView>(headerFooter type: HeaderFooter.Type) {
        register(UINib(nibName: type.className, bundle: nil), forCellWithReuseIdentifier: type.className)
    }

    open func dequeue<Cell: BaseCollectionCell>(_ cell: Cell.Type, for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withReuseIdentifier: Cell.className, for: indexPath) as! Cell
    }

    open func dequeue<Cell: BaseCollectionCell>(_ cell: Cell.Type, for row: Int, in section: Int = 0) -> Cell {
        return dequeue(cell, for: IndexPath(row: row, section: section))
    }
    
}

extension BaseCollectionView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeForItemAt?(collectionView, collectionViewLayout, indexPath) ??  CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 5)//Значение по умолчанию, параметры ширины и высоты не несут смысловой нагрузки
        
        //UICollectionViewFlowLayout.automaticSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        willDisplay.forEach({
            closure in
            closure(collectionView, cell, indexPath)
        })
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAt?(self, indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insetForSection?(collectionView, collectionViewLayout, section) ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension BaseCollectionView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Количество секций всегда должно быть == 1
        return numberOfItemsInSection?(collectionView, section) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellForItemAt?(collectionView, indexPath) ?? BaseCollectionCell()
    }
}

