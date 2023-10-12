Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D3426E33
	for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwzo08fu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF889C433C8;
	Thu, 12 Oct 2023 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697115471;
	bh=Ok28SdhAWW1nvMtIM0V7FGuq4sgQwHbgRzFRQZos3eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwzo08fucF91DIEhvRvfXhMNnJ9L1KcNM2Ht+7wU+42fegJWJqnkRU9lBWCSRTUtJ
	 iqHRhGvLvlzvJraz/+HnhcM6RSJ7mLvjtuWzt9BmSfLQMmEJeZrh2EGs+h7sP4FZgL
	 mlaRa4DNCZucToVO1rNeGdGNMfahw/pE6xcXyGl3QvAG/Medx+PISc1PD1RAAewdiN
	 CDTBYLArI7ySh6l4y0BNZelwyuFmAs8y72Jmf9hdBzaNN3+nnxc+m+6uWkgd5ieed9
	 eVT08lDYcmKz67eeiSx36fYOAXfO4sfKQKkqccXaHxqC20M+O8Y/Go3Mo3lpYGtJUU
	 UaO7HQpqymbRw==
Date: Thu, 12 Oct 2023 13:57:46 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev, jgg@nvidia.com,
	baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/7] iommu: Clean up open-coded ownership checks
Message-ID: <20231012125746.GB12142@willie-the-truck>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <0d68867cec0fb90578d50cc145f7f9a180407f20.1697047261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d68867cec0fb90578d50cc145f7f9a180407f20.1697047261.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Oct 11, 2023 at 07:14:54PM +0100, Robin Murphy wrote:
> Some drivers already implement their own defence against the possibility
> of being given someone else's device. Since this is now taken care of by
> the core code (and via a slightly different path from the original
> fwspec-based idea), let's clean them up.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  3 ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  9 +--------
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 16 +++-------------
>  drivers/iommu/mtk_iommu.c                   |  7 +------
>  drivers/iommu/mtk_iommu_v1.c                |  3 ---
>  drivers/iommu/sprd-iommu.c                  |  8 +-------
>  drivers/iommu/virtio-iommu.c                |  3 ---
>  7 files changed, 6 insertions(+), 43 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
