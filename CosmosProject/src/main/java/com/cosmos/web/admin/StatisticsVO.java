package com.cosmos.web.admin;

public class StatisticsVO {
	private int p_num;
	private String title;
	private int child_tot;
	private int teenager_tot;
	private int adult_tot;
	
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
	public int getChild_tot() {
		return child_tot;
	}
	public void setChild_tot(int child_tot) {
		this.child_tot = child_tot;
	}
	public int getTeenager_tot() {
		return teenager_tot;
	}
	public void setTeenager_tot(int teenager_tot) {
		this.teenager_tot = teenager_tot;
	}
	public int getAdult_tot() {
		return adult_tot;
	}
	public void setAdult_tot(int adult_tot) {
		this.adult_tot = adult_tot;
	}
	
}
