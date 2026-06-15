Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B272276038
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 05:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781499713; cv=none; b=S7TueaRlpjouMV50kEjsvjT029qe3oUKbZjyb4/3JZ1DIa8jH/Sv2b+huQjHxTsGz8jSSpcDb26AAyCxlf42S/sVtxlOrBQVmL7kupCMhllY+9o60DpfW0xaIjALLSZQpaYas4W9hdwKMCne02S9KSmOv8tUZXiuc2OfLGrtKHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781499713; c=relaxed/simple;
	bh=npidoyhUEKR6DcTVhsfk/llpfeUx+9KkBOPwh6w/6yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVQn1zClUKRXZfb+kc1nQd999kInMeqyZqGAGfDHpKXYriVfEjB6T83Hn6evVaC2PkxpQ14IGBtZ1uYXNqdboGFXjL6Zt0o8agSuZqefOdXo5l+KyDElQ5XTuzupXkix8qEOoYCOFFmeJRteBzloJEqkkb152RdtDV+cvXWqaL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L7snMDSW; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L7snMDSW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781499712; x=1813035712;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=npidoyhUEKR6DcTVhsfk/llpfeUx+9KkBOPwh6w/6yE=;
  b=L7snMDSW1XFCC8hX6Li1l4/Sy5ZSSccZ8ZCeQBN3u9nnDdEk7yHIrcWY
   unFe9MTpCXqogmg1eF9KDtFHlbcuPn7k1ITxEkAhSYbXWSvm2Gy8M1wI5
   QMK9q9FRgEdSslLpQkmR/TLa2AkxCOjFT5x/ko+7R6FIeVteC0gAvNWUb
   5yFYceMuOaq+lJQ5TtfWMwa0+Cdadesi/tzh94R/xUTE7VELZiAEoX0F1
   v72iHSGzMcyYjWNhpK5GuCi8a6SV6ReEvnmU0qEDLCaa/al7pRStRmU/o
   T82i/lmDJ26Rbl7lDQFhAip52LL1trCCvPaaW+w+cRFmMJKKuO6ubbGCH
   w==;
X-CSE-ConnectionGUID: 8wj4ZxtUQ8G90uvzOreK8Q==
X-CSE-MsgGUID: eX+B2ZhoTl2TeKlSkhWciQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="82421835"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="82421835"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 22:01:51 -0700
X-CSE-ConnectionGUID: IjvyRHwbTDKDSpnRdtwneg==
X-CSE-MsgGUID: vAmhCS+WTyumfgq0oRTm6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="244459617"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 22:01:48 -0700
Message-ID: <c6ddabae-09ee-4101-94ca-d077514bae5a@linux.intel.com>
Date: Mon, 15 Jun 2026 13:00:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] iommu/vt-d: Consolidate dmar state management and
 force_on logic
To: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <jroedel@suse.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Chris Wright <chrisw@sous-sol.org>,
 Jesse Barnes <jbarnes@virtuousgeek.org>,
 Asit Mallick <asit.k.mallick@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260604051540.592925-1-kevin.tian@intel.com>
 <20260604051540.592925-5-kevin.tian@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260604051540.592925-5-kevin.tian@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/26 13:15, Kevin Tian wrote:
