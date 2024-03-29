#' ---
#' title: "Mod\u00e9lisation statistique par la pratique avec R"
#' subtitle: "Chapitre 2 : Mesures de liaison"
#' author: "Fr\u00e9d\u00e9ric Bertrand, Emmanuelle Claeys, Myriam Maumy-Bertrand"
#' date: "`r format(Sys.time(), '%d %B, %Y')`"
#' ---

#Chapitre 2
#page 22
set.seed(314)
x=rnorm(50)
Y=function(x){x^2}
par(oma=rep(0,4));par(mar=c(3, 3, 1, 1)+0.1,mgp=c(2,1,0))
plot(Y,xlab="X",from=-3, to=3,lwd=2,col="blue")
points(x,Y(x),col="red")

#page 23
data(anscombe)
with(anscombe,cor(x1,y1))
with(anscombe,cor(x2,y2))
with(anscombe,cor(x3,y3))
with(anscombe,cor(x4,y4))

old.par <- par(no.readonly = TRUE)

par(mar=c(3,3,2,1))
par(mgp=c(2,1,0))

#page 24
layout(matrix(1:4,nrow=2,ncol=2,byrow=TRUE))
with(anscombe,plot(x1,y1,main=substitute(rho(x1,y1) == x, 
     list(x = format(with(anscombe,cor(x1,y1)), digits = 3, nsmall = 3)))))
with(anscombe,plot(x2,y2,main=substitute(rho(x2,y2) == x, 
     list(x = format(with(anscombe,cor(x2,y2)), digits = 3, nsmall = 3)))))
with(anscombe,plot(x3,y3,main=substitute(rho(x3,y3) == x, 
     list(x = format(with(anscombe,cor(x3,y3)), digits = 3, nsmall = 3)))))
with(anscombe,plot(x4,y4,main=substitute(rho(x4,y4) == x, 
     list(x = format(with(anscombe,cor(x4,y4)), digits = 3, nsmall = 3)))))

par(old.par)
layout(1)

#page 25
library(mvtnorm)
help(package="mvtnorm")
dmvnorm(c(0,0), c(0,0), diag(2), log=FALSE)

#page 26
#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require("lattice")){install.packages("lattice")}
library(lattice)
# N2(c(0,0),I_2)
g <- expand.grid(x=seq(-2,2,0.05),y=seq(-2,2,0.05))
g$z <- dmvnorm(x=cbind(g$x,g$y),mean=c(0,0), sigma=diag(2),log=FALSE)
wireframe(z ~ x*y, data = g,colorkey = TRUE,drape=TRUE)

#page 27
# N2(c(0,0),matrix(c(1,0.75,0.75,1),byrow=T,nrow=2))
var <- matrix(c(1,0.75,0.75,1),byrow=T,nrow=2)
g <- expand.grid(x = seq(-2,2,0.05), y = seq(-2,2,0.05))
g$z <- dmvnorm(x=cbind(g$x,g$y),mean=c(0,0), sigma=var, log=FALSE)
wireframe(z ~ x*y, data = g,colorkey = TRUE,drape=TRUE)

#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require("rgl")){install.packages("rgl")}
library(rgl)
# N2(c(0,0),matrix(c(1,0,0,1),byrow=T,nrow=2))
g <- expand.grid(x = seq(-4,4,0.05), y = seq(-4,4,0.05))
g$z <- dmvnorm(x=cbind(g$x,g$y),mean=c(0,0),
               sigma=diag(2), log=FALSE)
g2z <- matrix(g$z*5000,byrow=T, nrow=length(seq(-4,4,0.05)))
g2x <- 10*(1:nrow(g2z))
g2y <- 10*(1:ncol(g2z))
zlim <- range(g2y)
zlen <- zlim[2]-zlim[1]+1
colorlut <- terrain.colors(zlen) # table des couleurs
col <- colorlut[ g2y-zlim[1]+1 ] # couleur par point
open3d()
surface3d(g2x, g2y, g2z, color=col, back="lines")
#Pour sauvegarder le graphique enlever le commentaire de la commande ci-dessous
# snapshot3d("rgl_norm01.png")

# N2(c(0,0),matrix(c(1,0.75,0.75,1),byrow=T,nrow=2))
g <- expand.grid(x = seq(-4,4,0.05), y = seq(-4,4,0.05))
g$z <- dmvnorm(x=cbind(g$x,g$y),mean=c(0,0), 
               sigma=matrix(c(1,0.75,0.75,1), byrow=T,nrow=2), log=FALSE)
