class SelfishSeoLayoutChanges
  def self.modify_head_layout
    if ENV["RAILS_ENV"] == "production"
      tmp_file = "/shared/tmp/head_work.tmp.txt"
    else
      tmp_file = "#{Rails.root}/head_work.tmp.txt"
    end
    head_layout = "#{Rails.root}/app/views/layouts/_head.html.erb"
    google_site_verification = '<meta name="google-site-verification" content="bBvzKkS7PmMFhAfxGGQR8uODDlhONm7GiTvJEnAwccU" />' + "\n"
    if File.readlines(head_layout).grep(/canonical/)&.any?
      IO.write(tmp_file, google_site_verification)
      IO.foreach(head_layout) do |line|
        IO.write(tmp_file, line, mode: "a") unless ((line.include? "canonical") || (line.include? "generator"))
      end
      FileUtils.mv(tmp_file, head_layout)
    end
  end

  def self.modify_footer_layout
    footer_layout = "#{Rails.root}/app/views/layouts/_noscript_footer.html.erb"
    if File.readlines(footer_layout).grep(/www\.chirpset\.com/)&.empty?
      powered_by_link = "\s\s\s\s\s\s" + '<p class="powered-by-link">Powered by <a href="https://chirpset.com/">chirpset.com</a>, best viewed with JavaScript enabled.</p>' + "\n"
      if ENV["RAILS_ENV"] == "production"
        tmp_file = "/shared/tmp/footer_work.tmp.txt"
      else
        tmp_file = "#{Rails.root}/footer_work.tmp.txt"
      end

      IO.foreach(footer_layout) do |line|
        if line.include? "powered_by_html"
          IO.write(tmp_file, powered_by_link, mode: "a")
        else
          IO.write(tmp_file, line, mode: "a")
        end
      end
      FileUtils.mv(tmp_file, footer_layout)
    end
  end
end
