const express = require('express')
const mongoose = express('mongoose')
const cors = require('cors')
const bodyParser = require('body-parser')

const port = 3000

const itemRoutes = require('./routes/productoRoutes') // Import the item routes


const app = express(); // Create an Express application
app.use(cors()); // Enable CORS for all routes
app.use(bodyParser.json()); // Parse JSON request bodies

// Connect to MongoDB
mongoose.connect('mongodb://localhost:27017/miBaseDeDatos', {//Envío propiedad de conexión a la base de datos
  useNewUrlParser: true,// Usar la nueva URL de análisis de MongoDB
  useUnifiedTopology: true// Usar el nuevo motor de topología unificada de MongoDB
}).then(() => {
  console.log('Conectado a MongoDB')
}).catch(err => {
  console.error('Error al conectar a MongoDB', err)
})


// Use the item routes for all requests to /items
app.use('api/items', itemRoutes) // Use the item routes for all requests to /items
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`)
}
)


app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})