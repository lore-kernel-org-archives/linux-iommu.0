Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA16C433F5
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 14:14:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E476619FA
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 14:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E476619FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8E1D404BD;
	Thu, 30 Sep 2021 14:14:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VshLt4dy4hY9; Thu, 30 Sep 2021 14:14:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AEBD840448;
	Thu, 30 Sep 2021 14:14:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89EC7C000F;
	Thu, 30 Sep 2021 14:14:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39541C000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 14:14:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1A5644011F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 14:14:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oiz_KSHZLh5K for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 14:14:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05823400EE
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 14:14:09 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="204677731"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; d="scan'208";a="204677731"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2021 07:14:09 -0700
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; d="scan'208";a="564196256"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.141])
 ([10.254.214.141])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2021 07:14:07 -0700
Subject: Re: [PATCH v1 2/2] iommu/vt-d: avoid duplicated removing in
 __domain_mapping
To: "Longpeng(Mike)" <longpeng2@huawei.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org
References: <20210915152129.1254-1-longpeng2@huawei.com>
 <20210915152129.1254-3-longpeng2@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2d060249-8503-6b68-33ed-7623f62686ae@linux.intel.com>
Date: Thu, 30 Sep 2021 22:14:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210915152129.1254-3-longpeng2@huawei.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, arei.gonglei@huawei.com,
 linux-kernel@vger.kernel.org
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

Hi Longpeng,

On 2021/9/15 23:21, Longpeng(Mike) wrote:
> __domain_mapping() always removes the pages in the range from
> 'iov_pfn' to 'end_pfn', but the 'end_pfn' is always the last pfn
> of the range that the caller wants to map.
> 
> This would introduce too many duplicated removing and leads the
> map operation take too long, for example:
> 
>    Map iova=0x100000,nr_pages=0x7d61800
>      iov_pfn: 0x100000, end_pfn: 0x7e617ff
>      iov_pfn: 0x140000, end_pfn: 0x7e617ff
>      iov_pfn: 0x180000, end_pfn: 0x7e617ff
>      iov_pfn: 0x1c0000, end_pfn: 0x7e617ff
>      iov_pfn: 0x200000, end_pfn: 0x7e617ff
>      ...
>    it takes about 50ms in total.
> 
> We can reduce the cost by recalculate the 'end_pfn' and limit it
> to the boundary of the end of the pte page.
> 
>    Map iova=0x100000,nr_pages=0x7d61800
>      iov_pfn: 0x100000, end_pfn: 0x13ffff
>      iov_pfn: 0x140000, end_pfn: 0x17ffff
>      iov_pfn: 0x180000, end_pfn: 0x1bffff
>      iov_pfn: 0x1c0000, end_pfn: 0x1fffff
>      iov_pfn: 0x200000, end_pfn: 0x23ffff
>      ...
>    it only need 9ms now.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>

The 0day robot reports below compiling warning when building a 32-bit
kernel (make W=1 ARCH=i386):

All errors (new ones prefixed by >>):

    In file included from drivers/gpu/drm/i915/i915_drv.h:43,
                     from 
drivers/gpu/drm/i915/display/intel_display_types.h:47,
                     from drivers/gpu/drm/i915/display/intel_dsi.h:30,
                     from <command-line>:
    include/linux/intel-iommu.h: In function 'nr_pte_to_next_page':
 >> include/linux/intel-iommu.h:719:3: error: cast to pointer from 
integer of different size [-Werror=int-to-pointer-cast]
      719 |   (struct dma_pte *)VTD_PAGE_ALIGN((unsigned long)pte) - pte;
          |   ^
    cc1: all warnings being treated as errors


vim +719 include/linux/intel-iommu.h

    715	
    716	static inline int nr_pte_to_next_page(struct dma_pte *pte)
    717	{
    718		return first_pte_in_page(pte) ? BIT_ULL(VTD_STRIDE_SHIFT) :
  > 719			(struct dma_pte *)VTD_PAGE_ALIGN((unsigned long)pte) - pte;
    720	}
    721	

Can you please take a look at this?

Best regards,
baolu

> ---
>   drivers/iommu/intel/iommu.c | 12 +++++++-----
>   include/linux/intel-iommu.h |  6 ++++++
>   2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d75f59a..87cbf34 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2354,12 +2354,18 @@ static void switch_to_super_page(struct dmar_domain *domain,
>   				return -ENOMEM;
>   			first_pte = pte;
>   
> +			lvl_pages = lvl_to_nr_pages(largepage_lvl);
> +			BUG_ON(nr_pages < lvl_pages);
> +
>   			/* It is large page*/
>   			if (largepage_lvl > 1) {
>   				unsigned long end_pfn;
> +				unsigned long pages_to_remove;
>   
>   				pteval |= DMA_PTE_LARGE_PAGE;
> -				end_pfn = ((iov_pfn + nr_pages) & level_mask(largepage_lvl)) - 1;
> +				pages_to_remove = min_t(unsigned long, nr_pages,
> +							nr_pte_to_next_page(pte) * lvl_pages);
> +				end_pfn = iov_pfn + pages_to_remove - 1;
>   				switch_to_super_page(domain, iov_pfn, end_pfn, largepage_lvl);
>   			} else {
>   				pteval &= ~(uint64_t)DMA_PTE_LARGE_PAGE;
> @@ -2381,10 +2387,6 @@ static void switch_to_super_page(struct dmar_domain *domain,
>   			WARN_ON(1);
>   		}
>   
> -		lvl_pages = lvl_to_nr_pages(largepage_lvl);
> -
> -		BUG_ON(nr_pages < lvl_pages);
> -
>   		nr_pages -= lvl_pages;
>   		iov_pfn += lvl_pages;
>   		phys_pfn += lvl_pages;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index a590b00..4bff70c 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -713,6 +713,12 @@ static inline bool first_pte_in_page(struct dma_pte *pte)
>   	return !((unsigned long)pte & ~VTD_PAGE_MASK);
>   }
>   
> +static inline int nr_pte_to_next_page(struct dma_pte *pte)
> +{
> +	return first_pte_in_page(pte) ? BIT_ULL(VTD_STRIDE_SHIFT) :
> +		(struct dma_pte *)VTD_PAGE_ALIGN((unsigned long)pte) - pte;
> +}
> +
>   extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
>   extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
