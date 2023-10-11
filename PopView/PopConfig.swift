//
//  PopConfig.swift
//  弹窗配置
//
//  Created by Lin on 2023/8/10.
//

import UIKit

///配置文件
public class PopConfig {
    ///当前状态
    public var state:popState = .loading
    ///加载图片
    public var loadingImage:UIImage?
    ///成功图片
    public var successImage:UIImage?
    ///失败图片
    public var errorImage:UIImage?
    ///关闭图片
    public var exitImage:UIImage?
    ///图片宽高
    public var imageSize:CGSize = CGSize(width: 40, height: 40)
    
    //MARK: 设置
    ///是否展示关闭按钮
    public var showExit:Bool = false
    ///是否开启蒙层
    public var showMask:Bool = false
    ///蒙层颜色
    public var maskColor:UIColor = .black.withAlphaComponent(0.5)
    ///交互框颜色
    public var userViewColor:UIColor = .black.withAlphaComponent(0.7)
    ///字体颜色
    public var textColor:UIColor = .white
    ///字体大小
    public var font:UIFont = .systemFont(ofSize: 14, weight: .regular)
    ///时长
    public var animateTime:TimeInterval = 2
    ///关闭回调
    public var exitBlock:(() -> Void)?
    
    //MARK: 间距
    ///文字距离图片底部
    public var labTop:CGFloat = 16
    ///加载框最小宽高
    public var popMinSize:CGSize = CGSize(width: 250, height: 150)
    
    public init(){}
    
    ///传值
    public func copyNewConfig() -> PopConfig {
        let config = PopConfig()
        if config.state != self.state { config.state = self.state }
        if config.loadingImage != self.loadingImage { config.loadingImage = self.loadingImage }
        if config.successImage != self.successImage { config.successImage = self.successImage }
        if config.errorImage != self.errorImage { config.errorImage = self.errorImage }
        if config.exitImage != self.exitImage { config.exitImage = self.exitImage }
        if config.showExit != self.showExit { config.showExit = self.showExit }
        if config.showMask != self.showMask { config.showMask = self.showMask }
        if config.maskColor != self.maskColor { config.maskColor = self.maskColor }
        if config.userViewColor != self.userViewColor { config.userViewColor = self.userViewColor }
        if config.textColor != self.textColor { config.textColor = self.textColor }
        if config.animateTime != self.animateTime { config.animateTime = self.animateTime }
        if config.font != self.font { config.font = self.font }
        config.exitBlock = self.exitBlock
        if config.maskColor != self.maskColor { config.maskColor = self.maskColor }
        if config.imageSize != self.imageSize { config.imageSize = self.imageSize }
        if config.labTop != self.labTop { config.labTop = self.labTop }
        if config.imageSize != self.imageSize { config.imageSize = self.imageSize }
        if config.popMinSize != self.popMinSize { config.popMinSize = self.popMinSize }
        return config
    }
}
