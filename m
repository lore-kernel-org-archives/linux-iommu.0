Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A3C259C
	for <iommu@lists.linux.dev>; Fri,  9 May 2025 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746800170; cv=none; b=C5i8m+4n+eJIGgwcdHKqeEiaPG6txFjqkJyCLZ1GHkL2LEmiI19OYpp7UZz5EawnvLCCmS2mzXRgr3rz7fltxDSJO6+EMC79LDr3a1fZ6J4BGxV1mO4mNtPZwHTw0LPFbNl0QUhk8qdwN3os0U6PzBKylcL0EDuf6Ur9FiaHLA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746800170; c=relaxed/simple;
	bh=GQprZbLzU0giY9qSR2XLACQGiQ09lBFFKhtouEZC5O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jr6e9iHWD9eFLr8Pg2dd0EsfEoSUY/APQioJ49EYHm0JIl8Jip/oPi+kmJ7H5gPsJYX8B73kwOoAdPg3RW7Bg1G0xbxN7k92lLRBjzaiIIYBoxLQIeylPj6H8gheHjxpM4MMliAJe9EHvsCzUG4giZxA18Sd4F+Og46HjAP9QgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63C48175D;
	Fri,  9 May 2025 07:15:56 -0700 (PDT)
Received: from [10.57.90.222] (unknown [10.57.90.222])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEF983F5A1;
	Fri,  9 May 2025 07:16:02 -0700 (PDT)
Message-ID: <9bb94fe8-d605-49b4-91f0-0ad6d527b320@arm.com>
Date: Fri, 9 May 2025 15:16:01 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v6 1/3] arm64: Add BBM Level 2 cpu feature
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
Cc: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 suzuki.poulose@arm.com, yang@os.amperecomputing.com, corbet@lwn.net,
 catalin.marinas@arm.com, jean-philippe@linaro.org, robin.murphy@arm.com,
 joro@8bytes.org, akpm@linux-foundation.org, paulmck@kernel.org,
 mark.rutland@arm.com, joey.gouly@arm.com, maz@kernel.org,
 james.morse@arm.com, broonie@kernel.org, oliver.upton@linux.dev,
 baohua@kernel.org, david@redhat.com, ioworker0@gmail.com, jgg@ziepe.ca,
 nicolinc@nvidia.com, mshavit@google.com, jsnitsel@redhat.com,
 smostafa@google.com, kevin.tian@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20250428153514.55772-2-miko.lenczewski@arm.com>
 <20250428153514.55772-4-miko.lenczewski@arm.com>
 <20250506142508.GB1197@willie-the-truck>
 <78fec33d-fe66-4352-be11-900f456c9af3@arm.com>
 <20250509134904.GA5707@willie-the-truck>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250509134904.GA5707@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/05/2025 14:49, Will Deacon wrote:
