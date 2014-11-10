require 'facter'
pkg = Puppet::Type.type(:package).new(:name => "Symantec Critical System Protection Agent")
v = pkg.retrieve[pkg.property(:ensure)].to_s
Facter.add(:symantec_scsp) do
	confine :osfamily => :windows
  setcode do
		v 
  end
end
