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

// Shared good/warn/bad/unknown classification, used by every representation
// so the panel icon, popup list and notifications never disagree on color.
function statusCategory(status) {
    switch (status) {
        case "succeeded":
        case "finished":
            return "good";
        case "building":
        case "scheduled":
            return "warn";
        case "failed":
        case "broken":
        case "unresolvable":
            return "bad";
        case "blocked":
        case "disabled":
        case "excluded":
            return "warn";
        default:
            return "unknown"; // "not configured", "searching ...", "error"
    }
}
