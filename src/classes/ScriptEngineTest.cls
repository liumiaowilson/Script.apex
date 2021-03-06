/**
 * MIT License
 *
 * Copyright (c) 2018 Click to Cloud Pty Ltd
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 **/
@IsTest
private class ScriptEngineTest {
    @IsTest
    private static void objectTest() {
        Jsep.Node node = new Jsep('{ name: "wilson" }').parse();
        Map<String, Object> context = new Map<String, Object>{};
        System.assertEquals(
            new Map<String, Object>{ 'name' => 'wilson'},
            ScriptEngine.getInstance().eval(node, context)
        );
    }

    @IsTest
    private static void arrayTest() {
        Jsep.Node node = new Jsep('["a", "b"]').parse();
        Map<String, Object> context = new Map<String, Object>{};
        System.assertEquals(
            new List<Object>{ 'a', 'b' },
            ScriptEngine.getInstance().eval(node, context)
        );
    }

    @IsTest
    private static void conditionalTest() {
        Jsep.Node node = new Jsep('a ? 1 : 2').parse();
        Map<String, Object> context = new Map<String, Object>{
            'a' => true,
            'b' => false
        };
        System.assertEquals(
            1,
            ScriptEngine.getInstance().eval(node, context)
        );
    }

    @IsTest
    private static void logicalTest() {
        Jsep.Node node = new Jsep('a && b').parse();
        Map<String, Object> context = new Map<String, Object>{
            'a' => true,
            'b' => false
        };
        System.assertEquals(
            false,
            ScriptEngine.getInstance().eval(node, context)
        );
    }

    @IsTest
    private static void binaryTest() {
        Jsep.Node node = new Jsep('a + b').parse();
        Map<String, Object> context = new Map<String, Object>{
            'a' => 1,
            'b' => 2
        };
        System.assertEquals(
            3,
            ScriptEngine.getInstance().eval(node, context)
        );
    }

    @IsTest
    private static void unaryTest() {
        Jsep.Node node = new Jsep('!true').parse();
        Map<String, Object> context = new Map<String, Object>();
        System.assertEquals(
            false,
            ScriptEngine.getInstance().eval(node, context)
        );
    }

    @IsTest
    private static void thisTest() {
        Jsep.Node node = new Jsep('this').parse();
        Map<String, Object> context = new Map<String, Object>();
        System.assertEquals(
            context,
            ScriptEngine.getInstance().eval(node, context)
        );
    }

    @IsTest
    private static void literalTest() {
        Jsep.Node node = new Jsep('null').parse();
        System.assertEquals(
            null,
            ScriptEngine.getInstance().eval(node)
        );
    }

    @IsTest
    private static void memberTest() {
        Jsep.Node node = new Jsep('a.b').parse();
        System.assertEquals(
            3,
            ScriptEngine.getInstance().eval(node, new Map<String, Object>{ 'a' => new Map<String, Object>{ 'b' => 3 } })
        );

        node = new Jsep('a[0]').parse();
        System.assertEquals(
            3,
            ScriptEngine.getInstance().eval(node, new Map<String, Object>{ 'a' => new List<Object>{ 3 } })
        );
    }

    @IsTest
    private static void identifierTest() {
        Jsep.Node node = new Jsep('a').parse();
        System.assertEquals(
            null,
            ScriptEngine.getInstance().eval(node)
        );

        System.assertEquals(
            3,
            ScriptEngine.getInstance().eval(node, new Map<String, Object>{ 'a' => 3 })
        );
    }

    @IsTest
    private static void compoundTest() {
        Jsep.Node node = new Jsep('"a", "b"').parse();
        System.assertEquals(
            new List<Object>{ 'a', 'b' },
            ScriptEngine.getInstance().eval(node)
        );
    }

    @IsTest
    private static void instanceTest() {
        System.assert(ScriptEngine.getInstance() != null);
    }
}
