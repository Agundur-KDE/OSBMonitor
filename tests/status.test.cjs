const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const {test} = require('node:test');

// Load the production QML JavaScript, without reproducing its status rules.
const osb = vm.createContext({});
vm.runInContext(fs.readFileSync(path.join(__dirname,
    '../package/contents/ui/code/osbFetcher.js'), 'utf8'), osb);

function model(statuses = []) {
    return {
        rows: statuses.map(status => ({status})),
        get count() { return this.rows.length; },
        get(index) { return this.rows[index]; },
        clear() { this.rows = []; },
        append(row) { this.rows.push(row); },
    };
}

test('disabled keeps the existing warning behavior by default', () => {
    assert.equal(osb.statusCategory('disabled'), 'warn');
    assert.equal(osb.summarizeWorstStatusFromModel(model(['succeeded', 'disabled'])), 'disabled');
});

test('ignored disabled rows are neutral and do not turn successful builds orange', () => {
    assert.equal(osb.statusCategory('disabled', true), 'neutral');
    assert.equal(osb.summarizeWorstStatusFromModel(model(['succeeded', 'disabled']), true), 'succeeded');
});

test('only disabled packages remain disabled, not falsely successful', () => {
    assert.equal(osb.summarizeWorstStatusFromModel(model(['disabled', 'disabled']), true), 'disabled');
});

test('ignoring disabled never suppresses real errors or build activity', () => {
    for (const status of ['failed', 'broken', 'unresolvable', 'blocked', 'building', 'scheduled', 'excluded']) {
        assert.equal(osb.summarizeWorstStatusFromModel(model(['disabled', status]), true), status);
        assert.notEqual(osb.statusCategory(status, true), 'neutral');
    }
});

test('a disabled architecture does not hide another architecture building or succeeding', () => {
    const xml = '<status package="example" code="disabled"/>' +
                '<status package="example" code="building"/>';
    const result = model();
    osb.parseXml(xml, result, true);
    assert.equal(result.get(0).status, 'building');
    osb.parseXml(xml.replace('building', 'succeeded'), result, true);
    assert.equal(result.get(0).status, 'succeeded');
    osb.parseXml(xml, result, false);
    assert.equal(result.get(0).status, 'disabled');
});

test('disabled entries remain visible and errors remain errors in either mode', () => {
    for (const ignoreDisabled of [false, true]) {
        const result = model();
        osb.parseXml('<status package="off" code="disabled"/>' +
            '<status package="bad" code="disabled"/>' +
            '<status package="bad" code="failed"/>', result, ignoreDisabled);
        assert.equal(result.count, 2);
        assert.equal(result.rows.find(row => row.package === 'off').status, 'disabled');
        assert.equal(result.rows.find(row => row.package === 'bad').status, 'failed');
    }
});
