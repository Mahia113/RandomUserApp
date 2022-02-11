//
//  ViewController.swift
//  RandomUserJusto
//
//

import UIKit
import Combine

class UserViewController: UIViewController, UserViewControllerDelegate {
    
    @IBOutlet weak var viewContainerTop: UIView!
    @IBOutlet weak var viewContainerBottom: UIView!
    
    @IBOutlet weak var imageViewAvatar: UIImageView!
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelGender: UILabel!
    @IBOutlet weak var labelYears: UILabel!
    
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelStateCity: UILabel!
    @IBOutlet weak var labelCountry: UILabel!
    @IBOutlet weak var labelPostCode: UILabel!
    @IBOutlet weak var labelTimeZone: UILabel!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelDateRegistered: UILabel!
    
    private let userPresenter: UserPresenter = UserPresenter()
    
    private let dialogTitle = "Lo sentimos"
    private let dialogMessage = "Ocurrio un error al obtener los datos del usuario. Razón: "
        
    override func viewDidLoad() {
        super.viewDidLoad()
        userPresenter.setViewDelegate(userViewControllerDelegate: self)
        userPresenter.getUserData()
        addViewShadows()
    }

    func displayUserData(data: RandomUserModel) {
        
        userPresenter.downloadUserImage(url: data.picture.medium)
        
        let name = data.name.title+" "+data.name.first+" "+data.name.last
        let years = String(data.dob.age)+" years"
        let address = data.location.street.name+", "+String(data.location.street.number)
        let stateCity = data.location.state+", "+data.location.city
        var postalCode = ""
        
        if let pc = data.location.postcode.any as? Int {
            postalCode = String(pc)
        } else if let pc = data.location.postcode.any as? String {
            postalCode = pc
        }
        
        DispatchQueue.main.async {
            self.labelName.text = name
            self.labelEmail.text = data.email
            self.labelPhone.text = data.phone
            self.labelGender.text = data.gender
            self.labelYears.text = years
            
            self.labelAddress.text = address
            self.labelStateCity.text = stateCity
            self.labelCountry.text = data.location.country
            self.labelTimeZone.text = data.location.timezone.description
            self.labelUserName.text = data.login.username
            self.labelDateRegistered.text = data.registered.date
            self.labelPostCode.text = postalCode
        }
            
    }
    
    func displayUserImage(image: Data) {
        DispatchQueue.main.async {
            self.imageViewAvatar.image = UIImage(data: image)
        }
    }
    
    func errorFetchingUserData(error: Error) {
        DispatchQueue.main.async {
            self.alert(message: self.dialogMessage+"\(error)", title: self.dialogTitle)
        }
    }
    
    func addViewShadows(){
        addViewShadow(view: viewContainerTop)
        addViewShadow(view: viewContainerBottom)
    }
    
    func addViewShadow(view: UIView){
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 4.0
    }

}

extension UIViewController {
  func alert(message: String, title: String = "") {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}

