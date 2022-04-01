import java.sql.Time;
import java.time.*;
import java.util.Hashtable;

public class App {
	
	public static void main(String[] args) {
		
		Instant inicio, fim;
		//FreqTable table = new FreqTable(3);
		
		Hashtable<Character,Double> table = new Hashtable<Character,Double>();
		
		String str = "aa bb cccc ddddddddd eeeeeeeeeee";  
        double[] freq = new double[str.length()];  
        int i, j;  
          


        //Converts given string into character array  
        char string[] = str.toCharArray();  
        

        for(i = 0; i <str.length(); i++) {  
            freq[i] = 1;  
            for(j = i+1; j <str.length(); j++) {  
                if(string[i] == string[j]) {  
                    freq[i]++;  
                      
                    //Set string[j] to 0 to avoid printing visited character  
                    string[j] = '0';  
                }  
            }  
		}
		int contSimbolos = 0;
		for(i = 0; i <freq.length; i++) {  
            if(string[i] != ' ' && string[i] != '0')  
				contSimbolos += freq[i];
		} 

          
        //Displays the each character and their corresponding frequency  
        for(i = 0; i <freq.length; i++) {  
            if(string[i] != ' ' && string[i] != '0')  
				table.put(string[i], (freq[i]/contSimbolos)*100);
		} 



		inicio = Instant.now();
		HuffmanEncoding hf = new HuffmanEncoding(table);
		fim = Instant.now();

		
		//hf.printEncoding();
		String auxil = " c ";

		for (int x=0; x<str.length();x++){//CODIFICA
			if(str.charAt(x) != ' ' && str.charAt(x) != '0'){ 
			   hf.printEncodingLetra(str.charAt(x));
			}
		}

		System.out.println(" a " + hf.getPalavra());

		
		//System.out.println(HuffmanEncoding.decoding("1100", hf.bt));
		
		long nanos = Duration.between(inicio, fim).toNanos();
		System.out.println("... "+ nanos);

		
	}
	
}
