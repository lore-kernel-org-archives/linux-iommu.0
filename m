From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: sync the OVACKFLG to PRIQ consumer
	register
Date: Mon, 23 Jul 2018 16:14:36 +0100
Message-ID: <69affaf7-096c-da11-0f87-1bfe1840715c@arm.com>
References: <8CD08B4737CACA4ABE0228F45E441A916382021E@DGGEMM501-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <8CD08B4737CACA4ABE0228F45E441A916382021E-0LhPdUyVHB9UuCJht5byYAK1hpo4iccwjNknBlVQO8k@public.gmane.org>
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
To: Zhongmiao <zhongmiao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Zhangshaokun <zhangshaokun-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

SGksCgpPbiAyMy8wNy8xOCAxNTo0MywgWmhvbmdtaWFvIHdyb3RlOgo+IFllYWgsICAgIEkgaGF2
ZW4ndCB0ZXN0ZWQgc21tdSAgZXZlbnRxICBvdmVyZmxvdyAsICBzbyBpJ20gbm90IHN1cmUgaWYg
dGhlcmUgaXMgYW55IHByb2JsZW0gd2l0aCBzbW11IGV2ZW50cS4gIEhvd2V2ZXIsIHRoZSBjb2Rl
IHNob3dzIHRoYXQgdGhlcmUgaXMgYWxzbyBhIHByb2JsZW0gYWZ0ZXIgdGhlIHNtbXUgZXZlbnRx
IG92ZXJmbG93cy4gXl9e4oCm4oCmLgoKVGhlcmUgcmVhbGx5IHNob3VsZG4ndCBiZSBhbnkgcHJv
YmxlbSB3aXRoIHRoZSBldmVudHEuIEhhbmRsaW5nIHRoZQpldmVudCBvdmVyZmxvdyBpbiBteSBw
YXRjaCBpcyBtb3N0bHkgY29zbWV0aWMgYW5kIGNhbiBiZSByZW1vdmVkLiBTZWUKdGhlIEV2ZW50
IHF1ZXVlIG92ZXJmbG93IHNlY3Rpb24gb2YgdGhlIFNNTVV2MyBzcGVjaWZpY2F0aW9uIChJSEkw
MDcwQik6CgoiTm90ZTogSW4gdGVybXMgb2YgZGVsaXZlcmluZyBldmVudHMsIGEgcXVldWUgaW4g
YW4gdW5hY2tub3dsZWRnZWQKb3ZlcmZsb3cgc3RhdGUgZG9lcyBub3QgYmVoYXZlIGFueSBkaWZm
ZXJlbnRseSB0byBub3JtYWwgcXVldWUgc3RhdGUuIElmCnNvZnR3YXJlIHdlcmUgdG8gY29uc3Vt
ZSBldmVudHMgYW5kIGZyZWUgc3BhY2UgYnV0IGxlYXZlIG92ZXJmbG93CnVuYWNrbm93bGVkZ2Vk
LCBuZXcgZXZlbnRzIGNvdWxkIGJlIHJlY29yZGVkLiIKClRoYW5rcywKSmVhbgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
