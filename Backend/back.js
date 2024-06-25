// Importa los módulos necesarios
const express = require('express');
const bodyParser = require('body-parser');
const { Pool } = require('pg');

const app = express();
app.use(bodyParser.json());

// Configura la conexión a la base de datos PostgreSQL
const pool = new Pool({
  user: 'postgres',
  host: '34.176.244.121',
  database: 'postgres',
  password: 'Agendabulla',
  port: 5432,
});

// Endpoint para iniciar sesión con Google
app.post('/login/google', async (req, res) => {
  const { googleId, email, nombre } = req.body;

  // Verifica si el usuario existe en la base de datos
  const userExistsQuery = 'SELECT * FROM usuarios WHERE google_id = $1';
  const userExistsValues = [googleId];
  const userExistsResult = await pool.query(userExistsQuery, userExistsValues);

  if (userExistsResult.rows.length === 0) {
    // Si el usuario no existe, registra los datos en la base de datos
    const insertUserQuery = 'INSERT INTO usuarios (google_id, email, nombre) VALUES ($1, $2, $3)';
    const insertUserValues = [googleId, email, nombre];
    await pool.query(insertUserQuery, insertUserValues);

    res.status(200).send('Usuario registrado correctamente.');
  } else {
    // Si el usuario ya existe, inicia sesión
    res.status(200).send('Inicio de sesión exitoso.');
  }
});

// Escucha las solicitudes en el puerto 3000
app.listen(3000, () => {
  console.log('Servidor backend iniciado en el puerto 3000.');
});


// Endpoint para obtener tarea
app.get('/tasks', async (req, res) => {
  const { user } = req.query;

  const tasksQuery = 'SELECT * FROM tareas WHERE usuario_google_id = $1';
  const tasksValues = [user];

  try {
    const tasksResult = await pool.query(tasksQuery, tasksValues);
    res.status(200).json(tasksResult.rows);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error al obtener las tareas.');
  }
});

// Endpoint para crear tarea
app.post('/tasks', async (req, res) => {
  const { usuarioGoogleId, titulo, descripcion, fechaVencimiento } = req.body;

  const insertTaskQuery = `
    INSERT INTO tareas (usuario_google_id, titulo, descripcion, fecha_vencimiento)
    VALUES ($1, $2, $3, $4) RETURNING *
  `;
  const insertTaskValues = [usuarioGoogleId, titulo, descripcion, fechaVencimiento];

  try {
    const insertTaskResult = await pool.query(insertTaskQuery, insertTaskValues);
    res.status(201).json(insertTaskResult.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error al crear la tarea.');
  }
});

//Endpoint para actalizar tarea
app.post('/tasks', async (req, res) => {
  const { usuarioGoogleId, titulo, descripcion, fechaVencimiento } = req.body;

  const insertTaskQuery = `
    INSERT INTO tareas (usuario_google_id, titulo, descripcion, fecha_vencimiento)
    VALUES ($1, $2, $3, $4) RETURNING *
  `;
  const insertTaskValues = [usuarioGoogleId, titulo, descripcion, fechaVencimiento];

  try {
    const insertTaskResult = await pool.query(insertTaskQuery, insertTaskValues);
    res.status(201).json(insertTaskResult.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error al crear la tarea.');
  }
});

//Borrar tarea

app.delete('/tasks/:id', async (req, res) => {
  const { id } = req.params;

  const deleteTaskQuery = 'DELETE FROM tareas WHERE id = $1';
  const deleteTaskValues = [id];

  try {
    await pool.query(deleteTaskQuery, deleteTaskValues);
    res.status(204).send();
  } catch (error) {
    console.error(error);
    res.status(500).send('Error al eliminar la tarea.');
  }
});
