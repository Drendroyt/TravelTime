//
//  FlightScheduleTableViewCell.swift
//  TravelTime
//
//  Created by Кирилл Дамковский on 05.06.2022.
//

import UIKit

class FlightScheduleTableViewCell: UITableViewCell {

    private lazy var travelInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    private lazy var departureInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var returnInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var departureRouteStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private lazy var returnRouteStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var startDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        return label
    }()

    private lazy var endDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        contentView.addSubview(travelInfoStackView)

        [priceLabel, departureInfoStackView, returnInfoStackView].forEach { travelInfoStackView.addArrangedSubview($0) }

        [startDateLabel, departureRouteStackView].forEach { departureInfoStackView.addArrangedSubview($0) }

        [departureStartCityLabel, departureArrowImageView, departureEndCityLabel].forEach { departureRouteStackView.addArrangedSubview($0) }

        [endDateLabel, returnRouteStackView].forEach { returnInfoStackView.addArrangedSubview($0) }

        [returnStartCityLabel, returnArrowImageView, returnEndCityLabel].forEach { returnRouteStackView.addArrangedSubview($0) }

        let inset: CGFloat = 8
        let labelWidth: CGFloat = 150

        NSLayoutConstraint.activate([
            travelInfoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            travelInfoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            travelInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            travelInfoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),

            departureStartCityLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            departureEndCityLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            returnStartCityLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            returnEndCityLabel.widthAnchor.constraint(equalToConstant: labelWidth)
        ])
    }

    func setupCell(data: ScheduleInfo.FlightInfo) {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SSZ"
        let startDate = dateFormatter.date(from: data.startDate)
        let endDate = dateFormatter.date(from: data.endDate)

        priceLabel.text = String(data.price) + " P"
        startDateLabel.text = startDate?.formatted(date: .complete, time: .omitted)
        departureStartCityLabel.text = data.startCity
        departureEndCityLabel.text = data.endCity
        endDateLabel.text = endDate?.formatted(date: .complete, time: .omitted)
        returnStartCityLabel.text = data.endCity
        returnEndCityLabel.text = data.startCity
    }
}

