#!/bin/bash

# [assignment] create your own bash script to compile Multipler3.circom modeling after compile-HelloWorld.sh below
circom Multiplier3.circom --r1cs --wasm --sym --c

if [[ $* == *--nodejs* ]]
then 
    echo "Using nodejs"
    cd circuit_js
    node generate_witness.js circuit.,wasm ../inputM3.json witness.wtns

else
    echo "Using cpp"
    cd circuit_cpp
    make circom  Multiplier3.circom /inputM3.json witness.wtns

fi



#cp witness.wtns ../witness.wtns

#cd ..

snarkjs powersoftau new bn128 pot12_0000.ptau -v

snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="I Did the Hard One First" -v -e="kjsdfk"

snarkjs powersoftau prepare phase2 pot12_0001.ptau pot12_final.ptau -v   

snarkjs groth16 setup circuit.rlcs pot12_final.ptau circuit_0000.zkey

snarkjs zkey contribute circuit_0000.zkey circuit_0001.zkey --name="still contrib hardest first" -v -e="kerjhf" 

snarkjs zkey export verificationkey circuit_0001.zkey verification_key.json

snarkjs groth16 prove circuit_0001.zkey witness.wtns proof.json public.json

snarkjs groth16 verify verification_key.json public.json proof.json


snarkjs zkey export solidityverifier circuit_0001.zkey verifierM3.sol

#snarkjs generatecall | tee parameters.txt

#done...booyah
