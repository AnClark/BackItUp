pushd %~dp0
java -jar signapk.jar bdd.pem bdd.pk8 %~n1.zip %~n1_signed.zip
Pause
