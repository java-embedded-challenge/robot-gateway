/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.remotecontrol;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

/**
 *
 * @author ken.lai
 */
@Controller
public class DistanceController {

   @Autowired
   private RestTemplate restTemplate;
   
   @RequestMapping(method = RequestMethod.GET, value = "/distance")
   public @ResponseBody String getDistance()
    {
       String result = restTemplate.getForObject("http://192.168.1.51:8080/things/sd1", String.class);
       return result.replaceFirst("d1\\?", "");
    }
    
}
