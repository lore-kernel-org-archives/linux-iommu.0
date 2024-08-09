Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B1A18C326
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723190978; cv=none; b=dDQ3xhH/p3LF5cvXDeXTg3XkyrmeqXe81z5TZ9wTY9pONgSfomzjpgT/fxtVgBzgBIcg5UnUtsxsg8Jlbm9Q14484ujvVy2epJkADwMihSxtu2TOTYU568g5TvDuWbcNnBgkUhotXmCs8mkl6+ovpCDjk2TkF77rXWBuZaieySo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723190978; c=relaxed/simple;
	bh=4me2Otj/1oatxnC6SB6SCwY1Mjomeaa+i+n+6ePk9F4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tDCn4MUIJi9oZdWvj7x9cDZAJvEjnKzVbOLYRUCIY0ZYJVKyHFkmS+5zarS0cdlpuhZeZDUYqVP2KxPKSiczjyKMwmQ9MYdAQEffZZnAPrI69v8Ks9AGDHOWtvK5fBXeRnt9DLfrU4DYzpRlj7Z++MHfzLYfeZJ8MhYyT9unKIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hw8DJTQt; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hw8DJTQt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723190976; x=1754726976;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4me2Otj/1oatxnC6SB6SCwY1Mjomeaa+i+n+6ePk9F4=;
  b=Hw8DJTQtFYnqt6YisUb1xaXtOzILYV+GT1h0cUJ4iGpdE7ZGK2Daz4dJ
   Rxnci/uGMY7jNGpgYRFcobMyX14XZQtrxvpK0YyWZ0k83ZFEkZU4sdp9L
   5yZHia4DhW/tFA2rGE3CDlTbfKYEmhwE9fsyqWi1iJNEVvJmufaLZt2N2
   qqG+Zcfbq7XCbWD43CI3gBcq6kQoKPzxryr1fOvh/ixRIiYuo98WuqKsp
   5V4fV7VlvWgzVz4B5x8KCyGA4Wa1HkeNMmfWDtqZ7qwOBGNlTJ/ov4k/t
   tlX/SI6+XYz4kc05d0wrFKMLIXThLEqJgLx5Ctyy5B6a/PSQr+G48RQmX
   w==;
X-CSE-ConnectionGUID: /BPLLwdqRAiI2mGSqN0ffA==
X-CSE-MsgGUID: y0YTplm6ReqySvEe++U+4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38862275"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="38862275"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:09:35 -0700
X-CSE-ConnectionGUID: G5guY3llQvWKjSyKyIBRxw==
X-CSE-MsgGUID: 7k7TzrgIQC6mBYjkKhicLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="95014520"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.229.145]) ([10.124.229.145])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:09:34 -0700
Message-ID: <f31580dd-f289-4423-8410-37c7e4727704@linux.intel.com>
Date: Fri, 9 Aug 2024 16:09:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iommu/vt-d: Refactor IOTLB and Dev-IOTLB flush
 logic
To: Tina Zhang <tina.zhang@intel.com>, Kevin Tian <kevin.tian@intel.com>
References: <20240809025431.14605-1-tina.zhang@intel.com>
 <20240809025431.14605-3-tina.zhang@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240809025431.14605-3-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/9 10:54, Tina Zhang wrote:
> Introduce three new helper functions, handle_iotlb_flush(), handle_dev_
> tlb_flush() and handle_dev_tlb_flush_all() to encapsulate the logic for
> IOTLB and Dev-IOTLB invalidation commands. This refactoring aims to
> improve code readability and maintainability by centralizing the handling
> of these flush operations.
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>   drivers/iommu/intel/cache.c | 136 +++++++++++++++++++-----------------
>   1 file changed, 72 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
> index 44e92638c0cd..3ae84ccfcfa1 100644
> --- a/drivers/iommu/intel/cache.c
> +++ b/drivers/iommu/intel/cache.c
> @@ -255,6 +255,72 @@ static unsigned long calculate_psi_aligned_address(unsigned long start,
>   	return ALIGN_DOWN(start, VTD_PAGE_SIZE << mask);
>   }
>   
> +static inline void handle_iotlb_flush(struct dmar_domain *domain,
> +				      struct cache_tag *tag,
> +				      unsigned long addr,
> +				      unsigned long pages,
> +				      unsigned long mask,
> +				      int ih)
> +{
> +	struct intel_iommu *iommu = tag->iommu;
> +
> +	if (domain->use_first_level) {
> +		qi_flush_piotlb(iommu, tag->domain_id,
> +				tag->pasid, addr, pages, ih);
> +	} else {
> +		/*
> +		 * Fallback to domain selective flush if no
> +		 * PSI support or the size is too big.
> +		 */
> +		if (!cap_pgsel_inv(iommu->cap) ||
> +		    mask > cap_max_amask_val(iommu->cap) ||
> +		    pages == -1)
> +			iommu->flush.flush_iotlb(iommu, tag->domain_id,
> +						 0, 0, DMA_TLB_DSI_FLUSH);
> +		else
> +			iommu->flush.flush_iotlb(iommu, tag->domain_id,
> +						 addr | ih, mask,
> +						 DMA_TLB_PSI_FLUSH);
> +	}
> +}

No need to make it inline. Same to other places in this series. If you
really want any inline helper, please add it in the header.

Thanks,
baolu
