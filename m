Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAB71AC45D
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 01:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792373452; cv=none; b=G/0/OBdOq54o1o3tApMAZQ9ZKE5na5vSXnlElKo7BI9y/oMHf1li9596J2adkeTW0PuJNyJGlhpLhkaP42lCx1SeMGUlLKZsJFQZ3tCGproj3KB9c0UgpEk2V6Fc0/tiWFQ8wJksU6T8zZMZW7eam3M3Uv2v97Q8HIqdmfKh8pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792373452; c=relaxed/simple;
	bh=Z0ySzCm4p42xcebUysLz6g5Qcv04uD1bUD2zrOIOm3I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pb4XTCKA/B2eFHWKqGZwGya5XxMpyoV8VSW1e99m5MBE/CjAdzgJPpKQUgLbPas/0Oppsy3xQxedJyNs81GNH7NbBxFqckNQ9xwu1opvtleTdV3E8S74gYv+ojXmVEOMV655reXJB4GWLCp+4rVOe77tp5bEndqHt+lEgYMMpL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+X1yHQB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+X1yHQB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792373451; x=1823909451;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z0ySzCm4p42xcebUysLz6g5Qcv04uD1bUD2zrOIOm3I=;
  b=m+X1yHQBKfla096Fzt9RcvU15vbI7VOKBAbM2tiAZgSGFpg2ysVtViuw
   BlY4u2i03aMWoAvYsuYHc/Nlof2gNB/iwTL3smEs8zlVhk6uIESxEDOP6
   AvGwCo8Gk+Z9y/z4ZmaM3aZrqpFYztyQcsCyVZ8vcyptEgu3tsVoO+W0E
   hcO8N7sRPoGFSyG3ZheBdiLA6uW5FM4pvfbbqbZ8hgxsRBnf8z0KQR0kw
   SGClkK9zspfgKRj8fwscbhaDGtfshS+pF3+s3bgAblTKB65a1nDNSLAZC
   GvV5GJhRvDm0/5RvWHpBB73jyUDOCOuRl7sHsL8+lU5aijGAd8DlobRm0
   w==;
X-CSE-ConnectionGUID: LS7p2qTUQficee6f/9NYGw==
X-CSE-MsgGUID: 5Xow0knOT7KbicGh9mj65A==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1069105"
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="1069105"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 18:30:50 -0700
X-CSE-ConnectionGUID: suzdxA2UT0KxVmfEucdcag==
X-CSE-MsgGUID: vq2OGzu7S2ugJghDyoXBHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="2765006"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 18:30:47 -0700
Message-ID: <3a78df93-845a-4432-8aa1-fc4939f4f400@linux.intel.com>
Date: Mon, 19 Oct 2026 09:30:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Ning Sun <ning.sun@intel.com>,
 Michal Camacho Romero <michal.camacho.romero@intel.com>, x86@kernel.org,
 iommu@lists.linux.dev, tboot-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Mateusz Mowka <mateusz.mowka@intel.com>,
 Adam Pawlicki <adamx.pawlicki@intel.com>,
 Pawel Randzio <pawel.randzio@intel.com>
Subject: Re: [PATCH v5 2/2] iommu/vt-d: Disable PMRs and skip force-IOMMU when
 TXT TPRs are active
To: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>,
 Thomas Gleixner <tglx@kernel.org>
