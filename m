Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE2D1B11F8
	for <iommu@lists.linux.dev>; Thu,  4 Jul 2024 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103405; cv=none; b=D0hw+cmnHPq9zScZyG2hL1eKersTq92X64gIG9jUcsYQHOmcZdUww4rkZn2nawVrb6q6msAObKF/Or7Nf1ifRE8ArCLfg3A2N3JIEScdPXOkykPs0dAb1SpvAYGhalFFMadSNWk6sKcN0ke/o6t0OkAu068MIBKMIqsYWZoK+jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103405; c=relaxed/simple;
	bh=aqW9gjTA95ciOjlGYFV47g4h2LobgpnPA7tQQS4gw9E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gSLxwRUoin1hQet5gYUDUECYP65S3I0tNKOThXIorbUhZzYdehlEpo1VOCvjXWA1vd0BWVoxNWqisGGy95ASGRBY2uPmG8MUKD7FpyzAlfGOYiVV/foiQg1J2CHiOu+Rjnb8hwQgbQdBhihIrncVfPz1YvvnWWzZ/vG+J1L2MOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4noqXJA; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4noqXJA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720103404; x=1751639404;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aqW9gjTA95ciOjlGYFV47g4h2LobgpnPA7tQQS4gw9E=;
  b=S4noqXJATjmN/83NyT6r6LmvT/TVl2t32JfT2GgKxcELmgC2MBwu1VXS
   1t59jiuz2xS07757Fj4wK2le1ep2cnxDcH4DexGEtcPDd/k4PaXBhLRHg
   3eg4NHRbanBCPI6b7+4u07EzouUE4eEVSQS5GxoPXAbtnQFBBZrVZSo5X
   XSXGH6H2Rb/P0fHu5PuMUyFvHFPhdyA/FQmdp18Q5FAWJWlU2f4uKuUfO
   hsHJun+X258SRVsdxlLJhvloFPcA5247SlKCccRRp/h4gVu2aSRbBNb9E
   DATVYfYDtJA+202yu7eNq49vxi3iO7g9XtRJ89Fj3XhNXr+Rcsg829rkT
   w==;
X-CSE-ConnectionGUID: WE41B1UaSB+fF5RxiEFHTw==
X-CSE-MsgGUID: SYGmcpVkRKy7NN8KWiewSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17522279"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17522279"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 07:25:00 -0700
X-CSE-ConnectionGUID: up9qyxkjSw6G1sTT0A8oiw==
X-CSE-MsgGUID: KX0cngofS5azc7TaKb/4Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="84166564"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 07:24:54 -0700
Message-ID: <f273615a-ebbd-488c-a301-e5cefc0715b1@linux.intel.com>
Date: Thu, 4 Jul 2024 22:24:52 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, catalin.marinas@arm.com,
 kernel-team@android.com, Yi Liu <yi.l.liu@intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
 Jason Wang <jasowang@redhat.com>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, ath10k@lists.infradead.org,
 ath11k@lists.infradead.org, iommu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/21] iommu: Refactoring domain allocation interface
To: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <172009858593.2049787.5200500337719932334.b4-ty@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <172009858593.2049787.5200500337719932334.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/4 22:18, Will Deacon wrote:
> On Mon, 10 Jun 2024 16:55:34 +0800, Lu Baolu wrote:
>> The IOMMU subsystem has undergone some changes, including the removal
>> of iommu_ops from the bus structure. Consequently, the existing domain
>> allocation interface, which relies on a bus type argument, is no longer
>> relevant:
>>
>>      struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
>>
>> [...]
> Applied a few of these to iommu (iommufd/paging-domain-alloc), thanks!
> 
> [01/21] iommu: Add iommu_paging_domain_alloc() interface
>          https://git.kernel.org/iommu/c/a27bf2743cb8
> [02/21] iommufd: Use iommu_paging_domain_alloc()
>          https://git.kernel.org/iommu/c/26a581606fab
> [03/21] vfio/type1: Use iommu_paging_domain_alloc()
>          https://git.kernel.org/iommu/c/60ffc4501722
> [04/21] vhost-vdpa: Use iommu_paging_domain_alloc()
>          https://git.kernel.org/iommu/c/9c159f6de1ae
> [05/21] drm/msm: Use iommu_paging_domain_alloc()
>          https://git.kernel.org/iommu/c/45acf35af200
> 
> [10/21] wifi: ath10k: Use iommu_paging_domain_alloc()
>          https://git.kernel.org/iommu/c/d5b7485588df
> [11/21] wifi: ath11k: Use iommu_paging_domain_alloc()
>          https://git.kernel.org/iommu/c/ef50d41fbf1c
> 
> [14/21] RDMA/usnic: Use iommu_paging_domain_alloc()
>          https://git.kernel.org/iommu/c/3b10f25704be
> [15/21] iommu/vt-d: Add helper to allocate paging domain
>          https://git.kernel.org/iommu/c/9e9ba576c259

Will, the patch [15/21] has already been included in my VT-d update pull
request. I have also addressed Yi's comment in that patch. So can you
please remove it from this branch?

Thanks,
baolu
