const Result = require("./Result");

class Handler {
  constructor(bmiCalcService) {
    this.handleCalculation = async (event, context, callback) => {
      console.log(event);
      try {
        let weight = event.queryStringParameters.weight;
        let height = event.queryStringParameters.height;
        if(isNaN(weight) || isNaN(height)) {
          return new Result.BadRequest_400('Weight or Height is not a number');
        }
        let bmiResult = await this.calcService.calculate(weight, height);
        return new Result.OK_200(bmiResult);
      } catch(e) {
        return new Result.InternalServerError_500(e);
      }
    }
    this.calcService = bmiCalcService;
  }
}
exports.Handler = Handler;