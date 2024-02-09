Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E391859
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707446464; cv=none; b=DFeK6CNiyGrVj8h9OH/ZQ8xFfBaogPdRlAia8i7K3MNh89uTHz9eOPlWtU8ADp4wJXpwsXV5nJBgOHaiSZFlE5mI75s+lE5MzzJ+XeCxPW0vkfPtLaf0a5eeBZ/GE+ugZGlptDbwvXL1+H+tPPBD9VB6lBbgH7nM0F60wvtqXh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707446464; c=relaxed/simple;
	bh=PJTFbv2YtGVGwc0ykmP+GYm3N/49nZRz55vdsHWeQuk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=C3SqCH5BkwbdRIjkaji8Pvicx6cA+j1JBSKI8SXLdABZ62UnzmGiEu6Jl1wb+B2EuYtAZMxtPmwROZz0RVyvhpNp2Fkjf0BnqKaD4P1W0rjoaBilIr0rt99DOg8jpE2yip6h2EY+MCIqYxiIhr5PpTJ7CXEc8r+M8CwjQy+VIIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkpDedNN; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkpDedNN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707446462; x=1738982462;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=PJTFbv2YtGVGwc0ykmP+GYm3N/49nZRz55vdsHWeQuk=;
  b=ZkpDedNNq7bbsPkS06FaD2VLckIRLjijjRjnMJLEtdbGsAUK3aS3Awel
   WoLy8syQPc5hUwh2mclj7AboUutZU9nA5A0mBB0s1BYMRV/6/8qW+5czl
   y23Wbh6qtzEaSgwjDzCH6Dg04e65zzcJ5Bmi7N2WLjaGHMw5uQwHRkix6
   zNyUQltVBUafy3xTsnvZ9D3YXsy/huno46zE1/AGyBGFpwgdNK+fZkakk
   bvldF6AB4DrX90zscZNxAg7srLPrdcPHEqUfPjVHirYWDY9O0sEoR63Nx
   A3G/BGlqfmT4BAGuOp/K6e/FVZxt3AhiwLIJqmC83fHWPZDJXorumqrio
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="436494807"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="436494807"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 18:41:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="6488708"
Received: from lshui-mobl1.ccr.corp.intel.com (HELO [10.249.170.42]) ([10.249.170.42])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 18:40:58 -0800
Message-ID: <7d5f761b-2e26-4d09-a285-7840487d5d83@linux.intel.com>
Date: Fri, 9 Feb 2024 10:40:57 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH rc 7/8] iommu/vt-d: Wrap the dirty tracking loop to be a
 helper
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
Cc: baolu.lu@linux.intel.com, alex.williamson@redhat.com,
 robin.murphy@arm.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, zhenzhong.duan@intel.com,
 joao.m.martins@oracle.com
References: <20240208082307.15759-1-yi.l.liu@intel.com>
 <20240208082307.15759-8-yi.l.liu@intel.com>
Content-Language: en-US
In-Reply-To: <20240208082307.15759-8-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/8 16:23, Yi Liu wrote:
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4730,23 +4730,35 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
>   	return vtd;
>   }
>   
> +static int
> +device_set_dirty_tracking(struct list_head *devices, bool enable)
> +{
> +	struct device_domain_info *info;
> +	int ret = 0;
> +
> +	list_for_each_entry(info, devices, link) {
> +		ret = intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
> +						       IOMMU_NO_PASID, enable);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}

Let's make this helper specific. Something like below.

/*
  * Set dirty tracking for the device list of a domain. The caller must
  * hold the domain->lock when calling it.
  */
static int device_list_set_dirty_tracking(...)

Best regards,
baolu
