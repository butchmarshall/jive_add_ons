JiveAddOns::Engine.routes.draw do
	post 'register' => "add_ons#create"
	post 'unregister' => "add_ons#destroy"

	mount JiveOsApps::Engine => "/osapps"
end
