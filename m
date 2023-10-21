Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA710658
	for <iommu@lists.linux.dev>; Sat, 21 Oct 2023 01:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R69lX7Pj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697851606; x=1729387606;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7GozSVUnhUINT8j3LKkbfRc0aYYLTTgIbM5u/goyqg4=;
  b=R69lX7PjObdzXMtcmr4N+/Kh8K4cMJGRaMstwcSAdN3Jc/i9VE9x5+L5
   w7rEjakxKkjWPvlb/4ean00O9L1mEE6pPK6D+9Fgkk+lnlyb8+PFsBZKh
   ILYKYktgRSckRwx3qrotyyOX1jqWKdgymWFDxh+mO9sffjaRhTobQFfJq
   NtUdMtkMREB5f6YdFtQUHIy2nfC2b4vePqHrUJdTU4HwaJssNiVDqyakT
   Ka+K192F38AOj5ttA2lJcSp59Q1/LhGV3w4bgK5lU4WtsHfzoQj8bHGs/
   ibp4c/Evn+pNO8T7lUVk3eoX6RT3zacohWrTqKjdvnvOltHLY83Qc11Dk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="376978765"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="376978765"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 18:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="5269068"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.30.224]) ([10.255.30.224])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 18:25:32 -0700
Message-ID: <dfbbdb6c-023a-46f0-bad6-77da4dd2e51b@linux.intel.com>
Date: Sat, 21 Oct 2023 09:26:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 yi.l.liu@intel.com
Subject: Re: [PATCH 2/2] iommufd/device: Drop enforce_cache_coherency in
 iommufd_hw_pagetable_attach
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com
References: <cover.1697848510.git.nicolinc@nvidia.com>
 <d51a21eecd19966a98cb56b99a4ed1d7f89b6151.1697848510.git.nicolinc@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <d51a21eecd19966a98cb56b99a4ed1d7f89b6151.1697848510.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/10/21 8:37, Nicolin Chen wrote:
> According to the conversion in the following link:
> https://lore.kernel.org/linux-iommu/20231020135501.GG3952@nvidia.com/
> 
> The enforce_cache_coherency should be set/enforced in the hwpt allocation
> routine. The iommu driver in its attach_dev() op should decide whether to
> reject or not a device that doesn't match with the configuration of cache
> coherency. Drop the enforce_cache_coherency piece in attach(), so it will
> be called only in the allocation routine. Then, drop it in the header and
> mark it as a static function.
> 
> Cc: stable@vger.kernel.org
> Fixes: 17bad52708b4 ("iommufd: Add enforced_cache_coherency to iommufd_hw_pagetable_alloc()")
> Suggested-by: Tian, Kevin <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/device.c          | 7 -------
>   drivers/iommu/iommufd/hw_pagetable.c    | 2 +-
>   drivers/iommu/iommufd/iommufd_private.h | 1 -
>   3 files changed, 1 insertion(+), 9 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

