const mongoose = require('mongoose');

const usuarioSchema = new mongoose.Schema({
  nombre: String,
  edad: Number,
  correo: String,
  activo: Boolean  // Para la segunda actualización
});

module.exports = mongoose.model('Usuario', usuarioSchema);
