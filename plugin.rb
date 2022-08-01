# frozen_string_literal: true

# name: discourse-selfish-seo-layout-changes
# about: selfish plugin to remove canonical url, generator and change powered by, etc.
# version: 0.0.9
# date: 18 March 2021
# authors: Neo
# url: https://github.com/unixneo/discourse-selfish-seo-layout-changes

PLUGIN_NAME = "discourse-selfish-seo-layout-changes"
require_relative "./app/lib/selfish_layout_changes"

enabled_site_setting :enable_selfish_seo_layout_changes

after_initialize do
  if SiteSetting.enable_selfish_seo_layout_changes?
    SelfishSeoLayoutChanges.modify_head_layout
    SelfishSeoLayoutChanges.modify_footer_layout
    
    require_relative "./app/lib/monkey_patch_topics_controller"
  end
end
