Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CFB329E4F;
	Wed,  7 Jan 2026 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767820812; cv=none; b=jksPInQmu119wsjjHEqSDfary8g4bQdJf2qYFJEjWeWMVX5GEc/QYfBjoyytrjtYG0H6v1mLDJL4m0irGQS+FD1xlphsMG1sJBWGw0Zt+jIirN653WSy/Nx44Q43E+hTM2YV2FPpslJOWpkdALfh9Azas9ZtrSk4g+WcwMScJKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767820812; c=relaxed/simple;
	bh=XppcCCr54iQac7uOZIwfkqrMvFp+4S0tQ8tyUXRWq2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5mhgwocgARO+EvrJAibo/NvW3NSJna5QSbPWty+xTlH+QRvTGHml0A4nMs68tHbGEjGTlzY1mJFV0rrXwRTUP6BHymhraQJxt2KNZKzF94LpHC+SSqINrI0aw3pRn2ziYkDuv6CNGmZw+V0MlZUkoAKLRlnmdlgrVopaXOY/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1wVe3lE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1wVe3lE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8764C4CEF1;
	Wed,  7 Jan 2026 21:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767820811;
	bh=XppcCCr54iQac7uOZIwfkqrMvFp+4S0tQ8tyUXRWq2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H1wVe3lEekvn4ymad67HRPhWzdiop2wQhGm26cdCqx22b1BvLmgKeiSJ4/2uH71Bn
	 NOSQBLa/jH3ephtfi22M1EbcgBH/vO+GRoJLFfXA8OgufwHw+O3Wj327xQW1T4+oCY
	 fQ2HJaNKOvqXq9+JUr2fxEEo5liSzvjZ0eOi3IEOHEhDgLcbPxychrLr7G8/Gy3jcU
	 Yt/Qi+hfQMoFvzx7hjK9Dpgo4RvPmtUaU1zafl9XSkW0oj+bax07P1yvJa+eaQk2vf
	 VJNLqbURkMbkuw4T6kPr893I3Q5bI54FJGkdGbfGc39h6gS/WF+C24EosePea9gppA
	 6WVMSOTzlHmWA==
Date: Wed, 7 Jan 2026 21:20:06 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com, xueshuai@linux.alibaba.com, smostafa@google.com
Subject: Re: [PATCH rc v5 1/4] iommu/arm-smmu-v3: Add update_safe bits to fix
 STE update sequence
Message-ID: <aV7OBrH-TDiGRblt@willie-the-truck>
References: <cover.1766093909.git.nicolinc@nvidia.com>
 <58f5af553fa7c3b5fd16f1eb13a81ae428f85678.1766093909.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58f5af553fa7c3b5fd16f1eb13a81ae428f85678.1766093909.git.nicolinc@nvidia.com>

On Thu, Dec 18, 2025 at 01:41:56PM -0800, Nicolin Chen wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> C_BAD_STE was observed when updating nested STE from an S1-bypass mode to
> an S1DSS-bypass mode. As both modes enabled S2, the used bit is slightly
> different than the normal S1-bypass and S1DSS-bypass modes. As a result,
> fields like MEV and EATS in S2's used list marked the word1 as a critical
> word that requested a STE.V=0. This breaks a hitless update.
> 
> However, both MEV and EATS aren't critical in terms of STE update. One
> controls the merge of the events and the other controls the ATS that is
> managed by the driver at the same time via pci_enable_ats().
> 
> Add an arm_smmu_get_ste_update_safe() to allow STE update algorithm to
> relax those fields, avoiding the STE update breakages.
> 
> After this change, entry_set has no caller checking its return value, so
> change it to void.
> 
> Note that this change is required by both MEV and EATS fields, which were
> introduced in different kernel versions. So add get_update_safe() first.
> MEV and EATS will be added to arm_smmu_get_ste_update_safe() separately.
> 
> Fixes: 1e8be08d1c91 ("iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 ++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 18 ++++++++++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 27 ++++++++++++++-----
>  3 files changed, 37 insertions(+), 10 deletions(-)

Hmm. So this appears to ignore the safe bits entirely, whereas the
rationale for the change is that going from {MEV,EATS} disabled to
enabled is safe (which I agree with). So what prevents an erroneous
hitless STE update when going from {MEV,EATS} enabled to disabled after
this change?

Will
