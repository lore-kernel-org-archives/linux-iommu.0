Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C78CC433EF
	for <iommu@archiver.kernel.org>; Mon, 18 Apr 2022 22:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD11F60E0A;
	Mon, 18 Apr 2022 22:09:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gsvhCe4tuNPU; Mon, 18 Apr 2022 22:09:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9779960ABB;
	Mon, 18 Apr 2022 22:09:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 741D9C002F;
	Mon, 18 Apr 2022 22:09:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8663C002C
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 22:09:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F17960ABB
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 22:09:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EeaBA4M793Rm for <iommu@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 22:09:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id DED876064D
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 22:09:43 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD81D1042;
 Mon, 18 Apr 2022 15:09:42 -0700 (PDT)
Received: from [10.57.41.251] (unknown [10.57.41.251])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A92383F766;
 Mon, 18 Apr 2022 15:09:39 -0700 (PDT)
Message-ID: <1d9a2146-9e48-ba97-d049-5d2332ebbd3a@arm.com>
Date: Mon, 18 Apr 2022 23:09:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 02/13] iommu: Move bus setup to IOMMU device registration
Content-Language: en-GB
To: Lu Baolu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org
References: <cover.1649935679.git.robin.murphy@arm.com>
 <e607a32be8e84c56d65160902f4bd3fb434ee9d3.1649935679.git.robin.murphy@arm.com>
 <d838c7f8-2d31-2327-9b4d-c05b06a516bb@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <d838c7f8-2d31-2327-9b4d-c05b06a516bb@linux.intel.com>
Cc: jean-philippe@linaro.org, zhang.lyra@gmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
 gerald.schaefer@linux.ibm.com
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

T24gMjAyMi0wNC0xNiAwMTowNCwgTHUgQmFvbHUgd3JvdGU6Cj4gT24gMjAyMi80LzE0IDIwOjQy
LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IEBAIC0xODgzLDI3ICsxOTAwLDEyIEBAIHN0YXRpYyBp
bnQgaW9tbXVfYnVzX2luaXQoc3RydWN0IGJ1c190eXBlICpidXMpCj4+IMKgwqAgKi8KPj4gwqAg
aW50IGJ1c19zZXRfaW9tbXUoc3RydWN0IGJ1c190eXBlICpidXMsIGNvbnN0IHN0cnVjdCBpb21t
dV9vcHMgKm9wcykKPj4gwqAgewo+PiAtwqDCoMKgIGludCBlcnI7Cj4+IC0KPj4gLcKgwqDCoCBp
ZiAob3BzID09IE5VTEwpIHsKPj4gLcKgwqDCoMKgwqDCoMKgIGJ1cy0+aW9tbXVfb3BzID0gTlVM
TDsKPj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+PiAtwqDCoMKgIH0KPj4gLQo+PiAtwqDC
oMKgIGlmIChidXMtPmlvbW11X29wcyAhPSBOVUxMKQo+PiArwqDCoMKgIGlmIChidXMtPmlvbW11
X29wcyAmJiBvcHMgJiYgYnVzLT5pb21tdV9vcHMgIT0gb3BzKQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIC1FQlVTWTsKPj4gwqDCoMKgwqDCoCBidXMtPmlvbW11X29wcyA9IG9wczsKPiAK
PiBEbyB3ZSBzdGlsbCBuZWVkIHRvIGtlZXAgYWJvdmUgbGluZXMgaW4gYnVzX3NldF9pb21tdSgp
PwoKSXQgcHJlc2VydmVzIHRoZSBleGlzdGluZyBiZWhhdmlvdXIgdW50aWwgZWFjaCBjYWxsc2l0
ZSBhbmQgaXRzIAphc3NvY2lhdGVkIGVycm9yIGhhbmRsaW5nIGFyZSByZW1vdmVkIGxhdGVyIG9u
LCB3aGljaCBzZWVtcyBsaWtlIGFzIGdvb2QgCmEgdGhpbmcgdG8gZG8gYXMgYW55LiBTaW5jZSBJ
J20gYWxyZWFkeSByZWxheGluZyBpb21tdV9kZXZpY2VfcmVnaXN0ZXIoKSAKdG8gYSB3YXJuLWJ1
dC1jb250aW51ZSBiZWhhdmlvdXIgd2hpbGUgaXQga2VlcHMgdGhlIGJ1cyBvcHMgb24gCmxpZmUt
c3VwcG9ydCBpbnRlcm5hbGx5LCBJIGZpZ3VyZWQgbm90IGNoYW5naW5nIHRvbyBtdWNoIGF0IG9u
Y2Ugd291bGQgCm1ha2UgaXQgZWFzaWVyIHRvIGJpc2VjdCBhbnkgcG90ZW50aWFsIGlzc3VlcyBh
cmlzaW5nIGZyb20gdGhpcyBmaXJzdCBzdGVwLgoKVGhhbmtzLApSb2Jpbi4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
