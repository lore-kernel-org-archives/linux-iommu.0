Return-Path: <SRS0=QSCI=P7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685FFC433EF
	for <iommu@archiver.kernel.org>; Fri, 12 Nov 2021 03:04:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F5F60F4A
	for <iommu@archiver.kernel.org>; Fri, 12 Nov 2021 03:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E5F5F60F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84CE04055E;
	Fri, 12 Nov 2021 03:04:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ssPa4NQUxbzu; Fri, 12 Nov 2021 03:04:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A35E44054A;
	Fri, 12 Nov 2021 03:04:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86B6FC0012;
	Fri, 12 Nov 2021 03:04:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BE9DC000E
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 03:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37F9E4054B
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 03:04:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rovQVB1fShHy for <iommu@lists.linux-foundation.org>;
 Fri, 12 Nov 2021 03:03:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 545214053E
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 03:03:59 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="233007403"
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; d="scan'208";a="233007403"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2021 19:03:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; d="scan'208";a="452987955"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga006.jf.intel.com with ESMTP; 11 Nov 2021 19:03:56 -0800
Subject: Re: [PATCH] iommu/vt-d: Fix unmap_pages support
To: Alex Williamson <alex.williamson@redhat.com>
References: <163659074748.1617923.12716161410774184024.stgit@omen>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <511aa70f-0646-bd90-b14e-ba1cfaa517d0@linux.intel.com>
Date: Fri, 12 Nov 2021 10:59:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <163659074748.1617923.12716161410774184024.stgit@omen>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org
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

Hi Alex,

On 11/11/21 8:32 AM, Alex Williamson wrote:
> When supporting only the .map and .unmap callbacks of iommu_ops,
> the IOMMU driver can make assumptions about the size and alignment
> used for mappings based on the driver provided pgsize_bitmap.  VT-d
> previously used essentially PAGE_MASK for this bitmap as any power
> of two mapping was acceptably filled by native page sizes.
> 
> However, with the .map_pages and .unmap_pages interface we're now
> getting page-size and count arguments.  If we simply combine these
> as (page-size * count) and make use of the previous map/unmap
> functions internally, any size and alignment assumptions are very
> different.
> 
> As an example, a given vfio device assignment VM will often create
> a 4MB mapping at IOVA pfn [0x3fe00 - 0x401ff].  On a system that
> does not support IOMMU super pages, the unmap_pages interface will
> ask to unmap 1024 4KB pages at the base IOVA.  dma_pte_clear_level()
> will recurse down to level 2 of the page table where the first half
> of the pfn range exactly matches the entire pte level.  We clear the
> pte, increment the pfn by the level size, but (oops) the next pte is
> on a new page, so we exit the loop an pop back up a level.  When we
> then update the pfn based on that higher level, we seem to assume
> that the previous pfn value was at the start of the level.  In this
> case the level size is 256K pfns, which we add to the base pfn and
> get a results of 0x7fe00, which is clearly greater than 0x401ff,
> so we're done.  Meanwhile we never cleared the ptes for the remainder
> of the range.  When the VM remaps this range, we're overwriting valid
> ptes and the VT-d driver complains loudly, as reported by the user
> report linked below.
> 
> The fix for this seems relatively simple, if each iteration of the
> loop in dma_pte_clear_level() is assumed to clear to the end of the
> level pte page, then our next pfn should be calculated from level_pfn
> rather than our working pfn.
> 
> Fixes: 3f34f1259776 ("iommu/vt-d: Implement map/unmap_pages() iommu_ops callback")
> Reported-by: Ajay Garg <ajaygargnsit@gmail.com>
> Link: https://lore.kernel.org/all/20211002124012.18186-1-ajaygargnsit@gmail.com/
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Thank you for fixing this! I will queue it for v5.16.

Best regards,
baolu

> ---
>   drivers/iommu/intel/iommu.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d75f59ae28e6..f6395f5425f0 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1249,7 +1249,7 @@ static struct page *dma_pte_clear_level(struct dmar_domain *domain, int level,
>   						       freelist);
>   		}
>   next:
> -		pfn += level_size(level);
> +		pfn = level_pfn + level_size(level);
>   	} while (!first_pte_in_page(++pte) && pfn <= last_pfn);
>   
>   	if (first_pte)
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