g2z <- matrix(g$z*5000,byrow=T, nrow=length(seq(-4,4,0.05)))
g2x <- 10*(1:nrow(g2z))
g2y <- 10*(1:ncol(g2z))
zlim <- range(g2y)
zlen <- zlim[2]-zlim[1]+1
colorlut <- terrain.colors(zlen) # table des couleurs
col <- colorlut[ g2y-zlim[1]+1 ] # couleur par point
open3d()
surface3d(g2x, g2y, g2z, color=col, back="lines")
#Pour sauvegarder le graphique enlever le commentaire de la commande ci-dessous
# snapshot3d("rgl_norm02.png")

#page 30
cor(x,Y(x))

#page 32
#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require("ModStatR")){install.packages("ModStatR")}
library(ModStatR)
#La fonction Gauss2F1 a ete integree `a la bibliotheque ModStatR
ModStatR::Gauss2F1
(Gauss2F1(1/2,1/2,(length(x)-2)/2,1-cor(x,Y(x))^2))*cor(x,Y(x))

#La fonction Gauss2F1gsl a ete integree `a la bibliotheque ModStatR
ModStatR::Gauss2F1gsl
(Gauss2F1gsl(1/2,1/2,(length(x)-2)/2,1-cor(x,Y(x))^2))*cor(x,Y(x))

#page 33
library(mvtnorm)
sigma <- matrix(c(4,2.5,2.5,3), ncol=2)
cov2cor(sigma)
cor_res = NULL; cor_sb_res = NULL
cor_sb_gsl_res = NULL; cor_sbapprox_res = NULL
set.seed(2718)
for(iii in 1:1000){
  simul_XY <- rmvnorm(n=20, mean=c(1,2), sigma=sigma)
  X=simul_XY[,1]
  Y=simul_XY[,2]
  cor_res = c(cor_res,cor(X,Y))
  cor_sb_res = c(cor_sb_res,(Gauss2F1(1/2,1/2,
                (length(X)-2)/2,1-cor(X,Y)^2))*cor(X,Y))
  cor_sb_gsl_res = c(cor_sb_gsl_res,(Gauss2F1gsl(1/2,1/2,
                (length(X)-2)/2,1-cor(X,Y)^2))*cor(X,Y))
  cor_sbapprox_res = c(cor_sbapprox_res,cor(X,Y)+
                cor(X,Y)*(1-cor(X,Y)^2)/(length(X)-2))
}

#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require("yarrr")){install.packages("yarrr")}
library(yarrr)
long_res = cbind(data.frame(res=c(cor_res,cor_sb_res,
  cor_sb_gsl_res,cor_sbapprox_res)),type=rep(1:4,rep(5000,4)))
pirateplot(res~type,data=long_res)
abline(h=cov2cor(sigma)[2,1],lwd=2,col="red")
mean_res = c(cov2cor(sigma)[2,1],with(long_res,
  tapply(res,type,mean)))
names(mean_res) <- c("true value","cor_res","cor_sb_res",
  "cor_sb_gsl_res","cor_sbapprox_res")
mean_res

#page 34
all.equal(cor_sb_res, cor_sb_gsl_res)

#page 36
#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require("pwr")){install.packages("pwr")}
library(pwr)
pwr.r.test(r=0.30,n=50,sig.level=0.05,alternative="two.sided")

pwr.r.test(r=0.30,n=50,sig.level=0.05,alternative="greater")

#page 37
pwr.r.test(r=0.3,power=0.80,sig.level=0.05, alternative="two.sided")

#page 40
#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require("BioStatR")){install.packages("BioStatR")}
library(BioStatR)
data("Quetelet")
str(Quetelet)

table(Quetelet$sexe)

#page 41
#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require("GGally")){install.packages("GGally")}
library(GGally)
pairquet <- ggpairs(Quetelet)
print(pairquet)

Quet_H <- subset(Quetelet,subset=sexe=="h") 
nrow(Quet_H)

#page 42
#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require("MVN")){install.packages("MVN")}
library(MVN)
result = mvn(data = Quet_H[,-1], mvnTest = "mardia",
               univariateTest = "SW", univariatePlot = "histogram",
               multivariatePlot = "qq", multivariateOutlierMethod =
               "adj", showOutliers = TRUE, showNewData = TRUE)
result$multivariateNormality

#page 43
result$univariateNormality
result$multivariateOutliers

Quet_H[c("12","31"),]

#page 44
result = mvn(data = Quet_H[,-1], mvnTest = "mardia",
               univariateTest = "SW", univariatePlot = "histogram",
               multivariatePlot = "persp", multivariateOutlierMethod =
                 "adj", showOutliers = TRUE)

