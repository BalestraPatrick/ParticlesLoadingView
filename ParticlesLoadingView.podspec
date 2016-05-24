Pod::Spec.new do |s|
s.name             = "ParticlesLoadingView"
s.version          = "0.1.1"
s.summary          = "A loading animation made of particles."
s.description      = "A customizable SpriteKit particles animation on the border of a view."
s.homepage         = "https://github.com/BalestraPatrick/ParticlesLoadingView"
s.license          = 'MIT'
s.author           = { "Patrick Balestra" => "me@patrickbalestra.com" }
s.source           = { :git => "https://github.com/BalestraPatrick/ParticlesLoadingView.git", :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/BalestraPatrick'
s.platform     = :ios, '9.0'
s.requires_arc = true

s.source_files = 'Pod/Classes/**/*'
s.resource_bundles = {
'ParticlesLoadingButton' => ['Pod/Assets/*.png', 'Pod/Assets/*.sks']
}

s.frameworks = 'SpriteKit'
end
