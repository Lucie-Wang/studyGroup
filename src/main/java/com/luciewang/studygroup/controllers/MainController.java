package com.luciewang.studygroup.controllers;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.luciewang.studygroup.models.StudyGroup;
import com.luciewang.studygroup.models.Task;
import com.luciewang.studygroup.models.Post;
import com.luciewang.studygroup.models.Session;
import com.luciewang.studygroup.models.User;
import com.luciewang.studygroup.repositories.CategoryRepo;
import com.luciewang.studygroup.repositories.CommentRepo;
import com.luciewang.studygroup.repositories.StudyGroupRepo;
import com.luciewang.studygroup.repositories.TaskRepo;
import com.luciewang.studygroup.repositories.PostRepo;
import com.luciewang.studygroup.repositories.SessionRepo;
import com.luciewang.studygroup.repositories.UserRepo;
import com.luciewang.studygroup.services.UserServ;
import com.luciewang.studygroup.validator.UserValidator;

@Controller
public class MainController {

	private final UserRepo urepo;
	private final UserServ userv;
	private final UserValidator uvalid;
	private final SessionRepo srepo;
	private final StudyGroupRepo grepo;
	private final PostRepo prepo;
	private final CommentRepo crepo;
	private final TaskRepo trepo;
	private final CategoryRepo ctrepo;

	public MainController(UserRepo urepo, UserServ userv, UserValidator uvalid, SessionRepo srepo, StudyGroupRepo grepo,
			PostRepo prepo, CommentRepo crepo, TaskRepo trepo, CategoryRepo ctrepo) {
		this.urepo = urepo;
		this.userv = userv;
		this.uvalid = uvalid;
		this.grepo = grepo;
		this.prepo = prepo;
		this.srepo = srepo;
		this.crepo = crepo;
		this.trepo = trepo;
		this.ctrepo = ctrepo;
	}

	// Login and registration

	@GetMapping("/registration")
	public String registerUser(Model model) {
		model.addAttribute("user", new User());
		return "register.jsp";
	}

