import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";


actor Token {
    var owner: Principal = Principal.fromText("e7pzm-gz4t2-b6wca-fm2ys-j6dbq-fjtqo-gzcbd-oujfm-t3sjo-uchi2-fqe");
    var totalSupply: Nat = 1000000000;
    var symbol: Text = "NOV";

    private stable var balanceEntries: [(Principal, Nat)] = [];
    //Creating a Ledger
    private var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
    if(balances.size() < 1){
        //Adding the owner to ledger and providing total Supply of token to owner
        balances.put(owner, totalSupply); 
    };

    //to retrive account balance using principle id
    public query func balanceOf(who: Principal) : async Nat {

        let balance: Nat = switch (balances.get(who)){
            case null 0;
            case (?result) result;
        };

        return balance;
    };
    
    //to get the symbol of the token
    public query func getSymbol() : async Text{
        return symbol;
    };

    //to transfer free token to the user
    public shared(msg) func payOut() : async Text {
        // Debug.print(debug_show(msg.caller));
        if (balances.get(msg.caller) == null){
            let amount = 10000;
            let result = await transfer(msg.caller, amount);    //Transfer amount from canister account
            return result;
        }else{
            return "Already Claimed";
        }
    };

    //to transfer coins from one account to other
    public shared(msg) func transfer(to: Principal, amount: Nat) : async Text {
        let fromBalance = await balanceOf(msg.caller);
        if(fromBalance >= amount) {
            let newFromBalance: Nat = fromBalance - amount;
            balances.put(msg.caller, newFromBalance);   //Update balance from senders account
            
            // adding amount to reciever's account
            let toBalance = await balanceOf(to);
            let newToBalance = toBalance + amount;
            balances.put(to, newToBalance);

            return "Success";
        }else{
            return "Insufficient Balance!";
        }
    };

    system func preupgrade() {
        balanceEntries := Iter.toArray(balances.entries());
    };

    system func postupgrade() {
        balances := HashMap.fromIter<Principal, Nat>(balanceEntries.vals(), 1, Principal.equal, Principal.hash);
        if(balances.size() < 1){
            //Adding the owner to ledger and providing total Supply of token to owner
            balances.put(owner, totalSupply); 
        };
    };
}