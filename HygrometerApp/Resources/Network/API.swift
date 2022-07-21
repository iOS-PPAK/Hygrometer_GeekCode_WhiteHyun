//
//  API.swift
//  HygrometerApp
//
//  Created by hyeonseok on 2022/07/11.
//

import Foundation

import Alamofire

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
        return fullStr
    }
    
    /// API로 부터 Data를 디코딩하는 함수
    /// - Parameters:
    ///   - url: 연결하려는 URL
    ///   - successHandler: 성공시 사용하는 Completion, Data를 가지고 있음
    ///   - errorHandler: 실패시 사용하는 Completion , Error 메세지를 가지고 있음
    @available(*, deprecated, message: "Weather에 대한 함수, 도시 정보에 대한 함수로 분리되었습니다. 이 함수를 사용하지 말아주세요")
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
    
    /// 도시 정보를 가져올 때 사용합니다.
    /// - Parameters:
    ///   - model: URL 요청에 사용할 URL 변환 가능 값
    ///   - completion: 요청이 완료되면 실행되는 클로저
    static func cityInformation(with model: GpsRequest, completion: @escaping (Result<GpsResponse, AFError>) -> Void) {
        AF
            .request(ApiType.gps.host, method: .get, parameters: model)
            .responseDecodable(of: GpsResponse.self) {
                completion($0.result)
            }
            .resume()
    }
    
    /// 날씨에 대한 정보를 가져올 때 사용합니다.
    /// - Parameters:
    ///   - model: URL 요청에 사용할 URL 변환 가능 값
    ///   - completion: 요청이 완료되면 실행되는 클로저
    static func weatherInformation(with model: WeatherRequest, completion: @escaping (Result<WeatherResponse, AFError>) -> Void) {
        AF
            .request(ApiType.weather.host, method: .get, parameters: model)
            .responseDecodable(of: WeatherResponse.self) {
                completion($0.result)
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
        }
    }
}
