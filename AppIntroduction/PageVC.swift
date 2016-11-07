//
//  PageVC.swift
//  AppIntroduction
//
//  Created by Scalman on 03/11/16.
//  Copyright © 2016 SchoolWork. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate,UIScrollViewDelegate{
    
    
    private var imageView: UIImageView?
    private var cloud: UIImageView?
    private var cloudFar: UIImageView?
    private var cloudMiddle: UIImageView?
    private var pageIndex: Int = 0
    private var pc: UIPageControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self

        //WTF
        for view in self.view.subviews{
            if view.isKind(of:UIScrollView.self){
                (view as! UIScrollView).delegate = self
                //(view as! UIScrollView). = true
            }
        }
        
        //TODO New Background Stuff Might Need A Change....
        imageView = UIImageView(image: UIImage(named: "air")!)
        imageView!.contentMode = .scaleAspectFill
        imageView!.frame = UIScreen.main.bounds
        view.insertSubview(imageView!, at: 0)
        
        self.cloud = UIImageView(image: UIImage(named: "cloud")!)
        self.cloud?.center.x = view.frame.width / 5
        view.insertSubview(cloud!, at: 1)
        
        self.cloudFar = UIImageView(image: UIImage(named: "cloudFar")!)
        self.cloudFar?.center.y = view.frame.height / 5
        self.cloudFar?.center.x = view.frame.width - (view.frame.width / 10)
        view.insertSubview(cloudFar!, at: 2)
        
        self.cloudMiddle = UIImageView(image: UIImage(named: "cloud")!)
        self.cloudMiddle?.center.y = view.frame.height / 3
        self.cloudMiddle?.center.x = view.frame.width / 15
        view.insertSubview(cloudMiddle!, at: 3)
        
        
        pc = UIPageControl.appearance()
        pc.pageIndicatorTintColor = UIColor.lightGray
        pc.currentPageIndicatorTintColor = UIColor.black
        
        
        if let firstVC = VCContainer.first{
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    var lastContentOffset: CGFloat = 414
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print("\(scrollView.contentOffset.x)")
        
        //var ii = VCContainer.index(of: self)
        //print("Current Page:  \(ii)")
       // print("\(scrollView.frame.width)") //scrollView.contentOffset.x
        //var x = scrollView.contentOffset.x
        //let hej: CGFloat  = lastContentOffset / 3
        //if

        //print("\(self.pc.numberOfPages)")
        //let prev = (self.cloudFar?.center.x)! - scrollView.contentOffset.x
        
        if self.pageIndex == 0{
            
            self.cloud?.center.x = scrollView.contentOffset.x / 5 // Between(414 - 828) / 5  ------> 82,8
            
            self.cloudFar?.center.x = view.frame.width - (scrollView.contentOffset.x / 10)
            
            self.cloudMiddle?.center.x = scrollView.contentOffset.x / 15

        }else if self.pageIndex == 1{

            self.cloud?.center.x = (scrollView.contentOffset.x + view.frame.width) / 5 // (optional(414) + fix(414)) / 5  ------> 82,8 * 2
            
            self.cloudFar?.center.x = view.frame.width - (scrollView.contentOffset.x + view.frame.width) / 10
            
            self.cloudMiddle?.center.x = (scrollView.contentOffset.x + view.frame.width) / 15
            
        }else if self.pageIndex == 2{
            
            self.cloud?.center.x = (scrollView.contentOffset.x + view.frame.width*2) / 5 // (optional(414) + fix(414 * 2)) / 5  ------> 82,8 * 3
            
            self.cloudFar?.center.x = view.frame.width - (scrollView.contentOffset.x + view.frame.width*2) / 10
            
            self.cloudMiddle?.center.x = (scrollView.contentOffset.x + view.frame.width*2) / 15
            
        }

    }
    
    /**
     *  Makes The ScrollViews In Bounds With The Whole Frame
     *  The Page Control in Every View Is Clear, Wich Means Alpha.
     */
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews{
            if view is UIScrollView{
                view.frame = UIScreen.main.bounds
            }else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
    
    /**
     *  Creates An Array Wich Contains A Bunch Of UIViewController.
     *  Fetches The Views From The StoryBoard.
     *  Lazy means that all of the pages will garanteed be there, has
     *  much to do with the phones OS.
     *  Return Value: UIViewController
     */
    private(set) lazy var VCContainer: [UIViewController] = {
        return [self.VCInstance(page: "FirstVC"),
                self.VCInstance(page: "SecondVC"),
                self.VCInstance(page: "ThirdVC")]
    }()
    /**
    *   Retrive ViewInstance From UIStoryBoard.
    *   Return value: UIViewController
    */
    private func VCInstance(page: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: page)
    }
    
    /**
    *   The Data Source wich comes with UIPageViewControllerDataSource.
    *   Specify Before And After View That Will Be Shown.
    *   Return Value: UIViewController Optional[?] Can Be "nil"
    *   You Should Return The View That Comes Next Or Before Depending On Method.
    */
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        
        
        
        guard let viewIndex = VCContainer.index(of: viewController) else {
            return nil
        }
        
        let previousPageIndex = viewIndex - 1
        //print("Before page: \(viewIndex)")
       // print("PageIndex: \(viewIndex)")
       // self.pageIndex = viewIndex
        guard previousPageIndex >= 0 else {
            return nil
        }
        
        guard VCContainer.count > previousPageIndex else {
            return nil
        }

        
       // print("PageIndex: \(viewIndex)")

        return VCContainer[previousPageIndex]
        
    }

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        
    
        guard let viewIndex = VCContainer.index(of: viewController) else {
            return nil
        }
        
        let nextPageIndex = viewIndex + 1
       // print("After Page: \(viewIndex)")
        

       /* guard nextPageIndex < VCContainer.count else {
            return VCContainer.first
        }*/
       // print("PageIndex: \(viewIndex)")
        //self.pageIndex = viewIndex
        guard VCContainer.count > nextPageIndex else {
            return nil
        }
        
        //print("PageIndex: \(viewIndex)")
        return VCContainer[nextPageIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool,previousViewControllers: [UIViewController],transitionCompleted completed: Bool)
    {
        if (completed && finished) {
            if let currentVC = pageViewController.viewControllers?.last {
                let indexx = VCContainer.index(of: currentVC)
                print("kuken : \(indexx)")
                pageIndex = indexx!
                //do something with index
            }
        }

        // How to get it?
    }
    
    
    /**
    *   How Meny ViewControllers That Is In Use
    */
    public func presentationCount(for pageViewController: UIPageViewController) -> Int{
        return VCContainer.count
    }
    
    /**
     *  This Will Be Called When The SetMethod Is Used.
     *  Make Sure That The View Is available, There Are Cases When
     *  The OS Decides To Remove One Or Two Of The Views You Already Created.
     */
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int{
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = VCContainer.index(of: firstViewController) else {
            return 0
        }
        return firstViewControllerIndex
    }
    
}
