JiveAddOns::Engine.routes.draw do
	post ':add_on_name/register' => "add_ons#create", :as => :register_add_on
	post ':add_on_name/unregister' => "add_ons#destroy", :as => :unregister_add_on

	mount JiveOsApps::Engine => "/osapps"
end
