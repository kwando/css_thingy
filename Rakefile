task :test do
  $: << 'lib' << 'test'
  Dir['test/**/*_test.rb'].each do |file|
    require_relative file
  end
end