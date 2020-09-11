Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4AEC43461
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 07:10:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 281C922204
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 07:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281C922204
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B6E66876C9;
	Fri, 11 Sep 2020 07:10:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IgpCPRvZuY+D; Fri, 11 Sep 2020 07:09:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C9433876E7;
	Fri, 11 Sep 2020 07:09:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B321FC0052;
	Fri, 11 Sep 2020 07:09:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 878E0C0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 07:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 707F087739
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 07:09:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4u4fJNGVG0hz for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 07:09:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2D17E8772F
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 07:09:55 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id DFED868B02; Fri, 11 Sep 2020 09:09:50 +0200 (CEST)
Date: Fri, 11 Sep 2020 09:09:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 04/12] dma-mapping: fix DMA_OPS dependencies
Message-ID: <20200911070950.GB22394@lst.de>
References: <20200908164758.3177341-1-hch@lst.de>
 <20200908164758.3177341-5-hch@lst.de>
 <1e3c7094-62da-6e8c-0a41-0bc63dd3db68@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1e3c7094-62da-6e8c-0a41-0bc63dd3db68@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
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

T24gVGh1LCBTZXAgMTAsIDIwMjAgYXQgMDE6NTU6MzdQTSArMDEwMCwgUm9iaW4gTXVycGh5IHdy
b3RlOgo+IEFGQUlDUyBhbGwgdGhyZWUgb2YgdGhlc2UgYnVzIGRyaXZlcnMgYXJlIG9ubHkgcHJv
eHlpbmcgYSBzdHJ1Y3QgCj4gZG1hX21hcF9vcHMgKiBwb2ludGVyIGFyb3VuZCwgc28gaWYgdGhl
eSB1c2VkIHRoZSBzZXRfZG1hX29wcygpIGhlbHBlciB0aGV5IAo+IHNob3VsZG4ndCBldmVuIG5l
ZWQgdGhlc2Ugc2VsZWN0cyBhdCBhbGwuIE9ubHkgSU5URUxfTUlDX0hPU1QgYXBwZWFycyB0byAK
PiBoYXZlIGEgbG9naWNhbCBkZXBlbmRlbmN5IG9uIERNQV9PUFMgZm9yIGFjdHVhbCBmdW5jdGlv
bmFsaXR5Lgo+Cj4gSG93ZXZlciwgSSBoYXZlIGEgdmFndWUgZmVlbGluZyB5b3UgbWlnaHQgbm90
IGJlIGZvbmQgb2YgdGhvc2UgZG1hX29wcyAKPiBoZWxwZXJzLCBhbmQgSSBoYXZlIG5vIGdyZWF0
IG9iamVjdGlvbiB0byB0aGlzIG9uZS1saW5lciBhcy1pcywgc28gKG1vZHVsbyAKPiB0aGUgY291
cGxlIG9mIGNvbW1pdCBtZXNzYWdlIHR5cG9zKSwKClRoZSBwcm9ibGVtIHdpdGggdGhlc2UgaW5o
ZXLRlnRhbmNlcyBpcyB0aGF0IHRoZXkgZG9uJ3QgYWN0dWFsbHkgd29yawpmb3IgdGhlIGdlbmVy
YWwgY2FzZS4gIFlvdSdkIGFsc28gbmVlZCB0byBpbmhlcml0eSB0aGluZ3MgbGlrZSB0aGUKZG1h
IHJhbmdlcywgdGhlIGJ1cyBsaW1pdHMsIGV0YywgZXRjLiAgU28gd2UgbmVlZCB0byBraWxsIHRo
ZW0gaW5zdGVhZC4KVGhhdCB3aG9sZSBtaWMvdm9wIGNhc2UgaXMgZXZlbiB3b3JzZSB0aGFuIHRo
YXQgd2l0aCBpdCdzIHdlaXJkIHNldApvZiBjaGFpbmVkIGRtYSBvcHMgdGhhdCBzZWVtcyB0byBp
bXBsZW1lbnQgc29tZSBraW5kIG9mIGRldmljZSBzaWRlCmlvbW11IHRoYXQgaXNuJ3QgaW4gc2Nv
cGUgZm9yIHRoZSBETUEgQVBJIGF0IGFsbC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
