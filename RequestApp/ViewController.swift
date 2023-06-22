//
//  ViewController.swift
//  RequestApp
//
//  Created by Serj on 20.06.2023.
//

import UIKit
struct Result: Codable {
    let data: [User]
}

// MARK: - Datum
struct User: Codable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

 final class ViewController: UIViewController {

    @IBOutlet weak var FisrstTF: UITextField!
    
    @IBOutlet weak var SecondTF: UITextField!
    
    @IBOutlet weak var ResultTV: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func fetchData(for url: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: url) else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard  let data else { return }
            DispatchQueue.main.async {
                completion(data)
            }
        } .resume()
    }
    
    @IBAction func GetUsersPressed(_ sender: Any) {
        fetchData(for: "https://reqres.in/api/users?page=2") { data in
            let users = (try? JSONDecoder().decode(Result.self, from: data).data) ?? []
            self.ResultTV.text = "\(users)"
        }
//        guard let url = URL(string: "https://reqres.in/api/users?page=2") else {return}
//        let request = URLRequest(url: url)
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data else { return }
//            let users = (try? JSONDecoder().decode(Result.self, from: data).data) ?? []
//            DispatchQueue.main.async {
//                self.ResultTV.text = "\(users)"//.map { $0.firstName }.joined(separator: ", ")
//            }
//        } .resume()
    }
    @IBAction func CreateUserPressed(_ sender: Any) {
        guard let url = URL(string: "https://reqres.in/api/users") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let name = FisrstTF.text ?? ""
        let job = SecondTF.text ?? ""
        var dict = [String:String]()
        dict["name"] = name
        dict["job"] = job
        let data = try? JSONSerialization.data(withJSONObject: dict)
        
        request.httpBody = data
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {return}
            let string = String(decoding: data, as: UTF8.self)
            DispatchQueue.main.async {
                self.ResultTV.text = string
            }
        } .resume()
    }
    @IBAction func RegisterUserPressed(_ sender: Any) {
        guard let url = URL(string: "https://reqres.in/api/register") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let email = FisrstTF.text ?? ""
        let pass = SecondTF.text ?? ""
        var dict = [String:String]()
        dict["email"] = email
        dict["password"] = pass
        let data = try? JSONSerialization.data(withJSONObject: dict)
        request.httpBody = data
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {return}
            let string = String(decoding: data, as: UTF8.self)
            DispatchQueue.main.async {
                self.ResultTV.text = string
            }
        } .resume()
        
    }
    
    @IBAction func Login(_ sender: Any) {
        guard let url = URL(string: "https://reqres.in/api/users/7") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        let name = "Michael"
        let job = SecondTF.text ?? ""
        var dict = [String:String]()
        dict["name"] = name
        dict["job"] = job
        let data = try? JSONSerialization.data(withJSONObject: dict)
        request.httpBody = data
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {return}
            let string = String(decoding: data, as: UTF8.self)
            DispatchQueue.main.async {
                self.ResultTV.text = string
            }
        } .resume()
    }
}

