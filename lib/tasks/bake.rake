namespace :bake do

  desc "Create a static mirror of the site"
  task :full do
    Dir.mkdir('mirror') unless File.exist?('mirror')
    Dir.chdir('mirror') do
      `wget -m -nH http://localhost:3000`
    end
		`rsync -ruv public/ mirror/`			

    Dir.glob('mirror/pages/*').each do |fname|
        next if fname == '.' or fname == '..'
        File.rename(fname, fname + '.html')
    end
    
    lines = IO.readlines('mirror/index.html').map do |line|
      if  line =~ /<a href="\/pages\/\w+">/
        asub = line.slice(/<a href="\/pages\/\w+/)
        bsub = line.slice(/">\w+\s*\w+<\/a>/)
        line.gsub!(/<a href="\/pages\/\w+">\w+\s*\w+<\/a>/, asub + '.html' + bsub)
      else
        line
      end
    end

    File.open('mirror/index.html', 'w') do |file|
      file.puts lines
    end
    
  end
  
end
