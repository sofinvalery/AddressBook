//
//  DetailsViewController.swift
//  ContactsBook
//
//  Created by Valeriy Sofin on 1/20/24.
//

import UIKit

class DetailsViewController: UITableViewController {
    
    var contactsBook: ContactBook
    var contact: Contact
    let detailCell = "DetailCell"
    
    init(contactsBook: ContactBook, contact: Contact) {
        self.contactsBook = contactsBook
        self.contact = contact
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        
        tableView.register(DetailCell.self, forCellReuseIdentifier: detailCell)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return contactsBook.book.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailCell, for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = contact.name
        case 1:
            cell.textLabel?.text = contact.address
        case 2:
            cell.textLabel?.text = contact.phone
        default:
            break
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Name"
        case 1:
            return "Address"
        case 2:
            return "Phone"
        default:
            return nil
        }
    }
}

extension DetailsViewController {
    func updateName(_ name: String) {
        contact.name = name
    }
    
    func updatePhone(_ phone: String) {
        contact.phone = phone
    }
}
