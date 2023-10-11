//
//  TestController.swift
//  YLPopDemo
//
//  Created by Lin on 2023/10/11.
//

import UIKit

class TestController: UIViewController {
    //MARK: 数据相关
    
    //MARK: 控件相关
    ///测试按钮
    lazy var testBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("点我", for: .normal)
        btn.backgroundColor = .gray
        btn.addTarget(self, action: #selector(testBtnClick(btn: )), for: .touchUpInside)
        btn.tag = 1
        return btn
    }()
    
    ///测试蒙层状态下点击
    lazy var maskBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("蒙层测试", for: .normal)
        btn.addTarget(self, action: #selector(maskBtnClick), for: .touchUpInside)
        btn.backgroundColor = .gray
        return btn
    }()
    
    
    
    //MARK: 入口
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //view
        view.backgroundColor = .white
        
        //控件
        view.addSubview(testBtn)
        //蒙层测试控件
        view.addSubview(maskBtn)
        testBtn.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.center.equalToSuperview()
        }
        
        maskBtn.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(200)
        }
        //MARK: 方法一定义一个
        //定义一个新的配置文件
//        var config = PopConfig()
//        //加载图片设置
//        config.loadingImage = UIImage(named: "PopLoading")
//        //失败图片设置
//        config.errorImage = UIImage(named: "PopError")
//        //成功图片设置
//        config.successImage = UIImage(named: "PopSuccess")
//        //传入设置
//        PopManager.share.config(result: config)
//        //MARK: 方法二
//        //全局设置报错图片
//        PopManager.share.config.errorImage = UIImage(named: "PopError")
//
//        PopManager.share.loading(view: UIApplication.shared.keyWindow ?? UIView(), text: "加载中")
//        //MARK: 在开始加载后单次设置弹窗的属性(开始加载后可以设置),在每次
//        PopManager.share.PopView.font = .systemFont(ofSize: 30, weight: .regular)
        //MARK: 方法三 block全局配置
        YLPop.config { config in
            config.loadingImage = UIImage(named: "PopLoading")
            config.errorImage = UIImage(named: "PopError")
            config.successImage = UIImage(named: "PopSuccess")
            config.font = .systemFont(ofSize: 13, weight: .regular)
            config.maskColor = .black.withAlphaComponent(0.5)
        }
    }


}

//MARK: 事件
extension TestController{
    ///测试按钮点击
    @objc func testBtnClick(btn:UIButton){
        if btn.tag == 1 {
//            PopManager.share.loading(view: UIApplication.shared.keyWindow ?? UIView(), text: "加载中测试")
            YLPop.loading(view: UIApplication.shared.keyWindow ?? UIView(), text: "加载中")
            YLPop.pop.font = .systemFont(ofSize: 30)
            UIView.animate(withDuration: 2) {
                btn.alpha = 0
            } completion: { bool in
                PopManager.share.success(text: "测试成功")
                btn.alpha = 1
                btn.tag = 2
            }
        } else if btn.tag == 2 {
            PopManager.share.loading(view: UIApplication.shared.keyWindow ?? UIView(), text: "加载中测试")
            UIView.animate(withDuration: 2) {
                btn.alpha = 0
            } completion: { bool in
                PopManager.share.error(text: "测试失败")
                btn.alpha = 1
                btn.tag = 3
            }
        } else {
            PopManager.share.tips(view: UIApplication.shared.keyWindow ?? UIView(), text: "测试弹窗")
            btn.tag = 1
        }
    }
    
    ///蒙层测试按钮点击
    @objc func maskBtnClick(){
        print("蒙层按钮点击")
    }
}
