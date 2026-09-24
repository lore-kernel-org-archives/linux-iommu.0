Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADB135BDC2
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 06:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232372; cv=none; b=OOHmqgpFA3MVGI7kXrT8gwjwxvUOZ+gqSqQO5/L1C4UB5LKsTTdEf1xPD6ocP4nGb7FaZNq/+aA0r8a9nu83retlQN5kqP4xL+tgQ0l462ihWvzPBVKyOa1XvaNJEVbRBFrcJ4gsEScn0CmsXpgoBnpt5Y4i4Jj4wYtNx84rWZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232372; c=relaxed/simple;
	bh=9X93mEba9oJz1t1ROXsa1+RcvpmXZTLshz2qV8yUV/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jiSZbyu5lNIft9s8OYqEEsuJ0JXX63w2AJ9On4xQDJXvVaXXu2uc/f06o4AdMiRGDuimUxER5DIqvHu7/UjJUVKUSfcwNzxa8Hsat1zLjw8+SZn/8mZSbB9+QZ/f9giAhBvPKliGq8NFilEIeeml5p4gMtU23tQVgl8Vuh4Ub58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gf7GLcfg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gf7GLcfg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790232371; x=1821768371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9X93mEba9oJz1t1ROXsa1+RcvpmXZTLshz2qV8yUV/E=;
  b=gf7GLcfgjPlFqqraXY2MOXZrk01OeHrdaMBy/1fN2Hw7IaWnamdXZtUR
   ch55MLRxX13CnFZmQSZ/cRKAVwtIRv4iGOAuZkq61MwOl8atNiM3tszom
   hES0aUB4ULjXubvJIrWKOekz48dUrOlxeuJJb15yIk3U+uNB53vlBBg6B
   oVTO3ro9GCJveUT4/YEVSGG7peuB3D6ZV4p1IcXjaMzkdQklNtDGcI7HH
   evYoBAcSkFTY5AyFCa2BDHk+R4s+38eW9SnfFtUw35Hk8nJtqyNMGRjBR
   /azFNaxxnrMXQrt8ozXkaokYn3Ry3vYMm9O5oIodZyBxw4JEo/V6p7cb5
   A==;
X-CSE-ConnectionGUID: rRptGqqdR1KyyPFu27tb9g==
X-CSE-MsgGUID: ZBa/ZTAEQcSPDcYXq9NUmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="89855275"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="89855275"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:46:11 -0700
X-CSE-ConnectionGUID: FohIE5vdQyaSwy7rUuhtAQ==
X-CSE-MsgGUID: PXe9kUHUTVK+4B0IbOpYbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="274108640"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:46:09 -0700
Message-ID: <534bb225-4a3a-4a7e-9a89-c6ca4d383ecb@linux.intel.com>
Date: Thu, 24 Sep 2026 14:46:07 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] iommu/vt-d: Fix issues reported by Sashiko
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260909075106.738691-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260909075106.738691-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 15:50, Lu Baolu wrote:
> Hi,
> 
> This collects a number of pre-existing issues that were reported by
> Sashiko while reviewing recent VT-d patches. None of them are
> regressions from the patches under review; they are latent problems in
> code those patches happened to touch.
> 
> Thanks,
> baolu
> 
> Lu Baolu (7):
>    iommu/vt-d: Avoid out-of-range shift in qi_desc_dev_iotlb_pasid()
>    iommu/vt-d: Do not ignore context table copy failures
>    iommu/vt-d: Handle DID reservation errors when copying context tables
>    iommu/vt-d: Reserve scalable-mode DIDs from PASID entries during copy
>    iommu/vt-d: Use old domain parameter when attaching the blocking
>      domain
>    iommu/vt-d: Fix iopf refcount leak in nested attach
>    iommu/vt-d: Drop old iopf ref only after attach succeeds
> 
>   drivers/iommu/intel/iommu.h  |  17 +++-
>   drivers/iommu/intel/iommu.c  | 152 ++++++++++++++++++++++++++++++-----
>   drivers/iommu/intel/nested.c |   2 +
>   3 files changed, 149 insertions(+), 22 deletions(-)

Queued for iommu/next.
