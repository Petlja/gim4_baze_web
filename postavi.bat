@echo off

if "%1" == "" (goto :upotreba)
if "%1" NEQ "prirodni" (if "%1" NEQ "drustveni" (goto :upotreba))

if %1 == prirodni (
    copy pavement_prirodni.py pavement.py
    copy conf_prirodni.py conf.py
    cd _sources
    copy index_prirodni.yaml index.yaml
    cd ..
)

if %1 == drustveni (
    copy pavement_drustveni_opsti.py pavement.py
    copy conf_drustveni_opsti.py conf.py
    cd _sources
    copy index_drustveni_opsti.yaml index.yaml
    cd ..
)

goto :kraj

:upotreba
echo upotreba:
echo postavi prirodni
echo postavi drustveni

:kraj
