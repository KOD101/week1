pragma circom 2.0.0;

// [assignment] Modify the circuit below to perform a multiplication of three signals

template Multiplier3 (n) {  

   // Declaration of signals.  
   signal input a;  
   signal input b;
   signal output j;
   signal input c;
   signal output d;
   signal output k;  

   // Constraints.  
   j <== a*c;
    
   d <== (b*c)+ a;
   k <== (j*d)-(1-n);  
   
}

component main = Multiplier3(2);
