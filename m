Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5676FC433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 16:25:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E6A65006
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 16:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E6A65006
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABA6E839B4;
	Fri, 12 Mar 2021 16:25:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YvyDEuBP8vMt; Fri, 12 Mar 2021 16:25:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88E5D834F7;
	Fri, 12 Mar 2021 16:25:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FD84C000A;
	Fri, 12 Mar 2021 16:25:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0C7FC0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 16:25:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 946D283A8E
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 16:25:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hSPFsJ1tmLaN for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 16:25:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC5B4834F7
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 16:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=z71Dy4S8XtDaYoM2XRkuE2wAHe2/+OE53EIe7Kw+TNU=; b=HqXLStXu7JHag3wGbK3mOgF/M8
 gsYjKlyGMCNs6Kp2trWSjJWEdoTTL7l0upjMGEke4ssz2qv6SN3QkQZ8mcg+a143IC5xIOM3SURoN
 lw4HuqO4LhNWzh1WAKj6/9SxZhr2mvmmvBMwjW/oqcvFMPefmD+CQ/sZD2cfS3DQ9XdARnulhX379
 XEmUxtLccrt+N+K+iBiVDqkj/U2P4KyQUA3p6kqQsHQwLLUNipLb7OSQ8YfLEh8+nzalEco/na8NL
 WnrW6BHAXcHt9X8Oyt7VfthZmCHT2QggtvHtaFRpzf4jqY5LDY0Xy1Vgj3qD6rJy+XfYFYP5DTIA3
 2H01sjhg==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1lKkar-0007E2-BR; Fri, 12 Mar 2021 09:24:54 -0700
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-7-logang@deltatee.com>
 <215e1472-5294-d20a-a43a-ff6dfe8cd66e@arm.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d7ead722-7356-8e0f-22de-cb9dea12b556@deltatee.com>
Date: Fri, 12 Mar 2021 09:24:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <215e1472-5294-d20a-a43a-ff6dfe8cd66e@arm.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, hch@lst.de,
 andrzej.jakowski@intel.com, sbates@raithlin.com, dan.j.williams@intel.com,
 daniel.vetter@ffwll.ch, jason@jlekstrand.net, jgg@ziepe.ca,
 christian.koenig@amd.com, willy@infradead.org, iweiny@intel.com,
 dave.hansen@linux.intel.com, jhubbard@nvidia.com, dave.b.minturn@intel.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 robin.murphy@arm.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH v2 06/11] dma-direct: Support PCI P2PDMA pages in
 dma-direct map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ira Weiny <iweiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Matthew Wilcox <willy@infradead.org>, Stephen Bates <sbates@raithlin.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jason Ekstrand <jason@jlekstrand.net>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

