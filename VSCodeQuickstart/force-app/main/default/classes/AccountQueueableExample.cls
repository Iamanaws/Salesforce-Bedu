public class AccountQueueableExample implements Queueable {

    public List<Account> accList;

    public AccountQueueableExample(List<Account> accs) {
        this.accList = accs;
    }

    public void execute(QueueableContext context) {
        for (Account a : accList) {
            a.Description = 'Updated from AccountQueueableExample';
        }

        update accList;
    }
}