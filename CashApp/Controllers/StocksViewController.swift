//
//  SearchVC.swift
//  CashApp
//
//  Created by Ahmet Yusuf Yuksek on 10/27/21.
//

import UIKit

protocol StockViewControlling: AnyObject {
    func updateData(on stocks: [Stock])
    func presentAlert(title: String, message: String)
}

class StocksViewController: UIViewController, StockViewControlling {

    init(interactor: StocksInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    var interactor: StocksInteractor
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Properties
    enum Section { case main }
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Stock>!
// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        interactor.fetchStocks()
        configureCollectionView()
        configureDataSource()
        configureSearchController()
    }
// MARK: - UIConfigurations
    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .cashGreen
        navigationItem.hidesSearchBarWhenScrolling = false
        title = "Stocks"
    }
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIFlowLayoutHelper.createTwoColumnLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.register(StockCell.self, forCellWithReuseIdentifier: StockCell.reuseID)
    }
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a stock"
        navigationItem.searchController = searchController
    }
// MARK: - Data Source
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Stock>(
            collectionView: collectionView,
            cellProvider: {(collectionView, indexPath, stock) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StockCell.reuseID,
                                                          for: indexPath) as? StockCell
                else {
                    fatalError("DequeueReusableCell failed while casting")
                }
            cell.set(stock: stock)
            return cell
        })
    }

    func updateData(on stocks: [Stock]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Stock>()
        snapshot.appendSections([.main])
        snapshot.appendItems(stocks)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func presentAlert(title: String, message: String) {
        self.presentCustomAlert(title: title, message: message, buttonTitle: "Ok")
    }
    func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: - CollectionView Delegate Methods
extension StocksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("DEBUG:\(indexPath.row)")
        let viewController = interactor.cellTapped(on: indexPath)
        let nav = UINavigationController(rootViewController: viewController)
        nav.modalPresentationStyle = .popover
        present(nav, animated: true)
    }
}

// MARK: - SearchResults Delegate Methods

extension StocksViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        interactor.searchResults(with: searchController.searchBar.text)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        interactor.cancelButtonTapped()
    }
}
