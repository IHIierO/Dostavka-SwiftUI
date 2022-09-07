//
//  TableForDescription.swift
//  dostavka
//
//  Created by   macbookair132013 on 15.06.2022.
//

import UIKit

class descriptionList: UITableViewController {

    let idOptionsDescriptionList = "idOptionsDescriptionList"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: idOptionsDescriptionList)
        title = "Proverka"

        title = "Описание"

    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return 1
        case 3: return 3
        default:
            return 1

        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsDescriptionList, for: indexPath)

        cell.textLabel!.text = "cell"
        return cell
    }




    }

