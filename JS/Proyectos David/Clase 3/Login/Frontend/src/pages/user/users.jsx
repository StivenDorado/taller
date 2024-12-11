import React from 'react';
import { useNavigate } from 'react-router-dom';

const ListUser = () => {
  const navigate = useNavigate();

  // Funciones para manejar la navegación
  const handleInicio = () => {
    navigate('/Login'); // Navega a la página de inicio
  };

  const handleCerrarSesion = () => {
    // Lógica para cerrar sesión
    // Aquí podrías hacer:
    // 1. Limpiar tokens de autenticación
    // 2. Limpiar estado de usuario
    // 3. Redirigir a página de login
    localStorage.removeItem('token'); // Ejemplo de limpieza de token
    navigate('/login'); // Redirigir a login
  };

  return (
    <>
      <div className="relative w-full min-h-screen overflow-hidden bg-black">
        {/* Imagen de fondo */}
        <div
          className="absolute inset-0 bg-cover bg-center"
          style={{
            backgroundImage:
              'url("https://i.pinimg.com/originals/49/cd/d8/49cdd838e8c6d7fe5e2dd55deead5567.gif")',
          }}
        />

        {/* Capa de superposición */}
        <div className="absolute inset-0 bg-black opacity-50 z-10" />

        {/* Encabezado */}
        <header className="relative z-20 flex justify-between items-center px-8 py-6 w-full">
          {/* Logo */}
          <img
            src="/api/placeholder/150/50"
            alt="Logo"
            className="h-12 object-contain"
          />
          {/* Navegación */}
          <nav className="flex space-x-4">
            <button
              onClick={handleInicio}
              className="py-2 px-6 bg-gradient-to-r from-red-400 to-pink-500 text-white rounded-lg hover:opacity-90 transition shadow-md"
            >
              Inicio
            </button>
            <button
              onClick={handleCerrarSesion}
              className="py-2 px-6 bg-gradient-to-r from-blue-400 to-blue-600 text-white rounded-lg hover:opacity-90 transition shadow-md"
            >
              Cerrar Sesión
            </button>
          </nav>
        </header>

        {/* Contenido principal */}
        <div className="relative z-20 flex flex-col justify-center items-center h-[calc(100vh-100px)] text-center text-white px-6">
          <h3 className="text-2xl md:text-5xl lg:text-5xl font-bold mb-4 shadow-lg">
            Bienvenido a Tu Sitio Web
          </h3>
          <button
            className="mt-6 py-3 px-8 bg-gradient-to-r from-blue-400 to-gray-500 text-white rounded-lg hover:opacity-90 transition shadow-lg text-lg"
          >
            Explorar Ahora
          </button>
        </div>
      </div>
    </>
  );
};

export default ListUser;