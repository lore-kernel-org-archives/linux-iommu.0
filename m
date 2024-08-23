Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055C188A3E;
	Fri, 23 Aug 2024 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428442; cv=none; b=La7B0+kqRrS1wx1JPx2ptuXr3EHpOHTKejW3dm8sdg8iELCA/cQkXDFvA0Yr7E13O0m6E9l9OzT8h9qISr3Ha5paELI8yesuTqFyeUpkWKRKwUxWi9Iy4maYgaanPF5vTSh8DxFwPRv4wuUCY3Tr/pXX9X0v3wFvVa9psW6R+5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428442; c=relaxed/simple;
	bh=Oknf7Bh9HhKv0p492TrRsH9RWzKQ8QEpPRIapU/vtx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZ19FxZR5oGJNn30sNj2EULOnnTCSNL6h+PZbz8/neS0h8S91YrF9Qpi22pvGf4aRXUx/rTV9S89aCOELwYq6bTy0GDgWsH++pB37Lb6XXYhapFQoGJFrB53kN50EO9IOGX/cCCHCpiVKw7JqUnMZLgQed3D+ixR/oNU28wVSq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOaBFcd8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOaBFcd8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0485C32786;
	Fri, 23 Aug 2024 15:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724428442;
	bh=Oknf7Bh9HhKv0p492TrRsH9RWzKQ8QEpPRIapU/vtx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LOaBFcd86Xy8xkLlgveZzv5oo4gHNIAjYJKRrV+TC2Bha+Q2oqc9RS+z+rkF4CG2r
	 B5sh76TgNhE4pN1HNDODQfBdpvhseP3oeLf/V0phOsnkC5hYiwMbjJsfMPriDnpFr1
	 1EElvFr60JqEx3pGRRsrwoGDMLKE7F2QsZnMtzWB5Q/WS/hPsK4+GUslyCRxbLUGht
	 XO+yjRD7jZRykvbhuEAS1i5EBdSN5H5NjKTvTxqSBV4T7lUoAzYdSgLPfQhTWXGw2D
	 QHPbQkcTkw6x9vSWAi+n/+lSqRlxg5S//qG88Jksy+7Ri/hrEtpjWPn2zUoehjlYa9
	 jvQ1MPNHFTRYA==
Date: Fri, 23 Aug 2024 16:53:57 +0100
From: Will Deacon <will@kernel.org>
To: Ashish Mhetre <amhetre@nvidia.com>, joro@8bytes.org
Cc: robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH V4] iommu/io-pgtable-arm: Optimise non-coherent unmap
Message-ID: <20240823155357.GC525@willie-the-truck>
References: <20240806105135.218089-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806105135.218089-1-amhetre@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Aug 06, 2024 at 10:51:35AM +0000, Ashish Mhetre wrote:
> The current __arm_lpae_unmap() function calls dma_sync() on individual
> PTEs after clearing them. Overall unmap performance can be improved by
> around 25% for large buffer sizes by combining the syncs for adjacent
> leaf entries.
> Optimize the unmap time by clearing all the leaf entries and issuing a
> single dma_sync() for them.
> Below is detailed analysis of average unmap latency(in us) with and
> without this optimization obtained by running dma_map_benchmark for
> different buffer sizes.
> 
> 		UnMap Latency(us)
> Size	Without		With		% gain with
> 	optimiztion	optimization	optimization
> 
> 4KB	3		3		0
> 8KB	4		3.8		5
> 16KB	6.1		5.4		11.48
> 32KB	10.2		8.5		16.67
> 64KB	18.5		14.9		19.46
> 128KB	35		27.5		21.43
> 256KB	67.5		52.2		22.67
> 512KB	127.9		97.2		24.00
> 1MB	248.6		187.4		24.62
> 2MB	65.5		65.5		0
> 4MB	119.2		119		0.17
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
> Changes in V2:
> - Updated the commit message to be imperative.
> - Fixed ptep at incorrect index getting cleared for non-leaf entries.
> 
> Changes in V3:
> - Used loop-local variables and removed redundant function variables.
> - Added check for zero-sized dma_sync in __arm_lpae_clear_pte().
> - Merged both patches into this single patch by adding check for a
>   NULL gather in __arm_lpae_unmap() itself.
> 
> Changes in V4:
> - Updated the subject in commit message to correctly reflect the changes
>   made in this patch.
> ---
>  drivers/iommu/io-pgtable-arm.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Joerg, please can you pick this one up for -next?

Cheers,

Will
