Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339F837D12D
	for <iommu@lists.linux.dev>; Fri,  4 Sep 2026 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788488400; cv=none; b=HZ/y9vfkYpOGFo2QMG5+YvObg7L0pOvd1LeA9QdB2bIKTv+M0FKjm5FedqyNpd3IebL7RQoaf69OBBbQCInwkYKLiWNd0Q46DoR6dVp4w8gATsZfogSBDfvbMDxg4T7u2LcKEwSnfeMhaZ8X383b10S4v3eH1Zvb5h5MTdoZYIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788488400; c=relaxed/simple;
	bh=GMAt7/a+tdHdEzK/y3OcB7bBupcUsL1GPbLyngMocjs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ouoJHHGE/XSPIiPkRKyKVVkruV3wTgkkZi+st8aOm4hl+S6eXI0u5OiQECKVTgCughOUDWmEPULUtL/Xbo+S2D3S9kdWFIogC0Ln1Psi3ZJTxdpT0SvyslKN/2QzZ/J7m4jPNIfjlv9iAhwg2ReHsE+mT6dIDKmF4Rlvnc4g3Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UGfHiI5w; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UGfHiI5w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788488398; x=1820024398;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GMAt7/a+tdHdEzK/y3OcB7bBupcUsL1GPbLyngMocjs=;
  b=UGfHiI5w8A8yHEpoxLVG2nlg9aiEOqaca7lB9jZaCLT9iwoezC37t3H1
   Frt2cDZHlea4lc0mOFlRwvxFE4R4WwdjeORnvPpNa3alJnHYNBmW7J61P
   L6rbK/VYdBAMKO68z07HH/jJ67bYa5tMaegXCLhW1diij9RVgxhxxLUG1
   5TiOp33obKH0az4Sk/izs2VIxgG1Yk4SdmgrUXVpAgFjB6uHCKQ+ihoS8
   TR1ehe6sQ/9ET9PViyyl/+pdU0MGF4EKpQETDe1PLbSfX+0BJlcramFaf
   ykGHNhktePMts7ZpgzlIDtaris5vE3Yg1YZLMrdiZ73LULP5RgkVpuykR
   w==;
X-CSE-ConnectionGUID: 71aJLQmlQ4OMYxGSNYuqew==
X-CSE-MsgGUID: VwOl7PDOSm2X9n7QHknYoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="111759994"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="111759994"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:19:57 -0700
X-CSE-ConnectionGUID: VF9L+YoMQ1+jKA3Fy+qICg==
X-CSE-MsgGUID: LJeqktqwQoqI4fGBOSMGjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="270431961"
Received: from unknown (HELO [10.238.1.188]) ([10.238.1.188])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:19:55 -0700
Message-ID: <c88f7c82-1b48-4ab2-95d6-73f920879f76@linux.intel.com>
Date: Fri, 4 Sep 2026 10:19:53 +0800
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
Subject: Re: [PATCH v3 2/2] iommu/vt-d: Disable PMRs and skip force-IOMMU when
 TXT TPRs are active
To: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>,
 Ning Sun <ning.sun@intel.com>, Thomas Gleixner <tglx@kernel.org>
References: <d32d505b-5985-4139-86da-97d902c9aeb9@linux.intel.com>
 <20260903093353.415170-1-michal.camacho.romero@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260903093353.415170-1-michal.camacho.romero@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/2026 5:33 PM, Michal Camacho Romero wrote:
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
> Signed-off-by: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
> ---
>   drivers/iommu/intel/dmar.c  | 13 +++++++++++++
>   drivers/iommu/intel/iommu.c |  9 ++++++++-
>   2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index ba675b08cd20..c98a44487706 100644
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

What happens if parse_dmar_table() returns failure after this call?
That would mean TPR teardown happens even if DMAR parsing later fails
and returns error. Is that the intended behavior (i.e., parse/disable
TPR regardless of whether DMAR is ultimately usable)?

Also, does tboot_get_dtpr_table() become a no-op and return NULL when
tboot is not active? This is important, since it is called
unconditionally on every boot.

> +	if (dtpr) {
> +		/*
> +		 * TPR is enabled. This will also tell not to establish IOMMU
> +		 * PMRs.
> +		 */
> +		tboot_parse_dtpr_table(dtpr);

Can this fail? If yes, why is there no error handling?

> +		iounmap(txt_heap);

txt_heap is not used in the IOMMU driver. Why map it inside a hidden
helper call and then unmap it here?

> +	}
> +
> +	txt_heap = NULL;

txt_heap is never used after this line, so this assignment is dead code?

>   	pr_info("Host address width %d\n", dmar->width + 1);
>   	ret = dmar_walk_dmar_table(dmar, &cb);
>   	if (ret == 0 && drhd_count == 0)
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
