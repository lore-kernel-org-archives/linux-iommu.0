Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7B77EA
	for <iommu@lists.linux.dev>; Sat, 21 Oct 2023 01:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HQKKfZCg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697851957; x=1729387957;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=70i1/C+fbIE2VpSwskddcgtUORM3772WnaPj85EQ9bk=;
  b=HQKKfZCg4n1MtDsa76TVBtUlgQyI6gcG+Vq1k/3pmASwH0Jxp2lSdMWT
   78en9vU2hEIuz+x3yDHb/ZLTErXYNHq1IcMh0YUVRqSk9opKgpMUzreC/
   +5UMmnxB54k+U7UeijIor01MalK/CYCWwkZliKBznlM+fo8OdXDnAJc8y
   qXZ9n446p1Egtm8gZLPkNozl+d+i6A3h8FP49sofPzf2MCQ+hMGLA1Kmg
   imM67WJrr5gqu6HvBDEJrkrEha9LzJRUWVjTi69LzWakFFLiuZm0xkjqE
   vO4CqsYBuLsaL/pfvfMdTirIUGaknGcNv8Tt60PSivJZVTyEkQ3syrSu0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="383808088"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="383808088"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 18:32:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="848253825"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="848253825"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.30.224]) ([10.255.30.224])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 18:32:34 -0700
Message-ID: <2201ae4d-b825-49a5-ba73-c6b310e2969c@linux.intel.com>
Date: Sat, 21 Oct 2023 09:32:32 +0800
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
Subject: Re: [PATCH 0/2] iommufd: Only enforce_cache_coherency when allocating
 hwpt
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com
References: <cover.1697848510.git.nicolinc@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <cover.1697848510.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/10/21 8:37, Nicolin Chen wrote:
> https://lore.kernel.org/linux-iommu/20231020135501.GG3952@nvidia.com/
> The conversation above concluded that a hwpt should only enforce cache
> coherency per device at the stage of its allocation, and it should not
> be changed or updated in the attach/replace routines.
> 
> Add two patches dropping the enforce_cache_coherency calls from attach
> and replce routines respectively, since they were introduced with two
> different commits.
> 
> Nicolin Chen (2):
>    iommufd/device: Drop enforce_cache_coherency in
>      iommufd_device_do_replace
>    iommufd/device: Drop enforce_cache_coherency in
>      iommufd_hw_pagetable_attach
> 
>   drivers/iommu/iommufd/device.c          | 19 ++-----------------
>   drivers/iommu/iommufd/hw_pagetable.c    |  2 +-
>   drivers/iommu/iommufd/iommufd_private.h |  1 -
>   3 files changed, 3 insertions(+), 19 deletions(-)

Hi Kevin and Jason,

With these two fixes, there's no issue in the intel driver any more. Do
I understand it right?

Best regards,
baolu
