package com.luciewang.studygroup.models;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "users")
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	@Email(message = "Invalid Email")
	private String email;
	@Size(min = 1, message = "Character Name must be at least 3 characters")
	private String name;
	@Size(min = 1, message = "Please choose a profile image")
	private String picture;
	@Size(min = 8, message = "Password must be at least 8 characters")
	private String password;
	@Transient
	private String confirmPassword;
	@Size(min=1,message="Location field cannot be empty")
	private String city;
	private String region;
	private String country;
	
	@OneToMany(mappedBy = "postWriter", fetch = FetchType.LAZY)
	private List<Post> posts;
	
	@OneToMany(mappedBy = "commentWriter", fetch = FetchType.LAZY)
	private List<Comment> comments;
	
	@OneToMany(mappedBy="taskCreator", fetch=FetchType.LAZY)
    private List<Task> createdTasks;
	
	@OneToMany(mappedBy="sessionCreator", fetch=FetchType.LAZY)
    private List<Session> createdSessions;
	
	@OneToMany(mappedBy="groupCreator", fetch=FetchType.LAZY)
    private List<StudyGroup> createdGroups;
    
    @OneToMany(mappedBy="assignee", fetch=FetchType.LAZY)
    private List<Task> assignedTasks;
    
    @ManyToMany(fetch=FetchType.LAZY)
    @JoinTable(
		    name = "users_interests", 
		    joinColumns = @JoinColumn(name = "user_id"), 
		    inverseJoinColumns = @JoinColumn(name = "category_id")
		)
	private List<Category> userInterests;
    
    
    @ManyToMany(fetch=FetchType.LAZY)
    @JoinTable(
		    name = "users_groups", 
		    joinColumns = @JoinColumn(name = "user_id"), 
		    inverseJoinColumns = @JoinColumn(name = "group_id")
		)
	private List<StudyGroup> joinedGroups;
	
    @ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
		    name = "users_skills", 
		    joinColumns = @JoinColumn(name = "user_id"), 
		    inverseJoinColumns = @JoinColumn(name = "skill_id")
		)
	private List<Skill> skills;

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
			name="friends",
			joinColumns = @JoinColumn(name = "friend_id"),
			inverseJoinColumns = @JoinColumn(name="other_friend_id"))
	private List<User> friends;
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
			name="friendRequests",
			joinColumns = @JoinColumn(name = "friend_id"),
			inverseJoinColumns = @JoinColumn(name="other_friend_id"))
	private List<User> friendRequests;
    
	@Column(updatable = false)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date createdAt;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date updatedAt;
	
	@OneToOne(mappedBy="groupLead", cascade=CascadeType.ALL, fetch=FetchType.LAZY)
    private StudyGroup groupLeading;

	@PrePersist
	protected void onCreate() {
		this.createdAt = new Date();
	}
	@PreUpdate
	protected void onUpdate() {
		this.updatedAt = new Date();
	}
	
	public StudyGroup getGroupLeading() {
		return groupLeading;
	}
	public void setGroupLeading(StudyGroup groupLeading) {
		this.groupLeading = groupLeading;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getConfirmPassword() {
		return confirmPassword;
	}
	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}
	public List<Post> getPosts() {
		return posts;
	}
	public void setPosts(List<Post> posts) {
		this.posts = posts;
	}
	public List<Comment> getComments() {
		return comments;
	}
	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}
	public List<Task> getCreatedTasks() {
		return createdTasks;
	}
	public void setCreatedTasks(List<Task> createdTasks) {
		this.createdTasks = createdTasks;
	}
	
	public List<StudyGroup> getCreatedGroups() {
		return createdGroups;
	}
	public void setCreatedGroups(List<StudyGroup> createdGroups) {
		this.createdGroups = createdGroups;
	}
	public List<Task> getAssignedTasks() {
		return assignedTasks;
	}
	public void setAssignedTasks(List<Task> assignedTasks) {
		this.assignedTasks = assignedTasks;
	}
	
	public List<StudyGroup> getJoinedGroups() {
		return joinedGroups;
	}
	public void setJoinedGroups(List<StudyGroup> joinedGroups) {
		this.joinedGroups = joinedGroups;
	}
	public List<Skill> getSkills() {
		return skills;
	}
	public void setSkills(List<Skill> skills) {
		this.skills = skills;
	}
	public List<User> getFriends() {
		return friends;
	}
	public void setFriends(List<User> friends) {
		this.friends = friends;
	}
	public List<User> getFriendRequests() {
		return friendRequests;
	}
	public void setFriendRequests(List<User> friendRequests) {
		this.friendRequests = friendRequests;
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

	public void setCreatedSessions(List<Session> createdSessions) {
		this.createdSessions = createdSessions;
	}
	public List<Session> getCreatedSessions() {
		return createdSessions;
	}
	public List<Category> getUserInterests() {
		return userInterests;
	}
	public void setUserInterests(List<Category> userInterests) {
		this.userInterests = userInterests;
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
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}

}
