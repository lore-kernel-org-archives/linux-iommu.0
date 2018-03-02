From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 11/14] drm/msm: Add support for iommu-sva
 PASIDs
Date: Fri, 2 Mar 2018 12:29:07 +0000
Message-ID: <a0ab61d6-1894-c3ba-4955-ca6d4f74a4d7@arm.com>
References: <20180221225924.30737-1-jcrouse@codeaurora.org>
 <20180221225924.30737-12-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180221225924.30737-12-jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gMjEvMDIvMTggMjI6NTksIEpvcmRhbiBDcm91c2Ugd3JvdGU6ClsuLi5dPiArc3RhdGljIGlu
dCBpbnN0YWxsX3Bhc2lkX2NiKGludCBwYXNpZCwgdTY0IHR0YnIsIHUzMiBhc2lkLCB2b2lkICpk
YXRhKQo+ICt7Cj4gKwlzdHJ1Y3QgcGFzaWRfZW50cnkgKmVudHJ5ID0ga3phbGxvYyhzaXplb2Yo
KmVudHJ5KSwgR0ZQX0tFUk5FTCk7Cj4gKwo+ICsJaWYgKCFlbnRyeSkKPiArCQlyZXR1cm4gLUVO
T01FTTsKPiArCj4gKwllbnRyeS0+cGFzaWQgPSBwYXNpZDsKPiArCWVudHJ5LT50dGJyID0gdHRi
cjsKPiArCWVudHJ5LT5hc2lkID0gYXNpZDsKPiArCj4gKwkvKiBGSVhNRTogQXNzdW1lIHRoYXQg
d2UnbGwgbmV2ZXIgaGF2ZSBhIHBhc2lkIGNvbmZsaWN0PyAqLwoKSSB0aGluayBhIGNvbmZsaWN0
IHdvdWxkIGJlIGEgYnVnIG9uIHRoZSBJT01NVSBzaWRlLiBVc2VycyBzaG91bGQgbm90IGhhdmUK
dG8gY2hlY2sgdGhpcy4gVGhlbiBhZ2FpbiwgSSBoYXZlIGEgZmV3IFdBUk5zIG9uIHRoZSBTTU1V
djMgY29udGV4dCB0YWJsZQpjb2RlIHRoYXQgdW5jb3ZlcmVkIG5hc3R5IGJ1Z3MgZHVyaW5nIGRl
dmVsb3BtZW50LgoKVGhhbmtzLApKZWFuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkZyZWVkcmVubyBtYWlsaW5nIGxpc3QKRnJlZWRyZW5vQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2ZyZWVkcmVubwo=
