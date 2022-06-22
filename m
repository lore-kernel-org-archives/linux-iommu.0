Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FCDC43334
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 07:17:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BA9842438;
	Wed, 22 Jun 2022 07:17:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6BA9842438
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Ep67fiT4VQD; Wed, 22 Jun 2022 07:17:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 01CBB4243B;
	Wed, 22 Jun 2022 07:17:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 01CBB4243B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1F0DC0032;
	Wed, 22 Jun 2022 07:17:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27D2DC002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 07:17:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E1DD5400DD
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 07:17:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E1DD5400DD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X7EDSfDt3EUz for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 07:17:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C42F8403FF
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id C42F8403FF
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 07:17:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0413913D5;
 Wed, 22 Jun 2022 00:17:37 -0700 (PDT)
Received: from [10.57.85.1] (unknown [10.57.85.1])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC4353F66F;
 Wed, 22 Jun 2022 00:17:35 -0700 (PDT)
Message-ID: <bc4add1b-8b89-7989-5afb-df6b5338eb3d@arm.com>
Date: Wed, 22 Jun 2022 08:17:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/3] iommu: Clean up release_device checks
Content-Language: en-GB
To: Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org
References: <cover.1655822151.git.robin.murphy@arm.com>
 <02671dbfad7a3343fc25a44222350efcb455fe3c.1655822151.git.robin.murphy@arm.com>
 <59002dbd-d72a-4f9c-7ad8-808ee8d2ff05@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <59002dbd-d72a-4f9c-7ad8-808ee8d2ff05@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

T24gMjAyMi0wNi0yMiAwMjozNiwgQmFvbHUgTHUgd3JvdGU6Cj4gT24gMjAyMi82LzIxIDIzOjE0
LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IFNpbmNlIC5yZWxlYXNlX2RldmljZSBpcyBub3cgY2Fs
bGVkIHRocm91Z2ggcGVyLWRldmljZSBvcHMsIGFueSBjYWxsCj4+IHdoaWNoIGdldHMgYXMgZmFy
IGFzIGEgZHJpdmVyIGRlZmluaXRlbHkqaXMqwqAgZm9yIHRoYXQgZHJpdmVyLCBmb3IgYQo+PiBk
ZXZpY2Ugd2hpY2ggaGFzIHN1Y2Nlc3NmdWxseSBwYXNzZWQgLnByb2JlX2RldmljZSwgc28gYWxs
IHRoZSBjaGVja3MgdG8KPj4gdGhhdCBlZmZlY3QgYXJlIG5vdyByZWR1bmRhbnQgYW5kIGNhbiBi
ZSByZW1vdmVkLiBJbiB0aGUgc2FtZSB2ZWluIHdlCj4+IGNhbiBhbHNvIHNraXAgZnJlZWluZyBm
d3NwZWNzIHdoaWNoIGFyZSBub3cgbWFuYWdlZCBieSBjb3JlIGNvZGUuCj4gCj4gRG9lcyB0aGlz
IGRlcGVuZCBvbiBhbnkgb3RoZXIgc2VyaWVzPyBJIGRpZG4ndCBzZWUgaW9tbXVfZndzcGVjX2Zy
ZWUoKQo+IGNhbGxlZCBpbiB0aGUgY29yZSBjb2RlLiBPciBJIG1pc3NlZCBhbnl0aGluZz8KCmRl
dl9pb21tdV9mcmVlKCkgY2xlYW5zIHVwIHBhcmFtLT5md3NwZWMgZGlyZWN0bHkgKHNlZSBiNTQy
NDBhZDQ5NDMpLiAKRldJVyB0aGUgcGxhbiBpcyB0aGF0IGlvbW11X2Z3c3BlY19mcmVlKCkgc2hv
dWxkIGV2ZW50dWFsbHkgZ28gYXdheSAtIG9mIAp0aGUgcmVtYWluaW5nIHVzZXMgYWZ0ZXIgdGhp
cywgdHdvIGFyZSBpbiBmYWN0IHNpbWlsYXJseSByZWR1bmRhbnQgCmFscmVhZHksIHNpbmNlIHRo
ZXJlJ3MgYWxzbyBhIGRldl9pb21tdV9mcmVlKCkgaW4gdGhlIHByb2JlIGZhaWx1cmUgCnBhdGgs
IGFuZCB0aGUgb3RoZXIgdHdvIHNob3VsZCBkaXNhcHBlYXIgaW4gcGFydCAyIG9mIGZpeGluZyB0
aGUgYnVzIApwcm9iaW5nIG1lc3MgKHdoZXJlaW4gdGhlIG9mX3hsYXRlIHN0ZXAgZ2V0cyBwdWxs
ZWQgaW50byAKaW9tbXVfcHJvYmVfZGV2aWNlIGFzIHdlbGwsIGFuZCBmaW5hbGx5IHdvcmtzIGNv
cnJlY3RseSBhZ2FpbikuCgpDaGVlcnMsClJvYmluLgoKPiAKPj4KPj4gU2lnbmVkLW9mZi1ieTog
Um9iaW4gTXVycGh5PHJvYmluLm11cnBoeUBhcm0uY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9p
b21tdS9hcHBsZS1kYXJ0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAz
IC0tLQo+PiDCoCBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jIHzC
oCA4ICstLS0tLS0tCj4+IMKgIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LmPC
oMKgwqDCoMKgwqAgfCAxNCArKystLS0tLS0tLS0tLQo+PiDCoCBkcml2ZXJzL2lvbW11L2FybS9h
cm0tc21tdS9xY29tX2lvbW11LmPCoMKgwqDCoCB8IDExIC0tLS0tLS0tLS0tCj4+IMKgIGRyaXZl
cnMvaW9tbXUvZXh5bm9zLWlvbW11LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
IDMgLS0tCj4+IMKgIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDUgLS0tLS0KPj4gwqAgZHJpdmVycy9pb21tdS9tdGtfaW9t
bXVfdjEuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNSAtLS0tLQo+PiDCoCBk
cml2ZXJzL2lvbW11L3NwcmQtaW9tbXUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfCAxMSAtLS0tLS0tLS0tLQo+PiDCoCBkcml2ZXJzL2lvbW11L3ZpcnRpby1pb21tdS5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA4ICstLS0tLS0tCj4+IMKgIDkgZmlsZXMg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA2MyBkZWxldGlvbnMoLSkKPiAKPiBCZXN0IHJlZ2Fy
ZHMsCj4gYmFvbHUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
