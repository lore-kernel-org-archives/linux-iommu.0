Return-Path: <SRS0=tZpB=NH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4733C4338F
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 07:48:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8814D61AAA
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 07:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8814D61AAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5236380E57;
	Mon, 16 Aug 2021 07:48:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CNVj2f_HLkQt; Mon, 16 Aug 2021 07:48:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1D63980D16;
	Mon, 16 Aug 2021 07:48:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E977CC001A;
	Mon, 16 Aug 2021 07:48:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CF4AC000E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 07:48:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E9E280E01
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 07:48:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w2nuwmIZM3ug for <iommu@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 07:48:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EBF0680D16
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 07:48:05 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gp5lR6SgRzb2Sx;
 Mon, 16 Aug 2021 15:44:19 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 15:47:59 +0800
Received: from [10.174.178.242] (10.174.178.242) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 15:47:58 +0800
Subject: Re: [PATCH 1/4] iommu/arm-smmu-v3: Use command queue batching helpers
 to improve performance
To: John Garry <john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20210811114852.2429-1-thunder.leizhen@huawei.com>
 <20210811114852.2429-2-thunder.leizhen@huawei.com>
 <81258eb7-eb73-8a32-0983-3487daba1167@arm.com>
 <4e741216-d6e7-c40c-f257-242cd2fea302@huawei.com>
 <5482d2e5-24db-6139-a8a8-74be1282e2ec@huawei.com>
 <52204403-f69a-d2b9-9365-7553e87d1298@huawei.com>
 <a3cdd5df-c028-5484-ce99-928a689d341a@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <e8b71423-e827-f141-1203-00aca2e70834@huawei.com>
Date: Mon, 16 Aug 2021 15:47:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a3cdd5df-c028-5484-ce99-928a689d341a@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.242]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

