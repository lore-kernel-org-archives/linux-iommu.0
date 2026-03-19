Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7324E3AA4E5;
	Thu, 19 Mar 2026 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937589; cv=none; b=vFFe4ipzKRywXR2qCtp4f8E8R+2rz6SRAD9UXONEZ1z5sjrrkj1nNJdXsO3g+IapuYH6KZgLB6OwB4LqrS0DzcVfCUuGA2A55NCbz7cQpq2gPNT6QT+hTQADWeYUSGV0Nq4gX43Fuy/X9y9tYU6uCj7jTY71SbRDhpt+Fa88R0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937589; c=relaxed/simple;
	bh=3unA1PwfL2Fg34GNfzHISq0EoNO+jPqZ9/aavZeuSeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ilYs84dn7WX2E5dsLubBu73MM9CVLEFrRuW+nvBCf5NleRSn/4qsKdk/wkMWs4ontNoHHEkdUPszIPN9QGVcpxV60LxyJpO/GeAG0U1JN8vITXRIT+ZpYDlIq0n6VezhgPphxPVKf1q8gnkThf4FeD+iLyIAPrBYnBaI+o+3g1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulPuAquR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulPuAquR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D861C19424;
	Thu, 19 Mar 2026 16:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773937588;
	bh=3unA1PwfL2Fg34GNfzHISq0EoNO+jPqZ9/aavZeuSeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ulPuAquROn7u7UJkt+WmVJuX2QSMIFnI/wXrEBxU3zlx3/2XY2nlFL20ONFJcV6yW
	 0fgO9FZT+oL5LSRfe1G/l+wR+fdVqSCaniIXj2pADxaaGznmz/jZuOEBRbNcV4DTqB
	 /SrR0XigW3jph0Z9+P5uQLQDrRXVdv1PvHRIJqsqlnQYfh1d9J8riYPHChCAzdloIf
	 APnPh6c6ozB++4I64/iYh9hNqxUb90fS4OTGWl322yypVol4lRIFdHAk/GCYw5uSRx
	 HzxqGIW7nMU/YvclTmOzzyBKqm5HINfj/Oeg8n4MwYJb4CjyjlwdP84EebHJv8Dk08
	 NLttWWNmGcLPA==
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	jpb@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	balbirs@nvidia.com,
	praan@google.com,
	miko.lenczewski@arm.com,
	smostafa@google.com,
	xueshuai@linux.alibaba.com,
	baolu.lu@linux.intel.com,
	kevin.tian@intel.com,
	mshavit@google.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v13 0/8] iommu/arm-smmu-v3: Introduce an RCU-protected invalidation array
Date: Thu, 19 Mar 2026 16:26:09 +0000
Message-ID: <177393290314.3824125.1547121281315179805.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773733797.git.nicolinc@nvidia.com>
References: <cover.1773733797.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 17 Mar 2026 00:59:15 -0700, Nicolin Chen wrote:
> This is a work based on Jason's design and algorithm. This implementation
> follows his initial draft and revising as well.
> 
> The new arm_smmu_invs array is an RCU-protected array, mutated when device
> attach to the domain, iterated when an invalidation is required for IOPTE
> changes in this domain. This keeps the current invalidation efficiency of
> a smb_mb() followed by a conditional rwlock replacing the atomic/spinlock
> combination.
> 
> [...]

Applied to iommu (arm/smmu/updates), thanks!

[1/8] iommu/arm-smmu-v3: Add a missing dma_wmb() for hitless STE update
      https://git.kernel.org/iommu/c/6fabce53f6b9
[2/8] iommu/arm-smmu-v3: Explicitly set smmu_domain->stage for SVA
      https://git.kernel.org/iommu/c/9b056856880a
[3/8] iommu/arm-smmu-v3: Add an inline arm_smmu_domain_free()
      https://git.kernel.org/iommu/c/c317452f5a22
[4/8] iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array
      https://git.kernel.org/iommu/c/15a2a5645ad7
[5/8] iommu/arm-smmu-v3: Pre-allocate a per-master invalidation array
      https://git.kernel.org/iommu/c/e3a56b37bf75
[6/8] iommu/arm-smmu-v3: Populate smmu_domain->invs when attaching masters
      https://git.kernel.org/iommu/c/b77429757e45
[7/8] iommu/arm-smmu-v3: Add arm_smmu_invs based arm_smmu_domain_inv_range()
      https://git.kernel.org/iommu/c/587bb3e56a2c
[8/8] iommu/arm-smmu-v3: Perform per-domain invalidations using arm_smmu_invs
      https://git.kernel.org/iommu/c/4202fddd01c7

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
