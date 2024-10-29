Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E77A1DD543
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 04:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730176687; cv=none; b=MiS/lY3bKtlrcVb+WCfgDg3XKYvJn+++TJVBv48McfbnMyOxlqRG/z2I6F1KsXl4+AiesNYHGAtJ+WAU9m5Y42VDGhZ6K0fR7liEihZ/Hau5Mal//AgS2fHZkfDEs2SgSb36Er0VHoZhqfiLplTWB+zFQzYcA/KrDoniNE+nOUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730176687; c=relaxed/simple;
	bh=+BY6UlmGCPb3TEH+JRlaT3AKx6sgOOr8Q9OYPKYvmuc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hq6b5yjGjK6zshx+uP5Tn7aqkAtQrLkAUL10XjhRCCVrMl2sqA5Aqp5fTvuIsoVpv/t4q4BImjOLUFKIrfoO/OsXwwBZ4utiH4XRIg0RIx3A5CmIXE0+vGh+xijL3Ci7bKCKWfHrY6nhkEP7/JCZuf+iGl7qcuRtKcpFuCuwsoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cd2j+xEC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cd2j+xEC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730176686; x=1761712686;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+BY6UlmGCPb3TEH+JRlaT3AKx6sgOOr8Q9OYPKYvmuc=;
  b=Cd2j+xECSM+PvhmLxkoKmpAJMddb7Awukq9WXWTFgzi7/Bc3gSGrbQJy
   cPC2iFCo1H3u/ij6+LAQ+pz9jfnEVzC5oJKDXM0di8++4IqL2/joOcXjr
   sykxtlqt61YKjoH7uRAXjHTQUCBc1ZZenGLSxh/E3BsJ1bsucrrPBAH0m
   wnQ9TmDHO1L0InrVfTxOP2CyzlZfLd9uRQZiQbKeav6+1K6HvZtPQL2gH
   aU3rU15cxLxUzmhs5lmPinPjTkHJ4vrc/GXZJXFenalacIpImkfwBESpO
   NodIH0B/mCqvBKMLDleH7O+98+diKrCJ8Axro9wTOtLWMaTi8Ngr1KvMH
   g==;
X-CSE-ConnectionGUID: o6P81HLkTY+c460LxxOlFA==
X-CSE-MsgGUID: M2Fek8GfTkyTEZB0xoroAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="41193589"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="41193589"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 21:38:05 -0700
X-CSE-ConnectionGUID: IC4T4soxTnOYpVoS6XiDjw==
X-CSE-MsgGUID: QnVaFd02SZawUa1iWBQo1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="82160544"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 21:38:03 -0700
Message-ID: <ba234a15-2feb-4c52-83e1-e427010fc1fc@linux.intel.com>
Date: Tue, 29 Oct 2024 12:38:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] iommu/vt-d: Add domain_alloc_paging support
To: iommu@lists.linux.dev
References: <20241021085125.192333-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241021085125.192333-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/21 16:51, Lu Baolu wrote:
> The Intel iommu driver will now use the domain_alloc_paging callback and
> remove the legacy domain_alloc callback. This ensures that a valid
> device pointer is provided whenever a paging domain is allocated, and
> all dmar_domain attributes can be set up at the time of allocation.
> 
> Both first-stage and second-stage page tables can be used for a paging
> domain. Unless IOMMU_HWPT_ALLOC_NEST_PARENT or
> IOMMU_HWPT_ALLOC_DIRTY_TRACKING is specified during paging domain
> allocation, this driver will try to use first-stage page tables if the
> hardware is capable. This is assuming that the first-stage page table is
> compatible with both the host and guest kernels.
> 
> The whole series is also available on GitHub:
> https://github.com/LuBaolu/intel-iommu/commits/vtd-domain_alloc_paging-v2
> 
> Please help review and comment.
> 
> Change log:
> 
> v2:
>   - Make prepare_domain_attach_device() a specific helper to check
>     whether a paging domain is compatible with the iommu hardware
>     capability.
>   - Rename prepare_domain_attach_device() to paging_domain_compatible()
>     to make it more meaningful.
> 
> v1:https://lore.kernel.org/linux-iommu/20241011042722.73930-1- 
> baolu.lu@linux.intel.com/
> 
> Lu Baolu (7):
>    iommu/vt-d: Add domain_alloc_paging support
>    iommu/vt-d: Remove unused domain_alloc callback
>    iommu/vt-d: Enhance compatibility check for paging domain attach
>    iommu/vt-d: Remove domain_update_iommu_cap()
>    iommu/vt-d: Remove domain_update_iommu_superpage()
>    iommu/vt-d: Refactor first_level_by_default()
>    iommu/vt-d: Refine intel_iommu_domain_alloc_user()
> 
>   drivers/iommu/intel/iommu.h  |   4 +-
>   drivers/iommu/intel/iommu.c  | 328 +++++++----------------------------
>   drivers/iommu/intel/nested.c |   2 +-
>   drivers/iommu/intel/pasid.c  |  28 +--
>   4 files changed, 64 insertions(+), 298 deletions(-)

Queued for v6.13.

--
baolu
