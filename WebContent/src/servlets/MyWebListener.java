package servlets;

import javax.servlet.annotation.WebListener;

import org.apache.shiro.web.env.EnvironmentLoaderListener;

@WebListener
public class MyWebListener extends EnvironmentLoaderListener{

}
