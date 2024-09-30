package com.himedia.mc;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@CrossOrigin(origins="http://localhost:3000")
public class HomeControl {
	@Autowired DAO dao;
	@Autowired BoardDAO bdao;
	@Autowired MenuDAO mdao;
	
	@GetMapping("/menuct")
	public String menuct() {
		return "menu/crud";
	}
	@PostMapping("/getmenus")
	@ResponseBody
	public String getmenu() {
		ArrayList<MenuDTO> menu = mdao.getmenu();
		for(int i=0;i<menu.size();i++) {
			System.out.println(menu.get(i));
		}
		JSONArray ja = new JSONArray();
		for (MenuDTO ml : menu) {
			JSONObject jo = new JSONObject();
			jo.put("id",ml.getId());
			jo.put("name",ml.getName());
			jo.put("price",ml.getPrice());
			System.out.println("id"+ml.id);
			System.out.println("name"+ml.name);
			
			ja.put(jo);
		}
		
		return ja.toString();
	}
	@PostMapping("/addmenu")
	@ResponseBody
	public String addmenu(HttpServletRequest req) {
		String name = req.getParameter("name");
		String price = req.getParameter("price");
		System.out.println(name+price);
		mdao.insertm(name, Integer.parseInt(price));
		return "ok";
		
	}
	@PostMapping("/delmenu")
	@ResponseBody
	public String delmenu(HttpServletRequest req) {
		int id = Integer.parseInt(req.getParameter("id"));
		mdao.delmenu(id);
		return "ooo";
	}
	@PostMapping("/updatemenu")
	@ResponseBody
	public String updatemenu(HttpServletRequest req) {
		int id = Integer.parseInt(req.getParameter("id"));
		String name = req.getParameter("name");
		int price = Integer.parseInt(req.getParameter("price"));
		mdao.updateM(id, name, price);
		return "oko";
	}
	@GetMapping("/orderct")
	public String orderct() {
		return "menu/order";
	}
	
	@PostMapping("/addsales")
	@ResponseBody
	public String addsales(HttpServletRequest req) {
		int id = Integer.parseInt(req.getParameter("id"));
		int price = Integer.parseInt(req.getParameter("price"));
		int qty = Integer.parseInt(req.getParameter("qty"));
		String mobile = req.getParameter("mobile");
		
		System.out.println(id);
		System.out.println(price);
		System.out.println(mobile);
		System.out.println(qty);
		mdao.insertsales(mobile, id, qty, price);
		return "orderct";
	}
	/*
	 * @PostMapping("/addsales2")
	 * 
	 * @ResponseBody public String addsales2(HttpServletRequest req) { String q =
	 * req.getParameter("1"); return "ok"; }
	 */
	
	@PostMapping("/getsales")
	@ResponseBody
	public String getsales(HttpServletRequest req) {
		
		ArrayList<SalesDTO> a = mdao.getSales();
		System.out.println("a size="+a.size());
		JSONArray ja = new JSONArray();
		for(SalesDTO sdto : a) {
			JSONObject S = new JSONObject();
			S.put("id",sdto.getId());
			S.put("mobile",sdto.getMobile());
			S.put("name",sdto.getName());
			S.put("qty",sdto.getQty());
			S.put("price",sdto.getPrice());
			S.put("create",sdto.getCreated());
			ja.put(S);
		}
		return ja.toString();
		
	}
	
	
	@PostMapping("/list")
	@ResponseBody
	public String dolist(HttpServletRequest req) {
		int start = 0;
		ArrayList<BoardDTO> arBoard = bdao.getList(start);
		System.out.println("arboard size="+arBoard.size());
		JSONArray ja = new JSONArray();
		for(BoardDTO bdto : arBoard) {
			JSONObject jo = new JSONObject();
			jo.put("id",bdto.getId());
			jo.put("title",bdto.getTitle());
			jo.put("content",bdto.getContent());
			jo.put("writer",bdto.getWriter());
			jo.put("created",bdto.getCreated());
			jo.put("updated",bdto.getUpdated());
			jo.put("hit",bdto.getHit());
			
			ja.put(jo);
		}
		return ja.toString();
	}
	@GetMapping("/crud")
	public String crud(HttpServletRequest req) {
		HttpSession s = req.getSession(); 
		String id = (String)s.getAttribute("id");
		if(id == null || id.equals("")) return "redirect:/login";
		return "ajax/crud";
	}
	@PostMapping("/addcon")
	@ResponseBody
	public String addcon(HttpServletRequest req) {
		HttpSession s = req.getSession(); 
		String title = req.getParameter("title");
		String writer = (String)s.getAttribute("id");
		String content = req.getParameter("content");
		System.out.println(writer);
		bdao.insert(title, writer, content);
		
		return "oo";
	}
	@PostMapping("/upcon")
	@ResponseBody
	public String upcon(HttpServletRequest req) {
		int id = Integer.parseInt(req.getParameter("id"));
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		bdao.update(id, title, content);
		
		return "oox";
	}
	