	@PostMapping("/registration")
	public String doRegisterUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
		uvalid.validate(user, result);
		if (result.hasErrors()) {
			System.out.println(user.getId());
			return "register.jsp";
		}
		userv.registerUser(user);
		session.setAttribute("user_id", user.getId());
		return "redirect:/newprofile";
	}

	@GetMapping("/")
	public String index() {
		return "redirect:/login";
	}

	@GetMapping("/login")
	public String login() {
		return "login.jsp";
	}

	@PostMapping("/login")
	public String doLogin(@RequestParam("email") String email, @RequestParam("password") String password, Model model,
			HttpSession session) {
		if (!userv.authenticateUser(email, password)) {
			model.addAttribute("error", "Incorrect email / password combination");
			return "login.jsp";
		}
		User user = urepo.findByEmail(email);
		session.setAttribute("user_id", user.getId());
		if (user.getName() == null) {
			return "redirect:/newprofile";
		}
		return "redirect:/dashboard";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}

	// new profile

	@GetMapping("/newprofile")
	public String newprofile(Model model, HttpSession session) {
		model.addAttribute("user", urepo.findById((Long) session.getAttribute("user_id")).orElse(null));
		model.addAttribute("allCategories", ctrepo.findAll());
		return "newProfile.jsp";
	}

	@PostMapping("/newprofile")
	public String createNewProfile(@Valid @ModelAttribute("user") User user, BindingResult result,
			HttpSession session) {
		if (result.hasErrors()) {
			return "newprofile.jsp";
		}
		User u = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		u.setName(user.getName());
		u.setPicture(user.getPicture());
		u.setCity(user.getCity());
		u.setRegion(user.getRegion());
		u.setCountry(user.getCountry());
		urepo.save(u);

		return "redirect:/dashboard";
	}

	// admin dash

	@GetMapping("/adminDash")
	public String Admin(Model model, HttpSession session) {
		User u = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		model.addAttribute("group", new StudyGroup());
		model.addAttribute("session", new Session());
		model.addAttribute("allGroups", grepo.findAll());
		model.addAttribute("allSessions", srepo.findAll());
		model.addAttribute("allUsers", urepo.findAll());
		model.addAttribute("userGroups", u.getJoinedGroups());
		model.addAttribute("user", u);
		return "dashboard.jsp";
	}

	@PostMapping("/group/new")
	public String createGroup(Model model, HttpSession session, @Valid @ModelAttribute("group") StudyGroup group,
			BindingResult result) {
		if (result.hasErrors()) {
			User u = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
			model.addAttribute("user", u);
			model.addAttribute("group", new StudyGroup());
			model.addAttribute("session", new Session());
			model.addAttribute("allGroups", grepo.findAll());
			model.addAttribute("allSessions", srepo.findAll());
			model.addAttribute("allUsers", urepo.findAll());
			model.addAttribute("userGroups", u.getJoinedGroups());
			return "dashboard.jsp";

		} else {
			Long userid = (Long) session.getAttribute("user_id");
			User u = urepo.findById(userid).orElse(null);
			StudyGroup g = grepo.save(group);
			u.getCreatedGroups().add(g);
			urepo.save(u);

			return "redirect:/dashboard";
		}
	}

	@GetMapping("/dashboard")
	public String dashboard(Model model, HttpSession session) {
		if (session.getAttribute("user_id") == null) {
			return "redirect:/";
		}
		User u = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		model.addAttribute("user", u);
		model.addAttribute("post", new Post());
		model.addAttribute("allPosts", prepo.findAll());
		model.addAttribute("allUsers", urepo.findAll());
		model.addAttribute("allSessions", srepo.findAll());
		model.addAttribute("allUsers", urepo.findAll());
		model.addAttribute("userGroups", u.getJoinedGroups());
		model.addAttribute("allTasks", trepo.findAll());

		return "dashboard.jsp";
	}

	@PostMapping("/post/new")
	public String createPost(Model model, HttpSession session, @Valid @ModelAttribute("post") Post post,
			BindingResult result) {
		if (result.hasErrors()) {
			User u = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
			model.addAttribute("user", u);
			model.addAttribute("post", new Post());
			model.addAttribute("allPosts", prepo.findAll());
			model.addAttribute("allUsers", urepo.findAll());
			model.addAttribute("allSessions", srepo.findAll());
			model.addAttribute("allUsers", urepo.findAll());
			model.addAttribute("userGroups", u.getJoinedGroups());
			model.addAttribute("allTasks", trepo.findAll());
			return "dashabord.jsp";

		} else {
			Long userid = (Long) session.getAttribute("user_id");
			User u = urepo.findById(userid).orElse(null);
			Post p = prepo.save(post);
			p.setPostWriter(u);
			prepo.save(p);
			return "redirect:/dashboard";
		}
	}

	@GetMapping("/session/all")
	public String sessions(Model model, HttpSession session, @Valid @ModelAttribute("post") Post post,
			BindingResult result) {
		if (session.getAttribute("user_id") == null) {
			return "redirect:/";
		}
		model.addAttribute("tasks", new Task());
		User u = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		model.addAttribute("user", u);
		model.addAttribute("allUsers", urepo.findAll());
		model.addAttribute("allSessions", srepo.findAll());
		model.addAttribute("allUsers", urepo.findAll());
		model.addAttribute("allTasks", trepo.findAll());
		model.addAttribute("userGroups", u.getJoinedGroups());
		return "allSessions.jsp";
	}

	@GetMapping("/session/new")
	public String newSession(Model model, HttpSession session) {
		if (session.getAttribute("user_id") == null) {
			return "redirect:/";
		}
		User u = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		model.addAttribute("session", new Session());
		model.addAttribute("user", u);
		model.addAttribute("allUsers", urepo.findAll());
		model.addAttribute("allSessions", srepo.findAll());
		model.addAttribute("allUsers", urepo.findAll());
		model.addAttribute("userGroups", u.getJoinedGroups());
		return "newSession.jsp";
	}

	@PostMapping("/{group_id}/session/new")
	public String createSession(Model model, HttpSession session, @Valid @ModelAttribute("session") Session sessionNew,
			@PathVariable("group_id") Long gId, BindingResult result) {
		if (result.hasErrors()) {
			model.addAttribute("group", new StudyGroup());
			model.addAttribute("session", new Session());
			model.addAttribute("date", new Date());
			User u = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
			model.addAttribute("user", u);
			model.addAttribute("allGroups", grepo.findAll());
			model.addAttribute("allSessions", srepo.findAll());
			model.addAttribute("allUsers", urepo.findAll());
			model.addAttribute("userGroups", u.getJoinedGroups());
			return "dashboard.jsp";

		} else {
			System.out.println(sessionNew.getDate());
			Long userid = (Long) session.getAttribute("user_id");
			User u = urepo.findById(userid).orElse(null);
			Session s = srepo.save(sessionNew);
			System.out.println(sessionNew.getDate());
			s.setSessionCreator(u);
			srepo.save(s);

			return "redirect:/dashboard";
		}
	}

	@PostMapping("/{group_id}/assignGroupLead")
	public String assignGL(Model model, HttpSession session, @PathVariable("group_id") Long gId,
			@RequestParam("groupLead") Long uId) {
		Long userid = (Long) session.getAttribute("user_id");
		User u = urepo.findById(userid).orElse(null);
		StudyGroup g = grepo.findById(gId).orElse(null);
		User groupLead = urepo.findById(uId).orElse(null);
		g.setGroupLead(groupLead);
		grepo.save(g);
		u.getJoinedGroups().add(g);
		urepo.save(u);
		return "redirect:/adminDash";
	}

	// tasks

	@GetMapping("/task/new")
	public String TaskForm(HttpSession session, Model model) {
		if (session.getAttribute("user_id")==null){
			return "redirect:/";
		}
		Long userid = (Long) session.getAttribute("user_id");
		User u = urepo.findById(userid).orElse(null);
		model.addAttribute("allUsers", urepo.findAll());
		model.addAttribute("user", u);
		model.addAttribute("userGroups", u.getJoinedGroups());
		model.addAttribute("task", new Task());
		return "newTask.jsp";

	}

	@PostMapping("/task/new")
	public String createTaskForm(HttpSession session, @Valid @ModelAttribute("task") Task task, BindingResult result,
			Model model) {
		if (result.hasErrors()) {
			Long userid = (Long) session.getAttribute("user_id");
			User u = urepo.findById(userid).orElse(null);
			model.addAttribute("allUsers", urepo.findAll());
			model.addAttribute("userGroups", u.getJoinedGroups());
			model.addAttribute("user", u);
			return "newTask.jsp";
		} else {
			Long userid = (Long) session.getAttribute("user_id");
			User u = urepo.findById(userid).orElse(null);
			Task t = trepo.save(task);
			t.setTaskCreator(u);
			t.setStatus(0);
			trepo.save(t);
			String taskId = t.getId().toString();
			return "redirect:/task/" + taskId;
		}
	}

	@GetMapping("/task/{task_id}")
	public String viewTask(Model model, HttpSession session, @PathVariable("task_id") Long tId) {
		if (session.getAttribute("user_id")==null){
			return "redirect:/";
		}
		User u = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		model.addAttribute("user", u);
		model.addAttribute("task", trepo.findById(tId).orElse(null));
		return "taskDetails.jsp";
	}

	@GetMapping("/task/{task_id}/edit")
	public String viewTaskDetails(@PathVariable("task_id") Long id, Model model, HttpSession session) {
		if (session.getAttribute("user_id")==null){
			return "redirect:/";
		}
		User u = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		model.addAttribute("user", u);
		model.addAttribute("task", trepo.findById(id).orElse(null));
		model.addAttribute("users", urepo.findAll());
		return "editTask.jsp";
	}

	@PostMapping("/task/{task_id}/edit")
	public String editTask(Model model, @PathVariable("task_id") Long id, HttpSession session,
			@Valid @ModelAttribute("task") Task task, BindingResult result) {
		if (result.hasErrors()) {
			Task original = trepo.findById(id).orElse(null);
			task.setId(id);
			task.setName(original.getName());
			task.setAssignee(original.getAssignee());
			task.setDescription(original.getDescription());
			task.setPriority(original.getPriority());
			model.addAttribute("users", urepo.findAll());
			return "editTask.jsp";
		} else {
			// creator
			Task original = trepo.findById(id).orElse(null);
			original.setName(task.getName());
			original.setDescription(task.getDescription());
			original.setAssignee(task.getAssignee());
			original.setPriority(task.getPriority());
			trepo.save(original);
			String taskId = original.getId().toString();
			return "redirect:/task/" + taskId;
		}
	}

	@GetMapping("/task/lowpriority")
	public String lowDashboard(Model model, HttpSession session) {
		if (session.getAttribute("user_id")==null){
			return "redirect:/";
		}
		User u = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		List<Task> mylist = trepo.findAll();
		mylist.sort((c1, c2) -> c2.getPriority() - c1.getPriority());
		model.addAttribute("allTasks", mylist);
		model.addAttribute("user", u);
		model.addAttribute("post", new Post());
		model.addAttribute("allPosts", prepo.findAll());
		model.addAttribute("allUsers", urepo.findAll());
		model.addAttribute("allSessions", srepo.findAll());
		model.addAttribute("allUsers", urepo.findAll());
		model.addAttribute("userGroups", u.getJoinedGroups());
		return "dashboard.jsp";
	}

	@GetMapping("task/highpriority")
	public String highDashboard(Model model, HttpSession session) {
		if (session.getAttribute("user_id")==null){
			return "redirect:/";
		}
		User u = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		List<Task> mylist = trepo.findAll();
		mylist.sort((c1, c2) -> c1.getPriority() - c2.getPriority());
		model.addAttribute("allTasks", mylist);
		model.addAttribute("user", u);
		model.addAttribute("post", new Post());
		model.addAttribute("allPosts", prepo.findAll());
		model.addAttribute("allUsers", urepo.findAll());
		model.addAttribute("allSessions", srepo.findAll());
		model.addAttribute("allUsers", urepo.findAll());
		model.addAttribute("userGroups", u.getJoinedGroups());
		return "dashboard.jsp";
	}

	@GetMapping("delete/{task_id}")
	public String removeTask(Model model, HttpSession session, @PathVariable("task_id") Long id) {
		if (session.getAttribute("user_id")==null){
			return "redirect:/";
		}
		Long userId = (Long) session.getAttribute("user_id");
		model.addAttribute("allTasks", trepo.findById(id).orElse(null));
		model.addAttribute("user", urepo.findById(userId).orElse(null));
		trepo.deleteById(id);
		return "redirect:/dashboard";
	}

	@GetMapping("/task/{task_id}/updateStatus")
	public String updateTaskStatus(Model model, HttpSession session, @PathVariable("task_id") Long id) {
		if (session.getAttribute("user_id")==null){
			return "redirect:/";
		}
		Long userId = (Long) session.getAttribute("user_id");
		User u = urepo.findById(userId).orElse(null);
		Task t = trepo.findById(id).orElse(null);
		t.setStatus(1);
		trepo.save(t);
		String taskId = t.getId().toString();
		model.addAttribute("user", u);
		model.addAttribute("task", t);
		return "redirect:/task/" + taskId;
	}

	@PostMapping("/session/{session_id}/addTask")
	public String AddTaskToSession(Model model, HttpSession session, @PathVariable("session_id") Long id,
			@RequestParam("task") Long tId) {
		Long userId = (Long) session.getAttribute("user_id");
		User u = urepo.findById(userId).orElse(null);
		Session s = srepo.findById(id).orElse(null);
		srepo.save(s);
		Task t = trepo.findById(tId).orElse(null);
		t.setSession(s);
		trepo.save(t);
		model.addAttribute("user", u);
		return "redirect:/session/all";
	}

	@GetMapping("/session/{session_id}/updateStatus")
	public String updateSessionStatus(Model model, HttpSession session, @PathVariable("session_id") Long id) {
		if (session.getAttribute("user_id")==null){
			return "redirect:/";
		}
		Long userId = (Long) session.getAttribute("user_id");
		User u = urepo.findById(userId).orElse(null);
		Session s = srepo.findById(id).orElse(null);
		s.setStatus(1);
		srepo.save(s);

		model.addAttribute("user", u);

		return "redirect:/session/all";
	}

	@GetMapping("delete/{session_id}")
	public String removeSession(Model model, HttpSession session, @PathVariable("session_id") Long id) {
		if (session.getAttribute("user_id")==null){
			return "redirect:/";
		}
		Long userId = (Long) session.getAttribute("user_id");
		model.addAttribute("thisSession", srepo.findById(id).orElse(null));
		model.addAttribute("user", urepo.findById(userId).orElse(null));
		srepo.deleteById(id);
		return "redirect:/session/all";
	}

	@GetMapping("/session/{session_id}")
	public String viewSessionDetails(Model model, HttpSession session, @PathVariable("session_id") Long sId) {
		if (session.getAttribute("user_id")==null){
			return "redirect:/";
		}
		User u = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		model.addAttribute("user", u);
		model.addAttribute("session", srepo.findById(sId).orElse(null));
		return "sessionDetails.jsp";
	}

	@PostMapping("/session/{session_id}/edit")
	public String editSession(Model model, @PathVariable("session_id") Long id, HttpSession session,
			@Valid @ModelAttribute("session")Session sessionEdit, BindingResult result) {
		if (result.hasErrors()) {
			Session original = srepo.findById(id).orElse(null);
			sessionEdit.setId(id);
			sessionEdit.setDate(original.getDate());
			sessionEdit.setMeetingLink(original.getMeetingLink());
			sessionEdit.setNotes(original.getNotes());
			model.addAttribute("users", urepo.findAll());
			return "editSession.jsp";
		} else {
			// creator
			Session original = srepo.findById(id).orElse(null);
			original.setDate(sessionEdit.getDate());
			original.setMeetingLink(sessionEdit.getMeetingLink());
			original.setNotes(sessionEdit.getNotes());
			srepo.save(original);
			String sessionId = original.getId().toString();
			return "redirect:/session/" + sessionId;
		}
	}

	@GetMapping("/session/{session_id}/edit")
	public String viewEditSession(Model model, @PathVariable("session_id") Long id, HttpSession session) {
		if (session.getAttribute("user_id")==null){
			return "redirect:/";
		}
		User u = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		model.addAttribute("user", u);
		model.addAttribute("session", srepo.findById(id).orElse(null));
		model.addAttribute("users", urepo.findAll());
		return "editSession.jsp";
		
	}

}