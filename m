Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCF9C433EF
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 10:08:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71C5441732;
	Wed, 25 May 2022 10:08:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rz3_W-zX2o8T; Wed, 25 May 2022 10:08:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E1D324159D;
	Wed, 25 May 2022 10:08:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3900C0032;
	Wed, 25 May 2022 10:08:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 930C9C002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 10:08:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7F8D4415B0
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 10:08:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vE0by600tAlh for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 10:07:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0DED64159D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 10:07:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06AE41FB;
 Wed, 25 May 2022 03:07:58 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CE023F73D;
 Wed, 25 May 2022 03:07:55 -0700 (PDT)
Message-ID: <567dffd4-8f15-ffb2-da69-4f47017c35fd@arm.com>
Date: Wed, 25 May 2022 11:07:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Content-Language: en-GB
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <f3170016-4d7f-e78e-db48-68305f683349@arm.com>
 <ff8f23c0-8763-1fac-6526-9095101ca0e5@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ff8f23c0-8763-1fac-6526-9095101ca0e5@linux.intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

T24gMjAyMi0wNS0yNSAwNzoyMCwgQmFvbHUgTHUgd3JvdGU6Cj4gSGkgUm9iaW4sCj4gCj4gT24g
MjAyMi81LzI0IDIyOjM2LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IE9uIDIwMjItMDUtMTkgMDg6
MjAsIEx1IEJhb2x1IHdyb3RlOgo+PiBbLi4uXQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9t
bXUvaW9tbXUtc3ZhLWxpYi5jIAo+Pj4gYi9kcml2ZXJzL2lvbW11L2lvbW11LXN2YS1saWIuYwo+
Pj4gaW5kZXggMTA2NTA2MTQzODk2Li4yMTBjMzc2ZjYwNDMgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2
ZXJzL2lvbW11L2lvbW11LXN2YS1saWIuYwo+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS1z
dmEtbGliLmMKPj4+IEBAIC02OSwzICs2OSw1MSBAQCBzdHJ1Y3QgbW1fc3RydWN0ICppb21tdV9z
dmFfZmluZChpb2FzaWRfdCBwYXNpZCkKPj4+IMKgwqDCoMKgwqAgcmV0dXJuIGlvYXNpZF9maW5k
KCZpb21tdV9zdmFfcGFzaWQsIHBhc2lkLCBfX21tZ2V0X25vdF96ZXJvKTsKPj4+IMKgIH0KPj4+
IMKgIEVYUE9SVF9TWU1CT0xfR1BMKGlvbW11X3N2YV9maW5kKTsKPj4+ICsKPj4+ICsvKgo+Pj4g
KyAqIElPTU1VIFNWQSBkcml2ZXItb3JpZW50ZWQgaW50ZXJmYWNlcwo+Pj4gKyAqLwo+Pj4gK3N0
cnVjdCBpb21tdV9kb21haW4gKgo+Pj4gK2lvbW11X3N2YV9hbGxvY19kb21haW4oc3RydWN0IGJ1
c190eXBlICpidXMsIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQo+Pgo+PiBBcmdoLCBwbGVhc2Ugbm8g
bmV3IGJ1cy1iYXNlZCBleHRlcm5hbCBpbnRlcmZhY2VzISBEb21haW4gYWxsb2NhdGlvbiAKPj4g
bmVlZHMgdG8gcmVzb2x2ZSB0byB0aGUgcmlnaHQgSU9NTVUgaW5zdGFuY2UgdG8gc29sdmUgYSBu
dW1iZXIgb2YgCj4+IGlzc3VlcywgYW5kIGNsZWFuaW5nIHVwIGV4aXN0aW5nIHVzZXJzIG9mIGlv
bW11X2RvbWFpbl9hbGxvYygpIHRvIAo+PiBwcmVwYXJlIGZvciB0aGF0IGlzIGFscmVhZHkgaGFy
ZCBlbm91Z2guIFRoaXMgaXMgYXJndWFibHkgZXZlbiBtb3JlIAo+PiByZWxldmFudCBoZXJlIHRo
YW4gZm9yIG90aGVyIGRvbWFpbiB0eXBlcywgc2luY2UgU1ZBIHN1cHBvcnQgaXMgbW9yZSAKPj4g
bGlrZWx5IHRvIGRlcGVuZCBvbiBzcGVjaWZpYyBmZWF0dXJlcyB0aGF0IGNhbiB2YXJ5IGJldHdl
ZW4gSU9NTVUgCj4+IGluc3RhbmNlcyBldmVuIHdpdGggdGhlIHNhbWUgZHJpdmVyLiBQbGVhc2Ug
bWFrZSB0aGUgZXh0ZXJuYWwgCj4+IGludGVyZmFjZSB0YWtlIGEgc3RydWN0IGRldmljZSwgdGhl
biByZXNvbHZlIHRoZSBvcHMgdGhyb3VnaCBkZXYtPmlvbW11Lgo+Pgo+PiBGdXJ0aGVyIG5pdDog
dGhlIG5hbWluZyBpbmNvbnNpc3RlbmN5IGJ1Z3MgbWUgYSBiaXQgLSAKPj4gaW9tbXVfc3ZhX2Rv
bWFpbl9hbGxvYygpIHNlZW1zIG1vcmUgbmF0dXJhbC4gQWxzbyBJJ2QgcXVlc3Rpb24gdGhlIAo+
PiBzeW1tZXRyeSB2cy4gdXNhYmlsaXR5IGRpY2hvdG9teSBvZiB3aGV0aGVyIHdlICpyZWFsbHkq
IHdhbnQgdHdvIAo+PiBkaWZmZXJlbnQgZnJlZSBmdW5jdGlvbnMgZm9yIGEgc3RydWN0IGlvbW11
X2RvbWFpbiBwb2ludGVyLCB3aGVyZSBhbnkgCj4+IGNhbGxlciB3aGljaCBtaWdodCBtaXggU1ZB
IGFuZCBub24tU1ZBIHVzYWdlIHRoZW4gaGFzIHRvIHJlbWVtYmVyIGhvdyAKPj4gdGhleSBhbGxv
Y2F0ZWQgYW55IHBhcnRpY3VsYXIgZG9tYWluIDovCj4+Cj4+PiArewo+Pj4gK8KgwqDCoCBzdHJ1
Y3QgaW9tbXVfc3ZhX2RvbWFpbiAqc3ZhX2RvbWFpbjsKPj4+ICvCoMKgwqAgc3RydWN0IGlvbW11
X2RvbWFpbiAqZG9tYWluOwo+Pj4gKwo+Pj4gK8KgwqDCoCBpZiAoIWJ1cy0+aW9tbXVfb3BzIHx8
ICFidXMtPmlvbW11X29wcy0+c3ZhX2RvbWFpbl9vcHMpCj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIEVSUl9QVFIoLUVOT0RFVik7Cj4+PiArCj4+PiArwqDCoMKgIHN2YV9kb21haW4gPSBremFs
bG9jKHNpemVvZigqc3ZhX2RvbWFpbiksIEdGUF9LRVJORUwpOwo+Pj4gK8KgwqDCoCBpZiAoIXN2
YV9kb21haW4pCj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7Cj4+
PiArCj4+PiArwqDCoMKgIG1tZ3JhYihtbSk7Cj4+PiArwqDCoMKgIHN2YV9kb21haW4tPm1tID0g
bW07Cj4+PiArCj4+PiArwqDCoMKgIGRvbWFpbiA9ICZzdmFfZG9tYWluLT5kb21haW47Cj4+PiAr
wqDCoMKgIGRvbWFpbi0+dHlwZSA9IElPTU1VX0RPTUFJTl9TVkE7Cj4+PiArwqDCoMKgIGRvbWFp
bi0+b3BzID0gYnVzLT5pb21tdV9vcHMtPnN2YV9kb21haW5fb3BzOwo+Pgo+PiBJJ2QgaGF2ZSB0
aG91Z2h0IGl0IHdvdWxkIGJlIGxvZ2ljYWwgdG8gcGFzcyBJT01NVV9ET01BSU5fU1ZBIHRvIHRo
ZSAKPj4gbm9ybWFsIGRvbWFpbl9hbGxvYyBjYWxsLCBzbyB0aGF0IGRyaXZlci1pbnRlcm5hbCBz
dHVmZiBsaWtlIGNvbnRleHQgCj4+IGRlc2NyaXB0b3JzIGNhbiBiZSBzdGlsbCBiZSBodW5nIG9m
ZiB0aGUgZG9tYWluIGFzIHVzdWFsIChyYXRoZXIgdGhhbiAKPj4gYWxsIGRyaXZlcnMgaGF2aW5n
IHRvIGltcGxlbWVudCBzb21lIGV4dHJhIGludGVybmFsIGxvb2t1cCBtZWNoYW5pc20gCj4+IHRv
IGhhbmRsZSBhbGwgdGhlIFNWQSBkb21haW4gb3BzKSwgYnV0IHRoYXQncyBzb21ldGhpbmcgd2Un
cmUgZnJlZSB0byAKPj4gY29tZSAKPiAKPiBBZ3JlZWQgd2l0aCBhYm92ZSBjb21tZW50cy4gVGhh
bmtzISBJIHdpbGwgcG9zdCBhbiBhZGRpdGlvbmFsIHBhdGNoCj4gZm9yIHJldmlldyBsYXRlci4K
PiAKPj4gYmFjayBhbmQgY2hhbmdlIGxhdGVyLiBGV0lXIEknZCBqdXN0IHN0aWNrIHRoZSBtbSBw
b2ludGVyIGluIHN0cnVjdCAKPj4gaW9tbXVfZG9tYWluLCBpbiBhIHVuaW9uIHdpdGggdGhlIGZh
dWx0IGhhbmRsZXIgc3R1ZmYgYW5kL29yIAo+PiBpb3ZhX2Nvb2tpZSAtIHRob3NlIGFyZSBtdXR1
YWxseSBleGNsdXNpdmUgd2l0aCBTVkEsIHJpZ2h0Pwo+IAo+ICJpb3ZhX2Nvb2tpZSIgaXMgbXV0
dWFsbHkgZXhjbHVzaXZlIHdpdGggU1ZBLCBidXQgSSBhbSBub3Qgc3VyZSBhYm91dAo+IHRoZSBm
YXVsdCBoYW5kbGVyIHN0dWZmLgoKVG8gY29ycmVjdCBteXNlbGYsIHRoZSBJT1ZBIGNvb2tpZSBz
aG91bGQgYmUgaXJyZWxldmFudCB0byAqY3VycmVudCogClNWQSwgYnV0IGlmIHdlIGV2ZXIgZ2V0
IGFzIGZhciBhcyB3aG9sZS1kZXZpY2UtU1ZBIHdpdGhvdXQgUEFTSURzIHRoZW4gCndlIG1pZ2h0
IG5lZWQgYW4gTVNJIGNvb2tpZSAobW9kdWxvIHRoZSBhZGRpdGlvbmFsIHByb2JsZW0gb2Ygc3Rl
YWxpbmcgCnNvbWUgcHJvY3Zlc3MgYWRkcmVzcyBzcGFjZSBmb3IgaXQpLgoKPiBEaWQgeW91IG1l
YW4gQGhhbmRsZXIgYW5kIEBoYW5kbGVyX3Rva2VuIHN0YWZmcyBiZWxvdz8KPiAKPiBzdHJ1Y3Qg
aW9tbXVfZG9tYWluIHsKPiAgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgdHlwZTsKPiAgwqDCoMKg
wqDCoMKgwqAgY29uc3Qgc3RydWN0IGlvbW11X2RvbWFpbl9vcHMgKm9wczsKPiAgwqDCoMKgwqDC
oMKgwqAgdW5zaWduZWQgbG9uZyBwZ3NpemVfYml0bWFwO8KgwqDCoCAvKiBCaXRtYXAgb2YgcGFn
ZSBzaXplcyBpbiB1c2UgKi8KPiAgwqDCoMKgwqDCoMKgwqAgaW9tbXVfZmF1bHRfaGFuZGxlcl90
IGhhbmRsZXI7Cj4gIMKgwqDCoMKgwqDCoMKgIHZvaWQgKmhhbmRsZXJfdG9rZW47Cj4gIMKgwqDC
oMKgwqDCoMKgIHN0cnVjdCBpb21tdV9kb21haW5fZ2VvbWV0cnkgZ2VvbWV0cnk7Cj4gIMKgwqDC
oMKgwqDCoMKgIHN0cnVjdCBpb21tdV9kbWFfY29va2llICppb3ZhX2Nvb2tpZTsKPiB9Owo+IAo+
IElzIGl0IG9ubHkgZm9yIERNQSBkb21haW5zPyBGcm9tIHRoZSBwb2ludCB2aWV3IG9mIElPTU1V
IGZhdWx0cywgaXQKPiBzZWVtcyB0byBiZSBnZW5lcmljLgoKWWVzLCBpdCdzIHRoZSBvbGQgY29t
bW9uIGlvbW11X3NldF9mYXVsdF9oYW5kbGVyKCkgc3R1ZmYgKHdoaWNoIGFyZ3VhYmx5IAppcyBt
b3JlIG9mIGEgIm5vdGlmaWVyIiB0aGFuIGEgImhhbmRsZXIiKSwgYnV0IEkgYXNzdW1lIHRoYXQg
dGhhdCdzIAppcnJlbGV2YW50IGlmIFNWQSBpcyB1c2luZyBJT1BGIGluc3RlYWQ/CgpUaGFua3Ms
ClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
