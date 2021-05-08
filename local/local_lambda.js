const express = require('express');
const body_parser = require('body-parser');
const http = require('http');
const {BMICalcService} = require("../src/service/bmi.calc.service");
const {Handler} = require("../src/api/handler");

const RequestHandler = new Handler(new BMICalcService())
// express
const app = express();
app.use(body_parser.json());
app.use(express.json());
app.use(express.urlencoded({extended: false}));
app.route('/bmi').get(async (req, res) => {
  let event = {};
  event.queryStringParameters = {
    "weight": req.query['weight'],
    'height': req.query['height']
  };
  const result = await RequestHandler.handleCalculation(event);
  res.status(result.statusCode).json(result.body);
});

const server = http.createServer(app);
const PORT = 8000;
server.listen(PORT);
console.log(`Server started & /bmi is open in port - ${PORT}`);
module.exports = app;