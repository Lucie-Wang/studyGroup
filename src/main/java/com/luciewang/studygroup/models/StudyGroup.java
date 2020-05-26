package com.luciewang.studygroup.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "study_groups")
public class StudyGroup {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	@Size(min=1,message="Group Name must be present")
	private String name;
	@Column(updatable=false)
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createdAt;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updatedAt;
	
	private String weChatGroupName;
	@Size(min=1,message="Location field cannot be empty")
	private String city;
	private String region;
	private String country;
	private Integer maxMember;
	
	@ManyToMany(fetch=FetchType.LAZY)
	@JoinTable(
	        name = "categories_groups", 
	        joinColumns = @JoinColumn(name = "group_id"), 
	        inverseJoinColumns = @JoinColumn(name = "category_id")
	    )
	private List<Category> groupCategories;
	
	@PrePersist
	protected void onCreate(){
		this.createdAt = new Date();
	}
	@PreUpdate
	protected void onUpdate(){
		this.updatedAt = new Date();
	}
	
	@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="groupCreator_id")
    private User groupCreator;

	@ManyToMany(fetch=FetchType.LAZY)
	@JoinTable(
			    name = "users_groups", 
			    joinColumns = @JoinColumn(name = "group_id"), 
			    inverseJoinColumns = @JoinColumn(name = "user_id")
			)
	private List<User> groupMembers;
	
	public User getGroupLead() {
		return groupLead;
	}
	public void setGroupLead(User groupLead) {
		this.groupLead = groupLead;
	}

	@OneToMany(mappedBy="group", fetch=FetchType.LAZY)
	private List<Session> sessions;
	
	@OneToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="groupLead_id")
    private User groupLead;
	
	
	public Long getId() {
		return id;
	}
	
	public String getWeChatGroupName() {
		return weChatGroupName;
	}
	public void setWeChatGroupName(String weChatGroupName) {
		this.weChatGroupName = weChatGroupName;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public Date getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	public User getGroupCreator() {
		return groupCreator;
	}
	public void setGroupCreator(User groupCreator) {
		this.groupCreator = groupCreator;
	}
	public List<User> getGroupMembers() {
		return groupMembers;
	}
	public void setGroupMembers(List<User> groupMembers) {
		this.groupMembers = groupMembers;
	}
	public List<Session> getSessions() {
		return sessions;
	}
	public void setSessions(List<Session> sessions) {
		this.sessions = sessions;
	}

	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public Integer getMaxMember() {
		return maxMember;
	}
	public void setMaxMember(Integer maxMember) {
		this.maxMember = maxMember;
	}
	public List<Category> getGroupCategories() {
		return groupCategories;
	}
	public void setGroupCategories(List<Category> groupCategories) {
		this.groupCategories = groupCategories;
	}
	public Integer getMaxNumber() {
		return maxMember;
	}
	public void setMaxNumber(Integer maxMember) {
		this.maxMember = maxMember;
	}
	
}
