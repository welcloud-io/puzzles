# init
def mime_types(fichiers, table)

response = []

for i in 0..fichiers.size-1 do
    nomFichier = fichiers[i]
    if nomFichier.rindex(".") == nil
	response.push("UNKNOWN")
    else
	ext = nomFichier[nomFichier.rindex(".")+1..-1].downcase
	if table.has_key?(ext)
	    response.push(table[ext])
	else
	    response.push("UNKNOWN")
	end
    end
end

return response

end

# remove last if
def mime_types(fichiers, table)

response = []

for i in 0..fichiers.size-1 do
    nomFichier = fichiers[i]
    dot_index = nomFichier.rindex(".")
    if dot_index == nil
	response.push("UNKNOWN")
    else
	ext = nomFichier[dot_index+1..-1].downcase
        response.push(table[ext] || "UNKNOWN")
    end
end

return response

end

# remove for
def mime_types(fichiers, table)

response = []

fichiers.each do |nomFichier|
    dot_index = nomFichier.rindex(".")
    if dot_index == nil
	response.push("UNKNOWN")
    else
	ext = nomFichier[dot_index+1..-1].downcase
        response.push(table[ext] || "UNKNOWN")
    end
end

return response

end

# extract response from if
def mime_types(fichiers, table)

response = []

fichiers.each do |nomFichier|
    dot_index = nomFichier.rindex(".")
    if dot_index == nil
	ext = nil
    else
	ext = nomFichier[dot_index+1..-1].downcase
    end
    response.push(table[ext] || "UNKNOWN")
end

return response

end

# extract response from if
def mime_types(fichiers, table)

response = []

fichiers.each do |nomFichier|
    dot_index = nomFichier.rindex(".")
    ext = nil
    ext = nomFichier[dot_index+1..-1].downcase if dot_index != nil
    response.push(table[ext] || "UNKNOWN")
end

return response

end

# removing if
def mime_types(fichiers, table)

response = []

fichiers.each do |nomFichier|
    dot_index = nomFichier.rindex(".")
    ext = nil
    ext = nomFichier[dot_index+1..-1].downcase if dot_index != nil
    response.push(table[ext] || "UNKNOWN")
end

return response

end

# remove return 
def mime_types(fichiers, table)

response = []

fichiers.each do |nomFichier|
    dot_index = nomFichier.rindex(".")
    ext = nil
    ext = nomFichier[dot_index+1..-1].downcase if dot_index != nil
    response.push(table[ext] || "UNKNOWN")
end

response

end

# replacin push 
def mime_types(fichiers, table)

response = []

fichiers.each do |nomFichier|
    dot_index = nomFichier.rindex(".")
    ext = nil
    ext = nomFichier[dot_index+1..-1].downcase if dot_index != nil
    response << (table[ext] || "UNKNOWN")
end

response

end

# using map
def mime_types(fichiers, table)

fichiers.map do |nomFichier|
    dot_index = nomFichier.rindex(".")
    ext = nil
    ext = nomFichier[dot_index+1..-1].downcase if dot_index != nil
    table[ext] || "UNKNOWN"
end

end

# using unless
def mime_types(fichiers, table)

fichiers.map do |nomFichier|
    dot_index = nomFichier.rindex(".")
    ext = nil
    ext = nomFichier[dot_index+1..-1].downcase unless dot_index == nil
    table[ext] || "UNKNOWN"
end

end

# using File.extname
def mime_types(fichiers, table)

fichiers.map do |nomFichier|
    ext = File.extname(nomFichier)[1..-1]
    ext = ext.downcase if ext != nil
    table[ext] || "UNKNOWN"
end

end


# using File.extname
def mime_types(fichiers, table)

fichiers.map do |nomFichier|
    ext = File.extname(nomFichier)[1..-1]
    ext = ext.downcase if ext != nil
    table[ext] || "UNKNOWN"
end

end

# identation
def mime_types(fichiers, table)

  fichiers.map do |nomFichier|
    ext = File.extname(nomFichier)[1..-1]
    ext = ext.downcase if ext != nil
    table[ext] || "UNKNOWN"
  end

end


# extract method

def ext(nomFichier)
    ext = File.extname(nomFichier)[1..-1]
    ext = ext.downcase if ext != nil
end

