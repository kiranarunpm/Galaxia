//
//  UIViewController+Extension.swift
//  Where2Go
//
//  Created by Kiran on 15/08/23.
//

import Foundation
struct ListResponse : Codable {
	let status : Bool?
	let message : String?
	let error : String?
	let result : [GalaxiaList]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case message = "message"
		case error = "error"
		case result = "result"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Bool.self, forKey: .status)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		error = try values.decodeIfPresent(String.self, forKey: .error)
		result = try values.decodeIfPresent([GalaxiaList].self, forKey: .result)
	}

}
