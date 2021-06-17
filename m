Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AADC2B9F4
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:18:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8630361241
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8630361241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C1C4606DD;
	Thu, 17 Jun 2021 07:18:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GSS-nNKhi_Om; Thu, 17 Jun 2021 07:18:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 35ACA606CB;
	Thu, 17 Jun 2021 07:18:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5268C000E;
	Thu, 17 Jun 2021 07:18:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18FFEC000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:18:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 145784056B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:18:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 58RcPY3xwErZ for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 07:18:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5BFDA40150
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:18:50 +0000 (UTC)
IronPort-SDR: M9XjshJ+q2IeQfa3QtCX6gxVWA7gv4hGFlnEWJW0yYt/p+LixSYXf+1q/8cMAZFx5fIk3gOg2L
 QLSfs/yhjG6A==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="267465282"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; d="scan'208";a="267465282"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2021 00:18:40 -0700
IronPort-SDR: p9P7Of8bXcURhxEQ7QVJfZ0eAGv7dO+302tJ+CVcvyeZPQIfuCx0r5wP8QM8reaCVTRnkMAvFS
 GaK90l/9wVVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; d="scan'208";a="472326150"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2021 00:18:36 -0700
Subject: Re: [PATCH v7 06/15] iommu: Split 'addr_merge' argument to
 iommu_pgsize() into separate parts
To: Georgi Djakov <quic_c_gdjako@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com
References: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
 <1623850736-389584-7-git-send-email-quic_c_gdjako@quicinc.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <21ba382a-8add-5872-13c9-6f97698a594d@linux.intel.com>
Date: Thu, 17 Jun 2021 15:17:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1623850736-389584-7-git-send-email-quic_c_gdjako@quicinc.com>
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
> The 'addr_merge' parameter to iommu_pgsize() is a fabricated address
> intended to describe the alignment requirements to consider when
> choosing an appropriate page size. On the iommu_map() path, this address
> is the logical OR of the virtual and physical addresses.
> 
> Subsequent improvements to iommu_pgsize() will need to check the
> alignment of the virtual and physical components of 'addr_merge'
> independently, so pass them in as separate parameters and reconstruct
> 'addr_merge' locally.
> 
> No functional change.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>   drivers/iommu/iommu.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 80e471ada358..80e14c139d40 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2375,12 +2375,13 @@ phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
>   }
>   EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
>   
> -static size_t iommu_pgsize(struct iommu_domain *domain,
> -			   unsigned long addr_merge, size_t size)
> +static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
> +			   phys_addr_t paddr, size_t size)
>   {
>   	unsigned int pgsize_idx;
>   	unsigned long pgsizes;
>   	size_t pgsize;
> +	unsigned long addr_merge = paddr | iova;
>   
>   	/* Page sizes supported by the hardware and small enough for @size */
>   	pgsizes = domain->pgsize_bitmap & GENMASK(__fls(size), 0);
> @@ -2433,7 +2434,7 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>   	pr_debug("map: iova 0x%lx pa %pa size 0x%zx\n", iova, &paddr, size);
>   
>   	while (size) {
> -		size_t pgsize = iommu_pgsize(domain, iova | paddr, size);
> +		size_t pgsize = iommu_pgsize(domain, iova, paddr, size);
>   
>   		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
>   			 iova, &paddr, pgsize);
> @@ -2521,8 +2522,9 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
>   	 * or we hit an area that isn't mapped.
>   	 */
>   	while (unmapped < size) {
> -		size_t pgsize = iommu_pgsize(domain, iova, size - unmapped);
> +		size_t pgsize;
>   
> +		pgsize = iommu_pgsize(domain, iova, iova, size - unmapped);
>   		unmapped_page = ops->unmap(domain, iova, pgsize, iotlb_gather);
>   		if (!unmapped_page)
>   			break;
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
