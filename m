Return-Path: <SRS0=vdHR=V5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6258AC19759
	for <iommu@archiver.kernel.org>; Thu,  1 Aug 2019 16:44:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31CB620838
	for <iommu@archiver.kernel.org>; Thu,  1 Aug 2019 16:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1vCYTqrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CB620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0DBAB16F4;
	Thu,  1 Aug 2019 16:44:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C73EB1186
	for <iommu@lists.linux-foundation.org>;
	Thu,  1 Aug 2019 16:44:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 83B2A5F4
	for <iommu@lists.linux-foundation.org>;
	Thu,  1 Aug 2019 16:44:16 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id A272C20838;
	Thu,  1 Aug 2019 16:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564677856;
	bh=luxeEe+sNcMiUEJZddOmw2LCtZnw/7cP+2BTlvtj75g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1vCYTqrWNpzwy70+mDDkDyYbXSINihdTQt827ZNZ38BqrocpuTP/5twuQPWb+gghN
	+bl+z5TixFmhDdNjnDx+Eh8sSH8KshmaqVzUor7b7NSq1e0PiUUaxnmgdxPhdn1229
	Armf1YNDTLI9lVu8j9VV+a1Qdb+UMV3aZU2PBKDY=
Date: Thu, 1 Aug 2019 17:44:12 +0100
From: Will Deacon <will@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-mapping: fix page attributes for dma_mmap_*
Message-ID: <20190801164411.kmsl4japtfkgvzxe@willie-the-truck>
References: <20190801142118.21225-1-hch@lst.de>
	<20190801142118.21225-2-hch@lst.de>
	<20190801162305.3m32chycsdjmdejk@willie-the-truck>
	<20190801163457.GB26588@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190801163457.GB26588@lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: Shawn Anastasio <shawn@anastas.io>, Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Thu, Aug 01, 2019 at 06:34:57PM +0200, Christoph Hellwig wrote:
> On Thu, Aug 01, 2019 at 05:23:06PM +0100, Will Deacon wrote:
> > > -	if (!dev_is_dma_coherent(dev) || (attrs & DMA_ATTR_WRITE_COMBINE))
> > > -		return pgprot_writecombine(prot);
> > > -	return prot;
> > > +	return pgprot_writecombine(prot);
> > >  }
> > 
> > Seems like a sensible cleanup to me:
> > 
> > Acked-by: Will Deacon <will@kernel.org>
> > 
> > Although arch_dma_mmap_pgprot() is a bit of a misnomer now that it only
> > gets involved in the non-coherent case.
> 
> A better name is welcome.

How about arch_dma_noncoherent_mmap_pgprot() ? Too long?

> My other idea would be to just remove it entirely and do something like:
> 
> #ifndef pgprot_dmacoherent
> #define pgprot_dmacoherent pgprot_noncached
> #endif
> 
> pgprot_t dma_mmap_pgprot(struct device *dev, pgprot_t prot, unsigned long attrs)
> {
> 	if (dev_is_dma_coherent(dev) || (attrs & DMA_ATTR_NON_CONSISTENT))
> 		return prot;
> #ifdef pgprot_writecombine
> 	if (attrs & DMA_ATTR_WRITE_COMBINE)
> 		return pgprot_writecombine(prot);
> #endif
> 	return pgprot_dmacoherent(prot);
> }

Oh, I prefer that!

> But my worry is how this interacts with architectures that have an
> uncached segment (mips, nios2, microblaze, extensa) where we'd have
> the kernel access DMA_ATTR_WRITE_COMBINE mappigns using the uncached
> segment, and userspace mmaps using pgprot_writecombine, which could
> lead to aliasing issues.  But then again mips already supports
> DMA_ATTR_WRITE_COMBINE, so this must be ok somehow.  I guess I'll
> need to field that question to the relevant parties.

Or it's always been busted and happens to work out in practice...

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
