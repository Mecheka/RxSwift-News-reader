//
//  ArticlesViewController.swift
//  NewsReader
//
//  Created by Suriya on 12/6/2564 BE.
//

import UIKit
import RxSwift

class ArticlesViewController: UIViewController {
    
    var source: String = ""
    fileprivate let viewModel = ArticlesViewModel()
    fileprivate let bag = DisposeBag()
    
    @IBOutlet weak var imageArticles: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headLineTitle: UILabel!
    @IBOutlet weak var headLineSubTitle: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ArticlesTableViewCell", bundle: nil), forCellReuseIdentifier: String(describing: ArticlesTableViewCell.self))
        
        let articlesResult = viewModel.articles.asDriver(onErrorJustReturn: [])
        
        articlesResult.drive(tableView.rx.items(cellIdentifier: "ArticlesTableViewCell", cellType: ArticlesTableViewCell.self)) {(row,articles,cell) in
            cell.imageArticle?.layer.cornerRadius = (cell.imageArticle?.frame.width)!/2
            cell.imageArticle?.layer.masksToBounds = true
            if let url = articles.urlToImage {
                if let data = try? Data(contentsOf: url) {
                    cell.imageArticle.image = UIImage(data: data)
                }
            } else {
                cell.imageArticle.image = UIImage(named: "ic_news")
            }
            cell.labelTitle.text = articles.title!
        }.disposed(by: bag)
        
        tableView.rx.modelSelected(Articles.self)
            .subscribe(onNext: {(article) in
                let newsVC = self.storyboard?.instantiateViewController(identifier: "News") as! NewsViewController
                
                if let url = article.url {
                    newsVC.webUrl = url
                    self.present(newsVC, animated: true, completion: nil)
                }
            })
            .disposed(by: bag)
        
        viewModel.loading
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: {(isLoad) in
                self.loading.isHidden = !isLoad
                self.imageArticles.isHidden = isLoad
                self.tableView.isHidden = isLoad
                self.headLineTitle.isHidden = isLoad
                self.headLineSubTitle.isHidden = isLoad
            })
            .disposed(by: bag)
        
        viewModel.headLine
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: {(headLine) in
                if let url = headLine.urlToImage {
                    if let data = try? Data(contentsOf: url) {
                        self.imageArticles.image = UIImage(data: data)
                    }
                }
                
                self.headLineTitle.text = headLine.title!
                self.headLineSubTitle.text = headLine.description!
            })
            .disposed(by: bag)
        
        viewModel.getActicles(self.source)
        // Do any additional setup after loading the view.
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
