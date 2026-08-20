Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF93307492
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 03:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787196506; cv=none; b=te/WYQshsIFND9a0BAfn1rtVTAZBqfZh0htGEgL3ta1/uoTLvxgvwACYphkb7944hIJU/whr5uIAoXwCxfxH0FjyXAyKNXlRGNEATt4NObotgfse1pgkfj+5MuBxWcDY9sRrqBhAu9zfS7vV2BmfZm19FB/flQNdyei5joUfEO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787196506; c=relaxed/simple;
	bh=l66RoNZoxubykSNB8dwIFKgoh8r1kPumIMo8gHnDz4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfe11fL20cmMQrMKNgIcwFjcC6puLUeIpb1hI7hFeUKf6RUir0piB63TrN20VyFNSEw420xkVg5/fSkc0FZenMlDXhpMChepjOBo46gUckF780MJRVYVIjmiX8swIIECRAfiZ8F7uSSg3WJogwxAmY5orgWIkONpgQWuU15MjQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0UxoRM7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0UxoRM7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787196505; x=1818732505;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l66RoNZoxubykSNB8dwIFKgoh8r1kPumIMo8gHnDz4w=;
  b=h0UxoRM7u6FuY18jUm3S5WOtT3WlAbylsw/TVjP2Hrhs13cAyhFTvVvC
   ZpM7qXS7aUX8WP10ZmP3YetlQUqdaPlfnTyTT9HfsI73qc7FuNNS8ViOn
   HAYd7Eam5TcDWI4cm87g0/q0PAno9LJ7/IBR84kUMgHAv4GKUih9ct9E2
   hPQdImvtRJqMqSv4+9j80wKtodV2RbIDGsQ03s79+aQIQZ6LgHSRQ129J
   sI5j/hRKef/UZwmRCcE58EzJMVETIovA1QJB8sDvsM7CEGL6vhDbwG4RS
   bR+ZYmizsYnopTRiWsy+wMDVHDb8rDjft5IV0dnrV95j/YbG4qyLTCxY1
   A==;
X-CSE-ConnectionGUID: V0WJhEscQq+bVe5aFL3jEQ==
X-CSE-MsgGUID: 6df9L84URZqll6m9ftBjXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="98315461"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="98315461"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 20:28:24 -0700
X-CSE-ConnectionGUID: ZkmBO/HrRWK4/fqFnwtY4g==
X-CSE-MsgGUID: 4iWXt2YvQDecwnEqtfnNFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="263161208"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 20:28:22 -0700
Message-ID: <d32d505b-5985-4139-86da-97d902c9aeb9@linux.intel.com>
Date: Thu, 20 Aug 2026 11:28:19 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iommu/vt-d: Disable PMRs and skip force-IOMMU when
 TXT TPRs are active
To: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>,
 Ning Sun <ning.sun@intel.com>, Thomas Gleixner <tglx@kernel.org>
Cc: Michal Camacho Romero <michal.camacho.romero@intel.com>, x86@kernel.org,
 iommu@lists.linux.dev, tboot-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Mateusz Mowka <mateusz.mowka@intel.com>,
 Adam Pawlicki <adamx.pawlicki@intel.com>,
 Pawel Randzio <pawel.randzio@intel.com>
References: <20260603114500.2771319-3-michal.camacho.romero@intel.com>
 <20260807101403.61259-1-michal.camacho.romero@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260807101403.61259-1-michal.camacho.romero@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/26 18:14, Michal Camacho Romero wrote:
> From: Michal Camacho Romero <michal.camacho.romero@intel.com>
> 
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
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Michal Camacho Romero <michal.camacho.romero@intel.com>
> ---
>   drivers/iommu/intel/dmar.c  | 13 +++++++++++++
>   drivers/iommu/intel/iommu.c |  9 ++++++++-
>   2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 767ec092accd..17c26d222253 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -635,6 +635,8 @@ static int __init
>   parse_dmar_table(void)
>   {
>   	struct acpi_table_dmar *dmar;
> +	struct acpi_table_dtpr *dtpr;
> +	void *txt_heap;
>   	int drhd_count = 0;
>   	int ret;
>   	struct dmar_res_callback cb = {
> @@ -670,6 +672,17 @@ parse_dmar_table(void)
>   		return -EINVAL;
>   	}
>   
> +	dtpr = tboot_get_dtpr_table(&txt_heap);
> +	if (dtpr) {
> +		/*
> +		 * TPR is enabled. This will also tell not to establish IOMMU
> +		 * PMRs.
> +		 */
> +		tboot_parse_dtpr_table(dtpr);
> +		iounmap(txt_heap);
> +	}
> +
> +	txt_heap = NULL;
>   	pr_info("Host address width %d\n", dmar->width + 1);
>   	ret = dmar_walk_dmar_table(dmar, &cb);
>   	if (ret == 0 && drhd_count == 0)
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 849d06dfe1ae..5bc6f2dd25c4 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2543,6 +2543,13 @@ static __init int tboot_force_iommu(void)

This patch doesn't apply cleanly on top of the recent mainline tree —
tboot_force_iommu() has been refactored by a recent merge. Please rebase
and re-post it after 7.3-rc1.

>   	if (!tboot_enabled())
>   		return 0;
>   
> +	/*
> +	 * If TPR is enabled we don't need to force IOMMU, TPR set by SINIT
> +	 * ACM will take care of DMA protection.
> +	 */
> +	if (tboot_is_tpr_enabled())
> +		return 0;
> +
>   	if (no_iommu || dmar_disabled)
>   		pr_warn("Forcing Intel-IOMMU to enabled\n");
>   
> @@ -2600,7 +2607,7 @@ int __init intel_iommu_init(void)
>   		 * calling SENTER, but the kernel is expected to reset/tear
>   		 * down the PMRs.
>   		 */
> -		if (intel_iommu_tboot_noforce) {
> +		if (intel_iommu_tboot_noforce || tboot_is_tpr_enabled()) {
>   			for_each_iommu(iommu, drhd)
>   				iommu_disable_protect_mem_regions(iommu);
>   		}

Thanks,
baolu
