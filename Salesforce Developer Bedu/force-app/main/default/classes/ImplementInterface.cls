public class ImplementInterface implements InterfacePractice{
    
    public void metodo1(){
        system.debug('Metodo 1');
    }

    public String metodo2(){
        system.debug('Metodo 2');
        return 'Hello World';
    }
    
    public  void metodo3(String param1){
        system.debug(param1);
    }
}