package repositorios;

import org.springframework.data.jpa.repository.JpaRepository;

import entidades.Curso;

public interface CursoRepositorio extends JpaRepository<Curso, Integer>{
}
