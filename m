Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9370A3D
	for <iommu@lists.linux.dev>; Tue, 23 Aug 2022 06:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661235913; x=1692771913;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5FdhoBKt2vIYyRD6ilpkOeWukzgkLGNhyzycjYZlBjc=;
  b=VmnztkoF3QcVo5ba++curZ577L1D0ZR5oBae4k8K6mDGqZNm0k3Sznsv
   iHzZShVKNUhJgHv7b5cBpQYJ0m+wKOC2cCg2HXyoyWrC9mJ/2Osi2DsIa
   Dx/HlDAI/+nIK8D3kfnpSXThqxyPSuv0QiXLFgqru8TT4VKN03vI/PY1l
   1zZJZjiSdnUPqjKYtIJPhQwCYsPhYTIVoojfRUPOgeb/XF/OCuqjhyX6E
   n2yfAytot9XnrdsTzxtk7yiohlLYfEqm4UJzJQwTKmBXTeg12L/09dfRS
   6ovqdIboZFefUXoF5OuNaTnGi72Bfofgjd2yDoLUj9p4XF28KxI4pxpTU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="280576509"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="280576509"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 23:25:13 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="642324148"
Received: from xujinlon-mobl.ccr.corp.intel.com (HELO [10.254.211.102]) ([10.254.211.102])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 23:25:11 -0700
Message-ID: <8702c6eb-bfd6-49d1-f96e-e9ae08cd87b0@linux.intel.com>
Date: Tue, 23 Aug 2022 14:25:09 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, raghunathan.srinivasan@intel.com,
 yi.l.liu@intel.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Correctly calculate sagaw value of IOMMU
Content-Language: en-US
To: iommu@lists.linux.dev
References: <20220817023558.3253263-1-baolu.lu@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220817023558.3253263-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/8/17 10:35, Lu Baolu wrote:
> The Intel IOMMU driver possibly selects between the first-level and the
> second-level translation tables for DMA address translation. However,
> the levels of page-table walks for the 4KB base page size are calculated
> from the SAGAW field of the capability register, which is only valid for
> the second-level page table. This causes the IOMMU driver to stop working
> if the hardware (or the emulated IOMMU) advertises only first-level
> translation capability and reports the SAGAW field as 0.
> 
> This solves the above problem by considering both the first level and the
> second level when calculating the supported page table levels.
> 
> Fixes: b802d070a52a1 ("iommu/vt-d: Use iova over first level")
> Cc:stable@vger.kernel.org
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>

This patch has been queued:

https://lore.kernel.org/linux-iommu/20220823061557.1631056-1-baolu.lu@linux.intel.com/

Best regards,
baolu
