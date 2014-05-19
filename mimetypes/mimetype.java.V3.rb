# Lecture des entrées

#~ N = STDIN.gets.to_i
#~ Q = STDIN.gets.to_i

#~ mime_type_of = {}
#~ N.times do
  #~ extension, mime_type = STDIN.gets.split
  #~ mime_type_of[extension.downcase] = mime_type
#~ end
#~ #p mime_type_of

#~ files = []
#~ Q.times do
  #~ files << STDIN.gets.strip
#~ end
#~ #p files

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

# moving downcase in ext function
def ext(file_name)
  (File.extname(file_name)[1..-1] || "").downcase
end

def mime_types(file_names, mime_type_of)
  file_names.map { |file_name|  mime_type_of[ext(file_name)] || "UNKNOWN" }
end


## ----------------------------------------------------
## ----------- JAVA VERSION (BEGIN)----
## ----------------------------------------------------

class Solution

  def Solution.main(table, fichiers)
    types_mimes = Array.new();
    for i in 0..fichiers.size-1 do
      nomFichier = fichiers[i];
      if (nomFichier.rindex(".") == nil)
        types_mimes.push("UNKNOWN");
      else
        ext = nomFichier[nomFichier.rindex(".")+1, 
	                           nomFichier.size-1];
        ext = ext.downcase;
        if (table.has_key?(ext))
          types_mimes.push(table[ext]);
        else
          types_mimes.push("UNKNOWN");
        end
      end
      i = i + 1;
    end
    return types_mimes;
  end
	
end

def mime_types(table, fichiers)
  Solution.main(table, fichiers);
end


## ----------------------------------------------------
## ----------- JAVA VERSION (END)----
## ----------------------------------------------------

## ----------------------------------------------------
## ----------- RUBY VERSION (END)----
## ----------------------------------------------------
def ext(file_name)
  (File.extname(file_name)[1..-1] || "").downcase
end

def mime_types(mime_type_of, file_names)
  file_names.map { |file_name|  mime_type_of[ext(file_name)] || 'UNKNOWN' }
end
## ----------------------------------------------------
## ----------- RUBY VERSION (END)----
## ----------------------------------------------------



require 'test/unit'

class TestMimeType < Test::Unit::TestCase

  def test01_empty_list

    extension_hash = { 
    }
    file_list = [
    ]
    assert_equal [
    ], mime_types(extension_hash, file_list)
    
  end

  def test02_one_file_list_with_one_known_mime_type

    extension_hash = { 
    "html" => "text/html" 
    }
    file_list = [
    "file.html"
    ]
    assert_equal [
    "text/html"
    ], mime_types(extension_hash, file_list)
    
  end  

  def test03_two_files_list_with_two_known_mime_types

    extension_hash = { 
    "html" => "text/html", 
    "gif" => "image/gif" 
    }
    file_list = [
    "file.html", 
    "file.gif"
    ]
    assert_equal [
    "text/html", 
    "image/gif"
    ], mime_types(extension_hash, file_list)
    
  end

  def test04_two_files_list_with_one_UNKNOWN_mime_type

    extension_hash = { 
    "html" => "text/html" 
    }
    file_list = [
    "file.html", 
    "file.gif"
    ]
    assert_equal [
    "text/html", 
    "UNKNOWN"
    ], mime_types(extension_hash, file_list)
    
  end
  
  def test05_file_list_with_particular_extensions
    extension_hash = { 
    "wav" => "audio/x-wav", 
    "mp3" => "audio/mpeg", 
    "pdf" => "application/pdf" 
    }
    file_list = [
    "a", 
    "a.wav", 
    "b.wav.tmp", 
    "test.vmp3", 
    "pdf", "mp3", 
    "report..pdf", 
    "defaultwav", 
    ".mp3.", "final."
    ]
    assert_equal  [
    "UNKNOWN", 
    "audio/x-wav", 
    "UNKNOWN", 
    "UNKNOWN", 
    "UNKNOWN", 
    "UNKNOWN", 
    "application/pdf", 
    "UNKNOWN", 
    "UNKNOWN", 
    "UNKNOWN"
    ], mime_types(extension_hash, file_list)

  end

  def test06_file_list_with_upper_or_lower_case_extensions

    extension_hash = { 
    "png" => "image/png", 
    "tiff" => "image/TIFF", 
    "css" => "text/css", 
    "txt" => "text/plain"
    }
    file_list = [
    "example.TXT", 
    "referecnce.txt", 
    "strangename.tiff", 
    "resolv.CSS", 
    "matrix.TiFF", 
    "lanDsCape.Png", 
    "extract.cSs"
    ]
    assert_equal  [
    "text/plain", 
    "text/plain", 
    "image/TIFF", 
    "text/css", 
    "image/TIFF", 
    "image/png", 
    "text/css"
    ], mime_types(extension_hash, file_list)
    
  end
  
end