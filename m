Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4370A27FB22;
	Tue,  6 May 2025 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541518; cv=none; b=X4JYxRyLMf19ofDTYz8ov6h8Q74gSLnJfZnGhyztWyjqpPhCo4FNNr5D5wA2/UyYDa91heT1A5VkhSLVN7OYorMYZteQN1Icyw4muqMzZw7S07eYeXQrchXDkptVRi7M43i6agZZEczJtO/rDBg5a5E+2TtESk4cqAzhRX4JXAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541518; c=relaxed/simple;
	bh=McmkAcIkslRMJrw+jewMVQZv98MXR3pnDjXXdxwIM6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPPHxrqsJynLsv0V7SMhzCSmlM5cxko0F5C1rp26KC6HKDsyFoG3dFUwwRkyFxvkFqTjpDCF7G3aPyuPDkWnNyQCI5za8P2DZ9u46wv4CBIMa2/ZZBbtR4e+Cd8diukbN2yMv/49KRoarH8RmU/qGpJwZMLFeuP+fa+lqsVRMhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPcvafjG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPcvafjG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66D6C4CEEB;
	Tue,  6 May 2025 14:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746541517;
	bh=McmkAcIkslRMJrw+jewMVQZv98MXR3pnDjXXdxwIM6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPcvafjGwbgNkBe3KWOrtBUTneUje3MA13kR4Ca0hHa42/L0xcPLow0jATDqFaTrk
	 4KVZSU9reYbz/Ax6HrXB4fbMrM/tCNm0baDln0laVnQZj2Xl1G8swFX5oAfibFuW1w
	 ycJJfTvnJeeAXfiKLVUQY7bOdg0v02Ul4zaRVVHYVBRAiATKrvHQYn+RPDAjEYwV3j
	 AszdVS3Y46tlbRDyI0WWfqRr+tB66lTFfFwsIBLkgfDHKs23oym0g/fyc6+cxpisFA
	 1SGdC3wsRJOYqZdg2SHkhUMMMHSSj8dXRDZeWcMUMfRIpADgmYzZjSuq3eSYIBFfOh
	 Yjlgcvy86uCDg==
Date: Tue, 6 May 2025 15:25:09 +0100
From: Will Deacon <will@kernel.org>
To: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
Cc: ryan.roberts@arm.com, suzuki.poulose@arm.com,
	yang@os.amperecomputing.com, corbet@lwn.net,
	catalin.marinas@arm.com, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
	paulmck@kernel.org, mark.rutland@arm.com, joey.gouly@arm.com,
	maz@kernel.org, james.morse@arm.com, broonie@kernel.org,
	oliver.upton@linux.dev, baohua@kernel.org, david@redhat.com,
	ioworker0@gmail.com, jgg@ziepe.ca, nicolinc@nvidia.com,
	mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
	kevin.tian@intel.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [RESEND PATCH v6 1/3] arm64: Add BBM Level 2 cpu feature
Message-ID: <20250506142508.GB1197@willie-the-truck>
References: <20250428153514.55772-2-miko.lenczewski@arm.com>
 <20250428153514.55772-4-miko.lenczewski@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250428153514.55772-4-miko.lenczewski@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Apr 28, 2025 at 03:35:14PM +0000, Mikołaj Lenczewski wrote:
