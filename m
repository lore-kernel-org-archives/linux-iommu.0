Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2F1C433F5
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 13:40:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1257A6064D;
	Wed,  8 Dec 2021 13:40:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YWmpBCxy8ZML; Wed,  8 Dec 2021 13:40:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9F05D60648;
	Wed,  8 Dec 2021 13:40:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D707C002F;
	Wed,  8 Dec 2021 13:40:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B735C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 13:40:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 098E8403C0
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 13:40:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pIvIbyed-fnm for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 13:40:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 01BC7403BA
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 13:40:16 +0000 (UTC)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J8JFB6w66zcbpt;
 Wed,  8 Dec 2021 21:39:58 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 21:40:11 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 21:40:10 +0800
Subject: Re: [PATCH v3 1/1] iommu/arm-smmu-v3: Simplify useless instructions
 in arm_smmu_cmdq_build_cmd()
To: John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux-foundation.org>,
 <linux-kernel@vger.kernel.org>
References: <20211207094109.1962-1-thunder.leizhen@huawei.com>
 <20211207094109.1962-2-thunder.leizhen@huawei.com>
 <9da73d96-c61d-4ed2-607d-4861e6bfd696@huawei.com>
Message-ID: <58e8e7c6-a47b-7816-ac74-aefa5b55dd17@huawei.com>
Date: Wed, 8 Dec 2021 21:40:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9da73d96-c61d-4ed2-607d-4861e6bfd696@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
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
From: "Leizhen \(ThunderTown\) via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Leizhen \(ThunderTown\)" <thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiAyMDIxLzEyLzggMDoxNywgSm9obiBHYXJyeSB3cm90ZToKPiAKPj4gKwo+PiDCoMKgwqDC
oMKgIHJldHVybiAwOwo+PiDCoCB9Cj4gCj4gRGlkIHlvdSBub3RpY2UgYW55IHBlcmZvcm1hbmNl
IGNoYW5nZSB3aXRoIHRoaXMgY2hhbmdlPwoKSGkgSm9objoKICBUaGFua3MgZm9yIHRoZSB0aXAu
IEkgd3JvdGUgYSB0ZXN0IGNhc2UgdG9kYXksIGFuZCBJIGZvdW5kIHRoYXQgdGhlCnBlcmZvcm1h
bmNlIGRpZCBub3QgZ28gdXAgYnV0IGRvd24uIEl0J3Mgc28gd2VpcmQuIFNvIEkgZGVjaWRlZCBu
b3QgdG8KY2hhbmdlIGl0LCBiZWNhdXNlIGl0J3MgYWxzbyBwb29ybHkgcmVhZGFibGUuIFNvIEkg
cGxhbiB0byBtYWtlIG9ubHkKdGhlIGZvbGxvd2luZyBtb2RpZmljYXRpb25zOgpAQCAtMjM3LDcg
KzIzNyw3IEBAIHN0YXRpYyBpbnQgcXVldWVfcmVtb3ZlX3JhdyhzdHJ1Y3QgYXJtX3NtbXVfcXVl
dWUgKnEsIHU2NCAqZW50KQogc3RhdGljIGludCBhcm1fc21tdV9jbWRxX2J1aWxkX2NtZCh1NjQg
KmNtZCwgc3RydWN0IGFybV9zbW11X2NtZHFfZW50ICplbnQpCiB7CiAgICAgICAgbWVtc2V0KGNt
ZCwgMCwgMSA8PCBDTURRX0VOVF9TWl9TSElGVCk7Ci0gICAgICAgY21kWzBdIHw9IEZJRUxEX1BS
RVAoQ01EUV8wX09QLCBlbnQtPm9wY29kZSk7CisgICAgICAgY21kWzBdID0gRklFTERfUFJFUChD
TURRXzBfT1AsIGVudC0+b3Bjb2RlKTsKCiAgICAgICAgc3dpdGNoIChlbnQtPm9wY29kZSkgewog
ICAgICAgIGNhc2UgQ01EUV9PUF9UTEJJX0VMMl9BTEw6CgpUaGlzIHByZXZlbnRzIHRoZSBjb21w
aWxlciBmcm9tIGdlbmVyYXRpbmcgdGhlIGZvbGxvd2luZyB0d28gaW5lZmZpY2llbnQKaW5zdHJ1
Y3Rpb25zOgogICAgIDM5NDogICAgICAgZjk0MDAwMDIgICAgICAgIGxkciAgICAgeDIsIFt4MF0J
Ly94MiA9IGNtZFswXQogICAgIDM5ODogICAgICAgYWEwMjAwNjIgICAgICAgIG9yciAgICAgeDIs
IHgzLCB4MgkvL3gzID0gRklFTERfUFJFUChDTURRXzBfT1AsIGVudC0+b3Bjb2RlKQoKTWF5YmUg
aXQncyBub3Qgd29ydGggY2hhbmdpbmcgYmVjYXVzZSBJJ3ZlIG9ubHkgc2VlbiBhIDAueCBuYW5v
c2Vjb25kIHJlZHVjdGlvbgppbiBwZXJmb3JtYW5jZS4gQnV0IG9uZSB0aGluZyBpcywgaXQgb25s
eSBjb21lcyB3aXRoIGJlbmVmaXRzLCBubyBzaWRlIGVmZmVjdHMuCgo+IAo+IFRoYW5rcywKPiBK
b2huCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