	@PostMapping("/delboard")
	@ResponseBody
	public String delboard(HttpServletRequest req) {
		int id = Integer.parseInt(req.getParameter("id"));
		BoardDTO bdto = bdao.delsel(id);
		System.out.println(bdto.getContent());
		return bdto.getContent();
	}
	@PostMapping("/delboardx")
	@ResponseBody
	public String delboardx(HttpServletRequest req) {
		int id = Integer.parseInt(req.getParameter("id"));
		bdao.delselx(id);
		return "ox";
	}
	
//	@PostMapping("/qtest")
//	@ResponseBody
//	public String test(HttpServletRequest req) {
//		int sum = mdao.sum();
//		String a = String.valueOf(sum);
//		System.out.println("zzzzzzzzzzzzzzzzzzzzzzz"+sum);
//		return a;
//	}
	
	@GetMapping("/")
		public String home(HttpServletRequest req,Model model) {
			String linkstr = "";
			String newpost = "";
			HttpSession s = req.getSession();
			String id = (String) s.getAttribute("id");
			if(id == null || id.equals("")) {
				linkstr = "<a href='/login'>로그인</a>&nbsp;&nbsp;&nbsp;"+
						"<a href='/signup'>회원가입</a>";
				newpost = "";
			}else {
				linkstr = "사용자 ["+id+"]&nbsp;&nbsp;&nbsp;"+
						"<a href='/logout'>로그아웃</a>";
				newpost = "<a href='/write'>새글작성</a>";
			}
			model.addAttribute("linkstr",linkstr);
			model.addAttribute("newpost",newpost);
			
			String pageno= req.getParameter("p");
			int nowpage=1;
			if(pageno==null || pageno.equals("")) nowpage =1;
			else nowpage = Integer.parseInt(pageno);
			
			int total = bdao.getcount();
			int pagesize=20;
			
			int start = (nowpage-1)*pagesize;
			int lastpage = (int)Math.ceil((double)total/pagesize);
			
			String movestr = "<a href='/?p=1'>처음</a>&nbsp;&nbsp;";
			if(nowpage!=1) {
				movestr += "<a href='/?p="+(nowpage-1)+"'>이전</a>&nbsp;&nbsp;";
			}
			if(nowpage!=lastpage) {
				movestr += "<a href='/?p="+(nowpage+1)+"'>다음</a>&nbsp;&nbsp;";
			}
			movestr += "<a href='/?p="+lastpage+"'>마지막</a>&nbsp;&nbsp;";
			
			model.addAttribute("movestr",movestr);
			
			ArrayList<BoardDTO> arBoard = bdao.getList(start);
			System.out.println(arBoard.size());
			model.addAttribute("arBoard",arBoard);
		return "home";
	}
	@GetMapping("/logout")
	public String logout(HttpServletRequest req) {
		HttpSession s = req.getSession();
		s.invalidate();
		return "redirect:/";
	}
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	@PostMapping("/dologin")
	public String dolo(HttpServletRequest req) {
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		HttpSession s = req.getSession();
		int a = dao.logch(id,pass);
		System.out.println(a);
		if(a==1) {
			s.setAttribute("id", id);
			return "redirect:/";
		
		}
		return "login";
		
	}
	@GetMapping("/signup")
	public String signup() {
		return "signup";
	}
	@PostMapping("/dosignup")
	public String dosign(HttpServletRequest req) {
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		String pass2 = req.getParameter("pass2");
		String name = req.getParameter("name");
		String birth = req.getParameter("birth");
		String gender = req.getParameter("gender");
		String mobile = req.getParameter("mobile");
		String[] re = req.getParameterValues("fav");
		System.out.println(re[1]);
		if(!pass.equals(pass2)) {
			return "signup";
		}
		String fav="";
		for (int i=0; i<re.length;i++) {fav += re[i]+",";}
		dao.savesignup(id,pass,name,birth,gender,mobile,fav);
		return "login";
	}
	@GetMapping("/board")
	public String showBoard(HttpServletRequest req) {
		HttpSession s = req.getSession();
		String id = (String)s.getAttribute("id");
		if(id==null || id.equals("")) {
			return "login";
		}
		return "board";
	}
	@GetMapping("/write")
	public String write(HttpServletRequest req,Model model) {
		HttpSession s = req.getSession();
		String id = (String)s.getAttribute("id");
		model.addAttribute("id",id);
		return "board/write";
	}
	@PostMapping("/save")
	public String save(HttpServletRequest req,Model model) {
		String title = req.getParameter("title");
		String writer= req.getParameter("writer");
		String content= req.getParameter("content");
		bdao.insert(title, writer, content);
		
		return "redirect:/"; 
	}
	@GetMapping("/view")
	public String view(HttpServletRequest req,Model model) {
		int id = Integer.parseInt(req.getParameter("id"));
		BoardDTO bdto = bdao.getView(id);
		bdao.addHit(id);
		model.addAttribute("board",bdto);

			ArrayList<ReDTO> a = bdao.getre(id);
			model.addAttribute("acb",a);
			//System.out.println(model.getAttribute("acb"));
			
		return "board/view";
	}
	@GetMapping("/delete")
	public String delete(HttpServletRequest req) {
		HttpSession s = req.getSession();
		String userid = (String)s.getAttribute("id");
		if(userid==null || userid.equals("")) {
			return "redirect:/";
		}
		int id = Integer.parseInt(req.getParameter("id"));
		BoardDTO bdto = bdao.getView(id);
		if(userid.equals(bdto.getWriter())) {
			bdao.delete(id);
		}
		return "redirect:/";
	}
	@GetMapping("/update")
	public String update(HttpServletRequest req,Model model) {
		HttpSession s = req.getSession();
		String userid = (String)s.getAttribute("id");
		if(userid==null || userid.equals("")) {
			return "redirect:/";
		}
		int id = Integer.parseInt(req.getParameter("id"));
		BoardDTO bdto = bdao.getView(id);
		if(userid.equals(bdto.getWriter())) {
			model.addAttribute("board",bdto);
			return "board/update";
		}
		return "redirect:/";
	}
	@PostMapping("/modify")
	public String modify(HttpServletRequest req,Model model) {
		int id = Integer.parseInt(req.getParameter("id"));
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		bdao.update(id, title, content);
		return "redirect:/";
	}
	@GetMapping("/room")
	public String room() {
		return "room";
	}
	
