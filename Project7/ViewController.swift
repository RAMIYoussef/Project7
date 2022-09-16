//
//  ViewController.swift
//  Project7
//
//  Created by Mymac on 14/9/2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var petitionsFiltred : [Petition]?
    var arrayOfPetitions = [[Petition]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let urlString : String
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showCredit))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filterTapped))
        if navigationController?.tabBarItem.tag == 0{
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }else{
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        //        getJSON(urlString: urlString) { (ts : Petitions?) in
        //            if let ts = ts {
        //                self.petitions = ts.results
        //                DispatchQueue.main.async {
        //                    self.tableView.reloadData()
        //                }
        //            }
        //        }
        getjson(urlString)
        
        //        let stringfilter : String
        //
        //        petitionsFiltred = petitions.filter({ petitions in
        //            petitions.title.contains(stringfilter)
        //        })
        //
        
        
        
    }
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        arrayOfPetitions.count
    //    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let petitionsFiltred = petitionsFiltred {
            return petitionsFiltred.count
        }else {return petitions.count }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition : Petition
        if let petitionsFiltred = petitionsFiltred{
            petition = petitionsFiltred[indexPath.row]
        }else{
            petition = petitions[indexPath.row]
        }
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BodyVC()
        let petition : Petition
        if let petitionsFiltred = petitionsFiltred{
            petition = petitionsFiltred[indexPath.row]
        }else{
            petition = petitions[indexPath.row]
        }
        vc.detailItem = petition
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    func getjson(_ urlString : String){
        guard let url = URL(string: urlString) else {
            showError()
            return  }
        if let dadajson = try? Data(contentsOf: url){
            parse(from: dadajson)
            return
        }
        showError()
    }
    func parse(from json : Data){
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            //            arrayOfPetitions.append(petitions)
            tableView.reloadData()
            return
        }
        showError()
    }
    //    func getJSON<T: Decodable>(urlString: String, compeltion: @escaping (T?)-> Void) {
    //
    //        guard let url = URL(string: urlString) else {
    //            print("the url is not valid")
    //            showError()
    //            return
    //        }
    //        let urlRequest = URLRequest(url: url)
    //        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
    //            if error != nil {
    //                compeltion(nil)
    //                self.showError()
    //                return
    //            }
    //            guard let data = data else {
    //                compeltion(nil)
    //                self.showError()
    //                return
    //            }
    //            let decoder = JSONDecoder()
    //            guard let decodedata = try? decoder.decode(T.self, from: data) else {
    //                compeltion(nil)
    //                self.showError()
    //                return
    //            }
    //            compeltion(decodedata)
    //        }.resume()
    //
    //    }
    
    func showError(){
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showCredit(){
        let ac = UIAlertController(title:"Credit", message: "the data comes from the We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler:  nil))
        present(ac, animated: true)
    }
    @objc func filterTapped(){
        let ac = UIAlertController(title: "Filter the petitions", message:"Enter your keywords to filter", preferredStyle: .alert)
        ac.addTextField()
        let filterAction = UIAlertAction(title: "Filter", style: .default) { [weak self,weak ac] action in
            guard let keyword = ac?.textFields?[0].text else {return}
            self?.filter(keyword)
        }
        ac.addAction(filterAction)
        present(ac, animated: true)
    }
    func filter(_ keyword : String){
        if keyword == "" {
            petitionsFiltred = petitions
        }else{
            petitionsFiltred = petitions.filter({ petition in
                petition.body.contains(keyword) || petition.title.contains(keyword)
            })
        }
        
        // arrayOfPetitions.append(petitionsFiltred)
        self.tableView.reloadData()
    }
    
}

