Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB593C13E0
	for <iommu@lists.linux.dev>; Wed,  7 Oct 2026 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791357117; cv=none; b=FVpvJ9Z4hjghDIBUOuKH8gFX/pFHczAfsCS+CiudTK08Bl0h3xtTjUk+rGF1RLAlbUulTPx2zoUtVofySRfSveLGPvdBlpUZPnmhSRe8HzdRLnF9QVeD6tv4v7fba9AeAI3Kn05k0TAS+rabi8h2+SyDxaqo0yJV7/6MR+ymEcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791357117; c=relaxed/simple;
	bh=ZrS80mSPT9EKKzjMKHB5yxHkIhIe50Ga/PdOlkjhTkM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HURjp2Awpn5AxR5DxZiemFemABmfPsYb9Pzb8FtFu3U+nOL2hLI5D3pt5vJAbSYn9hRoIwf72kvCto/92AKeJSx4WKYKz9PHmbBcQGpV8vcbSmX+0idawo2SbxXVbTFrlnZDp8PYxUmt3AkpXvYdt88KBC2BVTAB9IhSPZoztkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DdoDp3xA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DdoDp3xA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791357114; x=1822893114;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZrS80mSPT9EKKzjMKHB5yxHkIhIe50Ga/PdOlkjhTkM=;
  b=DdoDp3xAl9+NioqGf98Rl6drA6Tre3YAMcyTIG2cRa6wJ4fQsqQzh7Lz
   7bZPTWo3IO/0T+yeXeYs79t3lAIcKMVeV4O4Bri0+Zuh7RfiqWG0abpoQ
   WfSPj3QawrT7KKw70Wmf8VwWLP0sykAvALZQ5kDOpOWsuUxLqV6Tvuj2O
   1tIgcpowMKqp1jULA3ZdPx1jLkoJ5wxHPIS2h9Y0Me486k8ZkaU5dhTCH
   nNfcJZ6AWJBVPs+duxEGjqxTaBVTYSabrgaAKUsXtyh7iJO0hOQTFvtbm
   rBgZOnJgPSNYw8FznT8ap0IXFggjwrOfsrl5HvHLdi0MrgfpYf2GKSB04
   w==;
