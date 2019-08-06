Return-Path: <SRS0=bP0W=WC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F18AC31E40
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 11:33:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A2820818
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 11:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A2820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B34E3D7F;
	Tue,  6 Aug 2019 11:33:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 882F2D7E
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 11:33:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1467D8A8
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 11:33:22 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id B6461227A81; Tue,  6 Aug 2019 13:33:18 +0200 (CEST)
Date: Tue, 6 Aug 2019 13:33:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: Regression due to d98849aff879 (dma-direct: handle
	DMA_ATTR_NO_KERNEL_MAPPING in common code)
Message-ID: <20190806113318.GA20215@lst.de>
References: <1565082809.2323.24.camel@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1565082809.2323.24.camel@pengutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
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

On Tue, Aug 06, 2019 at 11:13:29AM +0200, Lucas Stach wrote:
> Hi Christoph,
> 
> I just found a regression where my NVMe device is no longer able to set
> up its HMB.
> 
> After subject commit dma_direct_alloc_pages() is no longer initializing
> dma_handle properly when DMA_ATTR_NO_KERNEL_MAPPING is set, as the
> function is now returning too early.
> 
> Now this could easily be fixed by adding the phy_to_dma translation to
> the NO_KERNEL_MAPPING code path, but I'm not sure how this stuff
> interacts with the memory encryption stuff set up later in the
> function, so I guess this should be looked at by someone with more
> experience with this code than me.

There is not much we can do about the memory encryption case here,
as that requires a kernel address to mark the memory as unencrypted.

So the obvious trivial fix is probably the right one:


diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 59bdceea3737..c49120193309 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -135,6 +135,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 		if (!PageHighMem(page))
 			arch_dma_prep_coherent(page, size);
 		/* return the page pointer as the opaque cookie */
+		*dma_handle = phys_to_dma(dev, page_to_phys(page));
 		return page;
 	}
 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
