Return-Path: <SRS0=vdHR=V5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864B2C19759
	for <iommu@archiver.kernel.org>; Thu,  1 Aug 2019 16:35:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D60B20679
	for <iommu@archiver.kernel.org>; Thu,  1 Aug 2019 16:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D60B20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AA3C221C8;
	Thu,  1 Aug 2019 16:35:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D507C130E
	for <iommu@lists.linux-foundation.org>;
	Thu,  1 Aug 2019 16:35:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 696D55F4
	for <iommu@lists.linux-foundation.org>;
	Thu,  1 Aug 2019 16:35:01 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id C7B8E68B20; Thu,  1 Aug 2019 18:34:57 +0200 (CEST)
Date: Thu, 1 Aug 2019 18:34:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] dma-mapping: fix page attributes for dma_mmap_*
Message-ID: <20190801163457.GB26588@lst.de>
References: <20190801142118.21225-1-hch@lst.de>
	<20190801142118.21225-2-hch@lst.de>
	<20190801162305.3m32chycsdjmdejk@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190801162305.3m32chycsdjmdejk@willie-the-truck>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Shawn Anastasio <shawn@anastas.io>, Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
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

On Thu, Aug 01, 2019 at 05:23:06PM +0100, Will Deacon wrote:
> > -	if (!dev_is_dma_coherent(dev) || (attrs & DMA_ATTR_WRITE_COMBINE))
> > -		return pgprot_writecombine(prot);
> > -	return prot;
> > +	return pgprot_writecombine(prot);
> >  }
> 
> Seems like a sensible cleanup to me:
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Although arch_dma_mmap_pgprot() is a bit of a misnomer now that it only
> gets involved in the non-coherent case.

A better name is welcome.  My other idea would be to just remove it
entirely and do something like:

#ifndef pgprot_dmacoherent
#define pgprot_dmacoherent pgprot_noncached
#endif

pgprot_t dma_mmap_pgprot(struct device *dev, pgprot_t prot, unsigned long attrs)
{
	if (dev_is_dma_coherent(dev) || (attrs & DMA_ATTR_NON_CONSISTENT))
		return prot;
#ifdef pgprot_writecombine
	if (attrs & DMA_ATTR_WRITE_COMBINE)
		return pgprot_writecombine(prot);
#endif
	return pgprot_dmacoherent(prot);
}

But my worry is how this interacts with architectures that have an
uncached segment (mips, nios2, microblaze, extensa) where we'd have
the kernel access DMA_ATTR_WRITE_COMBINE mappigns using the uncached
segment, and userspace mmaps using pgprot_writecombine, which could
lead to aliasing issues.  But then again mips already supports
DMA_ATTR_WRITE_COMBINE, so this must be ok somehow.  I guess I'll
need to field that question to the relevant parties.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
