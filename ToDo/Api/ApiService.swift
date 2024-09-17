//
//  ApiService.swift
//  ToDo
//
//  Created by Денис Королевский on 12/9/24.
//

import Foundation
import Alamofire

enum MyError: Error {
    case invalidURL
    
    var descriptionOfError: String {
        switch self {
        case .invalidURL:
            return "Не удалось создать ссылку"
        }
    }
}

class ApiService {
    
    static let shared = ApiService()
    
    private let baseURL = "https://dummyjson.com/todos"
    
    func loadTasks(completion: @escaping (Result<ToDosResponseModel, Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(MyError.invalidURL))
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            AF.request(url)
                .validate()
                .responseDecodable(of: ToDosResponseModel.self) { response in
                    DispatchQueue.main.async {
                        switch response.result {
                        case .success(let responseModel):
                            completion(.success(responseModel))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
        }
    }
}
