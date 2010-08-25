# Run using: rake autospec

def all_specs
  Dir['spec/**/*_spec.rb']
end

def run(file)
  if file == :all
    puts 'Running all specs'
    run_specs all_specs
  else
    matches = all_specs.grep(/#{file}_spec\.rb/)
    if matches[0]
      puts "Running #{matches[0]}"
      run_specs [matches[0]]
    end
  end
end

def run_specs(specs_to_run)
  system "rspec #{specs_to_run.join(' ')}"
end

run :all
watch(/^spec\/(.*)_spec\.rb/)   { |m| run m[1] }
watch(/^lib\/(.*)\.rb/)         { |m| run m[1] }
watch(/^spec\/spec_helper\.rb/) { run :all }
watch(/^spec\/support\/.*\.rb/) { run :all }