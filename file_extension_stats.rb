require 'pathname'

# Основна функція для підрахунку розширень файлів
def count_file_extensions(directory_path)
  raise ArgumentError, "Директорія не знайдена: #{directory_path}" unless Dir.exist?(directory_path)

  extension_count = Hash.new(0)

  Dir.foreach(directory_path) do |file|
    next if File.directory?(file) # Пропускаємо підкаталоги та "."/ ".."

    ext = File.extname(file).downcase
    extension_count[ext] += 1 unless ext.empty?
  end

  extension_count
end
