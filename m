From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 2/3] iommu/arm-smmu: Add qcom implementation
Date: Wed, 4 Jan 2017 09:31:22 -0500
Message-ID: <CAF6AEGuT_qq-UJK3sdvtVqxfsLBH-_jZVKz1vF383tOYVQpraw@mail.gmail.com>
References: <1483479056-15202-1-git-send-email-robdclark@gmail.com>
	<1483479056-15202-3-git-send-email-robdclark@gmail.com>
	<20170103222832.GA19199@jcrouse-lnx.qualcomm.com>
	<003201d2668f$1b8456e0$528d04a0$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <003201d2668f$1b8456e0$528d04a0$@codeaurora.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 4, 2017 at 8:33 AM, Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> Hi,
>
>>-----Original Message-----
>>From: linux-arm-msm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-arm-msm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Jordan Crouse
>>Sent: Wednesday, January 04, 2017 3:59 AM
>>To: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Sricharan R
>><sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>Subject: Re: [RFC 2/3] iommu/arm-smmu: Add qcom implementation
>>
>>On Tue, Jan 03, 2017 at 04:30:55PM -0500, Rob Clark wrote:
>>> At least on the db820c I have, with the firmware I have, I'm not seeing
>>> the SS bit set, even though the iommu is in a stalled state.  So for
>>> this implementation ignore not having SS bit set.
>>
>>The SS bit gets set if SCTLR.CFCFG is set to 1. It works in the downstream
>>kernel because the GPU driver writes directly to SCTLR in the IOMMU hardware
>>(which of course is a crime against humanity but that is one of the many reasons
>>why it is a *downstream* driver).
>>
>>My understanding is that SCTLR.CFCFG == 0 should automatically terminate the
>>transaction so I don't understand why we need to write to RESUME. I'm not
>>doubting Rob's patch, I'm doubting why we need it in the first place. It seems
>>that if we have to write it regardless of the value of CFCFG then we should
>>probably just do that instead of relying on the SS bit.
>>
>
> The patch is setting CFCFG to 1, hence we require clearing the fault with a
> write to the RESUME register. I tested these patches on arm-smmu with
> the DB820c and saw that the 'FSR_SS' bit is getting set properly after a
> fault on the adreno smmu.

I'll drop this patch and re-test.. hopefully later today.  It's
possible that I was having the problem w/ SS not set due to some other
issue.  (This was what I was seeing initially after just reverting the
patch that removed the stall/resume stuff.)  I probably need to double
checkk that CFCFG bit isn't getting cleared somewhere.

BR,
-R

>>The public spec doesn't give any indication to me that any of this behavior is
>>implementation specific but I only have one implementation to base that
>>assumption on. Perhaps the default value of SCTLR is implementation specific?
>>
>>If other implementations do expect SS (and CFCFG) to be set by default then we
>>would indeed need to set up a quirk. The other possibility would be to force
>>set CFCFG for all targets, but I would be hesitant to do that on the GPU iommu
>>because if we stall the GPU for too long then hang detect will fire.
>>
>
> As i understood from the previous discussions on this [1],  the
> behaviour of the stall model (whether enabling the stall would impact other
> contexts as well) and how the stalled context bank is going to assert the
> interrupts were implementation defined. I thought that the setting of the
> 'SS' bit should happen if stall model is supported.
>
> [1] https://www.spinics.net/lists/linux-arm-msm/msg25203.html
>
> Regards,
>  Sricharan
>
>
>>Jordan
>>
>>> Signed-off-by: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> ---
>>>  drivers/iommu/arm-smmu.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index a71cb8f..a8d9901 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -298,6 +298,7 @@ enum arm_smmu_implementation {
>>>      GENERIC_SMMU,
>>>      ARM_MMU500,
>>>      CAVIUM_SMMUV2,
>>> +    QCOM_SMMUV2,
>>>  };
>>>
>>>  struct arm_smmu_s2cr {
>>> @@ -716,6 +717,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>>>      /* Clear the faulting FSR */
>>>      writel(fsr, cb_base + ARM_SMMU_CB_FSR);
>>>
>>> +    if (smmu->model == QCOM_SMMUV2)
>>> +            fsr |= FSR_SS;
>>> +
>>>      /* Retry or terminate any stalled transactions */
>>>      if (fsr & FSR_SS) {
>>>              /* Should we care about ending up w/ a stalled transaction
>>> @@ -1991,6 +1995,7 @@ ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
>>>  ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
>>>  ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
>>>  ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
>>> +ARM_SMMU_MATCH_DATA(qcom_smmuv2, ARM_SMMU_V2, QCOM_SMMUV2);
>>>
>>>  static const struct of_device_id arm_smmu_of_match[] = {
>>>      { .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
>>> @@ -1999,6 +2004,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
>>>      { .compatible = "arm,mmu-401", .data = &arm_mmu401 },
>>>      { .compatible = "arm,mmu-500", .data = &arm_mmu500 },
>>>      { .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
>>> +    { .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
>>>      { },
>>>  };
>>>  MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>>> --
>>> 2.7.4
>>>
>>
>>--
>>The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>>a Linux Foundation Collaborative Project
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
>>the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
