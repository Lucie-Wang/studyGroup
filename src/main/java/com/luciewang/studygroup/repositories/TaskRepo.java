package com.luciewang.studygroup.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.luciewang.studygroup.models.Task;

@Repository
public interface TaskRepo extends CrudRepository<Task,Long>{
	List<Task> findAll();
	Task findBySession(String session);
}
