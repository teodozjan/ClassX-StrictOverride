class X::UnknownMethod is Exception {
    has @.extras;
    has $.typename;

    method message {
        "The following methods are not overriding for any parent in type $!typename: {@!extras.join(", ")}"
    }
}

role ClassX::StrictOverride {
    sub has_meth($type, $meth) {
       
	
        for  $type.^methods(:local) -> $m{
	    return True if $m.name eq $meth.name;
	}
        return False;
    }

    method new(*%dontuse) {
        my @extras;
        for self.^methods -> $meth {
	    
            unless has_meth(self.WHAT, $meth) {
                my $inherited = False;
                for self.^parents(:excl) -> $parent {
                    $inherited = True if has_meth($parent, $meth)
                }
                @extras.push: $meth unless $inherited;
            }
        }
        if @extras {
            die X::UnknownMethod.new(typename => self.^name, :@extras) 
        }
        nextsame;
    }
}
