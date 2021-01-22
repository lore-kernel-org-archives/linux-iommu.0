Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30BCC433DB
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 13:56:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 340A9235F7
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 13:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340A9235F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E792B870D9;
	Fri, 22 Jan 2021 13:56:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6anlp6BGwsON; Fri, 22 Jan 2021 13:56:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CB850870A8;
	Fri, 22 Jan 2021 13:56:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F60EC08A1;
	Fri, 22 Jan 2021 13:56:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F6E1C013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5EEFD870A8
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:56:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NLUUpeJG32zo for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 13:56:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 46850870A9
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:56:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9179811B3;
 Fri, 22 Jan 2021 05:56:49 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABC403F66E;
 Fri, 22 Jan 2021 05:56:47 -0800 (PST)
Subject: Re: [PATCH 1/3] iommu/arm-smmu-v3: Split arm_smmu_tlb_inv_range()
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, will@kernel.org,
 joro@8bytes.org
References: <20210122115257.2502526-1-jean-philippe@linaro.org>
 <20210122115257.2502526-2-jean-philippe@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <4a4cee75-2ebb-6de8-05c3-2973b08d5428@arm.com>
Date: Fri, 22 Jan 2021 13:56:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122115257.2502526-2-jean-philippe@linaro.org>
Content-Language: en-GB
Cc: vivek.gautam@arm.com, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, linux-arm-kernel@lists.infradead.org
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

On 2021-01-22 11:52, Jean-Philippe Brucker wrote:
> Extract some of the cmd initialization and the ATC invalidation from
> arm_smmu_tlb_inv_range(), to allow an MMU notifier to invalidate a VA
> range by ASID.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 62 ++++++++++++---------
>   1 file changed, 35 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 740a3d487591..a27b074d5c0c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1934,40 +1934,27 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>   	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
>   }
>   
> -static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
> -				   size_t granule, bool leaf,
> +static void arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
> +				   unsigned long iova, size_t size,
> +				   size_t granule,
>   				   struct arm_smmu_domain *smmu_domain)

To keep with the specific low-level helper vibe, maybe we should just 
pass the pgsize_bitmap directly, since I think that's all we're using 
the domain for now.

Robin.

>   {
>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
> -	unsigned long start = iova, end = iova + size, num_pages = 0, tg = 0;
> +	unsigned long end = iova + size, num_pages = 0, tg = 0;
>   	size_t inv_range = granule;
>   	struct arm_smmu_cmdq_batch cmds = {};
> -	struct arm_smmu_cmdq_ent cmd = {
> -		.tlbi = {
> -			.leaf	= leaf,
> -		},
> -	};
> -
>   	if (!size)
>   		return;
>   
> -	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> -		cmd.opcode	= CMDQ_OP_TLBI_NH_VA;
> -		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
> -	} else {
> -		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
> -		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
> -	}
> -
>   	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
>   		/* Get the leaf page size */
>   		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
>   
>   		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
> -		cmd.tlbi.tg = (tg - 10) / 2;
> +		cmd->tlbi.tg = (tg - 10) / 2;
>   
>   		/* Determine what level the granule is at */
> -		cmd.tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
> +		cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
>   
>   		num_pages = size >> tg;
>   	}
> @@ -1985,11 +1972,11 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
>   
>   			/* Determine the power of 2 multiple number of pages */
>   			scale = __ffs(num_pages);
> -			cmd.tlbi.scale = scale;
> +			cmd->tlbi.scale = scale;
>   
>   			/* Determine how many chunks of 2^scale size we have */
>   			num = (num_pages >> scale) & CMDQ_TLBI_RANGE_NUM_MAX;
> -			cmd.tlbi.num = num - 1;
> +			cmd->tlbi.num = num - 1;
>   
>   			/* range is num * 2^scale * pgsize */
>   			inv_range = num << (scale + tg);
> @@ -1998,17 +1985,37 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
>   			num_pages -= num << scale;
>   		}
>   
> -		cmd.tlbi.addr = iova;
> -		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
> +		cmd->tlbi.addr = iova;
> +		arm_smmu_cmdq_batch_add(smmu, &cmds, cmd);
>   		iova += inv_range;
>   	}
>   	arm_smmu_cmdq_batch_submit(smmu, &cmds);
> +}
> +
> +static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
> +					  size_t granule, bool leaf,
> +					  struct arm_smmu_domain *smmu_domain)
> +{
> +	struct arm_smmu_cmdq_ent cmd = {
> +		.tlbi = {
> +			.leaf	= leaf,
> +		},
> +	};
> +
> +	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> +		cmd.opcode	= CMDQ_OP_TLBI_NH_VA;
> +		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
> +	} else {
> +		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
> +		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
> +	}
> +	arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
>   
>   	/*
>   	 * Unfortunately, this can't be leaf-only since we may have
>   	 * zapped an entire table.
>   	 */
> -	arm_smmu_atc_inv_domain(smmu_domain, 0, start, size);
> +	arm_smmu_atc_inv_domain(smmu_domain, 0, iova, size);
>   }
>   
>   static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
> @@ -2024,7 +2031,7 @@ static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
>   static void arm_smmu_tlb_inv_walk(unsigned long iova, size_t size,
>   				  size_t granule, void *cookie)
>   {
> -	arm_smmu_tlb_inv_range(iova, size, granule, false, cookie);
> +	arm_smmu_tlb_inv_range_domain(iova, size, granule, false, cookie);
>   }
>   
>   static const struct iommu_flush_ops arm_smmu_flush_ops = {
> @@ -2622,8 +2629,9 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
>   {
>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>   
> -	arm_smmu_tlb_inv_range(gather->start, gather->end - gather->start,
> -			       gather->pgsize, true, smmu_domain);
> +	arm_smmu_tlb_inv_range_domain(gather->start,
> +				      gather->end - gather->start,
> +				      gather->pgsize, true, smmu_domain);
>   }
>   
>   static phys_addr_t
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
