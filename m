Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214161C744;
	Tue, 23 May 2023 06:16:32 +0000 (UTC)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8903B248122;
	Tue, 23 May 2023 08:16:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1684822591;
	bh=WOV2n4U1XIMeZwJcbGdXD+StZYMmpOBGIf0HW/AhkoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yOsIw/HNKRz7NZTV+Dz+GAALftR2NsDkqjh619hMmQ76AwVH0DeVdfiGYiWnd/u5X
	 3rpqnp1Px2m8aAuuh0iU3izkPYg1TR2XsekjUA8LGHgWDRmiAj6/MN57WhbNHNvRAB
	 NBkNHAzNGXHU9Pd7lsrNAPhYY0/xiUk2n8wFmtztA5uavRPxGKYGghc5qsOgZjCnwg
	 ePWz3dsvfYBVekareKjDEp/tmkdpT0qPq6jcR9v+mf6IVxRUUMev94vXsmUckdQVNH
	 0Llzz0TZeyArieW0KT8EpU1Xecph7v/FJ3/eQVJzOuuWFF8qO5s+VsKARoB1h4bH/q
	 xlDLkbDb46v+A==
Date: Tue, 23 May 2023 08:16:30 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH v5 00/17] Consolidate the error handling around device
 attachment
Message-ID: <ZGxaPkMNCnwVN5QZ@8bytes.org>
References: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>

On Thu, May 11, 2023 at 01:41:58AM -0300, Jason Gunthorpe wrote:
> Jason Gunthorpe (17):
>   iommu: Replace iommu_group_device_count() with list_count_nodes()
>   iommu: Add for_each_group_device()
>   iommu: Make __iommu_group_set_domain() handle error unwind
>   iommu: Use __iommu_group_set_domain() for __iommu_attach_group()
>   iommu: Use __iommu_group_set_domain() in iommu_change_dev_def_domain()
>   iommu: Replace __iommu_group_dma_first_attach() with set_domain
>   iommu: Remove iommu_group_do_dma_first_attach() from
>     iommu_group_add_device()
>   iommu: Replace iommu_group_do_dma_first_attach with
>     __iommu_device_set_domain
>   iommu: Fix iommu_probe_device() to attach the right domain
>   iommu: Do iommu_group_create_direct_mappings() before attach
>   iommu: Remove the assignment of group->domain during default domain
>     alloc
>   iommu: Consolidate the code to calculate the target default domain
>     type
>   iommu: Revise iommu_group_alloc_default_domain()
>   iommu: Consolidate the default_domain setup to one function
>   iommu: Allow IOMMU_RESV_DIRECT to work on ARM
>   iommu: Remove __iommu_group_for_each_dev()
>   iommu: Tidy the control flow in iommu_group_store_type()
> 
>  .clang-format         |   1 +
>  drivers/iommu/iommu.c | 683 +++++++++++++++++++++---------------------
>  2 files changed, 345 insertions(+), 339 deletions(-)

Applied, thanks Jason.
