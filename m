Return-Path: <SRS0=QBaT=OR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CD9C433EF
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 18:51:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051EE6103B
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 18:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 051EE6103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C953880EA4;
	Mon, 27 Sep 2021 18:51:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Bt_LMCj1qjo; Mon, 27 Sep 2021 18:51:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9574480FFD;
	Mon, 27 Sep 2021 18:51:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF566C0023;
	Mon, 27 Sep 2021 18:51:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF395C000F
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 18:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9FE460067
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 18:51:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z6Z1RwMAK9v5 for <iommu@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 18:51:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B8CE606A0
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 18:51:01 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9932A60FF2;
 Mon, 27 Sep 2021 18:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632768661;
 bh=k2U75S9hycwPlp5+wID80zDHl//3Y8/paTLDMvAioQM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=UiGsmazF0pWnH4PJv++Pc3qoV57uOH08K5QJJNjGF1YcGUP4WV8kgU0kScvdNul0f
 wsFexhiQ+OrXnOMHfhTBDaEwOebbHwizs+TDglY/05m9tFSdRkfw2BPGq5S9irGr4v
 xKCycfmgSfp44hpQbD3NpX0spcoShILfvx6pxDN+hdnBFxmd1nG6YKflsKrINUqr/i
 mODOdQCoSyl+//BrlyHw4aFcrOIfom6oGDPjKUzjmt/OsJt3cocks7xy3gDpYABdqM
 VSiASBD1dlEDX2AtBOYNl4ixAWKOPhe5JI9ce00vwSDeE2hNqp8o8xg5e/lLNSUdSA
 JgnAJe9AfYHlA==
Date: Mon, 27 Sep 2021 13:50:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 13/20] PCI/P2PDMA: remove pci_p2pdma_[un]map_sg()
Message-ID: <20210927185059.GA668202@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-14-logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
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

On Thu, Sep 16, 2021 at 05:40:53PM -0600, Logan Gunthorpe wrote:
> This interface is superseded by support in dma_map_sg() which now supports
> heterogeneous scatterlists. There are no longer any users, so remove it.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Ditto.

> ---
>  drivers/pci/p2pdma.c       | 65 --------------------------------------
>  include/linux/pci-p2pdma.h | 27 ----------------
>  2 files changed, 92 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 58c34f1f1473..4478633346bd 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -878,71 +878,6 @@ enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
>  	return type;
>  }
>  
> -static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
> -		struct device *dev, struct scatterlist *sg, int nents)
> -{
> -	struct scatterlist *s;
> -	int i;
> -
> -	for_each_sg(sg, s, nents, i) {
> -		s->dma_address = sg_phys(s) - p2p_pgmap->bus_offset;
> -		sg_dma_len(s) = s->length;
> -	}
> -
> -	return nents;
> -}
> -
> -/**
> - * pci_p2pdma_map_sg_attrs - map a PCI peer-to-peer scatterlist for DMA
> - * @dev: device doing the DMA request
> - * @sg: scatter list to map
> - * @nents: elements in the scatterlist
> - * @dir: DMA direction
> - * @attrs: DMA attributes passed to dma_map_sg() (if called)
> - *
> - * Scatterlists mapped with this function should be unmapped using
> - * pci_p2pdma_unmap_sg_attrs().
> - *
> - * Returns the number of SG entries mapped or 0 on error.
> - */
> -int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
> -		int nents, enum dma_data_direction dir, unsigned long attrs)
> -{
> -	struct pci_p2pdma_pagemap *p2p_pgmap =
> -		to_p2p_pgmap(sg_page(sg)->pgmap);
> -
> -	switch (pci_p2pdma_map_type(sg_page(sg)->pgmap, dev)) {
> -	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> -		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
> -	case PCI_P2PDMA_MAP_BUS_ADDR:
> -		return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
> -	default:
> -		return 0;
> -	}
> -}
> -EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
> -
> -/**
> - * pci_p2pdma_unmap_sg_attrs - unmap a PCI peer-to-peer scatterlist that was
> - *	mapped with pci_p2pdma_map_sg()
> - * @dev: device doing the DMA request
> - * @sg: scatter list to map
> - * @nents: number of elements returned by pci_p2pdma_map_sg()
> - * @dir: DMA direction
> - * @attrs: DMA attributes passed to dma_unmap_sg() (if called)
> - */
> -void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
> -		int nents, enum dma_data_direction dir, unsigned long attrs)
> -{
> -	enum pci_p2pdma_map_type map_type;
> -
> -	map_type = pci_p2pdma_map_type(sg_page(sg)->pgmap, dev);
> -
> -	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
> -		dma_unmap_sg_attrs(dev, sg, nents, dir, attrs);
> -}
> -EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
> -
>  /**
>   * pci_p2pdma_map_segment - map an sg segment determining the mapping type
>   * @state: State structure that should be declared outside of the for_each_sg()
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index e5a8d5bc0f51..0c33a40a86e7 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -72,10 +72,6 @@ void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
>  void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
>  enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
>  					     struct device *dev);
> -int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
> -		int nents, enum dma_data_direction dir, unsigned long attrs);
> -void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
> -		int nents, enum dma_data_direction dir, unsigned long attrs);
>  enum pci_p2pdma_map_type
>  pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
>  		       struct scatterlist *sg);
> @@ -135,17 +131,6 @@ pci_p2pdma_map_type(struct dev_pagemap *pgmap, struct device *dev)
>  {
>  	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
>  }
> -static inline int pci_p2pdma_map_sg_attrs(struct device *dev,
> -		struct scatterlist *sg, int nents, enum dma_data_direction dir,
> -		unsigned long attrs)
> -{
> -	return 0;
> -}
> -static inline void pci_p2pdma_unmap_sg_attrs(struct device *dev,
> -		struct scatterlist *sg, int nents, enum dma_data_direction dir,
> -		unsigned long attrs)
> -{
> -}
>  static inline enum pci_p2pdma_map_type
>  pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
>  		       struct scatterlist *sg)
> @@ -181,16 +166,4 @@ static inline struct pci_dev *pci_p2pmem_find(struct device *client)
>  	return pci_p2pmem_find_many(&client, 1);
>  }
>  
> -static inline int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg,
> -				    int nents, enum dma_data_direction dir)
> -{
> -	return pci_p2pdma_map_sg_attrs(dev, sg, nents, dir, 0);
> -}
> -
> -static inline void pci_p2pdma_unmap_sg(struct device *dev,
> -		struct scatterlist *sg, int nents, enum dma_data_direction dir)
> -{
> -	pci_p2pdma_unmap_sg_attrs(dev, sg, nents, dir, 0);
> -}
> -
>  #endif /* _LINUX_PCI_P2P_H */
> -- 
> 2.30.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
