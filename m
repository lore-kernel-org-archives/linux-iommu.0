From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 09/19] iommu/arm-smmu: Consolidate stream map entry
	state
Date: Thu, 1 Sep 2016 19:54:19 +0100
Message-ID: <20160901185419.GX6721@arm.com>
References: <cover.1471975357.git.robin.murphy@arm.com>
	<26fcf7d3138816b9546a3dcc2bbbc2f229f34c91.1471975357.git.robin.murphy@arm.com>
	<20160901183257.GT6721@arm.com>
	<6d3209ff-51ad-30ca-867b-ce62105e6699@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6d3209ff-51ad-30ca-867b-ce62105e6699-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

T24gVGh1LCBTZXAgMDEsIDIwMTYgYXQgMDc6NDU6NTFQTSArMDEwMCwgUm9iaW4gTXVycGh5IHdy
b3RlOgo+IE9uIDAxLzA5LzE2IDE5OjMyLCBXaWxsIERlYWNvbiB3cm90ZToKPiA+IE9uIFR1ZSwg
QXVnIDIzLCAyMDE2IGF0IDA4OjA1OjIwUE0gKzAxMDAsIFJvYmluIE11cnBoeSB3cm90ZToKPiA+
PiAtCXdoaWxlICgtLWkgPj0gMCkKPiA+PiAtCQlfX2FybV9zbW11X2ZyZWVfYml0bWFwKHNtbXUt
PnNtcl9tYXAsIHNtcnNbaV0uaWR4KTsKPiA+PiAtCWtmcmVlKHNtcnMpOwo+ID4+ICsJd2hpbGUg
KGktLSkgewo+ID4+ICsJCWFybV9zbW11X2ZyZWVfc21yKHNtbXUsIGNmZy0+c21lbmR4W2ldKTsK
PiA+PiArCQljZmctPnNtZW5keFtpXSA9IElOVkFMSURfU01FTkRYOwo+ID4+ICsJfQo+ID4gCj4g
PiBIbW0sIGRvbid0IHlvdSBoYXZlIGFuIG9mZi1ieS1vbmUgaGVyZT8gQXQgbGVhc3QsIGxvb2tp
bmcgYXQgdGhlIGZpbmFsCj4gPiBjb2RlLCB3ZSBicmFuY2ggdG8gb3V0X2VyciBmcm9tIHdpdGhp
biB0aGUgZm9yX2VhY2hfY2ZnX3NtZSBsb29wLCBidXQKPiA+IGJlZm9yZSB3ZSd2ZSBpbmNyZW1l
bnRlZCBzbW11LT5zMmNyc1tpZHhdLmNvdW50LCBzbyB0aGUgYXJtX3NtbXVfZnJlZV9zbXIKPiA+
IHdpbGwgZXJyb25lb3VzbHkgZGVjcmVtZW50IHRoYXQuCj4gCj4gR2l2ZW4gdGhhdCBzMmNycyBv
bmx5IGRvZXNuJ3QgZXhpc3QgdW50aWwgcGF0Y2ggMTAsIGFuZCBzMmNycy0+Y291bnQKPiBkb2Vz
bid0IGV4aXN0IHVudGlsIHBhdGNoIDE0LCBJJ2QgaGF2ZSB0byBzYXkgcGljayBvbmUgb2Y6Cj4g
Cj4gYSkgbm8KPiAKPiBiKSDCr1xfKOODhClfL8KvCgpZb3UgZm9yZ290OgoKYykgSSBjb21wbGV0
ZWx5IG1pc3JlYWQgdGhlIGNvZGUKClNvIGl0J3MgYWxsIGZpbmUhCgpXaWxsCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
