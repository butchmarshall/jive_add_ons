module JiveAddOns
	class Engine < ::Rails::Engine
		isolate_namespace JiveAddOns

		initializer :append_migrations do |app|
			unless app.root.to_s.match(root.to_s)
				config.paths["db/migrate"].expanded.each do |expanded_path|
					app.config.paths["db/migrate"] << expanded_path
				end
			end
		end
	end
	
	def self.setup(&block)
		@@config ||= JiveAddOns::Engine::Configuration.new

		# Whitelist specific add-on names
		@@config.whitelist = []
		# Blacklist specific add-on names
		@@config.blacklist = []

		yield @@config if block

		return @@config
	end

	def self.config
		Rails.application.config
	end
end
