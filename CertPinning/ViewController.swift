//
//  ViewController.swift
//  CertPinning
//
//  Created by Ascra on 10/08/17.
//  Copyright © 2017 Ascracom.ascratech. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		callGetRequest()
		callCertificatePinning()
		
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func callCertificatePinning() {
		let serverTrustPolicies: [String: ServerTrustPolicy]  = [
			"github.com": .pinCertificates(
				certificates: ServerTrustPolicy.certificates(),
				validateCertificateChain: true,
				validateHost: true
			)
		]
		
		let sessionManager = SessionManager(serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
		
		sessionManager.request("https://github.com").response { response in // method defaults to `.get`
			debugPrint(response)
		}
		
	}
	
	func callGetRequest() {
		Alamofire.request("https://github.com").response { response in
			print("Request:", response.request ?? String())
			print("\n\nResponse:",response.response ?? String())

			
			if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
				print("Data: \(utf8Text)")
			}
		}
	}
	
}

