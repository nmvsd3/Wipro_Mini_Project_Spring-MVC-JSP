package com.example.auth.dao;

import com.example.auth.model.Task;
import com.example.auth.model.TaskStatus;
import com.example.auth.model.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class TaskDao {

    @Autowired
    private SessionFactory sessionFactory;

    private Session session() {
        return sessionFactory.getCurrentSession();
    }

    public void save(Task t) {
        session().save(t);
    }

    public void update(Task t) {
        session().update(t);
    }

    public Task findById(Integer id) {
        return session().createQuery(
                "SELECT t FROM Task t " +
                "LEFT JOIN FETCH t.assignee " +
                "WHERE t.id = :id",
                Task.class
        ).setParameter("id", id)
         .uniqueResult();
    }

    public List<Task> findAll() {
        return session().createQuery(
                "SELECT DISTINCT t FROM Task t " +
                "LEFT JOIN FETCH t.assignee " +
                "ORDER BY t.id ASC",
                Task.class
        ).list();
    }

    // New method for safe user deletion
    public List<Task> findByAssignee(User u) {
        return session().createQuery(
                "SELECT DISTINCT t FROM Task t " +
                "LEFT JOIN FETCH t.assignee " +
                "WHERE t.assignee = :u",
                Task.class
        ).setParameter("u", u)
         .list();
    }

    public long countByStatus(TaskStatus status) {
        return session().createQuery(
                "SELECT COUNT(t) FROM Task t WHERE t.status = :status",
                Long.class
        ).setParameter("status", status)
         .getSingleResult();
    }
}
