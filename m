Return-Path: <SRS0=xEY5=QC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23479C433F5
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 18:15:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43B66337D
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 18:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B43B66337D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 779EE40368;
	Mon, 15 Nov 2021 18:15:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iFsVCg8BL0SM; Mon, 15 Nov 2021 18:15:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 33A1640106;
	Mon, 15 Nov 2021 18:15:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18E8FC001E;
	Mon, 15 Nov 2021 18:15:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76316C0012
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 18:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 642DC80C20
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 18:15:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SC4J64oiHw2u for <iommu@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 18:15:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 001EB80BFA
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 18:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=/j1kGg3Y3gXXMCKBT/FlrMPEzAkt4b0LfzEg1w0LaRY=; b=MiHTez0Qf+wX+jRQ5B/3EkMeSB
 TvxNL1Ov34NgD3bwoIg17g3//hLJW1J9conA8mIU+92DauDmRpeOBfGqiA+NBBYGONoovgPDaaoeT
 E9hbRqrey5lkoxXaOlQSqb3RveB7VNobb8j6oZMXpGtHVa1EjZvb84ijRMjafDoYjn/qi06lzFIA4
 t08ygSB4+Hxt81yRGLr3p5uBd+TEtPKsvy2hqjw+oLQ+qHd5zgxTZAGfK6xvoDdQihW4H2ydtA27R
 ylOo0xgaDgmTlW9rxr1QiFESRAn1mAZ7WrFwnQuCKV/52trgg6FZ6tiCPD0OlfG2au6V0ORG4Dkg6
 C8px0TLw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mmgVX-00Ge06-LZ; Mon, 15 Nov 2021 18:15:07 +0000
Date: Mon, 15 Nov 2021 10:15:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 02/11] driver core: Set DMA ownership during driver
 bind/unbind
Message-ID: <YZKjq3sXb9+UTDSz@infradead.org>
References: <20211115020552.2378167-1-baolu.lu@linux.intel.com>
 <20211115020552.2378167-3-baolu.lu@linux.intel.com>
 <YZJeRomcJjDqDv9q@infradead.org>
 <20211115132442.GA2379906@nvidia.com>
 <8499f0ab-9701-2ca2-ac7a-842c36c54f8a@arm.com>
 <20211115155613.GA2388278@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211115155613.GA2388278@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org, rafael@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>,
 Will Deacon <will@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Diana Craciun <diana.craciun@oss.nxp.com>
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

On Mon, Nov 15, 2021 at 11:56:13AM -0400, Jason Gunthorpe wrote:
> drivers/base/platform.c:        .dma_configure  = platform_dma_configure,
> drivers/bus/fsl-mc/fsl-mc-bus.c:        .dma_configure  = fsl_mc_dma_configure,
> drivers/pci/pci-driver.c:       .dma_configure  = pci_dma_configure,
> drivers/gpu/host1x/bus.c:       .dma_configure = host1x_dma_configure,
> 
> Other than host1x they all work with VFIO.
> 
> Also, there is no bus->dma_unconfigure() which would be needed to
> restore the device as well.
> 
> So, would you rather see duplicated code into the 4 drivers, and a new
> bus op to 'unconfigure dma'

The tend to mostly call into common helpers eventually.

> 
> Or, a 'dev_configure_dma()' function that is roughly:
> 
>         if (dev->bus->dma_configure) {
>                 ret = dev->bus->dma_configure(dev);
>                 if (ret)
>                         return ret;
>                 if (!drv->suppress_auto_claim_dma_owner) {
>                        ret = iommu_device_set_dma_owner(dev, DMA_OWNER_KERNEL,
>                                                         NULL);
>                        if (ret)
>                                ret;
>                 }
>          }
> 
> And a pair'd undo.

But that seems like an even better idea to me.  Even better with an
early return and avoiding the pointless indentation.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
