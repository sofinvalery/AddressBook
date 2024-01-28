//
//  ContactsTableTableViewController.swift
//  ContactsBook
//
//  Created by Valeriy Sofin on 1/20/24.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    var contactsBook: ContactBook?
    let contactCell = "ContactCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsBook = ContactBook()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [editButtonItem]
        navigationItem.leftBarButtonItems = [addButton]
        
        contactsBook?.book = [
          Contact(name: "John Smith", address: "123 Main St, Anytown USA", phone: "555-1234"),
          Contact(name: "Jane Doe", address: "456 Oak Rd, Somecity NY", phone: "555-5678"),
          Contact(name: "Bob Johnson", address: "789 Elm St, Otherville CA", phone: "555-9012"),
          Contact(name: "Sara Lee", address: "321 Sunny Ln, Lastplace OR", phone: "555-3456"),
          Contact(name: "Mike Jones", address: "159 Water St, Smalltown TN", phone: "555-7890"),
          Contact(name: "Karen Hill", address: "753 Mountain Dr, Middleburg VA", phone: "555-2345"),
          Contact(name: "Tom Wilson", address: "864 Valley View Rd, Newplace TX", phone: "555-6789"),
          Contact(name: "Jessica Black", address: "975 Park Ave, Oldcity PA", phone: "555-1234"),
          Contact(name: "Chris White", address: "357 River Rd, Nextcity FL", phone: "555-4321"),
          Contact(name: "Amanda Green", address: "159 Highway Dr, Laststop AZ", phone: "555-9876")
        ]
        
        tableView.reloadData()
        
        title = "Contacts"
        
        self.clearsSelectionOnViewWillAppear = false
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.register(ContactCell.self, forCellReuseIdentifier: contactCell)
    }
    
    @objc func addTapped() {
        let alertController = UIAlertController(title: "New Contact", message: "Please enter the contact's details", preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "Name"
        }

        alertController.addTextField { textField in
            textField.placeholder = "Address"
        }

        alertController.addTextField { textField in
            textField.placeholder = "Phone Number"
        }

        let addButton = UIAlertAction(title: "Add Contact", style: .default) { action in
            guard let name = alertController.textFields?[0].text, name != "",
                  let address = alertController.textFields?[1].text, address != "",
                  let phoneNumber = alertController.textFields?[2].text, phoneNumber != "" else { return }

            let newContact = Contact(name: name, address: address, phone: phoneNumber)
            self.contactsBook?.book.append(newContact)

            let indexPath = IndexPath(row: self.contactsBook!.book.count - 1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)

            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }

        alertController.addAction(addButton)

        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelButton)

        present(alertController, animated: true)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let contact = contactsBook?.book[indexPath.row] else { return }
        let detailsViewController = DetailsViewController(contactsBook: contactsBook!, contact: contact)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsBook?.book.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = contactsBook?.book[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: contactCell, for: indexPath)
        
        cell.textLabel?.text = contact?.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contactsBook?.book.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        if editingStyle == .insert {
            contactsBook?.book.append(Contact(name: "", address: "", phone: ""))
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        contactsBook?.book.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
}
