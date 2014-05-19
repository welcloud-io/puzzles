$ascii_art_characters = [
" #  ##   ## ##  ### ###  ## # # ###  ## # # #   # # ###  #  ##   #  ##   ## ### # # # # # # # # # # ### ### ",
"# # # # #   # # #   #   #   # #  #    # # # #   ### # # # # # # # # # # #    #  # # # # # # # # # #   #   # ",
"### ##  #   # # ##  ##  # # ###  #    # ##  #   ### # # # # ##  # # ##   #   #  # # # # ###  #   #   #   ## ",
"# # # # #   # # #   #   # # # #  #  # # # # #   # # # # # # #    ## # #   #  #  # # # # ### # #  #  #       ",
"# # ##   ## ##  ### #    ## # # ###  #  # # ### # # # #  #  #     # # # ##   #  ###  #  # # # #  #  ###  #  ",
]

$ascii_art_characters_2 = [
%q{ .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .-----------------. .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------. },
%q{| .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |},
%q{| |      __      | || |   ______     | || |     ______   | || |  ________    | || |  _________   | || |  _________   | || |    ______    | || |  ____  ____  | || |     _____    | || |     _____    | || |  ___  ____   | || |   _____      | || | ____    ____ | || | ____  _____  | || |     ____     | || |   ______     | || |    ___       | || |  _______     | || |    _______   | || |  _________   | || | _____  _____ | || | ____   ____  | || | _____  _____ | || |  ____  ____  | || |  ____  ____  | || |   ________   | || |    ______    | |},
%q{| |     /  \     | || |  |_   _ \    | || |   .' ___  |  | || | |_   ___ `.  | || | |_   ___  |  | || | |_   ___  |  | || |  .' ___  |   | || | |_   ||   _| | || |    |_   _|   | || |    |_   _|   | || | |_  ||_  _|  | || |  |_   _|     | || ||_   \  /   _|| || ||_   \|_   _| | || |   .'    `.   | || |  |_   __ \   | || |  .'   '.     | || | |_   __ \    | || |   /  ___  |  | || | |  _   _  |  | || ||_   _||_   _|| || ||_  _| |_  _| | || ||_   _||_   _|| || | |_  _||_  _| | || | |_  _||_  _| | || |  |  __   _|  | || |   / _ __ `.  | |},
%q{| |    / /\ \    | || |    | |_) |   | || |  / .'   \_|  | || |   | |   `. \ | || |   | |_  \_|  | || |   | |_  \_|  | || | / .'   \_|   | || |   | |__| |   | || |      | |     | || |      | |     | || |   | |_/ /    | || |    | |       | || |  |   \/   |  | || |  |   \ | |   | || |  /  .--.  \  | || |    | |__) |  | || | /  .-.  \    | || |   | |__) |   | || |  |  (__ \_|  | || | |_/ | | \_|  | || |  | |    | |  | || |  \ \   / /   | || |  | | /\ | |  | || |   \ \  / /   | || |   \ \  / /   | || |  |_/  / /    | || |  |_/____) |  | |},
%q{| |   / ____ \   | || |    |  __'.   | || |  | |         | || |   | |    | | | || |   |  _|  _   | || |   |  _|      | || | | |    ____  | || |   |  __  |   | || |      | |     | || |   _  | |     | || |   |  __'.    | || |    | |   _   | || |  | |\  /| |  | || |  | |\ \| |   | || |  | |    | |  | || |    |  ___/   | || | | |   | |    | || |   |  __ /    | || |   '.___`-.   | || |     | |      | || |  | '    ' |  | || |   \ \ / /    | || |  | |/  \| |  | || |    > `' <    | || |    \ \/ /    | || |     .'.' _   | || |    /  ___.'  | |},
%q{| | _/ /    \ \_ | || |   _| |__) |  | || |  \ `.___.'\  | || |  _| |___.' / | || |  _| |___/ |  | || |  _| |_       | || | \ `.___]  _| | || |  _| |  | |_  | || |     _| |_    | || |  | |_' |     | || |  _| |  \ \_  | || |   _| |__/ |  | || | _| |_\/_| |_ | || | _| |_\   |_  | || |  \  `--'  /  | || |   _| |_      | || | \  `-'  \_   | || |  _| |  \ \_  | || |  |`\____) |  | || |    _| |_     | || |   \ `--' /   | || |    \ ' /     | || |  |   /\   |  | || |  _/ /'`\ \_  | || |    _|  |_    | || |   _/ /__/ |  | || |    |_|       | |},
%q{| ||____|  |____|| || |  |_______/   | || |   `._____.'  | || | |________.'  | || | |_________|  | || | |_____|      | || |  `._____.'   | || | |____||____| | || |    |_____|   | || |  `.___.'     | || | |____||____| | || |  |________|  | || ||_____||_____|| || ||_____|\____| | || |   `.____.'   | || |  |_____|     | || |  `.___.\__|  | || | |____| |___| | || |  |_______.'  | || |   |_____|    | || |    `.__.'    | || |     \_/      | || |  |__/  \__|  | || | |____||____| | || |   |______|   | || |  |________|  | || |    (_)       | |},
%q{| |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | |},
%q{| '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |},
%q{ '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------' }
]

