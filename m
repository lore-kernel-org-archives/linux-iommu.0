Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18173C41517
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 13:57:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF9C21BF6
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 13:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF9C21BF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BDDACE18;
	Wed, 24 Jul 2019 13:57:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 89FD6DC9
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 13:57:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 644E4224
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 13:57:00 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4D0A368B20; Wed, 24 Jul 2019 15:56:57 +0200 (CEST)
Date: Wed, 24 Jul 2019 15:56:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC 3/4] dma-direct: add dma_direct_min_mask
Message-ID: <20190724135657.GA9075@lst.de>
References: <20190717153135.15507-1-nsaenzjulienne@suse.de>
	<20190717153135.15507-4-nsaenzjulienne@suse.de>
	<20190718091526.GA25321@lst.de>
	<13dd1a4f33fcf814545f0d93f18429e853de9eaf.camel@suse.de>
	<58753252bd7964e3b9e9558b633bd325c4a898a1.camel@suse.de>
	<20190724135124.GA44864@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190724135124.GA44864@arrakis.emea.arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: stefan.wahren@i2se.com, f.fainelli@gmail.com,
	Robin Murphy <robin.murphy@arm.com>, phil@raspberrypi.org,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Jisheng.Zhang@synaptics.com, mbrugger@suse.com,
	Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, will@kernel.org,
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

On Wed, Jul 24, 2019 at 02:51:24PM +0100, Catalin Marinas wrote:
> I think it may be better if we have both ZONE_DMA and ZONE_DMA32 on
> arm64. ZONE_DMA would be based on the smallest dma-ranges as described
> in the DT while DMA32 covers the first naturally aligned 4GB of RAM
> (unchanged). When a smaller ZONE_DMA is not needed, it could be expanded
> to cover what would normally be ZONE_DMA32 (or could we have ZONE_DMA as
> 0-bytes? I don't think GFP_DMA can still allocate memory in this case).
> 
> We'd probably have to define ARCH_ZONE_DMA_BITS for arm64 to something
> smaller than 32-bit but sufficient to cover the known platforms like
> RPi4 (the current 24 is too small, so maybe 30). AFAICT,
> __dma_direct_optimal_gfp_mask() figures out whether GFP_DMA or GFP_DMA32
> should be passed.

ARCH_ZONE_DMA_BITS should probably become a variable.  That way we can
just initialize it to the default 24 bits in kernel/dma/direct.c and
allow architectures to override it in their early boot code.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
