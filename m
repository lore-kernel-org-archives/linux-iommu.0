From: Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v2 0/2] iommu/arm-smmu-v3: make sure the kdump kernel can
 work well when smmu is enabled
Date: Wed, 24 Apr 2019 18:22:30 +0200
Message-ID: <8302e13d-2a9d-ab28-8883-1748848c36d9@suse.com>
References: <20190318131243.20716-1-thunder.leizhen@huawei.com>
 <20190404153031.GE27558@fuggles.cambridge.arm.com>
 <5CAAB293.3080600@huawei.com>
 <20190416091410.GC31579@fuggles.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416091410.GC31579@fuggles.cambridge.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-kernel <linux-kernel@vger.kernel.org>, iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org



On 16/04/2019 11:14, Will Deacon wrote:
> On Mon, Apr 08, 2019 at 10:31:47AM +0800, Leizhen (ThunderTown) wrote:
>> On 2019/4/4 23:30, Will Deacon wrote:
>>> On Mon, Mar 18, 2019 at 09:12:41PM +0800, Zhen Lei wrote:
>>>> v1 --> v2:
>>>> 1. Drop part2. Now, we only use the SMMUv3 hardware feature STE.config=0b000
>>>> (Report abort to device, no event recorded) to suppress the event messages
>>>> caused by the unexpected devices.
>>>> 2. rewrite the patch description.
>>>
>>> This issue came up a while back:
>>>
>>> https://lore.kernel.org/linux-pci/20180302103032.GB19323@arm.com/
>>>
>>> and I'd still prefer to solve it using the disable_bypass logic which we
>>> already have. Something along the lines of the diff below?
>>
>> Yes, my patches also use disable_bypass=1(set ste.config=0b000). If
>> SMMU_IDR0.ST_LEVEL=0(Linear Stream table supported), then all STE entries
>> are allocated and initialized(set ste.config=0b000). But if SMMU_IDR0.ST_LEVEL=1
>> (2-level Stream Table), we only allocated and initialized the first level tables,
>> but leave level 2 tables dynamic allocated. That means, C_BAD_STREAMID(eventid=0x2)
>> will be reported, if an unexpeted device access memory without reinitialized in
>> kdump kernel.
> 
> So is your problem just that the C_BAD_STREAMID events are noisy? If so,
> perhaps we should be disabling fault reporting entirely in the kdump kernel.
> 
> How about the update diff below? I'm keen to have this as simple as
> possible, so we don't end up introducing rarely tested, complex code on
> the crash path.
> 
> Will
> 
> --->8
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index d3880010c6cf..d8b73da6447d 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2454,13 +2454,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  	/* Clear CR0 and sync (disables SMMU and queue processing) */
>  	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
>  	if (reg & CR0_SMMUEN) {
> -		if (is_kdump_kernel()) {
> -			arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> -			arm_smmu_device_disable(smmu);
> -			return -EBUSY;
> -		}
> -
>  		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
> +		WARN_ON(is_kdump_kernel() && !disable_bypass);
> +		arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
>  	}
>  
>  	ret = arm_smmu_device_disable(smmu);
> @@ -2553,6 +2549,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  		return ret;
>  	}
>  
> +	if (is_kdump_kernel())
> +		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
>  
>  	/* Enable the SMMU interface, or ensure bypass */
>  	if (!bypass || disable_bypass) {
> 

Same here I tested the patch and it works for me.

Feel free to add:
Tested-by: Matthias Brugger <mbrugger@suse.com>

Regards,
Matthias
