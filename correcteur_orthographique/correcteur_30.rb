class Word
  
  attr_reader :index
  
  def initialize(word_string, index = nil)
    @word_string = word_string
    @index = index
  end
  
  def correct(gender, number)
    self
  end
  
  def to_s
    @word_string
  end
  
end

class Article < Word
  
  def initialize(article_string)
    super(article_string)
  end  
  
  def number
    $dictionary.articles[@word_string]
  end
  
end

class Pronoun < Word
  
  def initialize(pronoun_string)
    super(pronoun_string)
  end  
  
end

class Noun < Word
  
  def initialize(noun_word)
    super(noun_word)
  end
  
  def gender
    $dictionary.noms[@word_string][:genre]
  end
  
  def correct(gender, number)
    $dictionary.noms[@word_string][number]
  end
  
end

class Adjective < Word
  
  def initialize(adjective_word)
    super(adjective_word)
  end
  
  def correct(gender, number)
    $dictionary.adjectifs[@word_string][gender][number]
  end
  
end

class Verb < Word
  
  def initialize(verb_string, index, context)
    super(verb_string, index)
    @context = context
  end
  
  def correct
    $dictionary.verbs[@context.subject.person]    
  end
  
end

class NominalGroup
  
  def initialize(words)
    @words = words
  end
  
  def gender
    @words.each { |word| return word.gender if word.instance_of? Noun }
  end
  
  def number
    @words.each { |word| return word.number if word.instance_of? Article }
  end

  def correct
    @words.map do |word|
      word.correct(gender, number)
    end
  end

end

class Complement < NominalGroup
  
  def initialize(complement_string)
    super(complement_string)
  end
  
end

class Subject < NominalGroup
  
  def initialize(words)
    super(words)
    @words = words
  end
  
  def person
    return @words.first.to_s if @words.first.instance_of? Pronoun
    return 'il' if number = :singulier
    return 'ils' if number == :pluriel
  end
  
  def to_s
    @subject_string
  end
  
end  

class Sentence
  
  SUJET = 0
  COMPLEMENT = 1
  
  def initialize(string)
    @sentence_string = string
    slice_in_words
  end
  
  def slice_in_words
    @words = @sentence_string.split
    @words.map!.with_index do |word_string, index|
      case
        when $dictionary.adjective?(word_string) then Adjective.new(word_string)
        when $dictionary.verb?(word_string) then Verb.new(word_string, index, self)
        when $dictionary.noun?(word_string) then Noun.new(word_string)
        when $dictionary.pronoun?(word_string) then Pronoun.new(word_string)
        when $dictionary.article?(word_string) then Article.new(word_string)
        else Word.new(word_string, index)
      end
    end    
  end
  
  def subject
    Subject.new(@words[0...verb.index])
  end
  
  def verb
    @words.select { |word| word.instance_of? Verb }[0]
  end
  
  def complement
    Subject.new(@words[verb.index+1..-1])
  end
  
  def correct
    (subject.correct + [verb.correct] + complement.correct).join(' ')
  end

end

