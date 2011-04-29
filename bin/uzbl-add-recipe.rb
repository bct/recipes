#!/usr/bin/env ruby

RECIPE_ROOT = File.join(File.dirname(__FILE__), '..')

name  = ARGV[0]
title = ENV['UZBL_TITLE']
url   = ENV['UZBL_URI']

content = `xclip -o`

new_recipe_path = File.join(RECIPE_ROOT, "#{name}.md")

# create the file (or raise Errno::EEXIST if it already exists)
File.open(new_recipe_path, File::EXCL|File::CREAT|File::WRONLY) do |f|
  # write out the recipe title
  f.puts("# #{title} #")

  # followed by a blank line
  f.puts

  # followed by metadata
  f.puts("source: #{url}")

  # followed by a blank line
  f.puts

  # followed by the recipe body
  f.puts(content)
end

# open the file for editing
exec "urxvt -e vim #{new_recipe_path}"
