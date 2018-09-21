//
//  ListViewController.swift
//  DesafioCielo
//
//  Created by Gustavo Melki Leal on 19/09/2018.
//  Copyright (c) 2018 Gustavo Melki Leal. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import RxSwift
import SDWebImage

protocol ListDisplayLogic: class {
  func displayCharacters(viewModel: List.ViewModel)
  func displayError(errorDescription: List.Error)
}

class ListViewController: UIViewController, ListDisplayLogic {
  
  var interactor: ListBusinessLogic?

  // MARK: Object lifecycle
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  private func setup() {
    let viewController = self
    let interactor = ListInteractor()
    let presenter = ListPresenter()
    viewController.interactor = interactor
    interactor.presenter = presenter
    presenter.viewController = viewController
  }
  
  // MARK: Routing
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let vc = segue.destination as? DetailViewController {
      vc.character = characters[sender as! Int]
      //print(sender)
      
    }
  }
  
  // MARK: View lifecycle
  @IBOutlet weak var charactersTableView: UITableView!
  var characters = [Character]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getCharacters()
    
  }
  
  func getCharacters() {
    let request = List.Request()
    interactor?.getCharacters(request: request)
  }
  
  func displayCharacters(viewModel: List.ViewModel) {
    characters = viewModel.characters
    self.charactersTableView.reloadData()
  }
  
  func displayError(errorDescription: List.Error) {
    let alert = UIAlertController(title: "Ops!", message: errorDescription.errorDescription, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true)
  }
}


extension ListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return characters.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
    
    let url = URL(string: (characters[indexPath.row].thumbnail?.path)! + "/portrait_medium." + (characters[indexPath.row].thumbnail?._extension)!)
    
    cell.characterImg?.sd_setImage(with: url!, completed: nil)
    cell.characterLabel?.text = characters[indexPath.row].name
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100.0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.performSegue(withIdentifier: "showDetail", sender: indexPath.row)
  }
  
}


