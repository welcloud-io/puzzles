int main()
{
    map<string,string> mm;
    string ext,mim,s,ext2;
    int n,m,i,j,ok;
    cin>>n>>m;
    for(i=0;i<n;i++)
    {
        cin>>ext>>mim;
        for(j=0;j<ext.size();j++) ext[j]=tolower(ext[j]);
        mm[ext]=mim;
    }
    for(i=0;i<m;i++)
    {
        cin>>s;
        ok=0;
        for(j=s.size()-1;j>=0;j--)
            if(s[j]=='.') { ok=1; break;}
        if(ok==0) printf("UNKNOWN\n");
        else{
            ext2.clear();
            j++;
            for(;j<s.size();j++) ext2.push_back(tolower(s[j]));
            if(mm[ext2]=="") printf("UNKNOWN\n");
            else cout<<mm[ext2]<<"\n";
        }
    }
    return 0;
}

#~ #include<iostream>
#~ #include<stdio.h>
#~ #include<stdlib.h>
#~ #include<string>
#~ #include<map>
#~ using namespace std;
#~ int main()
#~ {
    #~ map<string,string> mm;
    #~ string ext,mim,s,ext2;
    #~ int n,m,i,j,ok;
    #~ cin>>n>>m;
    #~ for(i=0;i<n;i++)
    #~ {
        #~ cin>>ext>>mim;
        #~ for(j=0;j<ext.size();j++) ext[j]=tolower(ext[j]);
        #~ mm[ext]=mim;
    #~ }
    #~ for(i=0;i<m;i++)
    #~ {
        #~ cin>>s;
        #~ ok=0;
        #~ for(j=s.size()-1;j>=0;j--)
            #~ if(s[j]=='.') { ok=1; break;}
        #~ if(ok==0) printf("UNKNOWN\n");
        #~ else{
            #~ ext2.clear();
            #~ j++;
            #~ for(;j<s.size();j++) ext2.push_back(tolower(s[j]));
            #~ if(mm[ext2]=="") printf("UNKNOWN\n");
            #~ else cout<<mm[ext2]<<"\n";
        #~ }
    #~ }
    #~ return 0;
#~ }