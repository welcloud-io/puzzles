# Read inputs from Standard Input.
# Write outputs to Standard Output.

require 'test/unit'

class TestsSession < Test::Unit::TestCase
  
# ---- sentence

def get_verb_from(sentence)
  @verbe_conjugue_au_present.uniq.select { |declinaison| sentence.split.include?(declinaison) }[0]
end

def get_subject_from(sentence)
  verbe = get_verb_from(sentence)  
  sentence.split(verbe)[0].strip.split
end

def get_complement_from(sentence)
  verbe = get_verb_from(sentence)
  (sentence.split(verbe)[1] || "").strip.split
end

# -- verbe

def correct_verb_with_pronoun(pronoun)
  @verbe_conjugue[pronoun.to_sym]  
end

def correct_verb_with_article(article)
  pronoun = get_nombre(article)
  @verbe_conjugue[pronoun.to_sym]
end

def pronoun?(sujet)
  @pronouns.keys.include?(sujet)
end

def correct_verb(subject)
    if pronoun?(subject[0])
        correct_verb_with_pronoun(subject[0])
    else
        correct_verb_with_article(subject[0])
    end
end

# -- groupe nominal

def find_noun(nominal)
    nominal.reject { |word| @all_but_nouns.include?(word) }[0]
end
  
def get_adjectifs(nominal)
  nominal.select { |word| @adjectifs_conjugues.flatten.include?(word) }
end  

def get_genre(noun)
    nom_conjugue = @noms_conjugues.select { |noms|  noms.include?(noun) }[0]
    nom_conjugue[0]
end

def get_nombre(article)
    @nombre[article]
end

def correct_adjectif(adjectif, genre, nombre)
  adjectif_decline = @adjectifs.select { |adjectif_conjugue|  adjectif_conjugue.keys.flatten.include?(adjectif) }[0]
  adjectif_decline[adjectif_decline.keys[0]][genre.to_sym][nombre.to_sym]
end

def correct_noun(noun, nombre)
  noun_decline = @noms.select { |nom_conjugue|  nom_conjugue.keys.flatten.include?(noun) }[0]
  noun_decline[noun_decline.keys[0]][nombre.to_sym]   
end

def correct_word(word, genre, nombre, type)
    if type == 'adjective'
        correct_adjectif(word, genre, nombre)
    else
        correct_noun(word, nombre)
    end
end
  
def get_nominal_noun_genre_et_nombre(nominal)
  noun = find_noun(nominal)
  genre = get_genre(noun)
  nombre = get_nombre(nominal[0])  
  return noun, genre, nombre
end  

def correct_nominal(nominal)
    if pronoun?(nominal[0])
        nominal
    else
        noun, genre, nombre = get_nominal_noun_genre_et_nombre(nominal)
        adjectifs = get_adjectifs(nominal)
        nominal.map do |word|
          if word == noun then
            correct_word(word, genre, nombre, 'noun') 
          elsif adjectifs.include?(word)
            correct_word(word, genre, nombre, 'adjective')
          else
            word 
          end
        end
    end
end

#process the input

def corrected_sentence(sentence, verbe_conjugue_au_present, adjectifs_conjugues, noms_conjugues)
  
  @verbe_conjugue_au_present = verbe_conjugue_au_present
  @all_but_nouns += @verbe_conjugue_au_present

  @adjectifs_conjugues = []
  adjectifs_conjugues.each do | adjectif_conjugue |
      @adjectifs_conjugues << adjectif_conjugue
      @all_but_nouns += adjectif_conjugue
  end

  @noms_conjugues = []
  noms_conjugues.each do |nom_conjugue|
      @noms_conjugues << nom_conjugue
  end
  
  @verbe_conjugue = {
    :je => verbe_conjugue_au_present[0],
    :tu => verbe_conjugue_au_present[1],
    :il => verbe_conjugue_au_present[2],
    :elle => verbe_conjugue_au_present[2],
    :singulier => verbe_conjugue_au_present[2],
    :nous => verbe_conjugue_au_present[3],
    :vous => verbe_conjugue_au_present[4],
    :ils => verbe_conjugue_au_present[5],
    :elles => verbe_conjugue_au_present[5],
    :pluriel => verbe_conjugue_au_present[5],
  }
  

  @adjectifs = adjectifs_conjugues.map do |adjectif_conjugue|
    { 
    adjectif_conjugue => { 
      :masculin => { :singulier => adjectif_conjugue[0], :pluriel => adjectif_conjugue[1]}, 
      :feminin => { :singulier => adjectif_conjugue[2], :pluriel => adjectif_conjugue[3]} 
    }
    }
  end
  
  @noms =   noms_conjugues.map do |nom_conjugue|
    {
      nom_conjugue => {
        :genre => nom_conjugue[0],
        :singulier => nom_conjugue[1],
        :pluriel => nom_conjugue[2]
      }
    }
  end
  
  #~ [ 'noms', { :feminin => { :singulier => '', :pluriel => ''} } ]
  



  subject = get_subject_from(sentence)
  verb = get_verb_from(sentence)
  complement = get_complement_from(sentence)

  corrected_sentence = []

  corrected_verb = correct_verb(subject)
  corrected_subject = correct_nominal(subject)

  corrected_sentence += corrected_subject
  corrected_sentence << corrected_verb

  if complement.size > 0
      corrected_complement = correct_nominal(complement)
      corrected_sentence += corrected_complement
  end
    
  corrected_sentence.join(' ')
  
end

# ----
# ----
# ----
  
  def setup

    @all_but_nouns = []

    @pronouns = {
        "je" => 0, 
        "tu" => 1,
        "il" => 2,
        "elle" => 2,
        "nous" => 3,
        "vous" => 4,
        "ils" => 5,
        "elles" => 5
    }

    @all_but_nouns += @pronouns.keys

    @nombre = {
        "un" => "singulier",
        "une" => "singulier",
        "le" => "singulier",
        "la" => "singulier",
        "les" => "pluriel",
        "des" => "pluriel"
    }

    @all_but_nouns += @nombre.keys

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