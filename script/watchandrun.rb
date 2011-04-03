#!/usr/bin/env ruby

require 'fssm'



cucumber = lambda do |relative|
  puts "\n\n"
  puts Time.now
  puts "running cucumber for #{relative}"
  `cucumber features\#{relative}`
end

FSSM.monitor('features', '**/*.feature') do
  update {|base, relative| cucumber.call(relative)}
  delete {|base, relative| puts base; puts relative}
  create {|base, relative| cucumber.call(relative)}
end

