#discrete-event simulation (DES) as in N.Matloff 'The art of R programming'
#this example is worth investing the time because illustrates
#the idea of objects and global environment (i.e. encapsulation)   

#events are represented by rows in dataframe
#format: eventype(string), arrival time(numeric)

# global list sim stores the events (evnts) & dbg for debuggin mode

#forms a row for an event of type evntty that occurs at time evnttm
#appin is optional set of application-specific traits of the event
evntrow <- function(evnttm, evntty, appin = NULL) {
  rw <- c(list(evnttime=evnttm,evnttype=evntty),appin)
  return(as.data.frame(rw))
}


#insert event with time evnttm and type evntty into list
schedevnt <- function(evnttm, evntty, appin = NULL) {
  newevnt <- evntrow(evnttm, evntty, appin)
  #if this event list is empty, set it
  if (is.null(sim$evnts)) {
    sim$evnts <<- newevnt
    return()
  }
  #otherwise, find insertion point
  inspt <- binsearch((sim$evnts)$evnttime, evnttm)
  #then insert accordingly the portion that should come 'before' or 'after' the new event 
  before <- 
    if (inspt==1) NULL else sim$evnts[1:(inspt-1),]
  nr <- nrow(sim$evnts)
  after <- if (inspt <= nr) sim$evnts[inspt:nr,] else NULL
  sim$evnts <<- rbind(before,newevnt,after)
}

#this function return the position in x before which y must be inserted
binsearch <- function(x,y) {
  n<-length(x)
  lo <- 1
  hi <- n
  while(lo+1 < hi) {
    mid <- floor((lo+hi)/2)
    if (y ==x[mid]) return(mid)
    if (y<x[mid]) hi <- mid else lo <- mid
  }
  if (y <= x[lo]) return(lo)
  if (y < x[hi]) return(hi)
  return(hi+1)
}


#start to process next event
getnextevnt <- function() {
  head <- sim$evnts[1,]
  #delete head
  if (nrow(sim$evnts) == 1) {
    sim$evnts <<- NULL
  } else sim$evnts <<- sim$evnts[-1,]
  return(head)
  }


#simulation body
#args:
#  initglbs: application specific initialization function
#  inits globals to statistical totals for the app, etc.
#  records apppars in globals; schedules the first event
#  reactevnt: application specific event handling function 
#  coding proper action for each type of event
#  prntrslts: prints application-specific parameters, eg. mean queue wait
#  apppars: list of application-specific parameters, eg. number of servers in queue
#  maxsimtime: simulation will be run until this simulated time
#  dbg: debug flag; if TRUE sim will be printed after each event

dosim <- function(initglbs, reactevnt, prntrslts, maxsimtime, apppars = NULL,
                  dbg = FALSE) {
  sim <<- list()
  sim$currtime <<- 0.0 #current simulated time
  sim$evnts <<- NULL #events data frame
  sim$dbg <<- dbg
  initglbs(apppars)
  while(sim$currtime < maxsimtime) {
    head <- getnextevnt()
    sim$currtime <<- head$evnttime #update current simulated time
    reactevnt(head) #process this event
    if (dbg) print(sim)
  }
  prntrslts()
}  
  


# DES application: M/M/1 queue, arrival rate 0.5, service rate 1.0

#initializes global variables specific to this app
mm1initglbls <- function(appars) {
  mm1glbls <<- list()
  #simulation parameters 
  mm1glbls$arrvrate <<- appars$arrvrate
  mm1glbls$srvrate <<- appars$srvrate
  #server queue, consisting of arrival times of queued jobs
  mm1glbls$srvq <<- vector(length=0)
  #statistics
  mm1glbls$njobsdone <<- 0 #jobs done so far
  mm1glbls$totwait <<- 0.0 # total wait so far
  #now set up first event 
  arrvtime <- rexp(1,mm1glbls$arrvrate)
  schedevnt(arrvtime, "arrv", list(arrvtime=arrvtime))
}

#application-specific event processing function called by dosim()
#in the general DES library
mm1reactevnt <- function(head) {
  if (head$evnttype == "arrv") { #arrival
    # if server free, start service, else add to queue
    # even if empty, for convenience
    if (length(mm1glbls$srvq) == 0) {
      mm1glbls$srvq <<- head$arrvtime
      srvdonetime <- sim$currtime + rexp(1,mm1glbls$srvrate)
      schedevnt(srvdonetime, "srvdone", list(arrvtime=head$arrvtime))
    } else mm1glbls$srvq <<- c(mm1glbls$srvq, head$arrvtime)
      #generate next arrival   
      arrvtime <- sim$currtime + rexp(1,mm1glbls$srvrate)
      schedevnt(arrvtime, "arrv", list(arrvtime=arrvtime))
  } else {
        #process job that just finished 
        #do accounting
    mm1glbls$njobsdone <<- mm1glbls$jobsdone + 1
    mm1glbls$totwait <<- mm1glbls$totwait + sim$currtime - head$arrvtime
    #remove from queue
    mm1glbls$srvq<<- mm1glbls$srvq[-1]
    #check if any left
    if(length(mm1glbls$srvq) > 0) {
    #schedule new service
      srvdonetime <- sim$currtime + rexp(1,mm1glbls$srvrate)  
      schedevnt(srvdonetime, "srvdone", list(arrvtime=mm1glbls$srvq[1]))
    }
  }
}

mm1prntrslts <- function() {
  print("mean wait:")
  print(mm1glbls$totwait/mm1glbls$njobdone)
}
