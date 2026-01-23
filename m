Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C469821FF48;
	Fri, 23 Jan 2026 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190613; cv=none; b=fcfAUc6QH0KlvdD8q/WCRC1zmDKX4IEZMBKoQM7gYMFmjUDQ2G75EJ8eMIa8aoTNMCLwVw8zRd3SSSVV7CyW37ruSiRd10BG2J52m0lhC1ka4IHQm4Q9FiKrPk4x9HYqQlXQZbOOiCTkIXq2bewy+wVXVE83O3rLaNSNiJwF3Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190613; c=relaxed/simple;
	bh=z3Bkw+uCwa+AmqSOg8BkgucGwYEm4VJUl7mTJocV5Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4EXLKAwK9CZtax3oqMxVwdoZxKnfrbcH4vzwTubV8/BEab0/AURRBI96TDFLaQFoEgg7nnCcxCCK/WEZX7ZxxwDQ4oqg0ary9uvIGllx5D5HaRP9EXKk6bHLoYJF7f5BVrnonjNrG4XoJaHT9GrWQnH9x27CV8kMelafqtFKnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kls8J8Jc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kls8J8Jc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A758DC4CEF1;
	Fri, 23 Jan 2026 17:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769190613;
	bh=z3Bkw+uCwa+AmqSOg8BkgucGwYEm4VJUl7mTJocV5Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kls8J8JcGWnLYZ1oI/Gbuulwg2rMGumK3WW/nshCN6eLZwwh+kAqca8tNMthI9M+n
	 bfUVJoInxPWzmg1Iplv3IwMHSa7RbNAFWyQID12LTGLXROthWfvsXArkMrppiKyNLg
	 VGIbhPJqdB6c9srdKrpgyl/9jUHc4XiL18+tvXSb5DhaCTSiz9edo28rzWfxjvQjox
	 GrhRl+m34X3dlZgqrqZuRmm/SRpC08GeGA2eXTsSf4EabE3I/fSct5+x9RoLQlh8do
	 MmwYrb9tcBOzRPm0yProMLQUqgZvZswr4aUro5J8+Z+ppcCczb5wfWLB9tc2lnk35e
	 OY/zFWkpR5c7Q==
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	robin.murphy@arm.com,
	joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skolothumtho@nvidia.com,
	praan@google.com,
	xueshuai@linux.alibaba.com,
	smostafa@google.com,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH rc v7 0/4] iommu/arm-smmu-v3: Fix hitless STE update in nesting cases
Date: Fri, 23 Jan 2026 17:49:51 +0000
Message-ID: <176917607019.801728.614554722771260022.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1768501336.git.nicolinc@nvidia.com>
References: <cover.1768501336.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 15 Jan 2026 10:23:27 -0800, Nicolin Chen wrote:
> Occasional C_BAD_STE errors were observed in nesting setups where a device
> attached to a nested bypass/identity domain enables PASID.
> 
> This occurred when the physical STE was updated from S2-only mode to S1+S2
> nesting mode, but the update failed to use the hitless routine that it was
> supposed to use. Instead, it cleared STE.V bit to load the CD table, while
> the default substream was still actively performing DMA.
> 
> [...]

Applied to iommu (arm/smmu/updates), thanks!

[1/4] iommu/arm-smmu-v3: Add update_safe bits to fix STE update sequence
      https://git.kernel.org/iommu/c/2781f2a930ab
[2/4] iommu/arm-smmu-v3: Mark STE MEV safe when computing the update sequence
      https://git.kernel.org/iommu/c/f3c1d372dbb8
[3/4] iommu/arm-smmu-v3: Mark EATS_TRANS safe when computing the update sequence
      https://git.kernel.org/iommu/c/7cad80048595
[4/4] iommu/arm-smmu-v3-test: Add nested s1bypass/s1dssbypass coverage
      https://git.kernel.org/iommu/c/a4f976edcb87

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
