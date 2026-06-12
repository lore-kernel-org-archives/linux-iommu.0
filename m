Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C09378D78
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 11:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262503; cv=none; b=F+PwaoIZsGzwoLpo+cTM1Ch/2cD4JoHJMTy64ogqWjK2bv1JX9fodMxsiPnY5AXTMKw/Dowqr0JcrMK+6ceAuOZ/ufnCLpWi3zFvw1eX+9kUGeTqT3YdRV+D7SUpbdVa2/AzmKocSlqBxMR5KUjtHM8TS4w92679ED9Ouk5ypH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262503; c=relaxed/simple;
	bh=cezXvdxOL+vfPJ/8Z18Bt6leqTyWfzCNtGOOOUK73fo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h5BzKIICRTpyQZFwNiul1BikieSA9r46XfCs4/y89Gtyul/hMXlpfHcsjsVbL5bI4XLb8CMykhTfjw7g9h6tcXsAd9Qiv+ppHXNPWFamlRvcjlGEqiE2zu46J3kA19yRub7tnAvMyXlLNQFA2tJFwCR2jtbah2+2A7BDGsvCuJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/Y6vINS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/Y6vINS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781262503; x=1812798503;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cezXvdxOL+vfPJ/8Z18Bt6leqTyWfzCNtGOOOUK73fo=;
  b=f/Y6vINSvyHZ//lJgi4x8XBStC3oFKGvG7lwZkHf97SkPtCc2OXnxArX
   L3D1CYse66nB9IveCtX/VqLX+rkSUkofwyGUyw58oYec9dJGnetGuW55D
   VcpGgDoZvkVbb5YqmIJJnpI+nV89+dCJTRZTQxgXtdh3DSvecus8Xf6Ry
   wI8lODZnxOqxo+anABLqV7FJj7HmtFFNZd1tyyNbF41bg9/oXILBmSxfz
   cyiVqAZpCAzzIFoZAP0lsi4t8tD/+73fsaZWvnIHxjF9hfLYVloUZI9rS
   4c/u8Yt6ercLbTa++lHWfHjFIqHFpozdoWTGmVWY/qcoMi48BARMOD3xe
   g==;
X-CSE-ConnectionGUID: hcH8GXVUT6m0H2lZo4DCmg==
X-CSE-MsgGUID: fvDUzGvWTl2PHSRyM2NnKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81997720"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="81997720"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 04:08:22 -0700
X-CSE-ConnectionGUID: ALg7M3ueTNOrWhjt75QIAQ==
X-CSE-MsgGUID: K8TqNZf1QVeWbE/ucSL97Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="245698480"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 04:08:18 -0700
Message-ID: <fe8d86ec-539c-4fb3-bf8b-48150e92eecf@linux.intel.com>
Date: Fri, 12 Jun 2026 19:08:15 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <jroedel@suse.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Chris Wright <chrisw@sous-sol.org>,
 Jesse Barnes <jbarnes@virtuousgeek.org>,
 Asit Mallick <asit.k.mallick@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] iommu/vt-d: Consolidate dmar state management and
 force_on logic
To: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20260604051540.592925-1-kevin.tian@intel.com>
 <20260604051540.592925-5-kevin.tian@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260604051540.592925-5-kevin.tian@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/2026 1:15 PM, Kevin Tian wrote:
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
> Signed-off-by: Kevin Tian<kevin.tian@intel.com>
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

It reads like tboot successfully overrides the user's choices, whereas
the platform opt-in cannot. Could you shed more light on this? My
understanding is that "trusted boot environment" is considered stronger
than "user choices", which in turn is stronger than a "platform opt-in
hint".

If this is indeed the core design philosophy, would you mind spelling it
out explicitly in this comment? Making the exact precedence clear
will help future development follow the same philosophy.

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

If this helper returns false (meaning a requested force_on type cannot
be enforced), would it be better to notify the user via a clear pr_info/
pr_warn in the kernel log?

Normally, a failure to enforce a requested "force_on" condition might
mean security or trust implications that the administrator should be
aware of.

The rest of the patch looks good to me. Thanks!

Thanks,
baolu
