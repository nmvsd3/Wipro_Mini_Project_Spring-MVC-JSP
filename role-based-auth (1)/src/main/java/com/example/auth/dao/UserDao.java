package com.example.auth.dao;

import com.example.auth.model.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserDao {

    @Autowired
    private SessionFactory sessionFactory;

    private Session session() {
        return sessionFactory.getCurrentSession();
    }

    public void save(User u) {
        session().save(u);
    }

    public void update(User u) {
        session().update(u);
    }

    public void delete(Integer id) {
        User u = findById(id);
        if (u != null) session().delete(u);
    }

    public User findById(Integer id) {
        return session().get(User.class, id);
    }

    public User findByUsername(String username) {
        return session().createQuery("from User where username = :username", User.class)
                .setParameter("username", username)
                .uniqueResult();
    }

    public List<User> findAll() {
        return session().createQuery("from User order by id asc", User.class).list();
    }
}
