<%@ page language="java"
	import="java.awt.*"
	import="java.awt.image.BufferedImage"
	import="java.util.*"
	import="javax.imageio.ImageIO"	
	pageEncoding="gb2312"%>
<html>
<%
	response.setHeader("Cache-Control","no-cache"); 
	// 在内存中创建图象 
	int width = 60, height = 20;
	BufferedImage image = new BufferedImage(width, height,
		BufferedImage.TYPE_INT_RGB);
	//获取画笔
	Graphics g = image.getGraphics();
	//设定背景色 
	g.setColor(new Color(200, 200, 200));
	g.fillRect(0, 0, width, height);
	//取随机产生的验证码(4位数字) 
	Random rnd = new Random();
	//int randNum = rnd.nextInt(8999) + 1000;
	String randStr = "";
	g.setColor(Color.black);
	g.setFont(new Font("", Font.PLAIN, 20));
	for ( int i = 0; i < 4; i++ )
    {
		String str_1="";
        String str = rnd.nextInt( 2 ) % 2 == 0 ? "num" : "char";
        if ( "char".equalsIgnoreCase( str ) )
        { // 产生字母
            int nextInt = rnd.nextInt( 2 ) % 2 == 0 ? 65 : 97;
            // System.out.println(nextInt + "!!!!"); 1,0,1,1,1,0,0
            str_1 = (char) ( nextInt + rnd.nextInt( 26 ) )+"";
        }
        else if ( "num".equalsIgnoreCase( str ) )
        { // 产生数字
        	str_1 = String.valueOf( rnd.nextInt( 10 ) );
        }
        g.drawString(str_1, 3+i*15, 17+i*1);
        randStr+=str_1;
    }
	
	//将验证码存入session
	session.setAttribute("randStr", randStr);
	//将验证码显示到图象中 
	
	
	
	// 随机产生30个干扰点，使图象中的验证码不易被其它程序探测到 
	for (int i = 0; i < 30; i++){
		int x = rnd.nextInt(width);
		int y = rnd.nextInt(height);
		g.drawOval(x, y, 1, 1);
	}
	// 输出图象到页面 
	ImageIO.write(image, "JPEG", response.getOutputStream());
	out.clear();
	out = pageContext.pushBody();
%>
</html>