Return-Path: <SRS0=bsOk=CS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1964C433E2
	for <iommu@archiver.kernel.org>; Wed,  9 Sep 2020 01:40:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588ED21973
	for <iommu@archiver.kernel.org>; Wed,  9 Sep 2020 01:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588ED21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 165B22E134;
	Wed,  9 Sep 2020 01:40:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sk3t9+NxBzCJ; Wed,  9 Sep 2020 01:40:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A4D0727A6E;
	Wed,  9 Sep 2020 01:40:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B605C0859;
	Wed,  9 Sep 2020 01:40:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83C8BC0051
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 01:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6BBD186DDD
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 01:40:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9pJkpO8EgH-T for <iommu@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 01:40:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 29CD286DDA
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 01:40:26 +0000 (UTC)
IronPort-SDR: nnae/A34IYK0PqcRptq5jkleRygZGwFIpLazrJ+puSrxEMeymN+bOCaEat5LRucSQ21T9W5Nu/
 zzGgSGWsrkjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="158284904"
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; d="scan'208";a="158284904"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 18:40:25 -0700
IronPort-SDR: WMSjOTClk/BnM1hYxm5crF2kugypLx62hEHXMy2+D7mX+3VT/pnF5WHtzeS+O3Fo1n1FrtgzKF
 a8nAsNG6YTxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; d="scan'208";a="407315378"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 08 Sep 2020 18:40:23 -0700
Subject: Re: [PATCH V2 3/5] iommu: allow the dma-iommu api to use bounce
 buffers
To: Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org
References: <20200903201839.7327-1-murphyt7@tcd.ie>
 <20200903201839.7327-4-murphyt7@tcd.ie>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <01e99ad4-a3b2-f184-c350-8b9a808af28a@linux.intel.com>
Date: Wed, 9 Sep 2020 09:34:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903201839.7327-4-murphyt7@tcd.ie>
Content-Language: en-US
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
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