CgpPbiAyMDIxLzgvMTYgMTU6MjQsIEpvaG4gR2Fycnkgd3JvdGU6Cj4+IEluIGFkZGl0aW9uLCBJ
IGZpbmQgdGhhdCBmdW5jdGlvbiBhcm1fc21tdV9jbWRxX2J1aWxkX2NtZCgpIGNhbiBhbHNvIGJl
IG9wdGltaXplZAo+PiBzbGlnaHRseSwgdGhyZWUgdXNlbGVzcyBpbnN0cnVjdGlvbnMgY2FuIGJl
IHJlZHVjZWQuCj4gCj4gSSB0aGluayB0aGF0IHlvdSBjb3VsZCBvcHRpbWlzZSBmdXJ0aGVyIGJ5
IHByZS1idWlsZGluZyBjb21tb25seSB1c2VkIGNvbW1hbmRzLgo+IAo+IEZvciBleGFtcGxlLCBD
TURfU1lOQyB3aXRob3V0IE1TSSBwb2xsaW5nIGlzIGFsd2F5cyB0aGUgc2FtZS4gQW5kIHRoZW4g
b25seSBkaWZmZXJlbnQgaW4gMSBmaWVsZCBmb3IgTVNJIHBvbGxpbmcuCj4gCj4gQnV0IHlvdSBu
ZWVkIHRvIGNoZWNrIGlmIHRoZSBwZXJmb3JtYW5jZSBnYWluIGlzIHdvcnRoIHRoZSBjaGFuZ2Uu
CgpHb29kIGFkdmljZS4gSSBjYW4gZ2l2ZSBpdCBhIHRyeS4KCj4gCj4+Cj4+IENhc2UgMSk6Cj4+
IHZvaWQgYXJtX3NtbXVfY21kcV9idWlsZF9jbWRfdHN0MSh1NjQgKmNtZCwgc3RydWN0IGFybV9z
bW11X2NtZHFfZW50ICplbnQpCj4+IHsKPj4gwqDCoMKgwqDCoMKgwqDCoCBtZW1zZXQoY21kLCAw
LCAxIDw8IENNRFFfRU5UX1NaX1NISUZUKTsKPj4gwqDCoMKgwqDCoMKgwqDCoCBjbWRbMF0gfD0g
RklFTERfUFJFUChDTURRXzBfT1AsIGVudC0+b3Bjb2RlKTsKPj4gfQo+PiAwMDAwMDAwMDAwMDA0
NjA4IDxhcm1fc21tdV9jbWRxX2J1aWxkX2NtZF90c3QxPjoKPj4gwqDCoMKgwqAgNDYwODrCoMKg
wqDCoMKgwqAgYTkwMDdjMWbCoMKgwqDCoMKgwqDCoCBzdHDCoMKgwqDCoCB4enIsIHh6ciwgW3gw
XQo+PiDCoMKgwqDCoCA0NjBjOsKgwqDCoMKgwqDCoCAzOTQwMDAyMsKgwqDCoMKgwqDCoMKgIGxk
cmLCoMKgwqAgdzIsIFt4MV0KPj4gwqDCoMKgwqAgNDYxMDrCoMKgwqDCoMKgwqAgZjk0MDAwMDHC
oMKgwqDCoMKgwqDCoCBsZHLCoMKgwqDCoCB4MSwgW3gwXQo+PiDCoMKgwqDCoCA0NjE0OsKgwqDC
oMKgwqDCoCBhYTAyMDAyMcKgwqDCoMKgwqDCoMKgIG9ycsKgwqDCoMKgIHgxLCB4MSwgeDIKPj4g
wqDCoMKgwqAgNDYxODrCoMKgwqDCoMKgwqAgZjkwMDAwMDHCoMKgwqDCoMKgwqDCoCBzdHLCoMKg
wqDCoCB4MSwgW3gwXQo+PiDCoMKgwqDCoCA0NjFjOsKgwqDCoMKgwqDCoCBkNjVmMDNjMMKgwqDC
oMKgwqDCoMKgIHJldAo+Pgo+PiBDYXNlIDIpOgo+PiB2b2lkIGFybV9zbW11X2NtZHFfYnVpbGRf
Y21kX3RzdDIodTY0ICpjbWQsIHN0cnVjdCBhcm1fc21tdV9jbWRxX2VudCAqZW50KQo+PiB7Cj4+
IMKgwqDCoMKgwqDCoMKgwqAgaW50IGk7Cj4+Cj4+IMKgwqDCoMKgwqDCoMKgwqAgY21kWzBdID0g
RklFTERfUFJFUChDTURRXzBfT1AsIGVudC0+b3Bjb2RlKTsKPj4gwqDCoMKgwqDCoMKgwqDCoCBm
b3IgKGkgPSAxOyBpIDwgQ01EUV9FTlRfRFdPUkRTOyBpKyspCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNtZFtpXSA9IDA7Cj4+IH0KPj4gMDAwMDAwMDAwMDAwNDYyMCA8YXJt
X3NtbXVfY21kcV9idWlsZF9jbWRfdHN0Mj46Cj4+IMKgwqDCoMKgIDQ2MjA6wqDCoMKgwqDCoMKg
IDM5NDAwMDIxwqDCoMKgwqDCoMKgwqAgbGRyYsKgwqDCoCB3MSwgW3gxXQo+PiDCoMKgwqDCoCA0
NjI0OsKgwqDCoMKgwqDCoCBhOTAwN2MwMcKgwqDCoMKgwqDCoMKgIHN0cMKgwqDCoMKgIHgxLCB4
enIsIFt4MF0KPj4gwqDCoMKgwqAgNDYyODrCoMKgwqDCoMKgwqAgZDY1ZjAzYzDCoMKgwqDCoMKg
wqDCoCByZXQKPj4gwqDCoMKgwqAgNDYyYzrCoMKgwqDCoMKgwqAgZDUwMzIwMWbCoMKgwqDCoMKg
wqDCoCBub3AKPj4KPj4gQ2FzZSAzKToKPj4gdm9pZCBhcm1fc21tdV9jbWRxX2J1aWxkX2NtZF90
c3QzKHU2NCAqY21kLCBzdHJ1Y3QgYXJtX3NtbXVfY21kcV9lbnQgKmVudCkKPj4gewo+PiDCoMKg
wqDCoMKgwqDCoMKgIG1lbXNldChjbWQsIDAsIDEgPDwgQ01EUV9FTlRfU1pfU0hJRlQpOwo+PiDC
oMKgwqDCoMKgwqDCoMKgIGNtZFswXSA9IEZJRUxEX1BSRVAoQ01EUV8wX09QLCBlbnQtPm9wY29k
ZSk7Cj4+IH0KPj4gMDAwMDAwMDAwMDAwNDYzMCA8YXJtX3NtbXVfY21kcV9idWlsZF9jbWRfdHN0
Mz46Cj4+IMKgwqDCoMKgIDQ2MzA6wqDCoMKgwqDCoMKgIGE5MDA3YzFmwqDCoMKgwqDCoMKgwqAg
c3RwwqDCoMKgwqAgeHpyLCB4enIsIFt4MF0KPj4gwqDCoMKgwqAgNDYzNDrCoMKgwqDCoMKgwqAg
Mzk0MDAwMjHCoMKgwqDCoMKgwqDCoCBsZHJiwqDCoMKgIHcxLCBbeDFdCj4+IMKgwqDCoMKgIDQ2
Mzg6wqDCoMKgwqDCoMKgIGY5MDAwMDAxwqDCoMKgwqDCoMKgwqAgc3RywqDCoMKgwqAgeDEsIFt4
MF0KPj4gwqDCoMKgwqAgNDYzYzrCoMKgwqDCoMKgwqAgZDY1ZjAzYzDCoMKgwqDCoMKgwqDCoCBy
ZXQKPj4KPiAKPiAuCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
