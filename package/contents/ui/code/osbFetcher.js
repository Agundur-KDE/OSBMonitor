
function fetchRaw(url, callback) {
    const xhr = new XMLHttpRequest();
    xhr.open("GET", url);
    xhr.setRequestHeader("User-Agent", "Mozilla/5.0 (X11; Linux x86_64)");
    xhr.onload = function () {
        console.log("📬 Status:", xhr.status);
        console.log("📄 Body:", xhr.responseText);
        callback && callback(xhr.responseText);
    };
    xhr.send();
}


function fetchBuildStatus(projectUrl, callback) {
    var xhr = new XMLHttpRequest();
    console.log("📡 [XHR] Opening:", projectUrl);

    xhr.open("GET", projectUrl);

     try {
        xhr.setRequestHeader("User-Agent", "Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101 Firefox/102.0");

    } catch (e) {
        console.log("❌ setRequestHeader(User-Agent) failed:", e);
    }

     try {
       xhr.setRequestHeader("Accept", "text/html,application/xhtml+xml");

    } catch (e) {
        console.log("❌ setRequestHeader(Accept) failed:", e);
    }

    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            console.log("📬 [XHR] Status:", xhr.status);
            // console.log("📄 [XHR] Response snippet:", xhr.responseText.substr(0, 200));

            if (xhr.status === 200) {
                const html = xhr.responseText;
                const result = parseHtml(html);
                callback(result);
            } else {
                console.log("❌ [XHR] Failed to fetch OSB page:", xhr.status);
                callback([]);
            }
        }
    };

    xhr.onerror = function (e) {
        console.log("❌ [XHR] Network error:", e);
        callback([]);
    };

    xhr.send();
}

function parseHtml(html) {
    const regex = /<tbody[^>]+data-statushash='([^']+)'/;
    const match = regex.exec(html);

    if (!match) {
        console.log("❌ Keine statushash-Daten gefunden.");
        return { headers: [], rows: [] };
    }

    const escapedJson = match[1]
        .replace(/&quot;/g, '"')
        .replace(/&amp;/g, '&');

    let statusData;
    try {
        statusData = JSON.parse(escapedJson);
    } catch (e) {
        console.log("❌ JSON Parse Error:", e);
        return { headers: [], rows: [] };
    }

    const archs = new Set();
    const packages = new Set();

    for (const distro in statusData) {
        for (const arch in statusData[distro]) {
            archs.add(arch);
            for (const pkg in statusData[distro][arch]) {
                packages.add(pkg);
            }
        }
    }

    const rows = [];
    for (const pkg of [...packages].sort()) {
        const row = { name: pkg };
        for (const arch of archs) {
            let status = "";
            for (const distro in statusData) {
                const entry = statusData[distro][arch]?.[pkg];
                if (entry) {
                    status = entry.code;
                }
            }
            row[arch] = status;
        }
        rows.push(row);
    }

    const headers = ["name", ...archs];
    console.log("✅ Table parsed:", { headers: headers, rows: rows });
    return { headers: headers, rows: rows };
}
