import datetime
from cryptography import x509
from cryptography.x509.oid import NameOID
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric import rsa

#function for certificate creation
def generate_certificate():
    #generate rsa key
    key = rsa.generate_private_key(
        public_exponent=65537,
        key_size=2048,
    )

    #signer details
    subject = issuer = x509.Name([
        x509.NameAttribute(NameOID.COUNTRY_NAME, "PL"),
        x509.NameAttribute(NameOID.STATE_OR_PROVINCE_NAME, "Dolnoslaskie"),
        x509.NameAttribute(NameOID.LOCALITY_NAME, "Wroclaw"),
        x509.NameAttribute(NameOID.ORGANIZATION_NAME, "PWR"),
        x509.NameAttribute(NameOID.COMMON_NAME, "mysite.com"),
    ])

    #generate certificate
    cert = x509.CertificateBuilder().subject_name(
        subject
    ).issuer_name(
        issuer
    ).public_key(
        key.public_key()
    ).serial_number(
        x509.random_serial_number()
    ).not_valid_before(
        datetime.datetime.now(datetime.timezone(datetime.timedelta(hours=+1)))
    ).not_valid_after(
        #validity length
        datetime.datetime.now(datetime.timezone(datetime.timedelta(hours=+1))) + datetime.timedelta(days=7)
    ).add_extension(
        x509.SubjectAlternativeName([x509.DNSName("localhost")]),
        critical=False,
    ).sign(key, hashes.SHA256())
    
    #save certificate
    with open("Python\SelfSignedCertificate.pem", "wb") as f:
        f.write(cert.public_bytes(serialization.Encoding.PEM))



#run function
generate_certificate()