Return-Path: <SRS0=tZpB=NH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C76C4338F
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 04:05:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35ABC61884
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 04:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 35ABC61884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1C3D80CD2;
	Mon, 16 Aug 2021 04:05:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nGY6bT9PkqqA; Mon, 16 Aug 2021 04:05:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BA6D180CC1;
	Mon, 16 Aug 2021 04:05:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F354C0010;
	Mon, 16 Aug 2021 04:05:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9C66C000E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 04:05:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA802605EF
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 04:05:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MgAH1xedOFLv for <iommu@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 04:05:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6BB99605EB
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 04:05:42 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gp0pq2KzNzb2LN;
 Mon, 16 Aug 2021 12:01:55 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 12:05:34 +0800
Received: from [10.174.178.242] (10.174.178.242) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 12:05:33 +0800
Subject: Re: [PATCH 1/4] iommu/arm-smmu-v3: Use command queue batching helpers
 to improve performance
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To: John Garry <john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20210811114852.2429-1-thunder.leizhen@huawei.com>
 <20210811114852.2429-2-thunder.leizhen@huawei.com>
 <81258eb7-eb73-8a32-0983-3487daba1167@arm.com>
 <4e741216-d6e7-c40c-f257-242cd2fea302@huawei.com>
 <5482d2e5-24db-6139-a8a8-74be1282e2ec@huawei.com>
