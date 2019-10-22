Return-Path: <SRS0=F9Hu=YP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04B9CA9EB9
	for <iommu@archiver.kernel.org>; Tue, 22 Oct 2019 13:25:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76DF021872
	for <iommu@archiver.kernel.org>; Tue, 22 Oct 2019 13:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DF021872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3CCFC1263;
	Tue, 22 Oct 2019 13:25:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 674D01259
	for <iommu@lists.linux-foundation.org>;
	Tue, 22 Oct 2019 13:25:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (unknown [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id DB641896
	for <iommu@lists.linux-foundation.org>;
	Tue, 22 Oct 2019 13:25:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E4932B;
	Tue, 22 Oct 2019 06:25:48 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE9C23F71F;
	Tue, 22 Oct 2019 06:25:46 -0700 (PDT)
Subject: Re: [RFC PATCH 1/3] dma-mapping: introduce a new dma api
	dma_addr_to_phys_addr()
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>, "hch@lst.de" <hch@lst.de>,
	"joro@8bytes.org" <joro@8bytes.org>,
	Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>
References: <20191022125502.12495-1-laurentiu.tudor@nxp.com>
	<20191022125502.12495-2-laurentiu.tudor@nxp.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <62561dca-cdd7-fe01-a0c3-7b5971c96e7e@arm.com>
Date: Tue, 22 Oct 2019 14:25:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191022125502.12495-2-laurentiu.tudor@nxp.com>
Content-Language: en-GB
Cc: Madalin-cristian Bucur <madalin.bucur@nxp.com>,
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

On 22/10/2019 13:55, Laurentiu Tudor wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Introduce a new dma map op called dma_addr_to_phys_addr() that converts
> a dma address to the physical address backing it up and add wrapper for
> it.

I'd really love it if there was a name which could encapsulate that this 
is *only* for extreme special cases of constrained descriptors/pagetable 
entries/etc. where there's simply no practical way to keep track of a 
CPU address alongside the DMA address, and the only option is this 
potentially-arbitrarily-complex operation (I mean, on some systems it 
may end up taking locks and poking hardware).

Either way it's tricky - much as I don't like adding an interface which 
is ripe for drivers to misuse, I also really don't want hacks like 
bdf95923086f shoved into other APIs to compensate, so on balance I'd 
probably consider this proposal ever so slightly the lesser evil.

> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>   include/linux/dma-mapping.h | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 4a1c4fca475a..5965d159c9a9 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -132,6 +132,8 @@ struct dma_map_ops {
>   	u64 (*get_required_mask)(struct device *dev);
>   	size_t (*max_mapping_size)(struct device *dev);
>   	unsigned long (*get_merge_boundary)(struct device *dev);
> +	phys_addr_t (*dma_addr_to_phys_addr)(struct device *dev,
> +					     dma_addr_t dma_handle);

I'd be inclined to name the internal callback something a bit snappier 
like .get_phys_addr.

>   };
>   
>   #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
> @@ -442,6 +444,19 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>   	return 0;
>   }
>   
> +static inline phys_addr_t dma_addr_to_phys_addr(struct device *dev,
> +						dma_addr_t dma_handle)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +
> +	if (dma_is_direct(ops))
> +		return (phys_addr_t)dma_handle;

Well that's not right, is it - remember why you had that namespace 
collision? ;)

Robin.

> +	else if (ops->dma_addr_to_phys_addr)
> +		return ops->dma_addr_to_phys_addr(dev, dma_handle);
> +
> +	return 0;
> +}
> +
>   void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   		gfp_t flag, unsigned long attrs);
>   void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
> @@ -578,6 +593,12 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
>   {
>   	return 0;
>   }
> +
> +static inline phys_addr_t dma_addr_to_phys_addr(struct device *dev,
> +						dma_addr_t dma_handle)
> +{
> +	return 0;
> +}
>   #endif /* CONFIG_HAS_DMA */
>   
>   static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
