package com.cosmos.web.program;

public class ProgramVO {
	private int p_num;
	private String title; 
	private String description;
	private String recommend;
	private int total_num_of_applicants;
	private int child;
	private int teenager;
	private int adult; 
	private int discount_min;
	private int discount_rate;
	private String write_date;
	
	public int getP_num() {
		return p_num;
	}
	public void setP_num(int p_num) {
		this.p_num = p_num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getRecommend() {
		return recommend;
	}
	public void setRecommend(String recommend) {
		this.recommend = recommend;
	}
	public int getTotal_num_of_applicants() {
		return total_num_of_applicants;
	}
	public void setTotal_num_of_applicants(int total_num_of_applicants) {
		this.total_num_of_applicants = total_num_of_applicants;
	}
	public int getChild() {
		return child;
	}
	public void setChild(int child) {
		this.child = child;
	}
	public int getTeenager() {
		return teenager;
	}
	public void setTeenager(int teenager) {
		this.teenager = teenager;
	}
	public int getAdult() {
		return adult;
	}
	public void setAdult(int adult) {
		this.adult = adult;
	}
	public int getDiscount_min() {
		return discount_min;
	}
	public void setDiscount_min(int discount_min) {
		this.discount_min = discount_min;
	}
	public int getDiscount_rate() {
		return discount_rate;
	}
	public void setDiscount_rate(int discount_rate) {
		this.discount_rate = discount_rate;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	
}
