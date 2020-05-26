package com.luciewang.studygroup.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.luciewang.studygroup.models.StudyGroup;


public interface StudyGroupRepo extends CrudRepository <StudyGroup,Long>{
	List<StudyGroup> findAll();
}
