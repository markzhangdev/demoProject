//
//  InvoiceListViewModel.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import Foundation

protocol InvoiceListViewModelProtocol: ObservableObject, InvoiceCellViewDelegate {
    associatedtype InvoiceItem: InvoiceViewModelProtocol

    var invoiceList: [InvoiceItem] { get set }
    func deleteInvoice(by indexSet: IndexSet)
    func refreshInvoiceList()
    func validateInvoiceInput(_ invoice: InvoiceItem) -> Bool
}

///
///
/// Warning: This part is over engineered for a simple app.
/// Only trying to demonstrate my ablility to work with protocol oriented programming complex app
///
///

class InvoiceListViewModel<InvoiceItem: InvoiceViewModelProtocol>: InvoiceListViewModelProtocol {
    @Published var invoiceList: [InvoiceItem] = []

    func updateInvoiceList(with updatedInvoiceList: [InvoiceItem]) {
        invoiceList = updatedInvoiceList
    }

    public init() {
        initData()
    }

    private func initData() {
        createInvoice(invoiceNumber: 1, invoiceDate: Date(), lineItems: [InvoiceLineViewModel(invoiceLineId: 1, description: "first line", quantity: 2, cost: 2.22),
                                                                         InvoiceLineViewModel(invoiceLineId: 2, description: "first line", quantity: 2, cost: 2.22)])
    }

    func deleteInvoice(by indexSet: IndexSet) {
        invoiceList.remove(atOffsets: indexSet)
    }

    func createInvoiceItem(invoiceNumber: Int = 1, invoiceDate: Date = Date(), lineItems: [InvoiceLineViewModel] = []) -> InvoiceItem? {
        return InvoiceViewModel(invoiceNumber: invoiceNumber, invoiceDate: invoiceDate, lineItems: lineItems) as? InvoiceItem
    }

    func createInvoice(invoiceNumber: Int = 1, invoiceDate: Date = Date(), lineItems: [InvoiceLineViewModel] = []) {
        guard let invoice = createInvoiceItem(invoiceNumber: invoiceNumber, invoiceDate: invoiceDate, lineItems: lineItems) else { return }
        guard validateInvoiceInput(invoice) else {
            return
        }
        invoiceList.append(invoice)
    }

    func validateInvoiceInput(_ invoice: InvoiceItem) -> Bool {
        if invoice.invoiceNumber == 0 {
            return false
        }

        return true
    }

    func getInvoices() -> [InvoiceItem] {
        invoiceList
    }

    @MainActor
    func refreshInvoiceList() {
        /// It's not working yet as API service is not based on correct URL
        Task {
            guard let invoiceListDTO = try? await InvoiceAPIService.getInvoiceList(path: "/invoiceList", method: .get) else { return }
            self.invoiceList = invoiceListDTO.compactMap(InvoiceItem.init)
        }
    }

    func cloneInvoice(from invoice: some InvoiceViewModelProtocol) {
        Task.detached {
            guard let clone: InvoiceItem = try? await invoice.clone() else { return }
            DispatchQueue.main.async {
                self.invoiceList.append(clone)
            }
        }
    }
}
