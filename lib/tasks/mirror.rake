namespace :bake do

  desc "Create a static mirror of the site"
  task :full do
    Dir.mkdir('mirror') unless File.exist?('mirror')
    Dir.chdir('mirror') do
      `wget -m -nH http://localhost:3000`
    end
		`rsync -ruv public/ mirror/`
  end
  
end
