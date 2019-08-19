Return-Path: <SRS0=RhgY=WP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED13C3A5A3
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 14:25:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BC02082C
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 14:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BC02082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3E189E3F;
	Mon, 19 Aug 2019 14:25:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D88D1E3C
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 14:25:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3960E89E
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 14:25:21 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id B1550227A81; Mon, 19 Aug 2019 16:25:16 +0200 (CEST)
Date: Mon, 19 Aug 2019 16:25:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 7/8] parisc: don't set ARCH_NO_COHERENT_DMA_MMAP
Message-ID: <20190819142516.GA6366@lst.de>
References: <20190808160005.10325-1-hch@lst.de>
	<20190808160005.10325-8-hch@lst.de>
	<1565861152.2963.7.camel@HansenPartnership.com>
	<20190815105002.GA30805@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190815105002.GA30805@lst.de>
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

Does my explanation from Thursday make sense or is it completely
off?  Does the patch description need some update to be less
confusing to those used to different terminology?

On Thu, Aug 15, 2019 at 12:50:02PM +0200, Christoph Hellwig wrote:
> Except for the different naming scheme vs the code this matches my
> assumptions.
> 
> In the code we have three cases (and a fourth EISA case mention in
> comments, but not actually implemented as far as I can tell):
> 
> arch/parisc/kernel/pci-dma.c says in the top of file comments:
> 
> ** AFAIK, all PA7100LC and PA7300LC platforms can use this code.
> 
> and the handles two different case.  for cpu_type == pcxl or pcxl2
> it maps the memory as uncached for dma_alloc_coherent, and for all
> other cpu types it fails the coherent allocations.
> 
> In addition to that there are the ccio and sba iommu drivers, of which
> according to your above comment one is always present for pa8xxx.
> 
> Which brings us back to this patch, which ensures that no cacheable
> memory is exported to userspace by removing ->mmap from ccio and sba.
> It then enabled dma_mmap_coherent for the pcxl or pcxl2 case that
> allocates uncached memory, which dma_mmap_coherent does not work
> because dma_alloc_coherent already failed for the !pcxl && !pcxl2
> and thus there is no memory to mmap.
> 
> So if the description is too confusing please suggest a better
> one, I'm a little lost between all these code names and product
> names (arch/parisc/include/asm/dma-mapping.h uses yet another set).
---end quoted text---
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
