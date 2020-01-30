Return-Path: <SRS0=QAIZ=3T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACF5C2D0DB
	for <iommu@archiver.kernel.org>; Thu, 30 Jan 2020 17:34:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F05520674
	for <iommu@archiver.kernel.org>; Thu, 30 Jan 2020 17:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F05520674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D424F20370;
	Thu, 30 Jan 2020 17:34:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id za3OCM4Xn0zh; Thu, 30 Jan 2020 17:34:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 86C8620134;
	Thu, 30 Jan 2020 17:34:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BC90C0178;
	Thu, 30 Jan 2020 17:34:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DF09C0171
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 17:34:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 47E3C88326
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 17:34:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mm3D4y5nAedp for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jan 2020 17:34:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id F3CE98849C
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 17:34:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D496531B;
 Thu, 30 Jan 2020 09:34:11 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAAFB3F67D;
 Thu, 30 Jan 2020 09:34:10 -0800 (PST)
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Add SMMUv3.2 range invalidation
 support
To: Auger Eric <eric.auger@redhat.com>, Rob Herring <robh@kernel.org>,
 iommu@lists.linux-foundation.org
References: <20200117211628.27888-1-robh@kernel.org>
 <2d04f201-3457-08ad-db8e-735f8315d74e@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7ac3f864-6c39-76e9-ee4a-21be03abc044@arm.com>
Date: Thu, 30 Jan 2020 17:34:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2d04f201-3457-08ad-db8e-735f8315d74e@redhat.com>
Content-Language: en-GB
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On 30/01/2020 3:06 pm, Auger Eric wrote:
> Hi Rob,
> On 1/17/20 10:16 PM, Rob Herring wrote:
>> Arm SMMUv3.2 adds support for TLB range invalidate operations.
>> Support for range invalidate is determined by the RIL bit in the IDR3
>> register.
>>
>> The range invalidate is in units of the leaf page size and operates on
>> 1-32 chunks of a power of 2 multiple pages. First, we determine from the
>> size what power of 2 multiple we can use. Then we calculate how many
>> chunks (1-31) of the power of 2 size for the range on the iteration. On
>> each iteration, we move up in size by at least 5 bits.
>>
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>   drivers/iommu/arm-smmu-v3.c | 66 ++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 65 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index e91b4a098215..0ee561db7149 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -70,6 +70,9 @@
>>   #define IDR1_SSIDSIZE			GENMASK(10, 6)
>>   #define IDR1_SIDSIZE			GENMASK(5, 0)
>>   
>> +#define ARM_SMMU_IDR3			0xc
>> +#define IDR3_RIL			(1 << 10)
>> +
>>   #define ARM_SMMU_IDR5			0x14
>>   #define IDR5_STALL_MAX			GENMASK(31, 16)
>>   #define IDR5_GRAN64K			(1 << 6)
>> @@ -327,9 +330,14 @@
>>   #define CMDQ_CFGI_1_LEAF		(1UL << 0)
>>   #define CMDQ_CFGI_1_RANGE		GENMASK_ULL(4, 0)
>>   
>> +#define CMDQ_TLBI_0_NUM			GENMASK_ULL(16, 12)
>> +#define CMDQ_TLBI_RANGE_NUM_MAX		31
>> +#define CMDQ_TLBI_0_SCALE		GENMASK_ULL(24, 20)
>>   #define CMDQ_TLBI_0_VMID		GENMASK_ULL(47, 32)
>>   #define CMDQ_TLBI_0_ASID		GENMASK_ULL(63, 48)
>>   #define CMDQ_TLBI_1_LEAF		(1UL << 0)
>> +#define CMDQ_TLBI_1_TTL			GENMASK_ULL(9, 8)
>> +#define CMDQ_TLBI_1_TG			GENMASK_ULL(11, 10)
>>   #define CMDQ_TLBI_1_VA_MASK		GENMASK_ULL(63, 12)
>>   #define CMDQ_TLBI_1_IPA_MASK		GENMASK_ULL(51, 12)
>>   
>> @@ -455,9 +463,13 @@ struct arm_smmu_cmdq_ent {
>>   		#define CMDQ_OP_TLBI_S2_IPA	0x2a
>>   		#define CMDQ_OP_TLBI_NSNH_ALL	0x30
>>   		struct {
>> +			u8			num;
>> +			u8			scale;
>>   			u16			asid;
>>   			u16			vmid;
>>   			bool			leaf;
>> +			u8			ttl;
>> +			u8			tg;
>>   			u64			addr;
>>   		} tlbi;
>>   
>> @@ -595,6 +607,7 @@ struct arm_smmu_device {
>>   #define ARM_SMMU_FEAT_HYP		(1 << 12)
>>   #define ARM_SMMU_FEAT_STALL_FORCE	(1 << 13)
>>   #define ARM_SMMU_FEAT_VAX		(1 << 14)
>> +#define ARM_SMMU_FEAT_RANGE_INV		(1 << 15)
>>   	u32				features;
>>   
>>   #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
>> @@ -856,13 +869,21 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>>   		cmd[1] |= FIELD_PREP(CMDQ_CFGI_1_RANGE, 31);
>>   		break;
>>   	case CMDQ_OP_TLBI_NH_VA:
>> +		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_NUM, ent->tlbi.num);
>> +		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_SCALE, ent->tlbi.scale);
>>   		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID, ent->tlbi.asid);
>>   		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_LEAF, ent->tlbi.leaf);
>> +		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TTL, ent->tlbi.ttl);
>> +		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TG, ent->tlbi.tg);
>>   		cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_VA_MASK;
>>   		break;
>>   	case CMDQ_OP_TLBI_S2_IPA:
>> +		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_NUM, ent->tlbi.num);
>> +		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_SCALE, ent->tlbi.scale);
>>   		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
>>   		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_LEAF, ent->tlbi.leaf);
>> +		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TTL, ent->tlbi.ttl);
>> +		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TG, ent->tlbi.tg);
>>   		cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_IPA_MASK;
>>   		break;
>>   	case CMDQ_OP_TLBI_NH_ASID:
>> @@ -2003,7 +2024,7 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
>>   {
>>   	u64 cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
>>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
>> -	unsigned long start = iova, end = iova + size;
>> +	unsigned long start = iova, end = iova + size, num_pages = 0, tg = 0;
>>   	int i = 0;
>>   	struct arm_smmu_cmdq_ent cmd = {
>>   		.tlbi = {
>> @@ -2022,12 +2043,50 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
>>   		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
>>   	}
>>   
>> +	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
>> +		/* Get the leaf page size */
>> +		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
>> +
>> +		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
>> +		cmd.tlbi.tg = ((tg - ilog2(SZ_4K)) / 2) + 1;

Given the comment, I think "(tg - 10) / 2" would suffice ;)

>> +
>> +		/* Determine what level the granule is at */
>> +		cmd.tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));

