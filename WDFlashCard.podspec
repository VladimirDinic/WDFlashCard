Pod::Spec.new do |s|

s.platform = :ios
s.name             = "WDFlashCard"
s.version          = "0.0.1"
s.summary          = "WDFlashCard is a simple lightweight component for displaying flashcards inside iOS apps."

s.description      = <<-DESC
This library enables you to setup expandable table view in several simple steps.
DESC

s.homepage         = "https://github.com/VladimirDinic/WDFlashCard"
s.license          = { :type => "MIT", :file => "LICENSE" }
s.author           = { "Vladimir Dinic" => "vladimir88dev@gmail.com" }
s.source           = { :git => "https://github.com/VladimirDinic/WDFlashCard.git", :tag => "#{s.version}"}

s.ios.deployment_target = "10.0"
s.source_files = "WDFlashCard/WDFlashCard/WDFlashCardView.swift"

end