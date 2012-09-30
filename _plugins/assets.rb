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

      target_dir = Pathname(root).join(site.config['sprockets_target'])

      %w( main.css ).each do |asset_name|
        target_file = target_dir.join(asset_name)
        asset = assets.find_asset(asset_name)
        asset.write_to(target_file)
      end
    end
  end
end
