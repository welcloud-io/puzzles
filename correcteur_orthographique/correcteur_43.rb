 
  
class Dictionary
  
  attr_accessor :verb, :articles, :nouns, :adjectives, :pronouns
  
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
    
    @pronouns = {"je" => { :gender => nil, :number => :singular }, "tu" => { :gender => nil, :number => :singular }, "il" => { :gender => :masculin, :number => :singular }, "elle" => { :gender => :feminin, :number => :singular  }, "nous" => { :gender => nil, :number => :singular }, "vous" => { :gender => nil, :number => :singular }, "ils" => { :gender => :masculin, :number => :singular  }, "elles" => { :gender => :feminin, :number => :singular  } }
    
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
  
  def verb_of_state?(word)
    ['suis', 'es', 'est', 'sommes', 'etes', 'sont'].include?(word)
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

def person(words, dictionary)
  return words.first.to_s if dictionary.verb[words.first.to_s]
  return 'il' if dictionary.articles[words.first.to_s] == :singular
  return 'ils' if dictionary.articles[words.first.to_s] == :plural
end

def gender(words, dictionary)
  words.each { |word| return dictionary.nouns[word.to_s][:genre] if dictionary.noun?(word.to_s) }  
  words.each { |word| return dictionary.pronouns[word.to_s][:gender] if dictionary.pronoun?(word.to_s) }  
end

def number(words, dictionary)
  words.each { |word| return dictionary.articles[word.to_s] if dictionary.article?(word.to_s) } 
  words.each { |word| return dictionary.pronouns[word.to_s][:number] if dictionary.pronoun?(word.to_s) }   
end

class Word
  def initialize(word_string)
    @word_string = word_string
  end
  
  def corrected(gender, number, dictionary)
    return self
  end
  
  def to_s
    @word_string
  end
end

class Verb < Word
  def initialize(word_string)
    super(word_string)
  end  

  def corrected(gender, number, dictionary)
    dictionary.verb[gender]
  end  

end

class Noun < Word
  def initialize(word_string)
    super(word_string)
  end  

  def corrected(gender, number, dictionary)
    dictionary.nouns[@word_string][number]
  end  
end

class Adjective < Word
  def initialize(word_string)
    super(word_string)
  end  

  def corrected(gender, number, dictionary)
    dictionary.adjectives[@word_string][gender][number]
  end  
end



