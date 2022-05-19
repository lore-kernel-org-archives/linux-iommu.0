Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E81C433F5
	for <iommu@archiver.kernel.org>; Thu, 19 May 2022 07:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF40B41CDF;
	Thu, 19 May 2022 07:11:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lNHK3irsH2up; Thu, 19 May 2022 07:11:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B845C41CBF;
	Thu, 19 May 2022 07:11:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A69BC0032;
	Thu, 19 May 2022 07:11:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B30BC002D
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 07:11:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5713E41CC4
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 07:11:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SWO-u_hVfUWL for <iommu@lists.linux-foundation.org>;
 Thu, 19 May 2022 07:11:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66B5541CBF
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 07:11:52 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id C07A368AFE; Thu, 19 May 2022 09:11:46 +0200 (CEST)
Date: Thu, 19 May 2022 09:11:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/dma: Add config for PCI SAC address trick
Message-ID: <20220519071146.GB22301@lst.de>
References: <ef8abf1c6b0839e39b272738fc7bc4d9699c8bcb.1652895419.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ef8abf1c6b0839e39b272738fc7bc4d9699c8bcb.1652895419.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 will@kernel.org, hch@lst.de, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, May 18, 2022 at 06:36:59PM +0100, Robin Murphy wrote:
> +config IOMMU_DMA_PCI_SAC_OPT
> +	bool "Enable 64-bit legacy PCI optimisation by default"
> +	depends on IOMMU_DMA
> +	default X86
> +	help
> +	  Enable by default an IOMMU optimisation for 64-bit legacy PCI devices,
> +	  wherein the DMA API layer will always first try to allocate a 32-bit
> +	  DMA address suitable for a single address cycle, before falling back
> +	  to allocating from the full usable address range. If your system has
> +	  64-bit legacy PCI devices in 32-bit slots where using dual address
> +	  cycles reduces DMA throughput significantly, this optimisation may be
> +	  beneficial to overall performance.

The config option name sounds odd.  Yes, maybe for actual 64-bit PCI
this actualy is an optimization.  But I'd think of it more as a
workaround. and I'd probably word it as such.  I also would not not
default to true for x86, just allow for that.  There is nothing
fundamental about x86 wanting that, just that people use more crap
drivers on x86.  An the fact that AMD SEV sets the high bit for
encrypted memory has been weeding out at least some of them.

> +bool iommu_dma_forcedac __read_mostly = !IS_ENABLED(CONFIG_IOMMU_DMA_PCI_SAC_OPT);

Overly long line here.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
