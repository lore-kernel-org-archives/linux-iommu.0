Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08C1C43334
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 10:54:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 381A0404F6;
	Wed,  6 Jul 2022 10:54:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 381A0404F6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9VLlTy-J03tU; Wed,  6 Jul 2022 10:54:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 13D414015F;
	Wed,  6 Jul 2022 10:54:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 13D414015F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E92C3C0033;
	Wed,  6 Jul 2022 10:54:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44FA3C002D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 10:54:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0FE1A60F58
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 10:54:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0FE1A60F58
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wlu5lBzVu1Ln for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 10:54:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8AEC60D53
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id C8AEC60D53
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 10:54:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68C5E1042;
 Wed,  6 Jul 2022 03:54:39 -0700 (PDT)
Received: from [10.57.86.2] (unknown [10.57.86.2])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD69B3F66F;
 Wed,  6 Jul 2022 03:54:36 -0700 (PDT)
Message-ID: <8915e679-71b2-eef4-88d5-127bcc6cf990@arm.com>
Date: Wed, 6 Jul 2022 11:54:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 09/14] iommu/ipmmu-vmsa: Clean up bus_set_iommu()
Content-Language: en-GB
To: Alexey Kardashevskiy <aik@ozlabs.ru>, joro@8bytes.org, will@kernel.org
References: <cover.1650890638.git.robin.murphy@arm.com>
 <01a58dcc9c70836b7556d54dbdac6a340f206781.1650890638.git.robin.murphy@arm.com>
 <aef1d470-e8a0-4ba8-2a55-adf05b836684@ozlabs.ru>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <aef1d470-e8a0-4ba8-2a55-adf05b836684@ozlabs.ru>
Cc: jean-philippe@linaro.org, zhang.lyra@gmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, gerald.schaefer@linux.ibm.com,
 linux-arm-kernel@lists.infradead.org
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

T24gMjAyMi0wNy0wNiAwOTozOCwgQWxleGV5IEthcmRhc2hldnNraXkgd3JvdGU6Cj4gCj4gCj4g
T24gMjgvMDQvMjAyMiAyMzoxOCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiBTdG9wIGNhbGxpbmcg
YnVzX3NldF9pb21tdSgpIHNpbmNlIGl0J3Mgbm93IHVubmVjZXNzYXJ5LiBUaGlzIGFsc28KPj4g
bGVhdmVzIHRoZSBjdXN0b20gaW5pdGNhbGwgZWZmZWN0aXZlbHkgZG9pbmcgbm90aGluZyBidXQg
cmVnaXN0ZXIKPj4gdGhlIGRyaXZlciwgd2hpY2ggbm8gbG9uZ2VyIG5lZWRzIHRvIGhhcHBlbiBl
YXJseSBlaXRoZXIsIHNvIGNvbnZlcnQKPj4gaXQgdG8gYnVpbHRpbl9wbGF0Zm9ybV9kcml2ZXIo
KS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNv
bT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvaW9tbXUvaXBtbXUtdm1zYS5jIHwgMzUgKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAzNCBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUv
aXBtbXUtdm1zYS5jIGIvZHJpdmVycy9pb21tdS9pcG1tdS12bXNhLmMKPj4gaW5kZXggOGZkYjg0
YjM2NDJiLi4yNTQ5ZDMyZjBkZGQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaXBtbXUt
dm1zYS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaXBtbXUtdm1zYS5jCj4+IEBAIC0xMDkwLDEx
ICsxMDkwLDYgQEAgc3RhdGljIGludCBpcG1tdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
IAo+PiAqcGRldikKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IGlvbW11X2RldmljZV9yZWdp
c3RlcigmbW11LT5pb21tdSwgJmlwbW11X29wcywgCj4+ICZwZGV2LT5kZXYpOwo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKHJldCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IHJldDsKPj4gLQo+PiAtI2lmIGRlZmluZWQoQ09ORklHX0lPTU1VX0RNQSkKPj4gLcKgwqDCoMKg
wqDCoMKgIGlmICghaW9tbXVfcHJlc2VudCgmcGxhdGZvcm1fYnVzX3R5cGUpKQo+PiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBidXNfc2V0X2lvbW11KCZwbGF0Zm9ybV9idXNfdHlwZSwgJmlwbW11
X29wcyk7Cj4+IC0jZW5kaWYKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgwqDCoMKgwqAgLyoKPiAKPiBU
aGUgY29tbWVudCB3aGljaCBzdGFydHMgaGVyZSBkaWQgbm90IG1ha2UgaXQgdG8gdGhlIHBhdGNo
IGJ1dCBpdCBzaG91bGQgCj4gaGF2ZSBhcyBpdCBtZW50aW9ucyBidXNfc2V0X2lvbW11KCkgd2hp
Y2ggaXMgZ29uZSBieSB0aGUgZW5kIG9mIHRoZSBzZXJpZXMuCgpIZWgsIGJ1c3RlZCEgSW4gZmFj
dCBJIHRoaW5rIHRoZSB3aG9sZSBwb2ludCBvZiB0aGF0IGNvbW1lbnQgc3RvcHMgYmVpbmcgCnRy
dWUsIGJ1dCBJIGNvdWxkbid0IGJlIGJvdGhlcmVkIHRvIHJlYXNvbiBhYm91dCBpdCBzaW5jZSBv
bmUgb2YgdGhlIApuZXh0IHN0ZXBzIGFmdGVyIHRoaXMgaXMgdG8gc3RhcnQgcmlwcGluZyBhbGwg
dGhlIGFybV9pb21tdV8qIHN0dWZmIG91dCAKYW55d2F5LgoKPiBNb3JlIGdlbmVyYWwgcXVlc3Rp
b24vcmVxdWVzdCAtIGNvdWxkIHlvdSBwbGVhc2UgaW5jbHVkZSB0aGUgZXhhY3Qgc2hhMSAKPiB0
aGUgcGF0Y2hzZXQgaXMgYmFzZWQgb24/IEl0IGRpZCBub3QgYXBwbHkgdG8gYW55IGN1cnJlbnQg
dHJlZXMgYW5kIAo+IHdoaWxlIGl0IHdhcyB0cml2aWFsLCBpdCB3YXMgc2xpZ2h0bHkgYW5ub3lp
bmcgdG8gcmVzb2x2ZSB0aGUgY29uZmxpY3RzIAo+IDopwqAgVGhhbmtzLAoKdjMgaXMgYmFzZWQg
ZGlyZWN0bHkgb24gNS4xOS1yYzM6CgpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL2NvdmVy
LjE2NTcwMzQ4MjcuZ2l0LnJvYmluLm11cnBoeUBhcm0uY29tLwoKQW5kIGlmIGl0IGhlbHBzIEkg
aGF2ZSBpdCBvbiBhIGJyYW5jaCBoZXJlIGFzIHdlbGw6CgpodHRwczovL2dpdGxhYi5hcm0uY29t
L2xpbnV4LWFybS9saW51eC1ybS8tL3RyZWUvYnVzLXNldC1pb21tdS12MwoKUm9iaW4uCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