result = mvn(data = Quet_H[,-1], mvnTest = "mardia", 
             univariateTest = "SW", univariatePlot = "histogram", 
             multivariatePlot = "contour", multivariateOutlierMethod = 
               "adj", showOutliers = TRUE)

#page 45
result = mvn(data = Quet_H[,-1], mvnTest = "mardia",
             univariateTest = "SW", univariatePlot = "box",
             multivariatePlot = "qq", multivariateOutlierMethod =
               "adj", showOutliers = TRUE)

result = mvn(data = Quet_H[,-1], mvnTest = "mardia",
             univariateTest = "SW", univariatePlot = "scatter",
             multivariatePlot = "qq", multivariateOutlierMethod =
               "adj", showOutliers = TRUE)

cor.test(Quet_H[,"poids"],Quet_H[,"taille"])

#page 46
corobs = cor.test(Quet_H[,"poids"],Quet_H[,"taille"])$estimate
tanh(atanh(corobs)-qnorm(.975)/sqrt(41-3))

tanh(atanh(corobs)+qnorm(.975)/sqrt(41-3))

tanh(atanh(corobs)-qnorm(.975)/sqrt(41-3))-corobs/(2*(41-1))

tanh(atanh(corobs)+qnorm(.975)/sqrt(41-3))-corobs/(2*(41-1))

#page 47
#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require("MBESS")){install.packages("MBESS")}
library(MBESS)
ci.R(corobs,1,41-2)

sqrt(41-2)*corobs/sqrt(1-corobs^2)

2*(1-pt(sqrt(41-2)*abs(corobs)/sqrt(1-corobs^2),41-2))


#page 48
#La fonction rho est disponible dans le package ModStatR
ModStatR::rho

#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require("boot")){install.packages("boot")}
library(boot)
boot.rho_H <- boot(Quet_H[,"poids"], y=Quet_H[,"taille"], rho,
                    R=10000)

boot.ci(boot.rho_H)

#page 49
rho_0 <- 0.78
n <- 41

sqrt(n-3)*(atanh(corobs)-atanh(rho_0))

2*(1-pnorm(abs(sqrt(n-3)*(atanh(corobs)-atanh(rho_0)))))

sqrt(n-3)*(atanh(corobs)-atanh(rho_0)-rho_0/(2*(n-1)))

2*(1-pnorm(abs(sqrt(n-3)*(atanh(corobs)-
                            atanh(rho_0)-rho_0/(2*(n-1))))))

#page 50
#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require("ModStatR")){install.packages("ModStatR")}
library(ModStatR)
#La fonction corrdist est disponible dans le package ModStatR
ModStatR::corrdist

#La fonction corrdistapprox est disponible dans le package ModStatR
ModStatR::corrdistapprox

#La fonction corrdistapprox2 est disponible dans le package ModStatR
ModStatR::corrdistapprox2

print(corrdist(.5,0,20))
print(corrdistapprox(.5,0,20))
print(corrdistapprox2(.5,0,20))

#page 51
integrate(corrdist, lower=-1, upper=corobs, rho_0=rho_0, n=n)

2*integrate(corrdist, lower=-1, upper=corobs, rho_0=rho_0,
            n=n)$value

plot(seq(-1,1,.01), corrdist(seq(-1,1,.01), rho_0, n) ,type="l",
       xlab="Pearson correlation", ylab="Density")
polygon(x=c(seq(-1,corobs, length=100), corobs, 0),
          y=c(sapply(seq(-1,corobs, length=100),
          corrdist, rho_0=rho_0, n=n), 0,0), col="grey")

#page 52
#La fonction ref.cor.test est disponible dans le package ModStatR
ModStatR::ref.cor.test
ref.cor.test(corobs=corobs,rho_0=rho_0,n=n)

Quet_F <- subset(Quetelet,subset=sexe=="f")
nrow(Quet_F)

#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require("jmuOutlier")){install.packages("jmuOutlier")}
library(jmuOutlier)
set.seed(1133)
perm.cor.test(Quet_F[,"poids"],Quet_F[,"taille"])

#page 53
#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require("boot")){install.packages("boot")}
library(boot)
boot.rho_F <- boot(Quet_F[,"poids"], y=Quet_F[,"taille"], rho,
                     R=10000)
boot.ci(boot.rho_F)

#Complement en ligne, calcul exact du test de permutatio avec un tres petit echantillon
library(mvtnorm)
set.seed(1116)
sigma <- matrix(c(4,3,3,3), ncol=2)
petit_ech <- rmvnorm(n=8, mean=c(1,2), sigma=sigma)
petit_ech
cor(petit_ech[,1],petit_ech[,2])

