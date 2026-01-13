import socket

#scan the given port and ip
def scan(ip, port):
    #initialize scanner  
    scanner = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    scanner.settimeout(1)
    #scan port
    result = scanner.connect_ex((ip, port))
    #close scanner
    scanner.close()
    return result


#start funciton
def start():
    #gather target information
    target = input("Provide target ip: ")
    ports_amount = int(input("How many ports to check: "))

    #initialize array
    ports_check = []

    #start i var
    i = 0
    #fill the ports
    while i < ports_amount:
        port_given = int(input("Provide a port: "))
        ports_check.append(port_given)
        i+=1

    #initialize scanning function
    for ports in ports_check:
        temp = scan(target, ports)
        if temp == 0:
            print(f"Port {ports} is open.")

start()