> The Break-Before-Make cpu feature supports multiple levels (levels 0-2),
> and this commit adds a dedicated BBML2 cpufeature to test against
> support for, as well as a kernel commandline parameter to optionally
> disable BBML2 altogether.
> 
> This is a system feature as we might have a big.LITTLE architecture
> where some cores support BBML2 and some don't, but we want all cores to
> be available and BBM to default to level 0 (as opposed to having cores
> without BBML2 not coming online).
> 
> To support BBML2 in as wide a range of contexts as we can, we want not
> only the architectural guarantees that BBML2 makes, but additionally
> want BBML2 to not create TLB conflict aborts. Not causing aborts avoids
> us having to prove that no recursive faults can be induced in any path
> that uses BBML2, allowing its use for arbitrary kernel mappings.
> Support detection of such CPUs.
> 
> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  3 +
>  arch/arm64/Kconfig                            | 19 +++++
>  arch/arm64/include/asm/cpucaps.h              |  2 +
>  arch/arm64/include/asm/cpufeature.h           |  5 ++
>  arch/arm64/kernel/cpufeature.c                | 71 +++++++++++++++++++
>  arch/arm64/kernel/pi/idreg-override.c         |  2 +
>  arch/arm64/tools/cpucaps                      |  1 +
>  7 files changed, 103 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index d9fd26b95b34..2749c67a4f07 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -449,6 +449,9 @@
>  	arm64.no32bit_el0 [ARM64] Unconditionally disable the execution of
>  			32 bit applications.
>  
> +	arm64.nobbml2	[ARM64] Unconditionally disable Break-Before-Make Level
> +			2 support

Hmm, I'm not sure we really want this. It opens up the door for folks to
pass 'id_aa64mmfr2.bbm=2' without updating the allow-list which feels
like it's going to make crashes harder to reason about.

Is there a compelling reason to add this right now?

>  	arm64.nobti	[ARM64] Unconditionally disable Branch Target
>  			Identification support
>  
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a182295e6f08..613b4925ca06 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2070,6 +2070,25 @@ config ARM64_TLB_RANGE
>  	  The feature introduces new assembly instructions, and they were
>  	  support when binutils >= 2.30.
>  
> +config ARM64_BBML2_NOABORT
> +	bool "Enable support for Break-Before-Make Level 2 detection and usage"
> +	default y

I don't think we need a new Kconfig option for this. It's a
kernel-internal detail and I'd prefer not to fragment the testing base.

> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9c4d6d552b25..7a85a1bdc6e9 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2200,6 +2200,70 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
>  	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
>  }
>  
> +static bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
> +{
> +	/*
> +	 * We want to allow usage of bbml2 in as wide a range of kernel contexts
> +	 * as possible. This list is therefore an allow-list of known-good
> +	 * implementations that both support bbml2 and additionally, fulfill the
> +	 * extra constraint of never generating TLB conflict aborts when using
> +	 * the relaxed bbml2 semantics (such aborts make use of bbml2 in certain
> +	 * kernel contexts difficult to prove safe against recursive aborts).
> +	 *
> +	 * Note that implementations can only be considered "known-good" if their
> +	 * implementors attest to the fact that the implementation never raises
> +	 * TLBI conflict aborts for bbml2 mapping granularity changes.
> +	 */
> +	static const struct midr_range supports_bbml2_noabort_list[] = {
> +		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
> +		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
> +		{}
> +	};
> +
> +	return is_midr_in_range_list(cpu_midr, supports_bbml2_noabort_list);

This doesn't compile against latest mainline as is_midr_in_range_list()
no longer takes the midr.

> +static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int scope)
> +{
> +	if (!IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT))
> +		return false;
> +
> +	if (scope & SCOPE_SYSTEM) {
> +		int cpu;
> +
> +		/*
> +		 * We are a boot CPU, and must verify that all enumerated boot
> +		 * CPUs have MIDR values within our allowlist. Otherwise, we do
> +		 * not allow the BBML2 feature to avoid potential faults when
> +		 * the insufficient CPUs access memory regions using BBML2
> +		 * semantics.
> +		 */
> +		for_each_online_cpu(cpu) {
> +			if (!cpu_has_bbml2_noabort(cpu_read_midr(cpu)))
> +				return false;
> +		}

This penalises large homogeneous systems and it feels unnecessary given
that we have the ability to check this per-CPU. Can you use
ARM64_CPUCAP_BOOT_CPU_FEATURE instead of ARM64_CPUCAP_SYSTEM_FEATURE
to solve this?

Will
