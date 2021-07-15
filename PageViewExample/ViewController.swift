//
//  ViewController.swift
//  PageViewExample
//
//  Created by 김종권 on 2021/07/15.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    lazy var navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray

        return view
    }()

    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        return vc
    }()

    lazy var vc1: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .red

        return vc
    }()

    lazy var vc2: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .green

        return vc
    }()

    lazy var vc3: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .blue

        return vc
    }()

    lazy var dataViewControllers: [UIViewController] = {
        return [vc1, vc2, vc3]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDelegate()

        configure()

        if let firstVC = dataViewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }

    }

    private func setupDelegate() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }

    private func configure() {
        view.addSubview(navigationView)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)

        navigationView.snp.makeConstraints { make in
            make.width.top.equalToSuperview()
            make.height.equalTo(72)
        }

        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        pageViewController.didMove(toParent: self)

    }
}

extension ViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return dataViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == dataViewControllers.count {
            return nil
        }
        return dataViewControllers[nextIndex]
    }
}
