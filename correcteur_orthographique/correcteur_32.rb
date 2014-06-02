class Dictionary
  
  attr_accessor :verb, :articles, :nouns, :adjectives
  
  def initialize(verb, adjectives, nouns)
    
    @articles = {"un" => :singular, "une" => :singular, "le" => :singular, "la" => :singular, "les" => :plural, "des" => :plural }  
    
    @articles_words = @articles.keys

    @verb = {
      'je' => verb[0],
      'tu' => verb[1],
      'il' => verb[2],
      'elle' => verb[2],
      'nous' => verb[3],
      'vous' => verb[4],
      'ils' => verb[5],
      'elles' => verb[5]
    }
    
    @pronouns_words = @verb.keys
    
    @verb[:singular] = verb[2]
    @verb[:plural] = verb[5]
    
    @verb_words = @verb.values.uniq
    
    @adjectives = {}
    
    adjectives.each do |adjective|
      (0..3).each do |index|
        @adjectives[adjective[index]] = { 
          :masculin => { :singular => adjective[0], :plural => adjective[1]}, 
          :feminin => { :singular => adjective[2], :plural => adjective[3]} 
        }
      end
    end
    
    @adjective_words = @adjectives.keys

    @nouns = {}
    
    nouns.each do |noun|
      @nouns[noun[1]] = { :genre => noun[0].to_sym, :singular => noun[1], :plural => noun[2] }
      @nouns[noun[2]] = { :genre => noun[0].to_sym, :singular => noun[1], :plural => noun[2] }
    end  
    
    @noun_words = @nouns.keys
  end
  
  def adjective?(word)
    @adjective_words.include?(word)
  end
  
  def verb?(word)
    @verb_words.include?(word)
  end 

  def noun?(word)
    @noun_words.include?(word)
  end 
  
  def pronoun?(word)
    @pronouns_words.include?(word)
  end
  
  def article?(word)
    @articles_words.include?(word)
  end
  
end

def corrected_sentence(sentence_string, verb, adjectives, nouns)
  dictionary = Dictionary.new(verb, adjectives, nouns)
  
  words = sentence_string.split
  person = words.first
  if dictionary.verb[person] == nil then
    person = 'il' if dictionary.articles[words.first] == :singular
  end
  correct_sentence = ""
  words.each do |word|
    correct_word = word
    correct_word = dictionary.verb[person] if dictionary.verb?(word)
    correct_sentence << " " + correct_word
  end
  correct_sentence.strip

end

# ----
# ----
# ----

require 'test/unit'

class TestsSession < Test::Unit::TestCase

  def test01
	  
    verb = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectives = []
    nouns = []
    
    assert_equal "je mange", corrected_sentence("je manges", verb, adjectives, nouns), "je manges"
    
  end
      
  def test02
	  
    verb = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectives = []
    nouns = []
    
    assert_equal "tu manges", corrected_sentence("tu mangent", verb, adjectives, nouns), "Phrase a corriger : " + "\"tu mangent\""
    
  end   

  def test03
	  
    verb = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectives = []
    nouns = []
    
    assert_equal "il mange", corrected_sentence("il mangent", verb, adjectives, nouns)
    
  end  
  
  def test04
	  
    verb = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectives = []
    nouns = []
    
    assert_equal "elle mange", corrected_sentence("elle manges", verb, adjectives, nouns)
    
  end  

  def test05
	  
    verb = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectives = []
    nouns = []
    
    assert_equal "nous mangeons", corrected_sentence("nous mangez", verb, adjectives, nouns)
    
  end  
  
  def test06
	  
    verb = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectives = []
    nouns = []
    
    assert_equal "vous mangez", corrected_sentence("vous mangeons", verb, adjectives, nouns)
    
  end   
  
  def test07
	  
    verb = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectives = []
    nouns = []
    
    assert_equal "ils mangent", corrected_sentence("ils mange", verb, adjectives, nouns)
    
  end  

  def test08
	  
    verb = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectives = []
    nouns = []
    
    assert_equal "ils mangent", corrected_sentence("ils mange", verb, adjectives, nouns)
    
  end
  
  def test09
	  
    verb = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectives = []
    nouns = []
    
    assert_equal "elles mangent", corrected_sentence("elles manges", verb, adjectives, nouns)
    
  end
  
  def test10
	  
    verb = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectives = [ ]
    nouns = [ ['feminin', 'coccinelle', 'coccinelles'] ]
    
    assert_equal "la coccinelle mange", corrected_sentence("la coccinelle manges", verb, adjectives, nouns), "la coccinelle manges"
    
  end  

  def test11
	  
    verb = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectives = [ ]
    nouns = [ ['masculin', 'renard', 'renards'] ]
    
    assert_equal "un renard mange", corrected_sentence("un renard mangent", verb, adjectives, nouns)
    
  end  

end