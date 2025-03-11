Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D76256C84
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695381; cv=none; b=I2V0SxyWcrBer0eOoWEr+oBtR4UGS2qvC/4OwuKsMnZTyge+gd6w36qF8M+iKmFMA6Zx7hV94itbEUwP+ibB/uRnHDiYtfo7YOAAHN449znRG2j1vn3boKyogqcCcODHHDk6qkdpEfi0XWcOZnTUzbgXyEhsWsAG/Q9uT2vXWBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695381; c=relaxed/simple;
	bh=Ar2cJr3FYM+YA0cBeFq7bf+EFgQEVYzNAHoHBA6A8HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iQlZydB4XUkgfiE++7pXBzasg47HU5bbcp1khrdGSa2G5mBAPx/lut8vIZqZyidyb2A2gIW+D1jYX6jhETdd7QMVDIxX1+7NmphYE1nt8QMZy9tQiXfCAnxSetEy5B4RQemmSQrq5SFP6ilJB0uPJXR6H/oo3TEn+5ua8dxzIOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06A4F152B;
	Tue, 11 Mar 2025 05:16:30 -0700 (PDT)
Received: from [10.57.40.127] (unknown [10.57.40.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0D6B13F7BD;
	Tue, 11 Mar 2025 05:16:14 -0700 (PDT)
Message-ID: <0ac0f1f5-e4a0-46ae-8ea0-2eba7e21a7e1@arm.com>
Date: Tue, 11 Mar 2025 12:16:14 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu/arm: Add BBM Level 2 smmu feature
Content-Language: en-GB
To: Ryan Roberts <ryan.roberts@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 catalin.marinas@arm.com, will@kernel.org, joro@8bytes.org,
 jean-philippe@linaro.org, mark.rutland@arm.com, joey.gouly@arm.com,
 oliver.upton@linux.dev, james.morse@arm.com, broonie@kernel.org,
 maz@kernel.org, david@redhat.com, akpm@linux-foundation.org, jgg@ziepe.ca,
 nicolinc@nvidia.com, mshavit@google.com, jsnitsel@redhat.com,
 smostafa@google.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-6-miko.lenczewski@arm.com>
 <b46dc626-edc9-4d20-99d2-6cd08a01346c@os.amperecomputing.com>
 <43732270-8fd0-4a18-abec-096e383a6a4d@arm.com>
 <5ff34bd0-7823-4f31-9f13-bf60d3345b99@arm.com>
 <7cca1edf-fd1b-4622-999e-8e0ca098dfe2@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <7cca1edf-fd1b-4622-999e-8e0ca098dfe2@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/03/2025 10:58, Ryan Roberts wrote:
> On 11/03/2025 10:17, Suzuki K Poulose wrote:
>> On 03/03/2025 10:17, Ryan Roberts wrote:
>>> On 01/03/2025 01:32, Yang Shi wrote:
>>>>
>>>>
>>>>
>>>> On 2/28/25 10:24 AM, Mikołaj Lenczewski wrote:
>>>>> For supporting BBM Level 2 for userspace mappings, we want to ensure
>>>>> that the smmu also supports its own version of BBM Level 2. Luckily, the
>>>>> smmu spec (IHI 0070G 3.21.1.3) is stricter than the aarch64 spec (DDI
>>>>> 0487K.a D8.16.2), so already guarantees that no aborts are raised when
>>>>> BBM level 2 is claimed.
>>>>>
>>>>> Add the feature and testing for it under arm_smmu_sva_supported().
>>>>>
>>>>> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
>>>>> ---
>>>>>     arch/arm64/kernel/cpufeature.c                  | 7 +++----
>>>>>     drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 3 +++
>>>>>     drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 +++
>>>>>     drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 4 ++++
>>>>>     4 files changed, 13 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>>>> index 63f6d356dc77..1022c63f81b2 100644
>>>>> --- a/arch/arm64/kernel/cpufeature.c
>>>>> +++ b/arch/arm64/kernel/cpufeature.c
>>>>> @@ -2223,8 +2223,6 @@ static bool has_bbml2_noabort(const struct
>>>>> arm64_cpu_capabilities *caps, int sco
>>>>>                 if (!cpu_has_bbml2_noabort(__cpu_read_midr(cpu)))
>>>>>                     return false;
>>>>>             }
>>>>> -
>>>>> -        return true;
>>>>>         } else if (scope & SCOPE_LOCAL_CPU) {
>>>>>             /* We are a hot-plugged CPU, so only need to check our MIDR.
>>>>>              * If we have the correct MIDR, but the kernel booted on an
>>>>> @@ -2232,10 +2230,11 @@ static bool has_bbml2_noabort(const struct
>>>>> arm64_cpu_capabilities *caps, int sco
>>>>>              * we have an incorrect MIDR, but the kernel booted on a
>>>>>              * sufficient CPU, we will not bring up this CPU.
>>>>>              */
>>>>> -        return cpu_has_bbml2_noabort(read_cpuid_id());
>>>>> +        if (!cpu_has_bbml2_noabort(read_cpuid_id()))
>>>>> +            return false;
>>>>>         }
>>>>>     -    return false;
>>>>> +    return has_cpuid_feature(caps, scope);
>>>>
>>>> Do we really need this? IIRC, it means the MIDR has to be in the allow list
>>>> *AND* MMFR2 register has to be set too. AmpereOne doesn't have MMFR2 register
>>>> set.
>>>
>>> Miko, I think this should have been squashed into patch #1? It doesn't belong in
>>> this patch.
>>>
>>> Yang, we discussed this internally and decided that we thought it was best to
>>> still require BBML2 being advertised in the feature register. That way if trying
>>> to use KVM to emulate a CPU that is in the allow list but doesn't really support
>>> BBML2, we won't try to use it.
>>>
>>> But we still end up with the same problem if running on a physical CPU that
>>> supports BBML2 with conflict aborts, but emulating a CPU in the allow list. So
>>
>> I don't understand the problem here ? In the worst case, if we want to disable
>> the BBML2 feature on a given CPU, we could provide an id-
>> override to reset the value of BBML2. Or provide a kernel parameter to
>> disable this in case we want to absolutely disable the feature on a
>> "distro" kernel.
> 
> Hi Suzuki,
> 
> Sorry perhaps I'm confusing everyone; As I recall, we had a conversation before
> Miko posted this series where you were suggesting we should check BOTH that all
> the CPUs' MIDRs are in the allow list AND that BBML2 is advertised in MMFR2 in
> order to decide to enable the CPU feature. My understanding was that without the
> MMFR2 check, you were concerned that in a virtualization scenario, a CPU's MIDR
> could be overridden to emulate a CPU that is in the allow list, but in reality
> the CPU does not support BBML2. We would then enable BBML2 and BadThings (TM)
> will happen. So additionally checking the MMFR2 would solve this.
> 
> But Yang is saying that he plans to add the AmpereOne to the allow list because
> it does support BBML2+NOCONFLICT semantics and we want to benefit from that. But
> AmpereOne does not advertise BBML2 in it's MMFR2. So with the current approach,
> adding AmpereOne to the allow list is not sufficient to enable the feature.
> 
> But back to your original justification for checking the MMFR2; I don't think
> that really solves the problem in general, because we don't just require BBML2,
> we require BBML2+NOCONFLICT. And we can only determine that from the MIDR. So
> why bother checking MMFR2?

My concerns are not around enabling a CPU, but having a damage control 
with a "kernel" that a user has no control over (Read, standard 
distribution kernel).

1. If the combination of the above causes problem (in Virtualization)
2. If the combination of the above is detected to have problems in 
baremetal.

In (1), VMM could control the ID register and disable the feature.

For (2) we could provide an id-override on command line to disable it in
the worst case.

So, having the id register case is a good way to get the system running
with a given kernel (in either world). Without that, we don't have a 
tunable to control the behavior at runtime.

May be I am being over paranoid about this.

> 
> I guess we could provide an id-override on the kernel command line to *enable*
> BBML2 for AmpereOne, but that's not going to be suitable for mass deployment, I

Unfortunately, we can't override to provide the "feature" that is 
missing (at least today).

One option is, run with a whitelist, but provide a kernel parameter to 
disable bbml2 feature.

Something like, arm64.bbml2=0

So the decision is based on the parameter && MIDR list.


Cheers
Suzuki

> don't think?
> 
> Thanks,
> Ryan
> 
>>
>> Suzuki
>>
>>
>>> given AmpereOne doesn't advertise BBML2 but does support it, I'd be happy to
>>> remove this check.
>>>
>>> Thanks,
>>> Ryan
>>>
>>>
>>>>
>>>> Thanks,
>>>> Yang
>>>>
>>>>>     }
>>>>>       #ifdef CONFIG_ARM64_PAN
>>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/
>>>>> arm/arm-smmu-v3/arm-smmu-v3-sva.c
>>>>> index 9ba596430e7c..6ba182572788 100644
>>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>>>>> @@ -222,6 +222,9 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>>>>>             feat_mask |= ARM_SMMU_FEAT_VAX;
>>>>>         }
>>>>>     +    if (system_supports_bbml2_noabort())
>>>>> +        feat_mask |= ARM_SMMU_FEAT_BBML2;
>>>>> +
>>>>>         if ((smmu->features & feat_mask) != feat_mask)
>>>>>             return false;
>>>>>     diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/
>>>>> arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> index 358072b4e293..dcee0bdec924 100644
>>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> @@ -4406,6 +4406,9 @@ static int arm_smmu_device_hw_probe(struct
>>>>> arm_smmu_device *smmu)
>>>>>         if (FIELD_GET(IDR3_RIL, reg))
>>>>>             smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
>>>>>     +    if (FIELD_GET(IDR3_BBML, reg) == IDR3_BBML2)
>>>>> +        smmu->features |= ARM_SMMU_FEAT_BBML2;
>>>>> +
>>>>>         /* IDR5 */
>>>>>         reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);
>>>>>     diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/
>>>>> arm/arm-smmu-v3/arm-smmu-v3.h
>>>>> index bd9d7c85576a..85eaf3ab88c2 100644
>>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>>>>> @@ -60,6 +60,9 @@ struct arm_smmu_device;
>>>>>     #define ARM_SMMU_IDR3            0xc
>>>>>     #define IDR3_FWB            (1 << 8)
>>>>>     #define IDR3_RIL            (1 << 10)
>>>>> +#define IDR3_BBML            GENMASK(12, 11)
>>>>> +#define IDR3_BBML1            (1 << 11)
>>>>> +#define IDR3_BBML2            (2 << 11)
>>>>>       #define ARM_SMMU_IDR5            0x14
>>>>>     #define IDR5_STALL_MAX            GENMASK(31, 16)
>>>>> @@ -754,6 +757,7 @@ struct arm_smmu_device {
>>>>>     #define ARM_SMMU_FEAT_HA        (1 << 21)
>>>>>     #define ARM_SMMU_FEAT_HD        (1 << 22)
>>>>>     #define ARM_SMMU_FEAT_S2FWB        (1 << 23)
>>>>> +#define ARM_SMMU_FEAT_BBML2        (1 << 24)
>>>>>         u32                features;
>>>>>       #define ARM_SMMU_OPT_SKIP_PREFETCH    (1 << 0)
>>>>
>>>
>>
> 

