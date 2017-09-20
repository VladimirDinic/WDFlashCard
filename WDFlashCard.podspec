Pod::Spec.new do |s|

s.platform = :ios
s.name             = "WDFlashCard"
s.version          = "1.0.6"
s.summary          = "WDFlashCard is a simple lightweight component for displaying flashcards inside iOS apps."

s.description      = <<-DESC
WDFlashCard is a simple lightweight component for displaying flashcards inside iOS apps. Just add front and back view, set flashcard animation type and duration.
DESC

s.homepage         = "https://github.com/VladimirDinic/WDFlashCard"
s.license          = { :type => "MIT", :file => "LICENSE" }
s.author           = { "Vladimir Dinic" => "vladimir88dev@gmail.com" }
s.source           = { :git => "https://github.com/VladimirDinic/WDFlashCard.git", :tag => "#{s.version}"}

s.ios.deployment_target = "9.0"
s.source_files = "WDFlashCard/WDFlashCard/WDFlashCardView.swift"

end
