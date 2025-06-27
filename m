Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D7B2EA730
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751039237; cv=none; b=myzPa49yCu9LEJ3oo3sFsBWkgO2gFTMka10IULLgXk2RvPCUEFSe11bSLoc9aZANGn+RfnCZVLlULCrMRBLW3gxpuh9HmK25C/j10vrSWHIwGfTfJlSINi64Y26b+j/VlbxGrxLg34HoLBy4mlTp9bPkyJBlYNZrc+gI8Ed9tR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751039237; c=relaxed/simple;
	bh=xL6qj4IqHspwz9EN/Z9QQDRkldqODCvciwLlhqkgJUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CHa1m/nC1DStrOmQ4m/4Bqmp8zwJPh9VVYNXHqHiugmleV/JD7Bav+wAr1URihqhnef1r9UCTMF8sl7Bq8LX6Zmar3X2lbue4swewr0cHPEJ7YXzDJtZYkh/0TAgTyPNcuGABAVO6HlJy/vCrffWw+R9TUFoIHKe8IVd5siA83w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D8E61A00;
	Fri, 27 Jun 2025 08:46:57 -0700 (PDT)
Received: from [10.57.84.221] (unknown [10.57.84.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4DD73F66E;
	Fri, 27 Jun 2025 08:47:10 -0700 (PDT)
Message-ID: <900d2fdc-fcaa-4dbd-8edc-1ba0b0398800@arm.com>
Date: Fri, 27 Jun 2025 16:47:08 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/4] arm64: Add BBM Level 2 cpu feature
Content-Language: en-GB
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 yang@os.amperecomputing.com, catalin.marinas@arm.com, will@kernel.org,
 jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
 maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
 james.morse@arm.com, broonie@kernel.org, ardb@kernel.org, baohua@kernel.org,
 suzuki.poulose@arm.com, david@redhat.com, jgg@ziepe.ca, nicolinc@nvidia.com,
 jsnitsel@redhat.com, mshavit@google.com, kevin.tian@intel.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20250625113435.26849-1-miko.lenczewski@arm.com>
 <20250625113435.26849-3-miko.lenczewski@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250625113435.26849-3-miko.lenczewski@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/06/2025 12:34, Mikołaj Lenczewski wrote:
> The Break-Before-Make cpu feature supports multiple levels (levels 0-2),
> and this commit adds a dedicated BBML2 cpufeature to test against
> support for.
> 
> To support BBML2 in as wide a range of contexts as we can, we want not
> only the architectural guarantees that BBML2 makes, but additionally
> want BBML2 to not create TLB conflict aborts. Not causing aborts avoids
> us having to prove that no recursive faults can be induced in any path
> that uses BBML2, allowing its use for arbitrary kernel mappings.
> 
> This feature builds on the previous ARM64_CPUCAP_EARLY_LOCAL_CPU_FEATURE,
> as all early cpus must support BBML2 for us to enable it (and any later
> cpus must also support it to be onlined).
> 
> Not onlining late cpus that do not support BBML2 is unavoidable, as we
> might currently be using BBML2 semantics for kernel memory regions. This
> could cause faults in the late cpus, and would be difficult to unwind,
> so let us avoid the case altogether.
> 
> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  arch/arm64/include/asm/cpufeature.h |  5 ++++
>  arch/arm64/kernel/cpufeature.c      | 38 +++++++++++++++++++++++++++++
>  arch/arm64/tools/cpucaps            |  1 +
>  3 files changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 155ebd040c55..bf13d676aae2 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -871,6 +871,11 @@ static inline bool system_supports_pmuv3(void)
>  	return cpus_have_final_cap(ARM64_HAS_PMUV3);
>  }
>  
> +static inline bool system_supports_bbml2_noabort(void)
> +{
> +	return alternative_has_cap_unlikely(ARM64_HAS_BBML2_NOABORT);
> +}
> +
>  int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
>  bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
>  
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index f9c947166322..7a3c404288d5 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2213,6 +2213,38 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
>  	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
>  }
>  
> +static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int scope)
> +{
> +	/*
> +	 * We want to allow usage of BBML2 in as wide a range of kernel contexts
> +	 * as possible. This list is therefore an allow-list of known-good
> +	 * implementations that both support BBML2 and additionally, fulfill the
> +	 * extra constraint of never generating TLB conflict aborts when using
> +	 * the relaxed BBML2 semantics (such aborts make use of BBML2 in certain
> +	 * kernel contexts difficult to prove safe against recursive aborts).
> +	 *
> +	 * Note that implementations can only be considered "known-good" if their
> +	 * implementors attest to the fact that the implementation never raises
> +	 * TLB conflict aborts for BBML2 mapping granularity changes.
> +	 */
> +	static const struct midr_range supports_bbml2_noabort_list[] = {
> +		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
> +		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
> +		{}
> +	};
> +
> +	/* Does our cpu guarantee to never raise TLB conflict aborts? */
> +	if (!is_midr_in_range_list(supports_bbml2_noabort_list))
> +		return false;
> +
> +	/*
> +	 * We currently ignore the ID_AA64MMFR2_EL1 register, and only care
> +	 * about whether the MIDR check passes.
> +	 */
> +
> +	return true;
> +}
> +
>  #ifdef CONFIG_ARM64_PAN
>  static void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
>  {
> @@ -2980,6 +3012,12 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.matches = has_cpuid_feature,
>  		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
>  	},
> +	{
> +		.desc = "BBM Level 2 without conflict abort",
> +		.capability = ARM64_HAS_BBML2_NOABORT,
> +		.type = ARM64_CPUCAP_EARLY_LOCAL_CPU_FEATURE,
> +		.matches = has_bbml2_noabort,
> +	},
>  	{
>  		.desc = "52-bit Virtual Addressing for KVM (LPA2)",
>  		.capability = ARM64_HAS_LPA2,
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index 10effd4cff6b..2bd2bfaeddcd 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -45,6 +45,7 @@ HAS_LPA2
>  HAS_LSE_ATOMICS
>  HAS_MOPS
>  HAS_NESTED_VIRT
> +HAS_BBML2_NOABORT
>  HAS_PAN
>  HAS_PMUV3
>  HAS_S1PIE

