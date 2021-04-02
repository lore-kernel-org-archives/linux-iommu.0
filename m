Return-Path: <SRS0=DOhO=I7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ED2C433B4
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 03:15:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0739D60FDC
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 03:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0739D60FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0CA260D5E;
	Fri,  2 Apr 2021 03:15:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IN9nkBOsAJcX; Fri,  2 Apr 2021 03:15:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 635CC60C32;
	Fri,  2 Apr 2021 03:15:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4960DC000B;
	Fri,  2 Apr 2021 03:15:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2961EC000A
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 03:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F7FB84BC6
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 03:15:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8LefcXFKVZld for <iommu@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 03:15:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C159984BC4
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 03:15:36 +0000 (UTC)
IronPort-SDR: UDDIQ3/gf1yfsJr43SDRny3bdoXnf2OghMGV75pL5PquTzpmJHBKQAVNhhX7rq4Nr+XiwbP0sp
 duOi+o8Zc54Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="190148758"
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; d="scan'208";a="190148758"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2021 20:15:34 -0700
IronPort-SDR: mWCofTGb+zOCsHT2FJk/D0jGvVvJ01//G9LsEk+Iog9W47QH4udM/T9l1qXmRpyjApFDXIInZO
 xUmh97glinFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; d="scan'208";a="439449589"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 01 Apr 2021 20:15:32 -0700
Subject: Re: [PATCH] iommu/vt-d: Force to flush iotlb before creating superpage
To: "Longpeng(Mike)" <longpeng2@huawei.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210401071834.1639-1-longpeng2@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <af470760-04c1-0929-7304-0879ca7af542@linux.intel.com>
Date: Fri, 2 Apr 2021 11:06:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210401071834.1639-1-longpeng2@huawei.com>
Content-Language: en-US
Cc: Kevin Tian <kevin.tian@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 stable@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Gonglei <arei.gonglei@huawei.com>
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

On 4/1/21 3:18 PM, Longpeng(Mike) wrote:
> The translation caches may preserve obsolete data when the
> mapping size is changed, suppose the following sequence which
> can reveal the problem with high probability.
> 
> 1.mmap(4GB,MAP_HUGETLB)
> 2.
>    while (1) {
>     (a)    DMA MAP   0,0xa0000
>     (b)    DMA UNMAP 0,0xa0000
>     (c)    DMA MAP   0,0xc0000000
>               * DMA read IOVA 0 may failure here (Not present)
>               * if the problem occurs.
>     (d)    DMA UNMAP 0,0xc0000000
>    }
> 
> The page table(only focus on IOVA 0) after (a) is:
>   PML4: 0x19db5c1003   entry:0xffff899bdcd2f000
>    PDPE: 0x1a1cacb003  entry:0xffff89b35b5c1000
>     PDE: 0x1a30a72003  entry:0xffff89b39cacb000
>      PTE: 0x21d200803  entry:0xffff89b3b0a72000
> 
> The page table after (b) is:
>   PML4: 0x19db5c1003   entry:0xffff899bdcd2f000
>    PDPE: 0x1a1cacb003  entry:0xffff89b35b5c1000
>     PDE: 0x1a30a72003  entry:0xffff89b39cacb000
>      PTE: 0x0          entry:0xffff89b3b0a72000
> 
> The page table after (c) is:
>   PML4: 0x19db5c1003   entry:0xffff899bdcd2f000
>    PDPE: 0x1a1cacb003  entry:0xffff89b35b5c1000
>     PDE: 0x21d200883   entry:0xffff89b39cacb000 (*)
> 
> Because the PDE entry after (b) is present, it won't be
> flushed even if the iommu driver flush cache when unmap,
> so the obsolete data may be preserved in cache, which
> would cause the wrong translation at end.
> 
> However, we can see the PDE entry is finally switch to
> 2M-superpage mapping, but it does not transform
> to 0x21d200883 directly:
> 
> 1. PDE: 0x1a30a72003
> 2. __domain_mapping
>       dma_pte_free_pagetable
>         Set the PDE entry to ZERO
>       Set the PDE entry to 0x21d200883
> 
> So we must flush the cache after the entry switch to ZERO
> to avoid the obsolete info be preserved.
> 
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Gonglei (Arei) <arei.gonglei@huawei.com>
> 
> Fixes: 6491d4d02893 ("intel-iommu: Free old page tables before creating superpage")
> Cc: <stable@vger.kernel.org> # v3.0+
> Link: https://lore.kernel.org/linux-iommu/670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com/
> Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>   drivers/iommu/intel/iommu.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index ee09323..cbcb434 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2342,9 +2342,20 @@ static inline int hardware_largepage_caps(struct dmar_domain *domain,
>   				 * removed to make room for superpage(s).
>   				 * We're adding new large pages, so make sure
>   				 * we don't remove their parent tables.
> +				 *
> +				 * We also need to flush the iotlb before creating
> +				 * superpage to ensure it does not perserves any
> +				 * obsolete info.
>   				 */
> -				dma_pte_free_pagetable(domain, iov_pfn, end_pfn,
> -						       largepage_lvl + 1);
> +				if (dma_pte_present(pte)) {
> +					int i;
> +
> +					dma_pte_free_pagetable(domain, iov_pfn, end_pfn,
> +							       largepage_lvl + 1);
> +					for_each_domain_iommu(i, domain)
> +						iommu_flush_iotlb_psi(g_iommus[i], domain,
> +								      iov_pfn, nr_pages, 0, 0);

Thanks for patch!

How about making the flushed page size accurate? For example,

@@ -2365,8 +2365,8 @@ __domain_mapping(struct dmar_domain *domain, 
unsigned long iov_pfn,
                                         dma_pte_free_pagetable(domain, 
iov_pfn, end_pfn,
 
largepage_lvl + 1);
                                         for_each_domain_iommu(i, domain)
- 
iommu_flush_iotlb_psi(g_iommus[i], domain,
- 
iov_pfn, nr_pages, 0, 0);
+ 
iommu_flush_iotlb_psi(g_iommus[i], domain, iov_pfn,
+ 
ALIGN_DOWN(nr_pages, lvl_pages), 0, 0);


> +				}
>   			} else {
>   				pteval &= ~(uint64_t)DMA_PTE_LARGE_PAGE;
>   			}
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
