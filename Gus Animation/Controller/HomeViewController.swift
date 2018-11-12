//
//  HomeViewController.swift
//  Gus Animation
//
//  Created by Agus Cahyono on 10/11/18.
//  Copyright © 2018 Agus Cahyono. All rights reserved.
//

import UIKit

class HomeViewController: BaseView, UITableViewDataSource, UITableViewDelegate, FloatingPanelControllerDelegate {

    @IBOutlet weak var tableView: UITableView!

    var navView: NavigationView!
    var headerHeight: CGFloat = 0
    var lastContentOffset: CGFloat = 0
    var parallaxHeader: GSParallaxHeader!
    
    var mainPanelVC: FloatingPanelController!
    var detailPanelVC: FloatingPanelController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.sectionHeaderHeight = 8
        
        tableView.showsVerticalScrollIndicator = false
        
        self.parallaxHeader = GSParallaxHeader(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 150))
        self.parallaxHeader.imageView.image = UIImage(named: "imgfood")
        self.tableView.tableHeaderView  = self.parallaxHeader
        
        let headerView = UIView(frame: self.tableView.tableHeaderView!.bounds)
        headerView.height -= 80
        headerHeight = headerView.height
        
        self.makeNavView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.transparentNavigation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainPanelVC.removePanelFromParent(animated: false)
    }
    
    func makeNavView() {
        navView = NavigationView(frame: CGRect(x: 0, y: 0, width: screen_width, height: 64))
        navView.navigationTitle.text = "Nasi Goreng Mak Nyak"
        self.navigationController?.view.addSubview(navView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section % 2 == 0 {
            return 4
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeViewCell
        
        cell.buildMenu()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let contentVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self.addMainPanel(with: contentVC)
        mainPanelVC.move(to: .full, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 48))
        headerView.backgroundColor = UIColor.white
        
        let sectionHeader = HeaderSection(frame: headerView.bounds)
        sectionHeader.sectionTitle.text = "Aneka Makanan 10 Ribuan"
        
        headerView.addSubview(sectionHeader)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func addMainPanel(with contentVC: DetailViewController) {
        // Initialize FloatingPanelController
        mainPanelVC = FloatingPanelController()
        mainPanelVC.delegate = self
        mainPanelVC.isRemovalInteractionEnabled = false
        
        // Initialize FloatingPanelController and add the view
        mainPanelVC.surfaceView.cornerRadius = 15.0
        mainPanelVC.surfaceView.shadowHidden = false
        
        
        // Set a content view controller
        mainPanelVC.set(contentViewController: contentVC)
        mainPanelVC.track(scrollView: contentVC.tableView)
        
        
        //  Add FloatingPanel to self.view
        mainPanelVC.addPanel(toParent: self, belowView: nil, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.tableView.tableHeaderView as! GSParallaxHeader
        headerView.scrollViewDidScroll(scrollView: scrollView)
        
        let yOffset = scrollView.contentOffset.y
        if yOffset < (headerHeight - navView.height) {
            let alpha = yOffset / (headerHeight - navView.height)
            
            UIView.animate(withDuration: 0.1, delay: 0.0
                , options: .curveLinear, animations: {
                    
                    self.navView.backgroundColor = UIColor.RGB_COLOR(255/255, g: 255/255, b: 255/255, alpha: alpha)
                    self.navView.frame.origin.y = -64
                    self.navView.navigationTitle.alpha = alpha
                    
            }) { completed in
                
            }
        } else {
            
            UIView.animate(withDuration: 0.1, delay: 0.0
                , options: .curveLinear, animations: {
                    
                    self.navView.backgroundColor = UIColor.white
                    self.navView.frame.origin.y = 0
                    self.navView.navigationTitle.alpha = 1
                    
            }) { completed in
                
            }
            
        }
        
    }
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
         return newCollection.verticalSizeClass == .compact ? RemovablePanelLandscapeLayout() :  RemovablePanelLayout()
    }
    
    
}

class RemovablePanelLayout: FloatingPanelLayout {
    var initialPosition: FloatingPanelPosition {
        return .half
    }
    var supportedPositions: Set<FloatingPanelPosition> {
        return [.full, .half]
    }
    var bottomInteractionBuffer: CGFloat {
        return 261.0 - 22.0
    }
    
    func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full: return 16.0
        case .half: return 261.0
        default: return nil
        }
    }
    func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
        return 0.3
    }
}

class RemovablePanelLandscapeLayout: FloatingPanelLayout {
    var initialPosition: FloatingPanelPosition {
        return .half
    }
    var supportedPositions: Set<FloatingPanelPosition> {
        return [.half]
    }
    var bottomInteractionBuffer: CGFloat {
        return 261.0 - 22.0
    }
    
    func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .half: return 261.0
        default: return nil
        }
    }
    func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
        return 0.3
    }
}
