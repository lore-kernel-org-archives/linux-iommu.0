Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87431D6DBF
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479307; cv=none; b=F7UZI8tNSQfZrvxuGqrxgriWMMO5fWkGNZ2cKJ3Paw700rN+2x35GW/Z0j84TbvTW/BUL/8uxaNafUeYEInXgzq1P7aDpDL+X/0pK94kuqtuxvAfTAdQZbbz7a3jUDDO6cZPpKJzm6FeYIARAXVMCAW3xrZwyo1VnI4oKzmQgvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479307; c=relaxed/simple;
	bh=EbDfeZBW+Qqxz9QJQfg9SBKQSFAEasL45ys9LJXsEhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gf7L4q91Wf2nRT4GrPuF/FbdeCFLmmO/dSMimrZ1zo6H9USMZ6z9qVsC12SHg9+h04fMpHY64lqCwfGLlJPEmCPTmIFiaZgYrRYahzafrPnkwc5asOQcFpc7qa17TvnN/8Ffzew+0ys3b1BSHo2QXrLNVPzjp60+fn/lIlolXNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFF5A113E;
	Thu, 20 Mar 2025 07:01:51 -0700 (PDT)
Received: from [10.57.84.158] (unknown [10.57.84.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7EAC3F63F;
	Thu, 20 Mar 2025 07:01:39 -0700 (PDT)
Message-ID: <2cbca34c-477c-4055-b388-a13bb6c22b4d@arm.com>
Date: Thu, 20 Mar 2025 14:01:38 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] arm64: Add BBM Level 2 cpu feature
Content-Language: en-GB
To: Ard Biesheuvel <ardb@kernel.org>,
 =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: suzuki.poulose@arm.com, yang@os.amperecomputing.com, corbet@lwn.net,
 catalin.marinas@arm.com, will@kernel.org, jean-philippe@linaro.org,
 robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
 mark.rutland@arm.com, joey.gouly@arm.com, maz@kernel.org,
 james.morse@arm.com, broonie@kernel.org, oliver.upton@linux.dev,
 baohua@kernel.org, david@redhat.com, ioworker0@gmail.com, jgg@ziepe.ca,
 nicolinc@nvidia.com, mshavit@google.com, jsnitsel@redhat.com,
 smostafa@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20250319150533.37440-2-miko.lenczewski@arm.com>
 <20250319150533.37440-3-miko.lenczewski@arm.com>
 <CAMj1kXFOofRCiVHxxxBZMGQHRH-ghtqNxgd=uww9D4sr4vvjEQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAMj1kXFOofRCiVHxxxBZMGQHRH-ghtqNxgd=uww9D4sr4vvjEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/03/2025 13:37, Ard Biesheuvel wrote:
> On Wed, 19 Mar 2025 at 16:06, Mikołaj Lenczewski
> <miko.lenczewski@arm.com> wrote:
>>
>> The Break-Before-Make cpu feature supports multiple levels (levels 0-2),
>> and this commit adds a dedicated BBML2 cpufeature to test against
>> support for, as well as a kernel commandline parameter to optionally
>> disable BBML2 altogether.
>>
>> This is a system feature as we might have a big.LITTLE architecture
>> where some cores support BBML2 and some don't, but we want all cores to
>> be available and BBM to default to level 0 (as opposed to having cores
>> without BBML2 not coming online).
>>
>> To support BBML2 in as wide a range of contexts as we can, we want not
>> only the architectural guarantees that BBML2 makes, but additionally
>> want BBML2 to not create TLB conflict aborts. Not causing aborts avoids
>> us having to prove that no recursive faults can be induced in any path
>> that uses BBML2, allowing its use for arbitrary kernel mappings.
>> Support detection of such CPUs.
>>
>> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
>> ---
>>  .../admin-guide/kernel-parameters.txt         |  3 +
>>  arch/arm64/Kconfig                            | 11 +++
>>  arch/arm64/include/asm/cpucaps.h              |  2 +
>>  arch/arm64/include/asm/cpufeature.h           |  5 ++
>>  arch/arm64/kernel/cpufeature.c                | 68 +++++++++++++++++++
>>  arch/arm64/kernel/pi/idreg-override.c         |  2 +
>>  arch/arm64/tools/cpucaps                      |  1 +
>>  7 files changed, 92 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index fb8752b42ec8..3e4cc917a07e 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -453,6 +453,9 @@
>>         arm64.no32bit_el0 [ARM64] Unconditionally disable the execution of
>>                         32 bit applications.
>>
>> +       arm64.nobbml2   [ARM64] Unconditionally disable Break-Before-Make Level
>> +                       2 support
>> +
>>         arm64.nobti     [ARM64] Unconditionally disable Branch Target
>>                         Identification support
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 940343beb3d4..49deda2b22ae 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -2057,6 +2057,17 @@ config ARM64_TLB_RANGE
>>           The feature introduces new assembly instructions, and they were
>>           support when binutils >= 2.30.
>>
>> +config ARM64_BBML2_NOABORT
>> +       bool "Enable support for Break-Before-Make Level 2 detection and usage"
>> +       default y
>> +       help
>> +         FEAT_BBM provides detection of support levels for break-before-make
>> +         sequences. If BBM level 2 is supported, some TLB maintenance requirements
>> +         can be relaxed to improve performance. We additonally require the
>> +         property that the implementation cannot ever raise TLB Conflict Aborts.
>> +         Selecting N causes the kernel to fallback to BBM level 0 behaviour
>> +         even if the system supports BBM level 2.
>> +
>>  endmenu # "ARMv8.4 architectural features"
>>
>>  menu "ARMv8.5 architectural features"
>> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
>> index 0b5ca6e0eb09..2d6db33d4e45 100644
>> --- a/arch/arm64/include/asm/cpucaps.h
>> +++ b/arch/arm64/include/asm/cpucaps.h
>> @@ -23,6 +23,8 @@ cpucap_is_possible(const unsigned int cap)
>>                 return IS_ENABLED(CONFIG_ARM64_PAN);
>>         case ARM64_HAS_EPAN:
>>                 return IS_ENABLED(CONFIG_ARM64_EPAN);
>> +       case ARM64_HAS_BBML2_NOABORT:
>> +               return IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT);
>>         case ARM64_SVE:
>>                 return IS_ENABLED(CONFIG_ARM64_SVE);
>>         case ARM64_SME:
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index e0e4478f5fb5..108ef3fbbc00 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -866,6 +866,11 @@ static __always_inline bool system_supports_mpam_hcr(void)
>>         return alternative_has_cap_unlikely(ARM64_MPAM_HCR);
>>  }
>>
>> +static inline bool system_supports_bbml2_noabort(void)
>> +{
>> +       return alternative_has_cap_unlikely(ARM64_HAS_BBML2_NOABORT);
>> +}
>> +
>>  int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
>>  bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
>>
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index d561cf3b8ac7..1a4adcda267b 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -2176,6 +2176,67 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
>>         return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
>>  }
>>
>> +static bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
>> +{
> 
> We generally start these block comments with just /* on the first line
> 
>> +       /* We want to allow usage of bbml2 in as wide a range of kernel contexts
>> +        * as possible. This list is therefore an allow-list of known-good
>> +        * implementations that both support bbml2 and additionally, fulfill the
>> +        * extra constraint of never generating TLB conflict aborts when using
>> +        * the relaxed bbml2 semantics (such aborts make use of bbml2 in certain
>> +        * kernel contexts difficult to prove safe against recursive aborts).
>> +        *
>> +        * Note that implementations can only be considered "known-good" if their
>> +        * implementors attest to the fact that the implementation never raises
>> +        * TLBI conflict aborts for bbml2 mapping granularity changes.
>> +        */
>> +       static const struct midr_range supports_bbml2_noabort_list[] = {
>> +               MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
>> +               MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
>> +               {}
>> +       };
>> +
> 
> Why on earth is this needed? Is there nothing in the architecture that
> can inform us about this? That seems like a huge oversight to me ...

Currently the architecture can only tell us about the BBM support level.
Currently level 2 is the highest and that permits an implementation to raise a
conflict abort instead of handling it in HW.

Since this series only relies on BBML2 for user space memory, we believe we
could contain and handle any conflict abort safely (the first version of this
series handled the abort). But Yang Shi has a series on list that aims to use
BBML2 to enable dynamically splitting the linear map. It becomes much harder to
reason about the safety of any conflict abort in that case.

Will was keen to take this approach were we decide if the HW supports
"BBML2+NOABORT" semanitics based on the MIDR. Plans are in flight to fix the
arch so we can tidy this up long term, but Will didn't want to hold up Ampere.

Thanks,
Ryan


