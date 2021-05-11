Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A2AC433ED
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:06:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F9E26191E
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9E26191E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0794C83D01;
	Tue, 11 May 2021 16:06:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8-PU79JQpaDx; Tue, 11 May 2021 16:06:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0E4D83CB3;
	Tue, 11 May 2021 16:06:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB179C000E;
	Tue, 11 May 2021 16:06:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 376C3C0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:06:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 25E5140564
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:06:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rzjFN3DlMzec for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 16:06:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D4F84055B
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620749178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tMAIqc3ynAUjVNMmJZyA97GO/AXkgEpCMde9bMg3dSI=;
 b=AhF2xVpeDPwH/BjQCUEfVH4X7MDDYMbAOGRKRS16jaFCvf00qHglAgNEu15zH1TGppWyHk
 sIhOD58OYa1/uvgDAkquLbtZuYPu5oEVmrOW7Ps8bYS/hu66omCqSU8Zol2NhXxHRu5kB8
 qMPNt4HEWRvbWoQy2JxMH2VqYW3565g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-qB9XlPV8NbqOjRN04e3B5A-1; Tue, 11 May 2021 12:06:16 -0400
X-MC-Unique: qB9XlPV8NbqOjRN04e3B5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F7ED8C8640;
 Tue, 11 May 2021 16:06:12 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30ECA6E53E;
 Tue, 11 May 2021 16:06:08 +0000 (UTC)
Subject: Re: [PATCH 07/16] PCI/P2PDMA: Make pci_p2pdma_map_type() non-static
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-8-logang@deltatee.com>
From: Don Dutile <ddutile@redhat.com>
Message-ID: <a2da7566-7e0d-6a3a-055d-4d324deba4af@redhat.com>
Date: Tue, 11 May 2021 12:06:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-8-logang@deltatee.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <helgaas@kernel.org>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 4/8/21 1:01 PM, Logan Gunthorpe wrote:
> pci_p2pdma_map_type() will be needed by the dma-iommu map_sg
> implementation because it will need to determine the mapping type
> ahead of actually doing the mapping to create the actual iommu mapping.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/pci/p2pdma.c       | 34 +++++++++++++++++++++++-----------
>   include/linux/pci-p2pdma.h | 15 +++++++++++++++
>   2 files changed, 38 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index bcb1a6d6119d..38c93f57a941 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -20,13 +20,6 @@
>   #include <linux/seq_buf.h>
>   #include <linux/xarray.h>
>   
> -enum pci_p2pdma_map_type {
> -	PCI_P2PDMA_MAP_UNKNOWN = 0,
> -	PCI_P2PDMA_MAP_NOT_SUPPORTED,
> -	PCI_P2PDMA_MAP_BUS_ADDR,
> -	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
> -};
> -
>   struct pci_p2pdma {
>   	struct gen_pool *pool;
>   	bool p2pmem_published;
> @@ -822,13 +815,30 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
>   }
>   EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
>   
> -static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
> -						    struct device *dev)
> +/**
> + * pci_p2pdma_map_type - return the type of mapping that should be used for
> + *	a given device and pgmap
> + * @pgmap: the pagemap of a page to determine the mapping type for
> + * @dev: device that is mapping the page
> + * @dma_attrs: the attributes passed to the dma_map operation --
> + *	this is so they can be checked to ensure P2PDMA pages were not
> + *	introduced into an incorrect interface (like dma_map_sg). *
> + *
> + * Returns one of:
> + *	PCI_P2PDMA_MAP_NOT_SUPPORTED - The mapping should not be done
> + *	PCI_P2PDMA_MAP_BUS_ADDR - The mapping should use the PCI bus address
> + *	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE - The mapping should be done directly
> + */
I'd recommend putting these descriptions in the enum's in pci-p2pdma.h .
Also, can you use a better description for THRU_HOST_BRIDGE -- it leaves the reader wondering what 'done directly' means.

Thanks.
-dd

> +enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
> +		struct device *dev, unsigned long dma_attrs)
>   {
>   	struct pci_dev *provider = to_p2p_pgmap(pgmap)->provider;
>   	enum pci_p2pdma_map_type ret;
>   	struct pci_dev *client;
>   
> +	WARN_ONCE(!(dma_attrs & __DMA_ATTR_PCI_P2PDMA),
> +		  "PCI P2PDMA pages were mapped with dma_map_sg!");
> +
>   	if (!provider->p2pdma)
>   		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
>   
> @@ -879,7 +889,8 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>   	struct pci_p2pdma_pagemap *p2p_pgmap =
>   		to_p2p_pgmap(sg_page(sg)->pgmap);
>   
> -	switch (pci_p2pdma_map_type(sg_page(sg)->pgmap, dev)) {
> +	switch (pci_p2pdma_map_type(sg_page(sg)->pgmap, dev,
> +				    __DMA_ATTR_PCI_P2PDMA)) {
>   	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>   		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
>   	case PCI_P2PDMA_MAP_BUS_ADDR:
> @@ -904,7 +915,8 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>   {
>   	enum pci_p2pdma_map_type map_type;
>   
> -	map_type = pci_p2pdma_map_type(sg_page(sg)->pgmap, dev);
> +	map_type = pci_p2pdma_map_type(sg_page(sg)->pgmap, dev,
> +				       __DMA_ATTR_PCI_P2PDMA);
>   
>   	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
>   		dma_unmap_sg_attrs(dev, sg, nents, dir, attrs);
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index 8318a97c9c61..a06072ac3a52 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -16,6 +16,13 @@
>   struct block_device;
>   struct scatterlist;
>   
> +enum pci_p2pdma_map_type {
> +	PCI_P2PDMA_MAP_UNKNOWN = 0,
> +	PCI_P2PDMA_MAP_NOT_SUPPORTED,
> +	PCI_P2PDMA_MAP_BUS_ADDR,
> +	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
> +};
> +
>   #ifdef CONFIG_PCI_P2PDMA
>   int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>   		u64 offset);
> @@ -30,6 +37,8 @@ struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
>   					 unsigned int *nents, u32 length);
>   void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
>   void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
> +enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
> +		struct device *dev, unsigned long dma_attrs);
>   int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>   		int nents, enum dma_data_direction dir, unsigned long attrs);
>   void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
> @@ -83,6 +92,12 @@ static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
>   static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
>   {
>   }
> +static inline enum pci_p2pdma_map_type pci_p2pdma_map_type(
> +		struct dev_pagemap *pgmap, struct device *dev,
> +		unsigned long dma_attrs)
> +{
> +	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
> +}
>   static inline int pci_p2pdma_map_sg_attrs(struct device *dev,
>   		struct scatterlist *sg, int nents, enum dma_data_direction dir,
>   		unsigned long attrs)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
