package entidades;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;



@Entity
public class Centro {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String nome;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "Centro", cascade = CascadeType.ALL)
	private List<Curso> cursoList;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "Centro", cascade = CascadeType.ALL)
	private List<Administrador> administradorList;

	public Centro() {
		
	}
	
	public Centro(String nome, List<Curso> cursoList, List<Administrador> administradorList) {
		this.nome = nome;
		this.cursoList = cursoList;
		this.administradorList = administradorList;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public List<Curso> getCursoList() {
		return cursoList;
	}

	public void setCursoList(List<Curso> cursoList) {
		this.cursoList = cursoList;
	}

	public List<Administrador> getAdministradorList() {
		return administradorList;
	}

	public void setAdministradorList(List<Administrador> administradorList) {
		this.administradorList = administradorList;
	}
	
	
	
}
