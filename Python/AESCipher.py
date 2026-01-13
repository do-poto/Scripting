import os
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes

#function for encrypting the file
def AESEncryption():
    #open file as byte input
    opened_file = open("Python\Test.txt", "rb")

    #generate block for GCM
    vector = os.urandom(128)
    #generate key of 32 byte length
    key = os.urandom(32)
    #initialize cipher with set algorithm, key, and mode
    cipher = Cipher(algorithms.AES256(key), modes.GCM(vector))
    
    #create encryptor with the cipher set
    AES_encryptor = cipher.encryptor()
    
    #encrypt data
    encrypted_file = AES_encryptor.update(opened_file.read()) + AES_encryptor.finalize()
    print(encrypted_file)




#running the function
AESEncryption()