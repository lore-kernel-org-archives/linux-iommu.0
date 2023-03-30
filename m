Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6016A185D;
	Thu, 30 Mar 2023 06:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680157449; x=1711693449;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jVr0dYel8qkhyPeKaWDPWFi/TapwzzsP8wpn7pXnoF8=;
  b=RzzrsRtN48DX23zI5T7v6Jh+7jChDl/hRMY2usI12kS35D59AZ5v+fKq
   II5CLVHQ3aUVXtzWuxc/2Uy4zgNh1xumIa6XB2i/peMmLsNgM/MJY19v3
   FmHOS3lOxfaoyVMym27ZG5AiiiVgZJziDa6Th4el8RzVAo7Jizl8mtQXu
   5VLHefqM+/3/ceYhuYRIzSwgP5uz5gIjSlA8e46TiwJPs9qeHvWoaY7u/
   k7WTzCLnazgKNwxrXn6HW+Y+T48WLgfZtE3K0csbbM+9IZu7BNEYBxjr7
   4oUxTwh7/SJAXgHpU0Ic1Mx1YL7DycDx07PqmgUIRIxcLvUWJj6qCQvTF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="325003321"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="325003321"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 23:24:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="773866281"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="773866281"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2023 23:24:05 -0700
Message-ID: <8fb79c29-176b-fa76-b8e4-58df7cabc153@linux.intel.com>
Date: Thu, 30 Mar 2023 14:24:21 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 06/14] iommu: Replace __iommu_group_dma_first_attach()
 with set_domain
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>
References: <6-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <6-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/30/23 7:40 AM, Jason Gunthorpe wrote:
> Prepare for removing the group->domain set from
> iommu_group_alloc_default_domain() by calling
> __iommu_group_set_domain_internal() to set the group->domain.
> 
> Add IOMMU_SET_DOMAIN_WITH_DEFERRED to allow it to do the attach_deferred
> logic.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
