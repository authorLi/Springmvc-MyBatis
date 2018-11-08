package com.abc.test;

import org.junit.Test;

public class RegixTest {
    @Test
    public void fun(){
        String regix = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$";
        String email = "524894052@qq.com";
        System.out.println(email.matches(regix));
    }
}
