//
//  InvoiceListContainerViewController.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import SwiftUI
import UIKit

class InvoiceListContainerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "Invoice List"
        setupTableView()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addInvoiceListView() {
        let invoiceViewModel = InvoiceListViewModel<Invoice<InvoiceLine>>()
        let invoiceListView = InvoiceListView(viewModel: invoiceViewModel)
        let controller = UIHostingController(rootView: invoiceListView)
        controller.view.backgroundColor = .lightGray
        addChildViewController(controller, to: view)
    }

    /// Initialises the tableview
    func setupTableView() {
        addInvoiceListView()
    }
}
