package repositorios;

import org.springframework.data.jpa.repository.JpaRepository;

import entidades.Administrador;

public interface AdministradorRepositorio extends JpaRepository<Administrador, Integer>{
}

