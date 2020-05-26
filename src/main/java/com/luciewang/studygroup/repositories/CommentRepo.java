package com.luciewang.studygroup.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.luciewang.studygroup.models.Comment;

public interface CommentRepo extends CrudRepository <Comment,Long>{
	List<Comment> findAll();
}
