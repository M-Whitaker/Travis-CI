import UIKit
import Foundation

public extension JSONDecoder {

    private static let nestedModelKeyPathCodingUserInfoKey = CodingUserInfoKey(rawValue: "nested_model_keypath")!

    private struct Key: CodingKey {
        let stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }

        let intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }

    private struct ModelResponse<TargetModel: Decodable>: Decodable {
        let model: TargetModel

        init(from decoder: Decoder) throws {
            // Split nested paths with '.'
            var keyPaths = (decoder.userInfo[JSONDecoder.nestedModelKeyPathCodingUserInfoKey]! as! String).split(separator: ".")

            // Get last key to extract in the end
            let lastKey = String(keyPaths.popLast()!)

            // Loop getting container until reach final one
            var targetContainer = try decoder.container(keyedBy: Key.self)
            for k in keyPaths {
                let key = Key(stringValue: String(k))!
                targetContainer = try targetContainer.nestedContainer(keyedBy: Key.self, forKey: key)
            }
            model = try targetContainer.decode(TargetModel.self, forKey: Key(stringValue: lastKey)!)
        }
    }

    /// Decodes a model T from json data with the given keypath.
    func decode<T: Decodable>(_ type: T.Type, from data: Data, keyPath: String) throws -> T {
        self.userInfo[JSONDecoder.nestedModelKeyPathCodingUserInfoKey] = keyPath
        return try self.decode(ModelResponse<T>.self, from: data).model
    }
}

struct Build: Decodable {
    var id: Int
    var number: String
    var state: String
//    var duration: Int
//    var startedAt: String
//    var finishedAt: String
}

struct Branch: Decodable {
//    var id = UUID()
    var name: String
    var lastBuild: Build?
//    var updatedAt: String
    
}

struct Repository: Identifiable, Decodable {
    var id: Int
    var name: String
    var slug: String
    var description: String?
    var starred: Bool
    var defaultBranch: Branch?
    var active: Bool
//    var buildNo: Int
//    var duration: Int
//    var Finished: Int
}

let url = URL(string: "https://api.travis-ci.com/repos?include=branch.last_build")!
let token = "token"
var request = URLRequest(url: url)
request.httpMethod = "GET"
request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
request.setValue("3", forHTTPHeaderField: "Travis-API-Version")
URLSession.shared.dataTask(with: request) { (data, response, error) in
    guard error == nil else { print(error!); return }
    guard let data = data else { print("No data"); return }
//    print(response)
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    let repos = try! decoder.decode([Repository].self, from: data, keyPath: "repositories")
    dump(repos)
//    DispatchQueue.main.async {
//        self.repos = repos
//    }
}.resume()