Is it possible to rephrase that with logs and shifts to avoid the division?

>> +
>> +		num_pages = size / (1UL << tg);

Similarly, in my experience GCC has always seemed too cautious to elide 
non-constant division even in a seemingly-obvious case like this, so 
explicit "size >> tg" might be preferable.

>> +	}
>> +
>>   	while (iova < end) {
>>   		if (i == CMDQ_BATCH_ENTRIES) {
>>   			arm_smmu_cmdq_issue_cmdlist(smmu, cmds, i, false);
>>   			i = 0;
>>   		}
>>   
>> +		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
>> +			/*
>> +			 * On each iteration of the loop, the range is 5 bits
>> +			 * worth of the aligned size remaining.
>> +			 * The range in pages is:
>> +			 *
>> +			 * range = (num_pages & (0x1f << __ffs(num_pages)))
>> +			 */
>> +			unsigned long scale, num;
>> +
>> +			/* Determine the power of 2 multiple number of pages */
>> +			scale = __ffs(num_pages);
>> +			cmd.tlbi.scale = scale;
>> +
>> +			/* Determine how many chunks of 2^scale size we have */
>> +			num = (num_pages >> scale) & CMDQ_TLBI_RANGE_NUM_MAX;
>> +			cmd.tlbi.num = num - 1;
>> +
>> +			/* range is num * 2^scale * pgsize */
>> +			granule = num << (scale + tg);
>> +
>> +			/* Clear out the lower order bits for the next iteration */
>> +			num_pages -= num << scale;
> Regarding the 2 options given in
> https://lore.kernel.org/linux-arm-kernel/CAL_JsqKABoE+0crGwyZdNogNgEoG=MOOpf6deQgH6s73c0UNdA@mail.gmail.com/raw,
> 
> I understand you implemented 2) but I still do not understand why you
> preferred that one against 1).
> 
> In your case of 1023*4k pages this will invalidate by 31 32*2^0*4K +
> 31*2^0*4K pages
> whereas you could achieve that with 10 invalidations with the 1st algo.
> I did not get the case where it is more efficient. Please can you detail.

I guess essentially we want to solve for two variables to get a range as 
close to size as possible. There might be a more elegant numerical 
method, but for the numbers involved brute force is probably good enough 
for the real world. 5 minutes alone with the architecture spec and a 
blank editor begat this pseudo-implementation:

	size_t npages = size >> pgshift;
	while (npages) {
		unsigned long range;
		unsigned int delta, best = UINT_MAX;
		int num, scale = min(31, __ffs(npages));

		while (scale) {
			num = min(32, npages >> scale);
			if (num == 32)
				break;

			delta = npages & ((1 << scale) - 1);
			if (!delta || delta > best)
				break;

			best = delta;
			scale--;
		}

		//invalidate

		range = num << scale;
		npages -= range;
		iova += (range) << pgshift;
	}

Modulo any obvious thinkos, what do you reckon?

> Also a question about TG. Reading the spec again & again, it is said
> entries to be invalidated were inserted using this
> Granule size. Here you pick the lowest granule supported by the domain.
> Does it mean this was the one being used?

Yes - in arm_smmu_domain_finalise(), the domain's pgsize_bitmap is 
updated to reflect whichever granule alloc_io_pgtable_ops() actually picked.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