#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require("combinat")){install.packages("combinat")}
library(combinat)
spcor <- sapply(permn(petit_ech[,1]), y=petit_ech[,2], 
                method="pearson", cor)
mean(abs(spcor)>=abs(cor(petit_ech[,1], petit_ech[,2])))

#page 56
Mes5_red_gv <- Mesures5[Mesures5$espece=="glycine violette",-5]

sumMasse=sum(Mes5_red_gv$masse)
sumTaille=sum(Mes5_red_gv$taille)
sumGraines=sum(Mes5_red_gv$graines)
sumMasseSec=sum(Mes5_red_gv$masse_sec)

#page 57
MatCov=matrix(NA,4,4,dimnames = list(c("masse","taille",
       "graines","masse_sec"),c("masse","taille","graines",
       "masse_sec")))
MatCov[1,2] <- MatCov[2,1] <- 1/(nrow(Mes5_red_gv)-1)*
  (sum(Mes5_red_gv$masse*Mes5_red_gv$taille)-
       1/nrow(Mes5_red_gv)*sumMasse*sumTaille)
MatCov[1,3] <- MatCov[3,1] <- 1/(nrow(Mes5_red_gv)-1)*
  (sum(Mes5_red_gv$masse*Mes5_red_gv$graines)-
       1/nrow(Mes5_red_gv)*sumMasse*sumGraines)
MatCov[1,4] <- MatCov[4,1] <- 1/(nrow(Mes5_red_gv)-1)*
  (sum(Mes5_red_gv$masse*Mes5_red_gv$masse_sec)-
       1/nrow(Mes5_red_gv)*sumMasse*sumMasseSec)
MatCov[2,3] <- MatCov[3,2] <- 1/(nrow(Mes5_red_gv)-1)*
  (sum(Mes5_red_gv$taille*Mes5_red_gv$graines)-
       1/nrow(Mes5_red_gv)*sumTaille*sumGraines)
MatCov[2,4] <- MatCov[4,2] <- 1/(nrow(Mes5_red_gv)-1)*
  (sum(Mes5_red_gv$taille*Mes5_red_gv$masse_sec)-
       1/nrow(Mes5_red_gv)*sumTaille*sumMasseSec)
MatCov[3,4] <- MatCov[4,3] <- 1/(nrow(Mes5_red_gv)-1)*
  (sum(Mes5_red_gv$graines*Mes5_red_gv$masse_sec)-
       1/nrow(Mes5_red_gv)*sumGraines*sumMasseSec)
MatCov[1,1] <- 1/(nrow(Mes5_red_gv)-1)*
  (sum(Mes5_red_gv$masse^2)-1/nrow(Mes5_red_gv)*
       sumMasse^2)
MatCov[2,2] <- 1/(nrow(Mes5_red_gv)-1)*
  (sum(Mes5_red_gv$taille^2)-1/nrow(Mes5_red_gv)*
       sumTaille^2)
MatCov[3,3] <- 1/(nrow(Mes5_red_gv)-1)*
  (sum(Mes5_red_gv$graines^2)-1/nrow(Mes5_red_gv)*
       sumGraines^2)
MatCov[4,4] <- 1/(nrow(Mes5_red_gv)-1)*
  (sum(Mes5_red_gv$masse_sec^2)-1/nrow(Mes5_red_gv)*
       sumMasseSec^2)
MatCov

#page 58
cov(Mes5_red_gv)

matsisj = outer(sqrt(diag(MatCov)),sqrt(diag(MatCov)),"*")
matsisj

MatCov/matsisj

cor(Mes5_red_gv)

Matcor = cor(Mes5_red_gv)
#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require("corrplot")){install.packages("corrplot")}
library(corrplot)
corrplot(Matcor)

#page 59
corrplot(Matcor, method="circle", title="M\u00e9thode = circle",
         mar = c(0, 0, 4, 0))
corrplot(Matcor, method="square", title="M\u00e9thode = square",
         mar = c(0, 0, 4, 0))

#page 60
corrplot(Matcor, method="ellipse", title="M\u00e9thode = ellipse",
         mar = c(0, 0, 4, 0))
corrplot(Matcor, method="number", title="M\u00e9thode = number",
         mar = c(0, 0, 4, 0))

corrplot(Matcor, method="shade", title="M\u00e9thode = shade", 
         mar = c(0, 0, 4, 0))
corrplot(Matcor, method="color", title="M\u00e9thode = color", 
         mar = c(0, 0, 4, 0))

#page 61
corrplot(Matcor, method="pie", title="M\u00e9thode = pie", 
         mar = c(0, 0, 4, 0))
