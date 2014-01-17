def file_extension(file_name)
  return file_name.split('.')[1]
end

def file_extension(file_name)
  return file_name.split('.').last
end

def file_extension(file_name)
  return file_name.split('.').last if file_name.include?('.') and file_name[0] != '.'
end

def file_extension(file_name)
  extension = file_name.split('.').last if file_name.include?('.') and file_name[0] != '.'
  if extension == nil then return '' else return extension end
end

def file_extension(file_name)
  if file_name.include?('.') and file_name[0] != '.' then
    extension = file_name.split('.').last 
  else
    return ''
  end
  if extension == nil then return '' else return extension end
end

def file_extension(file_name)
  extension = file_name.split('.').last if file_name.include?('.') and file_name[0] != '.'
  extension || ''
end

# --------

def mime_types(file_list, mime_type)
  []
end

def mime_types(file_list, mime_type)
  
  mime_types = []
  
  for i in 0..file_list.size-1 do
    mime_types[i] = mime_type[file_extension(file_list[i])]
  end

  return mime_types

end


def mime_types(file_list, mime_type_hash)
  
  mime_types = []
  
  for i in 0..file_list.size-1 do
    mime_type = mime_type_hash[file_extension(file_list[i])]
    if mime_type != nil then 
      mime_types[i] = mime_type
    end
    if mime_type == nil then
      mime_types[i] = 'UNKNOWN'
    end
  end

  return mime_types

end

def mime_types(file_list, mime_type_hash)
  
  mime_types = []
  
  for i in 0..file_list.size-1 do
    mime_type = mime_type_hash[file_extension(file_list[i]).downcase]
    if mime_type == nil then mime_type= mime_type_hash[file_extension(file_list[i]).upcase] end
    if mime_type != nil then 
      mime_types[i] = mime_type
    end
    if mime_type == nil then
      mime_types[i] = 'UNKNOWN'
    end
  end

  return mime_types

end

def mime_types(file_list, mime_type_hash)
  
  mime_types = []
  i = 0
  
  file_list.each do |file_name|
    extension = file_extension(file_name)
    mime_type = mime_type_hash[extension.downcase] || mime_type_hash[extension.upcase]
    mime_types[i] = mime_type || 'UNKNOWN'
    i += 1
  end

  return mime_types

end

def mime_types(file_list, mime_type_hash)

  file_list.map do |file_name|
    extension = file_extension(file_name)
    mime_type_hash[extension.downcase] || mime_type_hash[extension.upcase] || 'UNKNOWN'
  end
  
end


require 'test/unit'

class TestsSession < Test::Unit::TestCase
	
  def test01
	  
    extension_hash = {}
    file_list = []
    
    assert_equal [], mime_types(file_list, extension_hash)
    
  end
  
  def test02
    assert_equal "html", file_extension("file.html")
    assert_equal "gif", file_extension("file.gif")
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

    extension_hash = { "png" => "image/png", "TIFF" => "image/TIFF", "css" => "text/css", "TXT" => "text/plain"}
    file_list = ["example.TXT", "referecnce.txt", "strangename.tiff", "resolv.CSS", "matrix.TiFF", "lanDsCape.Png", "extract.cSs"]   
    
    assert_equal  ["text/plain", "text/plain", "image/TIFF", "text/css", "image/TIFF", "image/png", "text/css"], mime_types(file_list, extension_hash)

  end
  
  def test15

    extension_hash = { }
    file_list = []   
    
    assert_equal  [], mime_types(file_list, extension_hash)

  end  

end