def corrected_sentence(sentence_string, verb, adjectives, nouns)
  dictionary = Dictionary.new(verb, adjectives, nouns)
  
  words = sentence_string.split.map do |word_string| 
    case 
    when dictionary.verb?(word_string) then Verb.new(word_string)
    when dictionary.adjective?(word_string) then Adjective.new(word_string)
    when dictionary.noun?(word_string) then Noun.new(word_string)
    else Word.new(word_string)
    end
  end
  
  verb_index = nil
  words.each.with_index do |word, index|
    verb_index = index if dictionary.verb?(word.to_s)
  end

  subject = words[0..verb_index-1]
  verb = words[verb_index..verb_index]
  complement = words[verb_index+1..-1]
  
  subject.map! do |word|
    word.corrected(gender(subject, dictionary), number(subject, dictionary), dictionary)  
  end
  
  verb.map! do |word| 
    word.corrected(person(subject, dictionary), nil, dictionary)
  end
  
  complement.map! do |word|
    case 
      when dictionary.verb_of_state?(verb[0].to_s) then word.corrected(gender(subject, dictionary), number(subject, dictionary), dictionary)
      else word.corrected(gender(complement, dictionary), number(complement, dictionary), dictionary)
    end
  end  
  
  (subject + verb + complement).join(" ").strip

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
  
  
  def test12
	  
    verbe = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectifs = [ ['petit', 'petits', 'petite', 'petites'] ]
    noms = [ ['masculin', 'renard', 'renards'] ]
    
    assert_equal "un petit renard mange", corrected_sentence("un petit renard mangent", verbe, adjectifs, noms)
    
  end  
  
  def test13
	  
    verbe = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectifs = [ ['petit', 'petits', 'petite', 'petites'] ]
    noms = [ ['feminin', 'coccinelle', 'coccinelles'] ]
    
    assert_equal "une petite coccinelle mange", corrected_sentence("une petits coccinelle manges", verbe, adjectifs, noms)
    
  end 

  def test14
	  
    verbe = ['vole', 'voles', 'vole', 'volons', 'volez', 'volent']
    adjectifs = [ ['petit', 'petits', 'petite', 'petites'] ]
    noms = [ ['feminin', 'coccinelle', 'coccinelles'] ]
    
    assert_equal "les petites coccinelles volent", corrected_sentence("les petit coccinelles voles", verbe, adjectifs, noms)
    
  end 

  def test15
	  
    verbe = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectifs = [ ['vert', 'verts', 'verte', 'vertes'] ]
    noms = [ ['feminin', 'coccinelle', 'coccinelles'] ]
    
    assert_equal "la coccinelle verte mange", corrected_sentence("la coccinelles vertes mangent", verbe, adjectifs, noms), "la coccinelles vertes mangent"
    
  end   
  
  def test16
	  
    verbe = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectifs = [ ['petit', 'petits', 'petite', 'petites'],  ['joli', 'jolis', 'jolie', 'jolies'], ['vert', 'verts', 'verte', 'vertes'] ]
    noms = [ ['feminin', 'coccinelle', 'coccinelles'] ]
    
    assert_equal "la jolie petite coccinelle verte mange", corrected_sentence("la jolis petit coccinelles vert manges", verbe, adjectifs, noms)
    
  end 
  
  def test17
	  
    verbe = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectifs = [ ['petit', 'petits', 'petite', 'petites'] ]
    noms = [ ['masculin', 'fruit', 'fruits'] ]
    
    assert_equal "ils mangent des petits fruits", corrected_sentence("ils mange des petit fruit", verbe, adjectifs, noms)
    
  end  
  
  def test18
	  
    verbe = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectifs = [ ['petit', 'petits', 'petite', 'petites'] ]
    noms = [ ['masculin', 'fruit', 'fruits'] ]
    
    assert_equal "je mange un petit fruit", corrected_sentence("je manges un petits fruits", verbe, adjectifs, noms)
    
  end
  
  def test19
	  
    verbe = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectifs = [ ['petit', 'petits', 'petite', 'petites'] ]
    noms = [ ['feminin', 'orange', 'oranges'] ]
    
    assert_equal "ils mangent des petites oranges", corrected_sentence("ils mange des petit orange", verbe, adjectifs, noms)
    
  end

  def test20
	  
    verbe = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectifs = [ ['petit', 'petits', 'petite', 'petites'], ['vert', 'verts', 'verte', 'vertes'] ]
    noms = [ ['masculin', 'fruit', 'fruits'] ]
    
    assert_equal "ils mangent un petit fruit vert", corrected_sentence("ils manges un petits fruits verte", verbe, adjectifs, noms)
    
  end   
  
  def test21
	  
    verbe = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectifs = [ ['petit', 'petits', 'petite', 'petites'] ]
    noms = [ ['feminin', 'coccinelle', 'coccinelles'], ['feminin', 'orange', 'oranges'] ]
    
    assert_equal "les petites coccinelles mangent une petite orange", corrected_sentence("les petits coccinelle manges une petits oranges", verbe, adjectifs, noms)
    
  end

  def test22
	  
    verbe = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectifs = [ ['petit', 'petits', 'petite', 'petites'],  ['joli', 'jolis', 'jolie', 'jolies'], ['vert', 'verts', 'verte', 'vertes'] ]
    noms = [ ['feminin', 'coccinelle', 'coccinelles'], ['masculin', 'kiwi', 'kiwis'] ]
    
    assert_equal "les jolies petites coccinelles vertes mangent des jolis petits kiwis verts", corrected_sentence("les joli petits coccinelle vert manges des jolie petite kiwi verte", verbe, adjectifs, noms)
    
  end
  
  def test23
	  
    verbe = ['suis', 'es', 'est', 'sommes', 'etes', 'sont']
    adjectifs = [ ['petit', 'petits', 'petite', 'petites'] ]
    noms = [ ]
    
    assert_equal "il est petit", corrected_sentence("il est petite", verbe, adjectifs, noms)
    
  end  

end  