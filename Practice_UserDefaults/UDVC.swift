//
//  UDVC.swift
//  Practice_UserDefaults
//
//  Created by 이병훈 on 2021/05/26.
//

import UIKit

class UDVC: UITableViewController {
    
    @IBOutlet weak var forName: UILabel!
    @IBOutlet weak var alaramSW: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alaramSW.isOn = UserDefaults.standard.bool(forKey: "알림")
        self.forName.text = UserDefaults.standard.string(forKey: "이름")
    }
    
    @IBAction func alaram(_ sender: UISwitch) {
        if sender.isOn == true {
            UserDefaults.standard.setValue(true, forKey: "알림")
        } else {
            UserDefaults.standard.setValue(false, forKey: "알림")
        }
        UserDefaults.standard.synchronize()
    }
}

extension UDVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let alert = UIAlertController(title: "이름을 적어주세요", message: nil, preferredStyle: .alert)
            alert.addTextField(){ (tf) in
                tf.placeholder = "이름을 적어주세요"
                tf.layer.cornerRadius = 0
            }
            
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                if let txt = alert.textFields?[0]{
                    if txt.text?.isEmpty == false {
                        self.forName.text = txt.text!
                        UserDefaults.standard.setValue(txt.text!, forKey: "이름")
                    } else {
                    self.forName.text = "이름을 입력안해줬댜"
                        self.forName.font = UIFont.systemFont(ofSize: 10)
                    UserDefaults.standard.setValue(self.forName.text, forKey: "이름")
                }
                    self.forName.sizeToFit()
                    UserDefaults.standard.synchronize()
                }
            })
            self.present(alert, animated: true)
        }
    }
}
