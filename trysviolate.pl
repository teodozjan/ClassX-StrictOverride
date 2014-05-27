use v6;
use ClassX::StrictOverride;


role Foo does ClassX::StrictOverride{

    method foo{...}
    method bar{ 1}

} 

class XXX does Foo{

    method foo{ 2 }
    method bar { 3  }
    method xyz{4 }



}


XXX.new;
