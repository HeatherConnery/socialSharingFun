//
//  ViewController.swift
//  SocialSharingFun
//
//  Created by Heather Connery on 2015-11-26.
//  Copyright © 2015 HConnery. All rights reserved.
//

import UIKit
import Social
import TwitterKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func socialShareSelected(sender: UIButton) {
        
        var socialType: String = ""
        let initialMessage = "Hello Social World"
        
        if sender.tag == 1 {
            socialType = SLServiceTypeTwitter
            print("Tweet Selected" )
        } else if sender.tag == 2 {
            socialType = SLServiceTypeFacebook
            print("Facebook selected")
        }
        if socialType.characters.count > 0 {
            let socialComposer = SLComposeViewController(forServiceType: socialType)
            socialComposer.setInitialText(initialMessage)
            
            presentViewController(socialComposer, animated: true, completion: { () -> Void in
                print("success")
            })
        }
        if sender.tag == 3 {
            // generic dont need to import social to use
            guard let url = NSURL(string: "http://google.ca") else {
                print("url should exist")
                return
            }
            let genericShareController = UIActivityViewController(activityItems: [initialMessage, url], applicationActivities: nil)
            if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Phone {
                
                presentViewController(genericShareController, animated: true, completion: { () -> Void in
                    print("presented")
                })
                
            } else if UI_USER_INTERFACE_IDIOM() == .Pad {
                let popover = UIPopoverController(contentViewController:genericShareController )
                popover.presentPopoverFromRect(sender.frame, inView: view , permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
                
            }
            
        }
       
    }
    
    
    @IBAction func logInSelected(sender: UIBarButtonItem) {
        // could get code from frabric for the twitter styled button - here we do our own 
        Twitter.sharedInstance().logInWithCompletion { (possibleSession, possibleError) -> Void in
            if let error = possibleError {
                print("\(error.localizedDescription)")
            }
            guard let session = possibleSession else {
                return}
            print("Successfully authenticalted sission: \(session)")
            }
        }
    }


