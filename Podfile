# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def all_pods
    pod 'RxSwift', '~> 4.5'
    pod 'RxCocoa', '~> 4.5'
    pod 'RxBlocking', '~> 4.5'
    pod 'Nuke', '~> 7.0'

end

target 'genreMovie' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for genreMovie
	all_pods
  target 'genreMovieTests' do
    inherit! :search_paths
    # Pods for testing
	all_pods
  end

  target 'genreMovieUITests' do
    # Pods for testing
  end

end
