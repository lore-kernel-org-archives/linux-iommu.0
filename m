Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ADA19E980;
	Thu, 12 Sep 2024 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726138215; cv=none; b=Lowf53JE00XnZWeCtM/yLrk/8YDh7i5eYsU2YKHrabrnBlb3HYFH+FYvOWjFB4R4RySkjwsaPWlmFTFicakn1WB9yPfYB6K5OChEIMMwHLTRgxkE3k/JIBcwtG78Ct+0RiMIHpOqC61c7paMrhJdOXj8ERWXa9bOEVZjOwxGyo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726138215; c=relaxed/simple;
	bh=UWFisCX+sP/FaVH9HnCW6SytHIDbBrmpiDvtn7Hz5v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tX/8naZDUh6tnQHrNdn+UB/wSZzEqPmIgUHrkM/pfmhtGLQcrLmCHDIhYBSVJLogC70Jg28Wi42xJLvOfj6Xi1MmowS3SXH1fm2jVXiqoQkAjvDv3mdcs8OfZz5HAr10HdidsVvFPq3OecLXmGZpACUBqcucTUKTOgjhyAPgfl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txyInzL2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txyInzL2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F10DC4CEC3;
	Thu, 12 Sep 2024 10:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726138215;
	bh=UWFisCX+sP/FaVH9HnCW6SytHIDbBrmpiDvtn7Hz5v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=txyInzL2qqrbBqay2W29wImzJWkeTAgAsudRseh/S/q+yCXLm7ChXt/pc0BT0KUx/
	 IDcBj7iaNRsKOzLPdssblGGTbKiNvl8M/7ZMSTPRslxQrk/S93jvWwNI4FjFnfdg1A
	 s1GUq1p0+qYje+edihX6i0NDLOSoEPfWm1TTA92ZmZCJEw2kknQ/la0Pg1QJczagXA
	 tUJdjJyucazFqGIQj7Z84MbfJWiG6RRduH+lOBTJirsgJKATmM8i6bKieWB9Dos6If
	 rNQEwiZo560q6Ny9ZVlInoGRaytCp8Fk1HymShREHmmFBOww6SrxXSDg8dDK2g7/8a
	 vE6Ze6Wv7clXg==
Date: Thu, 12 Sep 2024 13:50:09 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH] dma-mapping: reliably inform about DMA support for IOMMU
Message-ID: <20240912105009.GI4026@unreal>
References: <7bbedc085ce87b121b9d0cb33eca8fba2fbdddbc.1726049194.git.leonro@nvidia.com>
 <20240912072954.GC7614@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912072954.GC7614@lst.de>

On Thu, Sep 12, 2024 at 09:29:54AM +0200, Christoph Hellwig wrote:
> Thanks, I've applied this.  I do like the flow of dma_supported even
> less with the duplicate condition now.  Can I get a quick review for
> this incremental cleanup, please?
> 
> ---
> From d311bfe189d12a836b4add55fdb946f37f8697fa Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Thu, 12 Sep 2024 09:21:18 +0200
> Subject: dma-mapping: reflow dma_supported
> 
> dma_supported has become too much spaghetti for my taste.  Reflow it to
> remove the duplicate use_dma_iommu condition and make the main path more
> obvious.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/mapping.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)

Reviewed-by: Leon Romanovsky <leon@kernel.org>

> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 022d670f8cad29..cd2a97d362cd24 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -841,20 +841,23 @@ static int dma_supported(struct device *dev, u64 mask)
>  {
>  	const struct dma_map_ops *ops = get_dma_ops(dev);
>  
> -	if (WARN_ON(ops && use_dma_iommu(dev)))
> -		return false;
> -
> -	if (use_dma_iommu(dev))
> +	if (use_dma_iommu(dev)) {
> +		if (WARN_ON(ops))
> +			return false;
>  		return true;

You can write it as "return !WARN_ON(ops);" if you want to be fancy, but
your version is perfectly fine too, so ignore this comment :).

> +	}
> +
>  	/*
> -	 * ->dma_supported sets the bypass flag, so we must always call
> -	 * into the method here unless the device is truly direct mapped.
> +	 * ->dma_supported sets and clears the bypass flag, so ignore it here
> +	 * and always call into the method if there is one.
>  	 */
> -	if (!ops)
> -		return dma_direct_supported(dev, mask);
> -	if (!ops->dma_supported)
> -		return 1;
> -	return ops->dma_supported(dev, mask);
> +	if (ops) {
> +		if (!ops->dma_supported)
> +			return 1;

Worth to change it to be "return true;"

> +		return ops->dma_supported(dev, mask);
> +	}
> +
> +	return dma_direct_supported(dev, mask);
>  }
>  
>  bool dma_pci_p2pdma_supported(struct device *dev)
> -- 
> 2.45.2
> 
