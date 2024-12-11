import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';

// Pages and Components
import LandingPage from './pages/inicio/landingPage';
import LoginComponent from './components/LoginComponent';
import RegisterComponent from './components/RegisterComponent';
import ListUser from './pages/user/users';

// Componente de ruta protegida
const ProtectedRoute = ({ children }) => {
  // Verifica si el usuario está autenticado (puedes ajustar esta lógica según tu backend)
  const isAuthenticated = !!localStorage.getItem('token');

  if (!isAuthenticated) {
    // Redirige al login si no está autenticado
    return <Navigate to="/login" replace />;
  }

  return children;
};

function App() {
  return (
    <Router>
      <Routes>
        {/* Ruta principal para LandingPage */}
        <Route path="/" element={<LandingPage />} />
        
        {/* Rutas de autenticación */}
        <Route path="/login" element={<LoginComponent />} />
        <Route path="/registro" element={<RegisterComponent />} />
        
        {/* Rutas protegidas */}
        <Route 
          path="/users" 
          element={
            <ProtectedRoute>
              <ListUser />
            </ProtectedRoute>
          } 
        />
        
        {/* Ruta de redireccionamiento por defecto */}
        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
    </Router>
  );
}

export default App;