	@PostMapping("/getType")
	@ResponseBody
	public String getT(HttpServletRequest req) {
		ArrayList<TypeDTO> a = mdao.getType();
		JSONArray Ty = new JSONArray();
		for(TypeDTO Tdto : a) {
			JSONObject T = new JSONObject();
			T.put("id",Tdto.getId());
			T.put("roomname",Tdto.getRoomname());
			
			Ty.put(T);
		}
		return Ty.toString();
	}
	
	@PostMapping("/insertRoom")
	@ResponseBody
	public String insertR(HttpServletRequest req) {
		int type = Integer.parseInt(req.getParameter("id"));
		String name = req.getParameter("name");
		int person = Integer.parseInt(req.getParameter("person"));
		int price = Integer.parseInt(req.getParameter("price"));
		mdao.insertRoom(name,type,person,price);
		System.out.println(name+type+person+price);
		
		return "room";
	}
	
	@PostMapping("/getRoomlist")
	@ResponseBody
	public String getRooml(HttpServletRequest req) {
		ArrayList<RoomDTO> a = mdao.getRoom();
		JSONArray Ty = new JSONArray();
		for(RoomDTO Rdto : a) {
			JSONObject T = new JSONObject();
			T.put("id",Rdto.getId());
			T.put("name",Rdto.getName());
			T.put("type",Rdto.getRoomname());
			T.put("person",Rdto.getPersonnel());
			T.put("price",Rdto.getPrice());
			Ty.put(T);
		}
		return Ty.toString();
	}
	@PostMapping("/delRoom")
	@ResponseBody
	public String delR(HttpServletRequest req) {
		int id = Integer.parseInt(req.getParameter("id"));
		mdao.delRoom(id);
		System.out.println(id);
		
		return "room";
	}
	
