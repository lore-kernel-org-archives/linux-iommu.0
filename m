From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/4] ACPI/IORT: Check ATS capability in root complex nodes
Date: Mon, 25 Mar 2019 15:02:00 +0000
Message-ID: <ad2d1735-eba3-4650-70b9-355c9c7201a8@arm.com>
References: <20190320173634.21895-1-jean-philippe.brucker@arm.com>
	<20190320173634.21895-2-jean-philippe.brucker@arm.com>
	<fc53b2f7-53c4-c32d-8588-6f8d98ef5e7f@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <fc53b2f7-53c4-c32d-8588-6f8d98ef5e7f-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
To: Sinan Kaya <Okaya-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: zhongmiao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

T24gMjEvMDMvMjAxOSAxNjowMCwgU2luYW4gS2F5YSB3cm90ZToKPiBPbiAzLzIwLzIwMTkgMToz
NiBQTSwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOgo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
ZXJyID0gcGNpX2Zvcl9lYWNoX2RtYV9hbGlhcyh0b19wY2lfZGV2KGRldiksCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW9ydF9wY2lfaW9t
bXVfaW5pdCwgJmluZm8pOwo+PiArCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIWVyciAmJiAhaW9y
dF9wY2lfcmNfc3VwcG9ydHNfYXRzKG5vZGUpKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBk
ZXYtPmlvbW11X2Z3c3BlYy0+ZmxhZ3MgfD0gSU9NTVVfRldTUEVDX1BDSV9OT19BVFM7Cj4gCj4g
SXMgaXQgcG9zc2libGUgdG8gcmVtb3ZlICFlcnIgY2hlY2sgaGVyZS4gQVRTIHN1cHBvcnRlZCBp
cyBqdXN0IGEgZmxhZwo+IGluIElPUlQgdGFibGUuIERvZXMgdGhpcyBkZWNpc2lvbiBoYXZlIHRv
IHJlbHkgb24gaGF2aW5nIGEgY29ycmVjdCBkbWEKPiBhbGlhcz8KCmlvcnRfcGNpX2lvbW11X2lu
aXQoKSBhbGxvY2F0ZXMgYW5kIGluaXRpYWxpemVzIGRldi0+aW9tbXVfZndzcGVjLCBzbwpjaGVj
a2luZyAhZXJyIGVuc3VyZXMgdGhhdCBkZXYtPmlvbW11X2Z3c3BlYy0+ZmxhZ3MgaXMgdmFsaWQu
CgpUaGFua3MsCkplYW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
