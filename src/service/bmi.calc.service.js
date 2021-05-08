class BMICalcService {
  constructor() {
    this.calculate = (w, h) => {
      console.log('BMICalcService', `Weight - ${w}, Height: - ${h}`)
      let weight = parseFloat(w, 10);
      let height = parseFloat(h, 10)
      return (weight/height/height * 10000).toFixed(2);
    }
  }
}

exports.BMICalcService = BMICalcService;