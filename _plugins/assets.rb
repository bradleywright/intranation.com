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

      assets.append_path(File.join(root, site.config['sprockets_root']))
      assets.append_path(File.join(root, site.config['sprockets_root'], "css"))
      assets.append_path(File.join(root, site.config['sprockets_root'], "js"))

      target_dir = Pathname(root).join(site.config['sprockets_target'])
      to_convert = site.config['sprockets_assets'].split(' ')

      to_convert.each do |asset_name|
        target_file = target_dir.join(asset_name)
        asset = assets.find_asset(asset_name)
        asset.write_to(target_file)
      end
    end
  end
end
