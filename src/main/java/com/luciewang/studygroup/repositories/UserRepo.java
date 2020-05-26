package com.luciewang.studygroup.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.luciewang.studygroup.models.User;

@Repository
public interface UserRepo extends CrudRepository<User, Long> {

	List<User> findAll();
	List<User> findByNameContaining(String str);
	User findByEmail(String email);
	User findByJoinedGroups(String group);
}