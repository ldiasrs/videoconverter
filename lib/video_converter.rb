# Search for videos types and convert into other videos types in resolution '480x284'
# Author: Leonardo Cardoso Dias
# Release date: 23/11/2015 22:01
# To install thread:  'gem install thread'
require 'fileutils'
require 'thread/pool'

ffmpeg_exec="~/files/programas/ffmpeg-20151031-git-ee20354-win64-static/bin/ffmpeg.exe"
resolution="480x284"
dir_converted_files='videos_convertidos'
extention_file_from='mp4'
extention_file_to='mpeg'

pool = Thread.pool(2)
files_with_extention_founded = Dir.glob("./**/*.#{extention_file_from}")
FileUtils::mkdir_p dir_converted_files
files_with_extention_founded.each do |file_found|
  pool.process {
    file_converted = File.basename(file_found).gsub extention_file_from, extention_file_to
    file_converted = file_converted.downcase.tr(" ", "_")
    puts "Processando: #{file_found}"
    `#{ffmpeg_exec} -i '#{file_found}' -s #{resolution} '#{dir_converted_files}/#{file_converted}'`
  }
end
pool.shutdown
