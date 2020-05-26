package com.luciewang.studygroup.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.luciewang.studygroup.models.Post;

public interface PostRepo extends CrudRepository <Post,Long>{
	List<Post> findAll();
	Post findByPostWriter(String name);
}
