// osbFetcher.js

function statusPriority(ignoreDisabled) {
    var priority = ["broken", "failed", "unresolvable", "blocked", "disabled", "excluded", "building", "finished", "scheduled", "succeeded"];
    if (ignoreDisabled) {
        priority.splice(priority.indexOf("disabled"), 1);
        priority.push("disabled");
    }
    return priority;
}

function parseXml(xml, model, ignoreDisabled) {
    if (!xml) return;

    var priority = statusPriority(ignoreDisabled);
    var summary = {};
    var re = /<status package="([^"]+)" code="([^"]+)"/g;
    var match;

    while ((match = re.exec(xml)) !== null) {
        var pkg = match[1];
        var code = match[2];
        if (!(pkg in summary) || priority.indexOf(code) < priority.indexOf(summary[pkg])) {
            summary[pkg] = code;
        }
    }

    model.clear();
    for (var key in summary) {
        model.append({ package: key, status: summary[key] });
    }
}

function summarizeWorstStatusFromModel(model, ignoreDisabled) {
    var priority = statusPriority(ignoreDisabled);
    var worstIndex = priority.length;

    for (var i = 0; i < model.count; ++i) {
        var idx = priority.indexOf(model.get(i).status);
        if (idx !== -1 && idx < worstIndex) worstIndex = idx;
    }

    return worstIndex < priority.length ? priority[worstIndex] : "succeeded";
}

// Shared good/warn/bad/unknown classification, used by every representation
// so the panel icon, popup list and notifications never disagree on color.
function statusCategory(status, ignoreDisabled) {
    if (status === "disabled" && ignoreDisabled) return "neutral";
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
