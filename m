Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3CC1C7017
	for <iommu@lists.linux.dev>; Mon, 19 May 2025 02:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747620863; cv=none; b=IDcs7d5lVGkr2toBvzNWA+VLdaWKxE+B8vWbWGZVTos7Ddwk6C9KFClJz4Zv2nn/+ocv7IXNbwABCv1i/ncem+OW00+dLkwxl+7/eJmSKOUc4oFMo191AnqzH2tetHQ598U1c/VUD3ntU4EI9ISlW79UYa6kAhaX+L3MPDsV39A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747620863; c=relaxed/simple;
	bh=hxcNNXpv2e+om893XHnEuV48ipYlUBPBPhOp1Kh1Ws8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZUf+cuJP1/py7tEtki/aKlrM8xZis9ZJnBEQKXIfPikrKGbHMzaqYZQIwU+8fpWacfvffbMC8IgZnhTqHoFEJxyaHA8GQXSO0Jh61MKTuq7f4BFOcwWC1b1qIj4Dk5d9bxCFMv3KaZ4mcSAwaR9/ZTeN60EL8pSrH3uKqawG6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OrONBe0O; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OrONBe0O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747620862; x=1779156862;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hxcNNXpv2e+om893XHnEuV48ipYlUBPBPhOp1Kh1Ws8=;
  b=OrONBe0OjMavEZfJIY+tHPm8MWR0HkVrDWZQDjL0v1shveUyNpAbqqqh
   plldk/gLWhb5L8I+omxVBDRI58MEXrWxQW3jTrvf2baKMs3ftQvRDzoKv
   QNAedGhhoj2WcfbRhhVQDehMym5fTAvETJ1cwZ9+nLRIKZNDNJBIq/fhq
   cnBPkb09AjtQm3yNnTvG17jpaD9SBRZhRDaFzMcR3LycYiAjG3nnEAdLp
   EZ1is6KM+QElYCOj4MDbQlt8dY/e1jtnvxY8hfCoIM84pwPQiOhdbiSOa
   8XGlxTsyn+5/NgSjTSddAf4l3llk2c3bwqVxAP7+j2fEzeqvu1T5d5FVT
   A==;
X-CSE-ConnectionGUID: u6zVOvpoR6SHTuzUQtDqrw==
X-CSE-MsgGUID: o3UIgZS8T7GakW+98vNFDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="49205906"
X-IronPort-AV: E=Sophos;i="6.15,299,1739865600"; 
   d="scan'208";a="49205906"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 19:14:21 -0700
X-CSE-ConnectionGUID: 2jfdCCgwQ9iuZdrmcULKSQ==
X-CSE-MsgGUID: iwEOnYSbT76c9or0o+eocw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,299,1739865600"; 
   d="scan'208";a="140251789"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 19:14:19 -0700
Message-ID: <d6a25c70-3b4b-4832-97e6-2c1915ffa373@linux.intel.com>
Date: Mon, 19 May 2025 10:09:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iommu: intel: Disable TPRs to allow Kernel for the
 further DMA usage
To: "Camacho Romero, Michal" <michal.camacho.romero@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "Fedko, Artem" <artem.fedko@intel.com>,
 "Mowka, Mateusz" <mateusz.mowka@intel.com>,
 "Pawlicki, AdamX" <adamx.pawlicki@intel.com>,
 "Michalak, BartlomiejX" <bartlomiejx.michalak@intel.com>
References: <IA1PR11MB77556710DD26474B9B857408AF93A@IA1PR11MB7755.namprd11.prod.outlook.com>
 <IA1PR11MB7755A29CB6DE24B485C71F31AF93A@IA1PR11MB7755.namprd11.prod.outlook.com>
 <IA1PR11MB7755B7E81479BC3BC5B11281AF93A@IA1PR11MB7755.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <IA1PR11MB7755B7E81479BC3BC5B11281AF93A@IA1PR11MB7755.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/16/25 17:19, Camacho Romero, Michal wrote:
> In order to enable DMA for the Linux Kernel, working on the newest Intel 
> CPUs versions,
> 
> it is necessary to disable TPR memory protection, set earlier by the 
> Intel's SINIT ACM module.

Can you please explain what's the impact if TPR memory protection is not
disabled?

> 
> Disable also the Intel IOMMU enforcement, in the situation, where
> 
> the TPRs have been activated.

Can you please explain the reason why ...?

> 
> This patch depends on the 2 other patches:
> 
> * [PATCH 2/3] tboot: Define DTPR ACPI Table parsing function
> 
> * [PATCH 1/3]: ACPICA: actbl1.h: Add support for the new ACPI Table: DTPR

I assume that all three patches are in a series. So no need to mention
this in the commit message.

> Signed-off-by: Michal Camacho Romero michal.camacho.romero@intel.com 
> <mailto:michal.camacho.romero@intel.com>
> 
> ---
> 
> drivers/iommu/intel/dmar.c  | 8 ++++++++
> 
> drivers/iommu/intel/iommu.c | 7 ++++++-
> 
> 2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> 
> index e540092d664d..616db46c3a12 100644
> 
> --- a/drivers/iommu/intel/dmar.c
> 
> +++ b/drivers/iommu/intel/dmar.c
> 
> @@ -635,6 +635,7 @@ static int __init
> 
> parse_dmar_table(void)
> 
> {
> 
>             struct acpi_table_dmar *dmar;
> 
> +          struct acpi_table_dtpr *dtpr;
> 
>             int drhd_count = 0;
> 
>             int ret;
> 
>             struct dmar_res_callback cb = {
> 
> @@ -670,6 +671,13 @@ parse_dmar_table(void)
> 
>                         return -EINVAL;
> 
>             }
> 
> +          dtpr = tboot_get_dtpr_table();
> 
> +          if (dtpr) {
> 
> +                      //TPR is enabled
> 
> +                      //This will also tell not to establish IOMMU PMRs
> 
> +                      tboot_parse_dtpr_table();
> 
> +          }

Why do you want to put DPPR ACPI table parsing logic in this helper?

> 
> +
> 
>             pr_info("Host address width %d\n", dmar->width + 1);
> 
>             ret = dmar_walk_dmar_table(dmar, &cb);
> 
>             if (ret == 0 && drhd_count == 0)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> 
> index cb0b993bebb4..a0250a321b5e 100644
> 
> --- a/drivers/iommu/intel/iommu.c
> 
> +++ b/drivers/iommu/intel/iommu.c
> 
> @@ -3074,6 +3074,11 @@ static __init int tboot_force_iommu(void)
> 
>             if (!tboot_enabled())
> 
>                         return 0;
> 
> +          //If TPR is enabled we don't need to force IOMMU,
> 
> +          //TPR set by SINIT ACM will take care of DMA protection

Please use

	/* xxx */

comment style in this file to keep it with the existing ones.

> 
> +          if (tboot_is_tpr_enabled())
> 
> +                      return 0;
> 
> +
> 
>             if (no_iommu || dmar_disabled)
> 
>                         pr_warn("Forcing Intel-IOMMU to enabled\n");
> 
> @@ -3131,7 +3136,7 @@ int __init intel_iommu_init(void)
> 
>                          * calling SENTER, but the kernel is expected to 
> reset/tear
> 
>                          * down the PMRs.
> 
>                          */
> 
> -                       if (intel_iommu_tboot_noforce) {
> 
> +                      if (intel_iommu_tboot_noforce || 
> tboot_is_tpr_enabled()) {
> 
>                                     for_each_iommu(iommu, drhd)
> 
>                                                 
> iommu_disable_protect_mem_regions(iommu);
> 
>                         }
> 
> -- 
> 
> 2.43.0
> 

Thanks,
baolu
