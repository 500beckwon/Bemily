//
//  NetworkError.swift
//  Bemily
//
//  Created by ByungHoon Ann on 2023/01/10.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case badURL
    case inValidError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return NSLocalizedString("Decoding에 실패하였습니다.", comment: "Data Decoding Error")
        case .badURL:
            return NSLocalizedString("URL이 잘못되었습니다.", comment: "Wrong URL")
        case .inValidError:
            return NSLocalizedString("원인을 알 수 없는 에러입니다", comment: "Invalid Error")
        }
    }
}
