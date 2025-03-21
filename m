Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A110D2FB
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 03:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742527005; cv=none; b=tv/ygzfhEhCJx7uG0IHzsi7kFV+10KvFcoUyJje07h7aPEFTkWvdM3DEUqnMCDqWxGCvbk3tzLA7aolG+smBLYIG1iTTK7snlXZR7hp04ER+Sbu69whvKVNVlgYP7rFQgu0ZXNDAE4La0pVIkbWrRj1F6oOz9kY2srmJg4Gx6Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742527005; c=relaxed/simple;
	bh=uyS+76rINTTcwIct9UCmeg7XVbpAK2HcylOhNrWhdTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6VA3buKUH+HGdzSr4x9RDFQIq16cdrsWJftWB3w78DY907ZPyynXk+UU7OF5esZCfPI0FSTaPrD5zirc4nIrZInxLh+jKuVZQwf4BYueN7NWKsaIEygjGf1uSr2DsNSzEFIoYs051qctUqinr4AqJenM+I443to9By5752O/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fxftfWFg; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fxftfWFg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742527003; x=1774063003;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uyS+76rINTTcwIct9UCmeg7XVbpAK2HcylOhNrWhdTo=;
  b=fxftfWFghsOHLG1+KHKFxXcVVkggpffJWFyRozD0wqUCScnZQF4yJNdP
   3bCf7ASM0AxlVCXqec6Oc2rLEIyKCGcgQSyqsZfq/9fhcZQhNLQjjT0DC
   Q8+5BDjKDEvuXTizbY0s4JPxqYgrITnRLDiBVK5oWoMZIeRZvUt/N0JwA
   j14/jhL21H7pb9gPQK0sudrcXeBy+MXfflysTrS+NLwvlKUuAoAmce7dC
   ac6XxxC5MPzuXLSJ8wDK1q9knaKEglYbCoF9PdI/NVUGxtw/T3hNimE5A
   zu27BPVfupG+xSuWysJkgFl4T5OztAlCDTs6F0E6TKS9t+CQIcSLXTtNI
   g==;
X-CSE-ConnectionGUID: afty9oasT4CoUNtrksUAuw==
X-CSE-MsgGUID: RIQzWKamSBeKKsIahtEGMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43515963"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43515963"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 20:16:41 -0700
X-CSE-ConnectionGUID: lBunJnTvQJCuP+FctWFLFQ==
X-CSE-MsgGUID: 5V6eKB0nSJyVOVe93ymlyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123732716"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 20:16:39 -0700
Message-ID: <0e4a17c9-1bdb-435a-b769-3cb365109f20@linux.intel.com>
Date: Fri, 21 Mar 2025 11:13:08 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/18] iommufd: Pass @pasid through the device
 attach/replace path
To: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, jgg@nvidia.com
Cc: joro@8bytes.org, iommu@lists.linux.dev, nicolinc@nvidia.com
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-4-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250320134744.5777-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 21:47, Yi Liu wrote:
> Most of the core logic before conducting the actual device attach/
> replace operation can be shared with pasid attach/replace. So pass
> @pasid through the device attach/replace helpers to prepare adding
> pasid attach/replace.
> 
> So far the @pasid should only be IOMMU_NO_PASID. No functional change.
> 
> Signed-off-by: Kevin Tian<kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Nicolin Chen<nicolinc@nvidia.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
