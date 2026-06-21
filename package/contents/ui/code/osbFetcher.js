// osbFetcher.js

function parseXml(xml) {
    if (!xml) return;

    var statusPriority = ["broken", "failed", "unresolvable", "blocked", "disabled", "excluded", "building", "finished", "scheduled", "succeeded"];
    var summary = {};
    var re = /<status package="([^"]+)" code="([^"]+)"/g;
    var match;

    while ((match = re.exec(xml)) !== null) {
        var pkg = match[1];
        var code = match[2];
        if (!(pkg in summary) || statusPriority.indexOf(code) < statusPriority.indexOf(summary[pkg])) {
            summary[pkg] = code;
        }
    }

    buildModel.clear();
    for (var key in summary) {
        buildModel.append({ package: key, status: summary[key] });
    }
}

function summarizeWorstStatusFromModel(model) {
    var statusPriority = ["broken", "failed", "unresolvable", "blocked", "disabled", "excluded", "building", "finished", "scheduled", "succeeded"];
    var worstIndex = statusPriority.length - 1;

    for (var i = 0; i < model.count; ++i) {
        var idx = statusPriority.indexOf(model.get(i).status);
        if (idx !== -1 && idx < worstIndex) worstIndex = idx;
    }

    return statusPriority[worstIndex];
}
