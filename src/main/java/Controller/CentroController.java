package Controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import entidades.Administrador;
import entidades.Centro;
import entidades.Curso;
import repositorios.CentroRepositorio;


@Controller
@RequestMapping("/centro")
public class CentroController {

	@Autowired
	private CentroRepositorio centroRepositorio;
	
	@PostMapping
	public String salvarCentro(@RequestBody Centro centro) {
		System.out.println("Owner save called...");

		// a new Centro
	        Centro novoCentro = new Centro(centro.getNome(), centro.getCursoList(), centro.getAdministradorList());
		// listas
	        List<Administrador> admins = new ArrayList();
	        for (Administrador newAdmin : centro.getAdministradorList()) {
	            // new admin
	            Administrador admin = new Administrador(newAdmin.getNome(), newAdmin.getMatricula(), newAdmin.getSenha());
	            admin.setCentro(novoCentro);
	            admins.add(admin);
	        }
	        novoCentro.setAdministradorList(admins);
	     
	        List<Curso> cursos = new ArrayList();
	        for (Curso newCurso : centro.getCursoList()) {
	            // new curso
	            Curso curso = new Curso(newCurso.getNome(), newCurso.getTurno(), newCurso.getDuracao());
	            curso.setCentro(novoCentro);
	            cursos.add(curso);
	        }
	        
	        // add blog list to Owner
	        novoCentro.setCursoList(cursos);

		// save Owner
	        Centro saidaCentro = centroRepositorio.save(novoCentro);
		return "Centro Salvo!!";
	}
}
