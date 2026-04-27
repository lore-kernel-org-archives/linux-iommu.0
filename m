Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3727F29ACC5
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777279047; cv=none; b=TszFLYxiV7rK79hsespLsMdNj0IwhZAMecmISJPxdkVKtNuVWXgpIuhOSDd5jkTsNpNyB7+BRijERLBUmOH9/dcIPBRNiMhEQY3Drsa0rWziI8Pk0vdyhUNx3FWYHaFKTc0Y161U9C+Tdw5LNLjdQ97sLPMHofoku03k1Nrsitg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777279047; c=relaxed/simple;
	bh=r4wdqfX7ROvcjdQLMGVE4gO2eWkSICU5kTUOKXDzkgs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lfVrCNezBY/hMcofhYpvljl8YPT8Dm+P/C56L/qx8mSCLUXWYfNTh8I9JZU/V63NDv2SvFx5QAGPTw7PcngQ9fl8sskdP0qX2P6MeD3NzyDqmJ3UUcgKnrtPYtNQ9LAoUcDV0t3FtAIlox6akSsYGIK1P7zgiDHY2UYGg04ohI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAveYE7+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAveYE7+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777279046; x=1808815046;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r4wdqfX7ROvcjdQLMGVE4gO2eWkSICU5kTUOKXDzkgs=;
  b=hAveYE7+ps94GJIlsZVhpLzLA6VzCaTVadDwZtDiPwvoMniq7JqRewbn
   Lx8SQ6GPA2BALOq8z6UAgtI/MLBWubYOD7KjwzwLBZN93HnEUFrS6IHVn
   ZHXhbx/hBWAiPdUD44TWRXK7Q883HlzJmHOoXH6ePFzZ//gw4LdAF95vI
   FeUD0VfhRyjkBgGPOcBVmDY7TV1f1dtaA01NIQ/QB19BXIQoeFPYztQhu
   eZx3dB9q8a/PhM/5KPY9ScpvF1ZisJ4V9Jw5H3fMKAavQT+KkEQCGyF1C
   jfR6YctcWtaNf3aF5pcgqNl8g2xScjRm6J6B/M6UDzcjwn9Rps+MtCI0n
   Q==;
X-CSE-ConnectionGUID: Ng2eFch/T4iZN+CaLujTaQ==
X-CSE-MsgGUID: ixcJbnHhQwCp+PRg5rnBzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="89541132"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="89541132"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:37:26 -0700
X-CSE-ConnectionGUID: cJCWq0/oRg2yFHvpfEg/zg==
X-CSE-MsgGUID: NM3lBkBGQgeRgNn9bh9a1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="235349313"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:37:23 -0700
Message-ID: <010f8775-acf1-4a59-96ed-a04b54a2a32d@linux.intel.com>
Date: Mon, 27 Apr 2026 16:37:21 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 xueshuai@linux.alibaba.com
Subject: Re: [PATCH rc v8 6/8] iommu: Fix ATS invalidation timeouts during
 __iommu_remove_group_pasid()
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
 kevin.tian@intel.com, jgg@nvidia.com
References: <cover.1777074513.git.nicolinc@nvidia.com>
 <628a9ba0cc123023f0d60fefec7b65ecc23f09f6.1777074513.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <628a9ba0cc123023f0d60fefec7b65ecc23f09f6.1777074513.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/2026 9:15 AM, Nicolin Chen wrote:
> If a device is blocked, its PASID domains are already detached. Repeating
> iommu_remove_dev_pasid() is unnecessary and might trigger ATS invalidation
> timeouts.
> 
> Skip the iommu_remove_dev_pasid() call upon gdev->blocked.
> 
> Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
> Cc:stable@vger.kernel.org
> Closes:https://sashiko.dev/#/patchset/20260407194644.171304-1-nicolinc%40nvidia.com
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
