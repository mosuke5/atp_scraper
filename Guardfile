guard :minitest, test_folders: 'test', test_file_patterns: '*.rb' do
  watch(%r{^test/(.*)\/?test_(.*)\.rb$}) { 'test' }
  watch(%r{^lib/(.*/)?([^/]+)\.rb$}) { 'test' }
end
