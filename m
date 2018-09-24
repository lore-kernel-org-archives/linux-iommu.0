From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 02/10] iommu/sva: Bind process address spaces to devices
Date: Mon, 24 Sep 2018 13:07:47 +0100
Message-ID: <7cbd503a-c79e-3c40-7388-ce6c23f7f536@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
	<20180920170046.20154-3-jean-philippe.brucker@arm.com>
	<cdcd4083-ef28-4c5e-4a2c-5b93e61a86b4@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cdcd4083-ef28-4c5e-4a2c-5b93e61a86b4-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gMjMvMDkvMjAxOCAwNDowNSwgTHUgQmFvbHUgd3JvdGU6Cj4gSGksCj4gCj4gT24gMDkvMjEv
MjAxOCAwMTowMCBBTSwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOgo+PiBBZGQgYmluZCgp
IGFuZCB1bmJpbmQoKSBvcGVyYXRpb25zIHRvIHRoZSBJT01NVSBBUEkuIEJpbmQoKSByZXR1cm5z
IGEKPj4gUEFTSUQgdGhhdCBkcml2ZXJzIGNhbiBwcm9ncmFtIGluIGhhcmR3YXJlLCB0byBsZXQg
dGhlaXIgZGV2aWNlcyBhY2Nlc3MgYW4KPj4gbW0uIFRoaXMgcGF0Y2ggb25seSBhZGRzIHNrZWxl
dG9ucyBmb3IgdGhlIGRldmljZSBkcml2ZXIgQVBJLCBtb3N0IG9mIHRoZQo+PiBpbXBsZW1lbnRh
dGlvbiBpcyBzdGlsbCBtaXNzaW5nLgo+IAo+IElzIGl0IHBvc3NpYmxlIHRoYXQgYSBtYWxpY2lv
dXMgcHJvY2VzcyBjYW4gdW5iaW5kIGEgcGFzaWQgd2hpY2ggaXMKPiB1c2VkIGJ5IGFub3RoZXIg
bm9ybWFsIHByb2Nlc3M/CgpZZXMsIGl0J3MgdXAgdG8gdGhlIGRldmljZSBkcml2ZXIgdGhhdCBj
YWxscyB1bmJpbmQoKSB0byBjaGVjayB0aGF0IHRoZQpjYWxsZXIgaXMgYWxsb3dlZCB0byB1bmJp
bmQgdGhpcyBQQVNJRC4gV2UgY2FuJ3QgZG8gaXQgb3Vyc2VsdmVzIHNpbmNlCnVuYmluZCgpIGNv
dWxkIGFsc28gYmUgY2FsbGVkIGZyb20gYSBrZXJuZWwgdGhyZWFkIGZvciBleGFtcGxlIGZyb20g
YQpjbGVhbnVwIGZ1bmN0aW9uIGluIHNvbWUgd29ya3F1ZXVlLCBvdXRzaWRlIHRoZSBjb250ZXh0
IG9mIHRoZSBwcm9jZXNzCnRvIHVuYmluZC4KClRoYW5rcywKSmVhbgoKPiAKPiBJdCBtaWdodCBo
YXBwZW4gaW4gYmVsb3cgc2VxdWVuY2U6Cj4gCj4gCj4gUHJvY2VzcyBBwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUHJvY2VzcyBCCj4gPT09PT09PT09wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPT09PT09PT09Cj4gaW9tbXVf
c3ZhX2luaXRfZGV2aWNlKGRldikKPiBpb21tdV9zdmFfYmluZF9kZXZpY2UoZGV2KQo+IC4uLi4K
PiBkZXZpY2UgYWNjZXNzIG1tIG9mIEEgd2l0aAo+ICNQQVNJRCByZXR1cm5lZCBhYm92ZQo+IC4u
Li4KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpb21tdV9zdmFfdW5iaW5kX2RldmljZShkZXYsICNQQVNJRCkKPiAuLi4uCj4g
W3VucmVjb3ZlcmFibGUgZXJyb3JzXQo+IAo+IEkgZGlkbid0IGhhdmUgYSB0aG9yb3VnaCBjb25z
aWRlcmF0aW9uIG9mIHRoaXMuIFNvcnJ5IGlmIHRoaXMgaGFzIGJlZW4KPiBwcmV2ZW50ZWQuCj4g
Cj4gQmVzdCByZWdhcmRzLAo+IEx1IEJhb2x1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
