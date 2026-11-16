Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794799898;
	b=Q9bAxNkcw7G/zy/RLE/AelgMO4HYPA5hFiLtuJS1LK0iGADA7C9Si67G3GF0CVai6Eew
	 rn1Cq++CifwpOYMYAriX1OLf6SdhCLOj4VVA3xXO6znwdj6NYvhdQH1jJyCzuey3u+sdq
	 jD/XoEYeFGONdzEP0eFxjWX90Y8irZlunvlYHdmE8yGjwXAiMTWT3UxWPodv6UAveq5p7
	 /rNMUghlzljh08oqqDEQjwefaUVDzQOPO0isIbiAYQKwHXZUoWY9cuiLsbMarXtwAz2fL
	 oF+h7K8o4YrZXQQkbREvia59efNx9RtoUpiNvnKZnXGJ7Af85t/cKpw+BUpWUX2hPjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794799898;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=pGgUABsNoxr3lMr42Lg/Dv10ONV9Iv1MysSuC98ImUg=;
	b=0krjumtMe0eDEZnZPCaVqHSI7Rp4F1HXFZijuPMID4WCySi2CvFuyC2I3m+u7m4wLMiV
	 CQ1jhK0AV46VwQsutDh6rx86avQFpd/aRo1GoxlzqhixmdfqbPfR8V9sDm6U45rYNq7H5
	 7q+MzNthoV3K+9w2CMMLM/aDwdxCPivjto40eSOlKXe6cYTA7of1dzCcIlAx2mfUg36P5
	 3c2dJhzUBBA8kZzrUKTfn3tZ/muYxVLJ3lB8Oho6sitn0wZdE79J770ZKuFhXcqURc9Rv
	 CZ9ToveDd1s7Oj3n8mm1OCTfUUzFiOgOX03wvzoGd139stdH8OHzat1OI1OTbf7ScXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WFbm1n7u;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2D2606A31F
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 03:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A2D2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WFbm1n7u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794799898; x=1826335898;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oes9flJ0JSpo5x3wjxFPFFH+FdhIg1fmD+pwTGOuot4=;
  b=WFbm1n7upC67HiIEMz/ANC0IJsC/R73jqniRmajAN031SY7ExSjUiMX6
   IzbcDu9Dj4WN7750PSQiIx9vfItJWtnZALurpMuMEcimOdzseffEO3sMp
   Zqm2tEk4jF3VFeW75dySL2+0+vff26lbUSPVmvSApJrH74HtJsSSFI32i
   ac8RjzXA5Knn9BpCxAzikkCgfILEFngW/EJdOjXoIm68Lzc/M13dxALTw
   MQ2a54NpUTtreOdfW3owDWOAifjT7uIRPhCWINsijvZtTIbTvneuxYTvf
   4L3TwcRohT29Ezh3H2LjVVNAasAW2IfyFot/96YBUbh0G3TS5DwSZKElL
   w==;
X-CSE-ConnectionGUID: qWc8rwqhRMGNk8l0IbWY7A==
X-CSE-MsgGUID: hmaJmIorQ8eQj+wZg2CV7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3541504"
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="3541504"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 19:31:37 -0800
X-CSE-ConnectionGUID: U3CPZAHtQJOFgrVN9p5TRw==
X-CSE-MsgGUID: S4IDXWZYQEaFRwmBtWMK9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="11217156"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.249.52]) ([10.124.249.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 19:31:32 -0800
Message-ID: <57c85edf-8400-4b45-9a64-5eddc0d29134@linux.intel.com>
Date: Mon, 16 Nov 2026 11:31:29 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>,
 Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>,
 Ankit Soni <Ankit.Soni@amd.com>, Nicolin Chen <nicolinc@nvidia.com>,
 John Starks <dev@jstarks.net>
Subject: Re: [PATCH v7 10/18] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
To: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>
References: <20261110040828.1774343-1-skhawaja@google.com>
 <20261110040828.1774343-11-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261110040828.1774343-11-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/2026 12:08 PM, Samiullah Khawaja wrote:
> During boot fetch the preserved state of IOMMU unit and if found then
> restore the state.
> 
> - Reuse the root_table that was preserved in the previous kernel.
> - Reclaim the domain ids of the preserved domains for each preserved
>    devices so these are not acquired by another domain.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.c      |  57 ++++++++++---
>   drivers/iommu/intel/iommu.h      |  14 ++++
>   drivers/iommu/intel/liveupdate.c | 139 +++++++++++++++++++++++++++++++
>   3 files changed, 197 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 6c86c155d12b..a83971368bef 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -987,6 +987,8 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
>   
>   static void release_dmar_iommu(struct intel_iommu *iommu)
>   {
> +	intel_iommu_handle_drhd_restore_failure(iommu);
> +
>   	/*
>   	 * All iommu domains must have been detached from the devices,
>   	 * hence there should be no domain IDs in use.
> @@ -1452,7 +1454,7 @@ static void intel_iommu_init_qi(struct intel_iommu *iommu)
>    * Returns 0 when the ID is reserved, was already reserved, or cannot be
>    * re-assigned, and a negative errno for a genuine allocation failure.
>    */
> -static int reserve_domain_id(struct intel_iommu *iommu, int did)
> +int reserve_domain_id(struct intel_iommu *iommu, int did)
>   {
>   	int ret;
>   
> @@ -1743,12 +1745,16 @@ static int copy_translation_tables(struct intel_iommu *iommu)
>   
>   static int __init init_dmars(void)
>   {
> +	struct iommu_hw_ser *iommu_ser;
>   	struct dmar_drhd_unit *drhd;
>   	struct intel_iommu *iommu;
>   	int ret;
>   
>   	for_each_iommu(iommu, drhd) {
> +		iommu_ser = iommu_get_restored_state(iommu->reg_phys,
> +						     IOMMU_SER_TYPE_INTEL);
>   		if (drhd->ignored) {
> +			intel_iommu_handle_drhd_restore_failure(iommu);
>   			iommu_disable_translation(iommu);
>   			continue;
>   		}
> @@ -1766,7 +1772,9 @@ static int __init init_dmars(void)
>   		}
>   
>   		intel_iommu_init_qi(iommu);
> -		init_translation_status(iommu);
> +
> +		if (!iommu_ser)
> +			init_translation_status(iommu);
>   
>   		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
>   			iommu_disable_translation(iommu);
> @@ -1775,14 +1783,18 @@ static int __init init_dmars(void)
>   				iommu->name);
>   		}
>   
> -		/*
> -		 * TBD:
> -		 * we could share the same root & context tables
> -		 * among all IOMMU's. Need to Split it later.
> -		 */
> -		ret = iommu_alloc_root_entry(iommu);
> -		if (ret)
> -			goto free_iommu;
> +		if (iommu_ser) {
> +			intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);

What happens if the incoming kernel is booted with intel_iommu=off?

intel_iommu_init() calls intel_disable_iommus() before reaching this
restore path. A preserved device may still be issuing DMA, which would
then bypass translation.

Could we detect preserved IOMMUs and force VT-d on in that case? We
should also ensure that the ACS configuration for preserved devices and
their upstream bridges remains consistent with the previous kernel.

Thanks,
baolu
