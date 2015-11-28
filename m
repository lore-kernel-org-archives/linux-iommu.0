From: Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>
Subject: Re: [PATCH 0/4 v2] Implement access checks in iommu page fault paths
Date: Sat, 28 Nov 2015 08:12:22 -0800
Message-ID: <arpeuk73ktop4vbf1svmic5f.1448727142412@email.android.com>
References: <1447773099-2444-1-git-send-email-joro@8bytes.org>
	<564CA3C4.60609@virtuousgeek.org> <20151127120751.GJ24300@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1841161074426593309=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151127120751.GJ24300-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============1841161074426593309==
Content-Type: multipart/alternative; boundary="--_com.android.email_11289344889431410"

----_com.android.email_11289344889431410
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

Tm8gc29ycnksIGFuZCBub3cgaXQgbG9va3MgbGlrZSBpdCdsbCBiZSBhbm90aGVyIGNvdXBsZSBv
ZiB3ZWVrcy4gSSdkIHNheSBnbyBhaGVhZCBhbmQgbGFuZCB0aGVtIHRob3VnaC4gWW91IGNhbiBh
ZGQgbXkgci1iIGFuZCBJJ2xsIHRlc3QgdGhlbSBuZXh0IHRpbWUgSSByZWJhc2UgbXkgaTkxNSBw
YXRjaGVzLiAKClRoYW5rcywgCkplc3NlIAoKLS0tLSBKb2VyZyBSb2VkZWwgd3JvdGUgLS0tLQoK
PkhleSBKZXNzZSwKPgo+T24gV2VkLCBOb3YgMTgsIDIwMTUgYXQgMDg6MTM6NTZBTSAtMDgwMCwg
SmVzc2UgQmFybmVzIHdyb3RlOgo+PiAKPj4gSSBtaWdodCBiZSBhYmxlIHRvIGZpbmQgdGltZSBs
YXRlciB0aGlzIHdlZWsgb3IgbmV4dDsgSSBoYXZlIHRvIHVwZGF0ZQo+PiBteSB0cmVlIHRvIERh
dmlkJ3MgbGF0ZXN0IGJpdHMgYW5kIHJlYmFzZSBteSBpOTE1IGNvZGUgb24gdG9wIGFsb25nIHdp
dGgKPj4gdGhlc2UgcGF0Y2hlcy4gIFRoZW4gSSBjYW4gcnVuIHNvbWUgb2YgbXkgdGVzdHMgYW5k
IGV4cGFuZCB0aGVtIHRvIHRyeQo+PiByL3cgdGVzdHMgdy9vIG1hcHBpbmcgdGhlIGJ1ZmZlciB3
aXRoIHRoZSByaWdodCBhY2Nlc3MgbW9kZS4KPgo+SGF2ZSB5b3UgZm91bmQgdGltZSB0byBydW4g
c29tZSBzbWFsbCB0ZXN0cyBvbiB0aGlzPwo+Cj4KPlRoYW5rcywKPgo+CUpvZXJnCj4KPgo=
----_com.android.email_11289344889431410
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PHAgZGlyPSJsdHIiPk5vIHNvcnJ5LCBhbmQgbm93IGl0IGxvb2tzIGxpa2UgaXQnbGwgYmUgYW5v
dGhlciBjb3VwbGUgb2Ygd2Vla3MuIEknZCBzYXkgZ28gYWhlYWQgYW5kIGxhbmQgdGhlbSB0aG91
Z2guIFlvdSBjYW4gYWRkIG15IHItYiBhbmQgSSdsbCB0ZXN0IHRoZW0gbmV4dCB0aW1lIEkgcmVi
YXNlIG15IGk5MTUgcGF0Y2hlcy4gPC9wPgo8cCBkaXI9Imx0ciI+VGhhbmtzLCA8YnI+Ckplc3Nl
IDwvcD4KPGJyPjxicj4tLS0tIEpvZXJnIFJvZWRlbCB3cm90ZSAtLS0tPGJyPjxicj5IZXkgSmVz
c2UsPGJyPjxicj5PbiBXZWQsIE5vdiAxOCwgMjAxNSBhdCAwODoxMzo1NkFNIC0wODAwLCBKZXNz
ZSBCYXJuZXMgd3JvdGU6PGJyPiZndDsgPGJyPiZndDsgSSBtaWdodCBiZSBhYmxlIHRvIGZpbmQg
dGltZSBsYXRlciB0aGlzIHdlZWsgb3IgbmV4dDsgSSBoYXZlIHRvIHVwZGF0ZTxicj4mZ3Q7IG15
IHRyZWUgdG8gRGF2aWQncyBsYXRlc3QgYml0cyBhbmQgcmViYXNlIG15IGk5MTUgY29kZSBvbiB0
b3AgYWxvbmcgd2l0aDxicj4mZ3Q7IHRoZXNlIHBhdGNoZXMuJm5ic3A7IFRoZW4gSSBjYW4gcnVu
IHNvbWUgb2YgbXkgdGVzdHMgYW5kIGV4cGFuZCB0aGVtIHRvIHRyeTxicj4mZ3Q7IHIvdyB0ZXN0
cyB3L28gbWFwcGluZyB0aGUgYnVmZmVyIHdpdGggdGhlIHJpZ2h0IGFjY2VzcyBtb2RlLjxicj48
YnI+SGF2ZSB5b3UgZm91bmQgdGltZSB0byBydW4gc29tZSBzbWFsbCB0ZXN0cyBvbiB0aGlzPzxi
cj48YnI+PGJyPlRoYW5rcyw8YnI+PGJyPglKb2VyZzxicj48YnI+PGJyPg==
----_com.android.email_11289344889431410--


--===============1841161074426593309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1841161074426593309==--
