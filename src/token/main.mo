import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";


actor Token {
    var owner: Principal = Principal.fromText("e7pzm-gz4t2-b6wca-fm2ys-j6dbq-fjtqo-gzcbd-oujfm-t3sjo-uchi2-fqe");
    var totalSupply: Nat = 1000000000;
    var symbol: Text = "NOV";

    //Creating a Ledger
    var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
    //Adding the owner to ledger and providing total Supply of token to owner
    balances.put(owner, totalSupply);   

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
            balances.put(msg.caller, amount);
            return "Success";
        }else{
            return "Already Claimed";
        }
    };
}