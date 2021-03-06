


# Shade the area in the persistency plot

shadeAreaP<-function(p,allEntity){
  # entity[1,]$Indexed=
  if(allEntity[1,]$Indexed==0){
  rect <- data.frame(xmin=allEntity[nrow(allEntity)-1,]$Release, xmax=allEntity[nrow(allEntity),]$Release, ymin=-Inf, ymax=Inf)
  p <-p + geom_rect(data=rect, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax),
                    color="white",
                    alpha=0.2,
                    inherit.aes = FALSE)+
    
    # ggtitle("Persistency Measure value based on entity count") +
    theme_hc() +
    scale_colour_tableau()
    return(p)
  }
  else{
    rect <- data.frame(xmin=allEntity[nrow(allEntity)-1,]$Release, xmax=allEntity[nrow(allEntity),]$Release, ymin=-Inf, ymax=Inf)
    p <-p + geom_rect(data=rect, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax),
                      color="white",
                      alpha=0.2,
                      inherit.aes = FALSE)+
      
      # ggtitle("Persistency Measure value based on entity count") +
      theme_hc() +
      scale_colour_tableau()
    return(p)
    
  }

}

reportPersistencyPlot<-function(transData){
p<-plot_persistency_data(transData)
areaPlot<-shadeAreaP(p,transData)
return(areaPlot)
}

# Persistency plot

plot_persistency_data<-function(entity){
  
  if(entity[1,]$Indexed==0){
    st<-total_count(entity)
    st<-distinct_entity(st)
    p<-ggplot(data=st, aes(x=Release, y=count, group=className,color=className)) +
      geom_line() +
      geom_point(size = 3) #+ theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
    
    return(p)
  }
  else{
    
    if(grepl("purl.org",entity[1,]$className)){
      print("####### aargon ######")
      # Release=mixedsort(unique(propertylist$Release))
      # 
      # st=tail(as.character(Release), n=2)
      # print("## print st with tail")
      # print(st)
      # 
      # 
      # st<-data.frame(v=st)
      # dt<-mixedsort(st$v)
      
      p<-ggplot(data=entity, aes(x=Release, y=count,group=className,color=className)) +
        geom_line() +
        geom_point(size=3)+theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
      
      
    }else{
      p<-ggplot(data=entity, aes(x=Release, y=count,group=className,color=className)) +
      geom_line() +
      geom_point(size=3)+theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
    }
    return(p)
  }
}


# Historical persistency plot


plotHistoricalPersistencyData<-function(entity){
  
  if(entity[1,]$Indexed==0){
    st<-total_count(entity)
    st<-distinct_entity(st)
    
    # entityNorm = ddply(entity, .(className), here(summarize), Release=Release,NormamizedCount=range01(count), normalize=(count-mean(count))/sd(count))
    # 
    # print(entityNorm)
    # 
    # p<-ggplot(data=st, aes(x=Release, y=count, group=className,color=className)) +
    #   geom_line() +
    #   geom_point(size=3)
    #   geom_bar(stat="identity") + theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5)) +
    #   theme_hc() +
    #   scale_colour_tableau()
      
      
    
     # stNorm = ddply(st, .(className), here(summarize), Release=Release,
     #                   Count=range01(count), normalize=(count-mean(count))/sd(count))
     # 
     # if()
     # 
     # print(stNorm)
       p<-ggplot(data=st, aes(x=Release, y=count,group=className,color=className)) +
        geom_line() +
        geom_point(size=3)+
        geom_bar(stat="identity", fill="steelblue")+theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))+
        geom_text(aes(label=count), vjust=1.6, color="white", size=3.5)+  
        theme_hc() +
        scale_colour_tableau()
      
      
      
    return(p)
  }
  else{
    
    if(grepl("purl.org",entity[1,]$className)){
      print("####### aargon ######")
      # Release=mixedsort(unique(propertylist$Release))
      # 
      # st=tail(as.character(Release), n=2)
      # print("## print st with tail")
      # print(st)
      # 
      # 
      # st<-data.frame(v=st)
      # dt<-mixedsort(st$v)
      entityNorm = ddply(entity, .(className), here(summarize), Release=Release,Count=range01(count), normalize=(count-mean(count))/sd(count))
      
      p<-ggplot(data=entityNorm, aes(x=Release, y=Count,group=className,color=className)) +
        geom_line() +
        geom_point(size=3)+
        geom_bar(stat="identity", fill="steelblue")+theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))+
        # geom_text(aes(label=Count), vjust=1.6, color="white", size=3.5)+  
            theme_hc() +
        scale_colour_tableau()
      
      
    }else{
      # freqDatPct= ddply(entity,.(className), here(transform), range=((count - 0)/(nrow(test)-0)) + 0)
     
      # very that the range of all is [0, 1]
      # slapply(normed, range)
      
      entityNorm = ddply(entity, .(className), here(summarize), Release=Release,Count=range01(count), normalize=(count-mean(count))/sd(count))
      
      # print(entityNorm)
      
      # entity$Count<-normalize(entity$count, range=c(0,1))
      p<-ggplot(data=entityNorm, aes(x=Release, y=Count,group=className,color=className)) +
        geom_line() +
        geom_point(size=3)+
        geom_bar(stat="identity", fill="steelblue")+theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))+
        # geom_text(aes(label=Count), vjust=1.6, color="white", size=3.5)+  
        
            theme_hc()+
        scale_colour_tableau()
    }
    return(p)
  }
}

