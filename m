From: Bogdan Purcareata <bogdan.purcareata-3arQi8VN3Tc@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: Properly initialize CBAR MemAttr
Date: Tue, 31 May 2016 13:09:23 +0000
Message-ID: <574D8D01.7090500@nxp.com>
References: <1464617742-5493-1-git-send-email-bogdan.purcareata@nxp.com>
	<574D5EBF.8010707@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <574D5EBF.8010707-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
Content-ID: <7F9A417FFC7A4147BEFA2F43C0466B1F-jdb/QiT5osKcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 31.05.2016 12:51, Robin Murphy wrote:
> On 30/05/16 15:15, Bogdan Purcareata wrote:
>> Currently, when initializing the CBAR memattr attributes to the weakest
>> values, it is expected that the final ones will be declared in the TTBCR
>> register (SMMU_CBn_TCR).
>
> You mean the stage 1 PTE, right? TTBCR only controls the attributes for
> table walks.

I got lost in the SMMU spec. I couldn't find the direct correlation between CBAR 
and TTBCR. Thanks for the clarification.

>> This is not required when CBAR type consists of a stage 1 translation
>> followed by a stage 2 bypass.
>
> On the contrary, this is _only_ required for stage 1 translation with
> stage 2 bypass - CBAR.MemAttr gives the _stage 2_ memory type (see
> section 2.4 "Memory type and shareability attribute determination" in
> the SMMU spec). For nested translation the stage 2 attributes come from
> the stage 2 context itself.

Yes. In the previous "this", I was referring to the TTBCR configurations, not 
CBAR itself.

>>                                This is the case when assigning a VFIO PCI
>> device to a KVM guest. Overriding the default transaction attributes to
>> writeback cacheable results in the device no longer working in the guest
>> (the adapter requires explicit flushes on the descriptor rings memory).
>
>   From that, the real problem is almost certainly that you're erroneously
> describing the device as coherent or non-coherent (whichever it actually
> isn't) somewhere.

And that was the issue, indeed. The PCIe controller was not described as 
dma-coherent in the device tree, when in fact it was, thus wreaking all this havoc.

Thank you for the valuable insight and please discard the patch.

Bogdan P.

>> Update the context init routine to initialize the CBAR MemAttr field only
>> if there's a stage 1 followed by a stage 2 translation.
>
> The CBAR.MemAttr field doesn't even exist in that format - it's a good
> thing that we don't actually implement nested translation (we currently
> just use a stage 2 context instead), because this would end up
> corrupting CBAR.CBNDX (i.e. the stage 2 context bank index). Now that I
> should probably fix...
>
>> Signed-off-by: Bogdan Purcareata <bogdan.purcareata-3arQi8VN3Tc@public.gmane.org>
>> ---
>>    drivers/iommu/arm-smmu.c | 13 +++++++++----
>>    1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index ff7a392..1400ec9 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -765,13 +765,14 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>>    {
>>    	u32 reg;
>>    	u64 reg64;
>> -	bool stage1;
>> +	bool stage1, stage1_stage2;
>>    	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>>    	struct arm_smmu_device *smmu = smmu_domain->smmu;
>>    	void __iomem *cb_base, *gr1_base;
>>
>>    	gr1_base = ARM_SMMU_GR1(smmu);
>>    	stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
>> +	stage1_stage2 = cfg->cbar == CBAR_TYPE_S1_TRANS_S2_TRANS;
>>    	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
>>
>>    	if (smmu->version > ARM_SMMU_V1) {
>> @@ -793,15 +794,19 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>>
>>    	/*
>>    	 * Use the weakest shareability/memory types, so they are
>> -	 * overridden by the ttbcr/pte.
>> +	 * overridden by the ttbcr/pte. This happens only if the stage
>> +	 * 1 is followed by a stage 2 translation.
>>    	 */
>> -	if (stage1) {
>> +	if (stage1_stage2) {
>>    		reg |= (CBAR_S1_BPSHCFG_NSH << CBAR_S1_BPSHCFG_SHIFT) |
>>    			(CBAR_S1_MEMATTR_WB << CBAR_S1_MEMATTR_SHIFT);
>> -	} else if (!(smmu->features & ARM_SMMU_FEAT_VMID16)) {
>
> Since MemAttr is initially zero, the net result of this is that *all*
> stage 1 transactions will now get overridden to Strongly-Ordered. That
> may hide your problem, but it's definitely not the correct thing to do.
>
> Robin.
>
>> +	}
>> +
>> +	if (!stage1 && !(smmu->features & ARM_SMMU_FEAT_VMID16)) {
>>    		/* 8-bit VMIDs live in CBAR */
>>    		reg |= ARM_SMMU_CB_VMID(smmu, cfg) << CBAR_VMID_SHIFT;
>>    	}
>> +
>>    	writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(cfg->cbndx));
>>
>>    	/* TTBRs */
>>
>
