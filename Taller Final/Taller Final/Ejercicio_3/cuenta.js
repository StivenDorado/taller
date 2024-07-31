class CuentaBancaria {
    #tipocuenta;

    constructor(nombreTitular, saldo, tipocuenta) {
        this.nombreTitular = nombreTitular;
        this.saldo = saldo;
        this.#tipocuenta = tipocuenta;
    }

    // Metodos
    depositar(monto) {
        if (monto > 0) {
            this.saldo += monto; // Agrega el monto al saldo
        } else {
            return "El monto a depositar debe ser positivo.";
        }
    }

    retirar(monto) {
        if (monto > 0) {
            if (monto <= this.saldo) {
                this.saldo -= monto; // Resta el monto del saldo
            } else {
                return "Fondos insuficientes.";
            }
        } else {
            return "El monto a retirar debe ser positivo.";
        }
    }

    consultarSaldo() {
        return this.saldo;
    }

    mostrarInformación() {
        return `El nombre del Titular es: ${this.nombreTitular}
El saldo de su cuenta es: ${this.saldo}
El tipo de cuenta es: ${this.#tipocuenta}`;
    }
}

// Instancias
const cuenta1 = new CuentaBancaria('Pablo Escobar', 250000000000, 'Ahorro de Cocaína');

// Agregar saldo y quitar
console.log(cuenta1.depositar(1000000000000)); 
console.log(cuenta1.retirar(500000000000));   

console.log(cuenta1.mostrarInformación());
