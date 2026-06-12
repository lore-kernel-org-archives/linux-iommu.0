Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B371D388E59
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781273807; cv=none; b=pRqto5muq7hEkVVDJhRgYGA5ell82KiyYuFmA/TW1Z2u+nl8TaTkvInk8ansb8O3T6FIcBmmjAuvD5J+kBiZU+AIJCPLG6Ad6gjU6lQmbav6ZgDR3WnpgRkVAjyw0TygFL4EW0Iy2ESgZD8oCFlChSdWrmah6bRIrKIzEj3vzy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781273807; c=relaxed/simple;
	bh=8PsJOJzuPF5XM9wJe8o3VURfHlj8iooyJpurpv29Aaw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j+psKes4jOD/nhIHKAMkQ99w2AuQRyhTxoaBZpuTPHq8ZV2ujIDV1gp/1b2G+BG102iULJnHEPWaImgfs0+X9hLsBc4p/ueykSPMG4sgUcY6GnpTDu27pYI1xQdJdl8Slmib2hi5Ktf5FWJ/rcHf9oTLhzkw/pW8odRSybCF5L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UQfq2XQy; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UQfq2XQy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781273803; x=1812809803;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8PsJOJzuPF5XM9wJe8o3VURfHlj8iooyJpurpv29Aaw=;
  b=UQfq2XQyCnC3nWUhYBdJh1M9pIfyx/TFDEj3+PzLm9otSb6afn2moWXN
   HKv6spKwsTzk4ASZjro8XaPwHSBQXbikhsZ9NV6DprUctAJsYf7VmrD+t
   67EZZ/TLe+qv9Ck6OMFEfOMhGIOT7FIe/hZgAp2FwkCZ1GnOUVoYilaEL
   vsJEd7/oFzKHoMEsALpN00u1/VebX/no7klbAd6e7An11CV43FvRAEgyh
   fBnGEuKZgR1W5VKWu02z0MLCeazGOU1c0kL4YzH6bQdSiRsoyS0HFTv0l
   ixeeCBGN6JblsOLy5jcDAccPNUuikH0254d7efLAn32dKrsPotp34NORQ
   Q==;
X-CSE-ConnectionGUID: 5uItp6QkQOu54eM33o30Iw==
X-CSE-MsgGUID: kI+ILDwAQk6frfe/I5WQjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="92781737"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="92781737"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 07:16:42 -0700
X-CSE-ConnectionGUID: MR8M0VqHR6S3zbkYCxrkhA==
X-CSE-MsgGUID: 2I6bsFn3SNqOw34uSNxxmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="245937204"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 07:16:39 -0700
Message-ID: <2680e88b-1a92-42ea-8574-dbe5a62ad7bd@linux.intel.com>
Date: Fri, 12 Jun 2026 22:16:36 +0800
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
Subject: Re: [PATCH 7/9] iommu/vt-d: Remove the 'force_on' variable
To: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20260604051540.592925-1-kevin.tian@intel.com>
 <20260604051540.592925-8-kevin.tian@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260604051540.592925-8-kevin.tian@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/2026 1:15 PM, Kevin Tian wrote:
> The force_on variable is now redundant - same information captured
> by "dmar_state == DMAR_ENABLED_FORCE". Replace all force_on checks
> with dmar_is_force_on().
> 
> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 34 +++++++++++++++-------------------
>   drivers/iommu/intel/iommu.h |  5 +++++
>   2 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index ed227de6d0ba..d05ae36eda70 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -53,10 +53,9 @@ static int rwbf_quirk;
>   #define rwbf_required(iommu)	(rwbf_quirk || cap_rwbf((iommu)->cap))
>   
>   /*
> - * set to 1 to panic kernel if can't successfully enable VT-d
> + * set to 1 to avoid kernel panic if can't successfully enable VT-d
>    * (used when kernel is launched w/ TXT)
>    */

It might be cleaner to replace it entirely with a new comment. For
example:

/*
  * Skip forcing iommu enablement and avoid tboot-related kernel panics
  * during initialization when set to 1 (via intel_iommu=tboot_noforce).
  */
int intel_iommu_tboot_noforce;