Message-ID: <52204403-f69a-d2b9-9365-7553e87d1298@huawei.com>
Date: Mon, 16 Aug 2021 12:05:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5482d2e5-24db-6139-a8a8-74be1282e2ec@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.242]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiAyMDIxLzgvMTYgMTA6MTUsIExlaXpoZW4gKFRodW5kZXJUb3duKSB3cm90ZToKPiAKPiAK
PiBPbiAyMDIxLzgvMTQgMDo0NSwgSm9obiBHYXJyeSB3cm90ZToKPj4gT24gMTMvMDgvMjAyMSAx
NzowMSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgYi9kcml2ZXJzL2lvbW11L2FybS9h
cm0tc21tdS12My9hcm0tc21tdS12My5jCj4+Pj4gaW5kZXggMjM1ZjliZGFlYWYyMjNiLi5jODFj
ZDkyOTA0N2Y1NzMgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUt
djMvYXJtLXNtbXUtdjMuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYz
L2FybS1zbW11LXYzLmMKPj4+PiBAQCAtMTc0NywxNSArMTc0NywxNiBAQCBzdGF0aWMgaW50IGFy
bV9zbW11X2F0Y19pbnZfbWFzdGVyKHN0cnVjdCBhcm1fc21tdV9tYXN0ZXIgKm1hc3RlcikKPj4+
PiDCoCB7Cj4+Pj4gwqDCoMKgwqDCoCBpbnQgaTsKPj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBhcm1f
c21tdV9jbWRxX2VudCBjbWQ7Cj4+Pj4gK8KgwqDCoCBzdHJ1Y3QgYXJtX3NtbXVfY21kcV9iYXRj
aCBjbWRzID0ge307Cj4+Pgo+Pj4gQlRXLCBpdCBsb29rcyBsaWtlIHRoaXMgaGFzIGNyb3NzZWQg
b3ZlciB3aXRoIEpvaG4ncyBwYXRjaCByZW1vdmluZyB0aGVzZS4KPj4KPj4gSXQgaXMgb25seSBj
YWxsZWQgZnJvbSBhcm1fc21tdV9kaXNhYmxlX2F0cygpLCBzbyBub3QgaG90LXBhdGggYnkgdGhl
IGxvb2sgZm9yIGl0LiBPciB3aG8gZXZlbiBoYXMgYXRzIEhXIC4uLj8KPj4KPj4gQnV0IGl0IHNo
b3VsZCBiZSBhdCBsZWFzdCBjbGVhbmVkLXVwIGZvciBjb25zaXN0ZW5jeS4gTGVpemhlbj8KPiAK
PiBPa2F5LCBJJ2xsIHJldmlzZSBpdC4gQnV0IFdpbGwgYWxyZWFkeSB0b29rIGl0LiBTbyBJJ20g
bm90IHN1cmUgd2hldGhlciB0byBzZW5kIHYyIG9yIGEgc2VwYXJhdGUgcGF0Y2guCgpJIHRoaW5r
IEknZCBiZXR0ZXIgcG9zdCB2Miwgb3RoZXJ3aXNlIEkgc2hvdWxkIHdyaXRlIHRoZSBzYW1lIGRl
c2NyaXB0aW9uLgoKSW4gYWRkaXRpb24sIEkgZmluZCB0aGF0IGZ1bmN0aW9uIGFybV9zbW11X2Nt
ZHFfYnVpbGRfY21kKCkgY2FuIGFsc28gYmUgb3B0aW1pemVkCnNsaWdodGx5LCB0aHJlZSB1c2Vs
ZXNzIGluc3RydWN0aW9ucyBjYW4gYmUgcmVkdWNlZC4KCkNhc2UgMSk6CnZvaWQgYXJtX3NtbXVf
Y21kcV9idWlsZF9jbWRfdHN0MSh1NjQgKmNtZCwgc3RydWN0IGFybV9zbW11X2NtZHFfZW50ICpl
bnQpCnsKICAgICAgICBtZW1zZXQoY21kLCAwLCAxIDw8IENNRFFfRU5UX1NaX1NISUZUKTsKICAg
ICAgICBjbWRbMF0gfD0gRklFTERfUFJFUChDTURRXzBfT1AsIGVudC0+b3Bjb2RlKTsKfQowMDAw
MDAwMDAwMDA0NjA4IDxhcm1fc21tdV9jbWRxX2J1aWxkX2NtZF90c3QxPjoKICAgIDQ2MDg6ICAg
ICAgIGE5MDA3YzFmICAgICAgICBzdHAgICAgIHh6ciwgeHpyLCBbeDBdCiAgICA0NjBjOiAgICAg
ICAzOTQwMDAyMiAgICAgICAgbGRyYiAgICB3MiwgW3gxXQogICAgNDYxMDogICAgICAgZjk0MDAw
MDEgICAgICAgIGxkciAgICAgeDEsIFt4MF0KICAgIDQ2MTQ6ICAgICAgIGFhMDIwMDIxICAgICAg
ICBvcnIgICAgIHgxLCB4MSwgeDIKICAgIDQ2MTg6ICAgICAgIGY5MDAwMDAxICAgICAgICBzdHIg
ICAgIHgxLCBbeDBdCiAgICA0NjFjOiAgICAgICBkNjVmMDNjMCAgICAgICAgcmV0CgpDYXNlIDIp
Ogp2b2lkIGFybV9zbW11X2NtZHFfYnVpbGRfY21kX3RzdDIodTY0ICpjbWQsIHN0cnVjdCBhcm1f
c21tdV9jbWRxX2VudCAqZW50KQp7CiAgICAgICAgaW50IGk7CgogICAgICAgIGNtZFswXSA9IEZJ
RUxEX1BSRVAoQ01EUV8wX09QLCBlbnQtPm9wY29kZSk7CiAgICAgICAgZm9yIChpID0gMTsgaSA8
IENNRFFfRU5UX0RXT1JEUzsgaSsrKQogICAgICAgICAgICAgICAgY21kW2ldID0gMDsKfQowMDAw
MDAwMDAwMDA0NjIwIDxhcm1fc21tdV9jbWRxX2J1aWxkX2NtZF90c3QyPjoKICAgIDQ2MjA6ICAg
ICAgIDM5NDAwMDIxICAgICAgICBsZHJiICAgIHcxLCBbeDFdCiAgICA0NjI0OiAgICAgICBhOTAw
N2MwMSAgICAgICAgc3RwICAgICB4MSwgeHpyLCBbeDBdCiAgICA0NjI4OiAgICAgICBkNjVmMDNj
MCAgICAgICAgcmV0CiAgICA0NjJjOiAgICAgICBkNTAzMjAxZiAgICAgICAgbm9wCgpDYXNlIDMp
Ogp2b2lkIGFybV9zbW11X2NtZHFfYnVpbGRfY21kX3RzdDModTY0ICpjbWQsIHN0cnVjdCBhcm1f
c21tdV9jbWRxX2VudCAqZW50KQp7CiAgICAgICAgbWVtc2V0KGNtZCwgMCwgMSA8PCBDTURRX0VO
VF9TWl9TSElGVCk7CiAgICAgICAgY21kWzBdID0gRklFTERfUFJFUChDTURRXzBfT1AsIGVudC0+
b3Bjb2RlKTsKfQowMDAwMDAwMDAwMDA0NjMwIDxhcm1fc21tdV9jbWRxX2J1aWxkX2NtZF90c3Qz
PjoKICAgIDQ2MzA6ICAgICAgIGE5MDA3YzFmICAgICAgICBzdHAgICAgIHh6ciwgeHpyLCBbeDBd
CiAgICA0NjM0OiAgICAgICAzOTQwMDAyMSAgICAgICAgbGRyYiAgICB3MSwgW3gxXQogICAgNDYz
ODogICAgICAgZjkwMDAwMDEgICAgICAgIHN0ciAgICAgeDEsIFt4MF0KICAgIDQ2M2M6ICAgICAg
IGQ2NWYwM2MwICAgICAgICByZXQKCj4gCj4+Cj4+IFRoYW5rcywKPj4gSm9obgo+PiAuCj4+Cj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBpb21tdSBt
YWlsaW5nIGxpc3QKPiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+IGh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11Cj4gCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
