require "csv" # CSVファイルを扱うためのライブラリを読み込んでいます

class MemoClass
  def message1
    puts "-----------"
    puts "メモを入力してください"
    puts "メモを入力後Ctrl+Dで保存します"
    puts "メモしたい内容を記入してください"
    puts "-----------"
  end

  def message2
    puts "-----------"
    puts "メモの作成ができました。アプリケーションを終了します"
  end

end

puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する / 3 → 終了する"
memo_type = gets.chomp.to_i

#untilでループさせているが3を押せば終わるのでここでは強制終了する仕組みはいらないと思います
until[1, 2, 3].include?(memo_type)
  puts "不正な値です。1か2か3を入力してください"
  memo_type = gets.chomp.to_i
end

if memo_type == 1
  #新規作成モード
  puts "-----------"
  puts "拡張子を除いたファイル名を入力してください"
  file_name = gets.chomp
  
  memo_type1 = MemoClass.new()
  memo_type1.message1()
  input = STDIN.read
  
  CSV.open("#{file_name}.csv", "w")do |csv|
    csv.puts [input]
  end

  memo_type1.message2()

elsif memo_type == 2
  #編集モード
  puts "-----------"
  puts "読み込みたいCSVファイルのファイル名を入力してください(拡張子の入力は不要です)"
  num = 0
  read_file = gets.chomp.to_s
  
  until File.exist?("#{read_file}.csv")
    #ファイルが見つからなかった時の処理
    num += 1
    if num == 5
      #無限ループの防止のために5回入力ミスを確認したら終了することにした
      puts "所定の回数を超えました。もう一度最初からやり直してください"
      exit
    end
    puts "ファイルが見つかりません"
    puts "もう一度ファイル名を入力してください"
    read_file = gets.chomp.to_s
  end

  csv_data = CSV.read("#{read_file}.csv")
  puts "-----------"
  puts "ファイルの内容を表示します"
  puts csv_data

  memo_type2 = MemoClass.new()
  memo_type2.message1()
  input = STDIN.read

  CSV.open("#{read_file}.csv", "a")do |csv|
    csv.puts [input]
  end
  
  memo_type2.message2

elsif memo_type == 3
  puts "アプリケーションを終了します"
end