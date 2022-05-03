#!/bin/bash

#cd contracts/circuits

#mkdir HelloWorld

if [ -f ./powersOfTau28_hez_final_10.ptau ]; then
    echo "powersOfTau28_hez_final_10.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_10.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_10.ptau
fi

echo "Compiling HelloWorld.circom..."

# compile circuit

circom Multiplier3.circom --r1cs --wasm --sym -o HelloWorld
snarkjs r1cs info HelloWorld/Multiplier3.r1cs

# Start a new zkey and make a contribution

snarkjs groth16 setup HelloWorld/Multiplier3.r1cs powersOfTau28_hez_final_10.ptau 
HelloWorld/circuit_0000.zkey
snarkjs zkey contribute HelloWorld/circuit_0000.zkey HelloWorld/circuit_finalM3.zkey --name="2nd Contrib M3" -v -e="random text"
snarkjs zkey export verificationkey HelloWorld/circuit_finalM3.zkey HelloWorld/verification_keyM3.json

# generate solidity contract
snarkjs zkey export solidityverifier HelloWorld/circuit_finalM3.zkey ../HelloWorldVerifierM3.sol

cd ../..
