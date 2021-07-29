Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E57C4338F
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 09:37:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D2861059
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 09:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 12D2861059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BB1FD403FE;
	Thu, 29 Jul 2021 09:37:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DMFTTtemdOWe; Thu, 29 Jul 2021 09:37:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1C00940361;
	Thu, 29 Jul 2021 09:37:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFB1EC0010;
	Thu, 29 Jul 2021 09:37:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 694B5C000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 09:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 46557838FE
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 09:37:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L6XoAXMeMyZr for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 09:37:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66C8183886
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 09:37:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7761D1FB;
 Thu, 29 Jul 2021 02:37:04 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B5533F73D;
 Thu, 29 Jul 2021 02:37:02 -0700 (PDT)
Subject: Re: [PATCH v2 18/24] iommu: Express DMA strictness via the domain type
To: Lu Baolu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <50bee17e9248ccfccb33a10238210d4ff4f4cf4d.1627468309.git.robin.murphy@arm.com>
 <b479f1f9-ecf2-2798-2df8-ae3d4c06bc63@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f2858a7f-e665-ff6a-38d6-b9d591287fac@arm.com>
Date: Thu, 29 Jul 2021 10:36:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <b479f1f9-ecf2-2798-2df8-ae3d4c06bc63@linux.intel.com>
Content-Language: en-GB
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

T24gMjAyMS0wNy0yOSAwODoxMywgTHUgQmFvbHUgd3JvdGU6Cj4gSGkgUm9iaW4sCj4gCj4gT24g
Ny8yOC8yMSAxMTo1OCBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pb21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+IGluZGV4IDk4MjU0
NTIzNGNmMy4uZWVjYjU2NTdkZTY5IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2lvbW11
LmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+IEBAIC0xMzYsNiArMTM2LDkgQEAg
c3RhdGljIGludCBfX2luaXQgaW9tbXVfc3Vic3lzX2luaXQodm9pZCkKPj4gwqDCoMKgwqDCoMKg
wqDCoMKgIH0KPj4gwqDCoMKgwqDCoCB9Cj4+ICvCoMKgwqAgaWYgKCFpb21tdV9kZWZhdWx0X3Bh
c3N0aHJvdWdoKCkgJiYgIWlvbW11X2RtYV9zdHJpY3QpCj4+ICvCoMKgwqDCoMKgwqDCoCBpb21t
dV9kZWZfZG9tYWluX3R5cGUgPSBJT01NVV9ET01BSU5fRE1BX0ZROwo+IAo+IGlvbW11X2RtYV9z
dHJpY3QgY291bGQgYmUgY2hhbmdlZCBsYXRlciBieSB0aGUgdmVuZG9yIGlvbW11IGRyaXZlciB2
aWEKPiBpb21tdV9zZXRfZG1hX3N0cmljdCgpLiBUaGlzIHNlZW1zIG5vdCB0byBiZSB0aGUgcmln
aHQgcGxhY2UgdG8gc2V0Cj4gaW9tbXVfZGVmX2RvbWFpbl90eXBlLgoKQWggeWVzLCBnb29kIGNh
dGNoIG9uY2UgYWdhaW4sIHRoYW5rcyEKCkkgdGhpbmsgdGhpcyAqaXMqIHRoZSByaWdodCBwbGFj
ZSB0byBpbml0aWFsbHkgc2V0IGl0IHRvIGhvbm91ciB0aGUgCmNvbW1hbmQtbGluZSBvcHRpb24s
IHNpbmNlIHRoYXQgbWF0Y2hlcyB3aGF0IHdlIGRvIGZvciBwYXNzdGhyb3VnaC4gCkhvd2V2ZXIg
YWxzbyBsaWtlIHBhc3N0aHJvdWdoIHdlJ2xsIG5lZWQgdG8ga2VlcCB0aGluZ3MgaW4gc3luYyBp
ZiBpdCdzIAp1cGRhdGVkIGxhdGVyLCBsaWtlIHRoaXM6CgoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwppbmRleCA4N2Q3YjI5OTQzNmUu
LjU5M2Q0NTU1YmM1NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5jCisrKyBiL2Ry
aXZlcnMvaW9tbXUvaW9tbXUuYwpAQCAtMzU5LDYgKzM1OSw4IEBAIGVhcmx5X3BhcmFtKCJpb21t
dS5zdHJpY3QiLCBpb21tdV9kbWFfc2V0dXApOwogIHZvaWQgaW9tbXVfc2V0X2RtYV9zdHJpY3Qo
dm9pZCkKICB7CiAgICAgICAgIGlvbW11X2RtYV9zdHJpY3QgPSB0cnVlOworICAgICAgIGlmIChp
b21tdV9kZWZfZG9tYWluX3R5cGUgPT0gSU9NTVVfRE9NQUlOX0RNQV9GUSkKKyAgICAgICAgICAg
ICAgIGlvbW11X2RlZl9kb21haW5fdHlwZSA9IElPTU1VX0RPTUFJTl9ETUE7CiAgfQoKICBzdGF0
aWMgc3NpemVfdCBpb21tdV9ncm91cF9hdHRyX3Nob3coc3RydWN0IGtvYmplY3QgKmtvYmosCgoK
RG9lcyB0aGF0IHNlZW0gcmVhc29uYWJsZT8gSSdtIG5vdCBzdXJlIHRoZXJlJ3MgYW55IGNsZWFu
ZXIgd2F5IHRvIGRvIGl0IApzaW5jZSB3ZSBkb24ndCB3YW50IHRvIGluYWR2ZXJ0ZW50bHkgY2xv
YmJlciB0aGUgZGVmYXVsdCB0eXBlIGlmIHRoZSAKdXNlciBoYXMgZ2l2ZW4gdXMgc29tZXRoaW5n
IGZ1bmt5IGxpa2UgImludGVsX2lvbW11PXN0cmljdCAKaW9tbXUucGFzc3Rocm91Z2g9MSIuCgpD
aGVlcnMsClJvYmluLgoKPiAKPj4gKwo+PiDCoMKgwqDCoMKgIHByX2luZm8oIkRlZmF1bHQgZG9t
YWluIHR5cGU6ICVzICVzXG4iLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfZG9tYWluX3R5
cGVfc3RyKGlvbW11X2RlZl9kb21haW5fdHlwZSksCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAoaW9t
bXVfY21kX2xpbmUgJiBJT01NVV9DTURfTElORV9ETUFfQVBJKSA/Cj4gCj4gQmVzdCByZWdhcmRz
LAo+IGJhb2x1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
