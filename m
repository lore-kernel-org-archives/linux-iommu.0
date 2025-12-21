Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0346223339
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 08:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766304619; cv=none; b=GTtmbV9/dhj+IF4dGYEgFMf+OT3RcukPlArQT7T0lzwNdpmTs5Owqi8X4DykcOvpbiPUnZnmHOz90n7Bwb2K9QOXMFJI3OgaV3EkKkUS7t/RquVjc2bpvqJtE5EkEmJHxo5gcupBagO0lQNyc1ivS9mH4ztymFHNgg/3zklgOnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766304619; c=relaxed/simple;
	bh=WAByElyEPPQAjfaOrFfgD/YdUVi6JRAJ639d+WI2beg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQ9vzZZFscjAQZzmDO44ueuQHByuuVGm0GJNU82o3LYXjz6v0nGAbgKTB1MEGeWAFGTfSrz+suBV5euz7nb4yRbzvBWUgzYTiZOl9nmZEttvmWqh+8R/HViy3NDG600XQGAoHkipfS0X5FuYPf7QAtw+mjUaG0dOQQwK8gDCSpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRooDuEG; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRooDuEG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766304617; x=1797840617;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WAByElyEPPQAjfaOrFfgD/YdUVi6JRAJ639d+WI2beg=;
  b=gRooDuEGr4dj/RDWRvWlGz3K8Q8lkNm/XLu5v+Mp8L2tdIeTbhH3j3R1
   TSjrvJKur7P0CeOFrvbG+fITodFw7mkdC4ihE9IE9KXWdX50wPK9cnluL
   a8oyt4KFMdi6h+1A4/4sKjbTO7RVB/QZSOCjeXD7EiUqdNjnB5xItBi/K
   muid9nc95nlmj5Ce96cbj+ixKtt90Cc0FfP3FXL41UgNivx2Jlzp7vEtM
   NQKF2b0tqyfcmLxrSqvuJQDQXO4yY4n0rcCQGg7G7lKl1b00DHoVS1SU8
   VdQl/v1lWnsNTbItdSDpolii9BzU8t/LowjnU+19ToKHfYpf47SCI5w96
   Q==;
X-CSE-ConnectionGUID: aHG5dkRbTPq7j8j+Ye6ryw==
X-CSE-MsgGUID: 7AL/VcctQM2hi/OHgd0NVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="90861297"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="90861297"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2025 00:10:17 -0800
X-CSE-ConnectionGUID: qcD8sW9ARze5HMdRfiPHKw==
X-CSE-MsgGUID: tvpV8RL1Su6oFiIj0Nx70A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="199226904"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2025 00:10:14 -0800
Message-ID: <f6fce114-ef7f-4541-8cc0-01c906c71a7c@linux.intel.com>
Date: Sun, 21 Dec 2025 16:11:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Flush cache for PASID table before using it
To: Dmytro Maluka <dmaluka@chromium.org>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Aashish Sharma <aashish@aashishsharma.net>,
 Grzegorz Jaszczyk <jaszczyk@chromium.org>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Kevin Tian <kevin.tian@intel.com>
References: <20251221001701.3626-1-dmaluka@chromium.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251221001701.3626-1-dmaluka@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/25 08:17, Dmytro Maluka wrote:
> When writing the address of a freshly allocated zero-initialized PASID
> table to a PASID directory entry, do that after the CPU cache flush for
> this PASID table, not before it, to avoid the time window when this
> PASID table may be already used by non-coherent IOMMU hardware while
> its contents in RAM is still some random old data, not zero-initialized.
> 

Fixes: 194b3348bdbb ("iommu/vt-d: Fix PASID directory pointer coherency")

> Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
> ---
>   drivers/iommu/intel/pasid.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 3e2255057079..77b9b147ab50 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -153,6 +153,9 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
>   		if (!entries)
>   			return NULL;
>   
> +		if (!ecap_coherent(info->iommu->ecap))
> +			clflush_cache_range(entries, VTD_PAGE_SIZE);
> +
>   		/*
>   		 * The pasid directory table entry won't be freed after
>   		 * allocation. No worry about the race with free and
> @@ -165,10 +168,8 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
>   			iommu_free_pages(entries);
>   			goto retry;
>   		}
> -		if (!ecap_coherent(info->iommu->ecap)) {
> -			clflush_cache_range(entries, VTD_PAGE_SIZE);
> +		if (!ecap_coherent(info->iommu->ecap))
>   			clflush_cache_range(&dir[dir_index].val, sizeof(*dir));
> -		}
>   	}
>   
>   	return &entries[index];

Thanks,
baolu
