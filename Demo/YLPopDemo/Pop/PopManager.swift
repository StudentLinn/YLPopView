//
//  PopManager.swift
//  弹窗工具类
//
//  Created by Lin on 2023/8/10.
//

import UIKit

//MARK: 0.0.1版本

///弹窗(加载框复用同一个view,提示文本初始化后丢弃)
public let YLPop:PopManager = PopManager.share

///弹窗工具类(加载框复用同一个view,提示文本初始化后丢弃)
open class PopManager{
    ///重要方法:初始化PopConfig一次设置各个参数然后调用config方法传入,或者使用工具类中的
    ///loading,success,error三种状态方法
    ///tips信息弹窗
    public static let share = PopManager()
    
    /**
     参数列表:->
     设置->
     是否展示蒙层
     是否展示关闭按钮
     */
    
    ///当前使用弹窗(一次性修改->在loading加载之后修改即可)
    public var pop = PopView(showMask: true)
    ///配置(在下一次loading时候生效)
    public var config = PopConfig()
    ///系统弹窗
}

//MARK: 各方法
extension PopManager{
    ///传入配置
    public func config(result:PopConfig) {
        pushConfigToPop(config: result, save: true)
    }
    ///传入配置
    public func config(_ resulut:@escaping (PopConfig) -> Void){
        resulut(self.config)
    }
    
    ///加载(添加在什么view上,文字信息,关闭按钮点击回调)
    public func loading(view:UIView?, //添加在什么view上
                 text:String, //文字信息
                 exitBlock:(() -> Void)? = nil){ //关闭回调
        pushConfigToPop(config: config)
        useDo(view: view)
        pop.state = .loading
        pop.text = text
        if let block = exitBlock { pop.exitBlock = block }
    }
    
    ///成功(文字信息)
    public func success(view:UIView? = nil, //添加在什么view上,nil只更改状态
                 text:String){ //展示信息
        useDo(view: view)
        pop.state = .success
        pop.text = text
    }
    
    ///失败(文字信息)
    public func error(view:UIView? = nil, //添加在什么view上,nil只更改状态
               text:String){ //展示信息
        useDo(view: view)
        pop.state = .error
        pop.text = text
    }
    
    ///提示信息(参数->加在什么view上,文字,是否需要蒙层,是否展示蒙层,文字上左下右约束默认8,16,-8,-16)
    public func tips(view:UIView?, //加在什么view上
              text:String, //需要展示的文字
              mask:Bool = true, //是否需要蒙层
              showMask:Bool = false, //是否展示蒙层
              labTop:CGFloat = 8, //文字上方间距
              labLeading:CGFloat = 16, //文字左边间距
              labBottom:CGFloat = -8, //文字距离底部
              labTrailing:CGFloat = -16 //文字距离右边
    ){
        let tipsView = PopView(tips: text, mask: mask, showMask: showMask, top: labTop, leading: labLeading, bottom: labBottom, trailing: labTrailing)
        if let view = view {
            view.addSubview(tipsView)
            tipsView.snp.makeConstraints { make in
                make.top.leading.bottom.trailing.equalToSuperview()
            }
        }
    }
    
    ///移除弹窗
    public func removePop(animate:Bool){
        pop.removeFromSuperview()
    }
}

//MARK: 私有方法
extension PopManager{
    ///在用之前查看是否有父类
    private func useDo(view:UIView? = nil){
        //如果有指定view就移除再添加
        if let view = view {
            pop.removeFromSuperview()
            view.addSubview(pop)
            pop.snp.makeConstraints { make in
                make.top.leading.bottom.trailing.equalToSuperview()
            }
        } else { //如果传入的view为空
            //如果没有父类就添加
            if pop.superview == nil {
                UIApplication.shared.keyWindow?.addSubview(pop)
                pop.snp.makeConstraints { make in
                    make.top.leading.bottom.trailing.equalToSuperview()
                }
            }
        }
    }
    
    ///将设置的值传入
    private func pushConfigToPop(config:PopConfig, save:Bool = false){
        //如果不相等再传入数据,防止性能损耗
        if pop.state != config.state { pop.state = config.state }
        if pop.loadingImage != config.loadingImage { pop.loadingImage = config.loadingImage }
        if pop.successImage != config.successImage { pop.successImage = config.successImage }
        if pop.errorImage != config.errorImage { pop.errorImage = config.errorImage }
        if pop.exitImage != config.exitImage { pop.exitImage = config.exitImage }
        if pop.showExit != config.showExit { pop.showExit = config.showExit }
        if pop.showMask != config.showMask { pop.showMask = config.showMask }
        if pop.maskColor != config.maskColor { pop.maskColor = config.maskColor }
        if pop.userViewColor != config.userViewColor { pop.userViewColor = config.userViewColor }
        if pop.textColor != config.textColor { pop.textColor = config.textColor }
        if pop.animateTime != config.animateTime { pop.animateTime = config.animateTime }
        if pop.font != config.font { pop.font = config.font }
        if pop.maskColor != config.maskColor { pop.maskColor = config.maskColor }
        pop.exitBlock = config.exitBlock
        if pop.imageSize != config.imageSize { pop.imageSize = config.imageSize }
        if pop.labTop != config.labTop { pop.labTop = config.labTop }
        if pop.imageSize != config.imageSize { pop.imageSize = config.imageSize }
        if pop.popMinSize != config.popMinSize { pop.popMinSize = config.popMinSize }
        //如果选择了保存这次更改就保存进全局配置
        if save { self.config = config }
    }
}
