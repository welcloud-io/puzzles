#~ import java.util.*;
#~ import java.io.*;
#~ import java.math.*;

#~ class Solution {
class Solution

	#~ public static void main(String args[]) {
		
		# read two first lines
		#~ Scanner in = new Scanner(System.in);
		#~ int n = Integer.valueOf(in.nextLine().trim());
		#~ int q = Integer.valueOf(in.nextLine().trim());
		#~ n = Math.max(0, Math.min(n, 10000));
		#~ q = Math.max(0, Math.min(q, 10000));
		
		# put n next lines in a hash
		#~ Map<String, String> table = new HashMap<String, String>();
		#~ for (int i = 0; i < n; i++) {
		    #~ String[] assoc = in.nextLine().split(" ");
		    #~ table.put(assoc[0].toUpperCase(), assoc[1]);
		#~ }
		
		table = {}
		
		q = 0
		fichiers = ['..']
		
		# map each lines
		#~ for (int i = 0; i < q; i++) {
		for i in 0..q do
		    #~ String nomFichier = in.nextLine().trim();
		    nomFichier = fichiers[i]
		    #~ if (nomFichier.lastIndexOf(".") < 0)
		    if nomFichier.rindex(".") < 0
			#~ System.out.println("UNKNOWN");
			puts "UNKNOWN"
		    #~ else {
		    else
			#~ String ext = nomFichier.substring(nomFichier.lastIndexOf(".") + 1).toUpperCase();
			ext = nomFichier[nomFichier.rindex(".")..-1].upcase;
			#~ if (table.containsKey(ext))
			if table.has_key?(ext)
			    #~ System.out.println(table.get(ext));
			    puts table[ext]
			else
			    #~ System.out.println("UNKNOWN");
			    puts "UNKNOWN"
			#~ }
			end
		    end
		#~ }
		end
		
	#~ }
#~ }
end

#~ import java.util.*;
#~ import java.io.*;
#~ import java.math.*;

#~ class Solution {

	#~ public static void main(String args[]) {
		
		#~ # read two first lines
		#~ Scanner in = new Scanner(System.in);
		#~ int n = Integer.valueOf(in.nextLine().trim());
		#~ int q = Integer.valueOf(in.nextLine().trim());
		#~ n = Math.max(0, Math.min(n, 10000));
		#~ q = Math.max(0, Math.min(q, 10000));
		
		#~ # put n next lines in a hash
		#~ Map<String, String> table = new HashMap<String, String>();
		#~ for (int i = 0; i < n; i++) {
		    #~ String[] assoc = in.nextLine().split(" ");
		    #~ table.put(assoc[0].toUpperCase(), assoc[1]);
		#~ }
		
		#~ # map each lines
		#~ for (int i = 0; i < q; i++) {
		    #~ String nomFichier = in.nextLine().trim();
		    #~ if (nomFichier.lastIndexOf(".") < 0)
			#~ System.out.println("UNKNOWN");
		    #~ else {
			#~ String ext = nomFichier.substring(nomFichier.lastIndexOf(".") + 1).toUpperCase();
			#~ if (table.containsKey(ext))
			    #~ System.out.println(table.get(ext));
			#~ else
			    #~ System.out.println("UNKNOWN");
		    #~ }
		#~ }
		
	#~ }
#~ }