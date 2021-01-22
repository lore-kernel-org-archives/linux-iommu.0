Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72756C433DB
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 13:00:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0052323437
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 13:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0052323437
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ABF67869ED;
	Fri, 22 Jan 2021 13:00:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XDWNhX91jumk; Fri, 22 Jan 2021 13:00:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A738F86A88;
	Fri, 22 Jan 2021 13:00:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90B56C088B;
	Fri, 22 Jan 2021 13:00:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3472C013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:00:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B0A0487350
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:00:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id agNgcMe+CpUL for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 13:00:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 752B2872A6
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:00:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1B3211B3;
 Fri, 22 Jan 2021 05:00:46 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 609D53F66E;
 Fri, 22 Jan 2021 05:00:45 -0800 (PST)
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: add support for BBML
To: Will Deacon <will@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>
References: <20201126034230.777-1-thunder.leizhen@huawei.com>
 <20210122125132.GB24102@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <34a9c164-389d-30cd-11a3-8796eb7bca93@arm.com>
Date: Fri, 22 Jan 2021 13:00:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122125132.GB24102@willie-the-truck>
Content-Language: en-GB
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yang Yingliang <yangyingliang@huawei.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On 2021-01-22 12:51, Will Deacon wrote:
> On Thu, Nov 26, 2020 at 11:42:30AM +0800, Zhen Lei wrote:
>> When changing from a set of pages/smaller blocks to a larger block for an
>> address, the software should follow the sequence of BBML processing.
>>
>> When changing from a block to a set of pages/smaller blocks for an
>> address, there's no need to use nT bit. If an address in the large block
>> is accessed before page table switching, the TLB caches the large block
>> mapping. After the page table is switched and before TLB invalidation
>> finished, new access requests are still based on large block mapping.
>> After the block or page is invalidated, the system reads the small block
>> or page mapping from the memory; If the address in the large block is not
>> accessed before page table switching, the TLB has no cache. After the
>> page table is switched, a new access is initiated to read the small block
>> or page mapping from the memory.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  2 +
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 +
>>   drivers/iommu/io-pgtable-arm.c              | 46 ++++++++++++++++-----
>>   include/linux/io-pgtable.h                  |  1 +
>>   4 files changed, 40 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index e634bbe60573..14a1a11565fb 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -1977,6 +1977,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
>>   		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
>>   		.tlb		= &arm_smmu_flush_ops,
>>   		.iommu_dev	= smmu->dev,
>> +		.bbml		= smmu->bbml,
>>   	};
>>   
>>   	if (smmu_domain->non_strict)
>> @@ -3291,6 +3292,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>>   
>>   	/* IDR3 */
>>   	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
>> +	smmu->bbml = FIELD_GET(IDR3_BBML, reg);
>>   	if (FIELD_GET(IDR3_RIL, reg))
>>   		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
>>   
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> index d4b7f40ccb02..aa7eb460fa09 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> @@ -51,6 +51,7 @@
>>   #define IDR1_SIDSIZE			GENMASK(5, 0)
>>   
>>   #define ARM_SMMU_IDR3			0xc
>> +#define IDR3_BBML			GENMASK(12, 11)
>>   #define IDR3_RIL			(1 << 10)
>>   
>>   #define ARM_SMMU_IDR5			0x14
>> @@ -617,6 +618,7 @@ struct arm_smmu_device {
>>   
>>   	int				gerr_irq;
>>   	int				combined_irq;
>> +	int				bbml;
>>   
>>   	unsigned long			ias; /* IPA */
>>   	unsigned long			oas; /* PA */
>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>> index a7a9bc08dcd1..341581337ad0 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -72,6 +72,7 @@
>>   
>>   #define ARM_LPAE_PTE_NSTABLE		(((arm_lpae_iopte)1) << 63)
>>   #define ARM_LPAE_PTE_XN			(((arm_lpae_iopte)3) << 53)
>> +#define ARM_LPAE_PTE_nT			(((arm_lpae_iopte)1) << 16)
>>   #define ARM_LPAE_PTE_AF			(((arm_lpae_iopte)1) << 10)
>>   #define ARM_LPAE_PTE_SH_NS		(((arm_lpae_iopte)0) << 8)
>>   #define ARM_LPAE_PTE_SH_OS		(((arm_lpae_iopte)2) << 8)
>> @@ -255,7 +256,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>   
>>   static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>>   				phys_addr_t paddr, arm_lpae_iopte prot,
>> -				int lvl, arm_lpae_iopte *ptep)
>> +				int lvl, arm_lpae_iopte *ptep, arm_lpae_iopte nT)
>>   {
>>   	arm_lpae_iopte pte = prot;
>>   
>> @@ -265,37 +266,60 @@ static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>>   		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
>>   
>>   	pte |= paddr_to_iopte(paddr, data);
>> +	pte |= nT;
>>   
>>   	__arm_lpae_set_pte(ptep, pte, &data->iop.cfg);
>>   }
>>   
>> +static void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
>> +				    arm_lpae_iopte *ptep);
>>   static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>>   			     unsigned long iova, phys_addr_t paddr,
>>   			     arm_lpae_iopte prot, int lvl,
>>   			     arm_lpae_iopte *ptep)
>>   {
>>   	arm_lpae_iopte pte = *ptep;
>> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>>   
>>   	if (iopte_leaf(pte, lvl, data->iop.fmt)) {
>>   		/* We require an unmap first */
>>   		WARN_ON(!selftest_running);
>>   		return -EEXIST;
>>   	} else if (iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_TABLE) {
>> -		/*
>> -		 * We need to unmap and free the old table before
>> -		 * overwriting it with a block entry.
>> -		 */
>>   		arm_lpae_iopte *tblp;
>> +		struct io_pgtable *iop = &data->iop;
>>   		size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
>>   
>> -		tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
>> -		if (__arm_lpae_unmap(data, NULL, iova, sz, lvl, tblp) != sz) {
>> -			WARN_ON(1);
>> -			return -EINVAL;
>> +		switch (cfg->bbml) {
>> +		case 0:
>> +			/*
>> +			 * We need to unmap and free the old table before
>> +			 * overwriting it with a block entry.
>> +			 */
>> +			tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
>> +			if (__arm_lpae_unmap(data, NULL, iova, sz, lvl, tblp) != sz) {
>> +				WARN_ON(1);
>> +				return -EINVAL;
>> +			}
>> +			break;
>> +		case 1:
>> +			__arm_lpae_init_pte(data, paddr, prot, lvl, ptep, ARM_LPAE_PTE_nT);
>> +
>> +			io_pgtable_tlb_flush_walk(iop, iova, sz, ARM_LPAE_GRANULE(data));
>> +			tblp = iopte_deref(pte, data);
>> +			__arm_lpae_free_pgtable(data, lvl + 1, tblp);
>> +			break;
>> +		case 2:
>> +			__arm_lpae_init_pte(data, paddr, prot, lvl, ptep, 0);
>> +
>> +			io_pgtable_tlb_flush_walk(iop, iova, sz, ARM_LPAE_GRANULE(data));
>> +			tblp = iopte_deref(pte, data);
>> +			__arm_lpae_free_pgtable(data, lvl + 1, tblp);
>> +			return 0;
> 
> Sorry, but I really don't understand what you're trying to do here. The old
> code uses BBM for the table -> block path so we don't need anything extra
> here. The dodgy case is when we unmap part of a block, and end up installing
> a table via arm_lpae_split_blk_unmap(). We can't use BBM there because there
> could be ongoing DMA to parts of the block mapping that we want to remain in
> place.
> 
> Are you seeing a problem in practice?

Right, I was under the assumption that we could ignore BBML because we 
should never have a legitimate reason to split blocks. I'm certainly not 
keen on piling any more complexity into split_blk_unmap, because the 
IOMMU API clearly doesn't have a well-defined behaviour for that case 
anyway - some other drivers will just unmap the entire block, and IIRC 
there was a hint somewhere in VFIO that it might actually expect that 
behaviour.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