> On Tue, May 06, 2025 at 03:52:59PM +0100, Ryan Roberts wrote:
>> On 06/05/2025 15:25, Will Deacon wrote:
>>> On Mon, Apr 28, 2025 at 03:35:14PM +0000, Mikołaj Lenczewski wrote:
>>>> The Break-Before-Make cpu feature supports multiple levels (levels 0-2),
>>>> and this commit adds a dedicated BBML2 cpufeature to test against
>>>> support for, as well as a kernel commandline parameter to optionally
>>>> disable BBML2 altogether.
>>>>
>>>> This is a system feature as we might have a big.LITTLE architecture
>>>> where some cores support BBML2 and some don't, but we want all cores to
>>>> be available and BBM to default to level 0 (as opposed to having cores
>>>> without BBML2 not coming online).
>>>>
>>>> To support BBML2 in as wide a range of contexts as we can, we want not
>>>> only the architectural guarantees that BBML2 makes, but additionally
>>>> want BBML2 to not create TLB conflict aborts. Not causing aborts avoids
>>>> us having to prove that no recursive faults can be induced in any path
>>>> that uses BBML2, allowing its use for arbitrary kernel mappings.
>>>> Support detection of such CPUs.
>>>>
>>>> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
>>>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>  .../admin-guide/kernel-parameters.txt         |  3 +
>>>>  arch/arm64/Kconfig                            | 19 +++++
>>>>  arch/arm64/include/asm/cpucaps.h              |  2 +
>>>>  arch/arm64/include/asm/cpufeature.h           |  5 ++
>>>>  arch/arm64/kernel/cpufeature.c                | 71 +++++++++++++++++++
>>>>  arch/arm64/kernel/pi/idreg-override.c         |  2 +
>>>>  arch/arm64/tools/cpucaps                      |  1 +
>>>>  7 files changed, 103 insertions(+)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>> index d9fd26b95b34..2749c67a4f07 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -449,6 +449,9 @@
>>>>  	arm64.no32bit_el0 [ARM64] Unconditionally disable the execution of
>>>>  			32 bit applications.
>>>>  
>>>> +	arm64.nobbml2	[ARM64] Unconditionally disable Break-Before-Make Level
>>>> +			2 support
>>>
>>> Hmm, I'm not sure we really want this. It opens up the door for folks to
>>> pass 'id_aa64mmfr2.bbm=2' without updating the allow-list which feels
>>> like it's going to make crashes harder to reason about.
>>>
>>> Is there a compelling reason to add this right now?
>>
>> I don't think there is a *compelling* reason. This came about from Suzuki's
>> feedback at [1]. He was keen to have a mechanism to disable BBML2 in case issues
>> were found.
>>
>> But simpler is usually better; I'd be ok with removing.
> 
> We can always add it back if we really need it, but adding an allowlist
> *and* a mechanism to override the allowlist at the same time seems overly
> pessimistic to me :)

ACK

> 
>>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>>> index 9c4d6d552b25..7a85a1bdc6e9 100644
>>>> --- a/arch/arm64/kernel/cpufeature.c
>>>> +++ b/arch/arm64/kernel/cpufeature.c
>>>> @@ -2200,6 +2200,70 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
>>>>  	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
>>>>  }
>>>>  
>>>> +static bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
>>>> +{
>>>> +	/*
>>>> +	 * We want to allow usage of bbml2 in as wide a range of kernel contexts
>>>> +	 * as possible. This list is therefore an allow-list of known-good
>>>> +	 * implementations that both support bbml2 and additionally, fulfill the
>>>> +	 * extra constraint of never generating TLB conflict aborts when using
>>>> +	 * the relaxed bbml2 semantics (such aborts make use of bbml2 in certain
>>>> +	 * kernel contexts difficult to prove safe against recursive aborts).
>>>> +	 *
>>>> +	 * Note that implementations can only be considered "known-good" if their
>>>> +	 * implementors attest to the fact that the implementation never raises
>>>> +	 * TLBI conflict aborts for bbml2 mapping granularity changes.
>>>> +	 */
>>>> +	static const struct midr_range supports_bbml2_noabort_list[] = {
>>>> +		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
>>>> +		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
>>>> +		{}
>>>> +	};
>>>> +
>>>> +	return is_midr_in_range_list(cpu_midr, supports_bbml2_noabort_list);
>>>
>>> This doesn't compile against latest mainline as is_midr_in_range_list()
>>> no longer takes the midr.
>>
>> Will ask Miko to fix.
> 
> Cheers. v6.15-rc1 is probably the right base to use as that's what I've
> based for-next/mm on.

ACK

> 
>>>> +static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int scope)
>>>> +{
>>>> +	if (!IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT))
>>>> +		return false;
>>>> +
>>>> +	if (scope & SCOPE_SYSTEM) {
>>>> +		int cpu;
>>>> +
>>>> +		/*
>>>> +		 * We are a boot CPU, and must verify that all enumerated boot
>>>> +		 * CPUs have MIDR values within our allowlist. Otherwise, we do
>>>> +		 * not allow the BBML2 feature to avoid potential faults when
>>>> +		 * the insufficient CPUs access memory regions using BBML2
>>>> +		 * semantics.
>>>> +		 */
>>>> +		for_each_online_cpu(cpu) {
>>>> +			if (!cpu_has_bbml2_noabort(cpu_read_midr(cpu)))
>>>> +				return false;
>>>> +		}
>>>
>>> This penalises large homogeneous systems and it feels unnecessary given
>>> that we have the ability to check this per-CPU. 

In case you didn't spot it, cpu_read_midr() is not actually reading a remote
cpu's midr. It's reading the cached midr in a per-cpu data structure. So I don't
think this will be very expensive in reality. And it's only run once during boot...

static inline unsigned int cpu_read_midr(int cpu)
{
	WARN_ON_ONCE(!cpu_online(cpu));

	return per_cpu(cpu_data, cpu).reg_midr;
}


> Can you use
>>> ARM64_CPUCAP_BOOT_CPU_FEATURE instead of ARM64_CPUCAP_SYSTEM_FEATURE
>>> to solve this?
>>
>> We are trying to solve for the case where the boot CPU has BBML2 but a secondary
>> CPU doesn't. (e.g. hetrogeneous system where boot CPU is big and secondary is
>> little and does not advertise the feature. I can't remember if we proved there
>> are real systems with this config - I have vague recollection that we did but my
>> memory is poor...).
>>
>> My understanding is that for ARM64_CPUCAP_BOOT_CPU_FEATURE, "If the boot CPU
>> has enabled this feature already, then every late CPU must have it". So that
>> would exclude any secondary CPUs without BBML2 from coming online?
> 
> Damn, yes, you're right. However, it still feels horribly hacky to iterate
> over the online CPUs in has_bbml2_noabort() -- the cpufeature framework
> has the ability to query features locally and we should be able to use
> that. We're going to want that should the architecture eventually decide
> on something like BBML3 for this.