def mime_types(fichiers, table)

  fichiers.map do |nomFichier|
    table[ext(nomFichier)] || "UNKNOWN"
  end

end

# nicing map
def ext(nomFichier)
    ext = File.extname(nomFichier)[1..-1]
    ext = ext.downcase if ext != nil
end

def mime_types(fichiers, table)
  fichiers.map { |nomFichier|  table[ext(nomFichier)] || "UNKNOWN" }
end


# nicing map
def ext(nomFichier)
    ext = File.extname(nomFichier)[1..-1]
    ext = ext.downcase if ext != nil
end

def mime_types(fichiers, table)
  fichiers.map { |nomFichier|  table[ext(nomFichier)] || "UNKNOWN" }
end

# changing names
def ext(file_name)
    ext = File.extname(file_name)[1..-1]
    ext = ext.downcase if ext != nil
end

def mime_types(file_names, mime_type_of)
  file_names.map { |file_name|  mime_type_of[ext(file_name)] || "UNKNOWN" }
end

# moving downcase
def ext(file_name)
  File.extname(file_name)[1..-1] || ""
end

def mime_types(file_names, mime_type_of)
  file_names.map { |file_name|  mime_type_of[ext(file_name).downcase] || "UNKNOWN" }
end

require 'test/unit'

class TestsSession < Test::Unit::TestCase

  def test03
    extension_hash = { "html" => "text/html" }
    file_list = ["file.html"]
    
    assert_equal ["text/html"], mime_types(file_list, extension_hash)
  end  

  def test03
	  
    extension_hash = { "html" => "text/html" }
    file_list = ["file.html"]
    
    assert_equal ["text/html"], mime_types(file_list, extension_hash)
    
  end  
  
  def test04
	  
    extension_hash = { "html" => "text/html" }
    file_list = ["file.html", "file.gif"]
    
    assert_equal ["text/html", "UNKNOWN"], mime_types(file_list, extension_hash)
    
  end
  
  def test05
	  
    extension_hash = { "html" => "text/html", "gif" => "image/gif" }
    file_list = ["file.html", "file.gif"]
    
    assert_equal ["text/html", "image/gif"], mime_types(file_list, extension_hash)
    
  end  
	
  def test11

    extension_hash = {"html" =>  "text/html", "png" => "image/png", "gif" => "image/gif" }
    file_list = ["animated.gif", "portrait.png", "index.html"]
    
    assert_equal  ["image/gif", "image/png", "text/html"], mime_types(file_list, extension_hash)

  end
  
  def test12
    
    extension_hash = {"txt" => "text/plain", "xml" =>  "text/xml", "flv" => "video/x-flv" }
    file_list = ["image.png", "animated.gif", "script.js", "source.cpp"]   
    
    assert_equal  ["UNKNOWN", "UNKNOWN", "UNKNOWN", "UNKNOWN"], mime_types(file_list, extension_hash)
    
  end
  
  def test13

    extension_hash = { "wav" => "audio/x-wav", "mp3" => "audio/mpeg", "pdf" => "application/pdf" }
    file_list = ["a", "a.wav", "b.wav.tmp", "test.vmp3", "pdf", "mp3", "report..pdf", "defaultwav", ".mp3.", "final."]   
    
    assert_equal  ["UNKNOWN", "audio/x-wav", "UNKNOWN", "UNKNOWN", "UNKNOWN", "UNKNOWN", "application/pdf", "UNKNOWN", "UNKNOWN", "UNKNOWN"], mime_types(file_list, extension_hash)

  end

  def test14

    #~ extension_hash = { "png" => "image/png", "TIFF" => "image/TIFF", "css" => "text/css", "TXT" => "text/plain"}
    extension_hash = { "png" => "image/png", "tiff" => "image/TIFF", "css" => "text/css", "txt" => "text/plain"}
    file_list = ["example.TXT", "referecnce.txt", "strangename.tiff", "resolv.CSS", "matrix.TiFF", "lanDsCape.Png", "extract.cSs"]   
    
    assert_equal  ["text/plain", "text/plain", "image/TIFF", "text/css", "image/TIFF", "image/png", "text/css"], mime_types(file_list, extension_hash)

  end
  
  def test15

    extension_hash = { }
    file_list = []   
    
    assert_equal  [], mime_types(file_list, extension_hash)

  end 
  
end