References: <7f637b22-110b-4e49-b083-6062bcad37c4@linux.intel.com>
 <20261012102211.1739615-1-michal.camacho.romero@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261012102211.1739615-1-michal.camacho.romero@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/2026 6:22 PM, Michal Camacho Romero wrote:
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 2e3b3ab216f8..ea32730701cf 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2558,11 +2558,18 @@ static int __init probe_acpi_namespace_devices(void)
>   	return 0;
>   }
>   
> -static __init void tboot_force_iommu(void)
> +static __init void tboot_force_iommu(s64 num_of_enabled_tprs)
>   {
>   	if (!tboot_enabled() || intel_iommu_tboot_noforce)
>   		return;
>   
> +	/*
> +	 * If TPR is enabled we don't need to force IOMMU, TPR set by SINIT
> +	 * ACM will take care of DMA protection.
> +	 */
> +	if (tboot_is_tpr_protection_enabled(num_of_enabled_tprs))
> +		return;
> +

I don't quite follow this. The TPRs are disabled once DMA remapping is
enabled in intel_iommu_init(). After that, the IOMMU is the only runtime
DMA protection, which is why tboot forces it on in the first place.

With this change, booting with intel_iommu=off on a TPR-capable platform
would no longer force the IOMMU on. What happens next?

- If the TPRs are left enabled, devices can't DMA into the protected
   ranges, so the system is likely broken.

- If the TPRs are later disabled, the measured launch has no DMA
   protection at all.

Neither seems acceptable. I may have overlooked or misunderstood
something, so please explain.

>   	if (!dmar_can_force_on(DMAR_FORCEON_TBOOT))
>   		panic("tboot: Failed to force IOMMU on\n");
>   
> @@ -2584,7 +2591,15 @@ int __init intel_iommu_init(void)
>   	 * Intel IOMMU is required for a TXT/tboot launch or platform
>   	 * opt in, so enforce that.
>   	 */
> -	tboot_force_iommu();
> +	void __iomem           *txt_heap = NULL;
> +	struct acpi_table_dtpr *dtpr     = tboot_get_dtpr_table(&txt_heap);
> +	s64 num_of_enabled_tprs = 0;

Too much tboot internal state leaks into the IOMMU driver. Could tboot
keep this state internally and expose only simple helpers, for example
tboot_tpr_active() and tboot_tpr_disable()?

> +	if (dtpr) {
> +		/* For the existing DTPR Table, verify TPRs activity status */
> +		num_of_enabled_tprs = tboot_check_tprs(dtpr, &txt_heap);
> +	}
> +	
> +	tboot_force_iommu(num_of_enabled_tprs);
>   	if (!dmar_policy_force_on())
>   		platform_optin_force_iommu();
>   
> @@ -2623,7 +2638,8 @@ int __init intel_iommu_init(void)
>   		 * calling SENTER, but the kernel is expected to reset/tear
>   		 * down the PMRs.
>   		 */
> -		if (intel_iommu_tboot_noforce) {
> +		if (intel_iommu_tboot_noforce ||
> +			tboot_is_tpr_protection_enabled(num_of_enabled_tprs)) {

tboot_noforce should apply to TPRs as well. See the comment on its
definition:

/*
  * Skip forcing iommu on and avoid tboot-related kernel panics during
  * initialization when set to 1 (via intel_iommu=tboot_noforce).
  */
int intel_iommu_tboot_noforce;

It's a debugging feature to avoid kernel panics during early boot.

>   			for_each_iommu(iommu, drhd)
>   				iommu_disable_protect_mem_regions(iommu);
>   		}
> @@ -2697,7 +2713,24 @@ int __init intel_iommu_init(void)
>   			iommu_enable_translation(iommu);
>   
>   		iommu_disable_protect_mem_regions(iommu);
> +

Unnecessary change.

>   	}
> +
> +	if (tboot_is_tpr_protection_enabled(num_of_enabled_tprs) && dtpr) {
> +		/*
> +		 * TPRs are enabled. It is necessary to disable active TPRs
> +		 * to enable DMA usage by the system.
> +		 */
> +		num_of_enabled_tprs = tboot_disable_tprs(dtpr, &txt_heap,
> +		                                         num_of_enabled_tprs);
> +		if (num_of_enabled_tprs != 0)
> +			panic("tboot: Failed to disable TPRs. DMA is still blocked.\n");
> +	}
> +
> +	/* Release the TXT heap memory if it was allocated */
> +	if (txt_heap)
> +		tboot_free_txt_heap_mem(&txt_heap);
> +
>   	up_read(&dmar_global_lock);
>   
>   	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
> @@ -2707,6 +2740,9 @@ int __init intel_iommu_init(void)
>   	return 0;
>   
>   out_free_dmar:
> +	if (txt_heap)
> +		tboot_free_txt_heap_mem(&txt_heap);
> +
>   	intel_iommu_free_dmars();
>   	up_write(&dmar_global_lock);
>   	return ret;
> -- 2.55.0

Thanks,
baolu
