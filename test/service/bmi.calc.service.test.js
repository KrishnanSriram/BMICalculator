const {BMICalcService} = require("../../src/service/bmi.calc.service");

test("Test BMI service - w=16.6, h=99.1", () => {
  let weight = 16.6;
  let height = 99.1
  let bmi = new BMICalcService().calculate(weight, height);
  expect(bmi).toEqual("16.90");
})