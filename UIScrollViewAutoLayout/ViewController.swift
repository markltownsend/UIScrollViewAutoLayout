//
//  ViewController.swift
//  UIScrollViewAutoLayout
//
//  Created by Mark Townsend on 12/18/22.
//

import UIKit

class ViewController: UIViewController {
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var headerView: UIView = {
        let view = HeaderView(title: "The quick brown fox jumped over the lazy moon", subtitle: "by Jonny Appleseed")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var tableView: UITableView = {
        let tableView = MyTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        tableView.isScrollEnabled = false
        tableView.rowHeight = 44.0
        tableView.dataSource = self
        return tableView
    }()

    let backgroundColors: [UIColor] = [.red, .blue, .green, .yellow, .purple, .orange]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        tableView.reloadData()
    }

    private func setupViews() {
        let frameGuide = scrollView.frameLayoutGuide
        let contentGuide = scrollView.contentLayoutGuide

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            frameGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frameGuide.topAnchor.constraint(equalTo: view.topAnchor),
            frameGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frameGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentGuide.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentGuide.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentGuide.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentGuide.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            // Prevent horizontal scrolling
            frameGuide.widthAnchor.constraint(equalTo: contentGuide.widthAnchor)
        ])

        contentView.addSubview(headerView)
        contentView.addSubview(tableView)

        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: headerView.bottomAnchor, multiplier: 1.0),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 500
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        cell.backgroundColor = backgroundColors[Int.random(in: 0..<backgroundColors.count)]
        cell.textLabel?.text = "\(Int.random(in: 0..<500))"
        return cell
    }
}

