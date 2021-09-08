Return-Path: <SRS0=xpAE=N6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155FDC433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Sep 2021 05:07:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D84A61152
	for <iommu@archiver.kernel.org>; Wed,  8 Sep 2021 05:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7D84A61152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 366524029F;
	Wed,  8 Sep 2021 05:07:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pQh9Q5R535wY; Wed,  8 Sep 2021 05:07:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D9A0240250;
	Wed,  8 Sep 2021 05:07:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B09C4C0011;
	Wed,  8 Sep 2021 05:07:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18F13C000D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Sep 2021 05:07:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E870382F9E
 for <iommu@lists.linux-foundation.org>; Wed,  8 Sep 2021 05:07:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a11kiVZLK51T for <iommu@lists.linux-foundation.org>;
 Wed,  8 Sep 2021 05:07:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E393982F99
 for <iommu@lists.linux-foundation.org>; Wed,  8 Sep 2021 05:07:02 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H498H3zbjz1DGQQ;
 Wed,  8 Sep 2021 13:06:07 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 13:06:58 +0800
Received: from [10.174.185.210] (10.174.185.210) by
 dggema765-chm.china.huawei.com (10.1.198.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 8 Sep 2021 13:06:58 +0800
Subject: Re: [question] Assign multiple devices from different SMMUs to a
 arm_smmu_domain
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Linux
 IOMMU" <iommu@lists.linux-foundation.org>, open list
 <linux-kernel@vger.kernel.org>
References: <bbfcb875-0da1-c303-ed48-fdaa890c89b3@huawei.com>
 <202f32cd-8036-563e-028b-781b999766be@arm.com>
From: Kunkun Jiang <jiangkunkun@huawei.com>
Message-ID: <d788d448-f2f2-1cb5-440c-d59dbdd27eab@huawei.com>
Date: Wed, 8 Sep 2021 13:06:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <202f32cd-8036-563e-028b-781b999766be@arm.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggeme709-chm.china.huawei.com (10.1.199.105) To
 dggema765-chm.china.huawei.com (10.1.198.207)
X-CFilter-Loop: Reflected
Cc: wanghaibin.wang@huawei.com
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

T24gMjAyMS85LzcgMTc6NDMsIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMDIxLTA5LTA3IDA4
OjQxLCBLdW5rdW4gSmlhbmcgd3JvdGU6Cj4+IEhpIGFsbCwKPj4KPj4gSSBhbSB3b3JraW5nIG9u
IFZGSU8gRE1BIGRpcnR5IHBhZ2VzIHRyYWNraW5nIGJhc2VkIG9uIEFSTSBTTU1VIEhUVFUsCj4+
IGFuZCBoYXZlIGRvbmUgYSBsb3Qgb2YgdGVzdGluZy5JbiB0aGUgdGVzdCwgSSBmb3VuZCBhIHBy
b2JsZW0gdGhhdCAKPj4gZ3JlYXRseSBhZmZlY3RzCj4+IHBlcmZvcm1hbmNlIG9mIFZGSU8gRE1B
IGRpcnR5IHBhZ2VzIHRyYWNraW5nLgo+Pgo+PiBBY2NvcmRpbmcgdG8gdGhlIGN1cnJlbnQgYXJt
LXNtbXUtdjMgZHJpdmVyLCBtdWx0aXBsZSBWRklPIHBhc3MtdGhyb3VnaAo+PiBkZXZpY2UgY29t
ZXMgZnJvbSBkaWZmZXJlbnQgU01NVXMgd2lsbCBiZSBhc3NpZ25lZCB0byBkaWZmZXJlbnQKPj4g
YXJtX3NtbXVfZG9tYWluLiBJdCB3aWxsIGNyZWF0ZSBwYWdlIHRhYmxlIGZvciBlYWNoIGFybV9z
bW11X2RvbWFpbiwKPj4gZXZlbiB0aG91Z2ggdGhlc2UgcGFnZSB0YWJsZXMgYXJlIGV4YWN0bHkg
dGhlIHNhbWUuIEJhY2F1c2UgZGlydHkgcGFnZXMKPj4gdHJhY2tpbmcgbmVlZHMgdG8gdHJhdmVy
c2UgdGhlIHBhZ2UgdGFibGUsIG11bHRpcGxlIHBhZ2UgdGFibGVzIHdpbGwgCj4+IG1ha2UKPj4g
cGVyZm9ybWFuY2Ugd29yc2UuCj4+Cj4+IEkgbGVhcm5lZCB0aGUgQVJNIFNNTVV2MyBzcGVjIGFu
ZCBoYWQgc29tZSBleGNoYW5nZXMgd2l0aCBteSBjb2xsZWFndWVzCj4+IHdobyB3b3JrIG9uIFNN
TVUgaGFyZHdhcmUuIEkgZGlkIG5vdCBmaW5kIHRoZSByZXN0cmljdGlvbiB0aGF0IG11bHRpcGxl
Cj4+IFNNTVVzIGNhbm5vdCBzaGFyZSB0aGUgc2FtZSBwYWdlIHRhYmxlLiBXZSBtaWd0aCBiZSBh
YmxlIHRvIGRvIHRoaXMgbGlrZQo+PiB4ODYgSU9NTVUuIElmIEkgaGF2ZSBtaXNzZWQgc29tZXRo
aW5nLCBwbGVhc2UgcG9pbnQgaXQgb3V0Lgo+Cj4gU3VyZSwgaXQncyBub3QgaW1wb3NzaWJsZSwg
dGhlcmUgYXJlIGp1c3QgYSBsb3Qgb2YgZmlkZGx5IAo+IGNvbnNpZGVyYXRpb25zLCBtb3N0bHkg
YXJvdW5kIGhvdyB0byBoYW5kbGUgU01NVSBpbnN0YW5jZXMgd2l0aCAKPiBkaWZmZXJlbnQgY2Fw
YWJpbGl0aWVzLiBXZSBoYXZlbid0IGhhZCBhIHN0cm9uZyBuZWVkIHRvIHN1cHBvcnQgdGhpcyAK
PiBjYXNlIHNvIGZhciwgc28gd2UndmUgc2ltcGx5IGJlZW4gYXZvaWRpbmcgYWxsIHRoYXQgY29t
cGxleGl0eS4KWWVzLCB0aGVyZSdzIGEgbG90IHRvIGNvbnNpZGVyIGhlcmUuIEknbGwgdHJ5IHRv
IGFuYWx5emUgaXQgY2FyZWZ1bGx5LiAKV2UgY2FuIGRpc2N1c3MKc29tZSBvZiB0aGUgZGlmZmlj
dWx0aWVzIGluIHRoZSBmdXR1cmUuIEZyb20gdGhlIHBlcnNwZWN0aXZlIG9mIAppbXByb3Zpbmcg
dGhlCnBlcmZvcm1hbmNlIG9mIFZGSU8gRE1BIGRpcnR5IHBhZ2VzIHRyYWNraW5nLCBpdCBpcyB3
b3J0aCBzdXBwb3J0aW5nIAp0aGlzIGZlYXR1cmUuCgpUaGFua3MsCkt1bmt1biBKaWFuZwo+Cj4g
Um9iaW4uCj4KPj4gTG9va2luZyBmb3J3YXJkIHRvIHlvdXIgc3VnZ2VzdGlvbnMu8J+YgQo+Pgo+
PiBUaGFua3MsCj4+IEt1bmt1biBKaWFuZwo+Pgo+IC4KCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
