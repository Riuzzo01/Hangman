class Game
  @@word_to_guess
  @@user_progress
  @@file
  def initialize(word_to_guess = nil, user_progress = "", turn = 1)
    if word_to_guess == nil
      @@file = File.readlines("google-10000-english-no-swears.txt")
      index = rand 0..9998
      puts @@file[index]
      @@word_to_guess = @@file[index].strip
    else 
      @@word_to_guess = word_to_guess
    end
    puts user_progress
    @@user_progress = user_progress
    guess(turn)
  end

  def guess(turnToPlay)
    puts "\nNow you have 12 tries to guess the extracted word... Ready?\nGO!!\n"
    guessed = false
    if turnToPlay.instance_of? String
      turn = turnToPlay.to_i 
    else
      turn = turnToPlay
    end
    if @@user_progress == ""
      for i in 0..@@word_to_guess.length-2
        @@user_progress += "_ "
      end
    end
    puts "\nThe word to guess has #{@@word_to_guess.length - 1} letters"
    while !guessed and turn != 13
      puts @@user_progress
      puts "\nEnter your try; you have #{13 - turn} remaining tries...\n\nYou can enter 'save' to save the game"
      try = gets.chomp.downcase
      if try == "save"
        fileName = "#{@@file[rand 0..9998].strip}_#{@@file[rand 0..9998].strip}_#{rand 0..9998}_riuzzo.txt"
        File.open(fileName, 'w') {|file| file.write "#{@@word_to_guess}\n#{@@user_progress}\n#{turn}"}
        break
      end
      check(try, @@word_to_guess.split(""))
      puts "\n#{@@user_progress.delete(" ")}\n"
      if !(@@user_progress.include? "_")
        puts "\nWord unveiled!!!!"
        guessed = true
      end
      turn += 1
    end
    if !guessed
      puts "Oh NO! You didn't find the secret word...\nIt was #{@@word_to_guess}"
    end
  end

  def check(try, word)
    progress = ""
    for i in 0..(word.length - 2)
      if try == word[i]
        progress += "#{try} "
      else
        progress += "_ "
      end
    end
    refactor(progress)
  end

  def refactor(progress)
    for i in 0..(progress.length - 2)
      if progress[i] != "_" and @@user_progress[i] == "_"
        @@user_progress[i] = progress[i]
      end
    end
  end
end


answer = ""
exitGame = false

while !exitGame
  loop do
    puts "Hello, man\nWelcome to Hangman! Do you want to play a new game? insert new to play a new game, load to load a game or exit to exit"
    answer = gets.chomp.downcase

    break if answer != "new" or answer != "load" or answer != "exit"
  end

  if answer == "new"
    game = Game.new
  elsif answer == "load"
    puts "write the name of the file"
    fileName = gets.chomp
    file = File.readlines("#{fileName}.txt")
    for i in 0..2
      puts file[i]
    end
    game = Game.new(file[0], file[1], file[2])
  else
    puts "Bye man!!"
    exitGame = true
  end
end


