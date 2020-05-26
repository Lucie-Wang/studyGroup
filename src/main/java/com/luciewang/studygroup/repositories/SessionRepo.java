package com.luciewang.studygroup.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.luciewang.studygroup.models.Session;

public interface SessionRepo extends CrudRepository <Session,Long>{
	List<Session> findAll();
}
