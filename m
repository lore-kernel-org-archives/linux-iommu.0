Return-Path: <SRS0=d1gY=H3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732DFC433E0
	for <iommu@archiver.kernel.org>; Thu, 25 Feb 2021 13:56:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD57A64F06
	for <iommu@archiver.kernel.org>; Thu, 25 Feb 2021 13:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD57A64F06
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34C5E4EE37;
	Thu, 25 Feb 2021 13:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9dkFtALV5jW6; Thu, 25 Feb 2021 13:56:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4D374EE33;
	Thu, 25 Feb 2021 13:56:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFDCCC000A;
	Thu, 25 Feb 2021 13:56:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEC82C0001
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 13:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 90F2383F32
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 13:56:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T9JOLCEgdWDm for <iommu@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 13:56:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E55C683F2E
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 13:56:11 +0000 (UTC)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DmYzH6zGtz67rV8;
 Thu, 25 Feb 2021 21:48:43 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 25 Feb 2021 14:56:05 +0100
Received: from [10.47.1.158] (10.47.1.158) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 25 Feb
 2021 13:56:04 +0000
From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/1] Revert "iommu/iova: Retry from last rb tree node if
 iova search fails"
To: Robin Murphy <robin.murphy@arm.com>, "Leizhen (ThunderTown)"
 <thunder.leizhen@huawei.com>, Will Deacon <will@kernel.org>, Joerg Roedel
 <joro@8bytes.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
References: <20210129092120.1482-1-thunder.leizhen@huawei.com>
 <5505b1e5-2450-d5c4-6d77-5bb21fd0b6a1@huawei.com>
 <e8ff095f-7b7c-da38-3675-cd3c1ee84b1a@arm.com>
Message-ID: <7e18829a-3e7e-cc82-9d33-366cf2025624@huawei.com>
Date: Thu, 25 Feb 2021 13:54:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <e8ff095f-7b7c-da38-3675-cd3c1ee84b1a@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.1.158]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Vijayanand Jitta <vjitta@codeaurora.org>, Linuxarm <linuxarm@huawei.com>
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

