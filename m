Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B2A2877ED;
	Wed, 10 Dec 2025 03:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765336586; cv=none; b=R7L0Tv9jPPkbwtDKpN8SCknACyvz2h2RPhbccsMMYlpuZWxb8KNpNQLhVHJhnblWKi7lCJD3GEBRgiatr3QUaqSiMutYguDP9PwOYw4uQ+aNA+HGdH64rRvrpP+P/rst1+YhesCNP6US+MrTI/PofLjBRzsaFLIJKtYiWzvEsvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765336586; c=relaxed/simple;
	bh=8EHolNA5kcb3cVvlThUvhptCIXxbGVAilC6PKrrgbt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MilUIxMGPOeb1GA9Hu0OsLaoBsTvyy0VimjvUlCJ2GXFXkiBKRCBqG3J63aO2delsrqaj/JFfBPamTq2YvKxtCwzZV9QvZuq+eAYs2cnq2ILqq1IpzVDyfkLQA3C5nvcXxleNe6L0T4ZB7Buqpa7/Y2//J/G8XIeCEYgBULGvHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfxenqYo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfxenqYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EA4C4CEF5;
	Wed, 10 Dec 2025 03:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765336584;
	bh=8EHolNA5kcb3cVvlThUvhptCIXxbGVAilC6PKrrgbt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JfxenqYomllyd0Wc3rRGibxuDKD8DqdVSDMOANLR9XQMyQmsjhUuvuYt38+Ic5Cxk
	 X61AUHBizU1O+TU1yFKOD7tcLq4di9jTp9KfxegWyyBL9tIqwcBHplTFN3ldlblEh3
	 n4ZtFul8f9MC4sRSYk+NL0u2i+oF6d4blg1ERri3pU91Aw/+q1GqJfmxNqfthosjRZ
	 NYylwIry/qaV7eNvy5dyg9bHDl+olJOIO1wNrLk7P/8afUPeHeTnVG8GPDEW1mOEvr
	 2ZAPXpiTKm03/p01SCIJ9Q5QkNZ3PEMB/VsGiT+EPcIB1ttJCiaK9J3mNsQ0VsKmIA
	 oju3g36bRQUtA==
Date: Wed, 10 Dec 2025 12:16:19 +0900
From: Will Deacon <will@kernel.org>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH v5 2/3] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Message-ID: <aTjmA_juSss36e8v@google.com>
References: <20251208212857.13101-1-jacob.pan@linux.microsoft.com>
 <20251208212857.13101-3-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251208212857.13101-3-jacob.pan@linux.microsoft.com>

On Mon, Dec 08, 2025 at 01:28:56PM -0800, Jacob Pan wrote:
> @@ -781,12 +771,21 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>  	local_irq_save(flags);
>  	llq.val = READ_ONCE(cmdq->q.llq.val);
>  	do {
> +		struct arm_smmu_queue_poll qp;
>  		u64 old;
>  
> +		/*
> +		 * Poll without WFE because:
> +		 * 1) Running out of space should be rare. Power saving is not
> +		 *    an issue.
> +		 * 2) WFE depends on queue full break events, which occur only
> +		 *    when the queue is full, but here we’re polling for
> +		 *    sufficient space, not just queue full condition.
> +		 */

I don't think this is reasonable; we should be able to use wfe instead of
polling on hardware that supports it and that is an important power-saving
measure in mobile parts.

If this is really an issue, we could take a spinlock around the
command-queue allocation loop for hardware with small queue sizes relative
to the number of CPUs, but it's not clear to me that we need to do anything
at all. I'm happy with the locking change in patch 3.

If we apply _only_ the locking change in the next patch, does that solve the
reported problem for you?

Will
