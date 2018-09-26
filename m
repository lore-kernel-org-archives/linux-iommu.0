From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 03/10] iommu/sva: Manage process address spaces
Date: Wed, 26 Sep 2018 11:20:34 +0100
Message-ID: <754d495d-d016-f42f-5682-ba4a75a618e0@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
	<20180920170046.20154-4-jean-philippe.brucker@arm.com>
	<09933fce-b959-32e1-b1f3-0d4389abf735@linux.intel.com>
	<20180925132627.vbdotr23o7lqrmnd@8bytes.org>
	<b33a1911-e100-586b-b8df-eb04312ecffd@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <b33a1911-e100-586b-b8df-eb04312ecffd-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gMjYvMDkvMjAxOCAwMDozMywgTHUgQmFvbHUgd3JvdGU6Cj4gSGkgSm9lcmcsCj4gCj4gT24g
MDkvMjUvMjAxOCAwOToyNiBQTSwgSm9lcmcgUm9lZGVsIHdyb3RlOgo+PiBPbiBUdWUsIFNlcCAy
NSwgMjAxOCBhdCAxMToxNTo0MEFNICswODAwLCBMdSBCYW9sdSB3cm90ZToKPj4+IFRoaXMgbWln
aHQgYmUgcHJvYmxlbWF0aWMgZm9yIHZ0LWQgKGFuZCBvdGhlciBwb3NzaWJsZSBhcmNoJ3Mgd2hp
Y2ggdXNlCj4+PiBQQVNJRCBvdGhlciB0aGFuIFNWQSkuIFdoZW4gdnQtZCBpb21tdSB3b3JrcyBp
biBzY2FsYWJsZSBtb2RlLCBhIFBBU0lECj4+PiBtaWdodCBiZSBhbGxvY2F0ZWQgZm9yOgo+Pj4K
Pj4+ICgxKSBTVkEKPj4+ICgyKSBEZXZpY2UgQXNzaWduYWJsZSBJbnRlcmZhY2UgKG1pZ2h0IGJl
IGEgbWRldiBvciBkaXJlY3RseSBtYW5hZ2VkCj4+PsKgwqDCoMKgwqAgd2l0aGluIGEgZGV2aWNl
IGRyaXZlcikuCj4+PiAoMykgU1ZBIGluIFZNIGd1ZXN0Cj4+PiAoNCkgRGV2aWNlIEFzc2lnbmFi
bGUgSW50ZXJmYWNlIGluIFZNIGd1ZXN0Cj4+Pgo+Pj4gU28gd2UgY2FuJ3QgZXhwZWN0IHRoYXQg
YW4gaW9fbW0gcG9pbnRlciB3YXMgYXNzb2NpYXRlZCB3aXRoIGVhY2ggUEFTSUQuCj4+PiBBbmQg
dGhpcyBjb2RlIG1pZ2h0IHJ1biBpbnRvIHByb2JsZW0gaWYgdGhlIHBhc2lkIGlzIGFsbG9jYXRl
ZCBmb3IKPj4+IHVzYWdlcyBvdGhlciB0aGFuIFNWQS4KPj4gCj4+IFNvIGFsbCBvZiB0aGVzZSB1
c2UtY2FzZXMgYWJvdmUgc2hvdWxkIHdvcmsgaW4gcGFyYWxsZWwgb24gdGhlIHNhbWUKPj4gZGV2
aWNlLCBqdXN0IHdpdGggZGlmZmVyZW50IFBBU0lEcz8KPiAKPiBOby4gSXQncyBub3QgcmVxdWly
ZWQuCj4gCj4+IE9yIGlzIGEgZGV2aWNlIGFsd2F5cyB1c2luZyBvbmx5IG9uZQo+PiBvZiB0aGUg
YWJvdmUgbW9kZXMgYXQgdGhlIHNhbWUgdGltZT8KPiAKPiBBIGRldmljZSBtaWdodCB1c2Ugb25l
IG9yIG11bHRpcGxlIG1vZGVzIGRlc2NyaWJlZCBhYm92ZSBhdCB0aGUgc2FtZQo+IHRpbWUuCgpZ
ZXMsIGF0IHRoZSBtb21lbnQgaXQncyBkaWZmaWN1bHQgdG8gZ3Vlc3Mgd2hhdCBkZXZpY2UgZHJp
dmVycyB3aWxsCndhbnQsIGJ1dCBJIGNhbiBpbWFnaW5lIHNvbWUgZHJpdmVyIG9mZmVyaW5nIFNW
QSB0byB1c2Vyc3BhY2UsIHdoaWxlCmtlZXBpbmcgYSBmZXcgUEFTSURzIGZvciB0aGVtc2VsdmVz
IHRvIG1hcCBrZXJuZWwgbWVtb3J5LiBPciBjcmVhdGUgbWRldgpkZXZpY2VzIGZvciB2aXJ0dWFs
aXphdGlvbiB3aGlsZSBhbHNvIGFsbG93aW5nIGJhcmUtbWV0YWwgU1ZBLiBTbyBJCnRoaW5rIHdl
IHNob3VsZCBhaW0gYXQgZW5hYmxpbmcgdGhlc2UgdXNlLWNhc2VzIGluIHBhcmFsbGVsLCBldmVu
IGlmIGl0CmRvZXNuJ3QgbmVjZXNzYXJpbHkgbmVlZCB0byBiZSBwb3NzaWJsZSByaWdodCBub3cu
CgpUaGFua3MsCkplYW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