On 9/4/20 4:18 AM, Tom Murphy wrote:
> Allow the dma-iommu api to use bounce buffers for untrusted devices.
> This is a copy of the intel bounce buffer code.
> 
> Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
> ---
>   drivers/iommu/dma-iommu.c   | 94 ++++++++++++++++++++++++++++++-------
>   drivers/iommu/intel/iommu.c |  6 +++
>   drivers/iommu/iommu.c       | 10 ++++
>   include/linux/iommu.h       |  7 +++
>   4 files changed, 101 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 33f3f4f5edc5..185cd504ca5a 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -21,9 +21,11 @@
>   #include <linux/mm.h>
>   #include <linux/mutex.h>
>   #include <linux/pci.h>
> +#include <linux/swiotlb.h>
>   #include <linux/scatterlist.h>
>   #include <linux/vmalloc.h>
>   #include <linux/crash_dump.h>
> +#include <linux/dma-direct.h>
>   
>   struct iommu_dma_msi_page {
>   	struct list_head	list;
> @@ -498,26 +500,87 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
>   	iommu_dma_free_iova(cookie, dma_addr, size, iotlb_gather.freelist);
>   }
>   
> +static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
> +		size_t size, enum dma_data_direction dir,
> +		unsigned long attrs)
> +{
> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +	struct iova_domain *iovad = &cookie->iovad;
> +	size_t iova_off = iova_offset(iovad, dma_addr);
> +	size_t aligned_size = iova_align(iovad, size + iova_off);
> +	phys_addr_t phys;
> +
> +	phys = iommu_iova_to_phys(domain, dma_addr);
> +	if (WARN_ON(!phys))
> +		return;
> +
> +	__iommu_dma_unmap(dev, dma_addr, size);
> +
> +#ifdef CONFIG_SWIOTLB
> +	if (unlikely(is_swiotlb_buffer(phys)))
> +		swiotlb_tbl_unmap_single(dev, phys, size,
> +				aligned_size, dir, attrs);
> +#endif
> +}
> +
>   static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> -		size_t size, int prot, u64 dma_mask)
> +		size_t org_size, dma_addr_t dma_mask, bool coherent,
> +		enum dma_data_direction dir, unsigned long attrs)
>   {
> +	int prot = dma_info_to_prot(dir, coherent, attrs);
>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	struct iova_domain *iovad = &cookie->iovad;
>   	size_t iova_off = iova_offset(iovad, phys);
> +	size_t aligned_size = iova_align(iovad, org_size + iova_off);
> +	void *padding_start;
> +	size_t padding_size;
>   	dma_addr_t iova;
>   
>   	if (unlikely(iommu_dma_deferred_attach(dev, domain)))
>   		return DMA_MAPPING_ERROR;
>   
> -	size = iova_align(iovad, size + iova_off);
> +#ifdef CONFIG_SWIOTLB
> +	/*
> +	 * If both the physical buffer start address and size are
> +	 * page aligned, we don't need to use a bounce page.
> +	 */
> +	if (iommu_needs_bounce_buffer(dev)
> +			&& !iova_offset(iovad, phys | org_size)) {
> +		phys = swiotlb_tbl_map_single(dev,
> +				__phys_to_dma(dev, io_tlb_start),
> +				phys, org_size, aligned_size, dir, attrs);
> +
> +		if (phys == DMA_MAPPING_ERROR)
> +			return DMA_MAPPING_ERROR;
> +
> +		/* Cleanup the padding area. */
> +		padding_start = phys_to_virt(phys);
> +		padding_size = aligned_size;
> +
> +		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> +		    (dir == DMA_TO_DEVICE ||
> +		     dir == DMA_BIDIRECTIONAL)) {
> +			padding_start += org_size;
> +			padding_size -= org_size;
> +		}
>   
> -	iova = iommu_dma_alloc_iova(domain, size, dma_mask, dev);
> +		memset(padding_start, 0, padding_size);
> +	}
> +#endif
> +
> +	iova = iommu_dma_alloc_iova(domain, aligned_size, dma_mask, dev);
>   	if (!iova)
>   		return DMA_MAPPING_ERROR;
>   
> -	if (iommu_map_atomic(domain, iova, phys - iova_off, size, prot)) {
> -		iommu_dma_free_iova(cookie, iova, size, NULL);
> +	if (iommu_map_atomic(domain, iova, phys - iova_off, aligned_size,
> +				prot)) {
> +
> +		if (unlikely(is_swiotlb_buffer(phys)))
> +			swiotlb_tbl_unmap_single(dev, phys, aligned_size,
> +					aligned_size, dir, attrs);
> +		iommu_dma_free_iova(cookie, iova, aligned_size, NULL);
>   		return DMA_MAPPING_ERROR;
>   	}
>   	return iova + iova_off;
> @@ -751,10 +814,10 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   {
>   	phys_addr_t phys = page_to_phys(page) + offset;
>   	bool coherent = dev_is_dma_coherent(dev);
> -	int prot = dma_info_to_prot(dir, coherent, attrs);
>   	dma_addr_t dma_handle;
>   
> -	dma_handle = __iommu_dma_map(dev, phys, size, prot, dma_get_mask(dev));
> +	dma_handle = __iommu_dma_map(dev, phys, size, dma_get_mask(dev),
> +			coherent, dir, attrs);
>   	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>   	    dma_handle != DMA_MAPPING_ERROR)
>   		arch_sync_dma_for_device(phys, size, dir);
> @@ -766,7 +829,7 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
>   {
>   	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>   		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
> -	__iommu_dma_unmap(dev, dma_handle, size);
> +	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);
>   }
>   
>   /*
> @@ -950,21 +1013,20 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   		sg = tmp;
>   	}
>   	end = sg_dma_address(sg) + sg_dma_len(sg);
> -	__iommu_dma_unmap(dev, start, end - start);
> +	__iommu_dma_unmap_swiotlb(dev, start, end - start, dir, attrs);
>   }
>   
>   static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
> -	return __iommu_dma_map(dev, phys, size,
> -			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
> -			dma_get_mask(dev));
> +	return __iommu_dma_map(dev, phys, size, dma_get_mask(dev), false, dir,
> +			attrs);
>   }
>   
>   static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
> -	__iommu_dma_unmap(dev, handle, size);
> +	__iommu_dma_unmap_swiotlb(dev, handle, size, dir, attrs);
>   }
>   
>   static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
> @@ -1046,7 +1108,6 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
>   		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
>   {
>   	bool coherent = dev_is_dma_coherent(dev);
> -	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
>   	struct page *page = NULL;
>   	void *cpu_addr;
>   
> @@ -1065,8 +1126,9 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
>   	if (!cpu_addr)
>   		return NULL;
>   
> -	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot,
> -			dev->coherent_dma_mask);
> +	*handle = __iommu_dma_map(dev, page_to_phys(page), size,
> +			dev->coherent_dma_mask, coherent, DMA_BIDIRECTIONAL,
> +			attrs);
>   	if (*handle == DMA_MAPPING_ERROR) {
>   		__iommu_dma_free(dev, size, cpu_addr);
>   		return NULL;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 03699860880b..ba47623f0f12 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5713,6 +5713,11 @@ static void intel_iommu_probe_finalize(struct device *dev)
>   		set_dma_ops(dev, NULL);
>   }
>   
> +static int intel_iommu_needs_bounce_buffer(struct device *d)
> +{
> +	return !intel_no_bounce && dev_is_pci(d) && to_pci_dev(d)->untrusted;

The intel_no_bounce option is added only for performance evaluation
during development phase. It should not be used in real field. I will
remove this include the .need_bounce_buffer callback if no objection.

Best regards,
baolu

> +}
> +
>   static void intel_iommu_get_resv_regions(struct device *device,
>   					 struct list_head *head)
>   {
> @@ -6079,6 +6084,7 @@ const struct iommu_ops intel_iommu_ops = {
>   	.probe_device		= intel_iommu_probe_device,
>   	.probe_finalize		= intel_iommu_probe_finalize,
>   	.release_device		= intel_iommu_release_device,
> +	.needs_bounce_buffer	= intel_iommu_needs_bounce_buffer,
>   	.get_resv_regions	= intel_iommu_get_resv_regions,
>   	.put_resv_regions	= generic_iommu_put_resv_regions,
>   	.apply_resv_region	= intel_iommu_apply_resv_region,
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index b6858adc4f17..8da26c73122f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2497,6 +2497,16 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
>   }
>   EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
>   
> +int iommu_needs_bounce_buffer(struct device *dev)
> +{
> +	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +
> +	if (ops && ops->needs_bounce_buffer)
> +		return ops->needs_bounce_buffer(dev);
> +
> +	return 0;
> +}
> +
>   void iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   {
>   	const struct iommu_ops *ops = dev->bus->iommu_ops;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index e3eafb3cf4ba..4c2d2619fd8c 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -263,6 +263,7 @@ struct iommu_ops {
>   			       enum iommu_attr attr, void *data);
>   	int (*domain_set_attr)(struct iommu_domain *domain,
>   			       enum iommu_attr attr, void *data);
> +	int (*needs_bounce_buffer)(struct device *dev);
>   
>   	/* Request/Free a list of reserved regions for a device */
>   	void (*get_resv_regions)(struct device *dev, struct list_head *list);
> @@ -474,6 +475,7 @@ static inline size_t iommu_map_sgtable(struct iommu_domain *domain,
>   	return iommu_map_sg(domain, iova, sgt->sgl, sgt->orig_nents, prot);
>   }
>   
> +extern int iommu_needs_bounce_buffer(struct device *dev);
>   extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
>   extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
>   extern void generic_iommu_put_resv_regions(struct device *dev,
> @@ -779,6 +781,11 @@ static inline void iommu_set_fault_handler(struct iommu_domain *domain,
>   {
>   }
>   
> +static inline int iommu_needs_bounce_buffer(struct device *dev)
> +{
> +	return 0;
> +}
> +
>   static inline void iommu_get_resv_regions(struct device *dev,
>   					struct list_head *list)
>   {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
