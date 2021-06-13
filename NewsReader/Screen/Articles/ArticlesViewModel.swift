//
//  ArticlesViewModel.swift
//  NewsReader
//
//  Created by Suriya on 12/6/2564 BE.
//

import Foundation
import RxSwift
import RxCocoa
import Moya_ObjectMapper
import Moya

class ArticlesViewModel {
    
    fileprivate let bag = DisposeBag()
    fileprivate let service = MoyaProvider<NewsService>(plugins: [NetworkLoggerPlugin()])
    let loading: PublishSubject<Bool> = PublishSubject()
    let headLine: PublishSubject<Articles> = PublishSubject()
    let articles: PublishSubject<[Articles]> = PublishSubject()
    
    func getActicles(_ sourceName: String) {
        loading.onNext(true)
        service.rx.request(.getArticles(sourceName))
            .filterSuccessfulStatusCodes()
            .mapObject(ArticlesResponse.self)
            .subscribe(onSuccess: {(response) in
                self.loading.onNext(false)
                self.headLine.onNext((response.articles?.first)!)
                self.articles.onNext(response.articles!)
            }, onError: {(error) in
                self.loading.onNext(false)
                print(error)
            })
            .disposed(by: bag)
    }
}
