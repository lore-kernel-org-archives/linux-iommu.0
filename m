Return-Path: <SRS0=lDjG=O4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79979C433F5
	for <iommu@archiver.kernel.org>; Fri,  8 Oct 2021 02:11:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083F961056
	for <iommu@archiver.kernel.org>; Fri,  8 Oct 2021 02:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 083F961056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB256606F3;
	Fri,  8 Oct 2021 02:11:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r8fvoYKYoPCV; Fri,  8 Oct 2021 02:11:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7B6D2606E8;
	Fri,  8 Oct 2021 02:11:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DBE5C0011;
	Fri,  8 Oct 2021 02:11:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABF78C000D
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 02:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8000A606F3
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 02:11:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9u0H2E1rv8kH for <iommu@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 02:11:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B121E606E8
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 02:11:08 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="289915948"
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; d="scan'208";a="289915948"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2021 19:11:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; d="scan'208";a="478804301"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 07 Oct 2021 19:11:05 -0700
Subject: Re: [PATCH v3 2/2] iommu/vt-d: avoid duplicated removing in
 __domain_mapping
To: "Longpeng(Mike)" <longpeng2@huawei.com>, dwmw2@infradead.org,
 will@kernel.org, joro@8bytes.org
References: <20211008000433.1115-1-longpeng2@huawei.com>
 <20211008000433.1115-3-longpeng2@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <54cf3663-85e0-3e63-9112-385e9d6eeceb@linux.intel.com>
Date: Fri, 8 Oct 2021 10:07:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211008000433.1115-3-longpeng2@huawei.com>
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

On 10/8/21 8:04 AM, Longpeng(Mike) wrote:
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
> to the boundary of the end of this pte page.
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
> ---
>   drivers/iommu/intel/iommu.c | 11 ++++++-----
>   include/linux/intel-iommu.h |  6 ++++++
>   2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d75f59a..46edae6 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2354,12 +2354,17 @@ static void switch_to_super_page(struct dmar_domain *domain,
>   				return -ENOMEM;
>   			first_pte = pte;
>   
> +			lvl_pages = lvl_to_nr_pages(largepage_lvl);
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
> @@ -2381,10 +2386,6 @@ static void switch_to_super_page(struct dmar_domain *domain,
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
> index 9bcabc7..b29b2a3 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -713,6 +713,12 @@ static inline bool first_pte_in_page(struct dma_pte *pte)
>   	return IS_ALIGNED((unsigned long)pte, VTD_PAGE_SIZE);
>   }
>   
> +static inline int nr_pte_to_next_page(struct dma_pte *pte)
> +{
> +	return first_pte_in_page(pte) ? BIT_ULL(VTD_STRIDE_SHIFT) :
> +		(struct dma_pte *)ALIGN((unsigned long)pte, VTD_PAGE_SIZE) - pte;

We should make it like this to avoid the 0day warning:

	(struct dma_pte *)(uintptr_t)VTD_PAGE_ALIGN((unsigned long)pte) - pte;

Can you please test this line of change? No need to send a new version.
I will handle it if it passes your test.

> +}
> +
>   extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
>   extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
>   
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
