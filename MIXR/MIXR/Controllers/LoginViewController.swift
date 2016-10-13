//
//  LoginViewController.swift
//  MIXR
//
//  Created by Nilesh Patel on 07/10/15.
//  Copyright (c) 2015 MIXR LLC. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Alamofire
import SwiftyJSON
import Foundation
import MobileCoreServices

var isTesting : Int = 2


class LoginViewController: BaseViewController {
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    var email: String? {
        return userEmailTextField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    var password: String? {
        return userPasswordTextField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
        
    override func viewDidLoad() {
        self.title = "Login"
        
        if let _ = AppPersistedStore.sharedInstance.authToken {
            self.loadTabar()
        }

        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (isTesting == 1)
        {
            self.userEmailTextField.text = "+919016234505"
            self.userPasswordTextField.text = "111111"
        }
        else if (isTesting == 2)
        {
            self.userEmailTextField.text = "bwears.com@gmail.com"
            self.userPasswordTextField.text = "test"
        }
        else if (isTesting == 3)
        {
            self.userEmailTextField.text = "re@re.co"
            self.userPasswordTextField.text = "1234"
        }
        else
        {
            self.userEmailTextField.text = ""
            self.userPasswordTextField.text = ""
        }
        
    }
    
    /*
    // Custom button methods for SignUP
    */
    
    func loadTabar()
    {
        let storyboard: UIStoryboard = UIStoryboard(name:"Main", bundle: NSBundle.mainBundle())
        let tabBarController: UITabBarController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
        self.presentViewController(tabBarController, animated: false, completion: nil)
    }
    
    @IBAction func signupButtonTapped(sender: AnyObject)
    {
        self.performSegueWithIdentifier("SignUpSegue", sender: nil)
    }
    
    /*
    // Custom button method for forgot password
    */
    
    @IBAction func forgotPasswordButtonTapped(sender: AnyObject)
    {
        // self.displayActionSheetForCamera()
        // return;
        self.performSegueWithIdentifier("ForgotPasswordSegue", sender: nil)
    }
    
    /*
    // Custom button method for Login
    */
    
    @IBAction func loginButtonTapped(sender: AnyObject){
        
        userEmailTextField.resignFirstResponder()
        userPasswordTextField.resignFirstResponder()
        
        // loadTabar()
        // return;
        
        let username = userEmailTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let password = userPasswordTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if username.isEmpty{
            let alertController = UIAlertController (title: globalConstants.kAppName , message:globalConstants.kEmailError , preferredStyle:.Alert)
            let okayAction: UIAlertAction = UIAlertAction(title: "Ok", style: .Cancel) { action -> Void in
                //Just dismiss the action sheet
            }
            alertController.addAction(okayAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            return;
        }
        
        if password.isEmpty{
            let alertController = UIAlertController (title: globalConstants.kAppName, message: "Please enter password", preferredStyle:.Alert)
            let okayAction: UIAlertAction = UIAlertAction(title: "Ok", style: .Cancel) { action -> Void in
                //Just dismiss the action sheet
            }
            alertController.addAction(okayAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            return;
            
        }
        
        var usernameCheck = username
        
        let firstCharacter =  username.substringToIndex(username.startIndex.advancedBy(1))
        print(firstCharacter) // Check for character
        
        // Strip '+' if it exists as the first character
        if firstCharacter == "+" {
            usernameCheck = username.substringFromIndex(username.startIndex.advancedBy(1))
        }
        
        let notDigits = NSCharacterSet.decimalDigitCharacterSet().invertedSet
        
        
        if usernameCheck.rangeOfCharacterFromSet(notDigits) == nil{
            print("phone option because digits only")
            
            if username.count < 12 {
                self.displayCommonAlert(globalConstants.kEnterValidPhoneNumber)
                return;
            }
            
        }
        else {
            print("email option because no digits")
            
            if !globalConstants.isValidEmail(usernameCheck){
                self.displayCommonAlert(globalConstants.kValidEmailError)
                return;
            }
            
        }
        
        
        //        Nil --  I commented this out for some reason it was printing "Test string..." as well as returning
        
        
        
        //        NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        //        if ([newString rangeOfCharacterFromSet:notDigits].location == NSNotFound)
        //        {
        //            // newString consists only of the digits 0 through 9
        //        }
        
        
        self.performLoginAction()
    }
    
    //MARK: Temp function to check upload file on server.
    // TODO: file upload
    func uploadFileOnServer() {
//        let fileURL = NSBundle.mainBundle().URLForResource("mixriconApp_icon", withExtension: "png")
//        let URL =  globalConstants.kAPIURL + globalConstants.kProfileUpdate
//        
//        //        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders?.updateValue("application/json", forKey: "Accept")
//        
//        //        Token 2952a5dcad5181d80b79c1bc335ab91c97c03f14
//        
//        var tokenString = "token "
//        tokenString +=  "2952a5dcad5181d80b79c1bc335ab91c97c03f14"//NSUserDefaults.standardUserDefaults().objectForKey("LoginToken") as! String
//        
//        
//        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders?.updateValue(tokenString, forKey: "Authorization")
//        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders?.updateValue("attachment; filename=media_filename.png;", forKey: "Content-Disposition")
//        
//        
//        Alamofire.upload(.POST, URL, file: fileURL!)
//            .progress { bytesWritten, totalBytesWritten, totalBytesExpectedToWrite in
//                print(totalBytesWritten)
//                
//                // This closure is NOT called on the main queue for performance
//                // reasons. To update your ui, dispatch to the main queue.
//                dispatch_async(dispatch_get_main_queue()) {
//                    print("Total bytes written on main queue: \(totalBytesWritten)")
//                }
//            }
//            .responseJSON { response in
//                debugPrint(response)
//        }
    }
    
    /*
    // performLoginAction used to Call the Login API & store logged in user's data in NSUserDefault
    */
    
    func performLoginAction() {
//        let parameters = [
//            "username": userEmailTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()),
//            "password": userPasswordTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())]
        
        if let email = email, let password = password {
            APIManager.sharedInstance.loginWithEmail(email,
                                                     password: password,
                                                     success: { [weak self] (response) in
                                                            self?.loadTabar()
                }, failure: nil)
        }
        
//        let URL =  globalConstants.kAPIURL + globalConstants.kLoginAPIEndPoint
//        
//        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders?.updateValue("application/json", forKey: "Accept")
//        
//        
//        Alamofire.request(.POST, URL , parameters: parameters, encoding: .JSON)
//            .responseString { response in
//                
//                guard let value = response.result.value else {
//                    print("Error: did not receive data")
//                    return
//                }
//                
//                guard response.result.error == nil else {
//                    print("error calling POST on Login")
//                    print(response.result.error)
//                    return
//                }
//                
//                
//                let post = JSON(value)
//                if let string = post.rawString() {
//                    let responseDic:[String:AnyObject]? = self.convertStringToDictionary(string)
//                    
//                    if response.response?.statusCode == 400{
//                        print("The Response Error is:   \(response.response?.statusCode)")
//                        
//                        if let val = responseDic?["code"] {
//                            if val[0].isEqualToString("13") {
//                                //                                print("Equals")
//                                //self.displayCommonAlert(responseDic?["detail"]?[0] as! String)
//                                self.displayCommonAlert((responseDic?["detail"] as? NSArray)?[0] as! String)
//
//                                return
//                            }
//                            // now val is not nil and the Optional has been unwrapped, so use it
//                        }
//                        
//                        if let errorData = responseDic?["detail"] {
//                            
//                            let errorMessage = (errorData as? NSArray)?[0] as! String
//                            self.displayCommonAlert(errorMessage)
//                            return;
//                        }
//                    }
//                    
//                    if let tokenData = responseDic?["token"] {
//                        let tokenString = tokenData as! String
//                        NSUserDefaults.standardUserDefaults().setObject(tokenString, forKey: "LoginToken")
//                        print(tokenString)
//                        self.loadTabar()
//                    }
//                }
//        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    func textFieldDidEndEditing(textField: UITextField){
        textField.resignFirstResponder()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}

extension LoginViewController {
    override func shouldHideNavigationBar() -> Bool {
        return true
    }
}
