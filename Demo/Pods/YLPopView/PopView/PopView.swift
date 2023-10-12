//
//  PopView.swift
//  PopTest
//
//  Created by Lin on 2023/8/10.
//

import UIKit
import SnapKit

///加载状态
public enum popState {
    ///加载中
    case loading
    ///成功
    case success
    ///失败
    case error
}

///弹窗
///(初始化两种方法)
///->带图片(自定义间距)
///->不带图片提示文本(2秒后消失)
public class PopView: UIView {
/**
 - Parameters
 参数列表:
    当前状态
 图片->
    加载图片
    成功图片
    失败图片
    关闭图片
    图片大小
 ----------
 设置->
     是否展示关闭按钮
     是否开启蒙层
     蒙层颜色
     交互框颜色
     字体颜色
     动画移除时长
     字体大小
     回调->
     关闭回调
 ----------
 间距->
     文字距离图片底部
     加载框最小宽高
*/
    
    /**
     图层 ---------->
        图片
        提示文本
            交互框
        关闭按钮
     */
    //MARK: 图片->
    ///当前状态
    public var state:popState = .loading { didSet { changeState() } }
    ///加载图片
    public var loadingImage:UIImage?
    ///成功图片
    public var successImage:UIImage?
    ///失败图片
    public var errorImage:UIImage?
    ///关闭图片
    public var exitImage:UIImage? { didSet { exitBtn.setImage(exitImage, for: .normal) } }
    ///图片宽高
    public var imageSize:CGSize = CGSize(width: 40, height: 40) {
        didSet {
            if stateImv.superview != nil {
                stateImv.snp.updateConstraints { make in
                    make.width.equalTo(imageSize.width)
                    make.height.equalTo(imageSize.height)
                }
            }
        }
    }
    
    //MARK: 设置
    ///是否展示关闭按钮
    public var showExit:Bool = false { didSet { exitBtn.isHidden = !showExit } }
    ///是否开启蒙层
    public var showMask:Bool = false {
        didSet {
            //如果展示就改背景色为蒙层色
            if showMask { backgroundColor = maskColor }
            else { backgroundColor = .clear }
        }
        
    }
    ///蒙层颜色
    public var maskColor:UIColor = .black.withAlphaComponent(0.5) { didSet { backgroundColor = maskColor } }
    ///交互框颜色
    public var userViewColor:UIColor = .black.withAlphaComponent(0.7) { didSet { userView.backgroundColor = userViewColor } }
    ///文字
    public var text:String = "" { didSet { tipsLab.text = text } }
    ///字体颜色
    public var textColor:UIColor = .white { didSet { tipsLab.textColor = textColor } }
    ///字体大小
    public var font:UIFont = .systemFont(ofSize: 14, weight: .regular) { didSet { tipsLab.font = font } }
    ///动画时长
    public var animateTime:TimeInterval = 2
    ///关闭回调
    public var exitBlock:(() -> Void)?
    
    //MARK: 间距
    ///文字距离图片底部
    public var labTop:CGFloat = 16 {
        didSet {
            if tipsLab.superview != nil {
                tipsLab.snp.updateConstraints { make in
                    make.top.equalTo(stateImv.snp.bottom).offset(labTop)
                }
            }
        }
    }
    
    ///加载框最小宽高
    public var popMinSize:CGSize = CGSize(width: 250, height: 150) {
        didSet {
            if userView.superview != nil {
                userView.snp.updateConstraints { make in
                    make.width.greaterThanOrEqualTo(popMinSize.width)
                    make.height.greaterThanOrEqualTo(popMinSize.height)
                }
            }
        }
    }
    
