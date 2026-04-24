Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0B92D9ECB
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 05:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777008581; cv=none; b=EJKRsLgPCdGI7KrL5bOWXWQOaIzC7mBHz+W08nYUX9Aa6jfTj6hn5GKIdIIT57MyKBvszg/uHzKV545JZUZl6GeDac3jGEzZ3x8hpGJwx0H6+EfXoKPmnckvsDPB4EEZdpBkHAjQiks4fvjEQwbVDAgaRfrikhfU8u79JucQ24E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777008581; c=relaxed/simple;
	bh=qZQj9DojqK0kfZouWpucobsVO8+bgCuQiDvQVqV8HBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJ6RDg8/AInz23+aQh4m5U1CCSRbaWQGX1PlN9Owl9BRFyI0ivQsGlJkoghvePkZogLsvpKV0QK7HNnR+e3QvMYZLMpBmoYr3Vh7Md1YF5ZwVS1S2M0hbbsMK9+WctdJgP4sUSSkYZ4zagPnW8iYpGM1C2ipvTfe7ONp7NGEdjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eFy0+PwB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eFy0+PwB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777008579; x=1808544579;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qZQj9DojqK0kfZouWpucobsVO8+bgCuQiDvQVqV8HBo=;
  b=eFy0+PwBviO3fB3AIBivZYnp33QvSqg5nLIghTSXVJ1K09hA0QhJ2R9R
   sLeZghxganw5Hr5TNeuL/Hs+HDZebTVsRSrAtpdAZfMglDnNmmfS60uSb
   zLMkthJqbLa7K8E0IVLuA9kn1lc1jTitLovSALYzy7DLGVqZP6UcXTBOc
   XQyvdsZJj2QASsTXf9zRhzkc9gJj53Wu84RuzDiN1pAa/7WlHevyL69JW
   j+ED/rHoGDzm2AFk0NpuJrBnQT7JnmZnBwSkdYEh7PYrJ7EKatf+QUh1c
   xOLLXVP0hl2nzHKJ7AU5L6dxAb6Mj44AE93wYHvYmDGkX62TplkBJ+2nr
   w==;
X-CSE-ConnectionGUID: GzXK9CW1Q8qtcCdNJCVCGA==
X-CSE-MsgGUID: r0tuMBSJTkWwAn07LnHPtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="89449672"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="89449672"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 22:29:39 -0700
X-CSE-ConnectionGUID: VN2s6jinT/e/aH0HB+YT6A==
X-CSE-MsgGUID: W4qFjC18QUS/z9aK0OVIyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="226324300"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 22:29:37 -0700
Message-ID: <b1939ea4-9f16-4753-9070-70240aebb913@linux.intel.com>
Date: Fri, 24 Apr 2026 13:27:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc v7 2/6] iommu: Replace per-group resetting_domain with
 per-gdev blocked flag
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
 kevin.tian@intel.com, jgg@nvidia.com
Cc: will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, xueshuai@linux.alibaba.com
References: <cover.1776551790.git.nicolinc@nvidia.com>
 <bc444d02c1aee02c59c8972ccc588f28dc93e059.1776551790.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <bc444d02c1aee02c59c8972ccc588f28dc93e059.1776551790.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/19/26 07:41, Nicolin Chen wrote:
> The core tracks device resetting states with a per-group resetting_domain,
> while a reset is actually per group-device. Such a mismatch might lead to
> confusion and even difficulty to untangle per-gdev handling requirement.
> 
> Shuai found that cxl_reset_bus_function() calls pci_reset_bus_function()
> internally while both are calling pci_dev_reset_iommu_prepare/done(). And
> the solution requires the core to track at the group_device level as well.
> 
> Introduce a 'blocked' flag to struct group_device, to allow a multi-device
> group to isolate concurrent device resets independently.
> 
> As the reset routine is per gdev, it cannot clear group->resetting_domain
> without iterating over the device list to ensure no other device is being
> reset. Simplify it by replacing the resetting_domain with a 'recovery_cnt'
> in the struct iommu_group.
> 
> No functional change. But this is essential to apply following bug fixes.
> 
> Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
> Cc:stable@vger.kernel.org
> Reported-by: Shuai Xue<xueshuai@linux.alibaba.com>
> Closes:https://lore.kernel.org/all/absKsk7qQOwzhpzv@Asurada-Nvidia/
> Reviewed-by: Shuai Xue<xueshuai@linux.alibaba.com>
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 104 ++++++++++++++++++++++++++++++++----------
>   1 file changed, 79 insertions(+), 25 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
