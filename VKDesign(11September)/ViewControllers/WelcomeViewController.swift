//
//  WelcomeViewController.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 30/10/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class WelcomeViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    let pageControlCurrentPage = 0
    let pageControlXPostitoin: CGFloat = 0
    let pageControlHeight: CGFloat = 50
    let pageControlYPosition: CGFloat = UIScreen.main.bounds.maxY - 50
    let pageControlWidth: CGFloat = UIScreen.main.bounds.width
    let mainStoryboardName = "Main"
    let firstPageViewControllerIdentifier = "sbRed"
    let secondPageViewControllerIdentifier = "sbBlue"
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVc(viewController: firstPageViewControllerIdentifier),
                self.newVc(viewController: secondPageViewControllerIdentifier)]
    }()
    
    var pageControl = UIPageControl()
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: pageControlXPostitoin, y: pageControlYPosition, width: pageControlWidth, height: pageControlHeight))
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = pageControlCurrentPage
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return orderedViewControllers.first
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard orderedViewControllers.count != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllers.count > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        self.delegate = self
        configurePageControl()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }
    
    
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: mainStoryboardName, bundle: nil).instantiateViewController(withIdentifier: viewController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

