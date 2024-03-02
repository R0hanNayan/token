import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";


actor Token {
    var owner: Principal = Principal.fromText("e7pzm-gz4t2-b6wca-fm2ys-j6dbq-fjtqo-gzcbd-oujfm-t3sjo-uchi2-fqe");
    var totalSupply: Nat = 1000000000;
    var symbol: Text = "AANG";

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
    }
}