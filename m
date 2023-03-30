Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB871C31;
	Thu, 30 Mar 2023 07:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680161598; x=1711697598;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gkMjrAsabz5vlVqnVrATOH0ecOpu5av0KzxjpU4hvjo=;
  b=hd6ktef2ppE5ZyCpvAX2R5UM2cieIdB78sZK3Fe/rsQ3YWvGRttoIdKw
   1SyVKRp6jzvH2tosw5KOMyGqFR6gH2ywxsDdIcRpRw2fjamI4m998YROB
   lFnLIIIUhELGtbIZPiWBJXKjBisANpa6gImVTXBgB5UKSpv14i7bLQvrV
   E5J9UFKahxnziyj/FGDYIr1PwmkMLVCJNsKv1RMD5cEGqx9qfysmNNaET
   0gqq+6W6MYvj748L977xvLKzlJS1sBwVv3/1/Lqc9J089E1DUXgu8iNL5
   TLO7ZIifzvvAehHBHhO3rWz/Xv554n5xmiIzDBfAVW+BS5137MLTIQ9bc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="320744782"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="320744782"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 00:33:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="687133966"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="687133966"
Received: from ztang3-mobl6.amr.corp.intel.com (HELO [10.255.30.251]) ([10.255.30.251])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 00:33:12 -0700
Message-ID: <03eddb9b-dc7d-45d5-4fa3-3471f3046fe0@linux.intel.com>
Date: Thu, 30 Mar 2023 15:33:10 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 09/14] iommu: Fix iommu_probe_device() to attach the
 right domain
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>
References: <9-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <9-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/30 7:40, Jason Gunthorpe wrote:
> The general invariant is that all devices in an iommu_group are attached
> to group->domain. We missed some cases here where an owned group would not
> get the device attached.
> 
> Rework this logic so it follows the default domain flow of the
> bus_iommu_probe() - call iommu_alloc_default_domain(), then use
> __iommu_group_set_domain_internal() to set up all the devices.
> 
> Finally always attach the device to the current domain if it is already
> set.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
