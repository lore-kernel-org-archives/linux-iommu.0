From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: How to ensure that different peripherals getting different IOVA
	address in kernel?
Date: Wed, 23 Sep 2015 13:08:28 +0100
Message-ID: <5602963C.8030601@arm.com>
References: <5600AF72.2000106@hisilicon.com> <560206AE.4020608@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <560206AE.4020608-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: chenfeng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rcallicotte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <rcallicotte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Dan zhao <dan.zhao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "Wangfei (William,
	Euler)" <w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Suzhuangluan <suzhuangluan-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, qijiwen <qijiwen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Peter Panshilin <peter.panshilin-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gMjMvMDkvMTUgMDI6NTUsIGNoZW5mZW5nIHdyb3RlOgo+IEhpIGFsbCwKPgo+IEluIElPTU1V
IGFyY2hpdGVjdHVyZSAsIGhvdyB0byBtYWtlIHR3byBkaWZmZXJlbnQgcGVyaXBoZXJhbHMgc2hh
cmUgdGhlIHNhbWUgcGFnZSB0YWJsZSA/Cj4KPiBJbiBvdGhlciB3b3JkcyAsIGlzIHRoZXJlIGEg
bWVjaGFuaXNtIG9yIHN0cnVjdHVyZSB0byBtYWtlIHR3byBwZXJpcGhlcmFscyBnZXQgY29tcGxl
dGVseSBkaWZmZXJlbnQgYWRkcmVzcy4KPgo+IGVnOgo+Cj4gcGVyaS1B44CBcGVyaS1CIGFuZCBw
ZXJpLUMgc2hhcmUgdGhlIHNhbWUgaW92YSBhZGRyZXNzIDAtMUcgZm9yIHNvbWUgcGVyZm9ybWFu
Y2UgcmVxdWVzdHMuCj4KPiBTbyB0aGUgQSxCLEMgbmVlZCB0byB1c2UgdGhlIHNhbWUgSU9WQSBn
ZW5lcmF0b3IgdG8gZW5zdXJlIHRoaXMsYnV0IEkgZG9uJ3QgZmluZCBhbiBhcmNoaXRlY3R1cmUg
dG8gbWFrZSB0aGlzLgoKVGhpcyBpcyB3aGF0IElPTU1VIGRvbWFpbnMgYXJlIGFsbCBhYm91dDog
ZGV2aWNlcyBpbiBvbmUgZG9tYWluIGFyZSAKaXNvbGF0ZWQgZnJvbSBkZXZpY2VzIGluIGRpZmZl
cmVudCBkb21haW5zLCBzbyBhbGwgeW91IG5lZWQgdG8gZG8gaXMgCm1ha2Ugc3VyZSBhbGwgZGV2
aWNlcyB0aGF0IHdhbnQgdG8gc2hhcmUgYnVmZmVycyBhcmUgYXR0YWNoZWQgdG8gdGhlIApzYW1l
IGRvbWFpbiwgdGhlbiB0aGV5IHdpbGwgYWxsIHNoYXJlIHRoYXQgZG9tYWluJ3MgSU9WQSBzcGFj
ZS4KClJvYmluLgoKPgo+IEFueSBoZWxwIHdpbGwgYmUgYXBwcmVjaWF0ZWQuCj4KPiBQdWNrCj4K
PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
