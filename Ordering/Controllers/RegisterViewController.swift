//
//  RegisterViewController.swift
//  Ordering
//
//  Created by Michael Wild on 10/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

    var usernameTxt : UITextField! //0
    var emailTxt: UITextField! //1
    var passwordTxt : UITextField! //2
    var verifyTxt : UITextField! //3
    var createButton : UIBarButtonItem!
    var activityIndicator : UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameTxt = UITextField(frame:CGRect(x:UIScreen.main.bounds.size.width * 0.05, y:(self.navigationController?.navigationBar.bounds.size.height)! + 10 + UIApplication.shared.statusBarFrame.size.height, width:UIScreen.main.bounds.size.width * 0.9, height:UITextField.defaultHeight()))
        self.usernameTxt.standardStyle()
        self.usernameTxt.placeholder = " Username"
        self.usernameTxt.clearButtonMode = UITextFieldViewMode.whileEditing
        self.usernameTxt.autocorrectionType = .no
        self.usernameTxt.autocapitalizationType = .none
        self.usernameTxt.tag = 0
        
        self.emailTxt = UITextField(frame: CGRect(x:UIScreen.main.bounds.size.width * 0.05, y:(self.navigationController?.navigationBar.bounds.size.height)! + UIApplication.shared.statusBarFrame.size.height + 10 + (UITextField.defaultHeight() + 10), width: UIScreen.main.bounds.size.width * 0.9, height: UITextField.defaultHeight()))
        self.emailTxt.standardStyle()
        self.emailTxt.placeholder = " Email Address"
        self.emailTxt.clearButtonMode = UITextFieldViewMode.whileEditing
        self.emailTxt.autocorrectionType = .no
        self.emailTxt.autocapitalizationType = .none
        self.emailTxt.keyboardType = .emailAddress
        self.emailTxt.tag = 1
        self.emailTxt.delegate = self
        
        self.passwordTxt = UITextField(frame: CGRect(x:UIScreen.main.bounds.size.width * 0.05, y:(self.navigationController?.navigationBar.bounds.size.height)! + UIApplication.shared.statusBarFrame.size.height + 10 + ((UITextField.defaultHeight() * 2) + 80), width: UIScreen.main.bounds.size.width * 0.9, height: UITextField.defaultHeight()));
        self.passwordTxt.standardStyle()
        self.passwordTxt.placeholder = " Password"
        self.passwordTxt.delegate = self
        self.passwordTxt.isSecureTextEntry = true
        self.passwordTxt.tag = 2
        
        self.verifyTxt = UITextField(frame: CGRect(x:UIScreen.main.bounds.size.width * 0.05, y: (self.navigationController?.navigationBar.bounds.size.height)! + UIApplication.shared.statusBarFrame.size.height + 10 + ((UITextField.defaultHeight() * 3) + 90), width: UIScreen.main.bounds.size.width * 0.9, height: UITextField.defaultHeight() ))
        self.verifyTxt.standardStyle()
        self.verifyTxt.placeholder = " Re-enter password"
        self.verifyTxt.isSecureTextEntry = true
        self.verifyTxt.tag = 3
        
        /*Navigation Bar Buttons*/
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonAction))
        navigationItem.leftBarButtonItems = [cancelButton]
        
        createButton = UIBarButtonItem(barButtonSystemItem:.add, target: self, action: #selector(createButtonAction))
        createButton.title = "Create"
        navigationItem.rightBarButtonItems = [createButton]
        /*----------------------------------*/

        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = UIColor.darkGray
        
        
        self.view.addSubview(usernameTxt)
        self.view.addSubview(emailTxt)
        self.view.addSubview(passwordTxt)
        self.view.addSubview(verifyTxt)
        
        self.usernameTxt.becomeFirstResponder()
    }
    
    func cancelButtonAction( _ sender: UIBarButtonItem ) {
        _ =  self.navigationController?.popViewController(animated: true)
    }
    
    func createButtonAction( _ sender: UIBarButtonItem ) {
        activityIndicator.startAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        
        var canBeSubmitted = true
        
        if( usernameTxt.text == "" || usernameTxt.text == nil){
            //change the username color?
            canBeSubmitted = false
        } else if emailTxt.text == "" ||   emailTxt.text == nil {
            //change the email color?
            canBeSubmitted = false
        } else if passwordTxt.text == "" || passwordTxt.text == nil {
            canBeSubmitted = false
        } else if verifyTxt.text == "" || verifyTxt.text == nil {
            canBeSubmitted = false
        } else if ( !isValidEmail(emailStr: emailTxt.text!) ) {
            //email is not valid
            canBeSubmitted = false
        }
        
        if ( canBeSubmitted ) {
            let _ : Void = UserHelper.sharedInstance.create(usernameTxt.text!,_password: passwordTxt.text!, _email: emailTxt.text!, onCompletion: {(complete: Bool?, error: NSError?) -> Void in
                if(error == nil && complete == true) {
                    //redirect to login page
                    print("new user was created")
                }else {
                    
                    //self.present(self.loginFailedAlert, animated:true, completion:nil)
                    print("failed to create new user")
                    self.navigationItem.rightBarButtonItems = [self.createButton]
                }
            })
        } else {
            self.navigationItem.rightBarButtonItems = [createButton]
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //change the passed in text fields values here
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            //this is the email field
            if( !isValidEmail(emailStr: textField.text! ) ) {
                //not valid
                //alert the user
                print("Not a valid email")
            }
        }
    }
    
    func isValidEmail ( emailStr: String ) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailStr);
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
