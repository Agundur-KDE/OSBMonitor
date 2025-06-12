
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
    // const dom = Qt.createQmlObject(
    //     'import QtQuick 2.15; QtObject { property string content: "" }',
    //     Qt.application,
    //     "DOMHelper"
    // );
    // dom.content = html;
console.log(html)
    const pkgList = [];

    // Quick & Dirty: regexbasierte Extraktion (da kein DOMParser in Qt/QML verfügbar ist)
    const regex = /class="build-state-([\w-]+)"/g;
    let match;

    console.log(regex.exec(html))

    while ((match = regex.exec(html)) !== null) {
        const pkgName = match[1].trim();
        const statusClass = match[2].trim();
        pkgList.push({ name: pkgName, status: statusClass });
    }

    return pkgList;
}
