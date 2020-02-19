package com.interview.teknologi.indonesia.siber;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan("com.interview.teknologi.indonesia")
@MapperScan("com.interview.teknologi.indonesia.services")
@SpringBootApplication
public class TnisApplication extends SpringBootServletInitializer{
   
    
    protected SpringApplicationBuilder confBuilder(SpringApplicationBuilder applicationBuilder){
        return applicationBuilder.sources(TnisApplication.class);
    }
    
	public static void main(String[] args) {
		SpringApplication.run(TnisApplication.class, args);
                System.out.println("good jobs...");
	}

}
