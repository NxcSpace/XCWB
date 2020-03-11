//
//  DataManager.swift
//  NetWorkDemo
//
//  Created by nxc on 2020/3/5.
//  Copyright © 2020 nxc. All rights reserved.
//


import Foundation
import Alamofire
typealias ResponseSuccess = (_ resopnse: String) -> Void
typealias ResponseFail = (_ error: String) -> Void

class DataManager: NSObject {
    //单例
    static let manager: DataManager = DataManager()
    private var sessionManager: Session?
    
    // MARK: - 初始化
    override init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        sessionManager = Session.init(configuration: configuration, delegate: SessionDelegate.init(), serverTrustManager: nil)
    }
    
}

// MARK: - 业务
extension DataManager{
    // MARK: - 请求token
    public func loadAccessToken(code: String,
                                 success: @escaping ResponseSuccess,
                                 fail: @escaping ResponseFail){
        xc_postWith(url: "https://api.weibo.com/oauth2/access_token", params: ["client_id":app_key,
                                                                               "client_secret":app_secret,
                                                                               "grant_type":"authorization_code","code":code,
                                                                               "redirect_uri":redirect_uri], success: success, fail: fail)
    }

    // MARK: - 请求个人信息
    public func loadUserInfo(userInfo: UserAccount,
                             success:@escaping ResponseSuccess,
                             fail: @escaping ResponseFail) {
        guard let token = userInfo.access_token else {
            return
        }
        guard let uid = userInfo.uid else {
            return
        }
        let params = ["access_token":token,
                      "uid":uid]
    
        xc_getWith(url: "https://api.weibo.com/2/users/show.json", params: params, success: success, fail: fail)
    }
    
    public func loadStatuses(since_id: Int,
                             max_id: Int,
                             page: Int,
                             count: Int,
                             success:@escaping ResponseSuccess,
                             fail: @escaping ResponseFail) {
       
        guard let token = UserAccountViewModal.shareIntance.userInfo?.access_token else {
            return
        }
       
        let params = ["access_token":token,
                      "max_id":max_id,
                      "since_id":since_id,
                      "page":page,
                      "count":count] as [String : Any]
    
        xc_getWith(url: "https://api.weibo.com/2/statuses/home_timeline.json", params: params, success: success, fail: fail)
    }
    
    public func sendStatuses(statusText : String,
                             success:@escaping ResponseSuccess,
                             fail: @escaping ResponseFail) {
       
        guard let token = UserAccountViewModal.shareIntance.userInfo?.access_token else {
            return
        }
        let wbStatus = "\(statusText)  http://www.xcwb.com/"
        
        
        let params = ["access_token":token,
                      "status":wbStatus,
                      ] as [String : Any]
    
        xc_postWith(url: "https://api.weibo.com/2/statuses/share.json", params: params, success: success, fail: fail)
    }
     public   func uploadImage(statusText : String,
                       image : UIImage,
                       success:@escaping ResponseSuccess,
                       fail: @escaping ResponseFail){
            var header = HTTPHeaders()
            header.add(name: "content-type", value: "multipart/form-data")
        guard let token = UserAccountViewModal.shareIntance.userInfo?.access_token else {
                   return
               }
         let wbStatus = "\(statusText)  http://www.xcwb.com/"
               
               
               let params = ["access_token":token,
                             "status":wbStatus,
                             ] as [String : Any]
        
            AF.upload(multipartFormData: { (formData) in
                
                if let imageData = image.jpegData(compressionQuality: 0.5) {
                    for p in params {
                               formData.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
                           }
                    formData.append(imageData, withName: "pic", fileName:  "123.png", mimeType: "image/png")
                }
                
            }, to: URL(string: "https://api.weibo.com/2/statuses/share.json")!, usingThreshold: MultipartFormData.encodingMemoryThreshold, method: .post, headers: header, interceptor: nil, fileManager: .default).responseJSON { (response) in
                switch response.result {
                case .success:
                    let json = String(data: response.data!, encoding: String.Encoding.utf8)
                    success(json ?? "")
                case .failure:
                    let statusCode = response.response?.statusCode
                    fail("\(statusCode ?? 0)请求失败")
                    debugPrint(response.response as Any)
                }
            }
            
        }
    
}


// MARK: - 请求公共方法
extension DataManager {
    // MARK: - get请求
    public func xc_getWith(url: String,
                 params: [String: Any]?,
                 success: @escaping ResponseSuccess,
                 fail: @escaping ResponseFail){
        requestWith(url: url, httpMethod: 0, params: params, success: success, error: fail)
        
    }
    // MARK: - post请求
    public func xc_postWith(url: String,
                  params: [String: Any]?,
                  success: @escaping ResponseSuccess,
                  fail: @escaping ResponseFail){
        
        requestWith(url: url, httpMethod: 1, params: params, success: success, error: fail)
        
    }
}

// MARK: - 请求业务逻辑处理
extension DataManager {
    private func requestWith(url: String,
                             httpMethod: Int32,
                             params: [String: Any]?,
                             success: @escaping ResponseSuccess,
                             error: @escaping ResponseFail) {
        //get
        if httpMethod == 0 {
            manageGet(url: url, params: params, success: success, error: error)
        } else {
            managePost(url: url, params: params!, success: success, error: error)
        }
    }
    
     private func manageGet(url: String,
                            params: [String: Any]?,
                            success: @escaping ResponseSuccess,
                            error: @escaping ResponseFail) {
         //请求头信息
         //            var header = HTTPHeaders()
         //            header.add(name: "dragon-system", value: FSRequestData.share.getHeaderJson())
         AF.request(url,
                    method: .get,
                    parameters: params,
                    encoding: URLEncoding.default,
                    headers: nil).responseJSON { (response) in
                     switch response.result {
                     case .success:
                         let json = String(data: response.data!, encoding: String.Encoding.utf8)
                         success(json ?? "")
                     case .failure:
                         let statusCode = response.response?.statusCode
                         error("\(statusCode ?? 0)请求失败")
                         debugPrint(response.response as Any)
                     }
         }
     }
     
     private func managePost(url: String,
                             params: [String: Any],
                             success: @escaping ResponseSuccess,
                             error: @escaping ResponseFail) {
        
         //请求头信息
         //var header = HTTPHeaders()
         //header.add(name: "dragon-system", value: FSRequestData.share.getHeaderJson())
         AF.request(url,
                    method: .post,
                    parameters: params,
                    encoding: URLEncoding.default,
                    headers: nil).responseJSON { (response) in
                     switch response.result {
                     case .success:
                         let json = String(data: response.data!, encoding: String.Encoding.utf8)
                         success(json ?? "")
                     case .failure:
                         let statusCode = response.response?.statusCode
                         error("\(statusCode ?? 0)请求失败")
                         debugPrint(response.response as Any)
                     }
         }
     }
     
}
