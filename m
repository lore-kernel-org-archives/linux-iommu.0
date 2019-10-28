Return-Path: <SRS0=Xx/3=YV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8890CA9EC1
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 13:42:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E24214B2
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 13:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E24214B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 576C310EA;
	Mon, 28 Oct 2019 13:42:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1DDCD10BB
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 13:42:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 62C2A87B
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 13:42:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C01261F1;
	Mon, 28 Oct 2019 06:42:45 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A0AF3F6C4;
	Mon, 28 Oct 2019 06:42:44 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] dma-mapping: introduce new dma unmap and sync api
	variants
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>, "hch@lst.de" <hch@lst.de>,
	"joro@8bytes.org" <joro@8bytes.org>,
	Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>
References: <20191024124130.16871-1-laurentiu.tudor@nxp.com>
	<20191024124130.16871-2-laurentiu.tudor@nxp.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ffcdb378-85df-f662-4961-49ff280f39d9@arm.com>
Date: Mon, 28 Oct 2019 13:42:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191024124130.16871-2-laurentiu.tudor@nxp.com>
Content-Language: en-GB
Cc: Madalin Bucur <madalin.bucur@nxp.com>,
	"davem@davemloft.net" <davem@davemloft.net>, Leo Li <leoyang.li@nxp.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 24/10/2019 13:41, Laurentiu Tudor wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Introduce a few new dma unmap and sync variants that, on top of the
> original variants, return the virtual address corresponding to the
> input dma address.
> In order to implement this a new dma map op is added and used:
>      void *get_virt_addr(dev, dma_handle);
> It does the actual conversion of an input dma address to the output
> virtual address.

At this point, I think it might be better to just change the prototype 
of the .unmap_page/.sync_single_for_cpu callbacks themselves. In cases 
where .get_virt_addr would be non-trivial, it's most likely duplicating 
work that the relevant callback has to do anyway (i.e. where the virtual 
and/or physical address is needed internally for a cache maintenance or 
bounce buffer operation). It would also help avoid any possible 
ambiguity about whether .get_virt_addr returns the VA corresponding 
dma_handle (if one exists) rather than the VA of the buffer *mapped to* 
dma_handle, which for a bounce-buffering implementation would be 
different, and the one you actually need - a naive 
phys_to_virt(dma_to_phys(dma_handle)) would lead you to the wrong place 
(in fact it looks like DPAA2 would currently go wrong with 
"swiotlb=force" and the SMMU disabled or in passthrough).

One question there is whether we'd want careful special-casing to avoid 
introducing overhead where unmap/sync are currently complete no-ops, or 
whether an extra phys_to_virt() or so in those paths would be tolerable.

> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>   include/linux/dma-mapping.h | 55 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 4a1c4fca475a..ae7bb8a84b9d 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -132,6 +132,7 @@ struct dma_map_ops {
>   	u64 (*get_required_mask)(struct device *dev);
>   	size_t (*max_mapping_size)(struct device *dev);
>   	unsigned long (*get_merge_boundary)(struct device *dev);
> +	void *(*get_virt_addr)(struct device *dev, dma_addr_t dma_handle);
>   };
>   
>   #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
> @@ -304,6 +305,21 @@ static inline void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr,
>   	debug_dma_unmap_page(dev, addr, size, dir);
>   }
>   
> +static inline struct page *
> +dma_unmap_page_attrs_desc(struct device *dev, dma_addr_t addr, size_t size,
> +			  enum dma_data_direction dir, unsigned long attrs)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +	void *ptr = NULL;
> +
> +	if (ops && ops->get_virt_addr)
> +		ptr = ops->get_virt_addr(dev, addr);

Note that this doesn't work for dma-direct, but for the sake of arm64 at 
least it almost certainly wants to.

Robin.

> +	dma_unmap_page_attrs(dev, addr, size, dir, attrs);
> +
> +	return ptr ? virt_to_page(ptr) : NULL;
> +}
> +
>   /*
>    * dma_maps_sg_attrs returns 0 on error and > 0 on success.
>    * It should never return a value < 0.
> @@ -390,6 +406,21 @@ static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
>   	debug_dma_sync_single_for_cpu(dev, addr, size, dir);
>   }
>   
> +static inline void *
> +dma_sync_single_for_cpu_desc(struct device *dev, dma_addr_t addr, size_t size,
> +			     enum dma_data_direction dir)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +	void *ptr = NULL;
> +
> +	if (ops && ops->get_virt_addr)
> +		ptr = ops->get_virt_addr(dev, addr);
> +
> +	dma_sync_single_for_cpu(dev, addr, size, dir);
> +
> +	return ptr;
> +}
> +
>   static inline void dma_sync_single_for_device(struct device *dev,
>   					      dma_addr_t addr, size_t size,
>   					      enum dma_data_direction dir)
> @@ -500,6 +531,12 @@ static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
>   		size_t size, enum dma_data_direction dir)
>   {
>   }
> +
> +static inline void *
> +dma_sync_single_for_cpu_desc(struct device *dev, dma_addr_t addr, size_t size,
> +			     enum dma_data_direction dir)
> +{
> +}
>   static inline void dma_sync_single_for_device(struct device *dev,
>   		dma_addr_t addr, size_t size, enum dma_data_direction dir)
>   {
> @@ -594,6 +631,21 @@ static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
>   	return dma_unmap_page_attrs(dev, addr, size, dir, attrs);
>   }
>   
> +static inline void *
> +dma_unmap_single_attrs_desc(struct device *dev, dma_addr_t addr, size_t size,
> +			    enum dma_data_direction dir, unsigned long attrs)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +	void *ptr = NULL;
> +
> +	if (ops && ops->get_virt_addr)
> +		ptr = ops->get_virt_addr(dev, addr);
> +
> +	dma_unmap_single_attrs(dev, addr, size, dir, attrs);
> +
> +	return ptr;
> +}
> +
>   static inline void dma_sync_single_range_for_cpu(struct device *dev,
>   		dma_addr_t addr, unsigned long offset, size_t size,
>   		enum dma_data_direction dir)
> @@ -610,10 +662,13 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
>   
>   #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
>   #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
> +#define dma_unmap_single_desc(d, a, s, r) \
> +		dma_unmap_single_attrs_desc(d, a, s, r, 0)
>   #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
>   #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
>   #define dma_map_page(d, p, o, s, r) dma_map_page_attrs(d, p, o, s, r, 0)
>   #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
> +#define dma_unmap_page_desc(d, a, s, r) dma_unmap_page_attrs_desc(d, a, s, r, 0)
>   #define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, 0)
>   #define dma_mmap_coherent(d, v, c, h, s) dma_mmap_attrs(d, v, c, h, s, 0)
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
