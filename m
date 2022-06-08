Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67273C433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Jun 2022 10:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 091D68425B;
	Wed,  8 Jun 2022 10:14:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LYSXTMmaHbCe; Wed,  8 Jun 2022 10:14:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6B4E6841EB;
	Wed,  8 Jun 2022 10:14:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4736FC0039;
	Wed,  8 Jun 2022 10:14:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54B29C002D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 10:14:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 42CA0419E7
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 10:14:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gNjUKXqOcPnN for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 10:14:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 38A97419CC
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 10:14:13 +0000 (UTC)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJ32H3WYkz6H6pv;
 Wed,  8 Jun 2022 18:12:55 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 12:14:09 +0200
Received: from [10.47.90.54] (10.47.90.54) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 8 Jun
 2022 11:14:08 +0100
Message-ID: <202f1969-41e4-5f9a-3ff6-0009757434f5@huawei.com>
Date: Wed, 8 Jun 2022 11:14:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 0/4] DMA mapping changes for SCSI core
To: Bart Van Assche <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>, 
 <joro@8bytes.org>, <will@kernel.org>, <jejb@linux.ibm.com>,
 <martin.petersen@oracle.com>, <hch@lst.de>, <m.szyprowski@samsung.com>,
 <robin.murphy@arm.com>
References: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
 <3e2324dc-2ab1-6a35-46ab-72d970cc466c@acm.org>
In-Reply-To: <3e2324dc-2ab1-6a35-46ab-72d970cc466c@acm.org>
X-Originating-IP: [10.47.90.54]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org,
 liyihang6@hisilicon.com, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMDcvMDYvMjAyMiAyMzo0MywgQmFydCBWYW4gQXNzY2hlIHdyb3RlOgo+IE9uIDYvNi8yMiAw
