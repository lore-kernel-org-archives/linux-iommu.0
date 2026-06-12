Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B27D3839AD
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274381; cv=none; b=JsNEc5qAlK/xVa2EGENGCDRf8bC6ETgkqPrW9FvueuqupmLu4AIUj/Y5kWQwC69beTC4TXr0HVZkD2zQlx1kJSAOSb/1/eEGh5QScetZPOtNAuOABT1IS41zLn/IpDCroRiaAK8WJUCg5SbyeJr7COMLhcg4UizhHwNfTeOpgrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274381; c=relaxed/simple;
	bh=oSAekkhrhmFGq1QKW0ADMiQ8W1kEGxHU8/BanClxXjI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UZ6NmU1Tu6FfiX92SJRyeUZO5GA78YUGeY1w0GxMOHY9RGvYqf16WG3y9SF7Vepp2e5d0yuH85QlOfQ9AP9j+KJCvl5qo3ZMOlFcs1OQPO88uGLrET1QjkpJipJ3uGW9RotZVDJuIFRfJzSm82fiMR4PG2mObkJV+vcVK5kIsV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XA32fqv1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XA32fqv1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781274379; x=1812810379;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oSAekkhrhmFGq1QKW0ADMiQ8W1kEGxHU8/BanClxXjI=;
  b=XA32fqv18lTYXw6Y5DUTxNoAkebyykk5yfg26Ph/1mG/j8NU7Bc6HesI
   USCriVEylmxo9mujwwrzYXvfMGQ+QQeUVl/C5SG2d94WdgR5jz3pL/mUn
   VCBVOK9Lg7fO7kXkJXzmbff7sE511xOSf9k3tyUIDNek3ISGPpm5PaSCF
   W4k0ULFD1czfppE4b7y493HglFh51Dk3ungWYxSOf3GTwI79rKhmuiN+K
   kXsrdsj+JSJKRNrl3klQT1KEhKCDVOp1EEvrpUi48PQPQwOUgqrjeY6Py
   BgWvlYAcZqQSedaxsSNN79B6XQHtvYYAXI8e9XfDTr3gIIgnnu7SSYbWE
   w==;
X-CSE-ConnectionGUID: 2vNNNWhxR8C4dtJZHwiPvw==
X-CSE-MsgGUID: HEV0YogyTQu/bvodTWM3yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="92426661"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="92426661"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 07:26:19 -0700
X-CSE-ConnectionGUID: eLMT6XsaT7C5S5dqAP/5QA==
X-CSE-MsgGUID: yRbRdbCgRBaDZEtq/sHv0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="245938954"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 07:26:16 -0700
Message-ID: <c9c6b903-f62b-448c-82e0-c8b40d13df0a@linux.intel.com>
Date: Fri, 12 Jun 2026 22:26:13 +0800
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
Subject: Re: [PATCH 8/9] iommu/vt-d: Remove dmar_disabled
To: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20260604051540.592925-1-kevin.tian@intel.com>
 <20260604051540.592925-9-kevin.tian@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260604051540.592925-9-kevin.tian@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/2026 1:15 PM, Kevin Tian wrote:
> It's replaced by dmar_is_disabled() now, covering both "iommu=off"
> and "intel_iommu=off". Also remove unnecessary checks on no_iommu,
> leaving only one exception in intel_iommu_init() which skips debugfs
> init for "iommu=off" but not "intel_iommu=off". Keep it to avoid
> surprise for now.

As mentioned in the previous patch, dmar_is_disabled() only becomes
meaningful for wider usage after the force_on logic has been executed,
right? Would it be better to add a check to make it safe?

> 
> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 9 ++-------
>   drivers/iommu/intel/iommu.h | 1 -
>   drivers/iommu/intel/svm.c   | 2 +-
>   3 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d05ae36eda70..78498dafa60a 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -199,7 +199,6 @@ int dmar_state = DMAR_ENABLED;
>   #else
>   int dmar_state = DMAR_DISABLED_AUTO;
>   #endif
> -int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
>   int intel_iommu_sm = IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
>   
>   int intel_iommu_enabled = 0;
> @@ -241,11 +240,9 @@ static int __init intel_iommu_setup(char *str)
>   	while (*str) {
>   		if (!strncmp(str, "on", 2)) {
>   			dmar_state = DMAR_ENABLED;
> -			dmar_disabled = 0;
>   			pr_info("IOMMU enabled\n");
>   		} else if (!strncmp(str, "off", 3)) {
>   			dmar_state = DMAR_DISABLED_USER;
> -			dmar_disabled = 1;
>   			pr_info("IOMMU disabled\n");
>   		} else if (!strncmp(str, "igfx_off", 8)) {
>   			disable_igfx_iommu = 1;
> @@ -2366,7 +2363,7 @@ void intel_iommu_shutdown(void)
>   	struct dmar_drhd_unit *drhd;
>   	struct intel_iommu *iommu = NULL;
>   
> -	if (no_iommu || dmar_disabled)
> +	if (dmar_is_disabled())
>   		return;
>   
>   	/*
> @@ -2499,7 +2496,6 @@ static void __init platform_optin_force_iommu(void)
>   	}
>   
>   	dmar_state = DMAR_ENABLED_FORCE;
> -	dmar_disabled = 0;
>   }
>   
>   static int __init probe_acpi_namespace_devices(void)
> @@ -2551,7 +2547,6 @@ static __init void tboot_force_iommu(void)
>   		pr_warn("Forcing Intel-IOMMU to enabled\n");
>   
>   	dmar_state = DMAR_ENABLED_FORCE;
> -	dmar_disabled = 0;
>   	no_iommu = 0;
>   }
>   
> @@ -2594,7 +2589,7 @@ int __init intel_iommu_init(void)
>   	if (!no_iommu)
>   		intel_iommu_debugfs_init();
>   
> -	if (no_iommu || dmar_disabled) {
> +	if (dmar_is_disabled()) {
>   		/*
>   		 * We exit the function here to ensure IOMMU's remapping and
>   		 * mempool aren't setup, which means that the IOMMU's PMRs
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 6b4e47f2f245..1832debf4982 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1390,7 +1390,6 @@ static inline bool dmar_is_force_on(void)
>   
>   bool dmar_can_force_on(enum dmar_force_on force_on);
>   
> -extern int dmar_disabled;
>   extern int intel_iommu_enabled;
>   extern int intel_iommu_tboot_noforce;
>   
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 57cd1db7207a..971dddaba48e 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -115,7 +115,7 @@ static int intel_iommu_sva_supported(struct device *dev)
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>   	struct intel_iommu *iommu;
>   
> -	if (!info || dmar_disabled)
> +	if (!info || dmar_is_disabled())
>   		return -EINVAL;
>   
>   	iommu = info->iommu;

Thanks,
baolu
