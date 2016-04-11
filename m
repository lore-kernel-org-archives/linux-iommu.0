From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [RFT v2] iommu/amd: use subsys_initcall() on amdv2 iommu
Date: Mon, 11 Apr 2016 15:28:52 +0200
Message-ID: <570BA694.8040900@amd.com>
References: <20160316171719.GE2195@8bytes.org>
	<1459273313-5139-1-git-send-email-mcgrof@kernel.org>
	<CAB=NE6XCmMk4sraQo34XQJfjWu_yRc1rar_eQRSET8Q7VR9EOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAB=NE6XCmMk4sraQo34XQJfjWu_yRc1rar_eQRSET8Q7VR9EOw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

QW0gMDkuMDQuMjAxNiB1bSAwMjoyNSBzY2hyaWViIEx1aXMgUi4gUm9kcmlndWV6Ogo+IE9uIFR1
ZSwgTWFyIDI5LCAyMDE2IGF0IDEwOjQxIEFNLCBMdWlzIFIuIFJvZHJpZ3VleiA8bWNncm9mQGtl
cm5lbC5vcmc+IHdyb3RlOgo+PiBXZSBuZWVkIHRvIGVuc3VyZSBhbWQgaW9tbXUgdjIgaW5pdGlh
bGl6ZXMgYmVmb3JlCj4+IGRyaXZlciB1c2VzIHN1Y2ggYXMgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX21vZHVsZS5jLAo+PiB0byBkbyB0aGlzIG1ha2UgaXRzIGluaXQgcm91dGluZSBh
IHN1YnN5c19pbml0Y2FsbCgpIHdoaWNoCj4+IGVuc3VyZXMgaXRzIGxvYWQgaW5pdCBpcyBjYWxs
ZWQgZmlyc3QgdGhhbiBtb2R1bGVzIHdoZW4KPj4gYnVpbHQtaW4uCj4+Cj4+IFRoaXMgcmV2ZXJ0
cyB0aGUgb2xkIHdvcmsgYXJvdW5kIGltcGxlbWVudGVkIHRocm91Z2ggY29tbWl0Cj4+IDFiYWNj
ODk0YzIyN2ZhZDhhNyAoImRyaXZlcnM6IE1vdmUgaW9tbXUvIGJlZm9yZSBncHUvIGluIE1ha2Vm
aWxlIiksCj4+IGluc3RlYWQgb2YgbWFraW5nIHRoZSBkZXBlbmRlbmN5IGltcGxpY2l0IGJ5IGxp
bmtlciBvcmRlciB0aGlzCj4+IG1ha2VzIHRoZSBvcmRlcmluZyByZXF1aXJlbWVudCBleHBsaWNp
dCB0aHJvdWdoIHByb3BlciBrZXJuZWwKPj4gQVBJcy4KPj4KPj4gQ2M6IE9kZWQgR2FiYmF5IDxv
ZGVkLmdhYmJheUBhbWQuY29tPgo+PiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBMdWlzIFIuIFJvZHJpZ3VleiA8bWNncm9m
QGtlcm5lbC5vcmc+CgpTb3JyeSBmb3Igbm90IHJlc3BvbmRpbmcgZWFybGllci4gSnVzdCBjb21p
bmcgYmFjayB0byBhbGwgdGhlIHN0dWZmIG9uIApteSBUT0RPIGxpc3QuCgpQYXRjaCBpcyBBY2tl
ZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKUmVnYXJk
cywKQ2hyaXN0aWFuLgoKPiAqcG9rZSoKPgo+ICAgTHVpcwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
