require_relative '../file_extension_stats'

RSpec.describe 'count_file_extensions' do
  before(:each) do
    @test_dir = "test_directory"
    Dir.mkdir(@test_dir) unless Dir.exist?(@test_dir)
  end

  after(:each) do
    Dir.foreach(@test_dir) do |file|
      next if file == '.' || file == '..'
      File.delete(File.join(@test_dir, file))
    end
    Dir.rmdir(@test_dir)
  end

  it 'returns correct counts for a directory with files of different extensions' do
    File.write(File.join(@test_dir, "file1.txt"), "Content")
    File.write(File.join(@test_dir, "file2.txt"), "Content")
    File.write(File.join(@test_dir, "image.jpg"), "Content")
    File.write(File.join(@test_dir, "script.rb"), "Content")

    result = count_file_extensions(@test_dir)
    expect(result).to eq({ ".txt" => 2, ".jpg" => 1, ".rb" => 1 })
  end

  it 'returns an empty hash for an empty directory' do
    result = count_file_extensions(@test_dir)
    expect(result).to eq({})
  end

  it 'ignores files without extensions' do
    File.write(File.join(@test_dir, "README"), "Content")
    File.write(File.join(@test_dir, "file1.txt"), "Content")

    result = count_file_extensions(@test_dir)
    expect(result).to eq({ ".txt" => 1 })
  end

  it 'raises an error if the directory does not exist' do
    expect {
      count_file_extensions("non_existent_dir")
    }.to raise_error(ArgumentError, "Директорія не знайдена: non_existent_dir")
  end
end