    //MARK: 控件
    ///用户交互框
    private lazy var userView:UIView = {
        let view = UIView()
        //背景色透明度0.7
        view.backgroundColor = userViewColor
        view.layer.cornerRadius = 8
        return view
    }()
    ///当前状态图片展示
    private lazy var stateImv = UIImageView(image: loadingImage)
    ///当前提示文本
    private lazy var tipsLab:UILabel = {
        let lab = UILabel()
        lab.font = font
        lab.textColor = textColor
        lab.numberOfLines = 0
        lab.textAlignment = .center
        return lab
    }()
    ///右上角关闭按钮
    private lazy var exitBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(exitImage, for: .normal)
        btn.addTarget(self, action: #selector(exitBtnClick), for: .touchUpInside)
        btn.isHidden = !showExit
        return btn
    }()
    
    //MARK: 入口
    ///图片初始化(参数:->是否展示蒙层)
    public init (showMask:Bool = false){
        super.init(frame: .zero)
        
        self.showMask = showMask
        inUI()
        inConstraints()
    }
    ///提示文本初始化(参数->提示信息,是否蒙层,是否展示蒙层,文字间距上左下右默认8,16,-8,-16,动画移除时间)
    public init (tips:String, //提示信息
                 mask:Bool, //是否蒙层
                 showMask:Bool, //是否展示蒙层
                 top:CGFloat = 8, //文字间距上
                 leading:CGFloat = 16, //左
                 bottom:CGFloat = -8, //下
                 trailing:CGFloat = -16, //右
                 animateTime:TimeInterval = 2 //动画移除时间
    ) {
        super.init(frame: .zero)
        //透明色
        backgroundColor = .clear
        //显示蒙层
        self.showMask = showMask
        //更改文字
        tipsLab.text = tips
        addSubview(userView)
        userView.addSubview(tipsLab)
        userView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        tipsLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(top)
            make.leading.equalToSuperview().offset(leading)
            make.bottom.equalToSuperview().offset(bottom)
            make.trailing.equalToSuperview().offset(trailing)
        }
        removeWithAnimate(time: animateTime)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

//MARK: UI
extension PopView{
    ///添加控件
    private func inUI(){
        addSubview(userView)
        userView.addSubview(stateImv)
        userView.addSubview(tipsLab)
        userView.addSubview(exitBtn)
    }
    
    ///添加约束
    private func inConstraints(){
        //用户交互view
        userView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.greaterThanOrEqualTo(popMinSize.width)
            make.height.greaterThanOrEqualTo(popMinSize.height)
        }
        
        //加载状态图片
        stateImv.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(34)
            make.width.equalTo(imageSize.width)
            make.height.equalTo(imageSize.height)
            make.centerX.equalToSuperview()
        }
        
        //提示文本
        tipsLab.snp.makeConstraints { make in
            make.top.equalTo(stateImv.snp.bottom).offset(labTop)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.greaterThanOrEqualToSuperview().offset(-8)
        }
        
        //关闭按钮
        exitBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.width.height.equalTo(24)
        }
    }
    
    ///状态改变
    private func changeState(){
        switch state {
        case .loading: //加载状态
            //开始旋转
            let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
            rotationAnim.fromValue = 0
            rotationAnim.toValue = Double.pi * 2
            rotationAnim.repeatCount = MAXFLOAT
            rotationAnim.duration = 2
            stateImv.layer.add(rotationAnim, forKey: "transform.rotation.z")
            stateImv.image = loadingImage
        case .success: //加载成功
            stateImv.layer.removeAnimation(forKey: "transform.rotation.z")
            stateImv.image = successImage
            removeWithAnimate(time: animateTime)
        case .error: //加载失败
            stateImv.layer.removeAnimation(forKey: "transform.rotation.z")
            stateImv.image = errorImage
            removeWithAnimate(time: animateTime)
        }
    }
    
    ///带动画移除
    private func removeWithAnimate(time:CGFloat){
        UIView.animate(withDuration: time) {
            self.alpha = 0
        } completion: { bool in
            self.removeFromSuperview()
            self.alpha = 1
        }
    }
}

//MARK: 事件
extension PopView{
    ///点击关闭
    @objc private func exitBtnClick(){ 
        self.removeFromSuperview()
        if let block = exitBlock { block() }
    }
}
