Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2543362;
	Thu, 13 Apr 2023 02:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681353341; x=1712889341;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6fOgzRG9nuM9iH6ZDFsLHVTkMRSDMEanIDS1hjFQLvQ=;
  b=OBElr4oC9hq/06AhPtKDud/PbT3wKwWOlzfmgfXwaE818rKVQb/Fn8S1
   5pDhu55dvk05gtjbLMcILFjbb+fY5gvA1UsClKrOZvh60IYPXVxERjAvk
   p6WGF6ngnMshkAtfYmp7kGLJ1csPd/SF6ig2gYWR+4zZE2zPgIdpcsuCn
   KzT7ZKYsBRWjsOgYwTAKVzY4ueZFjqMGq1R2ELuOzuxULON1xgIdewl42
   jcPUAn5CUCyKAx7Z1kld5sVHKcHh1YYKerNaoNdxhMle4hWS4JSGbuSTw
   A+S6EJfoKY9H4m2avsZRac0yuxTQaPJdFAcuYSIXvxzH3C0yBilwZN/ri
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332774132"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332774132"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 19:35:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="863543148"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="863543148"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga005.jf.intel.com with ESMTP; 12 Apr 2023 19:35:36 -0700
Message-ID: <69dade67-fde6-15bb-bf2f-2879554c5852@linux.intel.com>
Date: Thu, 13 Apr 2023 10:35:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v4 06/17] iommu: Replace __iommu_group_dma_first_attach()
 with set_domain
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>
References: <6-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <6-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/12/23 9:51 PM, Jason Gunthorpe wrote:
> Reorganize the attach_deferred logic to set dev->iommu->attach_deferred
> immediately during probe and then have __iommu_device_set_domain() check
> it and not attach the default_domain.
> 
> This is to prepare for removing the group->domain set from
> iommu_group_alloc_default_domain() by calling __iommu_group_set_domain()
> to set the group->domain.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
