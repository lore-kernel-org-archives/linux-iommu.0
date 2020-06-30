Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BD6C433DF
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 12:43:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ABA620774
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 12:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="puWqgxQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABA620774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 267718869F;
	Tue, 30 Jun 2020 12:43:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rh5dLzhuPSZa; Tue, 30 Jun 2020 12:43:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 49DF3883F1;
	Tue, 30 Jun 2020 12:43:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F06CC088F;
	Tue, 30 Jun 2020 12:43:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89D44C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 12:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7F1A287D9E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 12:43:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ot2-1+3mJb00 for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 12:43:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D466C87D9D
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 12:43:01 +0000 (UTC)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5efb33240000>; Tue, 30 Jun 2020 05:42:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 30 Jun 2020 05:43:01 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 30 Jun 2020 05:43:01 -0700
Received: from [10.26.75.203] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 12:42:54 +0000
Subject: Re: [PATCH v8 3/3] iommu/arm-smmu: Add global/context fault
 implementation hooks
To: Robin Murphy <robin.murphy@arm.com>, Krishna Reddy <vdumpa@nvidia.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-4-vdumpa@nvidia.com>
 <4b4b20af-7baa-0987-e40d-af74235153f6@nvidia.com>
 <6c2ce909-c71b-351f-79f5-b1a4b4c0e4ac@arm.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <fd1f1102-ab05-002a-a86a-d3c6cef21e01@nvidia.com>
Date: Tue, 30 Jun 2020 13:42:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <6c2ce909-c71b-351f-79f5-b1a4b4c0e4ac@arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593520932; bh=hK3xWsoaF4cxDik6Mhq5qaTx82gKOLvVl8GbV1br+EM=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=puWqgxQA8yIruffJjHDVkJAi+UFOYN1pn9OAiXwGvywkKRxjWFtBhUaip1YoThldr
 i6NHZ/dtKAjI+ln4Q1pE/KqNNlnUyluMJWqRyzuo/t91r1WMqbicqPfWCCQfx+fvuQ
 9NXOzVNUNZWMkxYN5++mPnQCMwjlfc9ZOiifR0/dSrwRbbHDHUpyGt6S6pI2K1RXDB
 xuE3VAKgS4D2NXdlBAtGsx9f6aNRLRdRZV1Cq3f/maRdn2uW4ti2PRd18RZPpqrg4e
 LqvR5JhOSxqw0tbBOpNj9MgYkrYITBUBAcsKIlpbugPsPSgP09fFVixBvKQSSvPNMp
 STDwB7x62E+0g==
Cc: talho@nvidia.com, treding@nvidia.com, bhuntsman@nvidia.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mperttunen@nvidia.com, nicoleotsuka@gmail.com, snikam@nvidia.com,
 nicolinc@nvidia.com, linux-tegra@vger.kernel.org, yhsu@nvidia.com,
 praithatha@nvidia.com, will@kernel.org, linux-arm-kernel@lists.infradead.org,
 bbiswas@nvidia.com
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

