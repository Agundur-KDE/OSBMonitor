// osbFetcher.js


function fetchBuildStatus(projectUrl, callback) {
    var xhr = new XMLHttpRequest();

    xhr.open("GET", projectUrl);

    try {
        xhr.setRequestHeader("Accept", "text/html,application/xhtml+xml");
    } catch (e) {
        console.log("❌ setRequestHeader(Accept) failed:", e);
    }

    xhr.onreadystatechange = (function f() {
        // console.log(callback);
        callback(xhr.responseText);
    });

    xhr.onerror = function (e) {
        console.log("❌ [XHR] Network error:", e);
    };
    // console.log("🕒 " + new Date().toLocaleTimeString());
    xhr.send();
}


function summarizePackageStatuses(statusData) {
    const statusPriority = [
        "failed",
        "broken",
        "unresolvable",
        "blocked",
        "disabled",
        "excluded",
        "scheduled",
        "building",
        "succeeded"
    ];

    const summary = {};

    for (const distro in statusData) {
        const arches = statusData[distro];
        for (const arch in arches) {
            const packages = arches[arch];
            for (const pkgName in packages) {
                const pkg = packages[pkgName];
                const code = pkg.code;

                if (!code || typeof code !== "string") continue; // skip invalid/empty

                if (!(pkgName in summary)) {
                    summary[pkgName] = code;
                } else {
                    const current = summary[pkgName];
                    // take the "worse" one based on priority
                    if (
                        statusPriority.indexOf(code) < statusPriority.indexOf(current)
                    ) {
                        summary[pkgName] = code;
                    }
                }
            }
        }
    }

    return summary;
}


function summarizeWorstStatusFromModel(model) {
    const statusPriority = [
        "broken",
        "failed",
        "unresolvable",
        "blocked",
        "disabled",
        "excluded",
        "building",
        "finished",
        "succeeded"
    ];

    let worstIndex = statusPriority.length - 1; // Start mit "succeeded"

    for (let i = 0; i < model.count; ++i) {
        const status = model.get(i).status;
        const index = statusPriority.indexOf(status);
        if (index !== -1 && index < worstIndex) {
            worstIndex = index;
        }
    }

    return statusPriority[worstIndex];
}

function parseHtml(html) {

    if (!html)
        return false;

    // 1) JSON-String aus data-statushash
    var regex = /<tbody[^>]+data-statushash='([^']+)'/;
    var match = regex.exec(html);
    if (!match) {

        console.log("❌ Keine statushash-Daten gefunden.");
        return false;
    }

    // 2) Unescape
    var escaped = match[1]
    .replace(/&quot;/g, '"')
    .replace(/&amp;/g, '&');

    var statusData;
    try {
        statusData = JSON.parse(escaped);
    } catch (e) {
        console.log("❌ JSON Parse Error:", e);
        return false;
    }
    buildModel.clear();


    var modelData = summarizePackageStatuses(statusData)

    // console.log(JSON.stringify(modelData, null, 2));

    for (let key in modelData) {
        if (modelData.hasOwnProperty(key)) {
            // console.log(key + ": " + modelData[key]);
            buildModel.append({ package: key, status: String(modelData[key]) });
        }
    }
}
