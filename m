From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: How to ensure that different peripherals getting different IOVA
	address in kernel?
Date: Wed, 23 Sep 2015 10:42:14 +0800
Message-ID: <56021186.4010500@linux.intel.com>
References: <5600AF72.2000106@hisilicon.com> <560206AE.4020608@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
To: chenfeng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rcallicotte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: Dan zhao <dan.zhao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "Wangfei (William,
	Euler)" <w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Suzhuangluan <suzhuangluan-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, qijiwen <qijiwen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Peter Panshilin <peter.panshilin-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gMjAxNS85LzIzIDk6NTUsIGNoZW5mZW5nIHdyb3RlOgo+IEhpIGFsbCwKPiAKPiBJbiBJT01N
VSBhcmNoaXRlY3R1cmUgLCBob3cgdG8gbWFrZSB0d28gZGlmZmVyZW50IHBlcmlwaGVyYWxzIHNo
YXJlIHRoZSBzYW1lIHBhZ2UgdGFibGUgPwo+IAo+IEluIG90aGVyIHdvcmRzICwgaXMgdGhlcmUg
YSBtZWNoYW5pc20gb3Igc3RydWN0dXJlIHRvIG1ha2UgdHdvIHBlcmlwaGVyYWxzIGdldCBjb21w
bGV0ZWx5IGRpZmZlcmVudCBhZGRyZXNzLgo+IAo+IGVnOgo+IAo+IHBlcmktQeOAgXBlcmktQiBh
bmQgcGVyaS1DIHNoYXJlIHRoZSBzYW1lIGlvdmEgYWRkcmVzcyAwLTFHIGZvciBzb21lIHBlcmZv
cm1hbmNlIHJlcXVlc3RzLgo+IAo+IFNvIHRoZSBBLEIsQyBuZWVkIHRvIHVzZSB0aGUgc2FtZSBJ
T1ZBIGdlbmVyYXRvciB0byBlbnN1cmUgdGhpcyxidXQgSSBkb24ndCBmaW5kIGFuIGFyY2hpdGVj
dHVyZSB0byBtYWtlIHRoaXMuCj4gCj4gQW55IGhlbHAgd2lsbCBiZSBhcHByZWNpYXRlZC4KSGkg
Q2hlbmZlbmcsCglTZWVtcyBJT01NVSBncm91cCBtYXkgaGVscCB5b3UsIHBsZWFzZSB0YWtlIGEg
bG9vayBhdApEb2N1bWVudGF0aW9uL3ZmaW8udHh0LgpUaGFua3MhCkdlcnJ5Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
