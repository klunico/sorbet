# typed: true

class FinalClass
  extend T::Helpers
  final!
end

module FinalModule
  extend T::Helpers
  final!
end

module NonFinalModule; end

class BadInherit < FinalClass # error: `FinalClass` was declared as final and cannot be inherited by `BadInherit`
end

module BadInclude
  include NonFinalModule
  extend NonFinalModule
  include FinalModule # error-with-dupes: `FinalModule` was declared as final and cannot be included in `BadInclude`
end

module BadExtend
  include NonFinalModule
  extend NonFinalModule
  extend FinalModule # error-with-dupes: `FinalModule` was declared as final and cannot be extended in `BadExtend`
end

AliasFinalModule = FinalModule

module BadAliasInclude
  include AliasFinalModule # error-with-dupes: `FinalModule` was declared as final and cannot be included in `BadAliasInclude`
end

module FinalModuleWithFinalMethods
  extend T::Helpers
  final!
  extend T::Sig
  sig(:final) {void}
  def foo; end
  sig(:final) {void}
  def self.bar; end
end

module FinalModuleWithNoFinalMethods
  extend T::Helpers
  final!
  def foo; end # error: `FinalModuleWithNoFinalMethods` was declared as final but its method `foo` was not declared as final
  def self.bar; end # error: `FinalModuleWithNoFinalMethods` was declared as final but its method `bar` was not declared as final
end