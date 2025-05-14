const express = require('express');
const router = express.Router();
const Usuario = require('../models/usuario');

// Ruta para insertar usuarios
router.get('/insertar', async (req, res) => {
  const usuarios = [
    { nombre: "Juan Pérez", edad: 30, correo: "juan.perez@urosario.com" },
    { nombre: "Ana López", edad: 25, correo: "ana.lopez@urosario.com" },
    { nombre: "Luis Torres", edad: 35, correo: "luis.torres@urosario.com" }
  ];

  try {
    await Usuario.insertMany(usuarios);
    res.send("Usuarios insertados correctamente.");
  } catch (error) {
    res.status(500).send("Error al insertar usuarios: " + error.message);
  }
});


// Ruta para obtener todos los usuarios
router.get('/consultar', async (req, res) => {
  try {
    const usuarios = await Usuario.find(); // Consulta todos los usuarios
    res.json(usuarios); // Envía la lista como JSON
  } catch (error) {
    res.status(500).send("Error al obtener usuarios: " + error.message);
  }
});

// Ruta para buscar un usuario por nombre
router.get('/buscar/:nombre', async (req, res) => {// :nombre es un parámetro de la URL, pero buscar es el nombre de la ruta
  try {
    const nombreBuscado = req.params.nombre;//para que yo pueda buscar el nombre que quiera poniendolo en la url
    const usuario = await Usuario.findOne({ nombre: nombreBuscado });

    if (usuario) {
      res.json(usuario);
    } else {
      res.status(404).send("Usuario no encontrado.");
    }
  } catch (error) {
    res.status(500).send("Error al buscar usuario: " + error.message);
  }
});

// Ruta para obtener usuarios mayores o iguales a 30 años
router.get('/mayores30', async (req, res) => {
  try {
    const usuarios = await Usuario.find({ edad: { $gte: 30 } }); // edad mayor o igual a 30
    res.json(usuarios); // Envía la lista como JSON
  } catch (error) {
    res.status(500).send("Error al obtener usuarios mayores de 30 años: " + error.message);
  }
});

// Ruta para actualizar la edad de Juan Pérez a 31 años
router.get('/actualizarJuan', async (req, res) => {
  try {
    const resultado = await Usuario.updateOne(
      { nombre: "Juan Pérez" },           // Filtro
      { $set: { edad: 31 } }              // Actualización
    );

    if (resultado.modifiedCount === 0) {
      res.status(404).send("Juan Pérez no fue encontrado o ya tiene 31 años.");
    } else {
      res.send("Edad de Juan Pérez actualizada a 31 años.");
    }
  } catch (error) {
    res.status(500).send("Error al actualizar usuario: " + error.message);
  }
});

// Ruta para añadir el campo activo: true a usuarios con edad >= 30
router.get('/activar30', async (req, res) => {
  try {
    const resultado = await Usuario.updateMany(
      { edad: { $gte: 30 } },            // edad >= 30
      { $set: { activo: true } }         // Actualización: añadir o modificar el campo "activo"
    );

    res.send(`Usuarios actualizados: ${resultado.modifiedCount}`);
  } catch (error) {
    res.status(500).send("Error al actualizar usuarios: " + error.message);
  }
});

// Ruta para eliminar al usuario "Luis Torres"
router.get('/eliminarLuis', async (req, res) => {
  try {
    const resultado = await Usuario.deleteOne({ nombre: "Luis Torres" });

    if (resultado.deletedCount === 0) {
      res.status(404).send("Luis Torres no fue encontrado.");
    } else {
      res.send("Usuario Luis Torres eliminado correctamente.");
    }
  } catch (error) {
    res.status(500).send("Error al eliminar usuario: " + error.message);
  }
});

// Ruta para Elimina todos los usuarios menores de 30 años.
router.get('/eliminar30', async (req, res) => {
  try {
    const resultado = await Usuario.deleteMany({ edad: { $lt: 30 } });

    if (resultado.deletedCount === 0) {
      res.send("No se encontraron usuarios menores de 30 años.");
    } else {
      res.send(`Usuarios eliminados: ${resultado.deletedCount}`);
    }
  } catch (error) {
    res.status(500).send("Error al eliminar usuarios: " + error.message);
  }
});

module.exports = router;
