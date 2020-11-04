Return-Path: <SRS0=z3hi=EK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0332C4741F
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 16:54:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18795206FA
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 16:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufgUb7fU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18795206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4D02E203FB;
	Wed,  4 Nov 2020 16:54:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fKpvTzifzDKv; Wed,  4 Nov 2020 16:53:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 406C1203E2;
	Wed,  4 Nov 2020 16:53:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30DD3C088B;
	Wed,  4 Nov 2020 16:53:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A0A2C0051
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 16:53:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 579B185F92
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 16:53:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p0W-aM3nOrjo for <iommu@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 16:53:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B94C885F80
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 16:53:55 +0000 (UTC)
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E4EBE206FA;
 Wed,  4 Nov 2020 16:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604508835;
 bh=2AnCcDgCUl6mvSBgQ/DNDlhMjVmEBjE51au1El1BYuY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=ufgUb7fUuwShufuwOFMMiN+b9KhxmZPRjeacpooFT3rGtbvfpEYeTIDtR+8qbpybZ
 ViNnVNVez79xeThoXkIgQLPNu1B162vS+R/Iws4UAxxNYredVESg2yvamgQAHpoXqg
 QCtTCOr9+JeAYws//F1IQSU6/a4lEYyRNDJ8N6Ho=
Date: Wed, 4 Nov 2020 10:53:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/5] PCI/p2p: remove the DMA_VIRT_OPS hacks
Message-ID: <20201104165353.GA357989@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201104095052.1222754-4-hch@lst.de>
Cc: linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux-foundation.org,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>
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

s|PCI/p2p: remove|PCI/P2PDMA: Remove/
to match history.

On Wed, Nov 04, 2020 at 10:50:50AM +0100, Christoph Hellwig wrote:
> Now that all users of dma_virt_ops are gone we can remove the workaround
> for it in the PCIe peer to peer code.

s/PCIe/PCI/
We went to some trouble to make P2PDMA work on conventional PCI as
well as PCIe.

> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/p2pdma.c | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index de1c331dbed43f..b07018af53876c 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -556,15 +556,6 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
>  		return -1;
>  
>  	for (i = 0; i < num_clients; i++) {
> -#ifdef CONFIG_DMA_VIRT_OPS
> -		if (clients[i]->dma_ops == &dma_virt_ops) {
> -			if (verbose)
> -				dev_warn(clients[i],
> -					 "cannot be used for peer-to-peer DMA because the driver makes use of dma_virt_ops\n");
> -			return -1;
> -		}
> -#endif
> -
>  		pci_client = find_parent_pci_dev(clients[i]);
>  		if (!pci_client) {
>  			if (verbose)
> @@ -837,17 +828,6 @@ static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
>  	phys_addr_t paddr;
>  	int i;
>  
> -	/*
> -	 * p2pdma mappings are not compatible with devices that use
> -	 * dma_virt_ops. If the upper layers do the right thing
> -	 * this should never happen because it will be prevented
> -	 * by the check in pci_p2pdma_distance_many()
> -	 */
> -#ifdef CONFIG_DMA_VIRT_OPS
> -	if (WARN_ON_ONCE(dev->dma_ops == &dma_virt_ops))
> -		return 0;
> -#endif
> -
>  	for_each_sg(sg, s, nents, i) {
>  		paddr = sg_phys(s);
>  
> -- 
> 2.28.0
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
