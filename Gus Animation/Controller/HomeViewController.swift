//
//  HomeViewController.swift
//  Gus Animation
//
//  Created by Agus Cahyono on 10/11/18.
//  Copyright © 2018 Agus Cahyono. All rights reserved.
//

import UIKit
import AMRefresher
import SVProgressHUD

class HomeViewController: BaseView, UITableViewDataSource, UITableViewDelegate, FloatingPanelControllerDelegate {

    @IBOutlet weak var tableView: UITableView!

    var navView: NavigationView!
    var headerHeight: CGFloat = 0
    var lastContentOffset: CGFloat = 0
    var parallaxHeader: GSParallaxHeader!
    
    var mainPanelVC: FloatingPanelController!
    
    var numRows = 0 {
        didSet {
            self.isloaded = true
            tableView.reloadData()
        }
    }
    
    private let pageSize = 5
    var isloaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.sectionHeaderHeight = 48
        tableView.showsVerticalScrollIndicator = false
        
        self.makeNavView()
        
        self.tableView.am.addPullToRefresh { [unowned self] in
            SVProgressHUD.show()
            self.fetchDataFromStart(completion: {
                self.numRows = 1
                self.addHeader()
                self.tableView.am.pullToRefreshView?.stopRefreshing()
                SVProgressHUD.dismiss()
            })
        }
        
        //Adding Infinite Scrolling
        self.tableView.am.addInfiniteScrolling { [unowned self] in
            self.fetchMoreData(completion: {
                if self.numRows != self.pageSize {
                    self.numRows += 1
                    self.tableView.am.infiniteScrollingView?.stopRefreshing()
                } else {
                    self.showNotificationFire()
                    self.tableView.am.infiniteScrollingView?.stopRefreshing()
                    self.tableView.am.infiniteScrollingView?.hideInfiniteScrollingView()
                }
            })
        }
        
        tableView.am.pullToRefreshView?.trigger()
        
    }
    
    func fetchDataFromStart(completion handler:@escaping ()->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            handler()
        }
    }
    
    func fetchMoreData(completion handler:@escaping ()->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            handler()
        }
    }
    
    func addHeader() {
        self.parallaxHeader = GSParallaxHeader(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 150))
        self.parallaxHeader.imageView.image = UIImage(named: "imgfood")
        self.tableView.tableHeaderView  = self.parallaxHeader
        
        let headerView = UIView(frame: self.tableView.tableHeaderView!.bounds)
        headerView.height -= 80
        headerHeight = headerView.height
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numRows
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
        if isloaded {
            let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 48))
            headerView.backgroundColor = UIColor.white
            
            let sectionHeader = HeaderSection(frame: headerView.bounds)
            sectionHeader.sectionTitle.text = "Aneka Makanan 10 Ribuan"
            
            headerView.addSubview(sectionHeader)
            
            return headerView
        } else {
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isloaded {
            return 48
        } else {
            return 0
        }
    }
    
    func addMainPanel(with contentVC: DetailViewController) {
        // Initialize FloatingPanelController
        mainPanelVC = FloatingPanelController()
        mainPanelVC.delegate = self
        mainPanelVC.isRemovalInteractionEnabled = true
        
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
        if isloaded  {
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
    }
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
         return newCollection.verticalSizeClass == .compact ? RemovablePanelLandscapeLayout() :  RemovablePanelLayout()
    }
    
    private func showNotificationFire(){
        let alertController = UIAlertController(title: "Oops", message: "No more data available.", preferredStyle: .alert)
        
        let action2 = UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
