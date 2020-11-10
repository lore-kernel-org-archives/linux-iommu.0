Return-Path: <SRS0=ThSx=EQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B511C63697
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 23:25:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A492080A
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 23:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPV32dPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A492080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0C60A861D5;
	Tue, 10 Nov 2020 23:25:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pHPzz4RSbbuF; Tue, 10 Nov 2020 23:25:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 575AE861A4;
	Tue, 10 Nov 2020 23:25:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48686C088B;
	Tue, 10 Nov 2020 23:25:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74E6EC016F
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 23:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5BE6985A22
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 23:25:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ZXqJb6ekHWb for <iommu@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 23:25:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C24EB859CF
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 23:25:15 +0000 (UTC)
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BC9BC20781;
 Tue, 10 Nov 2020 23:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605050715;
 bh=o6lMTu5xFOzYsPde49ClXFU1xXCgPh17zPTl4Yx9dys=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=dPV32dPJxAhqlhllWUsMt1gC7dOq85ACuyi2fnWL+r9/kPB0YaAY/q+UhWjLeQo7V
 ZDoeayJFbRzQ9/aW39itkyKKH8s+us5oMd9a8UfsuIgKpGjmBDN1DXk5OlpCVC2zRi
 xPJXtoRNKmQs4fail2G1MnvjO16Ve1HVNwPMHkTo=
Date: Tue, 10 Nov 2020 17:25:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 03/15] PCI/P2PDMA: Introduce
 pci_p2pdma_should_map_bus() and pci_p2pdma_bus_offset()
Message-ID: <20201110232513.GA705726@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201106170036.18713-4-logang@deltatee.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ira Weiny <iweiny@intel.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@lst.de>
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

On Fri, Nov 06, 2020 at 10:00:24AM -0700, Logan Gunthorpe wrote:
> Introduce pci_p2pdma_should_map_bus() which is meant to be called by
> dma map functions to determine how to map a given p2pdma page.

s/dma/DMA/ for consistency (also below in function comment)

> pci_p2pdma_bus_offset() is also added to allow callers to get the bus
> offset if they need to map the bus address.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/p2pdma.c       | 46 ++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-p2pdma.h | 11 +++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index ea8472278b11..9961e779f430 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -930,6 +930,52 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
>  
> +/**
> + * pci_p2pdma_bus_offset - returns the bus offset for a given page
> + * @page: page to get the offset for
> + *
> + * Must be passed a pci p2pdma page.

s/pci/PCI/

> + */
> +u64 pci_p2pdma_bus_offset(struct page *page)
> +{
> +	struct pci_p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(page->pgmap);
> +
> +	WARN_ON(!is_pci_p2pdma_page(page));
> +
> +	return p2p_pgmap->bus_offset;
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pdma_bus_offset);
> +
> +/**
> + * pci_p2pdma_should_map_bus - determine if a dma mapping should use the
> + *	bus address
> + * @dev: device doing the DMA request
> + * @pgmap: dev_pagemap structure for the mapping
> + *
> + * Returns 1 if the page should be mapped with a bus address, 0 otherwise
> + * and -1 the device should not be mapping P2PDMA pages.

I think this is missing a word.

I'm not really sure how to interpret the "should" in
pci_p2pdma_should_map_bus().  If this returns -1, does that mean the
patches *cannot* be mapped?  They *could* be mapped, but you really
*shouldn't*?  Something else?

1 means page should be mapped with bus address.  0 means ... what,
exactly?  It should be mapped with some different address?

Sorry these are naive questions because I don't know how all this
works.

> + */
> +int pci_p2pdma_should_map_bus(struct device *dev, struct dev_pagemap *pgmap)
> +{
> +	struct pci_p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(pgmap);
> +	struct pci_dev *client;
> +
> +	if (!dev_is_pci(dev))
> +		return -1;
> +
> +	client = to_pci_dev(dev);
> +
> +	switch (pci_p2pdma_map_type(p2p_pgmap->provider, client)) {
> +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +		return 0;
> +	case PCI_P2PDMA_MAP_BUS_ADDR:
> +		return 1;
> +	default:
> +		return -1;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pdma_should_map_bus);
> +
>  /**
>   * pci_p2pdma_enable_store - parse a configfs/sysfs attribute store
>   *		to enable p2pdma
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index 8318a97c9c61..fc5de47eeac4 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -34,6 +34,8 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>  		int nents, enum dma_data_direction dir, unsigned long attrs);
>  void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>  		int nents, enum dma_data_direction dir, unsigned long attrs);
> +u64 pci_p2pdma_bus_offset(struct page *page);
> +int pci_p2pdma_should_map_bus(struct device *dev, struct dev_pagemap *pgmap);
>  int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
>  			    bool *use_p2pdma);
>  ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
> @@ -83,6 +85,15 @@ static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
>  static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
>  {
>  }
> +static inline u64 pci_p2pdma_bus_offset(struct page *page)
> +{
> +	return -1;
> +}
> +static inline int pci_p2pdma_should_map_bus(struct device *dev,
> +					    struct dev_pagemap *pgmap)
> +{
> +	return -1;
> +}
>  static inline int pci_p2pdma_map_sg_attrs(struct device *dev,
>  		struct scatterlist *sg, int nents, enum dma_data_direction dir,
>  		unsigned long attrs)
> -- 
> 2.20.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
