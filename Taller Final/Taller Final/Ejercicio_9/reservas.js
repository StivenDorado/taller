class ReservaHotel {
    #habitacionAsignada;

    constructor(nombreCliente, fechaReserva) {
        this.nombreCliente = nombreCliente;
        this.fechaReserva = fechaReserva;
        this.#habitacionAsignada = null;
    }

    // Metodos
    reservarHabitacion(habitacion) {
        if (this.#habitacionAsignada === null) {
            this.#habitacionAsignada = habitacion;
            return `Habitación ${habitacion} reservada para ${this.nombreCliente} en la fecha ${this.fechaReserva}.`;
        } else {
            return `Ya hay una habitación reservada para ${this.nombreCliente}.`;
        }
    }

    cancelarReserva() {
        if (this.#habitacionAsignada !== null) {
            const habitacionCancelada = this.#habitacionAsignada;
            this.#habitacionAsignada = null;
            return `Reserva cancelada. La habitación ${habitacionCancelada} esta disponible.`;
        } else {
            return `No hay ninguna reserva para cancelar.`;
        }
    }

    mostrarReserva() {
        if (this.#habitacionAsignada !== null) {
            return `Nombre del Cliente: ${this.nombreCliente}
                    Fecha de Reserva: ${this.fechaReserva}
                    Habitación Asignada: ${this.#habitacionAsignada}`;
        } else {
            return `No hay ninguna habitación reservada para ${this.nombreCliente}.`;
        }
    }
}

// Instancias
const reserva1 = new ReservaHotel("Beto", "2025-08-16");
console.log(reserva1.reservarHabitacion("11B"));
console.log(reserva1.mostrarReserva());
console.log(reserva1.cancelarReserva());
console.log(reserva1.mostrarReserva());
