Return-Path: <SRS0=Juc9=WR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1D5C3A59E
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 16:25:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B824206DD
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 16:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B824206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1DB4BB7A;
	Wed, 21 Aug 2019 16:25:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CB11DB79
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 16:25:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 5D3698A6
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 16:25:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC34A337;
	Wed, 21 Aug 2019 09:25:49 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB8FF3F718;
	Wed, 21 Aug 2019 09:25:48 -0700 (PDT)
Subject: Re: [PATCH v2 6/8] iommu/arm-smmu-v3: Fix ATC invalidation ordering
	wrt main TLBs
To: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org
References: <20190821151749.23743-1-will@kernel.org>
	<20190821151749.23743-7-will@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e5835d3e-6f8b-27fa-cb8f-7aa616a8b573@arm.com>
Date: Wed, 21 Aug 2019 17:25:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190821151749.23743-7-will@kernel.org>
Content-Language: en-GB
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
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

On 21/08/2019 16:17, Will Deacon wrote:
> When invalidating the ATC for an PCIe endpoint using ATS, we must take
> care to complete invalidation of the main SMMU TLBs beforehand, otherwise
> the device could immediately repopulate its ATC with stale translations.
> 
> Hooking the ATC invalidation into ->unmap() as we currently do does the
> exact opposite: it ensures that the ATC is invalidated *before*  the
> main TLBs, which is bogus.
> 
> Move ATC invalidation into the actual (leaf) invalidation routines so
> that it is always called after completing main TLB invalidation.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   drivers/iommu/arm-smmu-v3.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index d7c65dfe42dc..ca504a60312d 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1961,6 +1961,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>   	 */
>   	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
>   	arm_smmu_cmdq_issue_sync(smmu);
> +	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
>   }
>   
>   static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
> @@ -1969,7 +1970,7 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
>   {
>   	u64 cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
> -	unsigned long end = iova + size;
> +	unsigned long start = iova, end = iova + size;
>   	int i = 0;
>   	struct arm_smmu_cmdq_ent cmd = {
>   		.tlbi = {
> @@ -2001,6 +2002,12 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
>   	}
>   
>   	arm_smmu_cmdq_issue_cmdlist(smmu, cmds, i, true);
> +
> +	/*
> +	 * Unfortunately, this can't be leaf-only since we may have
> +	 * zapped an entire table.
> +	 */
> +	arm_smmu_atc_inv_domain(smmu_domain, 0, start, size);
>   }
>   
>   static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
> @@ -2420,18 +2427,13 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
>   static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
>   			     size_t size, struct iommu_iotlb_gather *gather)
>   {
> -	int ret;
>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>   	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
>   
>   	if (!ops)
>   		return 0;
>   
> -	ret = ops->unmap(ops, iova, size, gather);
> -	if (ret && arm_smmu_atc_inv_domain(smmu_domain, 0, iova, size))
> -		return 0;
> -
> -	return ret;
> +	return ops->unmap(ops, iova, size, gather);
>   }
>   
>   static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