X-CSE-ConnectionGUID: kQcoChGATw6NjRlCW9f+ig==
X-CSE-MsgGUID: Y1ArlBIfQPqntxX0af8lPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="5398"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="5398"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 00:11:53 -0700
X-CSE-ConnectionGUID: tD/ODBe8RR61rg7frVPPeQ==
X-CSE-MsgGUID: M6ZIaecXSd+b90sJf91/Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="1456629"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.249.52]) ([10.124.249.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 00:11:51 -0700
Message-ID: <7f637b22-110b-4e49-b083-6062bcad37c4@linux.intel.com>
Date: Wed, 7 Oct 2026 15:11:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com,
 Michal Camacho Romero <michal.camacho.romero@intel.com>, x86@kernel.org,
 iommu@lists.linux.dev, tboot-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Mateusz Mowka <mateusz.mowka@intel.com>,
 Adam Pawlicki <adamx.pawlicki@intel.com>,
 Pawel Randzio <pawel.randzio@intel.com>
Subject: Re: [PATCH v4 2/2] iommu/vt-d: Disable PMRs and skip force-IOMMU when
 TXT TPRs are active
To: michal.camacho.romero@linux.intel.com, Ning Sun <ning.sun@intel.com>,
 Thomas Gleixner <tglx@kernel.org>
References: <c88f7c82-1b48-4ab2-95d6-73f920879f76@linux.intel.com>
 <20261001121229.1486711-1-michal.camacho.romero@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261001121229.1486711-1-michal.camacho.romero@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/2026 8:12 PM, michal.camacho.romero@linux.intel.com wrote:
> From: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
> 
> When Intel TXT Protection Regions (TPRs) are present in the DTPR table,
> hardware-level DMA protection is already enforced by the SINIT ACM.
> In this case:
> 
> - Skip forcing IOMMU enablement in tboot_force_iommu(), since TPRs
>    already provide DMA protection.
> - Tear down PMRs during intel_iommu_init() when TPRs are active,
>    while PMRs are redundant with TPR-based protection.
> - Call tboot_disable_tprs() from parse_dmar_table() to disable
>    TPR regions early, allowing the kernel to manage DMA protection
>    prior to the OS boot.
> 
> Link: https://uefi.org/sites/default/files/resources/633933_Intel_TXT_DMA_Protection_Ranges_rev_0p73.pdf
> Link: https://cdrdv2-public.intel.com/315168/315168_TXT_MLE_DG_rev_017_7.pdf
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Please drop this Reviewed-by tag. It was carried over from an earlier
version, and the changes are substantial enough that my previous review
no longer covers them.

> Signed-off-by: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
> ---
> Thanks for the careful review. Summary of how each point is handled:
> 
> Answer for Question No.1:
>     The DTPR handling is now invoked only after dmar_walk_dmar_table()
>     returns success. If DMAR parsing fails, parse_dmar_table() returns the error
>     and IOMMU initialization aborts before any TPR teardown, so the TPRs stay
>     active and DMA protection is retained. They are disabled only, if DMAR parse
>     succeeds.
> 
> Answer for Question No.2:
>     I've replaced tboot_parse_dtpr_table function with the tboot_disable_tprs(),
>     which is defined in the Kernel patch
>     "[PATCH v5 1/2] x86/tboot: Add support for parsing DTPR table and disabling TPRs".
>     It is void type function. It verifies now, both if the DTPR Table is
>     present and if TXT Heap exists. If not then function prints a proper warning
>     message and returns.
> 
> The rest of your suggestions (including the stale txt_heap = NULL cleanup) have
> been applied in the current patch version.
> 
> Regards,
> Michal Camacho Romero
> 
>   drivers/iommu/intel/dmar.c  | 18 ++++++++++++++++--
>   drivers/iommu/intel/iommu.c |  9 ++++++++-
>   2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index ba675b08cd20..e8ec2dfe3e33 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -672,8 +672,22 @@ parse_dmar_table(void)
>   
>   	pr_info("Host address width %d\n", dmar->width + 1);
>   	ret = dmar_walk_dmar_table(dmar, &cb);
> -	if (ret == 0 && drhd_count == 0)
> -		pr_warn(FW_BUG "No DRHD structure found in DMAR table\n");
> +	if (ret == 0) {
> +		/* After DMAR Table successful parsing disable TPRs if necessary */
> +		void __iomem           *txt_heap;
> +		struct acpi_table_dtpr *dtpr = tboot_get_dtpr_table(&txt_heap);
> +
> +		if (dtpr) {
> +			/*
> +			 * TPRs are enabled. This will also tell not to establish IOMMU
> +			 * PMRs. It is necessary to parse DTPR Table and disable active TPRs.
> +			 */
> +			tboot_disable_tprs(dtpr, &txt_heap);

I am confused about the timing here. TPRs are now disabled in
parse_dmar_table(), which is called from dmar_table_init() very early in
boot. However, the IOMMU does not actually enable DMA translation until
much later, in intel_iommu_init(). It may even be disabled via a boot
option.

What enforces DMA protection between the point where TPRs are disabled
and the point where the Intel IOMMU driver takes over by enabling DMA
translation?

The commit message says, "disable TPR regions early, allowing the kernel
to manage DMA protection prior to the OS boot", I find this difficult to
understand. Do you mind explaining it?

> +		}
> +
> +		if (drhd_count == 0)
> +			pr_warn(FW_BUG "No DRHD structure found in DMAR table\n");
> +	}
>   
>   	return ret;
>   }
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 2e3b3ab216f8..ce40b1bf0296 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2563,6 +2563,13 @@ static __init void tboot_force_iommu(void)
>   	if (!tboot_enabled() || intel_iommu_tboot_noforce)
>   		return;
>   
> +	/*
> +	 * If TPR is enabled we don't need to force IOMMU, TPR set by SINIT
> +	 * ACM will take care of DMA protection.
> +	 */
> +	if (tboot_is_tpr_enabled())
> +		return;

TPRs have already been explicitly disabled at this point, so how can
tboot_is_tpr_enabled() return true? Does it indicate that TPRs were
enabled before the OS booted, even though the OS has disabled them
during early boot?

> +
>   	if (!dmar_can_force_on(DMAR_FORCEON_TBOOT))
>   		panic("tboot: Failed to force IOMMU on\n");
>   
> @@ -2623,7 +2630,7 @@ int __init intel_iommu_init(void)
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
