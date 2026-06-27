Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D8F38D3E4
	for <iommu@lists.linux.dev>; Sat, 27 Jun 2026 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782543446; cv=none; b=ccXHJq2wHjALsZ7zqNWoeiZyGN23iSPwrUtcV0aaec/yrm7K7eus4bSbBeSY0dF0wih/gOasVpopw32nA+jYpAuRfqeCvNMl79wa9svEO5JcN44GrC9li+tsTGON21gW6C/6+RYlBbboIVugxUc2TxqCgcCnDLukFydUDNy3HvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782543446; c=relaxed/simple;
	bh=G+uiy9oRfVC0xDCofC1oqIXtoT9unLw8wIjsUX45maI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dwTkTgZ6RchuhvcdbjH4qlZIvKg3j4AQwb38bGVBOTRxUvx6ikbfqWG4+2aRBSPaZy7gDfilvBeGUA9CKFfemkLQ+E680xfTGkzb3Am0jmB7iTihyhUjHoezbFlPnSPpm30iz/oqQ8eb5c+FnjvIOfj4oReqGjJkSOdSsxPU75A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D0qtMz5t; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0qtMz5t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782543446; x=1814079446;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G+uiy9oRfVC0xDCofC1oqIXtoT9unLw8wIjsUX45maI=;
  b=D0qtMz5tOi8yUQ0chnVesyB11bYxDGR5+OvkiSpnUmt1D8oVAPfrjhP2
   8V7z8L7ayavSIUunUg4dtUlhFyt2gK6DssFJCw7rz35HTiPzJ8aG/BhvE
   j70ymQrr2p1rZAqB+lXmaUacfimDhaD+j1DY8eeOnOpcabZGaSs5SpnmW
   hJ0luVwh71Kmr9LtDiPKSefW4OowuQBaNNMqerULHeGXrYrZxmO9Dw6ba
   xHH1JmpqVJU62M3GNo6/CnELA96fllrE4uJIKIoqyV/VvF27pjCHVm+gC
   N7VHuoVWs6+LoDiABGQT760ELkKOKjtBV+YK9ICJ3o3g+u93VALVGikY5
   Q==;
X-CSE-ConnectionGUID: s/MnV9EpRzOtn+C8eUEiWQ==
X-CSE-MsgGUID: QOwor6apQZi542CI5mKGoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="83521038"
X-IronPort-AV: E=Sophos;i="6.24,228,1774335600"; 
   d="scan'208";a="83521038"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 23:57:25 -0700
X-CSE-ConnectionGUID: JV0r/GhyRvS4enRPi+wBGw==
X-CSE-MsgGUID: CvhpaYaESFeMjCi0Mglnvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,228,1774335600"; 
   d="scan'208";a="253404517"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.236.63]) ([10.124.236.63])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 23:57:22 -0700
Message-ID: <8288734d-545a-490d-9e3b-7f516753b079@linux.intel.com>
Date: Sat, 27 Jun 2026 14:57:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH] iommu/vt-d: Fix CACHE_TAG_NESTING_DEVTLB polluting shared
 variables in flush loop
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 Li RongQing <lirongqing@baidu.com>
References: <20260623060122.3796325-1-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260623060122.3796325-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/2026 2:01 PM, Guanghui Feng wrote:
> In cache_tag_flush_range(), the CACHE_TAG_NESTING_DEVTLB case modifies the
> shared local variables 'addr' and 'mask' before falling through to
> CACHE_TAG_DEVTLB. This causes all subsequent CACHE_TAG_DEVTLB entries in
> the same loop iteration to incorrectly use the full-range flush parameters
> (addr=0, mask=MAX_AGAW_PFN_WIDTH) instead of the precisely calculated PSI
> range. This is not the intended behavior, as regular DEVTLB entries should
> always perform targeted range-based invalidation.
> 
> Fix this by having CACHE_TAG_NESTING_DEVTLB directly call
> cache_tag_flush_devtlb_psi() with the full-range constants and break,
> instead of modifying shared variables and falling through. This ensures
> CACHE_TAG_DEVTLB always uses the original calculated addr and mask for
> precise range flush.
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/iommu/intel/cache.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
> index fdc88817709f..26a758b0f501 100644
> --- a/drivers/iommu/intel/cache.c
> +++ b/drivers/iommu/intel/cache.c
> @@ -454,9 +454,8 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
>   			 * affected by a change in S2. So just flush the entire
>   			 * device cache.
>   			 */
> -			addr = 0;
> -			mask = MAX_AGAW_PFN_WIDTH;
> -			fallthrough;
> +			cache_tag_flush_devtlb_psi(domain, tag, 0, MAX_AGAW_PFN_WIDTH);
> +			break;
>   		case CACHE_TAG_DEVTLB:
>   			cache_tag_flush_devtlb_psi(domain, tag, addr, mask);
>   			break;

It seems there is already a fix for the same issue posted on the mailing
list:

https://lore.kernel.org/linux-iommu/20260605003950.1720-1-lirongqing@baidu.com/

Cc'ing Rongqing.

Thanks,
baolu

