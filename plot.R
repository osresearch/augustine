# R script to generate the plot
library(ggplot2)
planes <- read.table("combat.csv",header=T,sep=",")
gdp <- read.table("gdp.csv",header=T,sep=",")
gdp$Real <- gdp$Real * 1e12  # scale from trillions

def <- read.table("FDEFX.csv",header=T,sep=",")
def$Year <- as.double(substr(def$DATE, 1, 4))
def$Real <- def$FDEFX * 1e9

# Ignore the Wright Model A
planes <- subset(planes, Year > 1920)

planes_ab <- lm(log10(Price) ~ Year, data=planes)
gdp_ab <- lm(log10(Real) ~ Year, data=gdp)
def_ab <- lm(log10(Real) ~ Year, data=def)

g <- ggplot()
g <- g + xlim(1930,2150)
g <- g + ggtitle("Augustine's Law XVI (revised)")
g <- g + theme_minimal() + theme(axis.title.x=element_blank())
# g <- g + ylim(4,12)
g <- g + scale_y_continuous(
	limits=c(4,15),
	name="Real Dollars (log scale, not inflation adjusted)",
	breaks=c(4:15),
	labels=c('$10k','$100k', '$1m', '$10m', '$100m','$1b','$10b','$100b','$1t','$10t','$100t', '$1q'))

g <- g + geom_point(aes(Year, log10(Price)), color="red", data=planes)
g <- g + geom_point(aes(Year, log10(Real)), alpha=0.2, color="blue", data=gdp)
g <- g + geom_point(aes(Year, log10(Real)), alpha=0.2, color="green", data=def)
g <- g + annotate("text", x=1955, y=log10(1.5e12), label="US GDP since 1920", hjust=0)
g <- g + annotate("text", x=1955, y=log10(40e9), label="Defense budget since 1947", hjust=0)
g <- g + annotate("text", x=2015, y=log10(3e6), label="Aircraft price at year of introduction", hjust=0)

g <- g + geom_abline(slope=planes_ab$coefficients[2], intercept=planes_ab$coefficients[1], color="red")
g <- g + geom_abline(slope=gdp_ab$coefficients[2], intercept=gdp_ab$coefficients[1], color="blue")
g <- g + geom_abline(slope=def_ab$coefficients[2], intercept=def_ab$coefficients[1], color="green")

# Non-overlapping Subset for the labels
labels = c(
        'P-6 Hawk',
        'P-51 Mustang',
        'F-100 Super Sabre',
        'F-16A/B Falcon',
        'F-18E Hornet',
        'B-52H',
        'B-52B',
        'F-35 Lightning'
)

g <- g + geom_text(aes(Year, log10(Price), label=Model), check_overlap=TRUE, hjust=0, nudge_x=5, data=planes) #subset(planes, Model %in% labels))

ggsave("augustine.png");
