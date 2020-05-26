//
//  RootPageViewController.swift
//  MyChat
//
//  Created by Chinh le on 5/26/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

class RootPageViewController: UIPageViewController {
    //MARK: Property
    var pageControl: UIPageControl?
    lazy var viewControllersList: [UIViewController] = {
        let storyboard = UIStoryboard(name: "Intro", bundle: nil)
        let vc1 = storyboard.instantiateViewController(identifier: "ViewController1")
        let vc2 = storyboard.instantiateViewController(identifier: "ViewController2")
        let vc3 = storyboard.instantiateViewController(identifier: "ViewController3")
        return [vc1, vc2, vc3]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        if let firstViewController = viewControllersList.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        configPageControl()
    }
    
    //MARK: Config
    private func configPageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width, height: 50))
        pageControl?.numberOfPages = viewControllersList.count
        pageControl?.currentPage = 0
        pageControl?.tintColor = UIColor.black
        pageControl?.pageIndicatorTintColor = UIColor.white
        pageControl?.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl ?? UIPageControl())
    }
    
}

extension RootPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllersList.firstIndex(of: viewController) else { return nil }
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else { return nil }
        guard viewControllersList.count > previousIndex else { return nil }
        return viewControllersList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllersList.firstIndex(of: viewController) else { return nil }
        let nextIndex = vcIndex + 1
        guard viewControllersList.count != nextIndex else { return nil }
        guard viewControllersList.count > nextIndex else { return nil }
        return viewControllersList[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let pageContentViewController = pageViewController.viewControllers?[0] {
            self.pageControl?.currentPage = viewControllersList.firstIndex(of: pageContentViewController) ?? 0
        }
    }
    
    
}
