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
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "categories")
public class Category{
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	@Size(min=2,message="Category Name must be at least 2 characters")
	private String name;
	@Column(updatable=false)
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createdAt;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updatedAt;
	
	@ManyToMany(fetch=FetchType.LAZY)
	@JoinTable(
	        name = "categories_groups", 
	        joinColumns = @JoinColumn(name = "category_id"), 
	        inverseJoinColumns = @JoinColumn(name = "group_id")
	    )
	private List<StudyGroup> studyGroups;
	
    @ManyToMany(fetch=FetchType.LAZY)
    @JoinTable(
		    name = "users_interests", 
		    joinColumns = @JoinColumn(name = "category_id"), 
		    inverseJoinColumns = @JoinColumn(name = "user_id")
		)
	private List<User> interestedUsers;
	
	@PrePersist
	protected void onCreate(){
		this.createdAt = new Date();
	}
	@PreUpdate
	protected void onUpdate(){
		this.updatedAt = new Date();
	}
	public Long getId() {
		return id;
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
	public List<StudyGroup> getStudyGroups() {
		return studyGroups;
	}
	public void setStudyGroups(List<StudyGroup> studyGroups) {
		this.studyGroups = studyGroups;
	}
	
}
