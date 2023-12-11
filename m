Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C1DD26F
	for <iommu@lists.linux.dev>; Mon, 11 Dec 2023 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="fyk7kIc4"
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4644A1A3EBC;
	Mon, 11 Dec 2023 15:26:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1702304766;
	bh=UyXsrtxXe8Bu737sErNNkhy+m06YJJxxgsCmOUR4Up8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyk7kIc4G69aVELPj/GrPysrj78By8BPLmMjVe3wbs+/I9PpyuEPSqhdVBByn+jaz
	 Ey8bQ3D6sC5Sh4i+NJhoOY6TvMCZQmdEnbCnnrbyBTv8GwfN4VJkWUwLegmI+sZToS
	 mhHZ86K4ZDzlBk3Yk6qRMuweFSRY/rg60UMyW37affqhM3LgbioHrtzKGPA2yqS7PS
	 lQY5y6qtS188Oqm/pDsJ5rCLL0sOD/M1Vaph5r52Y6PcWOoyWT9T8WQR1hhd+IPJIW
	 vDTw0Rbo3ponJwLcBfyWwScIiNfaFazWmjGxoiJYVGUDYzSrKw6OqbK+HfozFohFjk
	 18QCbsEJks6fA==
Date: Mon, 11 Dec 2023 15:26:05 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com, jgg@ziepe.ca
Subject: Re: [PATCH v2 0/9] Improve TLB invalidation logic
Message-ID: <ZXcb_coNiIqdLjzT@8bytes.org>
References: <20231122090215.6191-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122090215.6191-1-vasant.hegde@amd.com>

On Wed, Nov 22, 2023 at 09:02:06AM +0000, Vasant Hegde wrote:
> Vasant Hegde (9):
>   iommu/amd: Rename iommu_flush_all_caches() -> amd_iommu_flush_all_caches()
>   iommu/amd: Remove redundant domain flush from attach_device()
>   iommu/amd: Remove redundant passing of PDE bit
>   iommu/amd: Add support to invalidate multiple guest pages
>   iommu/amd: Refactor IOMMU tlb invalidation code
>   iommu/amd: Refactor device iotlb invalidation code
>   iommu/amd: Consolidate amd_iommu_domain_flush_complete() call
>   iommu/amd: Make domain_flush_pages as global function
>   iommu/amd/pgtbl_v2: Invalidate updated page ranges only
> 
>  drivers/iommu/amd/amd_iommu.h       |   8 +-
>  drivers/iommu/amd/amd_iommu_types.h |   6 -
>  drivers/iommu/amd/init.c            |   8 +-
>  drivers/iommu/amd/io_pgtable.c      |   5 +-
>  drivers/iommu/amd/io_pgtable_v2.c   |  10 +-
>  drivers/iommu/amd/iommu.c           | 163 ++++++++++++----------------
>  6 files changed, 88 insertions(+), 112 deletions(-)

Applied, thanks.
