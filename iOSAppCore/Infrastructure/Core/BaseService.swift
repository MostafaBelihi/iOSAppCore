//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import Foundation
import Alamofire

class BaseService {
	init(jsonDecoder: JSONDecoder? = nil) {
		if let jsonDecoder =  jsonDecoder {
			self.jsonDecoder = jsonDecoder;
		}
	}
	
	// MARK: - Service Specs
	// JSONDecoder: Add special format handling when decoding fetched data
	private var jsonDecoder: JSONDecoder = {
		let jsonDecoder = JSONDecoder();
		
		// Property casing
//		jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase;
		
		// Date format
//		let dateFormatter = DateFormatter();
//		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ";
//		jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter);
		
		return jsonDecoder
	}()
	
	// MARK: - Service Requests
	// API calls
	func request<TResponse: Decodable, TError: Decodable>(_ request: URLRequestConvertible,
														  completion: @escaping (Result<TResponse, APIServiceError<TError>>) -> Void) {
		
		// Debug Prints
//		Common.debugLog(isInit: true, request.asURLRequest().url!.absoluteString);
		
		// Making request
		AF.request(request).responseData() { (dataResponse) in
			self.completionHandler(afResponse: dataResponse, completion: completion);
		}
	}
	
	// MARK: - Response Handlers
	// Central completion handler
	private func completionHandler<TResponse: Decodable, TError: Decodable>(afResponse: DataResponse<Data, AFError>,
																			completion: @escaping (Result<TResponse, APIServiceError<TError>>) -> Void) {
		// Debug Prints
		Common.debugLog(title: "Service Response", afResponse);
		
		// Check StatusCode
		guard let statusCode = (afResponse.response)?.statusCode else {
			completion(.failure(APIServiceError(as: .invalidResponse)));
			return;
		}
		
		// Handle Response
		switch afResponse.result {
			// Success
			case .success(let data):
				Common.debugLog("Success");
				
				switch statusCode {
					case 200..<299:
						// Decoding
						do {
							let values = try self.jsonDecoder.decode(TResponse.self, from: data);
							completion(.success(values));
						}
						catch let ex {
							Common.debugLog(title: "Exception", ex);
							completion(.failure(APIServiceError(as: .decodingError)));
						}
					
					case 401:
						Common.debugLog(APIBasicError.unauthorized);
						completion(.failure(APIServiceError(as: .unauthorized)));
					
					default:
						// Decoding
						do {
							let values = try self.jsonDecoder.decode(TError.self, from: data);
							completion(.failure(APIServiceError(as: .apiError, error: values)));
						}
						catch let ex {
							Common.debugLog(title: "Exception", ex);
							completion(.failure(APIServiceError(as: .decodingError)));
						}
			}
			
			// Failure
			case .failure(let error):
				// Debug Prints
				Common.debugLog("Failure");
				Common.debugLog(title: "Error", error);
				Common.debugLog(title: "Error", error.localizedDescription);
				
				switch statusCode {
					case 401:
						Common.debugLog(APIBasicError.unauthorized);
						completion(.failure(APIServiceError(as: .unauthorized)));
					
					default:
						completion(.failure(APIServiceError(as: .unknownError)));
				}
		}
	}
	
	// Handle Status Code
	//	private func handleStatusCode(of statusCode: Int, )
	
	// MARK: - Static Methods
	static func composeURLRequest(baseURL: URL,
								  path: String,
								  queryItems: [URLQueryItem]? = nil,
								  method: HTTPMethod,
								  headers: HTTPHeaders) throws -> URLRequest {
		
		var url = baseURL.appendingPathComponent(path);
		
		if let queryItems = queryItems {
			guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
				throw APIBasicError.invalidEndpoint;
			}

			urlComponents.queryItems = queryItems;
			
			if let newUrl = urlComponents.url {
				url = newUrl;
			}
		}

		// Request
		var request = URLRequest(url: url);
		request.method = method;
		request.headers = headers;
		
		return request;
	}
	
}

// MARK: - API Errors
class APIServiceError<TError: Decodable> : Error {
	init(as basicError: APIBasicError, error: TError? = nil) {
		self.basicError = basicError;
		
		if let error = error {
			self.error = error;
		}
	}
	
	var basicError: APIBasicError;
	var error: TError?;
}

enum APIBasicError : Error {
	case unknownError
	case apiError
	case unauthorized
	case decodingError
	case invalidEndpoint
	case invalidResponse
	case noData
	
	var message: String {
		switch self {
			case .unauthorized:			return NSLocalizedString("unauthorized", comment: "");
			default:					return NSLocalizedString("unknownError", comment: "");
		}
	}
}

/// General error model
struct ServiceError : Decodable {
	var code: String
	var propertyName: String
	var message: String
}