CgpPbiAyMDIxLTAzLTEyIDg6NTIgYS5tLiwgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiArCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBzZy0+ZG1hX2FkZHJlc3MgPSBkbWFfZGlyZWN0X21hcF9wYWdlKGRl
diwgc2dfcGFnZShzZyksCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2ct
Pm9mZnNldCwgc2ctPmxlbmd0aCwgZGlyLCBhdHRycyk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoc2ctPmRtYV9hZGRyZXNzID09IERNQV9NQVBQSU5HX0VSUk9SKQo+PiBAQCAtNDExLDcgKzQ0
MCw3IEBAIGludCBkbWFfZGlyZWN0X21hcF9zZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdAo+
PiBzY2F0dGVybGlzdCAqc2dsLCBpbnQgbmVudHMsCj4+IMKgIMKgIG91dF91bm1hcDoKPj4gwqDC
oMKgwqDCoCBkbWFfZGlyZWN0X3VubWFwX3NnKGRldiwgc2dsLCBpLCBkaXIsIGF0dHJzIHwKPj4g
RE1BX0FUVFJfU0tJUF9DUFVfU1lOQyk7Cj4+IC3CoMKgwqAgcmV0dXJuIDA7Cj4+ICvCoMKgwqAg
cmV0dXJuIHJldDsKPj4gwqAgfQo+PiDCoCDCoCBkbWFfYWRkcl90IGRtYV9kaXJlY3RfbWFwX3Jl
c291cmNlKHN0cnVjdCBkZXZpY2UgKmRldiwgcGh5c19hZGRyX3QKPj4gcGFkZHIsCj4+IGRpZmYg
LS1naXQgYS9rZXJuZWwvZG1hL21hcHBpbmcuYyBiL2tlcm5lbC9kbWEvbWFwcGluZy5jCj4+IGlu
ZGV4IGI2YTYzMzY3OTkzMy4uYWRjMWE4Mzk1MGJlIDEwMDY0NAo+PiAtLS0gYS9rZXJuZWwvZG1h
L21hcHBpbmcuYwo+PiArKysgYi9rZXJuZWwvZG1hL21hcHBpbmcuYwo+PiBAQCAtMTc4LDggKzE3
OCwxNSBAQCB2b2lkIGRtYV91bm1hcF9wYWdlX2F0dHJzKHN0cnVjdCBkZXZpY2UgKmRldiwKPj4g
ZG1hX2FkZHJfdCBhZGRyLCBzaXplX3Qgc2l6ZSwKPj4gwqAgRVhQT1JUX1NZTUJPTChkbWFfdW5t
YXBfcGFnZV9hdHRycyk7Cj4+IMKgIMKgIC8qCj4+IC0gKiBkbWFfbWFwc19zZ19hdHRycyByZXR1
cm5zIDAgb24gZXJyb3IgYW5kID4gMCBvbiBzdWNjZXNzLgo+PiAtICogSXQgc2hvdWxkIG5ldmVy
IHJldHVybiBhIHZhbHVlIDwgMC4KPj4gKyAqIGRtYV9tYXBzX3NnX2F0dHJzIHJldHVybnMgMCBv
biBhbnkgcmVzb3VyY2UgZXJyb3IgYW5kID4gMCBvbiBzdWNjZXNzLgo+PiArICoKPj4gKyAqIElm
IDAgaXMgcmV0dXJuZWQsIHRoZSBtYXBwaW5nIGNhbiBiZSByZXRyaWVkIGFuZCB3aWxsIHN1Y2Nl
ZWQgb25jZQo+PiArICogc3VmZmljaWVudCByZXNvdXJjZXMgYXJlIGF2YWlsYWJsZS4KPiAKPiBU
aGF0J3Mgbm90IGEgZ3VhcmFudGVlIHdlIGNhbiB1cGhvbGQuIFJldHJ5aW5nIGZvcmV2ZXIgaW4g
dGhlIHZhaW4gaG9wZQo+IHRoYXQgYSBkZXZpY2UgbWlnaHQgZXZvbHZlIHNvbWUgZXh0cmEgYWRk
cmVzcyBiaXRzLCBvciBhIGJvdW5jZSBidWZmZXIKPiBtaWdodCBtYWdpY2FsbHkgZ3JvdyBiaWcg
ZW5vdWdoIGZvciBhIGdpZ2FudGljIG1hcHBpbmcsIGlzbid0Cj4gbmVjZXNzYXJpbHkgdGhlIGJl
c3QgaWRlYS4KClBlcmhhcHMgdGhpcyBpcyBqdXN0IHBvb3JseSB3b3JkZWQuIFJldHVybmluZyAw
IGlzIHRoZSBub3JtYWwgY2FzZSBhbmQKbm90aGluZyBoYXMgY2hhbmdlZCB0aGVyZS4gVGhlIGJs
b2NrIGxheWVyLCBmb3IgZXhhbXBsZSwgd2lsbCByZXRyeSBpZgp6ZXJvIGlzIHJldHVybmVkIGFz
IHRoaXMgb25seSBoYXBwZW5zIGlmIGl0IGZhaWxlZCB0byBhbGxvY2F0ZSByZXNvdXJjZXMKZm9y
IHRoZSBtYXBwaW5nLiBUaGUgcmVhc29uIHdlIGhhdmUgdG8gcmV0dXJuIC0xIGlzIHRvIHRlbGwg
dGhlIGJsb2NrCmxheWVyIG5vdCB0byByZXRyeSB0aGVzZSByZXF1ZXN0cyBhcyB0aGV5IHdpbGwg
bmV2ZXIgc3VjY2VlZCBpbiB0aGUgZnV0dXJlLgoKPj4gKyAqCj4+ICsgKiBJZiB0aGVyZSBhcmUg
UDJQRE1BIHBhZ2VzIGluIHRoZSBzY2F0dGVybGlzdCB0aGVuIHRoaXMgZnVuY3Rpb24gbWF5Cj4+
ICsgKiByZXR1cm4gLUVSRU1PVEVJTyB0byBpbmRpY2F0ZSB0aGF0IHRoZSBwYWdlcyBhcmUgbm90
IG1hcHBhYmxlIGJ5IHRoZQo+PiArICogZGV2aWNlLiBJbiB0aGlzIGNhc2UsIGFuIGVycm9yIHNo
b3VsZCBiZSByZXR1cm5lZCBmb3IgdGhlIElPIGFzIGl0Cj4+ICsgKiB3aWxsIG5ldmVyIGJlIHN1
Y2Nlc3NmdWxseSByZXRyaWVkLgo+PiDCoMKgICovCj4+IMKgIGludCBkbWFfbWFwX3NnX2F0dHJz
KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHNjYXR0ZXJsaXN0ICpzZywgaW50Cj4+IG5lbnRz
LAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZW51bSBkbWFfZGF0YV9kaXJlY3Rpb24gZGlyLCB1bnNp
Z25lZCBsb25nIGF0dHJzKQo+PiBAQCAtMTk3LDcgKzIwNCw3IEBAIGludCBkbWFfbWFwX3NnX2F0
dHJzKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0Cj4+IHNjYXR0ZXJsaXN0ICpzZywgaW50IG5l
bnRzLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZW50cyA9IGRtYV9kaXJlY3RfbWFwX3NnKGRldiwg
c2csIG5lbnRzLCBkaXIsIGF0dHJzKTsKPj4gwqDCoMKgwqDCoCBlbHNlCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCBlbnRzID0gb3BzLT5tYXBfc2coZGV2LCBzZywgbmVudHMsIGRpciwgYXR0cnMpOwo+
PiAtwqDCoMKgIEJVR19PTihlbnRzIDwgMCk7Cj4+ICsKPiAKPiBUaGlzIHNjYXJlcyBtZSAtIEkg
aGVzaXRhdGUgdG8gaW1hZ2luZSB0aGUgYW1vdW50IG9mIGRyaXZlci9zdWJzeXN0ZW0KPiBjb2Rl
IG91dCB0aGVyZSB0aGF0IHdpbGwgc2VlIG5vbnplcm8gYW5kIG1lcnJpbHkgc2V0IG9mZiBpdGVy
YXRpbmcgYQo+IG5lZ2F0aXZlIG51bWJlciBvZiBzZWdtZW50cywgaWYgd2Ugb3BlbiB0aGUgZmxv
b2RnYXRlcyBvZiBhbGxvd2luZwo+IGltcGxlbWVudGF0aW9ucyB0byByZXR1cm4gZXJyb3IgY29k
ZXMgaGVyZS4KClllcywgYnV0IGl0IHdpbGwgbmV2ZXIgaGFwcGVuIG9uIGV4aXN0aW5nIGRyaXZl
cnMvc3Vic3lzdGVtcy4gVGhlIG9ubHkKd2F5IGl0IGNhbiByZXR1cm4gYSBuZWdhdGl2ZSBudW1i
ZXIgaXMgaWYgdGhlIGRyaXZlciBwYXNzZXMgaW4gUDJQRE1BCnBhZ2VzIHdoaWNoIGNhbid0IGhh
cHBlbiB3aXRob3V0IGNoYW5nZXMgaW4gdGhlIGRyaXZlci4gV2UgYXJlIGNhcmVmdWwKYWJvdXQg
d2hlcmUgUDJQRE1BIHBhZ2VzIGNhbiBnZXQgaW50byBzbyB3ZSBkb24ndCBoYXZlIHRvIHdvcnJ5
IGFib3V0CmFsbCB0aGUgZXhpc3RpbmcgZHJpdmVyIGNvZGUgb3V0IHRoZXJlLgoKTG9nYW4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
