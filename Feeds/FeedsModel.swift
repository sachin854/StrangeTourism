import SwiftUI
import Foundation

// Define the model for the API response
struct Post: Codable, Identifiable {
    let id: Int
    let title: String
    let body: String
}



class ViewModelFeeds: ObservableObject {
    @Published var feeds: [FeedsViewModelElement] = []

    func feedPosts(token: String) {
        
        print("tookkkenn","Bearer "+token)
        guard let url = URL(string: "http://34.30.1.124:8080/api/posts/users/socialwall") else {
            return
        }

        var request = URLRequest(url: url)
       
             request.addValue("Bearer "+token, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data else {
                return
            }
            print("possssst",data.self)


            do {
                
                let decodedResponse = try JSONDecoder().decode(FeedsViewModelElement.self, from: data)
                DispatchQueue.main.async {
                    self.feeds = [decodedResponse]
                }
                print("responseee",decodedResponse)
            } catch let error {
                if let jsonString = String(data: data, encoding: .utf8) {
                     print("JSON String: \(jsonString)")
                 }

                 if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                     print("Error Message: \(errorResponse.message)")
                 } else {
                     print("Error decoding JSON: \(error)")
                 }
            }

        }.resume()
    }
}


struct ErrorResponse: Codable {
    let message: String
}


// MARK: - FeedsViewModelElement
struct FeedsViewModelElement: Codable {
    let _id: String?
    let user: User?
    let postText: String?
    let location, postDate: String
    let taggedUser: [TaggedUser]
    let shareCount, likeCount, commentsCount: Int
    let media: [Media]
    let v: Int
    let isLiked, isCollected: Bool
    let recentComment: RecentComment?

    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case user, postText, location, postDate, taggedUser, shareCount, likeCount, commentsCount, media
        case v = "__v"
        case isLiked, isCollected, recentComment
    }
}


// MARK: - Media
struct Media: Codable {
    let mediaType: MediaType
    let mediaFile, id: String

    enum CodingKeys: String, CodingKey {
        case mediaType, mediaFile
        case id = "_id"
    }
}

enum MediaType: String, Codable {
    case image = "image"
    case shortVideo = "short-video"
}

// MARK: - RecentComment
struct RecentComment: Codable {
    let comment: String
    let user: User
}

// MARK: - User
struct User: Codable {
    let userName: UserName
    let profilePic: String
    let gender: Gender
    let id: String?

    enum CodingKeys: String, CodingKey {
        case userName, profilePic, gender
        case id = "_id"
    }
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
}

enum UserName: String, Codable {
    case nischal = "nischal"
    case shwetha = "shwetha"
    case testtyy = "testtyy"
}

// MARK: - TaggedUser
struct TaggedUser: Codable {
    let id, userName: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userName
    }
}

typealias FeedsViewModel = [FeedsViewModelElement]







//class ViewModel: ObservableObject {
//    @Published var posts: [Post] = []
//
//    func fetchPosts(withUID uid: String) {
//        guard let url = URL(string: "http://34.30.1.124:8080/api/posts/users/socialwall") else {
//            return
//        }
//
//        var request = URLRequest(url: url)
//             request.addValue(uid, forHTTPHeaderField: uid)
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let dataRe = data else {
//                return
//            }
//            print("helll",dataRe);
//            do {
//
//                let decodedResponse = try JSONDecoder().decode(Post.self, from: dataRe)
//                DispatchQueue.main.async {
//                    self.posts = [decodedResponse]
//                }
//                print("kkkk")
//            } catch {
//                print("Error decoding JSON: \(error)")
//            }
//        }.resume()
//    }
//}
