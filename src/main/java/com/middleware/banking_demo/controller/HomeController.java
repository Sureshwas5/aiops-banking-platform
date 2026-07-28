package com.middleware.banking.controller;

import org.springframework.core.SpringVersion;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home(Model model) {

        model.addAttribute("application", "AIOps Banking Platform");
        model.addAttribute("environment", "Development");
        model.addAttribute("server", "Apache Tomcat 9");
        model.addAttribute("javaVersion", System.getProperty("java.version"));
        model.addAttribute("springVersion", SpringVersion.getVersion());
        model.addAttribute("status", "Application is Running");

        return "index";
    }
}
