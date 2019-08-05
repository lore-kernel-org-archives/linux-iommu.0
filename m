Return-Path: <SRS0=bWDR=WB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FBAC433FF
	for <iommu@archiver.kernel.org>; Mon,  5 Aug 2019 09:11:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E152067D
	for <iommu@archiver.kernel.org>; Mon,  5 Aug 2019 09:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E152067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 03914D8D;
	Mon,  5 Aug 2019 09:11:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A95C4CD3
	for <iommu@lists.linux-foundation.org>;
	Mon,  5 Aug 2019 09:10:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id B6656829
	for <iommu@lists.linux-foundation.org>;
	Mon,  5 Aug 2019 09:10:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AC9428;
	Mon,  5 Aug 2019 02:10:56 -0700 (PDT)
Received: from iMac.local (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CDE03F694;
	Mon,  5 Aug 2019 02:10:54 -0700 (PDT)
Date: Mon, 5 Aug 2019 10:10:52 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] dma-mapping: fix page attributes for dma_mmap_*
Message-ID: <20190805091051.GB59981@iMac.local>
References: <20190805080145.5694-1-hch@lst.de>
	<20190805080145.5694-2-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190805080145.5694-2-hch@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Cc: Gavin Li <git@thegavinli.com>, Shawn Anastasio <shawn@anastas.io>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, linux-mips@vger.kernel.org,
	iommu@lists.linux-foundation.org, Paul Burton <paul.burton@mips.com>,
	James Hogan <jhogan@kernel.org>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Aug 05, 2019 at 11:01:44AM +0300, Christoph Hellwig wrote:
> All the way back to introducing dma_common_mmap we've defaulyed to mark

s/defaultyed/defaulted/

> the pages as uncached.  But this is wrong for DMA coherent devices.
> Later on DMA_ATTR_WRITE_COMBINE also got incorrect treatment as that
> flag is only treated special on the alloc side for non-coherent devices.
> 
> Introduce a new dma_pgprot helper that deals with the check for coherent
> devices so that only the remapping cases even reach arch_dma_mmap_pgprot

s/even/ever/

> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 1d3f0b5a9940..bd2b039f43a6 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -14,9 +14,7 @@
>  pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
>  		unsigned long attrs)
>  {
> -	if (!dev_is_dma_coherent(dev) || (attrs & DMA_ATTR_WRITE_COMBINE))
> -		return pgprot_writecombine(prot);
> -	return prot;
> +	return pgprot_writecombine(prot);
>  }

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
