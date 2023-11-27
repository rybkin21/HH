
import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum RequestType {
    case vacancyList
    case detailedVacancy
}

struct Endpoint {
    static let vacancies = "vacancies"
    static let keyword = "suggests/vacancy_search_keyword"
}

// MARK: - NetworkServiceProtocol

protocol NetworkServiceProtocol: AnyObject {

    func getVacancies<T: Decodable>(path: String,
                               page: Int?,
                               method: HttpMethod,
                               requestType: RequestType,
                               completion: @escaping(Result<T?, Error>) -> Void)

    func requestDataTask<T: Decodable>(
        urlRequest: URLRequest,
        completion: @escaping(Result<T?, Error>) -> Void)
}

// MARK: - NetworkService

class NetworkService: NetworkServiceProtocol {

    // MARK: - Private Properties

    private lazy var urlSession: URLSession = {
        let session = URLSession(configuration: .default)
        return session
    }()

    private var dataTask: URLSessionDataTask? = nil
    let mainStringUrl = NetworkConfiguration.mainUrl + Endpoint.vacancies

    // MARK: - Public Methods

    func getVacancies<T: Decodable>(path: String,
                                    page: Int?,
                                    method: HttpMethod = .get,
                                    requestType: RequestType,
                                    completion: @escaping (Result<T?, Error>) -> Void) {

        guard var urlElements = URLComponents(string: mainStringUrl) else {
            completion(.failure(CustomError(message: "wrong url")))
            return
        }

        var queryItems: [URLQueryItem] = urlElements.queryItems ?? []
        let vacancyQueryItems: [URLQueryItem] = [
            URLQueryItem(name: "text", value: path),
            URLQueryItem(name: "page", value: String(page ?? 0)),
            URLQueryItem(name: "per_page", value: "20")
        ]
        vacancyQueryItems.forEach { queryItem in
            queryItems.append(queryItem)
        }
        urlElements.queryItems = queryItems
        var urlRequest = URLRequest(url: (urlElements.url)!)
        urlRequest.httpMethod = method.rawValue
        requestDataTask(urlRequest: urlRequest, completion: completion)
    }

    func requestDataTask<T: Decodable>(urlRequest: URLRequest,
                                       completion: @escaping(Result<T?, Error>) -> Void) {
        dataTask = urlSession.dataTask(with: urlRequest, completionHandler: { data, response, error in
            if let data = data {
                do {
                    let content = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(content))
                } catch {
                    completion(.failure(CustomError(message: "Failed to decode data: \(error)")))
                }
            } else {
                completion(.failure(CustomError(message: "No Data!")))
            }
        })
        dataTask?.resume()
    }
}
