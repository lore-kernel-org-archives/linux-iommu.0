Return-Path: <SRS0=JEM9=V3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FBBC433FF
	for <iommu@archiver.kernel.org>; Tue, 30 Jul 2019 15:13:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 010C020657
	for <iommu@archiver.kernel.org>; Tue, 30 Jul 2019 15:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iUWZXk9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010C020657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B74932F20;
	Tue, 30 Jul 2019 15:13:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F27002F02
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Jul 2019 15:06:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A3D2EA8
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Jul 2019 15:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Fwo4UgelKrFlMANHP0CkxoeTqhbpEZ5Al8KPq5+W4/U=;
	b=iUWZXk9xQpjnD8idH1ONwy0Ks
	uvbIFEUFVogcOZpxi9Cbe4SadL88AtQVARgcp0CIgRK/l7u6FQCnt751ny2ekMKuilZV5cnHSaqf2
	DEP0bAzj4/P2HA4BenSDpdsLhAQnqmvTeRtUFG5BgFiQ2JE4OpvXUw3MPNyjXhuFqZzhy0x2k2+T6
	J7sisXENInwgsG/Oxeg6Gr71NPoReXVZdqodP+PsMZbBN/0wm+62MoHSc1hJa5IFo+4TJ7qtQBSZr
	HlHlfaA5OqllYikmO5watDVyT9vEfLH81TlRFaeH464UY2fTdZRIu84Xs3PucbNogH6MAXW0uGIqR
	eJkfN3fAg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
	Linux)) id 1hsTho-0000n1-Sp; Tue, 30 Jul 2019 15:06:25 +0000
Date: Tue, 30 Jul 2019 08:06:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/dma: Handle MSI mappings separately
Message-ID: <20190730150624.GA27573@infradead.org>
References: <2b2595de703c60a772ebcffe248d0cf036143e6a.1564414114.git.robin.murphy@arm.com>
	<20190730062843.GA1400@infradead.org>
	<90566814-ed36-2eb9-49e2-98a4a949c9f6@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <90566814-ed36-2eb9-49e2-98a4a949c9f6@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: maz@kernel.org, iommu@lists.linux-foundation.org,
	Andre Przywara <andre.przywara@arm.com>,
	linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, Jul 30, 2019 at 11:43:25AM +0100, Robin Murphy wrote:
> > Hmm.  I remember proposing this patch and you didn't like it because
> > we could also have msis for a !IOMMU_DMA_IOVA_COOKIE cookie type.
> > Or did we talk past each other?
> 
> Do you have a pointer? That sparks the vaguest of memories, but I can't seem
> to turn anything up in my inbox. If that was my objection, though, it sounds
> like your patch was probably trying to go a step or two further than this
> one.

I can't find anything either.  This must have been a git tree I passed
around to you before posting it.

> > Note that if this change turns out to be valid we should also
> > clean up the iommu_dma_free_iova() side.
> 
> We're not touching the iommu_dma_{alloc,free}_iova() path here; those are
> designed to cope with both types of cookie, and I think that's a reasonable
> abstraction to keep. This is just getting rid of the asymmetry - and now bug
> - caused by trying to keep the MSI page flow going through a special case in
> __iommu_dma_map() despite that having evolved into a more specific DMA
> domain fastpath (there's no corresponding unmap special case since MSI
> mappings just persist and get recycled until the domain is destroyed).

Ok, that might have been the issue with my earlier patch..
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
