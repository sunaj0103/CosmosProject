package com.cosmos.web.member;

public class MembersVO {
	private int m_num;
    private String id;
    private String password;
    private String name;
    
    private String year;
    private String month;
    private String day;
    private String birth;
    
    private String gender;
    
    private String tel1;
    private String tel2;
    private String tel3;
    private String phone;
    
    private String email;
    private String sms_reception;
    private String is_manager;
    private String write_date;
    private String modified_date;
    private String withdrawal;
    
	public int getM_num() {
		return m_num;
	}
	public void setM_num(int m_num) {
		this.m_num = m_num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	//DB 저장하기 위해
	public void setBirth() {
		String birth = year+month+day;
		this.birth = birth;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getTel1() {
		return tel1;
	}
	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}
	public String getTel2() {
		return tel2;
	}
	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}
	public String getTel3() {
		return tel3;
	}
	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	//DB 저장하기 위해 
	public void setPhone() {
		String phone = tel1+"-"+tel2+"-"+tel3;
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSms_reception() {
		return sms_reception;
	}
	public void setSms_reception(String sms_reception) {
		this.sms_reception = sms_reception;
	}
	public String getIs_manager() {
		return is_manager;
	}
	public void setIs_manager(String is_manager) {
		this.is_manager = is_manager;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	public String getModified_date() {
		return modified_date;
	}
	public void setModified_date(String modified_date) {
		this.modified_date = modified_date;
	}
	public String getWithdrawal() {
		return withdrawal;
	}
	public void setWithdrawal(String withdrawal) {
		this.withdrawal = withdrawal;
	}
    
}
