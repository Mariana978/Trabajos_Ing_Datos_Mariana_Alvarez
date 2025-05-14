const express = require('express');
const mongoose = require('mongoose');
const usuarioRoutes = require('./routes/usuarioRoutes'); 
const productoRoutes = require('./routes/productoRoutes');

const app = express();
app.use(express.json());

// Definir el puerto como constante
const PORT = 3000;

// Conectar a MongoDB
mongoose.connect('mongodb://localhost:27017/tallerMongoDB', {
  useNewUrlParser: true,
  useUnifiedTopology: true
}).then(() => console.log(' Conectado a MongoDB'))
  .catch((err) => console.error('Error al conectar a MongoDB:', err));

app.use('/usuarios', usuarioRoutes);
app.use('/productos', productoRoutes);

// Inicia el servidor usando la constante PORT
app.listen(PORT, () => {
  console.log(` Servidor iniciado en http://localhost:${PORT}`);
});
