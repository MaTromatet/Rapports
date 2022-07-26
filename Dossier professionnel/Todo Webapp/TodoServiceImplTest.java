package fr.afpa.brice.todoApp.services.impl;

import static org.junit.jupiter.api.Assertions.*;
import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.fail;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;

import fr.afpa.brice.todoApp.daojpa.ITodoDao;
import fr.afpa.brice.todoApp.modeles.dto.TodoBean;
import fr.afpa.brice.todoApp.modeles.entities.TodoEntity;
import fr.afpa.brice.todoApp.modeles.mappers.TodoMapper;
import fr.afpa.brice.todoApp.services.ITodoService;

import org.junit.jupiter.api.Test;
@ExtendWith(MockitoExtension.class)
class TodoServiceImplTest {
	
    @InjectMocks
    private ITodoService serviceTodo = new TodoServiceImpl();

    @Mock
    private ITodoDao todoDao;

    @Mock
    private TodoBean todoBean;

    @Mock
    private TodoEntity todo;

    @Mock
    private List<TodoBean> todoBeans;

    @Mock
    private List<TodoEntity> todos;

	
	@Test
    void testGetTodos() {

        // ARRANGE
        TodoBean todo1 = new TodoBean(1,"todo1", "user1", "desc1", false);
        TodoBean todo2 = new TodoBean(2,"todo2", "user2", "desc2", true);
        todoBeans.add(todo1);
        todoBeans.add(todo2);

        TodoEntity todoE1 = new TodoEntity(1,"todo1", "user1", "desc1", false);
        TodoEntity todoE2 = new TodoEntity(2,"todo2", "user2", "desc2", true);
        todos.add(todoE1);
        todos.add(todoE2);

//https://www.baeldung.com/mockito-mock-static-methods

        assertThat(TodoMapper.toBean(todoE2)).isEqualTo(todo2);
        try (MockedStatic<TodoMapper> todoMap = Mockito.mockStatic(TodoMapper.class)) {
            todoMap.when(() -> TodoMapper.toBean(todoE2)).thenReturn(todo2);
            assertThat(TodoMapper.toBean(todoE2)).isEqualTo(todo2);

            todoMap.when(() -> TodoMapper.toBean(todoE1)).thenReturn(todo1);
            assertThat(TodoMapper.toBean(todoE1)).isEqualTo(todo1);

            when(todoDao.findAll()).thenReturn(todos);

            when(serviceTodo.getTodos()).thenReturn(todoBeans);

            // ACT
            List<TodoBean> retriedvedTodos = serviceTodo.getTodos();

            // ASSERT
            assertThat(retriedvedTodos).isEqualTo(todoBeans);

            // VERIFY
            verify(todoDao,times(2)).findAll();
        }

    }

    @Test
    void testUpdateTodo() {
        // ARRANGE
        TodoBean todo1 = new TodoBean(1,"todo1", "user1", "desc1", false);
        TodoBean todo2 = new TodoBean(2,"todo2", "user2", "desc2", true);
        todoBeans.add(todo1);
        todoBeans.add(todo2);

        TodoEntity todoE1 = new TodoEntity(1,"todo1", "user1", "desc1", false);
        TodoEntity todoE2 = new TodoEntity(2,"todo2", "user2", "desc2", true);
        todos.add(todoE1);
        todos.add(todoE2);

        //https://www.baeldung.com/mockito-mock-static-methods
        assertThat(TodoMapper.toEntity(todo1)).isEqualTo(todoE1);
        try (MockedStatic<TodoMapper> todoMap = Mockito.mockStatic(TodoMapper.class)) {
            todoMap.when(() -> TodoMapper.toEntity(todo2)).thenReturn(todoE2);
            assertThat(TodoMapper.toEntity(todo2)).isEqualTo(todoE2);

            todoMap.when(() -> TodoMapper.toEntity(todo1)).thenReturn(todoE1);
            assertThat(TodoMapper.toEntity(todo1)).isEqualTo(todoE1);



            https://www.baeldung.com/mockito-void-methods

            todoBean =     new TodoBean(1,"todo1", "user1", "desc1", false);
            ITodoService sTodo  = mock(TodoServiceImpl.class);

            doNothing().when(sTodo).updateTodo(todoBean);

            // ACT
            sTodo.updateTodo(todoBean);

            verify(sTodo).updateTodo(todoBean);

        }
    }

    @Test
    void testDeleteTodo() {
        // ARRANGE
        todoBean =     new TodoBean(1,"todo1", "user1", "desc1", false);
        // ACT
        serviceTodo.deleteTodo(1);

        // VERIFY
        verify(todoDao).deleteById(todoBean.getId());


    }

}
