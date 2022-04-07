Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C646C433EF
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 13:59:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97F5D4099A;
	Thu,  7 Apr 2022 13:59:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qc-ljmBPcx6d; Thu,  7 Apr 2022 13:59:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 356164033C;
	Thu,  7 Apr 2022 13:59:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01787C002C;
	Thu,  7 Apr 2022 13:59:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B022C0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 13:59:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF2AA8404F
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 13:59:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fcn75mNVA28j for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 13:59:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A62B83FB2
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 13:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=Wz4hNkxsawX4PgHGVpqI7DcWA7D+ygHUR+Jezxq/sok=; b=p8lu6HeON3HuIqNpvtMeUF8UAq
 8f/e/8K+TvocGaKgfxOWSnIxVRfDL+25cIGEQltU/vpsnWLs2u/cG7YeDVQXUgeJTiZe8j2EoesMO
 Loeu+j1y4VJZO8fvV1AahrwbE4sG/A7yD4tJRVr6AmEOKACG84SlM1jp/JtepWhAi6LmBp+BOUfit
 ZzxkGfAGEayAyrxcI5txuKnCg1fXhQZD6P7u8aBmmg/d1yEN9g1AP9lVPYA9bu9GpcDVKq2+Jd3E5
 hODo+PqENwnnZJ56le4zI75STD1YwMVBU/WUTN5Qub3jEdLXTyVUXKJ7TBMWmS0f4KEG1o3wCfRSO
 NfTZduow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1ncSfc-00CGaB-Oy; Thu, 07 Apr 2022 13:59:32 +0000
Date: Thu, 7 Apr 2022 06:59:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v9 06/11] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Message-ID: <Yk7uRPG1TwGFPbyY@infradead.org>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
 <20220404124209.1086-7-shameerali.kolothum.thodi@huawei.com>
 <Yk7m8oDPtusDzReK@infradead.org>
 <b50cded6-6777-c9c7-7030-a57f28771bc3@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b50cded6-6777-c9c7-7030-a57f28771bc3@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
 Christoph Hellwig <hch@infradead.org>, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
 will@kernel.org, wanghuiqiang@huawei.com
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

T24gVGh1LCBBcHIgMDcsIDIwMjIgYXQgMDI6NTM6MzhQTSArMDEwMCwgUm9iaW4gTXVycGh5IHdy
b3RlOgo+ID4gV2h5IGNhbid0IHRoaXMganVzdCBnbyBpbnRvIGdlbmVyaWNfaW9tbXVfcHV0X3Jl
c3ZfcmVnaW9ucz8gIFRoZSBpZGVhCj4gPiB0aGF0IHRoZSBpb21tdSBsb3ctbGV2ZWwgZHJpdmVy
cyBuZWVkIHRvIGNhbGwgaW50byBkbWEtaW9tbXUgd2hpY2ggaXMKPiA+IGEgY29uc3VtZXIgb2Yg
dGhlIElPTU1VIEFQSSBpcyBvZGQuICBFc3BlY2lhbGx5IGlmIHRoYXQganVzdCBjYWxscyBvdXQK
PiA+IHRvIEFDUEkgY29kZSBhbmQgZ2VuZXJpYyBJT01NVSBjb2RlIG9ubHkgYW55d2F5Lgo+IAo+
IEJlY2F1c2UgYXNzdW1pbmcgQUNQSSBtZWFucyBJT1JUIGlzIG5vdCBnZW5lcmljLiBQYXJ0IG9m
IHRoZSBhaW0gaW4gYWRkaW5nCj4gdGhlIHVuaW9uIHRvIGlvbW11X3Jlc3ZfcmVnaW9uIGlzIHRo
YXQgc3R1ZmYgbGlrZSBBTUQncyB1bml0eV9tYXBfZW50cnkgYW5kCj4gSW50ZWwncyBkbWFyX3Jt
cnJfdW5pdCBjYW4gYmUgZm9sZGVkIGludG8gaXQgYXMgd2VsbCwgYW5kIHRoZWlyIHJlc2VydmVk
Cj4gcmVnaW9uIGhhbmRsaW5nIGNvcnJlc3BvbmRpbmdseSBzaW1wbGlmaWVkIHRvby4KPiAKPiBU
aGUgaW9tbXVfZG1hX3tnZXQscHV0fV9yZXN2X3JlZ2lvbigpIGhlbHBlcnMgYXJlIGtpbmQgb2Yg
aW50ZW5kZWQgdG8gYmUKPiBzcGVjaWZpYyB0byB0aGUgZndub2RlIG1lY2hhbmlzbSB3aGljaCBk
ZWFscyB3aXRoIElPUlQgYW5kIGRldmljZXRyZWUgKG9uY2UKPiB0aGUgcmVzZXJ2ZWQgcmVnaW9u
IGJpbmRpbmdzIGFyZSBmdWxseSB3b3JrZWQgb3V0KS4KCkJ1dCBJT1JUIGlzIG5vdCBkcml2ZXLi
gotzcGVjaWZpYyBjb2RlLiAgU28gd2UnbGwgbmVlZCBhIFVTRV9JT1JUIGZsYWcKc29tZXdoZXJl
IGluIGNvcmUgSU9NTVUgY29kZSBpbnN0ZWFkIG9mIHRyeWluZyB0byBzdHVmZiB0aGlzIGludG8K
ZHJpdmVyIG9wZXJhdGlvbnMuICBhbmQgZG1hLWlvbW11IG1vc3RseSBjZXJ0YWlubHkgaW1wbGll
cyBJT1JUIGV2ZW4KbGVzcyB0aGFuIEFDUEkuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
