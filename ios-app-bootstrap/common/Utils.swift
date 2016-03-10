//
//  Utils.swift
//  ios-app-bootstrap
//
//  Created by xdf on 9/4/15.
//  Copyright (c) 2015 open source. All rights reserved.
//

import UIKit
import SwiftyJSON

class Utils: NSObject {

    class func getImgView(ImgName: NSString)->UIImage{
        
        var image:UIImage = UIImage(named: ImgName as String)!
        
        image = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        return image
    }
    
    class func matchesForRegexInText(regex: String!, text: String!) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = text as NSString
            let results = regex.matchesInString(text,
                options: [], range: NSMakeRange(0, nsString.length))
            return results.map { nsString.substringWithRange($0.range)}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    class func parseQuery(querystring: String) -> [String: String] {
        var query = [String: String]()
        
        for qs in querystring.componentsSeparatedByString("&") {
            let key = qs.componentsSeparatedByString("=")[0]
            var value = qs.componentsSeparatedByString("=")[1]
            value = value.stringByReplacingOccurrencesOfString("+", withString: " ")
            value = value.stringByRemovingPercentEncoding!
            query[key] = value
        }
        return query
    }
    
    class func getValueFromQuery(queryStrings: [String: String], key: String) -> String {
        let data = String(queryStrings["data"]!)
        let dataString = data.stringByRemovingPercentEncoding!
        let _dataString = dataString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let json = JSON(data: _dataString!)
        let value = String(json[key])
        return value
    }
    
    class func test(reg: String, content: String) -> Bool {
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", reg)
        return Bool(regextestmobile.evaluateWithObject(content))
    }
    
    class func isMobileNo(content: String) -> Bool {
        return test("^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$", content: content)
    }
    
    class func debug(content: String) {
        print("debug: " + content)
    }
    
    class func parseJSON(string: String) -> AnyObject {
        do {
            let data = string.dataUsingEncoding(NSUTF8StringEncoding)
            let res = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
            return res
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return false
    }
    
    class func trim(string: String) -> String {
        let res = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        return res
    }
    
    class func getRGB (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
        
        let rString = (cString as NSString).substringToIndex(2)
        let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    class func getValueFromQueue(queryStrings: [String: String], key: String) -> String {
        let data = String(queryStrings["data"]!)
        let dataString = data.stringByRemovingPercentEncoding!
        let _dataString = dataString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let json = JSON(data: _dataString!)
        let value = String(json[key])
        return value
    }
    
    class func getData(key: String) -> String {
        let temp = NSUserDefaults.standardUserDefaults()
        let value = temp.objectForKey(key)
        
        if (value != nil) {
            return String(value!)
        } else {
            return "nil"
        }
    }
    
    class func hasData(key: String) -> Bool {
        let temp = self.getData(key)
        return temp != "nil"
    }
    
    class func setData(key: String, value: String) {
        removeData(key)
        let temp = NSUserDefaults.standardUserDefaults()
        temp.setObject(value, forKey: key)
        temp.synchronize()
    }
    
    class func removeData(key: String) {
        let temp = NSUserDefaults.standardUserDefaults()
        temp.removeObjectForKey(key)
        temp.synchronize()
    }
}
