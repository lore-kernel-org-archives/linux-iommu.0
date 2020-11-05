Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE1CC4741F
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 14:34:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2474E2078E
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 14:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="d1AhRiIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2474E2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D0FDD86064;
	Thu,  5 Nov 2020 14:34:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OrIbU-UfDqkv; Thu,  5 Nov 2020 14:34:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 40B4D85C04;
	Thu,  5 Nov 2020 14:34:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2890AC0893;
	Thu,  5 Nov 2020 14:34:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BCC9C0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 14:34:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5A84C84FB1
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 14:34:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zi11NlRbjVvs for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 14:34:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com
 [209.85.219.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 154DE85C04
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 14:34:21 +0000 (UTC)
Received: by mail-qv1-f68.google.com with SMTP id g13so760190qvu.1
 for <iommu@lists.linux-foundation.org>; Thu, 05 Nov 2020 06:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=RNmi4P8WYl4GQETrYJxETS32iCzFa9Xv1b6hiJTCjLI=;
 b=d1AhRiIAMURRnc2p19hIinkgrZ6DW3hWA8vDhq/FL2ROPM9EIi7JcPpv2eyODMprbv
 4tsGNhNZb3TGymM+rZ2KZpf7GleHIlpZRPJ1UsjK/hXagRZWDUJmcrYQVfHeR+tkTLcM
 yLJj9NoZf/Q3nZOoW/UjmUerXb3f8wc8oTFVeaBD9eIeWidRa76hIGSkix04wBZ5ymWQ
 WtnJL/Rr3jLHyWCeww/F9fNpKvr2iFh5jmrA2Fggtp5vL3Txcy1VsPqbFyvUl5S5XEEa
 yLfPujs8ZYzi44/IC4MYGlUYRGZLZCYfVKyDCGS3sayP4ntGQRdP/uL9pLPQCddX+lOL
 +xTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RNmi4P8WYl4GQETrYJxETS32iCzFa9Xv1b6hiJTCjLI=;
 b=Enacxx191wNBTXdNPAu8cFrfz5XYcBt1YgPD54Z0lmvo5yqYX+nedhvSljWAQ80TF4
 9twYfXntxrNvnXV5Iooo0WFbvbjHgCrxIVhEvPDo+SEWJbbCjuAsqHoqrRj0gZwlzq96
 rwyFqzjoYGgoqnmLFcGQjx4lxY97bEmfQCSR7EfvtySfKqfc1ByT19/YO32uw1IDBCw1
 UYxEU9j0VPj6fet4R5g3djB7/07ggCyRf8BrE6jnHW2DWTFXsROVcHN28oVMk8ViPzRp
 n62xyhVAxZRiAI9GZ3pMCWtB3q/P4NCsB/ZD6vgH4dyMuYQWQuXCDz4aJNdN3M5prwWX
 bMVg==
X-Gm-Message-State: AOAM531CQYzQGWVO2A4xmZFcoBZncViIueB184172nli+pjvzU3QkCzu
 dXpHqOGcTZ/MO7YX9Hg4QAu7i+v11nID6+5N
X-Google-Smtp-Source: ABdhPJw0ST1B67vguCBdvn7ezsqBPCcqlyF/5YAxBY/HhZbjhQWUMpnKjhTf+w+TlD6Fi1I60TlRyQ==
X-Received: by 2002:a0c:8d05:: with SMTP id r5mr2332295qvb.31.1604586860101;
 Thu, 05 Nov 2020 06:34:20 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id d18sm1115165qka.41.2020.11.05.06.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 06:34:19 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1kagLC-00HNlu-Vc; Thu, 05 Nov 2020 10:34:18 -0400
Date: Thu, 5 Nov 2020 10:34:18 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/6] PCI/P2PDMA: Remove the DMA_VIRT_OPS hacks
Message-ID: <20201105143418.GA4142106@ziepe.ca>
References: <20201105074205.1690638-1-hch@lst.de>
 <20201105074205.1690638-5-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201105074205.1690638-5-hch@lst.de>
Cc: Zhu Yanjun <yanjunz@nvidia.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Logan Gunthorpe <logang@deltatee.com>
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

On Thu, Nov 05, 2020 at 08:42:03AM +0100, Christoph Hellwig wrote:
> Now that all users of dma_virt_ops are gone we can remove the workaround
> for it in the PCI peer to peer code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>  drivers/pci/p2pdma.c | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index de1c331dbed43f..b07018af53876c 100644
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

The check is removed here, but I didn't see a matching check added to
the IB side? Something like:

static int rdma_rw_map_sg(struct ib_device *dev, struct scatterlist *sg,
			  u32 sg_cnt, enum dma_data_direction dir)
{
	if (is_pci_p2pdma_page(sg_page(sg))) {
		if (ib_uses_virt_dma(dev))
			return 0;
		return pci_p2pdma_map_sg(dev->dma_device, sg, sg_cnt, dir);
	}
	return ib_dma_map_sg(dev, sg, sg_cnt, dir);
}

I think the change to rdma_rw_unmap_sg() should probably be dropped in
favour of the above?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
