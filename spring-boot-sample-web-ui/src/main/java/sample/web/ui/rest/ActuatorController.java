package sample.web.ui.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.actuate.health.Health;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import sample.web.ui.Message;
import sample.web.ui.MessageRepository;

@RestController
public class ActuatorController {

    @Autowired
    MessageRepository messageRepository;

    @GetMapping("/health")
    public Health health() throws Exception {
        boolean isOk = check();
        if (!isOk) {

            int errorCode = 404;
            return Health.down().withDetail("Error Code", errorCode).build();
        }
        return Health.up().build();
    }

    public boolean check() throws Exception {

        try {
            Iterable<Message> messages = this.messageRepository.findAll();
        } catch (Exception e) {
            throw new Exception();
        }
        return true;
    }
}
