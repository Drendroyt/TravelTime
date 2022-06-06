//
//  NetworkService.swift
//  TravelTime
//
//  Created by Кирилл Дамковский on 05.06.2022.
//

import Foundation

class NetworkService {

    static func loadFlightSchedule(completion: @escaping ([ScheduleInfo.FlightInfo]) -> ()) {

        let stringURL = "https://travel.wildberries.ru/statistics/v1/cheap"
        guard let url = URL(string: stringURL) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print(error?.localizedDescription ?? "Error without description")
                return
            }
            guard let data = data else { return }
            guard let flightSchedule = try? JSONDecoder().decode(ScheduleInfo.self, from: data) else {
                print("Error: parsing error")
                return
            }
            completion(flightSchedule.data)
        }
        task.resume()
    }
}
