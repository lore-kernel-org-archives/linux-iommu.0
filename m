Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DF8C07E96
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 08:53:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 847C161178
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 08:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847C161178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F07A42201;
	Thu, 15 Jul 2021 08:53:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5q1Mh86He2Hp; Thu, 15 Jul 2021 08:53:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 83BEA421F4;
	Thu, 15 Jul 2021 08:53:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BACAC0010;
	Thu, 15 Jul 2021 08:53:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 247F4C000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 08:53:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 18EAD606A6
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 08:53:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kJPrvIS9e8OF for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 08:53:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD3236067C
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 08:53:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C94036D;
 Thu, 15 Jul 2021 01:53:27 -0700 (PDT)
Received: from [10.57.36.240] (unknown [10.57.36.240])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E48213F774;
 Thu, 15 Jul 2021 01:53:26 -0700 (PDT)
Subject: Re: [PATCH] iommu: Unify iova_to_phys for identity domains
To: Lu Baolu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org
References: <e701030cbf91b441f60d2d6788885f679317fad6.1626283714.git.robin.murphy@arm.com>
 <eaa44be7-5c83-6d11-5efb-5ba4707b683b@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3c03a3f1-5c9c-be2f-e3bc-9487d662d4f9@arm.com>
Date: Thu, 15 Jul 2021 09:53:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <eaa44be7-5c83-6d11-5efb-5ba4707b683b@linux.intel.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMjAyMS0wNy0xNSAwMjozOCwgTHUgQmFvbHUgd3JvdGU6Cj4gT24gNy8xNS8yMSAxOjI4IEFN
LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IElmIHBlb3BsZSBhcmUgZ29pbmcgdG8gaW5zaXN0IG9u
IGNhbGxpbmcgaW9tbXVfaW92YV90b19waHlzKCkKPj4gcG9pbnRsZXNzbHkgYW5kIGV4cGVjdGlu
ZyBpdCB0byB3b3JrLCB3ZSBjYW4gYXQgbGVhc3QgZG8gb3Vyc2VsdmVzIGEKPj4gZmF2b3VyIGJ5
IGhhbmRsaW5nIHRob3NlIGNhc2VzIGluIHRoZSBjb3JlIGNvZGUsIHJhdGhlciB0aGFuIHJlcGVh
dGVkbHkKPj4gYWNyb3NzIGFuIGluY29uc2lzdGVudCBoYW5kZnVsIG9mIGRyaXZlcnMuCj4+Cj4+
IFNpZ25lZC1vZmYtYnk6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+Cj4+IC0t
LQo+PiDCoCBkcml2ZXJzL2lvbW11L2FtZC9pb19wZ3RhYmxlLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8IDMgLS0tCj4+IMKgIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1z
bW11LXYzLmMgfCAzIC0tLQo+PiDCoCBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21t
dS5jwqDCoMKgwqDCoMKgIHwgMyAtLS0KPj4gwqAgZHJpdmVycy9pb21tdS9pb21tdS5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA2ICsrKysrLQo+PiDCoCA0
IGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCj4+Cj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FtZC9pb19wZ3RhYmxlLmMgCj4+IGIvZHJpdmVycy9p
b21tdS9hbWQvaW9fcGd0YWJsZS5jCj4+IGluZGV4IGJiMGVlNWM5ZmRlNy4uMTgyYzkzYTQzZWZk
IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2FtZC9pb19wZ3RhYmxlLmMKPj4gKysrIGIv
ZHJpdmVycy9pb21tdS9hbWQvaW9fcGd0YWJsZS5jCj4+IEBAIC00OTMsOSArNDkzLDYgQEAgc3Rh
dGljIHBoeXNfYWRkcl90IGlvbW11X3YxX2lvdmFfdG9fcGh5cyhzdHJ1Y3QgCj4+IGlvX3BndGFi
bGVfb3BzICpvcHMsIHVuc2lnbmVkIGxvCj4+IMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBvZmZz
ZXRfbWFzaywgcHRlX3Bnc2l6ZTsKPj4gwqDCoMKgwqDCoCB1NjQgKnB0ZSwgX19wdGU7Cj4+IC3C
oMKgwqAgaWYgKHBndGFibGUtPm1vZGUgPT0gUEFHRV9NT0RFX05PTkUpCj4+IC3CoMKgwqDCoMKg
wqDCoCByZXR1cm4gaW92YTsKPj4gLQo+PiDCoMKgwqDCoMKgIHB0ZSA9IGZldGNoX3B0ZShwZ3Rh
YmxlLCBpb3ZhLCAmcHRlX3Bnc2l6ZSk7Cj4+IMKgwqDCoMKgwqAgaWYgKCFwdGUgfHwgIUlPTU1V
X1BURV9QUkVTRU5UKCpwdGUpKQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJt
LXNtbXUtdjMvYXJtLXNtbXUtdjMuYyAKPj4gYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12
My9hcm0tc21tdS12My5jCj4+IGluZGV4IDNlODdhOWNmNmRhMy4uYzlmZGQwZDA5N2JlIDEwMDY0
NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jCj4+
ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMKPj4gQEAg
LTI0ODEsOSArMjQ4MSw2IEBAIGFybV9zbW11X2lvdmFfdG9fcGh5cyhzdHJ1Y3QgaW9tbXVfZG9t
YWluIAo+PiAqZG9tYWluLCBkbWFfYWRkcl90IGlvdmEpCj4+IMKgIHsKPj4gwqDCoMKgwqDCoCBz
dHJ1Y3QgaW9fcGd0YWJsZV9vcHMgKm9wcyA9IHRvX3NtbXVfZG9tYWluKGRvbWFpbiktPnBndGJs
X29wczsKPj4gLcKgwqDCoCBpZiAoZG9tYWluLT50eXBlID09IElPTU1VX0RPTUFJTl9JREVOVElU
WSkKPj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiBpb3ZhOwo+PiAtCj4+IMKgwqDCoMKgwqAgaWYg
KCFvcHMpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LmMgCj4+IGIvZHJpdmVycy9pb21tdS9h
cm0vYXJtLXNtbXUvYXJtLXNtbXUuYwo+PiBpbmRleCAwZjE4MWY3NmMzMWIuLjBkMDRlYWZhM2Zk
YiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuYwo+
PiArKysgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jCj4+IEBAIC0xMzE3
LDkgKzEzMTcsNiBAQCBzdGF0aWMgcGh5c19hZGRyX3QgYXJtX3NtbXVfaW92YV90b19waHlzKHN0
cnVjdCAKPj4gaW9tbXVfZG9tYWluICpkb21haW4sCj4+IMKgwqDCoMKgwqAgc3RydWN0IGFybV9z
bW11X2RvbWFpbiAqc21tdV9kb21haW4gPSB0b19zbW11X2RvbWFpbihkb21haW4pOwo+PiDCoMKg
wqDCoMKgIHN0cnVjdCBpb19wZ3RhYmxlX29wcyAqb3BzID0gc21tdV9kb21haW4tPnBndGJsX29w
czsKPj4gLcKgwqDCoCBpZiAoZG9tYWluLT50eXBlID09IElPTU1VX0RPTUFJTl9JREVOVElUWSkK
Pj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiBpb3ZhOwo+PiAtCj4+IMKgwqDCoMKgwqAgaWYgKCFv
cHMpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW9tbXUvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+PiBpbmRleCA0M2EyMDQx
ZDk2MjkuLjdjMTZmOTc3YjVhNiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5j
Cj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+PiBAQCAtMjM3MSw3ICsyMzcxLDExIEBA
IEVYUE9SVF9TWU1CT0xfR1BMKGlvbW11X2RldGFjaF9ncm91cCk7Cj4+IMKgIHBoeXNfYWRkcl90
IGlvbW11X2lvdmFfdG9fcGh5cyhzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sIAo+PiBkbWFf
YWRkcl90IGlvdmEpCj4+IMKgIHsKPj4gLcKgwqDCoCBpZiAodW5saWtlbHkoZG9tYWluLT5vcHMt
PmlvdmFfdG9fcGh5cyA9PSBOVUxMKSkKPj4gK8KgwqDCoCBpZiAoZG9tYWluLT50eXBlID09IElP
TU1VX0RPTUFJTl9JREVOVElUWSkKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBpb3ZhOwo+PiAr
Cj4+ICvCoMKgwqAgaWYgKHVubGlrZWx5KGRvbWFpbi0+b3BzLT5pb3ZhX3RvX3BoeXMgPT0gTlVM
TCkgfHwKPj4gK8KgwqDCoMKgwqDCoMKgIGRvbWFpbi0+dHlwZSA9PSBJT01NVV9ET01BSU5fQkxP
Q0tFRCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+IAo+IE5pdDoKPiBMb2dpY2Fs
bHkgd2Ugb25seSBuZWVkcyBvcHMtPmlvdmFfdG9fcGh5cyBmb3IgRE1BIGFuZCBVTk1BTkFHRUQg
ZG9tYWlucywKPiBzbyBpdCBsb29rcyBiZXR0ZXIgaWYgd2UgaGF2ZQo+IAo+ICDCoMKgwqDCoGlm
IChkb21haW4tPnR5cGUgPT0gSU9NTVVfRE9NQUlOX0JMT0NLRUQgfHwKPiAgwqDCoMKgwqDCoMKg
wqAgdW5saWtlbHkoZG9tYWluLT5vcHMtPmlvdmFfdG9fcGh5cyA9PSBOVUxMKSkKPiAgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIDA7CgpZZWFoLCBJIHB1dCBJT01NVV9ET01BSU5fQkxPQ0tFRCBsYXN0
IGFzIHRoZSBsZWFzdCBsaWtlbHkgY29uZGl0aW9uIApzaW5jZSBpdCdzIHJlYWxseSBqdXN0IGZv
ciBjb21wbGV0ZW5lc3MgLSBJIGRvbid0IHRoaW5rIGl0J3MgcG9zc2libGUgdG8gCnNlZSBpdCBs
ZWdpdGltYXRlbHkgdXNlZCBhdCB0aGUgbW9tZW50IC0gYnV0IG9uIHNlY29uZCBsb29rIEkgdGhp
bmsgCm9wcy0+aW92YV90b19waHlzID09IE5VTEwgaXMgZXF1YWxseSB0aGVvcmV0aWNhbCBub3cs
IHNvIG1heWJlIEkgY291bGQgCmJlIHJlbW92aW5nIHRoYXQgYW5kIHdlIGp1c3QgbWFrZSBpdCBt
YW5kYXRvcnkgZm9yIGFueSBuZXcgZHJpdmVycz8KCj4gQW55d2F5LAo+IAo+IFJldmlld2VkLWJ5
OiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPgoKVGhhbmtzIQoKUm9iaW4uCgo+
IAo+IEJlc3QgcmVnYXJkcywKPiBiYW9sdQo+IAo+PiDCoMKgwqDCoMKgIHJldHVybiBkb21haW4t
Pm9wcy0+aW92YV90b19waHlzKGRvbWFpbiwgaW92YSk7Cj4+Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
