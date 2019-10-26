Return-Path: <SRS0=J3yl=YT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5003ECA9EB9
	for <iommu@archiver.kernel.org>; Sat, 26 Oct 2019 10:13:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E5C820863
	for <iommu@archiver.kernel.org>; Sat, 26 Oct 2019 10:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="USP3P3B2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Md6Dg7kT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5C820863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ACB4EAD7;
	Sat, 26 Oct 2019 10:12:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8892889B
	for <iommu@lists.linux-foundation.org>;
	Sat, 26 Oct 2019 10:12:58 +0000 (UTC)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3469913A
	for <iommu@lists.linux-foundation.org>;
	Sat, 26 Oct 2019 10:12:58 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F3D2A607B5; Sat, 26 Oct 2019 10:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1572084778;
	bh=7I09K5+CmAYJ4+S3gYjmbFECynwUeOnBJfhDvdQI5to=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=USP3P3B2USPu6bSKWZYTpMAlcVA8OkWOIwx6TGwTA9C6p4WjZBwyXpV6Fk0+iFyil
	asCpK1jJzEZFSHj1w3JwZDwdH0EXkOmoEoAFCSsvsebBM6cW3MPdhnoYV8gA8ytEQo
	ZvEsfh6s6J5sBLP83tzVnTq3q/mNoS57KZ+ETFNA=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4460560A61;
	Sat, 26 Oct 2019 10:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1572084777;
	bh=7I09K5+CmAYJ4+S3gYjmbFECynwUeOnBJfhDvdQI5to=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Md6Dg7kTGuXVpqmAZfASuB5staSOsMUSox9FfGwfmr8hxY11PnlLPSFBcJdLiOtJU
	mdT2cHbWERzIzgoBUNWQGgXxS2wswbCeNMuS7otPaViTsWBcSGTp61iIbgMQVknEic
	h9a0ZkRJTCoymHHfGVpM9JOdL4p5RkqT+cpTbpvg=
MIME-Version: 1.0
Date: Sat, 26 Oct 2019 03:12:57 -0700
From: isaacm@codeaurora.org
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] iommu/dma: Add support for DMA_ATTR_SYS_CACHE
In-Reply-To: <20191026053026.GA14545@lst.de>
References: <1572050616-6143-1-git-send-email-isaacm@codeaurora.org>
	<20191026053026.GA14545@lst.de>
Message-ID: <e5fe861d7d506eb41c23f3fc047efdfa@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Cc: robin.murphy@arm.com, linux-kernel@vger.kernel.org, pratikp@codeaurora.org,
	iommu@lists.linux-foundation.org, lmark@codeaurora.org, will@kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gMjAxOS0xMC0yNSAyMjozMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gVGhlIGRlZmlu
aXRpb24gbWFrZXMgdmVyeSBsaXR0bGUgc2Vuc2UuCkNhbiB5b3UgcGxlYXNlIGNsYXJpZnkgd2hh
dCBwYXJ0IGRvZXNu4oCZdCBtYWtlIHNlbnNlLCBhbmQgd2h5PyBUaGlzIGlzIApyZWFsbHkganVz
dCBhbiBleHRlbnNpb24gb2YgdGhpcyBwYXRjaCB0aGF0IGdvdCBtYWlubGluZWQsIHNvIHRoYXQg
CmNsaWVudHMgdGhhdCB1c2UgdGhlIERNQSBBUEkgY2FuIHVzZSBJT01NVV9RQ09NX1NZU19DQUNI
RSBhcyB3ZWxsOiAKaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDk0NjA5OS8K
PiAgQW55IHdpdGhvdXQgYSB1c2VyIGluIHRoZSBzYW1lIHNlcmllcyBpdCBpcyBhIGNvbXBsZXRl
IG5vLWdvIGFueXdheS4KSU9NTVVfUUNPTV9TWVNfQ0FDSEUgZG9lcyBub3QgaGF2ZSBhbnkgY3Vy
cmVudCB1c2VycyBpbiB0aGUgbWFpbmxpbmUsIApub3IgZGlkIGl0IGhhdmUgaXQgaW4gdGhlIHBh
dGNoIHNlcmllcyBpbiB3aGljaCBpdCBnb3QgbWVyZ2VkLCB5ZXQgaXQgaXMgCnN0aWxsIHByZXNl
bnQ/IEZ1cnRoZXJtb3JlLCB0aGVyZSBhcmUgcGxhbnMgdG8gdXBzdHJlYW0gc3VwcG9ydCBmb3Ig
b25lIApvZiBvdXIgU29DcyB0aGF0IG1heSBiZW5lZml0IGZyb20gdGhpcywgYXMgc2VlbiBoZXJl
OiAKaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvaW9tbXUvbXNnMzk2MDguaHRtbC4KClRo
YW5rcywKSXNhYWMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
