//
//  FlightScheduleViewController.swift
//  TravelTime
//
//  Created by Кирилл Дамковский on 05.06.2022.
//

import UIKit

class FlightScheduleViewController: UIViewController {

    var flightList = [ScheduleInfo.FlightInfo]()
    var likeStatusList: [Int : Bool] = [:]

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.style = .large
        spinner.startAnimating()
        return spinner
    }()

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
        setupNavigationBar()
        layout()
        NetworkService.loadFlightSchedule { sheduleInfo in
            DispatchQueue.main.async {
                self.flightList = sheduleInfo
                self.activityIndicator.stopAnimating()
                self.likeStatusList = {
                    var dictonary: [Int: Bool] = [:]
                    let keysArray = Array(0...9)
                    let valueArray = Array.init(repeating: false, count: 10)
                    zip(keysArray, valueArray).forEach { dictonary[$0] = $1 }
                    return dictonary
                }()
                self.scheduleTableView.reloadData()
            }
        }
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Маршруты"
        self.navigationItem.backButtonTitle = "Назад"
    }

    private func layout() {
        view.addSubview(activityIndicator)
        view.addSubview(scheduleTableView)

        view.bringSubviewToFront(activityIndicator)
        
        NSLayoutConstraint.activate([

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = FlightDetailViewController()
        detailVC.delegate = self
        detailVC.indexPath = indexPath
        detailVC.setupViews(data: flightList[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension FlightScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flightList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlightScheduleTableViewCell.identifier, for: indexPath) as! FlightScheduleTableViewCell
        cell.indexPath = indexPath
        cell.delegate = self
        cell.selectionStyle = .none
        cell.setupCell(data: flightList[indexPath.row])
        return cell
    }

}
