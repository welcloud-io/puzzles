table = {}

q = 0
fichiers = ['..']

for i in 0..q do
    nomFichier = fichiers[i]
    if nomFichier.rindex(".") < 0
	puts "UNKNOWN"
    else
	ext = nomFichier[nomFichier.rindex(".")..-1].upcase;
	if table.has_key?(ext)
	    puts table[ext]
	else
	    puts "UNKNOWN"
	end
    end
end


