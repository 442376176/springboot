package com.lxg.service;

import com.lxg.dao.UserDao;
import com.lxg.model.JpaUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author LXG
 */
@Service
public class UserService {
	@Autowired
	private UserDao userDao;

	/**
	 * 新增或修改，无id为新增，有id为修改
	 * @param jpaUser
	 */
//	@Transactional
	public void saveUser(JpaUser jpaUser) {
		userDao.save(jpaUser);
		/**
		 * 这里的save方法会更新所有字段，如果只传了age属性进行更新，
		 * name属性就会修改为null，避免这个问题需要使用下面的原生Sql
		 * 并且加上方法上的@Transactional注解
		 * userDao.update(jpaUser.getId(),jpaUser.getAge());
		 */
	}

	/**
	 * 根据id删除
	 * 
	 * @param id
	 */
	public void deleteUser(String id) {
		userDao.deleteById(id);
	}

	/**
	 * 查询所有
	 */
	public List<JpaUser> findAll() {
		return userDao.findAll();
	}

	/**
	 * 根据id查询
	 * 
	 * @param id
	 */
	public JpaUser findUserById(String id) {
		return userDao.findById(id).get();
	}

    /**
     * 条件查询+age排序
     * @param searchMap
     */
	public List<JpaUser> findSearch(Map searchMap) {
        Specification<JpaUser> specification = createSpecification(searchMap);
		Sort sort = new Sort(Sort.Direction.ASC, "age");
        return userDao.findAll(specification,sort);
	}

    /**
     * 条件+分页+age排序
     * @param searchMap
     * @param page
     * @param size
     */
	public Page<JpaUser> findSearch(Map searchMap, int page, int size) {
		Specification<JpaUser> specification = createSpecification(searchMap);
		Sort sort = new Sort(Sort.Direction.ASC, "age");
		PageRequest pageRequest = PageRequest.of(page - 1, size,sort);
		return userDao.findAll(specification, pageRequest);
	}

	/**
	 * 创建查询条件
	 */
	private Specification<JpaUser> createSpecification(Map searchMap) {
		return new Specification<JpaUser>() {
			@Override
			public Predicate toPredicate(Root<JpaUser> root, CriteriaQuery<?> criteriaQuery,
										 CriteriaBuilder criteriaBuilder) {
				List<Predicate> preList = new ArrayList<Predicate>();
				if (searchMap.get("name") != null && !"".equals((searchMap.get("name")))) {
					preList.add(
							criteriaBuilder.like(root.get("name").as(String.class), "%" + searchMap.get("name") + "%"));
				}
				if (searchMap.get("age") != null && !"".equals((searchMap.get("age")))) {
					preList.add(criteriaBuilder.equal(root.get("age").as(Integer.class), searchMap.get("age")));
				}
				Predicate[] preArray = new Predicate[preList.size()];
				return criteriaBuilder.and(preList.toArray(preArray));
			}
		};
	}
}
