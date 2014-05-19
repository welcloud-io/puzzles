# ---- sentence

def get_verb_from(sentence)
  sentence_words = sentence.split
  @verbe.values.uniq.select { |declinaison| sentence_words.include?(declinaison) }[0]
end

def get_subject_from(sentence)
  verbe = get_verb_from(sentence)  
  sentence.split(verbe)[0].strip
end

def get_complement_from(sentence)
  verbe = get_verb_from(sentence)
  (sentence.split(verbe)[1] || "").strip
end

# -- verbe

def correct_verb(sujet)
  first_word = sujet.split.first
  personne = first_word if @verbe.keys.include?(first_word)
  personne = @articles_hash[first_word].to_sym if @articles_hash.keys.include?(first_word)
  return @verbe[personne]
end

# -- groupe nominal

def find_noun(nominal)
  nominal.select { |word| @noun_words.include?(word) }[0]
end

def correct_nominal(nominal)
    return nil if nominal == ""
    return nominal if @verbe.keys.include?(nominal.split.first)
    
    nominal_words = nominal.split

    noun = find_noun(nominal_words)
    genre = @noms[noun][:genre].to_sym
    nombre = @articles_hash[nominal_words.first].to_sym

    nominal_words.map do |word|
      case
        when @noun_words.include?(word) then @noms[word][nombre]  
        when @adjectif_words.include?(word)  then @adjectifs[word][genre][nombre]
        else word
      end
    end.join(' ')

end

#process the input

def corrected_sentence(sentence, verbe_conjugue_au_present, adjectifs_conjugues, noms_conjugues)
  
  @articles_hash = {"un" => "singulier", "une" => "singulier", "le" => "singulier", "la" => "singulier", "les" => "pluriel", "des" => "pluriel" }  

  @verbe = {
    'je' => verbe_conjugue_au_present[0],
    'tu' => verbe_conjugue_au_present[1],
    'il' => verbe_conjugue_au_present[2],
    'elle' => verbe_conjugue_au_present[2],
    'nous' => verbe_conjugue_au_present[3],
    'vous' => verbe_conjugue_au_present[4],
    'ils' => verbe_conjugue_au_present[5],
    'elles' => verbe_conjugue_au_present[5]
  }
  
  @verbe[:singulier] = verbe_conjugue_au_present[2]
  @verbe[:pluriel] = verbe_conjugue_au_present[5]
  
  @adjectifs = {}
  
  adjectifs_conjugues.each do |adjectif_conjugue|
    (0..3).each do |index|
      @adjectifs[adjectif_conjugue[index]] = { 
        :masculin => { :singulier => adjectif_conjugue[0], :pluriel => adjectif_conjugue[1]}, 
        :feminin => { :singulier => adjectif_conjugue[2], :pluriel => adjectif_conjugue[3]} 
      }
    end
  end
  
  @adjectif_words = @adjectifs.keys

  @noms = {}
  
  noms_conjugues.each do |nom_conjugue|
    @noms[nom_conjugue[1]] = { :genre => nom_conjugue[0], :singulier => nom_conjugue[1], :pluriel => nom_conjugue[2] }
    @noms[nom_conjugue[2]] = { :genre => nom_conjugue[0], :singulier => nom_conjugue[1], :pluriel => nom_conjugue[2] }
  end  
  
  @noun_words = @noms.keys
  
  subject = get_subject_from(sentence)
  verb = get_verb_from(sentence)
  complement = get_complement_from(sentence)
  
  corrected_sentence = [correct_nominal(subject), correct_verb(subject), correct_nominal(complement)].join(' ').strip
  
  return corrected_sentence
  
end

# ----
# ----
# ----

require 'test/unit'

class TestsSession < Test::Unit::TestCase

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