//
//  FlightScheduleViewController.swift
//  TravelTime
//
//  Created by Кирилл Дамковский on 05.06.2022.
//

import UIKit

class FlightScheduleViewController: UIViewController {

    var flightList = [ScheduleInfo.FlightInfo]()

    lazy var scheduleTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FlightScheduleTableViewCell.self, forCellReuseIdentifier: FlightScheduleTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        layout()
        NetworkService.loadFlightSchedule { sheduleInfo in
            DispatchQueue.main.async {
                self.flightList = sheduleInfo
                self.scheduleTableView.reloadData()
                print(sheduleInfo)
            }
        }
    }

    private func layout() {
        view.addSubview(scheduleTableView)
        
        NSLayoutConstraint.activate([
            scheduleTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scheduleTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scheduleTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scheduleTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension FlightScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension FlightScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flightList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlightScheduleTableViewCell.identifier, for: indexPath) as! FlightScheduleTableViewCell
        cell.setupCell(data: flightList[indexPath.row])
        return cell
    }

}
