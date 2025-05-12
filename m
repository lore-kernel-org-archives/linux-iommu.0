Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3B32951D3
	for <iommu@lists.linux.dev>; Mon, 12 May 2025 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056910; cv=none; b=JPz8X3AHmQX18zBwaxmwZWXVERfLhLrZlcsHbyJlvtxs3hy7sEIcNfUG8WALqAmghLSjv4u3UoHIg0Al8eRHOYDUvmR8SJwlZpFQxL7Q2aJlhw8cTADfaWpDaapIGZFqXOCyBAWh9ngJroRVmFWgRyrwvL6Hk9lz0zSXRly/pjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056910; c=relaxed/simple;
	bh=awHNVJyaHw8/80BC7Snxq4IjeNVF1gecvNMAl54NTRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omFE1InoU5iqGpKJzEy0qV4LHOGxumqhdrcaaVdfxX53P0/0nRdFOvpp4zj4rIRwXCHJDOMzjVH7Maw7SrYQ3OK6Q4mRzrtoaJxnzWSEJ/abTRsvI02aSiOnMjYj1t4vgR12FBohOru6i6PrNmRXsd6tgP4cjUQoU6eye7sUF3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 814DF150C;
	Mon, 12 May 2025 06:34:56 -0700 (PDT)
Received: from [10.57.90.222] (unknown [10.57.90.222])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E57BB3F5A1;
	Mon, 12 May 2025 06:35:02 -0700 (PDT)
Message-ID: <99079d56-428b-4bc4-b20a-dc10032f2a2f@arm.com>
Date: Mon, 12 May 2025 14:35:01 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v6 1/3] arm64: Add BBM Level 2 cpu feature
Content-Language: en-GB
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 yang@os.amperecomputing.com, corbet@lwn.net, jean-philippe@linaro.org,
 robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
 paulmck@kernel.org, mark.rutland@arm.com, joey.gouly@arm.com,
 maz@kernel.org, james.morse@arm.com, broonie@kernel.org,
 oliver.upton@linux.dev, baohua@kernel.org, david@redhat.com,
 ioworker0@gmail.com, jgg@ziepe.ca, nicolinc@nvidia.com, mshavit@google.com,
 jsnitsel@redhat.com, smostafa@google.com, kevin.tian@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20250428153514.55772-2-miko.lenczewski@arm.com>
 <20250428153514.55772-4-miko.lenczewski@arm.com>
 <20250506142508.GB1197@willie-the-truck>
 <78fec33d-fe66-4352-be11-900f456c9af3@arm.com>
 <20250509134904.GA5707@willie-the-truck> <aB4nqtMJuvvp7Vwm@arm.com>
 <015746d7-ca46-4978-a441-09fba781fdd4@arm.com>
 <4709ff5a-f89c-426e-ae95-f8356808f4f5@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <4709ff5a-f89c-426e-ae95-f8356808f4f5@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/05/2025 14:24, Suzuki K Poulose wrote:
> On 12/05/2025 14:07, Ryan Roberts wrote:
>> On 09/05/2025 17:04, Catalin Marinas wrote:
>>> On Fri, May 09, 2025 at 02:49:05PM +0100, Will Deacon wrote:
>>>> On Tue, May 06, 2025 at 03:52:59PM +0100, Ryan Roberts wrote:
>>>>> On 06/05/2025 15:25, Will Deacon wrote:
>>>>>> This penalises large homogeneous systems and it feels unnecessary given
>>>>>> that we have the ability to check this per-CPU. Can you use
>>>>>> ARM64_CPUCAP_BOOT_CPU_FEATURE instead of ARM64_CPUCAP_SYSTEM_FEATURE
>>>>>> to solve this?
>>>>>
>>>>> We are trying to solve for the case where the boot CPU has BBML2 but a
>>>>> secondary
>>>>> CPU doesn't. (e.g. hetrogeneous system where boot CPU is big and secondary is
>>>>> little and does not advertise the feature. I can't remember if we proved there
>>>>> are real systems with this config - I have vague recollection that we did
>>>>> but my
>>>>> memory is poor...).
>>>>>
>>>>> My understanding is that for ARM64_CPUCAP_BOOT_CPU_FEATURE, "If the boot CPU
>>>>> has enabled this feature already, then every late CPU must have it". So that
>>>>> would exclude any secondary CPUs without BBML2 from coming online?
>>>>
>>>> Damn, yes, you're right. However, it still feels horribly hacky to iterate
>>>> over the online CPUs in has_bbml2_noabort() -- the cpufeature framework
>>>> has the ability to query features locally and we should be able to use
>>>> that. We're going to want that should the architecture eventually decide
>>>> on something like BBML3 for this.
>>>>
>>>> What we have with BBML2_NOABORT seems similar to an hwcap in that we only
>>>> support the capability if all CPUs have it (rejecting late CPUs without it
>>>> in that case) but we can live without it if not all of the early CPUs
>>>> have it. Unlikely hwcaps, though, we shouldn't be advertising this to
>>>> userspace and we can't derive the capability solely from the sanitised
>>>> system registers.
>>>>
>>>> I wonder if we could treat it like an erratum in some way instead? That
>>>> is, invert things so that CPUs which _don't_ have BBML2_NOABORT are
>>>> considered to have a "BBM_CONFLICT_ABORT" erratum (which we obviously
>>>> wouldn't shout about). Then we should be able to say:
>>>>
>>>>    - If any of the early CPUs don't have BBML2_NOABORT, then the erratum
>>>>      would be enabled and we wouln't elide BBM.
>>>>
>>>>    - If a late CPU doesn't have BBML2_NOABORT then it can't come online
>>>>      if the erratum isn't already enabled.
>>>>
>>>> Does that work? If not, then perhaps the cpufeature/cpuerrata code needs
>>>> some surgery for this.
>>>
>>> Ah, I should have read this thread in order. I think we can treat this
>>> as BBML2_NOABORT available as default based on ID regs and use the
>>> allow/deny-list as an erratum.
>>>
>>
>> Just to make sure I've understood all this, I think what you are both saying is
>> we can create a single capability called ARM64_HAS_NO_BBML2_NOABORT of type
>> ARM64_CPUCAP_LOCAL_CPU_ERRATUM. Each CPU will then check it has BBML2 and is in
>> the MIDR allow list; If any of those conditions are not met, the CPU is
>> considered to have ARM64_HAS_NO_BBML2_NOABORT.
> 
> I guess we need two caps.
> 
> 1. SYSTEM cap -> ARM64_HAS_BBML2. Based on the ID registers
> 2. An erratum -> ARM64_BBML2_ABORTS. Based on BBLM2==1 && !in_midr_list()

I don't think we *need* two caps; I was suggesting to consider both of these
conditions for the single cap. You are suggesting to separate them. But I think
both approaches give the same result?

I'm easy either way, but keen to understand why 2 caps are preferred?

Perhaps for my version it would be better to refer to it as
ARM64_CPUCAP_BOOT_RESTRICTED_CPU_LOCAL_FEATURE instead of
ARM64_CPUCAP_LOCAL_CPU_ERRATUM (they both have the exact same semantics under
the hood AFAICT).

Thanks,
Ryan

> 
> 
> And then:
> 
> 
>>
>> Then we have this helper:
>>
>> static inline bool system_supports_bbml2_noabort(void)
>> {
>>     return system_capabilities_finalized() &&
>         alternative_has_cap_unlikely(ARM64_HAS_BBML2) &&
>         !alternative_has_cap_unlikely(!ARM64_HAS_BBML2_ABORTS)
> 
> Without (1), we may enable BBML2 on a (system with) CPU that doesn't
> have BBML2 feature.
> 
> And (1) can prevent any non-BBML2 capable CPUs from booting or (2) can prevent
> anything that aborts with BBML2.
> 
> 
> Suzuki
> 
> 
>>            !alternative_has_cap_unlikely(ARM64_HAS_NO_BBML2_NOABORT);
> 
> 
>> }
>>
>> system_capabilities_finalized() is there to ensure an early call to this helper
>> returns false (i.e. the safe value before we have evaluated on all CPUs).
>> Because ARM64_HAS_NO_BBML2_NOABORT is inverted it would otherwise return true
>> prior to finalization.
>>
>> I don't believe we need any second (SYSTEM or BOOT) feature. This is sufficient
>> on its own?
>>
>> Thanks,
>> Ryan
>>
> 

