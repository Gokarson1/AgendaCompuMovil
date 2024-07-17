require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const { Pool } = require('pg');
const app = express();
const port = process.env.PORT || 3002;

app.use(bodyParser.json());

// Configura la conexión a la base de datos PostgreSQL
const pool = new Pool({
  user: 'postgres',
  host: '34.176.244.121',
  database: 'postgres',
  password: 'Agendabulla',
  port: 5432,
});

// Endpoint de prueba "Hola Mundo"
app.get('/', (req, res) => {
  res.send('Hola Mundo');
});

app.post('/register', async (req, res) => {
  const { name, email } = req.body;

  try {
    const userCheck = await pool.query(
      'SELECT * FROM usuario WHERE email = $1',
      [email]
    );

    if (userCheck.rows.length > 0) {
      res.status(200).json({ message: 'usuario already exists' });
    } else {
      const result = await pool.query(
        'INSERT INTO usuario (name, email) VALUES ($1, $2) RETURNING id, name, email',
        [name, email]
      );
      res.status(200).json(result.rows[0]);
    }
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: err.message });
  }
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
