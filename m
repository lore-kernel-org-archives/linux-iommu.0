Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798D61A6806
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167795; cv=none; b=cwMwbwofjc5LlFwJPj/dwMin1oq7+62/2hxuwylpKfEaK2S8oE3ISiW66xqdqYm8R0HIylM2qwQY6UI5iTse0GIE7nxsQn8kh+lLqpLV2gYzzSStsZEKcJpxptmFGuLXswYYc8dhe3oeFiRtIekBp+ZaSNKsAQN/woAR0pLer0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167795; c=relaxed/simple;
	bh=6tYVvnGZKasWDm9BXemM4cAOIkZRfGZJvPRQFKV7xYg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MEDRfRxazPCu/lhHZn3mcN1XpgpR6XbWWvQqsVeFtk4/NPlQnUDhvq4zI0uCLGE5uh3AO4smjCdQtucfvrh1hbyPop+th586z+COY6tpHjA2zHpYls54SWJ3C4a1Zb4hzvVm8T9BmPyZ35usvkXmR9K7DCrHozx7APbF+UFtAcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJpfUkGS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJpfUkGS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781167794; x=1812703794;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6tYVvnGZKasWDm9BXemM4cAOIkZRfGZJvPRQFKV7xYg=;
  b=aJpfUkGSp8Z9MFxTR3OAjtG089e4O+AzRqruH3X5K1pj8DtWBJxLlUQC
   QgRPrhxkj/doLzpPxh3gJg7m/u4WI9Dm+m3BiUZAeg03clTVOjcGMnA04
   YfroUhZZGtH8XNVSW9Er5d2H5+iNBaFQOXafLxPpyEyXwcjae2Tm9SmRi
   lNwX5x6Y6BEQ0AOLjjryVzFyfDq+RuVS0m8rZykb/BHH0pQTx5enuE8ho
   EcVMmf5Vpwnm3h7CLq8xmMnacTyAhZ+OgMPfZwBgGXxRwBnkLUZf4MGkR
   F8NXpx6EX5+S4WpdHefw1C8lj7V1hepIOB+nMtqcHOdgnHtxrDihOapAq
   g==;
X-CSE-ConnectionGUID: lSHTzCIOTM+U8ExL0UssUQ==
X-CSE-MsgGUID: xl06SRsUS4aRL7xsmPHcJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81717070"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="81717070"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 01:49:54 -0700
X-CSE-ConnectionGUID: bdbt8xryTHO0R6bsoiZm2g==
X-CSE-MsgGUID: iesS4LovSL6Mdrv0RskxqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="251515866"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 01:49:50 -0700
Message-ID: <9f79de94-01ac-4504-baf6-f5d59e77a954@linux.intel.com>
Date: Thu, 11 Jun 2026 16:49:47 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, x86@kernel.org, iommu@lists.linux.dev,
 tboot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Mateusz Mowka <mateusz.mowka@intel.com>,
 Adam Pawlicki <adamx.pawlicki@intel.com>,
 Pawel Randzio <pawel.randzio@intel.com>
Subject: Re: [PATCH v1 2/2] iommu/vt-d: Disable PMRs and skip force-IOMMU when
 TXT TPRs are active
To: Michal Camacho Romero <michal.camacho.romero@intel.com>,
 Ning Sun <ning.sun@intel.com>, Thomas Gleixner <tglx@kernel.org>
References: <20260603114500.2771319-1-michal.camacho.romero@intel.com>
 <20260603114500.2771319-3-michal.camacho.romero@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260603114500.2771319-3-michal.camacho.romero@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/3/2026 7:45 PM, Michal Camacho Romero wrote:
> When Intel TXT Protection Regions (TPRs) are present in the DTPR table,
> hardware-level DMA protection is already enforced by the SINIT ACM.
> In this case:
> 
> - Skip forcing IOMMU enablement in tboot_force_iommu(), since TPRs
>    already provide DMA protection.
> - Tear down PMRs during intel_iommu_init() when TPRs are active,
>    while PMRs are redundant with TPR-based protection.
> - Call tboot_parse_dtpr_table() from parse_dmar_table() to disable
>    TPR regions early, allowing the kernel to manage DMA protection
>    prior to the OS boot.
> 
> Link: https://uefi.org/sites/default/files/resources/633933_Intel_TXT_DMA_Protection_Ranges_rev_0p73.pdf
> Link: https://cdrdv2-public.intel.com/315168/315168_TXT_MLE_DG_rev_017_7.pdf
> Signed-off-by: Michal Camacho Romero <michal.camacho.romero@intel.com>
> ---
>   drivers/iommu/intel/dmar.c  | 12 ++++++++++++
>   drivers/iommu/intel/iommu.c |  8 +++++++-
>   2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index d33c119a935e..3ab09117c79e 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -635,6 +635,8 @@ static int __init
>   parse_dmar_table(void)
>   {
>   	struct acpi_table_dmar *dmar;
> +	struct acpi_table_dtpr *dtpr;
> +	void                   *txt_heap;

Please avoid using extra whitespace before the variable name. Just use:

	void *txt_heap;

>   	int drhd_count = 0;
>   	int ret;
>   	struct dmar_res_callback cb = {
> @@ -670,6 +672,16 @@ parse_dmar_table(void)
>   		return -EINVAL;
>   	}
>   
> +	dtpr = tboot_get_dtpr_table(&txt_heap);
> +	if (dtpr) {
> +		/* TPR is enabled
> +		 * This will also tell not to establish IOMMU PMRs
> +		 */

Please use the standard kernel multiple-line comment format:

	/*
	 * TPR is enabled. This will also tell not to establish IOMMU
	 * PMRs.
	 */

> +		tboot_parse_dtpr_table(dtpr);
> +		iounmap(txt_heap);
> +	}
> +
> +	txt_heap = NULL;
>   	pr_info("Host address width %d\n", dmar->width + 1);
>   	ret = dmar_walk_dmar_table(dmar, &cb);
>   	if (ret == 0 && drhd_count == 0)
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 4d0e65bc131d..486693a13dc6 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2540,6 +2540,12 @@ static __init int tboot_force_iommu(void)
>   	if (!tboot_enabled())
>   		return 0;
>   
> +	/* If TPR is enabled we don't need to force IOMMU,
> +	 * TPR set by SINIT ACM will take care of DMA protection
> +	 */

Ditto.

> +	if (tboot_is_tpr_enabled())
> +		return 0;
> +
>   	if (no_iommu || dmar_disabled)
>   		pr_warn("Forcing Intel-IOMMU to enabled\n");
>   
> @@ -2597,7 +2603,7 @@ int __init intel_iommu_init(void)
>   		 * calling SENTER, but the kernel is expected to reset/tear
>   		 * down the PMRs.
>   		 */
> -		if (intel_iommu_tboot_noforce) {
> +		if (intel_iommu_tboot_noforce || tboot_is_tpr_enabled()) {
>   			for_each_iommu(iommu, drhd)
>   				iommu_disable_protect_mem_regions(iommu);
>   		}

With these nits fixed:

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
