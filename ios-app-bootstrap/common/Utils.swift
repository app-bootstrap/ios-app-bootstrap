//
//  Utils.swift
//  ios-app-bootstrap
//
//  Created by xdf on 9/4/15.
//  Copyright (c) 2015 open source. All rights reserved.
//

import UIKit

class Utils: NSObject {

    class func getImgView(_ ImgName: NSString)->UIImage{
        var image:UIImage = UIImage(named: ImgName as String)!
        image = image.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        return image
    }
    
    class func matchesForRegexInText(_ regex: String!, text: String!) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = text as NSString
            let results = regex.matches(in: text,
                options: [], range: NSMakeRange(0, nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    class func test(_ reg: String, content: String) -> Bool {
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", reg)
        return Bool(regextestmobile.evaluate(with: content))
    }
    
    class func isMobileNo(_ content: String) -> Bool {
        return test("^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$", content: content)
    }
    
    class func debug(_ content: String) {
        print("debug: " + content)
    }
    
    class func parseJSON(_ string: String) -> AnyObject {
        do {
            let data = string.data(using: String.Encoding.utf8)
            let res = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
            return res as AnyObject
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return false as AnyObject
    }
    
    class func trim(_ string: String) -> String {
        let res = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return res
    }
    
    class func getRGB (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    class func getData(_ key: String) -> String {
        let temp = UserDefaults.standard
        let value = temp.object(forKey: key)
        
        if (value != nil) {
            return String(describing: value!)
        } else {
            return "nil"
        }
    }
    
    class func hasData(_ key: String) -> Bool {
        let temp = self.getData(key)
        return temp != "nil"
    }
    
    class func setData(_ key: String, value: String) {
        removeData(key)
        let temp = UserDefaults.standard
        temp.set(value, forKey: key)
        temp.synchronize()
    }
    
    class func removeData(_ key: String) {
        let temp = UserDefaults.standard
        temp.removeObject(forKey: key)
        temp.synchronize()
    }
    
    class func getValueFromQuery(_ queryStrings: String, key: String) -> String {
        let dataString = queryStrings.removingPercentEncoding
        let _dataString = dataString?.data(using: String.Encoding.utf8, allowLossyConversion: false)
        let json = try! JSONSerialization.jsonObject(with: _dataString!) as? NSDictionary
        let res: String = json?.value(forKey: key) as! String
        return res
    }
    
    class func parseQuery(_ querystring: String) -> [String: String] {
        var query = [String: String]()
        for qs in querystring.components(separatedBy: "&") {
            let key = qs.components(separatedBy: "=")[0]
            let value = qs.components(separatedBy: "=")[1]
            query[key] = value
        }
        return query
    }
  
    class func dataHubAdapter(_ APIName: String) -> String {
      let url = "\(Const.DATAHUB_HOST)/data/\(Const.DATAHUB_HUBNAME_1)/\(APIName)"
      return url
    }
    
    class Path {
        
        static func basename(_ path: String) -> String {
            return ((path as NSString).lastPathComponent as NSString).deletingPathExtension
        }
        
        static func dirname(_ path: String) -> String {
            return (path as NSString).deletingLastPathComponent
        }
        
        static func extname(_ path: String) -> String {
            return (path as NSString).pathExtension
        }
    }
}
