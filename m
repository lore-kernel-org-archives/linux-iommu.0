Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89787CCA47C
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 15:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0917760E13;
	Wed, 29 Jun 2022 15:39:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0917760E13
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=fcBq3BeN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PZ-yP4h1cP2k; Wed, 29 Jun 2022 15:39:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7E66460601;
	Wed, 29 Jun 2022 15:39:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E66460601
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 556DCC0039;
	Wed, 29 Jun 2022 15:39:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9FD5C002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 15:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 95D2740157
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 15:39:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 95D2740157
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com
 header.a=rsa-sha256 header.s=20200525 header.b=fcBq3BeN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NnTRRpyYxioP for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 15:39:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E0058400BB
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E0058400BB
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 15:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=O0wtNrY7uERkcVmDzn9Qzn0QOjEuS076HETf2WzjME4=; b=fcBq3BeNtwnbwtK5Y2Ik7xDHNX
 R2UXfuLGRfqLKYw2O//6lyhArxbX+eYSq7C1KjshVcSK35zRKyY1/m5BoX90BANeJxKsWQHWzpJfH
 RLRIfLr01lR+my9+2IpdU/iMUoeB9400EApUEEHjJe6aaYg5O0DxWTZXa/RxPY1IK4XGp8wIPTO+B
 n0noULDLnowj1XntvqsDZQQRPCkqagswEtT4sxIgVQ1daNBO6u/6PpMAZgin/duxNTYcVdNOEKaTU
 0nCYR6bUVRS/Ok2+w20mNj06bY59NCDNF5cCXwNLFbRetVx9eUzGy9o9+U3YM2hjMTGWYbrJXVGen
 0sKA+1AQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10]) by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <logang@deltatee.com>)
 id 1o6Zmm-002RkM-SQ; Wed, 29 Jun 2022 09:39:25 -0600
Message-ID: <c42b5ee3-5d4f-7e44-8885-26b8417208ae@deltatee.com>
Date: Wed, 29 Jun 2022 09:39:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-CA
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-2-logang@deltatee.com>
 <b56d9b93-c59f-5764-e599-d9718edb42d3@arm.com>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <b56d9b93-c59f-5764-e599-d9718edb42d3@arm.com>
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com,
 jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org,
 daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net,
 dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org,
 ira.weiny@intel.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com,
 rcampbell@nvidia.com, kch@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v7 01/21] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>, Xiong Jianxin <jianxin.xiong@intel.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgoKT24gMjAyMi0wNi0yOSAwMzowNSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjItMDYt
