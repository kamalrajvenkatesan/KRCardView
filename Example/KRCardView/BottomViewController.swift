//
//  BottomViewController.swift
//  KRCardView_Example
//
//  Created by kamalraj venkatesan on 02/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import KRCardView

class BottomViewController: CardViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension BottomViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = "Row - \(indexPath.row)"
    cell.textLabel?.textAlignment = .center
    return cell
  }

}
