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
        if (typeof root !== "undefined") {
            root.tableHeaders = result.headers;
            root.buildModel.clear();
            result.rows.forEach(function(r) {
                root.buildModel.append(r);
            });
            console.log("📊 tableHeaders =", result.headers);
            console.log("📊 buildModel.count =", root.buildModel.count);
        }
        callback(result);
    };

    xhr.onerror = function (e) {
        console.log("❌ [XHR] Network error:", e);
        callback({ headers: [], rows: [] });
    };

    xhr.send();
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

 console.log(escaped);
    var distros = Object.keys(statusData);
    var archs = [];
    var pkgs  = [];
    distros.forEach(function(distro) {

        console.log(Object.keys(statusData[distro]));


        // Object.keys(statusData[distro]).forEach(function(arch) {
        //     if (archs.indexOf(arch) === -1) archs.push(arch);
        //     Object.keys(statusData[distro][arch]).forEach(function(p) {
        //         if (pkgs.indexOf(p) === -1) pkgs.push(p);
        //     });
        // });
    });

    // 5) headers & rows bauen
    var headers = ["name"].concat(archs);
    var rows = pkgs.sort().map(function(pkg) {
        var row = { name: pkg };
        archs.forEach(function(arch) {
            var code = "";
            Object.keys(statusData).some(function(distro) {
                var entry = statusData[distro][arch] && statusData[distro][arch][pkg];
                if (entry) {
                    code = entry.code;
                    return true;
                }
                return false;
            });
            row[arch] = code;
        });
        return row;
    });

    console.log("✅ parseHtml produced:", { headers: headers, rows: rows });
    return { headers: headers, rows: rows };
}
