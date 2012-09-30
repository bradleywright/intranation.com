module Jekyll
  require 'sprockets'

  class SprocketsGenerator < Generator
    safe true
    priority :low

    def generate(site)
      root = site.source
      assets = Sprockets::Environment.new(root) do |env|
        env.logger = Logger.new(STDOUT)
      end

      assets.append_path(File.join(root, site.config['sprockets_assets']))
      assets.append_path(File.join(root, site.config['sprockets_assets'], "css"))
      assets.append_path(File.join(root, site.config['sprockets_assets'], "js"))

      %w( main.css ).each do |asset|
        asset = assets.find_asset(asset)
        p asset
        p asset.methods
        p asset.body
      end
    end
  end
end
