Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A0F152196
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 05:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740549404; cv=none; b=RbSF5NQ/o6NBpJ84b2UAjfP8z8kLiUu+WWXn7k3wDEyhPSaHmRq8PsdBoB3ArruZGOKIFDtHXXwDDXtfdDKRmBv9Ryyu1fRQUPLEmCSJ5taScGRnosIFmR1moMj/xk//iIKsvMgHNukrEE+65QfztF5QnzJC0jRz8QcaL6lZtAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740549404; c=relaxed/simple;
	bh=kr5ICFThfU4OzpcFvP7e4d7PwzUDzlxViKlw2z9o6ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yhm+2aIS+LL8ocTQaTyI2nyRVMsA/Eq3JjRmY/FBrW05O3VRxN4RWTF4YOH5o8cIPg6MIbs6OAs3oidUy3ToL0BiaAxxuea1fElJB23sTecrDtyYGn6c7/5PrfaQXdfLXMUDFaQ1hsQ9WWzh+SM1T86MoEvLZDD+UqnRDprs/SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PGOlsB1r; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PGOlsB1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740549403; x=1772085403;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kr5ICFThfU4OzpcFvP7e4d7PwzUDzlxViKlw2z9o6ls=;
  b=PGOlsB1r93/KvT3USPjWRc9VBKS0ki1f/E0/2Opy9dIbLpDgMbcCq1OA
   77wOqYc2fshGggbnzKK2xOO3xmX2ygzaocw8uhmJwcgV6ZDcHzHywjuYM
   bTrBxmCxU71X2quhd0xZXmGUN4LeeMP+BUVwQ2r6dCfcRJVIiFss8mTE3
   04hlsjZHkdBEOc7++bTRiIDKBTqaTbdwfNScOfo5EF3V4qkwQbpmrI2zu
   CnqpNdzQEbdVIN4zZp6iQFhviUjOV5nJJuAW6V3vHH4MwUvuvWuZ/nLLo
   ro3rZVidFjgvMor3cQhQumbVI2rPyGtWgjy0btbqkgYsrvyBs4lC42rmj
   A==;
X-CSE-ConnectionGUID: k9Uv0lXURiGeU7/2vO2PYg==
X-CSE-MsgGUID: SFfgB4RURwC4lIq1DUqufw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="28973408"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="28973408"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:56:41 -0800
X-CSE-ConnectionGUID: qwIn+vzMTrardrEn/ZPaZA==
X-CSE-MsgGUID: JC5DOPNxSQ6SU9di4FAr5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120718750"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:56:39 -0800
Message-ID: <06f521f4-99b3-4517-a583-19955983b4f3@linux.intel.com>
Date: Wed, 26 Feb 2025 13:53:24 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] iommu: Store either domain or handle in
 group->pasid_array
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com
Cc: kevin.tian@intel.com, iommu@lists.linux.dev, robin.murphy@arm.com,
 nicolinc@nvidia.com, will@kernel.org
References: <20250226011849.5102-1-yi.l.liu@intel.com>
 <20250226011849.5102-4-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250226011849.5102-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/25 09:18, Yi Liu wrote:
> iommu_attach_device_pasid() only stores handle to group->pasid_array
> when there is a valid handle input. However, it makes the
> iommu_attach_device_pasid() unable to detect if the pasid has been
> attached or not previously.
> 
> To be complete, let the iommu_attach_device_pasid() store the domain
> to group->pasid_array if no valid handle. The other users of the
> group->pasid_array should be updated to be consistent. e.g. the
> iommu_attach_group_handle() and iommu_replace_group_handle().
> 
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Nicolin Chen<nicolinc@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
