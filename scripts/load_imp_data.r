map <- read.delim(url('https://raw.githubusercontent.com/knights-lab/IMP_analyses/master/data/map.txt?raw=true'),row=1)
otus <- t(read.delim(url('https://github.com/knights-lab/IMP_analyses/blob/master/data/denovo/final_otu.txt?raw=true'),row=1))
alpha <- read.delim(url('https://raw.githubusercontent.com/knights-lab/IMP_analyses/master/data/denovo/alpha.txt?raw=true'),row=1)
beta_uuf <- read.delim(url('https://raw.githubusercontent.com/knights-lab/IMP_analyses/master/data/denovo/unweighted_unifrac_dm.txt?raw=true'),row=1)
beta_wuf <- read.delim(url('https://raw.githubusercontent.com/knights-lab/IMP_analyses/master/data/denovo/weighted_unifrac_dm.txt?raw=true'),row=1)
phylum <- t(read.delim(url('https://github.com/knights-lab/IMP_analyses/blob/master/data/denovo/taxatable_L2.txt?raw=true'),row=1))
genus <- t(read.delim(url('https://github.com/knights-lab/IMP_analyses/blob/master/data/denovo/taxatable_L6.txt?raw=true'),row=1))
species <- t(read.delim(url('https://github.com/knights-lab/IMP_analyses/blob/master/data/denovo/taxatable_L7.txt?raw=true'),row=1))


keep.ix <- is.na(map$Sample.Order) | map$Sample.Order==1
map <- map[keep.ix,]

ix <- map$BMI.Class != "Overweight"
map <- droplevels(map[ix,])

common.rownames <- intersect(rownames(map),rownames(otus))
map <- map[common.rownames,]
otus <- otus[common.rownames,]
alpha <- alpha[common.rownames,]
beta_uuf <- beta_uuf[common.rownames,common.rownames]
beta_wuf <- beta_wuf[common.rownames,common.rownames]
phylum <- phylum[common.rownames,]
genus <- genus[common.rownames,]
species <- species[common.rownames,]

colnames(phylum) <- sapply(strsplit(colnames(phylum),";"),function(xx) xx[length(xx)])
colnames(genus) <- sapply(strsplit(colnames(genus),";"),function(xx) xx[length(xx)])
colnames(species) <- sapply(strsplit(colnames(species),";"),function(xx) xx[length(xx)])

map$Generation <- "Thai" # fill with Thai to start
map$Generation[map$Sample.Group == "Karen1st" | map$Sample.Group == "Hmong1st"] <- "1stGen"
map$Generation[map$Sample.Group == "Hmong2nd"] <- "2ndGen"
map$Generation[map$Sample.Group == "Control"] <- "Control"
map$Generation <- factor(map$Generation, levels=c('Thai','1stGen','2ndGen','Control'))


write.table(map,'map.txt',quote=F,col.names=TRUE,row.names=TRUE,sep="\t")
write.table(otus,'otu_table.txt',quote=F,col.names=TRUE,row.names=TRUE,sep="\t")
write.table(alpha,'alpha.txt',quote=F,col.names=TRUE,row.names=TRUE,sep="\t")
write.table(beta_uuf,'beta_uuf.txt',quote=F,col.names=TRUE,row.names=TRUE,sep="\t")
write.table(beta_wuf,'beta_wuf.txt',quote=F,col.names=TRUE,row.names=TRUE,sep="\t")
write.table(phylum,'phylum.txt',quote=F,col.names=TRUE,row.names=TRUE,sep="\t")
write.table(genus,'genus.txt',quote=F,col.names=TRUE,row.names=TRUE,sep="\t")
write.table(species,'species.txt',quote=F,col.names=TRUE,row.names=TRUE,sep="\t")

