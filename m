From: "Vesely, Jan" <Jan.Vesely-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/amd: Destroy api_lock mutex when freeing domain
Date: Thu, 9 Jun 2016 15:48:44 +0000
Message-ID: <1465487321.7114.0.camel@amd.com>
References: <1463854264-26445-1-git-send-email-jan.vesely@rutgers.edu>
	<1463854264-26445-2-git-send-email-jan.vesely@rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1463854264-26445-2-git-send-email-jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
Content-Language: en-US
Content-ID: <5512DE78BE3B7B4287F3CE26E4737E70-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gU2F0LCAyMDE2LTA1LTIxIGF0IDE0OjExIC0wNDAwLCBKYW4gVmVzZWx5IHdyb3RlOg0KPiBG
cm9tOiBKYW4gVmVzZWx5IDxqYW4udmVzZWx5QGFtZC5jb20+DQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBKYW4gVmVzZWx5IDxqYW4udmVzZWx5QGFtZC5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvaW9t
bXUvYW1kX2lvbW11LmMgfCAxICsNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jIGIvZHJpdmVycy9p
b21tdS9hbWRfaW9tbXUuYw0KPiBpbmRleCAxN2M3NmYyLi40ZmY1ZTQwIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jDQo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYW1kX2lv
bW11LmMNCj4gQEAgLTMwMTYsNiArMzAxNiw3IEBAIHN0YXRpYyB2b2lkIHByb3RlY3Rpb25fZG9t
YWluX2ZyZWUoc3RydWN0DQo+IHByb3RlY3Rpb25fZG9tYWluICpkb21haW4pDQo+IMKgDQo+IMKg
CWRlbF9kb21haW5fZnJvbV9saXN0KGRvbWFpbik7DQo+IMKgDQo+ICsJbXV0ZXhfZGVzdHJveSgm
ZG9tYWluLT5hcGlfbG9jayk7DQo+IMKgCWlmIChkb21haW4tPmlkKQ0KPiDCoAkJZG9tYWluX2lk
X2ZyZWUoZG9tYWluLT5pZCk7DQo+IMKgDQoNCnBpbmcKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