range01 <- function(x){(x-min(x))/(max(x)-min(x))}


# KB growth plot

plot_Kbgrowth_data<-function(data){
  
  if(data[1,]$Indexed==0){
    st<-total_count(data)
    st<-distinct_entity(st)
    entity= ddply(st,.(className), here(transform), days=fn(Release))
    # ND<-NormDist(entityWithDays)
    
    en=entity[1:nrow(entity)-1,]
    
    enLm=lm(count~days,data=en)
    
    pred=data.frame(days=entity$days,count=predict(enLm,entity))
    
    summary(enLm)
    
    res=mean(abs(enLm$residuals))
    
    p<-ggplot(entity, aes(x = days, y = count)) + 
      geom_point() +
      geom_line(data=pred,color="red")+
      geom_ribbon(data=pred,aes(ymin=count-res,ymax=count+res),alpha=0.2)+
      theme_hc()+
      scale_colour_tableau()
    
    return(p)
    
  }
  else{
    entity= ddply(data,.(className), here(transform), days=fn(Release))
    en=entity[1:nrow(entity)-1,]
    
    enLm=lm(count~days,data=en)
    
    pred=data.frame(days=entity$days,count=predict(enLm,entity))
    
    summary(enLm)
    
    res=mean(abs(enLm$residuals))
    
    p<-ggplot(entity, aes(x = days, y = count)) + 
      geom_point() +
      geom_line(data=pred,color="red")+
      geom_ribbon(data=pred,aes(ymin=count-res,ymax=count+res),alpha=0.2)+
      theme_hc()+
      scale_colour_tableau()
    
    return(p)
  }
  
}


######## For visualization ##########


#--------Funtions for plot----------------#

plot_indexed_data<-function(entity){
  entity<-total_count(entity)
  entity<-distinct_entity(entity)
  
  # p <- ggplot(df, aes(x=grp, y=val)) 
  # p <- p + geom_bar(stat="identity", alpha=0.75) 
  # 
  # p + geom_line(data=df2, aes(x=grp, y=val), colour="blue")
  
  # p <- ggplot(data=entity, aes(x=Release, y=count, fill=className)) +
  #      geom_bar(stat="identity")
  
  p<-ggplot(data=entity, aes(x=Release, y=count),color=className) +
    geom_line() +
    geom_point()+theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))+
    theme_hc()+
    scale_colour_tableau()
  
  
  # my.df <- data.frame(index = 1:10, value = rnorm(10))
  
  #' create the ggplot object
  return(p)
}