MjozMCwgSm9obiBHYXJyeSB3cm90ZToKPj4gQXMgcmVwb3J0ZWQgaW4gWzBdLCBETUEgbWFwcGlu
Z3Mgd2hvc2Ugc2l6ZSBleGNlZWRzIHRoZSBJT01NVSBJT1ZBIAo+PiBjYWNoaW5nCj4+IGxpbWl0
IG1heSBzZWUgYSBiaWcgcGVyZm9ybWFuY2UgaGl0Lgo+Pgo+PiBUaGlzIHNlcmllcyBpbnRyb2R1
Y2VzIGEgbmV3IERNQSBtYXBwaW5nIEFQSSwgZG1hX29wdF9tYXBwaW5nX3NpemUoKSwgc28KPj4g
dGhhdCBkcml2ZXJzIG1heSBrbm93IHRoaXMgbGltaXQgd2hlbiBwZXJmb3JtYW5jZSBpcyBhIGZh
Y3RvciBpbiB0aGUKPj4gbWFwcGluZy4KPj4KPj4gUm9iaW4gZGlkbid0IGxpa2UgdXNpbmcgZG1h
X21heF9tYXBwaW5nX3NpemUoKSBmb3IgdGhpcyBbMV0uCj4+Cj4+IFRoZSBTQ1NJIGNvcmUgY29k
ZSBpcyBtb2RpZmllZCB0byB1c2UgdGhpcyBsaW1pdC4KPj4KPj4gSSBhbHNvIGFkZGVkIGEgcGF0
Y2ggZm9yIGxpYmF0YS1zY3NpIGFzIGl0IGRvZXMgbm90IGN1cnJlbnRseSBob25vdXIgdGhlCj4+
IHNob3N0IG1heF9zZWN0b3JzIGxpbWl0Lgo+Pgo+PiBOb3RlOiBDaHJpc3RvcGggaGFzIHByZXZp
b3VzbHkga2luZGx5IG9mZmVyZWQgdG8gdGFrZSB0aGlzIHNlcmllcyB2aWEgdGhlCj4+IMKgwqDC
oMKgwqDCoCBkbWEtbWFwcGluZyB0cmVlLCBzbyBJIHRoaW5rIHRoYXQgd2UganVzdCBuZWVkIGFu
IGFjayBmcm9tIHRoZQo+PiDCoMKgwqDCoMKgwqAgSU9NTVUgZ3V5cyBub3cuCj4+Cj4+IFswXSAK
Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMjAyMTAxMjkwOTIxMjAuMTQ4
Mi0xLXRodW5kZXIubGVpemhlbkBodWF3ZWkuY29tLyAKPj4KPj4gWzFdIAo+PiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1pb21tdS9mNWI3OGM5Yy0zMTJlLTcwYWItZWNiYi1mMTQ2MjNh
NGI2ZTNAYXJtLmNvbS8gCj4+Cj4gCj4gUmVnYXJkaW5nIFswXSwgdGhhdCBwYXRjaCByZXZlcnRz
IGNvbW1pdCA0ZTg5ZGNlNzI1MjEgKCJpb21tdS9pb3ZhOiAKPiBSZXRyeSBmcm9tIGxhc3QgcmIg
dHJlZSBub2RlIGlmIGlvdmEgc2VhcmNoIGZhaWxzIikuIFJlYWRpbmcgdGhlIAo+IGRlc2NyaXB0
aW9uIG9mIHRoYXQgcGF0Y2gsIGl0IHNlZW1zIHRvIG1lIHRoYXQgdGhlIGlvdmEgYWxsb2NhdG9y
IGNhbiBiZSAKPiBpbXByb3ZlZC4gU2hvdWxkbid0IHRoZSBpb3ZhIGFsbG9jYXRvciBiZSBpbXBy
b3ZlZCBzdWNoIHRoYXQgd2UgZG9uJ3QgCj4gbmVlZCB0aGlzIHBhdGNoIHNlcmllcz8gVGhlcmUg
YXJlIGFsZ29yaXRobXMgdGhhdCBoYW5kbGUgZnJhZ21lbnRhdGlvbiAKPiBtdWNoIGJldHRlciB0
aGFuIHRoZSBjdXJyZW50IGlvdmEgYWxsb2NhdG9yIGFsZ29yaXRobSwgZS5nLiB0aGUgCj4gaHR0
cHM6Ly9lbi53aWtpcGVkaWEub3JnL3dpa2kvQnVkZHlfbWVtb3J5X2FsbG9jYXRpb24gYWxnb3Jp
dGhtLgoKUmVnYXJkbGVzcyBvZiB3aGV0aGVyIHRoZSBJT1ZBIGFsbG9jYXRvciBjYW4gYmUgaW1w
cm92ZWQgLSB3aGljaCBpdCAKcHJvYmFibHkgY2FuIGJlIC0gdGhpcyBzZXJpZXMgaXMgc3RpbGwg
dXNlZnVsLiBUaGF0IGlzIGR1ZSB0byB0aGUgSU9WQSAKcmNhY2hlIC0gdGhhdCBpcyBhIGNhY2hl
IG9mIHByZS1hbGxvY2F0ZWQgSU9WQXMgd2hpY2ggY2FuIGJlIHF1aWNrbHkgCnVzZWQgaW4gdGhl
IERNQSBtYXBwaW5nLiBUaGUgcmFjaGUgY29udGFpbnMgSU9WQXMgdXAgdG8gY2VydGFpbiBmaXhl
ZCAKc2l6ZS4gSW4gdGhpcyBzZXJpZXMgd2UgbGltaXQgdGhlIERNQSBtYXBwaW5nIGxlbmd0aCB0
byB0aGUgcmNhY2hlIHNpemUgCnVwcGVyIGxpbWl0IHRvIGFsd2F5cyBieXBhc3MgdGhlIGFsbG9j
YXRvciAod2hlbiB3ZSBoYXZlIGEgY2FjaGVkIElPVkEgCmF2YWlsYWJsZSkgLSBzZWUgYWxsb2Nf
aW92YV9mYXN0KCkuCgpFdmVuIGlmIHRoZSBJT1ZBIGFsbG9jYXRvciB3ZXJlIGdyZWF0bHkgb3B0
aW1pc2VkIGZvciBzcGVlZCwgdGhlcmUgd291bGQgCnN0aWxsIGJlIGFuIG92ZXJoZWFkIGluIHRo
ZSBhbGxvYyBhbmQgZnJlZSBmb3IgdGhvc2UgbGFyZ2VyIElPVkFzIHdoaWNoIAp3b3VsZCBvdXR3
ZWlnaCB0aGUgYWR2YW50YWdlIG9mIGhhdmluZyBsYXJnZXIgRE1BIG1hcHBpbmdzLiBCdXQgaXMg
dGhlcmUgCmV2ZW4gYW4gYWR2YW50YWdlIGluIHZlcnkgbGFyZ2Ugc3RyZWFtaW5nIERNQSBtYXBw
aW5ncz8gTWF5YmUgZm9yIGlvdGxiIAplZmZpY2llbmN5LiBCdXQgc29tZSBzYXkgaXQncyBiZXR0
ZXIgdG8gaGF2ZSB0aGUgRE1BIGVuZ2luZSBzdGFydCAKcHJvY2Vzc2luZyB0aGUgZGF0YSBBU0FQ
IGFuZCBub3Qgd2FpdCBmb3IgbGFyZ2VyIGxpc3RzIHRvIGJlIGJ1aWx0LgoKVGhhbmtzLApKb2hu
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
