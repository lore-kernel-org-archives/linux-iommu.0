Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1FF2309B7
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427239; cv=none; b=cVMWozV82GvOHcymHpYEuwNMKymmeLJhzemNoZ4pj/NKh4yc6X38HIRpuEowtMCS/w1iP3TihPpgo2LejF7LG/+sT1F5I3KH0+46JPIpwRao4XUjipTy0drCzc08wpDFw+XRzywsRYdZ3x+Vpo3X0OOIjcd4SlkdJHu12sC8CrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427239; c=relaxed/simple;
	bh=jRptFKZ6EWwcd9gt1RnzMN4OZFAiMNrpYSjY4y96mqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVfp/0K5MUiuCrFTNuCUTgsSCGcg4SQHXPEQzIAa4ERfzuteosbU/NpC9qtPjizz0n/CBcuP0dKnddTIadRNaOmu28nKyAfMf4t52vByJVVLnwxKXuF/PPrPBClYGBoTme0X7y2uJQ/DKsX6HJZmVmj5XTD6fjSDmtojq9RvWyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzLgJLi0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzLgJLi0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1C3C4CECD;
	Tue, 12 Nov 2024 16:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731427239;
	bh=jRptFKZ6EWwcd9gt1RnzMN4OZFAiMNrpYSjY4y96mqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzLgJLi047fFA6CUYdWIWbsQwDTyAzZlZaSufd8HROXV5wqNtC2IVpEXtTEJIvp6X
	 JwRbhxC0eVMwgY6PIXlVEdaDxG1aFBkQaTUYWI3ovv5DvINBFTJLU8JepMudnjdvy9
	 Eatsx/2hTpEaLn8a+Od2X+slepsrXy7Qau6VY0WCH37fLbYRwYB3nnG/Qupix4dDyw
	 5l6iZnFd7kDUvYLQrLFBWdibsJamkMg7WS0RfzlzLzgRCCtjbeLZkGMlbijuUL4JQd
	 pYn/4vOKPCtcIepvnaA8xujmrTlaUl6gWlrfdrnPY0nCJ/iEkIPSPzUtBwE5jxKS7u
	 fqYIyupLS1RGg==
Date: Tue, 12 Nov 2024 16:00:35 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] iommu: Manage driver probe deferral better
Message-ID: <20241112160032.GD21479@willie-the-truck>
References: <cover.1731088789.git.robin.murphy@arm.com>
 <2da0ae7f76c7466176e906fa5d7a0ae5210e8650.1731088789.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2da0ae7f76c7466176e906fa5d7a0ae5210e8650.1731088789.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Nov 08, 2024 at 06:30:17PM +0000, Robin Murphy wrote:
> Since iommu_fwspec_init() absorbed the basic driver probe deferral
> check to wait for an IOMMU to register, we may as well handle the probe
> deferral timeout there as well. The current inconsistency of callers
> results in client devices deferring forever on an arm64 ACPI system
> where an SMMU has failed its own driver probe.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommu.c    | 2 +-
>  drivers/iommu/of_iommu.c | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
