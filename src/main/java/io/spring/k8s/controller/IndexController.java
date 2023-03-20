package io.spring.k8s.controller;

import io.spring.k8s.domain.BaseResult;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class IndexController {

    @GetMapping("/")
    public String index() {
        return "index";
    }

    @ResponseBody
    @GetMapping("/health")
    public BaseResult<String> health() {
        return BaseResult.ok("it's works!!");
    }
}
