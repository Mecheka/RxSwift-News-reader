//
//  SourceViewController.swift
//  NewsReader
//
//  Created by Suriya on 10/6/2564 BE.
//

import UIKit
import RxCocoa
import RxSwift

class SourceViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    private let viewModel = SourceViewModel()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    
        bindViewModel()
        // Do any additional setup after loading the view.
    }
    
    private func bindViewModel() {
        
        tableView.register(UINib(nibName: "SourceTableViewCell", bundle: nil), forCellReuseIdentifier: String(describing: SourceTableViewCell.self))
        
        let resultLoading = viewModel.loading.asDriver(onErrorJustReturn: false)
        
        resultLoading
            .drive(loading.rx.isHidden)
            .disposed(by: bag)
        
        resultLoading
            .drive(onNext: {(value) in
                self.tableView.isHidden = !value
            })
            .disposed(by: bag)
        
        tableView.rx.modelSelected(Source.self)
            .subscribe(onNext: {(source) in
                let articles = self.storyboard?.instantiateViewController(identifier: "Articles") as! ArticlesViewController
                articles.source = source.id!
                self.present(articles, animated: true, completion: nil)
            })
            .disposed(by: bag)
        
        viewModel.sourcesSubject.asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: "SourceTableViewCell", cellType: SourceTableViewCell.self)) { (row, source, cell) in
                cell.sourceName.text = source.name
            }.disposed(by: bag)
        
        viewModel.getSource()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
