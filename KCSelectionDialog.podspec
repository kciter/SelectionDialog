Pod::Spec.new do |s|
  s.name         = "KCSelectionDialog"
  s.version      = "0.0.2"
  s.summary      = "Simple selection dialog"
  s.homepage     = "https://github.com/kciter/KCSelectionDialog"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "kciter" => "kciter@naver.com" }
  s.source       = { :git => "https://github.com/kciter/KCSelectionDialog.git", :tag => "#{s.version}" }
  s.platform     = :ios, '8.0'
  s.source_files = 'KCSelectionDialog/*.{swift}'
  s.frameworks   = 'UIKit', 'Foundation'
  s.requires_arc = true
end