T24gMjkvMDEvMjAyMSAxMjowMywgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjEtMDEtMjkg
MDk6NDgsIExlaXpoZW4gKFRodW5kZXJUb3duKSB3cm90ZToKPj4KPj4gQ3VycmVudGx5LCB3ZSBh
cmUgdGhpbmtpbmcgYWJvdXQgdGhlIHNvbHV0aW9uIHRvIHRoZSBwcm9ibGVtLiBIb3dldmVyLCAK
Pj4gYmVjYXVzZSB0aGUgZW5kIHRpbWUgb2YgdjUuMTEgaXMgYXBwcm9hY2hpbmcsIHRoaXMgcGF0
Y2ggaXMgc2VudCBmaXJzdC4KPiAKPiBIb3dldmVyLCB0aGF0IGNvbW1pdCB3YXMgbWFkZSBmb3Ig
YSByZWFzb24gLSBob3cgZG8gd2UganVzdGlmeSB0aGF0IG9uZSAKPiB0aGluZyBiZWluZyBzbG93
IGlzIG1vcmUgaW1wb3J0YW50IHRoYW4gYW5vdGhlciB0aGluZyBiZWluZyBjb21wbGV0ZWx5IAo+
IGJyb2tlbj8gSXQncyBub3QgcHJhY3RpY2FsIHRvIGp1c3Qga2VlcCBkb2luZyB0aGUgcGF0Y2gg
aG9rZXktY29rZXkgCj4gYmFzZWQgb24gd2hvZXZlciBzaG91dHMgbG91ZGVzdCA6KAo+IAo+PiBP
biAyMDIxLzEvMjkgMTc6MjEsIFpoZW4gTGVpIHdyb3RlOgo+Pj4gVGhpcyByZXZlcnRzIGNvbW1p
dCA0ZTg5ZGNlNzI1MjEzZDNkMGIwNDc1MjExYjUwMGVkYTRlZjRiZjJmLgo+Pj4KPj4+IFdlIGZp
bmQgdGhhdCB0aGlzIHBhdGNoIGhhcyBhIGdyZWF0IGltcGFjdCBvbiBwZXJmb3JtYW5jZS4gQWNj
b3JkaW5nIHRvCj4+PiBvdXIgdGVzdDogdGhlIGlvcHMgZGVjcmVhc2VzIGZyb20gMTY1NS42SyB0
byA4OTMuNUssIGFib3V0IGhhbGYuCj4+Pgo+Pj4gSGFyZHdhcmU6IDEgU0FTIGV4cGFuZGVyIHdp
dGggMTIgU0FTIFNTRAo+Pj4gQ29tbWFuZDrCoCBPbmx5IHRoZSBtYWluIHBhcmFtZXRlcnMgYXJl
IGxpc3RlZC4KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZpbyBicz00ayBydz1yZWFkIGlvZGVw
dGg9MTI4IGNwdXNfYWxsb3dlZD0wLTEyNwo+IAo+IEZXSVcsIEknbSA5OSUgc3VyZSB0aGF0IHdo
YXQgeW91IHJlYWxseSB3YW50IGlzIFsxXSwgYnV0IHRoZW4geW91IGdldCB0byAKPiBiYXR0bGUg
YWdhaW5zdCBhbiB1bmtub3duIHF1YW50aXR5IG9mIGRvZGd5IGZpcm13YXJlIGluc3RlYWQuCj4K
ClNvbWV0aGluZyB3aGljaCBoYXMgbm90IGJlZW4gc2FpZCBiZWZvcmUgaXMgdGhhdCB0aGlzIG9u
bHkgaGFwcGVucyBmb3IgCnN0cmljdCBtb2RlLgoKQW55d2F5LCB3ZSBzZWUgfjUwJSB0aHJvdWdo
cHV0IHJlZ3Jlc3Npb24sIHdoaWNoIGlzIGludG9sZXJhYmxlLiBBcyBzZWVuIAppbiBbMF0sIEkg
cHV0IHRoaXMgZG93biB0byB0aGUgZmFjdCB0aGF0IHdlIGhhdmUgc28gbWFueSBJT1ZBIHJlcXVl
c3RzIAp3aGljaCBleGNlZWQgdGhlIHJjYWNoZSBzaXplIGxpbWl0LCB3aGljaCBtZWFucyBtYW55
IFJCIHRyZWUgYWNjZXNzZXMgCmZvciBub24tY2FjaGVibGUgSU9WQXMsIHdoaWNoIGFyZSBub3cg
c2xvd2VyLgoKT24gYW5vdGhlciBwb2ludCwgYXMgZm9yIGxvbmd0ZXJtIElPVkEgYWdpbmcgaXNz
dWUsIGl0IHNlZW1zIHRoYXQgdGhlcmUgCmlzIG5vIGNvbmNsdXNpb24gdGhlcmUuIEhvd2V2ZXIg
SSBkaWQgbWVudGlvbiB0aGUgaXNzdWUgb2YgSU9WQSBzaXplcyAKZXhjZWVkaW5nIHJjYWNoZSBz
aXplIGZvciB0aGF0IGlzc3VlLCBzbyBtYXliZSB3ZSBjYW4gZmluZCBhIGNvbW1vbiAKc29sdXRp
b24uIFNpbWlsYXIgdG8gYSBmaXhlZCByY2FjaGUgZGVwb3Qgc2l6ZSwgaXQgc2VlbXMgdGhhdCBo
YXZpbmcgYSAKZml4ZWQgcmNhY2hlIG1heCBzaXplIHJhbmdlIHZhbHVlIChhdCA2KSBkb2Vzbid0
IHNjYWxlIGVpdGhlci4KCkFzIGZvciA0ZTg5ZGNlNzI1MjEsIHNvIGV2ZW4gaWYgaXQncyBwcm9w
ZXIgdG8gcmV0cnkgZm9yIGEgZmFpbGVkIGFsbG9jLCAKaXQgaXMgbm90IGFsd2F5cyBuZWNlc3Nh
cnkuIEkgbWVhbiwgaWYgd2UncmUgbGltaXRpbmcgb3Vyc2VsdmVzIHRvIDMyYiAKc3Vic3BhY2Ug
Zm9yIHRoaXMgU0FDIHRyaWNrIGFuZCB3ZSBmYWlsIHRoZSBhbGxvYywgdGhlbiB3ZSBjYW4gdHJ5
IHRoZSAKc3BhY2UgYWJvdmUgMzJiIGZpcnN0IChpZiB1c2FibGUpLiBJZiB0aGF0IGZhaWxzLCB0
aGVuIHJldHJ5IHRoZXJlLiBJIApkb24ndCBzZWUgYSBuZWVkIHRvIHJldHJ5IHRoZSAzMmIgc3Vi
c3BhY2UgaWYgd2UncmUgbm90IGxpbWl0ZWQgdG8gaXQuIApIb3cgYWJvdXQgaXQ/IFdlIHRyaWVk
IHRoYXQgaWRlYSBhbmQgaXQgbG9va3MgdG8ganVzdCBhYm91dCByZXN0b3JlIApwZXJmb3JtYW5j
ZS4KClRoYW5rcywKSm9obgoKWzBdIApodHRwczovL3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20v
aGlzaWxpY29uL2tlcm5lbC1kZXYvdG9waWMtaW9tbXUtNS4xMC1pb3ZhLWRlYnVnLXYzL2FnaW5n
X3Rlc3QKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