MTUgMTc6MTIsIExvZ2FuIEd1bnRob3JwZSB3cm90ZToKPj4gTWFrZSB1c2Ugb2YgdGhlIHRoaXJk
IGZyZWUgTFNCIGluIHNjYXR0ZXJsaXN0J3MgcGFnZV9saW5rIG9uIDY0Yml0Cj4+IHN5c3RlbXMu
Cj4+Cj4+IFRoZSBleHRyYSBiaXQgd2lsbCBiZSB1c2VkIGJ5IGRtYV9bdW5dbWFwX3NnX3AycGRt
YSgpIHRvIGRldGVybWluZSB3aGVuIGEKPj4gZ2l2ZW4gU0dMIHNlZ21lbnRzIGRtYV9hZGRyZXNz
IHBvaW50cyB0byBhIFBDSSBidXMgYWRkcmVzcy4KPj4gZG1hX3VubWFwX3NnX3AycGRtYSgpIHdp
bGwgbmVlZCB0byBwZXJmb3JtIGRpZmZlcmVudCBjbGVhbnVwIHdoZW4gYQo+PiBzZWdtZW50IGlz
IG1hcmtlZCBhcyBhIGJ1cyBhZGRyZXNzLgo+Pgo+PiBUaGUgbmV3IGJpdCB3aWxsIG9ubHkgYmUg
dXNlZCB3aGVuIENPTkZJR19QQ0lfUDJQRE1BIGlzIHNldDsgdGhpcyBtZWFucwo+PiBQQ0kgUDJQ
RE1BIHdpbGwgcmVxdWlyZSBDT05GSUdfNjRCSVQuIFRoaXMgc2hvdWxkIGJlIGFjY2VwdGFibGUg
YXMgdGhlCj4+IG1ham9yaXR5IG9mIFAyUERNQSB1c2UgY2FzZXMgYXJlIHJlc3RyaWN0ZWQgdG8g
bmV3ZXIgcm9vdCBjb21wbGV4ZXMgYW5kCj4+IHJvdWdobHkgcmVxdWlyZSB0aGUgZXh0cmEgYWRk
cmVzcyBzcGFjZSBmb3IgbWVtb3J5IEJBUnMgdXNlZCBpbiB0aGUKPj4gdHJhbnNhY3Rpb25zLgo+
Pgo+PiBTaWduZWQtb2ZmLWJ5OiBMb2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5jb20+
Cj4+IFJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPgo+PiAt
LS0KPj4gwqAgZHJpdmVycy9wY2kvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqAgfMKgIDUgKysrKysK
Pj4gwqAgaW5jbHVkZS9saW51eC9zY2F0dGVybGlzdC5oIHwgNDQgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLQo+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL0tjb25maWcg
Yi9kcml2ZXJzL3BjaS9LY29uZmlnCj4+IGluZGV4IDEzM2M3MzIwNzc4Mi4uNWNjN2NiYTE5NDFm
IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3BjaS9LY29uZmlnCj4+ICsrKyBiL2RyaXZlcnMvcGNp
L0tjb25maWcKPj4gQEAgLTE2NCw2ICsxNjQsMTEgQEAgY29uZmlnIFBDSV9QQVNJRAo+PiDCoCBj
b25maWcgUENJX1AyUERNQQo+PiDCoMKgwqDCoMKgIGJvb2wgIlBDSSBwZWVyLXRvLXBlZXIgdHJh
bnNmZXIgc3VwcG9ydCIKPj4gwqDCoMKgwqDCoCBkZXBlbmRzIG9uIFpPTkVfREVWSUNFCj4+ICvC
oMKgwqAgIwo+PiArwqDCoMKgICMgVGhlIG5lZWQgZm9yIHRoZSBzY2F0dGVybGlzdCBETUEgYnVz
IGFkZHJlc3MgZmxhZyBtZWFucyBQQ0kgUDJQRE1BCj4+ICvCoMKgwqAgIyByZXF1aXJlcyA2NGJp
dAo+PiArwqDCoMKgICMKPj4gK8KgwqDCoCBkZXBlbmRzIG9uIDY0QklUCj4+IMKgwqDCoMKgwqAg
c2VsZWN0IEdFTkVSSUNfQUxMT0NBVE9SCj4+IMKgwqDCoMKgwqAgaGVscAo+PiDCoMKgwqDCoMKg
wqDCoCBFbmFibGXRlSBkcml2ZXJzIHRvIGRvIFBDSSBwZWVyLXRvLXBlZXIgdHJhbnNhY3Rpb25z
IHRvIGFuZCBmcm9tCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0Lmgg
Yi9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmgKPj4gaW5kZXggN2ZmOWQ2Mzg2YzEyLi42NTYx
Y2E4YWVhZDggMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgvc2NhdHRlcmxpc3QuaAo+PiAr
KysgYi9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmgKPj4gQEAgLTY0LDEyICs2NCwyNCBAQCBz
dHJ1Y3Qgc2dfYXBwZW5kX3RhYmxlIHsKPj4gwqAgI2RlZmluZSBTR19DSEFJTsKgwqDCoCAweDAx
VUwKPj4gwqAgI2RlZmluZSBTR19FTkTCoMKgwqDCoMKgwqDCoCAweDAyVUwKPj4gwqAgKy8qCj4+
ICsgKiBiaXQgMiBpcyB0aGUgdGhpcmQgZnJlZSBiaXQgaW4gdGhlIHBhZ2VfbGluayBvbiA2NGJp
dCBzeXN0ZW1zIHdoaWNoCj4+ICsgKiBpcyB1c2VkIGJ5IGRtYV91bm1hcF9zZygpIHRvIGRldGVy
bWluZSBpZiB0aGUgZG1hX2FkZHJlc3MgaXMgYQo+PiArICogYnVzIGFkZHJlc3Mgd2hlbiBkb2lu
ZyBQMlBETUEuCj4+ICsgKi8KPj4gKyNpZmRlZiBDT05GSUdfUENJX1AyUERNQQo+PiArI2RlZmlu
ZSBTR19ETUFfQlVTX0FERFJFU1PCoMKgwqAgMHgwNFVMCj4+ICtzdGF0aWNfYXNzZXJ0KF9fYWxp
Z25vZl9fKHN0cnVjdCBwYWdlKSA+PSA4KTsKPj4gKyNlbHNlCj4+ICsjZGVmaW5lIFNHX0RNQV9C
VVNfQUREUkVTU8KgwqDCoCAweDAwVUwKPj4gKyNlbmRpZgo+PiArCj4+IMKgIC8qCj4+IMKgwqAg
KiBXZSBvdmVybG9hZCB0aGUgTFNCIG9mIHRoZSBwYWdlIHBvaW50ZXIgdG8gaW5kaWNhdGUgd2hl
dGhlciBpdCdzCj4+IMKgwqAgKiBhIHZhbGlkIHNnIGVudHJ5LCBvciB3aGV0aGVyIGl0IHBvaW50
cyB0byB0aGUgc3RhcnQgb2YgYSBuZXcKPj4gc2NhdHRlcmxpc3QuCj4+IMKgwqAgKiBUaG9zZSBs
b3cgYml0cyBhcmUgdGhlcmUgZm9yIGV2ZXJ5b25lISAodGhhbmtzIG1hc29uIDotKQo+PiDCoMKg
ICovCj4+IC0jZGVmaW5lIFNHX1BBR0VfTElOS19NQVNLIChTR19DSEFJTiB8IFNHX0VORCkKPj4g
KyNkZWZpbmUgU0dfUEFHRV9MSU5LX01BU0sgKFNHX0NIQUlOIHwgU0dfRU5EIHwgU0dfRE1BX0JV
U19BRERSRVNTKQo+PiDCoCDCoCBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBfX3NnX2ZsYWdz
KHN0cnVjdCBzY2F0dGVybGlzdCAqc2cpCj4+IMKgIHsKPj4gQEAgLTkxLDYgKzEwMywxMSBAQCBz
dGF0aWMgaW5saW5lIGJvb2wgc2dfaXNfbGFzdChzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnKQo+PiDC
oMKgwqDCoMKgIHJldHVybiBfX3NnX2ZsYWdzKHNnKSAmIFNHX0VORDsKPj4gwqAgfQo+PiDCoCAr
c3RhdGljIGlubGluZSBib29sIHNnX2lzX2RtYV9idXNfYWRkcmVzcyhzdHJ1Y3Qgc2NhdHRlcmxp
c3QgKnNnKQo+PiArewo+PiArwqDCoMKgIHJldHVybiBfX3NnX2ZsYWdzKHNnKSAmIFNHX0RNQV9C
VVNfQUREUkVTUzsKPj4gK30KPj4gKwo+PiDCoCAvKioKPj4gwqDCoCAqIHNnX2Fzc2lnbl9wYWdl
IC0gQXNzaWduIGEgZ2l2ZW4gcGFnZSB0byBhbiBTRyBlbnRyeQo+PiDCoMKgICogQHNnOsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgU0cgZW50cnkKPj4gQEAgLTI0NSw2ICsyNjIsMzEgQEAgc3RhdGlj
IGlubGluZSB2b2lkIHNnX3VubWFya19lbmQoc3RydWN0Cj4+IHNjYXR0ZXJsaXN0ICpzZykKPj4g
wqDCoMKgwqDCoCBzZy0+cGFnZV9saW5rICY9IH5TR19FTkQ7Cj4+IMKgIH0KPj4gwqAgKy8qKgo+
PiArICogc2dfZG1hX21hcmtfYnVzIGFkZHJlc3MgLSBNYXJrIHRoZSBzY2F0dGVybGlzdCBlbnRy
eSBhcyBhIGJ1cyBhZGRyZXNzCj4+ICsgKiBAc2c6wqDCoMKgwqDCoMKgwqDCoCBTRyBlbnRyeVNj
YXR0ZXJsaXN0Cj4gCj4gZW50cnlTY2F0dGVybGlzdD8KPiAKPj4gKyAqCj4+ICsgKiBEZXNjcmlw
dGlvbjoKPj4gKyAqwqDCoCBNYXJrcyB0aGUgcGFzc2VkIGluIHNnIGVudHJ5IHRvIGluZGljYXRl
IHRoYXQgdGhlIGRtYV9hZGRyZXNzIGlzCj4+ICsgKsKgwqAgYSBidXMgYWRkcmVzcyBhbmQgZG9l
c24ndCBuZWVkIHRvIGJlIHVubWFwcGVkLgo+PiArICoqLwo+PiArc3RhdGljIGlubGluZSB2b2lk
IHNnX2RtYV9tYXJrX2J1c19hZGRyZXNzKHN0cnVjdCBzY2F0dGVybGlzdCAqc2cpCj4+ICt7Cj4+
ICvCoMKgwqAgc2ctPnBhZ2VfbGluayB8PSBTR19ETUFfQlVTX0FERFJFU1M7Cj4+ICt9Cj4+ICsK
Pj4gKy8qKgo+PiArICogc2dfdW5tYXJrX3BjaV9wMnBkbWEgLSBVbm1hcmsgdGhlIHNjYXR0ZXJs
aXN0IGVudHJ5IGFzIGEgYnVzIGFkZHJlc3MKPj4gKyAqIEBzZzrCoMKgwqDCoMKgwqDCoMKgIFNH
IGVudHJ5U2NhdHRlcmxpc3QKPj4gKyAqCj4+ICsgKiBEZXNjcmlwdGlvbjoKPj4gKyAqwqDCoCBD
bGVhcnMgdGhlIGJ1cyBhZGRyZXNzIG1hcmsuCj4+ICsgKiovCj4+ICtzdGF0aWMgaW5saW5lIHZv
aWQgc2dfZG1hX3VubWFya19idXNfYWRkcmVzcyhzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnKQo+PiAr
ewo+PiArwqDCoMKgIHNnLT5wYWdlX2xpbmsgJj0gflNHX0RNQV9CVVNfQUREUkVTUzsKPj4gK30K
PiAKPiBEb2VzIHRoaXMgc2VydmUgYW55IHVzZWZ1bCBwdXJwb3NlPyBJZiBhIHBhZ2UgaXMgZGV0
ZXJtaW5lZCB0byBiZSBkZXZpY2UKPiBtZW1vcnksIGl0J3Mgbm90IGdvaW5nIHRvIHN1ZGRlbmx5
IHN0b3AgYmVpbmcgZGV2aWNlIG1lbW9yeSwgYW5kIGlmIHRoZQo+IHVuZGVybHlpbmcgc2cgaXMg
cmVjeWNsZWQgdG8gcG9pbnQgZWxzZXdoZXJlIHRoZW4gc2dfYXNzaWduX3BhZ2UoKSB3aWxsCj4g
c3RpbGwgKGNvcnJlY3RseSkgY2xlYXIgdGhpcyBmbGFnIGFueXdheS4gVHJ5aW5nIHRvIHJlYXNv
biBhYm91dCB0aGlzCj4gYmV5b25kIHN1cGVyZmljaWFsIEFQSSBzeW1tZXRyeSAtIGkuZS4gd2h5
IGV4YWN0bHkgd291bGQgYSBjYWxsZXIgbmVlZAo+IHRvIGNhbGwgaXQsIGFuZCB3aGF0IHdvdWxk
IHRoZSBpbXBsaWNhdGlvbnMgYmUgb2YgZmFpbGluZyB0byBkbyBzbyAtCj4gc2VlbXMgdG8gbGVh
ZCBzdHJhaWdodCB0byBjb25mdXNpb24uCj4gCj4gSW4gZmFjdCBJJ2QgYmUgaW5jbGluZWQgdG8g
aGF2ZSBzZ19hc3NpZ25fcGFnZSgpIGJlIHJlc3BvbnNpYmxlIGZvcgo+IHNldHRpbmcgdGhlIGZs
YWcgYXV0b21hdGljYWxseSBhcyB3ZWxsLCBhbmQgdGh1cyBub3QgbmVlZAo+IHNnX2RtYV9tYXJr
X2J1c19hZGRyZXNzKCkgZWl0aGVyLCBob3dldmVyIEkgY2FuIHNlZSB0aGUgYXJndW1lbnQgZm9y
Cj4gZG9pbmcgaXQgdGhpcyB3YXkgcm91bmQgdG8gbm90IGVudGFuZ2xlIHRoZSBBUElzIHRvbyBt
dWNoLCBzbyBJIGRvbid0Cj4gaGF2ZSBhbnkgZ3JlYXQgb2JqZWN0aW9uIHRvIHRoYXQuCgpZZXMs
IEkgdGhpbmsgeW91IG1pc3VuZGVyc3RhbmQgd2hhdCB0aGlzIGlzIGZvci4gVGhlIFNHX0RNQV9C
VVNfQURERFJFU1MKZmxhZyBkb2Vzbid0IG1hcmsgdGhlIHNlZ21lbnQgZm9yIHRoZSBwYWdlLCBi
dXQgZm9yIHRoZSBkbWEgYWRkcmVzcy4gSXQKY2Fubm90IGJlIHNldCBpbiBzZ19hc3NpZ25fcGFn
ZSgpIHNlZWluZyBpdCdzIG5vdCBhIHByb3BlcnR5IG9mIHRoZSBwYWdlCmJ1dCBhIHByb3BlcnR5
IG9mIHRoZSBkbWFfYWRkcmVzcyBpbiB0aGUgc2dsLgoKSXQncyBub3QgbWVhbnQgZm9yIHVzZSBi
eSByZWd1bGFyIFNHIHVzZXJzLCBpdCdzIG9ubHkgbWVhbnQgZm9yIHVzZQppbnNpZGUgRE1BIG1h
cHBpbmcgaW1wbGVtZW50YXRpb25zLiBUaGUgcHVycG9zZSBpcyB0byBrbm93IHdoZXRoZXIgYQpn
aXZlbiBkbWFfYWRkcmVzcyBpbiB0aGUgU0dMIGlzIGEgYnVzIGFkZHJlc3Mgb3IgcmVndWxhciBt
ZW1vcnkgYmVjYXVzZQp0aGUgdHdvIGRpZmZlcmVudCB0eXBlcyBtdXN0IGJlIHVubWFwcGVkIGRp
ZmZlcmVudGx5LiBXZSBjYW4ndCByZWx5IG9uCnRoZSBwYWdlIGJlY2F1c2UsIGFzIHlvdSBrbm93
LCBtYW55IGRtYV9tYXBfc2coKSB0aGUgZG1hX2FkZHJlc3MgZW50cnkKaW4gdGhlIHNnbCBkb2Vz
IG5vdCBtYXAgdG8gdGhlIHNhbWUgbWVtb3J5IGFzIHRoZSBwYWdlLiBPciB0byBwdXQgaXQKYW5v
dGhlciB3YXk6IGlzX3BjaV9wMnBkbWFfcGFnZShzZy0+cGFnZSkgZG9lcyBub3QgaW1wbHkgdGhh
dApzZy0+ZG1hX2FkZHJlc3MgcG9pbnRzIHRvIGEgYnVzIGFkZHJlc3MuCgpEb2VzIHRoYXQgbWFr
ZSBzZW5zZT8KCkxvZ2FuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
