using Car_Rental_System.Models;
using Car_Rental_System.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Car_Rental_System.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PaymentsController : ControllerBase
    {
        public readonly IPaymentService _service;
        public PaymentsController(IPaymentService service)
        {
            _service = service;
        }

        [HttpGet]
        public IActionResult GetAll()
        {
            List<Payment> payments = _service.GetAllPayment();
            return Ok(payments);
        }

        [HttpGet("{id}")]
        public IActionResult GetPaymentById(int id)
        {
            Payment payment = _service.GetPaymentById(id);
            return Ok(payment);
        }

        [HttpPost]
        public IActionResult Post(Payment payment)
        {
            int Result = _service.AddNewPayment(payment);
            return Ok(Result);
        }

        [HttpPut]
        public IActionResult Put(Payment payment)
        {
            string result = _service.UpdatePayment(payment);
            return Ok(result);
        }

        [HttpDelete]
        public IActionResult Delete(int id)
        {
            string result = _service.DeletePayment(id);
            return Ok(result);
        }
    }
}