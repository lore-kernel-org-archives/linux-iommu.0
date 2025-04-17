Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D36253B4E;
	Thu, 17 Apr 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900070; cv=none; b=i+2l2hGkzJL+30nam++ASAUu5kgdgb+Su+OL9NzVzBn9WnXKJDmeKy72158+Ma3ZSfBnyIYQL0YVccQ4KYAgf6mgzF6GLyg0y1HH/MmGL9VzVlOtbnlnZtc7ehbl3W+v7ll6OjTkJF4F2EjbFiPFyXsM76hcWKjFTzhSaV5AziM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900070; c=relaxed/simple;
	bh=dc5THRs8sdex1tXpUYXJFytKr+HWzkUjxR2SoRX8SVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCoT9fZD7DJOkmZq9qquoe6AFkSHRNiwj7UlOv6kJPv6QwytgyLYXevqoPN/uKDIUak+0oXDj4GuYtkvenXRLWDsdDIKROIlAajTNzM9lOvwrwtHPbrzZANRQg6+MaUoJcLbk3ZR8F/X3Nr7rnUgh8DI4X/LaDPdLxs2J1b5Y18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTAmqGb2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTAmqGb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29725C4CEE4;
	Thu, 17 Apr 2025 14:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744900070;
	bh=dc5THRs8sdex1tXpUYXJFytKr+HWzkUjxR2SoRX8SVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pTAmqGb2VhdyDPzKrYxl4sy0eu+nrlgai2NDGms5O7IxhEeKWhSLIA5mRbOzLx/ae
	 878wIImj2DW5TOws89L5jxNJev6TTlEHLrTllp12Ws9uQEg6nvWgJpVxDbkAuR0OZR
	 wOX/2pW8Ryu3ulaIR3dtj6SDUfd0evA9JM1N0poGbh6aCLPLYhkIO7gynVFjvNczHN
	 l4WYquPCGOEwp9IRQisb/cszLAykQ0yrcmILVC98DJOz4rBUPt5zqbZ7+6bSny1Brr
	 A9ky51vSNET1Obz5Q29H0uDqRAnwS51HM/u8cuXk5qkEYdIgOnpD0YbRPbYZbU09cF
	 nycx5yngJzaqQ==
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux.dev,
	Balbir Singh <balbirs@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix pgsize_bit for sva domains
Date: Thu, 17 Apr 2025 15:27:26 +0100
Message-Id: <174488932359.908730.13983605983506218156.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250412002354.3071449-1-balbirs@nvidia.com>
References: <20250412002354.3071449-1-balbirs@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 12 Apr 2025 10:23:54 +1000, Balbir Singh wrote:
> UBSan caught a bug with IOMMU SVA domains, where the reported exponent
> value in __arm_smmu_tlb_inv_range() was >= 64.
> __arm_smmu_tlb_inv_range() uses the domain's pgsize_bitmap to compute
> the number of pages to invalidate and the invalidation range. Currently
> arm_smmu_sva_domain_alloc() does not setup the iommu domain's
> pgsize_bitmap. This leads to __ffs() on the value returning 64 and that
> leads to undefined behaviour w.r.t. shift operations
> 
> [...]

Applied to iommu (arm/smmu/fixes), thanks!

[1/1] iommu/arm-smmu-v3: Fix pgsize_bit for sva domains
      https://git.kernel.org/iommu/c/12f78021973a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
