Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D1B1E0DFE
	for <iommu@lists.linux.dev>; Tue, 13 May 2025 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747127756; cv=none; b=X9PKv5wqx62pYDeL7nU76wTHHiIFkmMbPB1PjY2x7y7c0uuA/HuoRDjLszbkZwe8/HXLZzcCJIySbSW1AryIbK5DuDXaoyVtrQ0mCVz0h7+eY5RHp+2Yhw6MlzcqR7RhMEg7WpUW9/4Mo2cDsR157SbZswOrrJDjRWG7P9HiNoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747127756; c=relaxed/simple;
	bh=L36Sf6u/RDbBIgdHmhUm9WdOwooC5Gpp6K8/pGAS6us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CImahyDBXn4m3d9Y/Vpkh6eOCRKM1hcFiM7HT2hZ1jqJ8U8vqmARgyCBRzazGCEPFJBxa0fNQDGqHCr01j2owXzp3NQLlexFMILsq2ivn4RgW+veg1f/7DYEnx8Aw27p2TqpcN+4ycZatROgWAB7IAkglVormEpCykkChXzjhyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A734168F;
	Tue, 13 May 2025 02:15:43 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 925F23F673;
	Tue, 13 May 2025 02:15:50 -0700 (PDT)
Message-ID: <c5a74dfe-68e2-48f1-9bbb-06db8e62ffea@arm.com>
Date: Tue, 13 May 2025 10:15:49 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v6 1/3] arm64: Add BBM Level 2 cpu feature
To: Catalin Marinas <catalin.marinas@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>,
 =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
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
 <99079d56-428b-4bc4-b20a-dc10032f2a2f@arm.com> <aCIiwrA_MOeVhFre@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <aCIiwrA_MOeVhFre@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/05/2025 17:33, Catalin Marinas wrote:
> On Mon, May 12, 2025 at 02:35:01PM +0100, Ryan Roberts wrote:
>> On 12/05/2025 14:24, Suzuki K Poulose wrote:
>>> On 12/05/2025 14:07, Ryan Roberts wrote:
>>>> On 09/05/2025 17:04, Catalin Marinas wrote:
>>>>> On Fri, May 09, 2025 at 02:49:05PM +0100, Will Deacon wrote:
>>>>>> I wonder if we could treat it like an erratum in some way instead? That
>>>>>> is, invert things so that CPUs which _don't_ have BBML2_NOABORT are
>>>>>> considered to have a "BBM_CONFLICT_ABORT" erratum (which we obviously
>>>>>> wouldn't shout about). Then we should be able to say:
>>>>>>
>>>>>>     - If any of the early CPUs don't have BBML2_NOABORT, then the erratum
>>>>>>       would be enabled and we wouln't elide BBM.
>>>>>>
>>>>>>     - If a late CPU doesn't have BBML2_NOABORT then it can't come online
>>>>>>       if the erratum isn't already enabled.
>>>>>>
>>>>>> Does that work? If not, then perhaps the cpufeature/cpuerrata code needs
>>>>>> some surgery for this.
>>>>>
>>>>> Ah, I should have read this thread in order. I think we can treat this
>>>>> as BBML2_NOABORT available as default based on ID regs and use the
>>>>> allow/deny-list as an erratum.
>>>>
>>>> Just to make sure I've understood all this, I think what you are both saying is
>>>> we can create a single capability called ARM64_HAS_NO_BBML2_NOABORT of type
>>>> ARM64_CPUCAP_LOCAL_CPU_ERRATUM. Each CPU will then check it has BBML2 and is in
>>>> the MIDR allow list; If any of those conditions are not met, the CPU is
>>>> considered to have ARM64_HAS_NO_BBML2_NOABORT.
>>>
>>> I guess we need two caps.
>>>
>>> 1. SYSTEM cap -> ARM64_HAS_BBML2. Based on the ID registers
>>> 2. An erratum -> ARM64_BBML2_ABORTS. Based on BBLM2==1 && !in_midr_list()
>>
>> I don't think we *need* two caps; I was suggesting to consider both of these
>> conditions for the single cap. You are suggesting to separate them. But I think
>> both approaches give the same result?
>>
>> I'm easy either way, but keen to understand why 2 caps are preferred?
> 
> I guess it's easier to reason about than a single, negated property but
> the result should be identical. With two properties we can easily
> implement the idreg override like nobbml2 since this works on the
> sanitised ID regs. But we could also implement this differently, no need
> to rely on the ID regs.
> 
> Stepping back a bit, we know that the MIDR allow-list implies
> BBML2_NOABORT (and at least BBML2 as in the ID regs). In theory, we need

Please be aware that BBML2_NOABORT midr list may not always imply BBLM2 
in ID registers (e.g., AmpereOne. But the plan is to fixup the per cpu
ID register - struct cpuinfo_arm64 - for such cores at early boot,
individually, before it is used for sanitisation of the system wide
copy).


> something like a SYSTEM_FEATURE which is the conjunction of all the
> early CPUs. However, such system-level cap is only checked after all the
> early CPUs booted _and_ only on the sanitised ID regs rather than MIDR.
> 
> We need a LOCAL_CPU feature behaviour to be called on each CPU but still
> have the conjunction of early CPUs, more like the system one. It should
> be permitted for late CPUs to have but not optional if already enabled.
> 
> So how about we introduce a WEAK_BOOT_CPU_FEATURE which gets enabled by
> the boot CPU if it has it _but_ cleared by any secondary early CPU if it
> doesn't (and never enabled by secondary CPUs). When the features are
> finalised, we know if all early CPUs had it. In combination with
> PERMITTED_FOR_LATE_CPU, we'd reject late CPUs that don't have it.

That could work, but it introduces this "clearing" a capability, which
we don't do at the moment.

We had an offline discussion about this some time ago, with Mark
Rutland. The best way to deal with this is to change the way we compute
capabilities. i.e.,


1. Each boot CPU run through all the capabilities and maintain a per-cpu
    copy of the state.
2. System wide capabilities can then be constructed from the all early
    boot CPU capability state (e.g., ANDing all the state from all CPUs
    for SCOPE_SYSTEM or ORing for LOCAL_CPU).

But this requires a drastic change to the infrastructure.

> 
> I think if we can get the above, it would be the cleaner option than
> trying to bend our minds around double negations like !NO_BBLM2_NOABORT.

Agree, every time I come back to the thread, I have to write down the
check and stare at it for a minute to agree with what it does. That said
it may be ideal solution for the short term. Or stick to what we do in
the patch currently, until we implement per-cpu capability proposal.

Cheers
Suzuki

> 