	@PostMapping("/updateRoom")
	@ResponseBody
	public String upR(HttpServletRequest req) {
		String name = req.getParameter("name");
		int id = Integer.parseInt(req.getParameter("id"));
		int price = Integer.parseInt(req.getParameter("price"));
		int person = Integer.parseInt(req.getParameter("person"));
		int list = Integer.parseInt(req.getParameter("list"));
		mdao.upRoom(name,id,person,price,list);
		System.out.println(name+id+price+person+list);
		
		return "room";
	}
//	@PostMapping("/recontent")
//	@ResponseBody
//	public String recontent(HttpServletRequest req,Model model) {
//		String recon = req.getParameter("recon");
//		int parid = Integer.parseInt(req.getParameter("parid"));
//		HttpSession s = req.getSession();
//		String userid = (String)s.getAttribute("id");
//		int memid = bdao.getmemid(userid);
//		//System.out.println(memid+recon+parid);
//		bdao.insertrecon(parid,recon,memid);
////		ArrayList<ReDTO> a = bdao.getre(parid);
////		model.addAttribute("a",a);
//		return "board/view";
//	}
	
	
//	@PostMapping("/reply")
//	@ResponseBody
//	public String reply(HttpServletRequest req,Model model) {
//		int parid = Integer.parseInt(req.getParameter("bid"));
//		ArrayList<ReDTO> a = bdao.getre(parid);
//		HttpSession s = req.getSession();
//		String userid = (String)s.getAttribute("id");
//		int memid = bdao.getmemid(userid);
//		System.out.println(memid);
//		bdao.insertrecon(parid,con,memid);
//		return "ok";
//	}
	
	
	@PostMapping("/reshow")
	@ResponseBody
	public String reshow(HttpServletRequest req,Model model) {
		String con = req.getParameter("recon");
		System.out.println(con);
		int parid = Integer.parseInt(req.getParameter("bid"));
		System.out.println(parid);
		HttpSession s = req.getSession();
		String userid = (String)s.getAttribute("id");
		int memid = bdao.getmemid(userid);
		System.out.println(memid);
		bdao.insertrecon(parid,con,memid);
		return "ok";
	}
	@PostMapping("/redel")
	@ResponseBody
	public String redel(HttpServletRequest req,Model model) {
		int id = Integer.parseInt(req.getParameter("reid"));
		bdao.redel(id);
		
		return "ok";
	}
	

	@PostMapping("/reup")
	@ResponseBody
	public String reup(HttpServletRequest req,Model model) {
		int id = Integer.parseInt(req.getParameter("reid"));
		String upcon = req.getParameter("ddup");
		bdao.reup(upcon, id);
		return "ok";
	}
	@PostMapping("/ddinsert")
	@ResponseBody
	public String rein(HttpServletRequest req,Model model) {
		String ddcon = req.getParameter("ddcon");
		int reid= Integer.parseInt(req.getParameter("reid"));
		HttpSession s = req.getSession();
		String userid = (String)s.getAttribute("id");
		int memid = bdao.getmemid(userid);
		bdao.reinsert(reid, ddcon, memid);
		return"ok";
	}
	@PostMapping("/ddre")
	@ResponseBody
	public String ssre(HttpServletRequest req,Model model) {
		//int id= Integer.parseInt(req.getParameter("id"));
		ArrayList<ReDTO> a = bdao.get();
		JSONArray ddre = new JSONArray();
		for(ReDTO Rdto : a) {
			JSONObject T = new JSONObject();
			T.put("id",Rdto.getId());
			T.put("parid",Rdto.getPar_id());
			T.put("Userid",Rdto.getUserid());
			T.put("Content",Rdto.getContent());
			T.put("Updated",Rdto.getUpdated());
			
			ddre.put(T);
		}
		return ddre.toString();
	}
}	