def ascii_art(string, characters, l, h)
  
  ascii_art_string = []

  (0..h-1).each do |line|
    ascii_art_line = ""
    string.each_char do |char|
      column = (char.upcase[0].ord - 65) * l
      ascii_art_line << characters[line][column..column+l-1]
    end
    ascii_art_string << ascii_art_line
  end
  
  ascii_art_string
  
end


require 'test/unit'

class TestsSession < Test::Unit::TestCase
  
  def test01

    result = [
    " #  ",
    "# # ",
    "### ",
    "# # ",
    "# # " ,
    ]
    
    assert_equal result, ascii_art("A", $ascii_art_characters, 4, 5), result.join("\n")
    
  end  
  
  def test02

    result = [
    "### ",
    "#   ",   
    "##  ",  
    "#   ",   
    "### "
    ]
    
    assert_equal result, ascii_art("E", $ascii_art_characters, 4, 5)
    
  end

  def test_03

    result = [
    "# #  #  ### # #  #  ### ###  #  ### ",
    "### # # # # # # # #  #   #  # # # # ",
    "### ### # # ### ###  #   #  ### # # ",
    "# # # # # # # # # #  #   #  # # # # ",
    "# # # # # # # # # #  #   #  # # # # " ,
    ]
  
    assert_equal result, ascii_art("MANHATTAN", $ascii_art_characters, 4, 5)
  
  end

  def test_04

    result = [
    "# #  #  ### # #  #  ### ###  #  ### ",
    "### # # # # # # # #  #   #  # # # # ",
    "### ### # # ### ###  #   #  ### # # ",
    "# # # # # # # # # #  #   #  # # # # ",
    "# # # # # # # # # #  #   #  # # # # " ,
    ]
  
    assert_equal result, ascii_art("ManhAtTan", $ascii_art_characters, 4, 5)
  
  end


  def test_05

    result = [
    "# # ### ### # # ### ### ### ### ### ",
    "###   # # # # #   #  #   #    # # # ",
    "###  ## # # ###  ##  #   #   ## # # ",
    "# #     # # # #      #   #      # # ",
    "# #  #  # # # #  #   #   #   #  # # ",
    ]
  
    assert_equal result, ascii_art("M@NH@TT@N", $ascii_art_characters, 4, 5)
  
  end

  def test_06
    
    result = [
    %q{ .----------------. },
    %q{| .--------------. |},
    %q{| |      __      | |},
    %q{| |     /  \     | |},
    %q{| |    / /\ \    | |},
    %q{| |   / ____ \   | |},
    %q{| | _/ /    \ \_ | |},
    %q{| ||____|  |____|| |},
    %q{| |              | |},
    %q{| '--------------' |},
    %q{ '----------------' },
    ]
    
    assert_equal result, ascii_art("A", $ascii_art_characters_2, 20, 11)    
    
  end

  def test_07
    
    result = [
    %q{ .----------------.  .----------------.  .-----------------. .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .-----------------.},
    %q{| .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |},
    %q{| | ____    ____ | || |      __      | || | ____  _____  | || |  ____  ____  | || |      __      | || |  _________   | || |  _________   | || |      __      | || | ____  _____  | |},
    %q{| ||_   \  /   _|| || |     /  \     | || ||_   \|_   _| | || | |_   ||   _| | || |     /  \     | || | |  _   _  |  | || | |  _   _  |  | || |     /  \     | || ||_   \|_   _| | |},
    %q{| |  |   \/   |  | || |    / /\ \    | || |  |   \ | |   | || |   | |__| |   | || |    / /\ \    | || | |_/ | | \_|  | || | |_/ | | \_|  | || |    / /\ \    | || |  |   \ | |   | |},
    %q{| |  | |\  /| |  | || |   / ____ \   | || |  | |\ \| |   | || |   |  __  |   | || |   / ____ \   | || |     | |      | || |     | |      | || |   / ____ \   | || |  | |\ \| |   | |},
    %q{| | _| |_\/_| |_ | || | _/ /    \ \_ | || | _| |_\   |_  | || |  _| |  | |_  | || | _/ /    \ \_ | || |    _| |_     | || |    _| |_     | || | _/ /    \ \_ | || | _| |_\   |_  | |},
    %q{| ||_____||_____|| || ||____|  |____|| || ||_____|\____| | || | |____||____| | || ||____|  |____|| || |   |_____|    | || |   |_____|    | || ||____|  |____|| || ||_____|\____| | |},
    %q{| |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | |},
    %q{| '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |},
    %q{ '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------' },
    ]
    
    assert_equal result, ascii_art("MANHATTAN", $ascii_art_characters_2, 20, 11)
    
  end

end