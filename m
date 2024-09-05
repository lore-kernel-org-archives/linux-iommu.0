Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F2818950B
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521476; cv=none; b=SQrLeyn4FeWSfOZzyDPtTyPqWDrXtBZ/x4iIRxPcHgL/e+vbYNu++E3fUY6LbBxy0IxaDFDlNoNpPaiZfKULSg5vpEnbJLVF0Y7j7H74WjqQuZVyO0lzsWeWHQ02OUokkgjke61c9h5F5qx3eItZoroeu9z6rPvPIz7/SkcJKkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521476; c=relaxed/simple;
	bh=0tEXOCRmzQvGMaQ2Hf74owmJ+GaCBBkJPS65VLgWbYU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WyDfxPfAiPAKO84k9fzbJxSbXG6NMuDkv1ZcKqtajxqJuxTlm5xpUcf1Zqyjuo/Ldkm9Vzx0jvewb25GUCWqRxiMVogvACKPgI1WKK7tWD9CxMequOKzLSo+yaR02aV6lN8X2BDjIN1hLZM/skst5t5Xi5nxBXgcIlD2RWFvK3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNCyCSYJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNCyCSYJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725521476; x=1757057476;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0tEXOCRmzQvGMaQ2Hf74owmJ+GaCBBkJPS65VLgWbYU=;
  b=NNCyCSYJDYzNCAvjDrsV5GWoE5aI72INGU43HLRAqr/fUadgzRSAulrM
   l9xlcbVr42yd3FaeZuo4WSP2LT0ZMb0x1jgvFajIX2o9pNeAnxwBal5mV
   Wku1SFtPg65RHBAN6otIwMbcu9IqRiSgGrWSEkbEELQKHVxde8O4Q1wBv
   92bEmsBsUKOwqFEmDFiMU3PXLcR9FVotDcBuza3J3VpYFnwfscgNrhuuy
   KRCXh+ZLKX000HPE25DiChP8X4NAiEa7VrWaTzaRhsAOwW0MoqH80ZsJX
   iYVIuHle3dBoR4+ODVZ9hlY2bYJJwh1Ub/Vn4qB+p4BW33Z+MGgxW5AXe
   Q==;
X-CSE-ConnectionGUID: ucfxa7pHQnuUiMP8cuwDNQ==
X-CSE-MsgGUID: hjOqk4/KSTWahi7aIVOtoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="41692520"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="41692520"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 00:31:15 -0700
X-CSE-ConnectionGUID: fjBK3sV2TWOBdAa43gJwcA==
X-CSE-MsgGUID: E/XBXnZfTTyYntLIrP4IBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="70451136"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.229.145]) ([10.124.229.145])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 00:31:12 -0700
Message-ID: <45a3ae40-6e59-43b4-ae57-d159bd2b54df@linux.intel.com>
Date: Thu, 5 Sep 2024 15:31:08 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/amd: Add kernel parameters to limit V1 page-sizes
To: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Vasant Hegde <vasant.hegde@amd.com>
References: <20240905072240.253313-1-joro@8bytes.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240905072240.253313-1-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/5 15:22, Joerg Roedel wrote:
> From: Joerg Roedel<jroedel@suse.de>
> 
> Add two new kernel command line parameters to limit the page-sizes
> used for v1 page-tables:
> 
> 	nohugepages     - Limits page-sizes to 4KiB
> 
> 	v2_pgsizes_only - Limits page-sizes to 4Kib/2Mib/1GiB; The
> 	                  same as the sizes used with v2 page-tables
> 
> This is needed for multiple scenarios. When assigning devices to
> SEV-SNP guests the IOMMU page-sizes need to match the sizes in the RMP
> table, otherwise the device will not be able to access all shared
> memory.
> 
> Also, some ATS devices do not work properly with arbitrary IO
> page-sizes as supported by AMD-Vi, so limiting the sizes used by the
> driver is a suitable workaround.
> 
> All-in-all, these parameters are only workarounds until the IOMMU core
> and related APIs gather the ability to negotiate the page-sizes in a
> better way.
> 
> Signed-off-by: Joerg Roedel<jroedel@suse.de>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 17 +++++++++++------
>   drivers/iommu/amd/amd_iommu.h                   |  1 +
>   drivers/iommu/amd/amd_iommu_types.h             |  4 ++++
>   drivers/iommu/amd/init.c                        |  8 ++++++++
>   drivers/iommu/amd/io_pgtable.c                  |  2 +-
>   5 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 09126bb8cc9f..6d6630aec46c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -333,12 +333,17 @@
>   					  allowed anymore to lift isolation
>   					  requirements as needed. This option
>   					  does not override iommu=pt
> -			force_enable - Force enable the IOMMU on platforms known
> -				       to be buggy with IOMMU enabled. Use this
> -				       option with care.
> -			pgtbl_v1     - Use v1 page table for DMA-API (Default).
> -			pgtbl_v2     - Use v2 page table for DMA-API.
> -			irtcachedis  - Disable Interrupt Remapping Table (IRT) caching.
> +			force_enable    - Force enable the IOMMU on platforms known
> +				          to be buggy with IOMMU enabled. Use this
> +				          option with care.
> +			pgtbl_v1        - Use v1 page table for DMA-API (Default).
> +			pgtbl_v2        - Use v2 page table for DMA-API.
> +			irtcachedis     - Disable Interrupt Remapping Table (IRT) caching.
> +			nohugepages     - Limit page-sizes used for v1 page-tables
> +				          to 4 KiB.

Intel iommu driver has a similar option 'intel_iommu=sp_off'

	sp_off [Default Off]
		By default, super page will be supported if Intel IOMMU
		has the capability. With this option, super page will
		not be supported.

Is it possible to consolidate these two into a single
"iommu.nohugepages=1"?

> +			v2_pgsizes_only - Limit page-sizes used for v1 page-tables
> +				          to 4KiB/2Mib/1GiB.
> +
>   
>   	amd_iommu_dump=	[HW,X86-64]
>   			Enable AMD IOMMU driver option to dump the ACPI table

Thanks,
baolu
