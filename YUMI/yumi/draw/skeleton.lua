local num_list={}--血量缓存数组
local _,瞄准--初始化 upvalue
local 击伤队列=CanvasAnimationSet()--实例化动画队列

return function(view,画布,画笔,self,fps,data)
  local skeleton={}--骨骼缓存数组

  local _fps,_time=fps()--获取fps数值
  if _fps>=50--判断帧率切换画笔颜色
    setColor("FPS画笔",0xff00ff00)
   elseif _fps<30
    setColor("FPS画笔",0xffff0000)
   else
    setColor("FPS画笔",0xFFFF7F00)
  end

  画布.drawText(tostring(_fps),100,126,FPS画笔)--绘制FPS
  画布.drawText("FPS",100,100,FPS画笔)--绘制FPS

  local id1,id2=0,0--申明人数变量

  file:seek('set')--移动文件指针
  for str file:lines()--按行读取b.log
    string.split(str,",")--分割字符串
    local x,y,w,h,m,hp,--x y 人物宽度 人物高度 敌人距离 敌人血量
    ai,dz,zy,dx,name,--人机判断 未知 敌人队营 倒地血量 敌人名字
    头部X,头部Y,胸部X,胸部Y,盆骨X,盆骨Y,左肩X,左肩Y,右肩X,右肩Y,左手肘X,左手肘Y,右手肘X,右手肘Y,左手腕X,左手腕Y,右手腕X,右手腕Y,左大腿X,左大腿Y,右大腿X,右大腿Y,左膝盖X,左膝盖Y,右膝盖X,右膝盖Y,左脚腕X,左脚腕Y,右脚腕X,右脚腕Y
    =tonumber(data[1]),tonumber(data[2]),
    tonumber(data[3]),tonumber(data[4]),
    tointeger(data[5]),tointeger(data[6]),
    tonumber(data[7]),tonumber(data[8]),
    tonumber(data[9]),tonumber(data[10]),data[11]
    ,tonumber(data[12]),tonumber(data[13]),tonumber(data[14]),tonumber(data[15]),tonumber(data[16]),tonumber(data[17]),tonumber(data[18]),tonumber(data[19]),tonumber(data[20]),tonumber(data[21]),tonumber(data[22]),tonumber(data[23]),tonumber(data[24]),tonumber(data[25]),tonumber(data[26]),tonumber(data[27]),tonumber(data[28]),tonumber(data[29]),tonumber(data[30]),tonumber(data[31]),tonumber(data[32]),tonumber(data[33]),tonumber(data[34]),tonumber(data[35]),tonumber(data[36]),tonumber(data[37]),tonumber(data[38]),tonumber(data[39]),tonumber(data[40]),tonumber(data[41])


    if x and y and w and h and m--过滤异常数据
      and hp and ai and zy and dx and name and 右脚腕X

      if ai==0 or zy==996--人机
        id2=id2+1--人机+1
       else--真人
        id1=id1+1--真人+1
      end

      local 队伍颜色_0xff=随机颜色(zy)--随机颜色
      local 队伍颜色_0xef=随机颜色(zy,0xef)
      local 队伍颜色_0xef_0z1_0x1=随机颜色(zy,0xef,-0.1,0.1)
      local 队伍颜色_0xaf_0_0x1=随机颜色(zy,0xaf,0,0.1)


      --击伤特效，不懂勿动
      local __hp
      if hp>100
        __hp=100
       elseif hp<0
        __hp=0
       else
        __hp=hp
      end
      if 击伤开关 and not tonumber(name)--击伤特效
        if !num_list[name]
          num_list[name]=__hp
        end
        if __hp~=num_list[name] and w>0
          local alpha=CanvasAnimation(255,0,1500)
          local dis=CanvasAnimation(0,200,1500,0.01)
          if num_list[name]<__hp
            alpha.color=0xff00ef00
            alpha.text="+"..(__hp-num_list[name])
           else
            alpha.color=0xffff0000
            alpha.text=tostring(__hp-num_list[name])
          end
          dis.x=x-126+(2.54*hp)+30
          dis.y=(y-w)-66
          击伤队列:append("alpha",alpha,"dis",dis)
        end
        num_list[name]=__hp
      end
      --击伤特效，不懂勿动


      if w>0--过滤掉背后的敌人
        x=x+(w/2)--身位矫正 向右挪移半个身位

        if ai==0--人机判断
          if 绘制背敌
            setColor("背敌画笔1",0xffffffff)--切换画笔颜色
            setColor("背敌画笔2",0xef404040)
            setColor("背敌文字",0xef404040)
          end
          if 绘制方框
            --判断是否瞄准
            if y>height_2-w and y<height_2+w and x>width_2-(w/2) and x<width_2+(w/2)--判断是否被瞄准
              瞄准=true
             else
              setColor("方框画笔",0xafffffff)
              瞄准=false
            end
          end
          name="BOT"
         else--真人
          if 绘制背敌
            setColor("背敌画笔1",队伍颜色_0xef)
            setColor("背敌画笔2",0xffffffff)
            setColor("背敌文字",0xffffffff)
          end
          if 绘制方框
            --判断是否瞄准
            if y>height_2-w and y<height_2+w and x>width_2-(w/2) and x<width_2+(w/2)--判断是否被瞄准
              瞄准=true
             else
              setColor("方框画笔",队伍颜色_0xaf_0_0x1)
              瞄准=false
            end
          end
        end


        if x+(w/2)<0--左侧背敌
          if 绘制背敌
            画布.drawRect(0,y-25,90,y+25,背敌画笔1)--背敌填充
            画布.drawRect(-1,y-25-1,91,y+25+1,背敌画笔2)--背敌边框
            画布.drawText(m.."m",45,y+8,背敌文字)--背敌文字
          end
         elseif x-(w/2)>width--右侧背敌
          if 绘制背敌
            画布.drawRect(width,y-25,width-90,y+25,背敌画笔1)
            画布.drawRect(width+1,y-25-1,width-91,y+25+1,背敌画笔2)
            画布.drawText(m.."m",width-45,y+8,背敌文字)
          end
         elseif y+w<0--上方背敌
          if 绘制背敌
            画布.drawRect(x-45,0,x+45,50,背敌画笔1)
            画布.drawRect(x-45-1,-1,x+45+1,51,背敌画笔2)
            画布.drawText(m.."m",x,35,背敌文字)
          end
         else--敌人方框

          len=#skeleton

          if 绘制骨骼
            画布.drawCircle(头部X,头部Y,w/9,骨骼画笔2)--绘制骨骼头部
            skeleton[len+1],skeleton[len+2],skeleton[len+3],skeleton[len+4],skeleton[len+5],skeleton[len+6],skeleton[len+7],skeleton[len+8],skeleton[len+9],skeleton[len+10],skeleton[len+11],skeleton[len+12],skeleton[len+13],skeleton[len+14],skeleton[len+15],skeleton[len+16],skeleton[len+17],skeleton[len+18],skeleton[len+19],skeleton[len+20],skeleton[len+21],skeleton[len+22],skeleton[len+23],skeleton[len+24],skeleton[len+25],skeleton[len+26],skeleton[len+27],skeleton[len+28],skeleton[len+29],skeleton[len+30],skeleton[len+31],skeleton[len+32],skeleton[len+33],skeleton[len+34],skeleton[len+35],skeleton[len+36],skeleton[len+37],skeleton[len+38],skeleton[len+39],skeleton[len+40],skeleton[len+41],skeleton[len+42],skeleton[len+43],skeleton[len+44],skeleton[len+45],skeleton[len+46],skeleton[len+47],skeleton[len+48],skeleton[len+49],skeleton[len+50],skeleton[len+51],skeleton[len+52]=胸部X, 胸部Y, 盆骨X, 盆骨Y,胸部X, 胸部Y, 左肩X, 左肩Y,胸部X, 胸部Y, 右肩X, 右肩Y,左肩X, 左肩Y, 左手肘X, 左手肘Y,右肩X, 右肩Y, 右手肘X, 右手肘Y,左手肘X, 左手肘Y, 左手腕X, 左手腕Y,右手肘X, 右手肘Y, 右手腕X, 右手腕Y,盆骨X, 盆骨Y, 左大腿X, 左大腿Y,盆骨X, 盆骨Y, 右大腿X, 右大腿Y,左大腿X, 左大腿Y, 左膝盖X, 左膝盖Y,右大腿X, 右大腿Y, 右膝盖X, 右膝盖Y,左膝盖X, 左膝盖Y, 左脚腕X, 左脚腕Y,右膝盖X, 右膝盖Y, 右脚腕X, 右脚腕Y
          end--缓存骨骼数据

          if 绘制方框
            if 瞄准--如果瞄准 使用发光画笔绘制方框
              画布.drawRect(x-(w/2),(y-w),x+(w/2),y+w,瞄准画笔)--绘制方框
             else
              画布.drawRect(x-(w/2),(y-w),x+(w/2),y+w,方框画笔)--绘制方框
            end
          end


          if 绘制信息
            if ai==0--人机判断
              setColor("信息画笔",0xef505050)
              setColor("信息画笔2",0xef404040)
             else
              setColor("信息画笔",队伍颜色_0xef_0z1_0x1)
              setColor("信息画笔2",队伍颜色_0xff)
            end

            --绘制信息框
            画布.drawRect(x-130,(y-w)-66,x+130,(y-w)-27,信息画笔)
            --绘制阵营卡片
            画布.drawRect(x-130,(y-w)-66,x-90,(y-w)-33,信息画笔2)

            画布.drawText(tostring(zy),x-111,(y-w)-42,阵营画笔)--绘制队营文字
            画布.drawText(m.."m",x+120,(y-w)-42,距离画笔)--绘制距离文字
            画布.drawText(name,x,(y-w)-42,名字画笔)--绘制人物名字

            if hp>100--适配团竞
              setColor("血条画笔2",0xFF00FF00)--蓝色血条
              画布.drawText(math.ceil(hp).."HP",x+140,(y-w)-41,血条画笔3)--文字血量
              hp=100
             elseif hp<=0--敌人倒地
              setColor("血条画笔2",0xffff0000)--设置红色血条
              hp=dx--设置敌人的倒地血量
             else--健康血量
              setColor("血条画笔2",0xffffffff)--设置绿色血条
            end
            画布.drawLine(x-126,(y-w)-31,x-126+(2.54*hp),(y-w)-31,血条画笔2)--绘制血条
            if 绘制射线
              画布.drawLine(width_2,104,x,(y-w)-68,射线画笔)--绘制射线
            end
           else
            if 绘制射线
              画布.drawLine(width_2,104,x,(y-w)-26,射线画笔)--绘制射线
            end
          end

          画布.drawText("▼",x,(y-w)-7,名字画笔)--绘制指针

        end
       else--后方背敌
        if 绘制背敌
          if ai==0
            setColor("背敌画笔1",0xffffffff)
            setColor("背敌画笔2",0xef404040)
            setColor("背敌文字",0xef404040)
           else--真人
            setColor("背敌画笔1",队伍颜色_0xef)
            setColor("背敌画笔2",0xffffffff)
            setColor("背敌文字",0xffffffff)
          end
          画布.drawRect(x-45,height,x+45,height-50,背敌画笔1)
          画布.drawRect(x-45-1,height-1,x+45+1,height-51,背敌画笔2)
          画布.drawText(m.."m",x,height-20,背敌文字)
        end
      end
    end
    --table.clear(data)--清空data，如要开启调试模式，建议取消注释
  end

  if 绘制骨骼--绘制骨骼
    画布.drawLines(skeleton,骨骼画笔1)
  end

  if 击伤开关--击伤特效，不懂勿动
    击伤队列:forEach(function(v,o)
      setColor("伤害画笔1",o.alpha.color)
      伤害画笔1.setAlpha(v.alpha)
      伤害画笔2.setAlpha(v.alpha)
      画布.drawText(o.alpha.text,o.dis.x,o.dis.y-v.dis,伤害画笔1)
      画布.drawText(o.alpha.text,o.dis.x,o.dis.y-v.dis,伤害画笔2)
    end)
  end

  --人数 人机
  if id1==0--切换人数颜色
    setColor("人数画笔1",0xfF07BE2E)
   else
    setColor("人数画笔1",0xFFFF193F)
  end
  画布.drawRect((width_2)-60,55,width_2,100,人数画笔1)--绘制人数背景
  画布.drawText(tostring(id1),width_2-30,87.5,人数画笔2)--人数字体

  --人数 玩家
  if id2==0
    setColor("人数画笔1",0xfF07BE2E)
   else
    setColor("人数画笔1",0xFFFF8100)
  end
  画布.drawRect((width_2)+60,55,width_2,100,人数画笔1)--绘制人数的背景
  画布.drawText(tostring(id2),width_2+30,87.5,人数画笔2)

end