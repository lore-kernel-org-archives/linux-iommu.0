Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F2E220689;
	Thu, 19 Jun 2025 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750331112; cv=none; b=OwJJLcoPD7ShzzChdKT69hQ+NkoFP2XRbHNymOlI03BjZRYTS5SOD7SXlvHxCiGawIbkV1oQ1NuXcj69TPPuzCO/3t66h2bhhng3+QonZKE6RYoslxvYE3K1Wklr3joz0WQZsI7vb+Yic+FUd4mYLI581+fxabVXAIuMf8Rly+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750331112; c=relaxed/simple;
	bh=rYhliljQfdXy0EYM3FNValqPiZeolZqxBnCCabM44Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbSDDlWHmQbdnCpfEnYtIc4xsGprD8X/3Cu3+a4C0zfxPNrM3OyyvtxX7Xd5wZsUowtEc9iFGSpkAercEEgHH5Sgs5QRISmURuqFcrJx9gtUHKNhXWW5j0Luo4Js8eKdEzjv0vkDKBW2ans73Ar0STIVoYwzukNhel0XvAO/v/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF159C4CEEA;
	Thu, 19 Jun 2025 11:05:07 +0000 (UTC)
Date: Thu, 19 Jun 2025 12:05:05 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
Cc: ryan.roberts@arm.com, yang@os.amperecomputing.com, will@kernel.org,
	jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	james.morse@arm.com, broonie@kernel.org, ardb@kernel.org,
	baohua@kernel.org, suzuki.poulose@arm.com, david@redhat.com,
	jgg@ziepe.ca, nicolinc@nvidia.com, jsnitsel@redhat.com,
	mshavit@google.com, kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v7 2/4] arm64: Add BBM Level 2 cpu feature
Message-ID: <aFPu4SorUGlFt-2p@arm.com>
References: <20250617095104.6772-1-miko.lenczewski@arm.com>
 <20250617095104.6772-3-miko.lenczewski@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617095104.6772-3-miko.lenczewski@arm.com>

On Tue, Jun 17, 2025 at 09:51:02AM +0000, Mikołaj Lenczewski wrote:
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index f9c947166322..2e80ff237b96 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2213,6 +2213,41 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
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
> +	 * TLBI conflict aborts for BBML2 mapping granularity changes.

s/TLBI/TLB/

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
> +	 * We currently ignore the AA64_ID_MMFR2 register, and only care about

s/AA64_ID_MMFR2/ID_AA64MMFR2_EL1/

> +	 * whether the MIDR check passes. This is because we specifically
> +	 * care only about a stricter form of BBML2 (one guaranteeing noabort),
> +	 * and so the MMFR2 check is pointless (all implementations passing the
> +	 * MIDR check should also pass the MMFR2 check).

I think there's at least one implementation that behaves as
BBML2-noabort but does not have the ID field advertising BBML2.

> +	 */
> +
> +	return true;
> +}
> +
>  #ifdef CONFIG_ARM64_PAN
>  static void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
>  {
> @@ -2980,6 +3015,11 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.matches = has_cpuid_feature,
>  		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
>  	},
> +	{
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

Otherwise it looks fine.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
