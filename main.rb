require_relative 'file_extension_stats'

# Інтерфейс користувача
puts "Введіть шлях до папки:"
directory_path = gets.chomp

begin
  result = count_file_extensions(directory_path)
  if result.empty?
    puts "У папці немає файлів з розширеннями."
  else
    puts "Статистика розширень файлів у папці '#{directory_path}':"
    result.each do |ext, count|
      puts "#{ext}: #{count}"
    end
  end
rescue ArgumentError => e
  puts e.message
end
