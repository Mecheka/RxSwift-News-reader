//
//  SourceViewModel.swift
//  NewsReader
//
//  Created by Suriya on 10/6/2564 BE.
//

import Foundation
import Moya
import Moya_ObjectMapper
import RxSwift

class SourceViewModel {
    
    fileprivate let bag = DisposeBag()
    fileprivate let service = MoyaProvider<NewsService>(plugins: [NetworkLoggerPlugin()])
    
    let loading: PublishSubject<Bool> = PublishSubject()
    let sourcesSubject: PublishSubject<[Source]> = PublishSubject()
    
    func getSource() {
        loading.onNext(false)
        service.rx.request(.getSource)
            .filterSuccessfulStatusCodes()
            .mapObject(SourceResponse.self)
            .subscribe(onSuccess: {(source) in
                self.loading.onNext(true)
                self.sourcesSubject.onNext(source.sources!)
            }, onError: {(error) in
                self.loading.onNext(true)
                print(error)
            })
            .disposed(by: bag)
    }
}
