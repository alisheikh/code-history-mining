#!/usr/bin/ruby
require './merge.rb'

change_size_chart_fixes = Proc.new { |html|
  html.gsub!(/width =.*?,/, 'width = 740,')
  html.gsub!('var defaultTimeInterval = "monday";', 'var defaultTimeInterval = "month";')
  html.gsub!('var showMovingAverage = false;', 'var showMovingAverage = false;')
  html.gsub!('dropDown.append("option").attr("value", "1").html("lines");', '')
  html.gsub!('dropDown.append("option").attr("value", "2").html("characters");', '')
  html.gsub!('return svgPos.left + margin.left', 'return margin.left')
}

amount_of_committers_fixes = Proc.new { |html|
  html.gsub!(/width =.*?,/, 'width = 740,')
  html.gsub!('var defaultTimeInterval = "monday";', 'var defaultTimeInterval = "month";')
  html.gsub!(/var rawDataIndex = 0;/, 'var rawDataIndex = 2;')
}

avg_amount_of_files_fixes = Proc.new { |html|
  html.gsub!(/width =.*?,/, 'width = 740,')
  html.gsub!('var defaultPercentile = 1.0;', 'var defaultPercentile = 0.95;')
  html.gsub!(/var rawDataIndex = 0;/, 'var rawDataIndex = 2;')
}

file_in_same_commit_fixes = Proc.new{ |html|
  html.gsub!(/width =.*?,/, 'width = 800,')
  html.gsub!(/var gravity = gravityValues.*?;/, 'var gravity = gravityValues.Medium;')
  html.gsub!('var minLinkStrength = linkValuesExtent[0];', 'var minLinkStrength = 8;')
}

committer_and_files_fixes = Proc.new{ |html|
  html.gsub!(/width =.*?,/, 'width = 800,')
  html.gsub!(/var gravity = gravityValues.*?;/, 'var gravity = gravityValues.Low;')
  html.gsub!('var minClusterSize = 2;', 'var minClusterSize = 2;')
  html.gsub!('var minLinkStrength = linkValuesExtent[0];', 'var minLinkStrength = 1;')
}

treemap_fixes = Proc.new{ |html|
  html.gsub!(/var w =.*?,/, 'var w = 800,')
  html.gsub!(/font:.*?;/, '')
}

punchcard_fixes = Proc.new{ |html|
  html.gsub!(/width =.*?,/, 'width = 740,')
  html.gsub!('var defaultCommitSizeMultiplier = 1;', 'var defaultCommitSizeMultiplier = 2;')
}

histogram_fixes = Proc.new{ |html|
  html.gsub!(/width =.*?,/, 'width = 740,')
  html.gsub!(/var defaultPercentile =.*?;/, 'var defaultPercentile = 0.6;')
}

word_cloud_fixes = Proc.new{ |html|
  html.gsub!('normalizeWordSize(data.words);', 'excludeWords(["svn", "http", "org", "commit", "rails", "trunk", "rubyonrails", "git", "ee", "ecf", "de", "fe", "id", "com"]); normalizeWordSize(data.words);')
}

src_path = '/Users/dima/Google Drive/visualisations/junit/'
merge_into(src_path, '../junit-template.html', '../junit.html', {
    '/Change size chart.html' => [change_size_chart_fixes],
    '/Amount of committers.html' => [amount_of_committers_fixes],
    '/Average amount of files in commit.html' => [avg_amount_of_files_fixes],
    '/Files changed in the same commit.html' => [file_in_same_commit_fixes],
    '/Committers changing same files.html' => [committer_and_files_fixes],
    '/Amount of commits treemap.html' => [treemap_fixes],
    '/Commit time punchcard.html' => [punchcard_fixes],
    '/Time between commits histogram.html' => [histogram_fixes],
    '/Commit messages word cloud.html' => [word_cloud_fixes],
})