corrplot(Matcor, method="pie", type="full", title="Type = full", 
         mar = c(0, 0, 4, 0))

corrplot(Matcor, method="pie", type="lower", title="Type = lower", 
         mar = c(0, 0, 4, 0))
corrplot(Matcor, method="pie", type="upper", title="Type = upper", 
         mar = c(0, 0, 4, 0))

corrplot(Matcor, method="pie", diag=FALSE, title="Diag = FALSE", 
         mar = c(0, 0, 4, 0))

#page 62
corrplot(Matcor, method="pie", diag=FALSE, addCoef.col="orange")
corrplot(Matcor, method="pie", diag=FALSE, addCoef.col="orange", 
         number.cex=.75)

#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require("RColorBrewer")){install.packages("RColorBrewer")}
library(RColorBrewer)
corrplot(Matcor, method="pie", diag=FALSE, col=brewer.pal(n=8, 
    name="PuOr"))

#page 63
corrplot(Matcor, method="pie", diag=FALSE, tl.srt=45)

#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require("ggcorrplot")){install.packages("ggcorrplot")}
library(ggcorrplot)
ggcorrplot(Matcor)
ggcorrplot(Matcor, method="circle", type ="lower")
  
#page 64
library(GGally)
ggcorr(Mes5_red_gv)

#page 65
Mes5_red_gv = subset(Mesures5[,-5],subset=Mesures5$espece==
                       "glycine violette")
mvn(data = Mes5_red_gv[,c("masse","taille","masse_sec")],
      mvnTest = "mardia")$multivariateNormality

#page 66
Mes5_red_lr = subset(Mesures5[,-5],subset=Mesures5$espece==
                       "laurier rose")
nrow(Mes5_red_lr)

mvn(data = Mes5_red_lr[,c("masse","taille","masse_sec")],
    mvnTest = "mardia", univariateTest = "SW",
    univariatePlot = "histogram", multivariateOutlierMethod =
      "adj", showOutliers = TRUE)$multivariateNormality

#page 67
tousalafois=cor.mtest(Mes5_red_lr[,c("masse","taille",
                                     "masse_sec")])
tousalafois$p

#page 68
tousalafois$p<.05/3

mvn(data = Mes5_red_gv[,c("masse","taille")], mvnTest =
      "mardia")$multivariateNormality

mvn(data = Mes5_red_gv[,c("masse","masse_sec")], mvnTest =
      "mardia")$multivariateNormality

#page 69
mvn(data = Mes5_red_gv[,c("taille","masse_sec")], mvnTest =
      "mardia")$multivariateNormality

library(ModStatR)
# La fonction perm.cor.mtest a ete integree `a la bibliotheque ModStatR
perm.cor.mtest

permtoutalafois <- perm.cor.mtest(Mes5_red_gv)
permtoutalafois

#page 70
permtoutalafois$p<.05/6

cor(Mes5_red_gv)

#page 71
nrow(na.omit(Mes5_red_lr[,c("taille","masse_sec")]))
ref.cor.mtest(Mes5_red_lr[,c("masse","taille","masse_sec")],0.7)

#page 72
rescormest <- cor.mtest(Mes5_red_lr[,c("masse","taille","masse_sec")])
rescormest$lowCI

rescormest$uppCI

#page 73
rescormestbonf <- cor.mtest(Mes5_red_lr[,c("masse","taille", 
                  "masse_sec")],conf.level = 1-0.05/3)
rescormestbonf$lowCI

rescormestbonf$uppCI

Matcor_lr=cor(Mes5_red_lr[,c("masse","taille","masse_sec")],
                use="pairwise.complete.obs")
par(ask = FALSE)
for (i in seq(0.1, 0, -0.005)) {
  tmp <- cor.mtest(Mes5_red_lr[,c("masse","taille","masse_sec")],
                     conf.level = 1-i)
  corrplot(Matcor_lr, p.mat = tmp$p, low = tmp$lowCI,
             upp = tmp$uppCI, pch.col = "red", sig.level = i, plotCI =
               "rect", cl.pos = "n", title = substitute(alpha == x,
                                                          list(x = format(i, digits = 3, nsmall = 3))),
             mar = c(0, 0, 4, 0))
  Sys.sleep(0.15)
}

#page 75
#La fonction rho.mult est disponible dans le package ModStatR
ModStatR::rho.mult

library(boot)
boot.mcor <- boot(Mes5_red_lr[,c("masse","taille","masse_sec")],
                    rho.mult, R=10000)
boot.mcor

#page 76
#La fonction boot.mcor.ic est disponible dans le package ModStatR
ModStatR::boot.mcor.ic
boot.mcor.ic.res <- boot.mcor.ic(Mes5_red_lr[,c("masse","taille","masse_sec")],boot.mcor)
boot.mcor.ic.res

