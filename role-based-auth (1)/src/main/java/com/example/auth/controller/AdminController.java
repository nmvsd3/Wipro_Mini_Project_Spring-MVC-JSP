package com.example.auth.controller;

import com.example.auth.model.Task;
import com.example.auth.model.TaskStatus;
import com.example.auth.model.User;
import com.example.auth.service.AdminService;
import com.example.auth.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;
    private final AuthService authService;

    @Autowired
    public AdminController(AdminService adminService, AuthService authService) {
        this.adminService = adminService;
        this.authService = authService;
    }

    private boolean isAdmin(HttpSession s) {
        Object role = s.getAttribute("role");
        return role != null && "ADMIN".equals(role.toString());
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession s, Model model) {
        if (!isAdmin(s)) return "redirect:/login";
        Map<TaskStatus, Long> counts = adminService.getStatusCounts();
        List<Task> tasks = adminService.listAllTasks();
        model.addAttribute("counts", counts);
        model.addAttribute("tasks", tasks);
        return "admin-dashboard";
    }

    // Users CRUD
    @GetMapping("/users")
    public String users(HttpSession s, Model model) {
        if (!isAdmin(s)) return "redirect:/login";
        model.addAttribute("users", adminService.listUsers());
        model.addAttribute("newUser", new User());
        return "admin-users";
    }

    @PostMapping("/users")
    public String addUser(@ModelAttribute("newUser") User user, HttpSession s, Model model) {
        if (!isAdmin(s)) return "redirect:/login";
        if (user.getPassword() == null || user.getPassword().isEmpty()) {
            model.addAttribute("error", "Password required");
            model.addAttribute("users", adminService.listUsers());
            return "admin-users";
        }
        if (authService.existsByUsername(user.getUsername())) {
            model.addAttribute("error", "Username already exists");
            model.addAttribute("users", adminService.listUsers());
            return "admin-users";
        }
        authService.registerUser(user);  // ✅ existing add method
        return "redirect:/admin/users";
    }

    @PostMapping("/users/{id}/delete")
    public String deleteUser(@PathVariable Integer id, HttpSession s) {
        if (!isAdmin(s)) return "redirect:/login";
        adminService.deleteUser(id);
        return "redirect:/admin/users";
    }

    // NEW: Update existing user (username + role)
    @PostMapping("/users/{id}/update")
    public String updateUser(@PathVariable Integer id,
                             @RequestParam String username,
                             @RequestParam String role,
                             HttpSession s) {
        if (!isAdmin(s)) return "redirect:/login";

        User user = adminService.getUserById(id);
        if (user != null) {
            user.setUsername(username);
            user.setRole(role);
            adminService.updateUser(user);
        }
        return "redirect:/admin/users";
    }

    // Tasks
    @GetMapping("/tasks/new")
    public String newTask(HttpSession s, Model model) {
        if (!isAdmin(s)) return "redirect:/login";
        model.addAttribute("users", adminService.listUsers());
        return "task-form";
    }

    @PostMapping("/tasks")
    public String createTask(@RequestParam String title,
                             @RequestParam(required = false) String description,
                             @RequestParam String startDate,
                             @RequestParam String dueDate,
                             @RequestParam Integer assigneeId,
                             HttpSession s) {
        if (!isAdmin(s)) return "redirect:/login";
        adminService.createTask(
                title,
                description,
                LocalDate.parse(startDate),
                LocalDate.parse(dueDate),
                assigneeId
        );
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/tasks/{taskId}/comments")
    public String viewComments(@PathVariable Integer taskId, HttpSession s, Model model) {
        if (!isAdmin(s)) return "redirect:/login";
        model.addAttribute("comments", adminService.getCommentsForTask(taskId));
        return "admin-task-comments";
    }

    // Update Task Status from Admin Dashboard
    @PostMapping("/tasks/{taskId}/status")
    public String updateTaskStatus(@PathVariable Integer taskId,
                                   @RequestParam("status") String status,
                                   HttpSession s) {
        if (!isAdmin(s)) return "redirect:/login";
        adminService.updateTaskStatus(taskId, TaskStatus.valueOf(status));
        return "redirect:/admin/dashboard";
    }
}
