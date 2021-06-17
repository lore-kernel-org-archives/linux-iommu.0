Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73058C2B9F4
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:17:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7571613B9
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7571613B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB515415D6;
	Thu, 17 Jun 2021 07:17:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PIawk4ojvpWu; Thu, 17 Jun 2021 07:17:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B2D1241607;
	Thu, 17 Jun 2021 07:17:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 841B1C000E;
	Thu, 17 Jun 2021 07:17:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F550C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4DB8D6070B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:17:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wTqUjgWVoc9M for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 07:17:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 12D7F606CB
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:17:36 +0000 (UTC)
IronPort-SDR: Fb2O4uIAeA1IhcnEaaIw2Wo76/naK9A83DlCidkvmMh0fmimA33CKMkBQ2aWaBPbxcEEY/2Zdr
 dIFOqo7+BWGw==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="186009258"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; d="scan'208";a="186009258"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2021 00:17:35 -0700
IronPort-SDR: 7mIaHJqyAcgjcjKemwRozT1mCbDOnCiIhOiokO+K3rim8RJj1C3utmbA4rTiduWFf1HbU9gXXn
 D9ohL96aueZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; d="scan'208";a="472325834"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2021 00:17:32 -0700
Subject: Re: [PATCH v7 05/15] iommu: Use bitmap to calculate page size in
 iommu_pgsize()
To: Georgi Djakov <quic_c_gdjako@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com
References: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
 <1623850736-389584-6-git-send-email-quic_c_gdjako@quicinc.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4d28e9cf-ac5d-06db-a110-2cdd3f506924@linux.intel.com>
Date: Thu, 17 Jun 2021 15:16:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1623850736-389584-6-git-send-email-quic_c_gdjako@quicinc.com>
Content-Language: en-US
Cc: isaacm@codeaurora.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, djakov@kernel.org, pratikp@codeaurora.org,
 linux-arm-kernel@lists.infradead.org
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

On 6/16/21 9:38 PM, Georgi Djakov wrote:
> From: Will Deacon <will@kernel.org>
> 
> Avoid the potential for shifting values by amounts greater than the
> width of their type by using a bitmap to compute page size in
> iommu_pgsize().
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>   drivers/iommu/iommu.c | 31 ++++++++++++-------------------
>   1 file changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 5419c4b9f27a..80e471ada358 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -8,6 +8,7 @@
>   
>   #include <linux/device.h>
>   #include <linux/kernel.h>
> +#include <linux/bits.h>
>   #include <linux/bug.h>
>   #include <linux/types.h>
>   #include <linux/init.h>
> @@ -2378,30 +2379,22 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
>   			   unsigned long addr_merge, size_t size)
>   {
>   	unsigned int pgsize_idx;
> +	unsigned long pgsizes;
>   	size_t pgsize;
>   
> -	/* Max page size that still fits into 'size' */
> -	pgsize_idx = __fls(size);
> +	/* Page sizes supported by the hardware and small enough for @size */
> +	pgsizes = domain->pgsize_bitmap & GENMASK(__fls(size), 0);
>   
> -	/* need to consider alignment requirements ? */
> -	if (likely(addr_merge)) {
> -		/* Max page size allowed by address */
> -		unsigned int align_pgsize_idx = __ffs(addr_merge);
> -		pgsize_idx = min(pgsize_idx, align_pgsize_idx);
> -	}
> -
> -	/* build a mask of acceptable page sizes */
> -	pgsize = (1UL << (pgsize_idx + 1)) - 1;
> -
> -	/* throw away page sizes not supported by the hardware */
> -	pgsize &= domain->pgsize_bitmap;
> +	/* Constrain the page sizes further based on the maximum alignment */
> +	if (likely(addr_merge))
> +		pgsizes &= GENMASK(__ffs(addr_merge), 0);
>   
> -	/* make sure we're still sane */
> -	BUG_ON(!pgsize);
> +	/* Make sure we have at least one suitable page size */
> +	BUG_ON(!pgsizes);
>   
> -	/* pick the biggest page */
> -	pgsize_idx = __fls(pgsize);
> -	pgsize = 1UL << pgsize_idx;
> +	/* Pick the biggest page size remaining */
> +	pgsize_idx = __fls(pgsizes);
> +	pgsize = BIT(pgsize_idx);
>   
>   	return pgsize;
>   }
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
