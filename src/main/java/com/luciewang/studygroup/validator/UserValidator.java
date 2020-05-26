package com.luciewang.studygroup.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.luciewang.studygroup.models.User;
import com.luciewang.studygroup.repositories.UserRepo;



@Component
public class UserValidator implements Validator {
	
	private final UserRepo urepo;
	
	public UserValidator(UserRepo urepo) {
		this.urepo = urepo;
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return User.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		User user = (User) target;
			if(!user.getConfirmPassword().equals(user.getPassword())) {
				errors.rejectValue("confirmPassword", "Match");
			}
			if (urepo.findByEmail(user.getEmail()) != null) {
				errors.rejectValue("email", "Duplicate");
			}
	}
	
}

