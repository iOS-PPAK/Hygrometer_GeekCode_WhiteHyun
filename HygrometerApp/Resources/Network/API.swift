//
//  API.swift
//  HygrometerApp
//
//  Created by hyeonseok on 2022/07/11.
//

import Foundation

public struct API {
    
    private init() {}
    
    /// Add String
    /// - Parameter stringArray: 여러개의 string 붙이기
    /// - Returns: 배열로 들어온 string 붙여서 하나로 리턴
    static public func makeString(with stringArray: [String]) -> String {
        
        var fullStr: String = ""
        for str in stringArray {
            fullStr += str
        }
//        print("\(fullStr)")
        return fullStr
    }
    
    
    /// API로 부터 Data를 디코딩하는 함수
    /// - Parameters:
    ///   - url: 연결하려는 URL
    ///   - successHandler: 성공시 사용하는 Completion, Data를 가지고 있음
    ///   - errorHandler: 실패시 사용하는 Completion , Error 메세지를 가지고 있음
    static public func getDataReturnData(url: String, successHandler: @escaping (_ resultData: Data?) -> Void, errorHandler: @escaping (_ error: Error) -> Void) {
        
        guard let reqUrl = URL(string: url) else {
            // TODO: URL 등록 오류를 처리하거나 무시해야함
            return
        }
        
        URLSession.shared.dataTask(with: reqUrl) { data, response, error in
            guard let rstData = data else {
                errorHandler(error!)
                return
            }
            successHandler(rstData)
        }
        .resume()
    }
}

enum ApiType {
    case gps
    case weather
    
    init() {
        self = .gps
    }
    
    var host: String {
        switch self {
        case .gps: return "https://api.vworld.kr/req/search?"
        case .weather: return "https://api.openweathermap.org/data/2.5/weather?"
            
//"https://api.vworld.kr/req/search?key=1DAD8342-3C3A-3763-AEC5-8D0EED23FB5A&query=수원&request=search&type=district&category=L4"

//https://api.vworld.kr/req/search??key=1DAD8342-3C3A-3763-AEC5-8D0EED23FB5A&query=수원&request=search&type=district&category=L4

            
//https://api.openweathermap.org/data/2.5/weather??key=1DAD8342-3C3A-3763-AEC5-8D0EED23FB5A&query=수원&request=search&type=district&category=L4

            
//            "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=\(serviceKey)"
        }
    }
}