class Dictionary
  
  attr_accessor :verbs, :articles, :noms, :adjectifs
  
  def initialize(verbe, adjectifs, noms)
    
    @articles = {"un" => :singulier, "une" => :singulier, "le" => :singulier, "la" => :singulier, "les" => :pluriel, "des" => :pluriel }  
    
    @articles_words = @articles.keys
    
    verbe = [['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']] + [['vole', 'voles', 'vole', 'volons', 'volez', 'volent']]

    @verbs = [{
      'je' => verbe[0][0],
      'tu' => verbe[0][1],
      'il' => verbe[0][2],
      'elle' => verbe[0][2],
      'nous' => verbe[0][3],
      'vous' => verbe[0][4],
      'ils' => verbe[0][5],
      'elles' => verbe[0][5]
    },
    {
      'je' => verbe[1][0],
      'tu' => verbe[1][1],
      'il' => verbe[1][2],
      'elle' => verbe[1][2],
      'nous' => verbe[1][3],
      'vous' => verbe[1][4],
      'ils' => verbe[1][5],
      'elles' => verbe[1][5]
    },    
    ]
    p verbs
    
    @pronouns_words = @verbs[0].keys
    
    #~ @verbs[:singulier] = verbe[0][2]
    #~ @verbs[:pluriel] = verbe[0][5]
    
    @verbs_words = verbe.flatten #values.uniq
    
    @adjectifs = {}
    
    adjectifs.each do |adjectif|
      (0..3).each do |index|
        @adjectifs[adjectif[index]] = { 
          :masculin => { :singulier => adjectif[0], :pluriel => adjectif[1]}, 
          :feminin => { :singulier => adjectif[2], :pluriel => adjectif[3]} 
        }
      end
    end
    
    @adjectif_words = @adjectifs.keys

    @noms = {}
    
    noms.each do |nom_conjugue|
      @noms[nom_conjugue[1]] = { :genre => nom_conjugue[0].to_sym, :singulier => nom_conjugue[1], :pluriel => nom_conjugue[2] }
      @noms[nom_conjugue[2]] = { :genre => nom_conjugue[0].to_sym, :singulier => nom_conjugue[1], :pluriel => nom_conjugue[2] }
    end  
    
    @noun_words = @noms.keys
  end
  
  def adjective?(word)
    @adjectif_words.include?(word)
  end
  
  def verb?(word)
    @verbs_words.include?(word)
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

def corrected_sentence(sentence_string, verbe, adjectifs, noms)
  
  $dictionary = Dictionary.new(verbe, adjectifs, noms)
  
  Sentence.new(sentence_string).correct

end

# ----
# ----
# ----

require 'test/unit'

class TestsSession < Test::Unit::TestCase

  def setup
    
    
    
  end

  def test01
	  
    verbe = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectifs = []
    noms = []
    
    assert_equal "je mange", corrected_sentence("je manges", verbe, adjectifs, noms)
    
  end
      
  def test02
	  
    verbe = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectifs = []
    noms = []
    
    assert_equal "tu manges", corrected_sentence("tu mangent", verbe, adjectifs, noms)
    
  end   

  def test03
	  
    verbe = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectifs = []
    noms = []
    
    assert_equal "il mange", corrected_sentence("il mangent", verbe, adjectifs, noms)
    
  end  
  
  def test04
	  
    verbe = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectifs = []
    noms = []
    
    assert_equal "elle mange", corrected_sentence("elle manges", verbe, adjectifs, noms)
    
  end  

  def test05
	  
    verbe = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectifs = []
    noms = []
    
    assert_equal "nous mangeons", corrected_sentence("nous mangez", verbe, adjectifs, noms)
    
  end  
  
  def test06
	  
    verbe = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectifs = []
    noms = []
    
    assert_equal "vous mangez", corrected_sentence("vous mangeons", verbe, adjectifs, noms)
    
  end   
  
  def test07
	  
    verbe = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectifs = []
    noms = []
    
    assert_equal "ils mangent", corrected_sentence("ils mange", verbe, adjectifs, noms)
    
  end  

  def test08
	  
    verbe = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectifs = []
    noms = []
    
    assert_equal "ils mangent", corrected_sentence("ils mange", verbe, adjectifs, noms)
    
  end
  
  def test09
	  
    verbe = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectifs = []
    noms = []
    
    assert_equal "elles mangent", corrected_sentence("elles manges", verbe, adjectifs, noms)
    
  end  
  
  def test10
	  
    verbe = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectifs = [ ]
    noms = [ ['feminin', 'coccinelle', 'coccinelles'] ]
    
    assert_equal "la coccinelle mange", corrected_sentence("la coccinelle manges", verbe, adjectifs, noms)
    
  end  

  def test11
	  
    verbe = ['mange', 'manges', 'mange', 'mangeons', 'mangez', 'mangent']
    adjectifs = [ ]
    noms = [ ['masculin', 'renard', 'renards'] ]
    
    assert_equal "un renard mange", corrected_sentence("un renard mangent", verbe, adjectifs, noms)
    
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
    
    assert_equal "la coccinelle verte mange", corrected_sentence("la coccinelles vertes mangent", verbe, adjectifs, noms)
    
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

end