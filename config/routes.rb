JiveAddOns::Engine.routes.draw do
	post ':name/register' => "add_ons#create", :as => :register_add_on
	post ':name/unregister' => "add_ons#destroy", :as => :unregister_add_on
end