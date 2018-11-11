//
//  DetailViewController.swift
//  Gus Animation
//
//  Created by Agus Cahyono on 11/11/18.
//  Copyright © 2018 Agus Cahyono. All rights reserved.
//

import UIKit

class DetailViewController: BaseView, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    @IBAction func dismiss(_ sender: DismissButton) {
        (self.parent as? FloatingPanelController)?.removePanelFromParent(animated: true, completion: nil)
    }
    
}
