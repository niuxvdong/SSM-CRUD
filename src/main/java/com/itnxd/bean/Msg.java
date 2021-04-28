package com.itnxd.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用的返回值！
 *
 * @author ITNXD
 * @create 2021-04-11 11:12
 */
public class Msg {

    // 状态码 100-成功 200-失败
    private Integer code;
    // 提示信息
    private String msg;

    // 保存用户返回给浏览器的信息
    private Map<String, Object> extend = new HashMap<>();

    /**
     * 静态方法，处理成功返回对象！
     *
     * @return
     */
    public static Msg success(){
        Msg res = new Msg();
        res.setCode(100);
        res.setMsg("处理成功！");
        return res;
    }

    /**
     * 静态方法，处理失败返回对象！
     *
     * @return
     */
    public static Msg fail(){
        Msg res = new Msg();
        res.setCode(200);
        res.setMsg("处理失败！");
        return res;
    }

    /**
     * 处理链式调用！
     *
     * @param name
     * @param value
     * @return
     */
    public Msg add(String name, Object value){
        this.getExtend().put(name, value);
        return this;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
