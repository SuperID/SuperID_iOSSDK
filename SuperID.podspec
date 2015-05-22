Pod::Spec.new do |s|

  s.name         = "SuperID"
  s.version      = "1.2.7"
  s.summary      = "SuperID SDK FaceLogin 为iOS、Android应用提供「刷脸登录」功能，简化注册、登录流程"

  s.description  = <<-DESC
                   为iOS、Android应用提供「刷脸登录」功能，简化注册、登录流程
                   一登 SDK 为应用提供了便捷的刷脸登录模式。通过一登账号体系，移动终端用户可快速登录开发者应用。同时，一登 SDK 提供了人脸属性高级功能，让移动开发者可以基于人脸属性，为应用做更精准的数据推送
                   DESC

  s.homepage     = "http://superid.me"

  s.license      = { :type => "Copyright", :text => "LICENSE Copyright 2015 superid.me, Inc. All rights reserved." }
  s.author       = { "SuperID" => "contact@superid.me" }

  s.platform     = :ios,"7.0"

  s.source       = { :git => "https://github.com/SuperID/SuperID_iOSSDK.git", :tag => "1.2.7" }
  s.source_files  = "SuperID_SDK/*.h"
  s.preserve_paths = "SuperID_SDK/*.a"
  s.resources = "SuperID_SDK/*.bundle"
  s.frameworks  = "AVFoundation", "CoreMedia", "CoreTelephony", "libc++"
  s.requires_arc = true
  s.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC -lstdc++' }
end
