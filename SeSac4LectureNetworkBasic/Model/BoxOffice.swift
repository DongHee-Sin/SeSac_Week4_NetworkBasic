//
//  BoxOfficeModel.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/08/02.
//

import Foundation
import RealmSwift


class BoxOffice: Object {
    @Persisted var targetDate: String
    @Persisted var movieList: List<Movie>
    
    convenience init(targetDate: String) {
        self.init()
        self.targetDate = targetDate
    }
}


class Movie: Object {
    @Persisted var movieTitle: String
    @Persisted var releaseDate: String
    @Persisted var totalCount: Int
    @Persisted var rank: String
    
    
    @Persisted(primaryKey: true) var object: ObjectId
    
    
    convenience init(movieTitle: String, releaseDate: String, totalCount: Int, rank: String) {
        self.init()
        self.movieTitle = movieTitle
        self.releaseDate = releaseDate
        self.totalCount = totalCount
        self.rank = rank
    }
}