> Currently the dmar state is carried by multiple variables (no_iommu,
> dmar_disabled, no_platform_optin, etc.) with error-prone force_on logic
> scattered in multiple places.
> 
> Unify the state management and centralize the policy/priority for
> various force_on scenarios.
> 
> No functional impact except one case - "intel_iommu=off" sets
> no_platform_optin which is checked in platform_optin_force_iommu()
> but not in detect_intel_iommu(), leading to ACS unnecessarily requested
> when iommu could not be forced on later. Now with the unified logic
> this becomes more consistent.
> 
> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> ---
>   drivers/iommu/intel/dmar.c  | 57 ++++++++++++++++++++++++++++++++++---
>   drivers/iommu/intel/iommu.c |  7 +++++
>   drivers/iommu/intel/iommu.h | 45 +++++++++++++++++++++++++++++
>   3 files changed, 105 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index e8f01e56cf46..791b91a7be29 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -915,14 +915,60 @@ dmar_validate_one_drhd(struct acpi_dmar_header *entry, void *arg)
>   	return 0;
>   }
>   
> +/*
> + * Centralized helper for deciding the force_on policy
> + *
> + * dmar disabled states (for DMA Remapping) are defined from stronger
> + * disables (more negative values) to weaker disables (less negative
> + * values).
> + *
> + * When a force_on type is passed in, it is associated to a reference
> + * level for comparison. force_on is permitted when dmar is in a
> + * disabled state less negative than the reference level (if dmar is
> + * enabled then the check is always true).
> + *
> + * For supported force_on types:
> + *
> + * - DMAR_FORCEON_TBOOT: tboot strictly requires DMA remapping for secure
> + *   boot hence supersedes any user opts ("iommu=off" or "intel_iommu=off")
> + *   and weaker disables.
> + *
> + * - DMAR_FORCEON_PLATFORM: external-facing devices requires DMA
> + *   remapping to prevent malicious downstream external devices from
> + *   composing DMA attacks. force_on is permitted only if dmar is disabled
> + *   by build configurations (CONFIG_INTEL_IOMMU_DEFAULT_ON=off).
> + */
> +bool dmar_can_force_on(enum dmar_force_on force_on)
> +{
> +	int level;
> +
> +	switch (force_on) {
> +	case DMAR_FORCEON_TBOOT:
> +		level = DMAR_DISABLED_USER;
> +		break;
> +	case DMAR_FORCEON_PLATFORM:
> +		level = DMAR_DISABLED_AUTO;
> +		break;
> +	default:
> +		pr_warn("Unsupported force_on type (%d)\n", force_on);
> +		/* '0' means returning true only when dmar is enabled */
> +		level = 0;
> +		break;
> +	}
> +
> +	return dmar_state >= level;
> +}
> +
>   static bool dmar_required(void)
>   {
> -	/* tboot supersedes any user/platform opt */
> -	if (!intel_iommu_tboot_noforce && tboot_enabled())
> +	if (dmar_is_enabled())
>   		return true;
>   
> -	if (!no_iommu && (!dmar_disabled || dmar_platform_optin()))
> -		return true;
> +	if (!intel_iommu_tboot_noforce && tboot_enabled())
> +		return dmar_can_force_on(DMAR_FORCEON_TBOOT);
> +
> +	if (dmar_platform_optin())
> +		return dmar_can_force_on(DMAR_FORCEON_PLATFORM);
>   
>   	return false;
>   }
> @@ -936,6 +982,9 @@ void __init detect_intel_iommu(void)
>   	};
>   
>   	down_write(&dmar_global_lock);
> +	if (no_iommu)
> +		dmar_state = DMAR_DISABLED_USER;
> +
>   	ret = dmar_table_detect();
>   	if (!ret)
>   		ret = dmar_walk_dmar_table((struct acpi_table_dmar *)dmar_tbl,
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 0365ff4e5092..0fc131a34963 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -196,6 +196,11 @@ static LIST_HEAD(dmar_satc_units);
>   
>   static void intel_iommu_domain_free(struct iommu_domain *domain);
>   
> +#ifdef CONFIG_INTEL_IOMMU_DEFAULT_ON
> +int dmar_state = DMAR_ENABLED;
> +#else
> +int dmar_state = DMAR_DISABLED_AUTO;
> +#endif
>   int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
>   int intel_iommu_sm = IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
>   
> @@ -237,9 +242,11 @@ static int __init intel_iommu_setup(char *str)
>   
>   	while (*str) {
>   		if (!strncmp(str, "on", 2)) {
> +			dmar_state = DMAR_ENABLED;
>   			dmar_disabled = 0;
>   			pr_info("IOMMU enabled\n");
>   		} else if (!strncmp(str, "off", 3)) {
> +			dmar_state = DMAR_DISABLED_USER;
>   			dmar_disabled = 1;
>   			no_platform_optin = 1;
>   			pr_info("IOMMU disabled\n");
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index bb8b973476f6..1acc393dafce 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1340,6 +1340,51 @@ static inline bool ecmd_has_pmu_essential(struct intel_iommu *iommu)
>   		DMA_ECMD_ECCAP3_ESSENTIAL;
>   }
>   
> +enum dmar_force_on {
> +	DMAR_FORCEON_PLATFORM,
> +	DMAR_FORCEON_TBOOT
> +};
> +
> +/*
> + * Enabled states are positive, with more positive value being stronger.
> + * Disabled states are negative, with more negative value being stronger.
> + *
> + * 'dmar' here refers to DMA remapping instead of the dmar/iommu unit.
> + *
> + * - DMAR_ENABLED_FORCE:
> + *     force enabled (e.g. by tboot or platform optin).
> + *
> + * - DMAR_ENABLED:
> + *     enabled by build configuration (CONFIG_INTEL_IOMMU_DEFAULT_ON=on)
> + *     or user opts ("intel_iommu=on").
> + *
> + * - DMAR_DISABLED_AUTO
> + *     disabled by build configuration (CONFIG_INTEL_IOMMU_DEFAULT_ON=off).
> + *
> + * - DMAR_DISABLED_USER
> + *     disabled by user opts ("intel_iommu=off" or "iommu=off").
> + *
> + * - '0' is invalid, compared to decide dmar enabled vs. disabled
> + *
> + */
> +#define DMAR_ENABLED_FORCE	2
> +#define DMAR_ENABLED		1
> +#define DMAR_DISABLED_AUTO	-1
> +#define DMAR_DISABLED_USER	-2
> +extern int dmar_state;
> +
> +static inline bool dmar_is_enabled(void)
> +{
> +	return dmar_state > 0;
> +}
> +
> +static inline bool dmar_is_disabled(void)
> +{
> +	return dmar_state < 0;
> +}

The helpers above seem to conflict with:

	extern int intel_iommu_enabled;

Can we possibly make the interface consistent?

> +
> +bool dmar_can_force_on(enum dmar_force_on force_on);
> +
>   extern int dmar_disabled;
>   extern int intel_iommu_enabled;
>   extern int intel_iommu_tboot_noforce;

Thanks,
baolu