> -static int force_on = 0;
>   int intel_iommu_tboot_noforce;
>   
>   #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
> @@ -1708,7 +1707,7 @@ static int __init init_dmars(void)
>   			 * we always have to disable PMRs or DMA may fail on
>   			 * this device
>   			 */
> -			if (force_on)
> +			if (dmar_is_force_on())
>   				iommu_disable_protect_mem_regions(iommu);
>   			continue;
>   		}
> @@ -1800,7 +1799,7 @@ static int init_iommu_hw(void)
>   			 * we always have to disable PMRs or DMA may fail on
>   			 * this device
>   			 */
> -			if (force_on)
> +			if (dmar_is_force_on())
>   				iommu_disable_protect_mem_regions(iommu);
>   			continue;
>   		}
> @@ -1861,7 +1860,7 @@ static void iommu_resume(void *data)
>   	unsigned long flag;
>   
>   	if (init_iommu_hw()) {
> -		if (force_on)
> +		if (dmar_is_force_on())
>   			panic("tboot: IOMMU setup failed, DMAR can not resume!\n");
>   		else
>   			WARN(1, "IOMMU setup failed, DMAR can not resume!\n");
> @@ -2129,7 +2128,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>   		/*
>   		 * we always have to disable PMRs or DMA may fail on this device
>   		 */
> -		if (force_on)
> +		if (dmar_is_force_on())
>   			iommu_disable_protect_mem_regions(iommu);
>   		return 0;
>   	}
> @@ -2482,13 +2481,13 @@ static bool has_external_pci(void)
>   	return false;
>   }
>   
> -static int __init platform_optin_force_iommu(void)
> +static void __init platform_optin_force_iommu(void)
>   {
>   	if (!dmar_platform_optin() || !dmar_can_force_on(DMAR_FORCEON_PLATFORM))
> -		return 0;
> +		return;
>   
>   	if (!has_external_pci())
> -		return 0;
> +		return;
>   
>   	/*
>   	 * If Intel-IOMMU is disabled by default, we will apply identity
> @@ -2501,8 +2500,6 @@ static int __init platform_optin_force_iommu(void)
>   
>   	dmar_state = DMAR_ENABLED_FORCE;
>   	dmar_disabled = 0;
> -
> -	return 1;
>   }
>   
>   static int __init probe_acpi_namespace_devices(void)
> @@ -2542,10 +2539,10 @@ static int __init probe_acpi_namespace_devices(void)
>   	return 0;
>   }
>   
> -static __init int tboot_force_iommu(void)
> +static __init void tboot_force_iommu(void)
>   {
>   	if (!tboot_enabled() || intel_iommu_tboot_noforce)
> -		return 0;
> +		return;
>   
>   	if (!dmar_can_force_on(DMAR_FORCEON_TBOOT))
>   		panic("tboot: Failed to force IOMMU on\n");
> @@ -2556,8 +2553,6 @@ static __init int tboot_force_iommu(void)
>   	dmar_state = DMAR_ENABLED_FORCE;
>   	dmar_disabled = 0;
>   	no_iommu = 0;
> -
> -	return 1;
>   }
>   
>   int __init intel_iommu_init(void)
> @@ -2570,17 +2565,18 @@ int __init intel_iommu_init(void)
>   	 * Intel IOMMU is required for a TXT/tboot launch or platform
>   	 * opt in, so enforce that.
>   	 */
> -	force_on = tboot_force_iommu() || platform_optin_force_iommu();
> +	tboot_force_iommu();
> +	platform_optin_force_iommu();
>   
>   	down_write(&dmar_global_lock);
>   	if (dmar_table_init()) {
> -		if (force_on)
> +		if (dmar_is_force_on())
>   			panic("tboot: Failed to initialize DMAR table\n");
>   		goto out_free_dmar;
>   	}
>   
>   	if (dmar_dev_scope_init() < 0) {
> -		if (force_on)
> +		if (dmar_is_force_on())
>   			panic("tboot: Failed to initialize DMAR device scope\n");
>   		goto out_free_dmar;
>   	}
> @@ -2634,7 +2630,7 @@ int __init intel_iommu_init(void)
>   
>   	ret = init_dmars();
>   	if (ret) {
> -		if (force_on)
> +		if (dmar_is_force_on())
>   			panic("tboot: Failed to initialize DMARs\n");
>   		pr_err("Initialization failed\n");
>   		goto out_free_dmar;
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 1acc393dafce..6b4e47f2f245 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1383,6 +1383,11 @@ static inline bool dmar_is_disabled(void)
>   	return dmar_state < 0;
>   }
>   
> +static inline bool dmar_is_force_on(void)
> +{
> +	return dmar_state == DMAR_ENABLED_FORCE;
> +}

This helper is only meaningful after

tboot_force_iommu();
platform_optin_force_iommu();

have been called. It would be better to add a brief comment about this?

> +
>   bool dmar_can_force_on(enum dmar_force_on force_on);
>   
>   extern int dmar_disabled;

Thanks,
baolu
