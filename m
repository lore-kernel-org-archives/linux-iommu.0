Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2FAC31E40
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 12:09:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57878206C2
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 12:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57878206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1658610A0;
	Thu, 15 Aug 2019 12:09:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EEC67FD8
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 12:09:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 6020A711
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 12:09:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E31DF28;
	Thu, 15 Aug 2019 05:09:09 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 878C03F694;
	Thu, 15 Aug 2019 05:09:08 -0700 (PDT)
Subject: Re: [PATCH 15/15] iommu/arm-smmu: Add context init implementation hook
To: Will Deacon <will@kernel.org>
References: <cover.1565369764.git.robin.murphy@arm.com>
	<6adbec8e4757f3b6c9f47135544a0302f8e7c55c.1565369764.git.robin.murphy@arm.com>
	<20190815105621.vt2gsuppjqgesrho@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7acdf5fb-3516-efbb-7c8c-7f84c02faad7@arm.com>
Date: Thu, 15 Aug 2019 13:09:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190815105621.vt2gsuppjqgesrho@willie-the-truck>
Content-Language: en-GB
Cc: bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org,
	gregory.clement@bootlin.com, linux-arm-kernel@lists.infradead.org
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

On 15/08/2019 11:56, Will Deacon wrote:
> On Fri, Aug 09, 2019 at 06:07:52PM +0100, Robin Murphy wrote:
>> Allocating and initialising a context for a domain is another point
>> where certain implementations are known to want special behaviour.
>> Currently the other half of the Cavium workaround comes into play here,
>> so let's finish the job to get the whole thing right out of the way.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/arm-smmu-impl.c | 39 +++++++++++++++++++++++++--
>>   drivers/iommu/arm-smmu.c      | 51 +++++++----------------------------
>>   drivers/iommu/arm-smmu.h      | 42 +++++++++++++++++++++++++++--
>>   3 files changed, 86 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
>> index c8904da08354..7a657d47b6ec 100644
>> --- a/drivers/iommu/arm-smmu-impl.c
>> +++ b/drivers/iommu/arm-smmu-impl.c
>> @@ -48,6 +48,12 @@ const struct arm_smmu_impl calxeda_impl = {
>>   };
>>   
>>   
>> +struct cavium_smmu {
>> +	struct arm_smmu_device smmu;
>> +	u32 id_base;
>> +};
>> +#define to_csmmu(s)	container_of(s, struct cavium_smmu, smmu)
> 
> To be honest with you, I'd just use container_of directly for the two
> callsites that need it. "to_csmmu" isn't a great name when we're also got
> the calxeda thing in here.

Sure, by this point I was mostly just going for completeness in terms of 
sketching out an example for subclassing arm_smmu_device. The Tegra 
patches will now serve as a more complete example anyway, so indeed we 
can live without it here.

>>   static int cavium_cfg_probe(struct arm_smmu_device *smmu)
>>   {
>>   	static atomic_t context_count = ATOMIC_INIT(0);
>> @@ -56,17 +62,46 @@ static int cavium_cfg_probe(struct arm_smmu_device *smmu)
>>   	 * Ensure ASID and VMID allocation is unique across all SMMUs in
>>   	 * the system.
>>   	 */
>> -	smmu->cavium_id_base = atomic_fetch_add(smmu->num_context_banks,
>> +	to_csmmu(smmu)->id_base = atomic_fetch_add(smmu->num_context_banks,
>>   						   &context_count);
>>   	dev_notice(smmu->dev, "\tenabling workaround for Cavium erratum 27704\n");
>>   
>>   	return 0;
>>   }
>>   
>> +int cavium_init_context(struct arm_smmu_domain *smmu_domain)
>> +{
>> +	u32 id_base = to_csmmu(smmu_domain->smmu)->id_base;
>> +
>> +	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2)
>> +		smmu_domain->cfg.vmid += id_base;
>> +	else
>> +		smmu_domain->cfg.asid += id_base;
>> +
>> +	return 0;
>> +}
>> +
>>   const struct arm_smmu_impl cavium_impl = {
>>   	.cfg_probe = cavium_cfg_probe,
>> +	.init_context = cavium_init_context,
>>   };
>>   
>> +struct arm_smmu_device *cavium_smmu_impl_init(struct arm_smmu_device *smmu)
>> +{
>> +	struct cavium_smmu *csmmu;
>> +
>> +	csmmu = devm_kzalloc(smmu->dev, sizeof(*csmmu), GFP_KERNEL);
>> +	if (!csmmu)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	csmmu->smmu = *smmu;
>> +	csmmu->smmu.impl = &cavium_impl;
>> +
>> +	devm_kfree(smmu->dev, smmu);
>> +
>> +	return &csmmu->smmu;
>> +}
>> +
>>   
>>   #define ARM_MMU500_ACTLR_CPRE		(1 << 1)
>>   
>> @@ -121,7 +156,7 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>>   		smmu->impl = &calxeda_impl;
>>   
>>   	if (smmu->model == CAVIUM_SMMUV2)
>> -		smmu->impl = &cavium_impl;
>> +		return cavium_smmu_impl_init(smmu);
>>   
>>   	if (smmu->model == ARM_MMU500)
>>   		smmu->impl = &arm_mmu500_impl;
> 
> Maybe rework this so we do the calxeda detection first (and return if we
> match), followed by a switch on smmu->model to make it crystal clear that
> we match only one?

As I see it, "match only one" is really only a short-term thing, though, 
so I didn't want to get *too* hung up on it. Ultimately we're going to 
have cases where we need to combine e.g. MMU-500 implementation quirks 
with platform integration quirks - I've been mostly planning on coming 
back to think about that (and potentially rework this whole logic) 
later, but I guess it wouldn't hurt to plan out a bit more structure 
from the start.

I'll have a hack on that (and all the other comments) today and 
hopefully have a v2 by tomorrow.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
