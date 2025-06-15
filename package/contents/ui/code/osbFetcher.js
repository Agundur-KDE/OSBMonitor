// osbFetcher.js

.pragma library

const severity = [
  "failed",    // ganz oben, wenn auch nur ein einziger „failed“ auftaucht
  "building",  // danach; z.B. „Building“ oder „pending“
  "succeeded"  // Default-Status ganz unten
];


function fetchBuildStatus(projectUrl, callback) {
    var xhr = new XMLHttpRequest();
    console.log("📡 [XHR] Fetching:", projectUrl);

    xhr.open("GET", projectUrl);

    // HTML akzeptieren
    try {
        xhr.setRequestHeader("Accept", "text/html,application/xhtml+xml");
    } catch (e) {
        console.log("❌ setRequestHeader(Accept) failed:", e);
    }

    xhr.onload = function () {
        console.log("📬 [XHR] Status:", xhr.status);
        if (xhr.status !== 200) {
            console.log("❌ HTTP Error:", xhr.status);
            callback({ headers: [], rows: [] });
            return;
        }
        // parseHtml liefert { headers, rows }
        var result = parseHtml(xhr.responseText);
        // modellbefüllung direkt hier:
        callback(result);
    };

    xhr.onerror = function (e) {
        console.log("❌ [XHR] Network error:", e);
        callback({ headers: [], rows: [] });
    };

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


function parseHtml(html) {

    // 1) JSON-String aus data-statushash
    var regex = /<tbody[^>]+data-statushash='([^']+)'/;
    var match = regex.exec(html);
    if (!match) {
        console.log("❌ Keine statushash-Daten gefunden.");
        return { headers: [], rows: [] };
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
        return { headers: [], rows: [] };
    }

    // console.log(statusData);
    var sps = summarizePackageStatuses(statusData);
    const summarizedList = Object.entries(sps).map(([pkg, status]) => {
    return { package: pkg, status: status };
    });

    console.log("📋 summarizedList:", JSON.stringify(summarizedList, null, 2));

// Jetzt kannst du z. B. das ListModel aktualisieren
    model.clear();
    for (let i = 0; i < summarizedList.length; ++i) {
        model.append(summarizedList[i]);
    }

    // console.log(sps);
    // console.log(JSON.stringify(sps, null, 2));
    // console.log("✅ parseHtml produced:", { headers: headers, rows: rows });
    // return { headers: headers, rows: rows };
}
