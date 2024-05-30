Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75F9F9F7
	for <iommu@lists.linux.dev>; Thu, 30 May 2024 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717038718; cv=none; b=J6EJjiwYx03zAbwtrzATI3lmzski0OHEh+d3u+BnnV8oUiWcfNwd3ur/Lrhcan0UKRBSHHwX+hj550GXBQl4yD+Frcx5IlOUaXgUA0FGBja0WgTCmMMMHYRQErt+J75zt++LUzxUMnO0fu4EtZUZCKWjE1soOmKw6DjniNk3g0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717038718; c=relaxed/simple;
	bh=AtVs/mAUfq0zsyGVzKlFt9Vs7GAGvhJdHEZppaw/M7Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hlA0+m7GO4PidCK3Fgdi+VxHMtfR3/oPZtLx+jbN9vaqxpLsNAMVVYjibPXyJWG9dbuKUg7adjFeGfz/MGE7XQiR99lAg/GjxtQ1DvfXAZc55Sa/Tj+8ObtRiP/N+DCdBtmPc9zhgWeuzSDe+km351TcpvoZOmYjjX9KzbRLytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7fp5sSH; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7fp5sSH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717038717; x=1748574717;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AtVs/mAUfq0zsyGVzKlFt9Vs7GAGvhJdHEZppaw/M7Y=;
  b=K7fp5sSHdCKwaEkkdntLkjarBcuWcavq72747J61ven4MDTL8GR8+H/A
   +hKgGFNnB9LSNtqDt6EjTK5LiYMwuLLyZ7QvBX5uN86YqNhz6r1WEbNgo
   1gsOV4h67d5bcXo6kq2mqkm6iWRFs1bE/RoadEMU1Ll6VpukaIDzN78w0
   hU/g0v3G+zqddaQK/q0KAc+knLtZq1GU1/zwuVvBX8S080lH3mnyk9q0y
   8wkrUipmUW207OXBE7DSycwn9MWg2EQM1duWePnZCoc/y9byhAnCbHXns
   xOOIKxyzx0jFOADNPecORvxkIB27Ve3wUwnT8wqBiUBPGkhi1JdH8bFWm
   Q==;
X-CSE-ConnectionGUID: DoyREM0JQWmcSdRrqXuTuQ==
X-CSE-MsgGUID: rTQfhjrWSb+yBW6RomFgjw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13334710"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13334710"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 20:11:57 -0700
X-CSE-ConnectionGUID: o/wZ19gZRkKu+qUIFx0MAQ==
X-CSE-MsgGUID: ASzVpoGHRkiecU00cNHKxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="40093824"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa005.fm.intel.com with ESMTP; 29 May 2024 20:11:51 -0700
Message-ID: <ad3d0781-08aa-4cab-8dc8-eaf753c6671a@linux.intel.com>
Date: Thu, 30 May 2024 11:09:45 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Kalle Valo <kvalo@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
 Jason Wang <jasowang@redhat.com>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/20] iommu: Add iommu_paging_domain_alloc() interface
To: Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
References: <20240529053250.91284-1-baolu.lu@linux.intel.com>
 <20240529053250.91284-6-baolu.lu@linux.intel.com>
 <eedb1df0-e745-4b48-9261-faa0ff320ee9@intel.com>
 <dc9fa861-628f-4a96-ae37-e419b23c6ea0@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <dc9fa861-628f-4a96-ae37-e419b23c6ea0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/24 9:59 AM, Baolu Lu wrote:
> On 5/29/24 5:04 PM, Yi Liu wrote:
>> On 2024/5/29 13:32, Lu Baolu wrote:
>>> Commit <17de3f5fdd35> ("iommu: Retire bus ops") removes iommu ops from
>>> bus. The iommu subsystem no longer relies on bus for operations. So the
>>> bus parameter in iommu_domain_alloc() is no longer relevant.
>>>
>>> Add a new interface named iommu_paging_domain_alloc(), which explicitly
>>> indicates the allocation of a paging domain for DMA managed by a kernel
>>> driver. The new interface takes a device pointer as its parameter, that
>>> better aligns with the current iommu subsystem.
>>
>> you may want to move this patch before patch 03/04.
> 
> Emm, why?

I see. The commit subject is misleading. It should be "vfio/type1: Use
iommu_user_domain_alloc()".

Best regards,
baolu
