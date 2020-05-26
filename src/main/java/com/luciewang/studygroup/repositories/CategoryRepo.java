package com.luciewang.studygroup.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.luciewang.studygroup.models.Category;

public interface CategoryRepo extends CrudRepository <Category,Long>{
	List<Category> findAll();
	Category findByName(String name);
	}

