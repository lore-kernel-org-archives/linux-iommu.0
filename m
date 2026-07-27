Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F1C39AD39
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 02:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785120580; cv=none; b=Jw9vzMvQ50u07M2NqYBQQOLISO1tuqDNAlFbmSNw23Lo4c8dsGoffgFSBsm7iq6EYzF18TMKdPaPAJjD8WEhHRxn4vs73KFDajVdO6Ut07tuJ0HCJx0drqMkWiVZhrmAfJep9BPyFdqjtBiK7L/EsGwSQHnypMaxSp7Swpvmmv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785120580; c=relaxed/simple;
	bh=/Ri3yBHd0Po1pXUBRlWqCUtuUZpDA/nhLpAZEtuPw24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rfUoS/WHRh20K3j+pPsMLzemGG9tUFjSC9+8tPaBcK16ZVRS728xfnI849IUO2kcArzcB+LDSLX454DuM3uSezbF0+8XQqscoYA3S4gj9w8gCjjlrwoQuY+JzVXDu26bMTMSBIL8pQF/Ei5Q41dExauBK7H01UnnrYBho5zqNPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hk249ark; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hk249ark"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785120578; x=1816656578;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/Ri3yBHd0Po1pXUBRlWqCUtuUZpDA/nhLpAZEtuPw24=;
  b=hk249arkTgT/0QhXjmmV/oERvTroHzzGtKIIlNEBnG/76ReWBxYQsJ/F
   KtyrhnuW821dBG+CMxyXDj6/DkSyn74bQed0sFGO+n7cxwrm6oEwJ755W
   QmshlMXvD6BELH25D0CC7fKmn0QrfGTyHcP6arcW4huTEPSsejwd20ZwS
   PKp0jbyFmBpTz5k5rWPqSQHGGCNEIWToGSPOiUmV9kXN7v3qqbuLdoj8j
   nye/ix/POWgCrfh1V0stUYhMPiWI9mu6oCjgpgmWet1/ZwfmkWb6HZVvd
   YB0XnkRqVsOU48cl2SZym8Q1SaaPhJh7UwWGyShLffEs1GeuOn499b0Qp
   w==;
X-CSE-ConnectionGUID: 8qP3IZaoQfmudMLLpWGEoA==
X-CSE-MsgGUID: 5cY2x8kWT9ykx3ScqbG1sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="103095871"
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="103095871"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 19:49:37 -0700
X-CSE-ConnectionGUID: 7fTquWicQ5+tSN+rbT/xGg==
X-CSE-MsgGUID: h+e4792NRISpl+coIDxlBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="255921849"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 19:49:34 -0700
Message-ID: <b118776e-2d87-42bc-8609-b0e4516be713@linux.intel.com>
Date: Mon, 27 Jul 2026 10:47:45 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Fix CACHE_TAG_NESTING_DEVTLB polluting shared
 variables in flush loop
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 alikernel-developer@linux.alibaba.com
References: <20260623060122.3796325-1-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260623060122.3796325-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/26 14:01, Guanghui Feng wrote:
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
> Signed-off-by: Guanghui Feng<guanghuifeng@linux.alibaba.com>
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>
> ---
>   drivers/iommu/intel/cache.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Queued for v7.3-rc1. Thanks a lot!
