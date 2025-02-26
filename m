Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2F92206B8
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578314; cv=none; b=DnRVT3r33qT0iwiTm+ndPLmraFM9/sjANnkpk+49FK6YlaFG8ovVSz1V4woktWHVrzxL45oTBrbQ31E0CKkd6Nf4VeLx0RzBekqpugrqSnUIZ9Y86AD233dGo1+v7JSHDJcKqE3Vx9t0kYzHm0Gpz5mog2VzaFbd5dA2PiJ14y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578314; c=relaxed/simple;
	bh=FZZt5KgIDDLaTKjKmZAVOsu8hSeoKqX67x8EEHvVw94=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lgWB/NKuHggDWAS5Mzc74PG6sxcCZ0LvGwdiiARFTyML5B0xD9x0WGYdgdMxamopAhLAniXAGRqNelup+tJrH6EMt8SjK2AIJMfhFoiyEcRcfoHZQobrXBu+KJ9vFtLUu29jrjZ1Qkh9negq9Oz0K1tsUHL28jNWwkgePGauM7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SbrxOXEs; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SbrxOXEs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740578303; x=1772114303;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FZZt5KgIDDLaTKjKmZAVOsu8hSeoKqX67x8EEHvVw94=;
  b=SbrxOXEsVWHwm1WbUi0PfZ9aiCDe31dNslTL4K5577U6Q0K11/P294Wv
   vqJTMibkFAkdOiCHSBcfPz1lUE/Wo8wGm0FtBzHWBQxwrbSCn4H1R1Gcm
   QyWzCX2Oz/g55q+DBQ+QcfJINK1uO/5UVaBn1+BHLjoOOCb5+snNDx+lH
   /Zd1OYOBC5JW5osisu+afJHsb6Rxoa78pTwXyrq1GaxeyQCbDvr/WHMN0
   MFRu2bytTMBnIJnXBungyti4BXmN1K/CHQKGsgmfRQkmgXcNhLGx0LrxP
   LSqdgn68qwThHbNvlvqO8cxMj0ddDUauGJTN8pZEZM3ZFMXiMfXwuk7cu
   A==;
X-CSE-ConnectionGUID: 1KdsjvlgRKaPe5MivAQZzA==
X-CSE-MsgGUID: QLLhWSXDSB21OocJohOQbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="66794697"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="66794697"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:58:22 -0800
X-CSE-ConnectionGUID: rmhYhyC3RN28J3t4TV7SVQ==
X-CSE-MsgGUID: 0u4Lu6pSSVyR8IvUofzYow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="116522307"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.105]) ([10.124.240.105])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:58:20 -0800
Message-ID: <854d25a4-a125-481f-a836-5535330e469c@linux.intel.com>
Date: Wed, 26 Feb 2025 21:58:18 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, joro@8bytes.org, iommu@lists.linux.dev,
 nicolinc@nvidia.com
Subject: Re: [PATCH v8 01/12] iommu: Add iommu_attach_device_pasid_handle()
To: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, jgg@nvidia.com
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-2-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250226114032.4591-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/26 19:40, Yi Liu wrote:
> The existing iommu_attach_device_pasid() function allows both a valid
> handle and a NULL handle, which is not consistent with the RID path where
> iommu_attach_group() and iommu_attach_group_handle() coexist. To refine
> it, this adds iommu_attach_device_pasid_handle() to cover the case with
> valid handle, while let the iommu_attach_device_pasid() only deals with
> the case with NULL handle.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