For BBML3, we're looking for a minimum value in the BBM field of the FFMR, and
in that case the framework can handle it nicely with
ARM64_CPUCAP_SYSTEM_FEATURE. But the framework doesn't have any support for the
case where we need to look at all the midrs. So Suzuki came up with this method.

If/when we have BBML3 I was thinking we could retrospectively treat the CPUs in
the midr list as having an erratum that they don't advertise BBML3 when they
should (since the semantics are basically the same I expect/hope/have been
trying to ensure), so we can just implement workarounds to make it look like
they do have BBML3, then the framework does it's thing. Perhaps we can live with
this hack until we get to that point?

> 
> What we have with BBML2_NOABORT seems similar to an hwcap in that we only
> support the capability if all CPUs have it (rejecting late CPUs without it
> in that case) but we can live without it if not all of the early CPUs
> have it. Unlikely hwcaps, though, we shouldn't be advertising this to
> userspace and we can't derive the capability solely from the sanitised
> system registers.

Agreed.

> 
> I wonder if we could treat it like an erratum in some way instead? That
> is, invert things so that CPUs which _don't_ have BBML2_NOABORT are
> considered to have a "BBM_CONFLICT_ABORT" erratum (which we obviously
> wouldn't shout about). Then we should be able to say:
> 
>   - If any of the early CPUs don't have BBML2_NOABORT, then the erratum
>     would be enabled and we wouln't elide BBM.
> 
>   - If a late CPU doesn't have BBML2_NOABORT then it can't come online
>     if the erratum isn't already enabled.

That's exactly the policy that this cludge provides. But it's using the midr to
check if the CPU has BBML2_NOABORT. I'm not sure I follow your point about a
"BBM_CONFLICT_ABORT" erratum?

I'm also at a massive disadvantage because I find the whole cpufeatures
framework impenetrable :)

I'll ping Suzuki to see if he can chime in here.

Thanks,
Ryan

> 
> Does that work? If not, then perhaps the cpufeature/cpuerrata code needs
> some surgery for this.
> 
>> How do you see this working with ARM64_CPUCAP_BOOT_CPU_FEATURE? Or do you just
>> think that all systems will always be homogeneous with respect to FEAT_BBM?
> 
> That's probably wishful thinking, sadly :(
> 
> Will