corrplot(Matcor_lr, low = boot.mcor.ic.res$cor.ic.percentile.low,
         upp = boot.mcor.ic.res$cor.ic.percentile.up, pch.col = "red",
         plotCI = "rect", cl.pos = "n", mar = c(0, 0, 4, 0),
         title = "IC Bootstrap percentile 95%")

#page 77
corrplot(Matcor_lr, low = boot.mcor.ic.res$cor.ic.BCa.low, 
         upp = boot.mcor.ic.res$cor.ic.BCa.up, pch.col = "red", 
         plotCI = "rect", cl.pos = "n", mar = c(0, 0, 4, 0), 
         title = "IC Bootstrap BCa 95%")

boot.mcor.ic.res.bonf <- boot.mcor.ic(Mes5_red_lr[,c("masse",
   "taille","masse_sec")], boot.mcor, conflevel = 1-0.05/3)
boot.mcor.ic.res.bonf

corrplot(Matcor_lr, mar = c(0, 0, 4, 0),
         low = boot.mcor.ic.res.bonf$cor.ic.percentile.low,
         upp = boot.mcor.ic.res.bonf$cor.ic.percentile.up,
         pch.col = "red", plotCI = "rect", cl.pos = "n", title =
         "IC Bootstrap percentile 95%\navec correction de Bonferroni")

#page 78
corrplot(Matcor_lr, mar = c(0, 0, 4, 0),
         low = boot.mcor.ic.res.bonf$cor.ic.BCa.low,
         upp = boot.mcor.ic.res.bonf$cor.ic.BCa.up,
         pch.col = "red", plotCI = "rect", cl.pos = "n", title =
           "IC Bootstrap BCa 95%\navec correction de Bonferroni")

#page 81
sigmaZ=cov(Mes5_red_gv)
sigmaZ

sigma11=sigmaZ[1,1]
sigma11

sigma21=sigmaZ[1,2:4]
sigma21

sigma22=sigmaZ[2:4,2:4]
sigma22

#page 82
sigma22inverse=solve(sigma22)
sigma22inverse

corM=sqrt(t(sigma21)%*%sigma22inverse%*%sigma21/sigma11)
corM

sqrt(summary(lm(masse~taille+graines+masse_sec,
                data=Mes5_red_gv))$r.squared)

#page 84
library(MBESS)
Expected.R2(.5, 10, 5)
Variance.R2(.5, 10, 5)

#page 86
Mes5_red_lr = subset(Mesures5[,-5],subset=Mesures5$espece==
                       "laurier rose")
Rmultobs_lr=sqrt(summary(lm(masse~taille+masse_sec,
                              data=Mes5_red_lr))$r.squared)

n=nrow(na.omit(Mes5_red_lr[,c("masse","taille","masse_sec")]))
n

#page 87
p=3
Fobs=(n-p)/(p-1)*Rmultobs_lr^2/(1-Rmultobs_lr^2)
Fobs

mvn(data = Mes5_red_lr[,c("masse","taille","masse_sec")], 
    mvnTest = "mardia")$multivariateNormality

n-p
p-1
pf(Fobs,p-1,n-p, lower.tail = FALSE)

fstat <- summary(lm(masse~taille+masse_sec, data= 
                      Mes5_red_lr))$fstatistic
fstat

#page 88
pf(fstat[1], fstat[2], fstat[3], lower.tail=FALSE)

summary(lm(masse~taille+masse_sec,data=Mes5_red_lr))

.Machine$double.eps
format.pval(pf(fstat[1L], fstat[2L], fstat[3L], lower.tail=FALSE))

#page 89
library(MBESS)
ss.power.R2(Population.R2=.3^2, Specified.N=15, alpha.level=.05, 
            p=2)

ss.power.R2(Population.R2=.3^2, alpha.level=.05, 
            desired.power=.80, p=2)

#page 90
Rmultobs_lr
tanh(atanh(Rmultobs_lr)-qnorm(.975)/sqrt(n-3))
tanh(atanh(Rmultobs_lr)+qnorm(.975)/sqrt(n-3))

ci.R(Rmultobs_lr,p-1,n-p)

#page 91
ci.R2(Rmultobs_lr^2,p-1,n-p)

#page 92
R_0=0.78
n=69
sqrt(n-3)*(atanh(Rmultobs_lr)-atanh(R_0))

2*(1-pnorm(abs(sqrt(n-3)*(atanh(Rmultobs_lr)-atanh(R_0)))))

