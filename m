Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6673D78
	for <iommu@lists.linux.dev>; Fri, 18 Nov 2022 14:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3477C433D6;
	Fri, 18 Nov 2022 14:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668782518;
	bh=3BDUgvBxoQ6ynhU3RnNM6d/uQAhJoqBegUWUv1fw6pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMfhy0Ouxk07x5LpFTwZ6qamu7YafxPQWbmPcTnp3+25K+npppvxKdVCvCZVCOOQc
	 fBE7Rz+YsIJRrFV5Zr5lJvYrdOcPSSMmHpntFpb49rp3AzQQusHTuBsSfp8IsFgC/Q
	 0E2U7DG+PmNe+fwu3mVLpXxRfOwJksTm3JCMv7hsgs3W00YBPB6cZyFYp4JFKOEaTb
	 +AXgZY9PixlSDCiFnRel54WbH15Q2d+SKGMOTwgPHv6F5v7aiOmy5aaSHvh/QoVrS2
	 J4mLDg0dhdiVKzoDzw0WANVdvuTigmOic1N3xVXzc7UJNapvxlk751SPTcP7FIYYZm
	 OmXaV7CePD8tA==
Date: Fri, 18 Nov 2022 14:41:53 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, robdclark@gmail.com,
	yong.wu@mediatek.com
Subject: Re: [PATCH 0/9] iommu: {map,unmap}_pages cleanup
Message-ID: <20221118144153.GA4624@willie-the-truck>
References: <cover.1668100209.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1668100209.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Nov 15, 2022 at 03:26:34PM +0000, Robin Murphy wrote:
> Here's a couple more strands of cleanup along a common theme. With the
> original pgsize_bitmap trick for multi-page mappings long gone from
> Intel and now getting cleaned up from s390 as well, the first two
> patches here convert the remaining instances of that to the proper new
> multi-page interfaces. The rest then convert the remaining users of the
> io-pgtable API, so we can clean up the old interfaces entirely at that
> level.
> 
> Cheers,
> Robin.
> 
> 
> Robin Murphy (9):
>   iommu/mediatek-v1: Update to {map,unmap}_pages
>   iommu/sprd: Update to {map,unmap}_pages
>   iommu/mediatek: Update to {map,unmap}_pages
>   iommu/msm: Update to {map,unmap}_pages
>   iommu/ipmmu-vmsa: Update to {map,unmap}_pages
>   iommu/qcom: Update to {map,unmap}_pages
>   iommu/io-pgtable-arm: Remove map/unmap
>   iommu/io-pgtable-arm-v7s: Remove map/unmap
>   iommu/io-pgtable: Remove map/unmap
> 
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 14 +++++----
>  drivers/iommu/io-pgtable-arm-v7s.c      | 41 +++++++++---------------
>  drivers/iommu/io-pgtable-arm.c          | 42 +++++++++----------------
>  drivers/iommu/ipmmu-vmsa.c              | 18 +++++------
>  drivers/iommu/msm_iommu.c               | 18 ++++++-----
>  drivers/iommu/mtk_iommu.c               | 15 ++++-----
>  drivers/iommu/mtk_iommu_v1.c            | 30 +++++++++---------
>  drivers/iommu/sprd-iommu.c              | 25 ++++++++-------
>  include/linux/io-pgtable.h              |  6 ----
>  9 files changed, 94 insertions(+), 115 deletions(-)

Thanks for doing this. For the lot:

Acked-by: Will Deacon <will@kernel.org>

Will
