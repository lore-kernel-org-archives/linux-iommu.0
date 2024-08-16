Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959837F9
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 02:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774897; cv=none; b=fEuokYGHKphCIModIBKZKIG2rRVE2Iw+ZG+N5o9xU1G8OESmCTJ3Ylzvs+gxHkfsLC9C49NfrL3mDBe92+rUbmX1demWey04baVVbQbEc94iJZsx5ZxsqigOVUQ6l0MtU3LGQuzr/ifGmij88o7ZHJOj+rkaHwlk4xSjSEVwk8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774897; c=relaxed/simple;
	bh=pk6OYyhWOJ/JBG37oa4i9zOfrfLVbY85+sSrpAlcx7I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FQ4b35tSojtDFopn9ZKiC4yDEsZhoMzs1MOHWcJWCGMX5hfbFC0aOAssqNRDYWb+xPrfAHGX6GIEado2SGXhH9Q7z7o16EarciLLRYYg/Bd2ZeAw5N56oT/Eme+psnc/+W7DdaqY1wR8/TIIch5Jowl8V1F2JMKHBQ5JgtODqVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IozdsHSe; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IozdsHSe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723774895; x=1755310895;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pk6OYyhWOJ/JBG37oa4i9zOfrfLVbY85+sSrpAlcx7I=;
  b=IozdsHSea9DpILGbXpBEisD1d9ItV+CmMs8oQTk+EPiQ/MAkdSz5uyso
   g0nPkgd9f2e9HmNLkYjtJx91CPVDIDjL6K2LfENxi+brvUzM89YBjlpDa
   DaUCZhzUEn/HfV/drQCiHo9YggRouwjj58dsXVGAponMU/xYW4Mz1t3V/
   zUeAM0B8zeJ+DxtVHY4twqgpjzqr+EYxiXV2PFSmfGoKvZXPeWpJv3Mv2
   H34sKskTVm4c8lbT/dil7W4xudTg6WBQdh1/rPoivZ+JdgQ8hGRcK9AS7
   qddnTPdjWe16GglC8Mo28GF0+Ixp5050rkjvWTp4JRS6vLgSY4fyrjazB
   g==;
X-CSE-ConnectionGUID: Dv2s+U3MRxKDkWNJFwfgKw==
X-CSE-MsgGUID: ruxfKgqGRFGppJYta5iwJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22205813"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="22205813"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 19:21:35 -0700
X-CSE-ConnectionGUID: 5nQesaMoSiiU0VzJRJQtwA==
X-CSE-MsgGUID: fDStZKGeQnKbnIe9kHrE5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="64484214"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 15 Aug 2024 19:21:33 -0700
Message-ID: <c35a4976-7b36-411d-9f4c-4fb3a3bf204a@linux.intel.com>
Date: Fri, 16 Aug 2024 10:17:59 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Mostafa Saleh <smostafa@google.com>,
 iommu@lists.linux.dev, Kunkun Jiang <jiangkunkun@huawei.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH rc v3] iommu: Handle iommu faults for a bad iopf setup
To: Pranjal Shrivastava <praan@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20240815182423.446137-1-praan@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240815182423.446137-1-praan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/16/24 2:24 AM, Pranjal Shrivastava wrote:
> The iommu_report_device_fault function was updated to return void while
> assuming that drivers only need to call iommu_report_device_fault() for
> reporting an iopf. This implementation causes following problems:
> 
> 1. The drivers rely on the core code to call it's page_reponse,
>     however, when a fault is received and no fault capable domain is
>     attached / iopf_param is NULL, the ops->page_response is NOT called
>     causing the device to stall in case the fault type was PAGE_REQ.
> 
> 2. The arm_smmu_v3 driver relies on the returned value to log errors
>     returning void from iommu_report_device_fault causes these events to
>     be missed while logging.
> 
> Modify the iommu_report_device_fault function to return -EINVAL for
> cases where no fault capable domain is attached or iopf_param was NULL
> and calls back to the driver (ops->page_response) in case the fault type
> was IOMMU_FAULT_PAGE_REQ. The returned value can be used by the drivers
> to log the fault/event as needed.
> 
> Reported-by: Kunkun Jiang<jiangkunkun@huawei.com>
> Closes:https://lore.kernel.org/all/6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com/
> Fixes: 3dfa64aecbaf ("iommu: Make iommu_report_device_fault() return void")
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Pranjal Shrivastava<praan@google.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   2 +-
>   drivers/iommu/io-pgfault.c                  | 116 +++++++++++++-------
>   include/linux/iommu.h                       |   5 +-
>   3 files changed, 83 insertions(+), 40 deletions(-)

Nit: can you please add some words to the comments of
iommu_report_device_fault() to explain what it returns? Right now, it
looks like the return value only matters for certain iommu drivers, so
it would be helpful to add a clear explanation.

Others look good to me,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks,
baolu


