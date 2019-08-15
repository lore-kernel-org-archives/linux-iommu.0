Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F88C31E40
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 10:50:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43EED208C2
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 10:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EED208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D3DB1CB6;
	Thu, 15 Aug 2019 10:50:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C6612CA6
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 10:50:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 18388711
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 10:50:09 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9FC9468AFE; Thu, 15 Aug 2019 12:50:03 +0200 (CEST)
Date: Thu, 15 Aug 2019 12:50:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 7/8] parisc: don't set ARCH_NO_COHERENT_DMA_MMAP
Message-ID: <20190815105002.GA30805@lst.de>
References: <20190808160005.10325-1-hch@lst.de>
	<20190808160005.10325-8-hch@lst.de>
	<1565861152.2963.7.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1565861152.2963.7.camel@HansenPartnership.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
	Helge Deller <deller@gmx.de>, x86@kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
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

On Thu, Aug 15, 2019 at 10:25:52AM +0100, James Bottomley wrote:
> >  which means exporting normally cachable memory to userspace is
> > relatively dangrous due to cache aliasing.
> > 
> > But normally cachable memory is only allocated by dma_alloc_coherent
> > on parisc when using the sba_iommu or ccio_iommu drivers, so just
> > remove the .mmap implementation for them so that we don't have to set
> > ARCH_NO_COHERENT_DMA_MMAP, which I plan to get rid of.
> 
> So I don't think this is quite right.  We have three architectural
> variants essentially (hidden behind about 12 cpu types):
> 
>    1. pa70xx: These can't turn off page caching, so they were the non
>       coherent problem case
>    2. pa71xx: These can manufacture coherent memory simply by turning off
>       the cache on a per page basis
>    3. pa8xxx: these have a full cache flush coherence mechanism.
> 
> (I might have this slightly wrong: I vaguely remember the pa71xxlc
> variants have some weird cache quirks for DMA as well)
> 
> So I think pa70xx we can't mmap.  pa71xx we can provided we mark the
> page as uncached ... which should already have happened in the allocate
> and pa8xxx which can always mmap dma memory without any special tricks.

Except for the different naming scheme vs the code this matches my
assumptions.

In the code we have three cases (and a fourth EISA case mention in
comments, but not actually implemented as far as I can tell):

arch/parisc/kernel/pci-dma.c says in the top of file comments:

** AFAIK, all PA7100LC and PA7300LC platforms can use this code.

and the handles two different case.  for cpu_type == pcxl or pcxl2
it maps the memory as uncached for dma_alloc_coherent, and for all
other cpu types it fails the coherent allocations.

In addition to that there are the ccio and sba iommu drivers, of which
according to your above comment one is always present for pa8xxx.

Which brings us back to this patch, which ensures that no cacheable
memory is exported to userspace by removing ->mmap from ccio and sba.
It then enabled dma_mmap_coherent for the pcxl or pcxl2 case that
allocates uncached memory, which dma_mmap_coherent does not work
because dma_alloc_coherent already failed for the !pcxl && !pcxl2
and thus there is no memory to mmap.

So if the description is too confusing please suggest a better
one, I'm a little lost between all these code names and product
names (arch/parisc/include/asm/dma-mapping.h uses yet another set).
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
