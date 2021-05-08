const {BMICalcService} = require("./service/bmi.calc.service");
const {Handler} = require("./api/handler");

const RequestHandler = new Handler(new BMICalcService())

exports.performBMICalculation = RequestHandler.handleCalculation;