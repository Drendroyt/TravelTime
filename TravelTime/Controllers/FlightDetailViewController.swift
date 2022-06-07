//
//  FlightDetailViewController.swift
//  TravelTime
//
//  Created by Кирилл Дамковский on 07.06.2022.
//

import UIKit

class FlightDetailViewController: UIViewController {

    var indexPath: IndexPath?
    weak var delegate: FlightScheduleViewController?

    private lazy var travelInfoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        return stackView
    }()

    private lazy var startCityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var endCityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var doubleArrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.right.arrow.left"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        return stackView
    }()

    private lazy var lineImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.right.arrow.left"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var startDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var endDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var departureDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var returnDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var flightInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Информация о вылетах:"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    private lazy var departureInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.layer.borderColor = UIColor.black.cgColor
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 3
        stackView.backgroundColor = .lightGray
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private lazy var returnInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.layer.borderColor = UIColor.black.cgColor
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 3
        stackView.backgroundColor = .lightGray
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private lazy var departureRouteStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()

    private lazy var returnRouteStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    private lazy var departureStartCityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var departureEndCityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()

    private lazy var returnStartCityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var returnEndCityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()

    private lazy var departureArrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var returnArrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        layout()
    }

    private func setupNavigationBar() {
        navigationItem.title = "Детали"
        navigationItem.rightBarButtonItem = {
            if delegate?.likeStatusList[indexPath!.row] == false {
                let likeButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(tapLikeButton))
                return likeButton
            } else {
                let likeButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(tapLikeButton))
                return likeButton
            }
        }()
    }

    private func layout() {
        [travelInfoStack, dateStackView, flightInfoLabel, departureInfoStackView, returnInfoStackView].forEach { view.addSubview($0) }

        [startCityLabel, doubleArrowImageView, endCityLabel].forEach { travelInfoStack.addArrangedSubview($0) }

        [startDateLabel, lineImageView, endDateLabel].forEach { dateStackView.addArrangedSubview($0) }

        [departureDateLabel, departureRouteStackView].forEach { departureInfoStackView.addArrangedSubview($0) }

        [departureStartCityLabel, departureArrowImageView, departureEndCityLabel].forEach { departureRouteStackView.addArrangedSubview($0) }

        [returnDateLabel, returnRouteStackView].forEach { returnInfoStackView.addArrangedSubview($0) }

        [returnStartCityLabel, returnArrowImageView, returnEndCityLabel].forEach { returnRouteStackView.addArrangedSubview($0) }

        let viewInset: CGFloat = 16
        let labelWidth: CGFloat = 150
        NSLayoutConstraint.activate([
            travelInfoStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: viewInset),
            travelInfoStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: viewInset),
            travelInfoStack.bottomAnchor.constraint(equalTo: dateStackView.topAnchor, constant: -(2 * viewInset)),

            dateStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: viewInset),
            dateStackView.bottomAnchor.constraint(equalTo: flightInfoLabel.topAnchor, constant: -viewInset),

            flightInfoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: viewInset),
            flightInfoLabel.bottomAnchor.constraint(equalTo: departureInfoStackView.topAnchor, constant: -(2 * viewInset)),

            departureInfoStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: viewInset),
            departureInfoStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -viewInset),
            departureInfoStackView.bottomAnchor.constraint(equalTo: returnInfoStackView.topAnchor, constant: -viewInset),

            returnInfoStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: viewInset),
            returnInfoStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -viewInset),


            departureStartCityLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            departureEndCityLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            returnStartCityLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            returnEndCityLabel.widthAnchor.constraint(equalToConstant: labelWidth)

        ])
    }

    func setupViews(data: ScheduleInfo.FlightInfo) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SSZ"
        let startDate = dateFormatter.date(from: data.startDate)
        let endDate = dateFormatter.date(from: data.endDate)

        startCityLabel.text = data.startCity
        endCityLabel.text = data.endCity
        startDateLabel.text = startDate?.formatted(date: .numeric, time: .omitted)
        endDateLabel.text = endDate?.formatted(date: .numeric, time: .omitted)
        departureStartCityLabel.text = data.startCity
        departureEndCityLabel.text = data.endCity
        returnStartCityLabel.text = data.endCity
        returnEndCityLabel.text = data.startCity
        departureDateLabel.text = startDate?.formatted(date: .long, time: .omitted)
        returnDateLabel.text = endDate?.formatted(date: .long, time: .omitted)
        priceLabel.text = String(data.price) + " P"

    }

    @objc private func tapLikeButton() {
        if delegate?.likeStatusList[indexPath!.row] == false {
            delegate?.likeStatusList.updateValue(true, forKey: indexPath!.row)
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
            delegate?.scheduleTableView.reloadData()
        } else {
            delegate?.likeStatusList.updateValue(false, forKey: indexPath!.row)
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
            delegate?.scheduleTableView.reloadData()
        }
    }
}
