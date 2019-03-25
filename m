From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/4] iommu/arm-smmu-v3: Add support for PCI ATS
Date: Mon, 25 Mar 2019 15:01:10 +0000
Message-ID: <130ae431-49b0-cec0-7b7d-8d6342353d31@arm.com>
References: <20190320173634.21895-1-jean-philippe.brucker@arm.com>
	<20190320173634.21895-4-jean-philippe.brucker@arm.com>
	<6a4fb991-b8cd-d64d-25bd-dbbefcf69fa5@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6a4fb991-b8cd-d64d-25bd-dbbefcf69fa5-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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

T24gMjEvMDMvMjAxOSAxNTo1MiwgU2luYW4gS2F5YSB3cm90ZToKPiBPbiAzLzIwLzIwMTkgMToz
NiBQTSwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOgo+PiBwb3MgPSBwY2lfZmluZF9leHRf
Y2FwYWJpbGl0eShwZGV2LCBQQ0lfRVhUX0NBUF9JRF9BVFMpOwo+PiArwqDCoMKgIGlmICghcG9z
KQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9TWVM7Cj4+ICsKPiAKPiBZb3UgZG9uJ3Qg
bmVlZCB0aGlzLiBwY2lfZW5hYmxlX2F0cygpIHZhbGlkYXRlcyB0aGlzIHZpYS4KPiAKPiDCoMKg
wqDCoGlmICghZGV2LT5hdHNfY2FwKQo+IMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwoK
UmlnaHQsIEkgdGhpbmsgSSB3YW50ZWQgdG8gZGlmZmVyZW50aWF0ZSBsYWNrIG9mIEFUUyBjYXBh
YmlsaXR5IGZyb20KYWN0dWFsIGVycm9yIGluIHBjaV9lbmFibGVfYXRzKCksIGluIHdoaWNoIGNh
c2Ugd2UnZCBpc3N1ZSBhIGRldl9lcnIoKS4KQnV0IHRoZSBvbmx5IG90aGVyIGVycm9ycyBpbiBw
Y2lfZW5hYmxlX2F0cygpIGFyZSByZWxhdGVkIHRvIGludmFsaWQgU1RVCnBhcmFtZXRlciwgd2hp
Y2ggYXJlIHZhbGlkIGluIG91ciBjYXNlLCBzbyB0aGUgZGV2X2VycigpIGlzIHByZXR0eQp1c2Vs
ZXNzLiBJJ2xsIHJlbW92ZSB0aGlzLgoKVGhhbmtzLApKZWFuCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
