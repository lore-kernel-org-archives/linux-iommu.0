Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E73036F;
	Thu, 13 Apr 2023 02:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681354075; x=1712890075;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XOYWrIuWmPhD/dw8MDIZHISrCktGP1NC1l9OIigiuHw=;
  b=XMUqQIghjqXEI9cBWTFq9spzdE7hIcUaAK4K8bBm7c/fKPufefCdBgFs
   ZC0lCHntAxNhsrsr5534nodzs1PCCLI5xML8DNLxyqZ7kddRCp0zq6eKh
   BwbHOVs6S5szMF/aLqRom4FKnqa8Ff0Mfe0GigXKBZIx9MC2nNVVsDmDF
   5rLBZQLhQH2NaM7YzkcrV0brSxfl7OrbvrZ9gbsOoGsBeEeTMAydTMC/k
   l6Mkl9TtQ7s9sUU3biq/4kz3kf6mXGOfCdYryjgidfn8fbZrqLLup5Mqm
   QmCnriA2SAFR8fOnSaeuFmK0vu5JqEewJPM0VkmBpudMumvi+bx76YMNM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="328184507"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="328184507"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 19:47:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="666580960"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="666580960"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga006.jf.intel.com with ESMTP; 12 Apr 2023 19:47:50 -0700
Message-ID: <3d26952d-1658-2e66-3802-f590f83fcc12@linux.intel.com>
Date: Thu, 13 Apr 2023 10:47:54 +0800
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
Subject: Re: [PATCH v4 13/17] iommu: Revise iommu_group_alloc_default_domain()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>
References: <13-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <13-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/12/23 9:51 PM, Jason Gunthorpe wrote:
> Robin points out that the fallback to guessing what domains the driver
> supports should only happen if the driver doesn't return a preference from
> its ops->def_domain_type().
> 
> Re-organize iommu_group_alloc_default_domain() so it internally uses
> iommu_def_domain_type only during the fallback and makes it clearer how
> the fallback sequence works.
> 
> Make iommu_group_alloc_default_domain() return the domain so the return
> based logic is cleaner and to prepare for the next patch.
> 
> Remove the iommu_alloc_default_domain() function as it is now trivially
> just calling iommu_group_alloc_default_domain().
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