#page 94
m.cov = rbind(c(3,1,1,0), c(1,3,0,1), c(1,0,2,0), c(0,1,0,2))

m.cor.1 = cov2cor(m.cov)
m.cor.1

#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require("corpcor")){install.packages("corpcor")}
library("corpcor")
m.pcor.1 = cor2pcor(m.cor.1)
m.pcor.1

#page 95
m.pcor.2 = cor2pcor(m.cov)
m.pcor.2

m.cor.2 = pcor2cor(m.pcor.1)
m.cor.2

z.m.cor.1 <- zapsmall(m.cor.1)
z.m.cor.2 <- zapsmall(m.cor.2)
z.m.cor.1 == z.m.cor.2

#Complement en ligne pour illustrer la definition 3
m.precision = solve(m.cov)
m.inv.cor = solve(cov2cor(m.cov))
#Meme resultat `a partir de l'inversion de la matrice de variance-covariance 
#ou `a partir de la matrice de correlation lineaire
-cov2cor(m.precision)
-cov2cor(m.inv.cor)
#Ce resultat est le meme que celui de la fonction cor2pcor
zapsmall(m.pcor.1) == zapsmall(-cov2cor(m.precision))
  
#page 96
Mes5_red_lr = subset(Mesures5[,-5],subset=Mesures5$espece== 
                       "laurier rose")
with(Mes5_red_lr, cor.test(masse,masse_sec))

#page 97
Mes5_red_lr_noNA <- na.omit(Mes5_red_lr[,-3])
sigmaTriplet = cov(Mes5_red_lr_noNA)

sigma11=sigmaTriplet[c(1,3),c(1,3)]
sigma11

sigma21=sigmaTriplet[2,c(1,3),drop=FALSE]
sigma21

sigma22=sigmaTriplet[2,2,drop=FALSE]
sigma22

#page 98
par_covar=sigma11-t(sigma21)%*%solve(sigma22)%*%sigma21
par_covar

cov2cor(par_covar)

res1 = residuals(lm(masse~taille, data=Mes5_red_lr_noNA)) 
res2 = residuals(lm(masse_sec~taille, data=Mes5_red_lr_noNA)) 
cor(res1,res2)

corTriplet <- cov2cor(sigmaTriplet)
corTriplet

#page 99
(corTriplet[3,1]-corTriplet[2,1]*corTriplet[3,2])/
  sqrt(1-corTriplet[2,1]^2)/sqrt(1-corTriplet[3,2]^2)

cor2pcor(sigmaTriplet)

#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require("ppcor")){install.packages("ppcor")}
library(ppcor)
pcor(Mes5_red_lr_noNA)$estimate

#page 102
pcor(Mes5_red_lr_noNA)

pcor(Mes5_red_lr_noNA)$p.value<5/3

#page 103
r_pcor<-pcor(Mes5_red_lr_noNA)
r_pcr_e<-r_pcor$estimate; n<-r_pcor$n; gp<-r_pcor$gp; N<-n-gp-3
tanh(atanh(r_pcr_e)-qnorm(.975)/sqrt(n-gp-3))

tanh(atanh(r_pcr_e)+qnorm(.975)/sqrt(n-gp-3))

#page 104
icl<-tanh(atanh(r_pcr_e)-qnorm(.975)/sqrt(N))-r_pcr_e/(2*(N+2))
icu<-tanh(atanh(r_pcr_e)+qnorm(.975)/sqrt(N))-r_pcr_e/(2*(N+2))

sqrt(n-gp-2)*r_pcr_e/sqrt(1-r_pcr_e^2)
r_pcor$statistic

2*(1-pt(sqrt(n-gp-2)*abs(r_pcr_e)/sqrt(1-r_pcr_e^2),n-gp-2))
r_pcor$p.value

library(MBESS)
cis=(sapply(abs(r_pcr_e),ci.R,df.1=1,df.2=N+1, simplify = TRUE))
colnames(cis) <- outer(rownames(r_pcr_e),colnames(r_pcr_e),paste)
cis

library(corrplot)
layout(t(1:2))
corrplot(r_pcor$estimate, title = "Corr\u00e9lation partielle", mar = 
           c(0, 0, 4, 0), cl.pos = "r")
corrplot(r_pcor$estimate, low = icl, upp = icu, pch.col = "red", 
         plotCI = "rect", cl.pos = "n", title = 
           "Corr\u00e9lation partielle et IC", mar = c(0, 0, 4, 0))
layout(1)

#page 105
Matcor_lr_noNA=cor(Mes5_red_lr_noNA)
layout(t(1:2))
corrplot(Matcor_lr_noNA, title = "Corr\u00e9lation simple", mar = 
           c(0, 0, 4, 0), cl.pos = "r")
