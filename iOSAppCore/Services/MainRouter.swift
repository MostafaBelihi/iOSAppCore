//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import Foundation
import Alamofire

enum MainRouter: URLRequestConvertible {
	case get;
	
	var baseURL: URL {
		return URL(string: Constants.baseURL)!;
	}
	
	var method: HTTPMethod {
		switch self {
			default: return .get;
		}
	}
	
	var path: String {
		switch self {
			case .get: return "get";
		}
	}
	
	var headers: HTTPHeaders {
		switch self {
			default: return ["Accept": "application/json"];
		}
	}
	
	var queryItems: [URLQueryItem] {
		var items: [URLQueryItem] = [];
		
		// Default QueryStrings
		items.append(contentsOf: Constants.defaultQueryItems);
		
		// Additional QueryStrings
		switch self {
			// Append to items with more cases here
			
			default: return items;
		}
		
		return items;
	}
	
	var parameterEncoder: ParameterEncoder {
		switch self {
			default: return JSONParameterEncoder.default;
		}
	}
	
	func encodeParameters(into request: URLRequest) throws -> URLRequest {
		switch self {
			default: return request;
		}
	}
	
	func asURLRequest() throws -> URLRequest {
		return try encodeParameters(into: BaseService.composeURLRequest(baseURL: baseURL,
																		path: path,
																		queryItems: queryItems,
																		method: method,
																		headers: headers));
	}
}
