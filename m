From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: Fix stream-match conflict with
	IOMMU_DOMAIN_DMA
Date: Tue, 5 Apr 2016 13:33:29 +0200
Message-ID: <5703A289.30308@linaro.org>
References: <1459527597-10740-1-git-send-email-will.deacon@arm.com>
	<570397F4.8080504@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <570397F4.8080504-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,
On 04/05/2016 12:48 PM, Robin Murphy wrote:
> On 01/04/16 17:19, Will Deacon wrote:
>> Commit cbf8277ef456 ("iommu/arm-smmu: Treat IOMMU_DOMAIN_DMA as bypass
>> for now") ignores requests to attach a device to the default domain
>> since, without IOMMU-basked DMA ops available everywhere, the default
>> domain will just lead to unexpected transaction faults being reported.
>>
>> Unfortunately, the way this was implemented on SMMUv2 causes a
>> regression with VFIO PCI device passthrough under KVM on AMD Seattle.
>> On this system, the host controller device is associated with both a
>> pci_dev *and* a platform_device, and can therefore end up with duplicate
>> SMR entries, resulting in a stream-match conflict at runtime.
>>
>> This patch amends the original fix so that attaching to IOMMU_DOMAIN_DMA
>> is rejected even before configuring the SMRs. This restores the old
>> behaviour for now, but we'll need to look at handing host controllers
>> specially when we come to supporting the default domain fully.
> 
> FWIW this is already solved with the generic bindings, as in most cases
> the host controller won't need an "iommus" property - for those that do
> actually have their own IDs for the platform device side, any aliasing
> with the PCI-derived IDs from "iommu-map" is magically taken care of in
> the group allocation code. That cross-bus-grouping should also apply to
> legacy masters too, since they look the same by the time we get to that
> point, so there should be no more stream match conflicts either way.
> I'll be working on a v2 of that series this week, so I'll rebase on top
> of this fix.

Thanks for the notice.

Besides the fault I was experiencing before that fix I also face a
regression with respect to SRIOV 2d VF assignment.  It appears it is due
to a shortage of context banks and not a shortage of SMRs as I thought
at the beginning. The -ENOSPC is returned by
arm_smmu_init_domain_context (__arm_smmu_alloc_bitmap).
arm_smmu_init_domain_context is called even if handle a default iommu
domain and if my understanding is correct we shouldn't consume any
context bank in that case.

Best Regards

Eric
> 
> Robin.
> 
>> Reported-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>> ---
>>   drivers/iommu/arm-smmu.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index e933679a3266..2f186d22477f 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1098,18 +1098,20 @@ static int arm_smmu_domain_add_master(struct
>> arm_smmu_domain *smmu_domain,
>>       struct arm_smmu_device *smmu = smmu_domain->smmu;
>>       void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
>>
>> -    /* Devices in an IOMMU group may already be configured */
>> -    ret = arm_smmu_master_configure_smrs(smmu, cfg);
>> -    if (ret)
>> -        return ret == -EEXIST ? 0 : ret;
>> -
>>       /*
>>        * FIXME: This won't be needed once we have IOMMU-backed DMA ops
>> -     * for all devices behind the SMMU.
>> +     * for all devices behind the SMMU. Note that we need to take
>> +     * care configuring SMRs for devices both a platform_device and
>> +     * and a PCI device (i.e. a PCI host controller)
>>        */
>>       if (smmu_domain->domain.type == IOMMU_DOMAIN_DMA)
>>           return 0;
>>
>> +    /* Devices in an IOMMU group may already be configured */
>> +    ret = arm_smmu_master_configure_smrs(smmu, cfg);
>> +    if (ret)
>> +        return ret == -EEXIST ? 0 : ret;
>> +
>>       for (i = 0; i < cfg->num_streamids; ++i) {
>>           u32 idx, s2cr;
>>
>>
> 
