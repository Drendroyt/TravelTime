//
//  ScheduleInfo.swift
//  TravelTime
//
//  Created by Кирилл Дамковский on 07.06.2022.
//

import Foundation

struct ScheduleInfo: Decodable {
    let data: [FlightInfo]

    struct FlightInfo: Decodable {
        let startCity: String
        let endCity: String
        let startDate: String
        let endDate: String
        let price: Int
    }
}
