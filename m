Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE3825D208;
	Fri, 23 Jan 2026 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188042; cv=none; b=QVacF1DQIjnNaY0wJjQXicjV+SZ205bbrEKnV9z9PngVCYrH67vUbD0Ot7ssA8gO8NBYplaXrk9sGZcQ69dny8QrvqJdUXmcZtMclqCC6k2N4fnLPXRvYp3f5EbPVEBR95t8gR2mhmfykjJ3pf1eHbOTOfnFAHFBGz4upYuUV8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188042; c=relaxed/simple;
	bh=9rUMilIkpNWtjs/T2EfzZx31jZHYz4VdqIi8b2c0JrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krxR8jF3Mr+r/JiSpz/WEXeHfoDlDCcPeTQtPiMvCldhQ4IHK12BAk89+YarUhWeILwtUVsfNf6IJypVuk4RCrG9alpKU4P/69Rf7Uxlb8YusESagI5Cq0MohMPvb/CYgGTrDrhxYR4T7gihB5j/3BlJn8RohF927mHibYbJFjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msNaMqX6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msNaMqX6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F0EC4CEF1;
	Fri, 23 Jan 2026 17:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769188041;
	bh=9rUMilIkpNWtjs/T2EfzZx31jZHYz4VdqIi8b2c0JrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=msNaMqX6KYDUOvOEOGX9DVjUrkfHhPyna2/uTUXTB1Mfn+jEouENQNmTCEeDZsCUQ
	 7SEUmcw+ZzoflGOLJj6bzpvd15muSZMZusyAh16GZxVIHtyyCAfsIKaB+aztqt0iBc
	 1T+jQA2nkNA+9mqK+3Fpl1Ur8V8EHOECXJNmRyAyOU4rsuRPcajnBjjAhYMjlv5HnA
	 YEuyQ+5VMes+kenXZydHFB/m8Cb6C7qahbmGdBLHQco0BTexSVJx85JvQ4fIkhYxiy
	 1+EckLMegEbN8q7kcDmD9JKuBndnt0J0TsZb2yDqbrDuitgksHiCrdW7gimjgfIwVg
	 LWPxkLhqs6vDw==
Date: Fri, 23 Jan 2026 17:07:15 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	jgg@nvidia.com, balbirs@nvidia.com, miko.lenczewski@arm.com,
	peterz@infradead.org, kevin.tian@intel.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 7/7] iommu/arm-smmu-v3: Perform per-domain
 invalidations using arm_smmu_invs
Message-ID: <aXOqwymxe-nzYpwU@willie-the-truck>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <308ed579c724879a4a20b19ccdcb33e917597d77.1766174731.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <308ed579c724879a4a20b19ccdcb33e917597d77.1766174731.git.nicolinc@nvidia.com>

On Fri, Dec 19, 2025 at 12:11:29PM -0800, Nicolin Chen wrote:
> Replace the old invalidation functions with arm_smmu_domain_inv_range() in
> all the existing invalidation routines. And deprecate the old functions.
> 
> The new arm_smmu_domain_inv_range() handles the CMDQ_MAX_TLBI_OPS as well,
> so drop it in the SVA function.
> 
> Since arm_smmu_cmdq_batch_add_range() has only one caller now, and it must
> be given a valid size, add a WARN_ON_ONCE to catch any missed case.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   7 -
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  29 +--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 165 +-----------------
>  3 files changed, 11 insertions(+), 190 deletions(-)

It's one thing replacing the invalidation implementation but I think you
need to update some of the old ordering comments, too. In particular,
the old code relies on the dma_wmb() during cmdq insertion to order
updates to in-memory structures, which includes the pgtable in non-strict
mode.

I don't think any of that is true now?

Will
