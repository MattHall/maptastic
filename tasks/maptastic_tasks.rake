include FileUtils

namespace :maptastic_form do
  desc 'Install maptastic javascript'
  task :install => :environment do
    cp_r "#{File.join(File.dirname(__FILE__), '../assets')}/javascripts/maptastic.js", "#{Rails.root}/public/javascripts"
  end
end