rescormest <- cor.mtest(Mes5_red_lr_noNA)
corrplot(Matcor_lr_noNA, low = rescormest$lowCI, 
         upp= rescormest$uppCI, pch.col = "red", plotCI = "rect", cl.pos= 
           "n", title = "Corr\u00e9lation simple et IC", mar = c(0, 0, 4, 0))
layout(1)

#page 111
library(mvtnorm)
set.seed(1116)
sigma <- matrix(c(4,3,3,3), ncol=2)
petit_ech <- rmvnorm(n=8, mean=c(1,2), sigma=sigma)
cor_spear = cor(petit_ech,method="spearman")
cor_spear

#page 112
cor.test(petit_ech[,1],petit_ech[,2],method="spearman")

#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require(pspearman)){install.packages("pspearman")}
library(pspearman)
spearman.test(petit_ech[,1],petit_ech[,2])

2*pspearman(10, 8)

#page 113
#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require(SuppDists)){install.packages("SuppDists")}
library(SuppDists)
2*pSpearman(cor_spear[2,1], 8, lower.tail = FALSE)

#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require(coin)){install.packages("coin")}
library(coin)
spearman_test(petit_ech[,1]~petit_ech[,2],distribution= 
                approximate(nresample=99999))

library(combinat)
spcor <- sapply(permn(petit_ech[,1]), y=petit_ech[,2], method= 
                  "spearman", cor)
mean(abs(spcor)>=abs(cor(petit_ech[,1],petit_ech[,2], method= 
                           "spearman")))

#page 114
data(Quetelet, package="BioStatR")
with(Quetelet,plot(taille,poids,col=c("red","blue")[sexe],pch= 
                     c(17,15)[sexe], main="Masse en fonction de la taille"))
legend(x="bottomright",legend = c("Femme","Homme"),pch= 
         c(17,15), col=c("red","blue"))

with(Quetelet,spearman_test(taille~ poids, distribution=
                              approximate(nresample=9999)))

#page 116
pcor(Mes5_red_lr_noNA, method = "spearman")

#page 117
cor(Mes5_red_lr_noNA, method = "spearman")

pcor(Mes5_red_lr_noNA, method = "spearman")$p.value<5/3

library(corrplot)
layout(t(1:2))
corrplot(r_pcor$estimate, mar = c(0, 0, 4, 0), cl.pos = "r", 
         title = "Corr\u00e9lation partielle\nde Spearman")
corrplot(cor(Mes5_red_lr_noNA, method="spearman"), mar=c(0,0, 
      4, 0), cl.pos = "r", title = "Corr\u00e9lation simple\nde Spearman")
layout(1)

#page 121
library(mvtnorm)
set.seed(1116)
sigma <- matrix(c(4,3,3,3), ncol=2)
petit_ech <- rmvnorm(n=8, mean=c(1,2), sigma=sigma)
cor_kend = cor(petit_ech,method="kendall")
cor_kend

cor.test(petit_ech[,1],petit_ech[,2],method="kendall")

if(!require(Kendall)){install.packages(Kendall)}
library(Kendall)
Kendall(petit_ech[,1],petit_ech[,2])

#Si le package n'est pas installe, enlever le commentaire
#puis executer la commande ci-dessous.
#if(!require(SuppDists)){install.packages("SuppDists")}
library(SuppDists)
2*pKendall(cor_kend[2,1], 8, lower.tail = FALSE)

#page 122
library(combinat)
spcor <- sapply(permn(petit_ech[,1]), y=petit_ech[,2], method= 
                  "kendall", cor)
mean(abs(spcor)>=abs(cor(petit_ech[,1],petit_ech[,2], method= 
                             "kendall")))

with(Quetelet,Kendall(taille, poids))


#page 125
pcor(Mes5_red_lr_noNA, method = "kendall")

#page 126
cor(Mes5_red_lr_noNA, method = "kendall")

pcor(Mes5_red_lr_noNA, method = "kendall")$p.value<5/3

#page 127
library(corrplot)
layout(t(1:2))
corrplot(r_pcor$estimate, mar = c(0, 0, 4, 0), cl.pos = "r", 
         title = "Corr\u00e9lation partielle\nde Kendall")
corrplot(cor(Mes5_red_lr_noNA, method="kendall"), mar=c(0,0, 
        4, 0), cl.pos = "r", title = "Corr\u00e9lation simple\nde Kendall")


#page 128, exercice 2
read.csv("https://tinyurl.com/y2c68uvw")

#page 137
read.csv("https://tinyurl.com/y2asrzgk")




