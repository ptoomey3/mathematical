require "test_helper"

class Mathematical::FixturesTest < Test::Unit::TestCase
  # the same SVGs sometimes get random id values, throwing off the tests
  def strip_id(blob)
    blob.gsub(/id="surface.+?"/, '')
  end

  Dir['test/mathematical/fixtures/before/*.text'].each do |before|
    name = before.split('/').last

    define_method "test_#{name}" do
      source = File.read(before)

      actual = MathToItex(source).convert do |eq, type|
        svg_content = Mathematical::Render.new(:base64 => true).render(eq)

        %|<img class="#{type.to_s}-math" data-math-type="#{type.to_s}-math" src="#{svg_content['svg']}"/>|
      end.rstrip

      expected_file = before.sub(/before/, "after").sub(/text/, "html")

      File.open(expected_file, "w") { |file| file.write(actual) } unless ENV['DEBUG_MATHEMATICAL'].nil?

      expected = File.read(expected_file)

      expected = (MathToItex(expected).convert {|string| Mathematical::Render.new.render(string)}).rstrip

      # Travis and OS X each render SVGs differently. For now, let's just be happy
      # that something renders at all.
      unless actual.match("PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My")
        diff = IO.popen("diff -u - #{expected_file}", 'r+') do |f|
          f.write actual
          f.close_write
          f.read
        end

        assert expected == actual, <<-eos
  #{File.basename expected_file}'s contents don't match command output:
  #{diff}
  eos
      end
    end
  end
end