Ck9uIDMwLzA2LzIwMjAgMTM6MTMsIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMDIwLTA2LTMw
IDA5OjM3LCBKb24gSHVudGVyIHdyb3RlOgo+Pgo+PiBPbiAzMC8wNi8yMDIwIDAxOjEwLCBLcmlz
aG5hIFJlZGR5IHdyb3RlOgo+Pj4gQWRkIGdsb2JhbC9jb250ZXh0IGZhdWx0IGhvb2tzIHRvIGFs
bG93IE5WSURJQSBTTU1VIGltcGxlbWVudGF0aW9uCj4+PiBoYW5kbGUgZmF1bHRzIGFjcm9zcyBt
dWx0aXBsZSBTTU1Vcy4KPj4KPj4gTml0IC4uLiB0aGlzIGlzIG5vdCBqdXN0IGZvciBOVklESUEs
IGJ1dCB0aGlzIGFsbG93cyBhbnlvbmUgdG8gYWRkCj4+IGN1c3RvbSBnbG9iYWwvY29udGV4dCBh
bmQgZmF1bHQgaG9va3MuIFNvIEkgdGhpbmsgdGhhdCB0aGUgY2hhbmdlbG9nCj4+IHNob3VsZCBi
ZSBjbGVhciB0aGF0IHRoaXMgY2hhbmdlIHBlcm1pdHMgY3VzdG9tIGZhdWx0IGhvb2tzIGFuZCB0
aGF0Cj4+IGN1c3RvbSBmYXVsdCBob29rcyBhcmUgbmVlZGVkIGZvciB0aGUgVGVncmExOTQgU01N
VS4gWW91IG1heSBhbHNvIHdhbnQKPj4gdG8gc2F5IHdoeS4KPj4KPj4+Cj4+PiBTaWduZWQtb2Zm
LWJ5OiBLcmlzaG5hIFJlZGR5IDx2ZHVtcGFAbnZpZGlhLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJp
dmVycy9pb21tdS9hcm0tc21tdS1udmlkaWEuYyB8IDk4ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwo+Pj4gwqAgZHJpdmVycy9pb21tdS9hcm0tc21tdS5jwqDCoMKgwqDCoMKgwqAg
fCAxNyArKysrKy0KPj4+IMKgIGRyaXZlcnMvaW9tbXUvYXJtLXNtbXUuaMKgwqDCoMKgwqDCoMKg
IHzCoCAzICsKPj4+IMKgIDMgZmlsZXMgY2hhbmdlZCwgMTE2IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCgouLi4KCj4+PiBAQCAtODM1LDcgKzgzNiwxMyBAQCBzdGF0aWMgaW50IGFybV9z
bW11X2luaXRfZG9tYWluX2NvbnRleHQoc3RydWN0Cj4+PiBpb21tdV9kb21haW4gKmRvbWFpbiwK
Pj4+IMKgwqDCoMKgwqDCoCAqIGhhbmRsZXIgc2VlaW5nIGEgaGFsZi1pbml0aWFsaXNlZCBkb21h
aW4gc3RhdGUuCj4+PiDCoMKgwqDCoMKgwqAgKi8KPj4+IMKgwqDCoMKgwqAgaXJxID0gc21tdS0+
aXJxc1tzbW11LT5udW1fZ2xvYmFsX2lycXMgKyBjZmctPmlycHRuZHhdOwo+Pj4gLcKgwqDCoCBy
ZXQgPSBkZXZtX3JlcXVlc3RfaXJxKHNtbXUtPmRldiwgaXJxLCBhcm1fc21tdV9jb250ZXh0X2Zh
dWx0LAo+Pj4gKwo+Pj4gK8KgwqDCoCBpZiAoc21tdS0+aW1wbCAmJiBzbW11LT5pbXBsLT5jb250
ZXh0X2ZhdWx0KQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGNvbnRleHRfZmF1bHQgPSBzbW11LT5pbXBs
LT5jb250ZXh0X2ZhdWx0Owo+Pj4gK8KgwqDCoCBlbHNlCj4+PiArwqDCoMKgwqDCoMKgwqAgY29u
dGV4dF9mYXVsdCA9IGFybV9zbW11X2NvbnRleHRfZmF1bHQ7Cj4+Cj4+IFdoeSBub3Qgc2VlIHRo
ZSBkZWZhdWx0IHNtbXUtPmltcGwtPmNvbnRleHRfZmF1bHQgdG8KPj4gYXJtX3NtbXVfY29udGV4
dF9mYXVsdCBpbiBhcm1fc21tdV9pbXBsX2luaXQoKSBhbmQgdGhlbiBhbGxvdyB0aGUKPj4gdmFy
aW91cyBpbXBsZW1lbnRhdGlvbnMgdG8gb3ZlcnJpZGUgYXMgbmVjZXNzYXJ5PyBUaGVuIHlvdSBj
YW4gZ2V0IHJpZAo+PiBvZiB0aGlzIGNvbnRleHRfZmF1bHQgdmFyaWFibGUgaGVyZSBhbmQganVz
dCB1c2UKPj4gc21tdS0+aW1wbC0+Y29udGV4dF9mYXVsdCBiZWxvdy4KPiAKPiBCZWNhdXNlIHRo
ZSBkZWZhdWx0IHNtbXUtPmltcGwgaXMgTlVMTC4gQW5kIGFzIEkndmUgc2FpZCBiZWZvcmUsIE5B
SyB0bwo+IGZvcmNpbmcgdGhlIGNvbW1vbiBjYXNlIHRvIGFsbG9jYXRlIGEgc2V0IG9mICJxdWly
a3MiIHB1cmVseSB0byBvdmVycmlkZQo+IHRoZSBkZWZhdWx0IElSUSBoYW5kbGVyIHdpdGggdGhl
IGRlZmF1bHQgSVJRIGhhbmRsZXIgOykKCgpBaCBPSywgbWFrZXMgc2Vuc2UuIFNvcnJ5IEkgYW0g
YSBiaXQgbGF0ZSB0byB0aGUgcmV2aWV3IDotKQoKSm9uCgotLSAKbnZwdWJsaWMKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
