Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ADCC144
	for <iommu@lists.linux.dev>; Sun, 22 Sep 2024 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727017338; cv=none; b=p24TQRSSSGaO7+GeFeRFkS+4paD/043Kw0FjoStxlPfRrVLm5xByTxd17g+eL+VCr0CYA47z/cPBgtrU6RnIsOUZ0+ZyFUcTQbUVwKhVCUabKfvLJKZXk5jkzsxU43Q6nEEr/KAJKx/NK9xmty4lBf/shdUQKsptw2VSWkzx0do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727017338; c=relaxed/simple;
	bh=4F00RqovIfyrSd5mQuI2EuhP8uxKErvLYeEpb8/EpBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNm+rSPWCNxjK3a/oZm8MtiFWj2LStlpM8m4erHQP3WZSDqpJKbHsuIHacxAhz4aTaWnh6382cz4WDIQbTZWn5jxGtqVrcX6wiiVCgJsa7mwEStNRcbaEzOgw+8u6sAZr+LbpM1gTcH4sC8kY5yFBuAaGN9FrNlwbNGio2QDPpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNUqhu/u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNUqhu/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4F3C4CEC3;
	Sun, 22 Sep 2024 15:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727017337;
	bh=4F00RqovIfyrSd5mQuI2EuhP8uxKErvLYeEpb8/EpBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jNUqhu/uGe+CGKrg/EvXzlKh8haUFKEaznrALH3XTJ9jsctRB7la1G48X3uyu98vv
	 94MnIcpzjLtxDF/KqvZhl0vbp9zVVBLH//CpauhPOIeb8aoFKE9MPUzLMUfhtKnnmA
	 OeNVULvDIEuL93nPQsvTt6vAjzKRZt1p5/nsYLzkq8sollWTofU7DMIs2uO06a+NIK
	 86N9Zo37ktTwvLQyStrJz028zc+yxGtZdJWZko9wp8GAZBdaPaMfZGEe9oJb8LueVk
	 97frAgJrHVO22jbX4crDw8GqK8E9M3IkOEUn59/PXdmx6QXet+J7d99etVg1bp8QPh
	 CJua1X/owUXZA==
Date: Sun, 22 Sep 2024 18:02:06 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH 1/2] dma-mapping: fix vmap and mmap of noncontiougs
 allocations
Message-ID: <20240922150206.GE11337@unreal>
References: <20240922140743.1596763-1-hch@lst.de>
 <20240922140743.1596763-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922140743.1596763-2-hch@lst.de>

On Sun, Sep 22, 2024 at 04:07:34PM +0200, Christoph Hellwig wrote:
> Commit b5c58b2fdc42 ("dma-mapping: direct calls for dma-iommu") switched
> to use direct calls to dma-iommu, but missed the dma_vmap_noncontiguous,
> dma_vunmap_noncontiguous and dma_mmap_noncontiguous behavior keyed off the
> presence of the alloc_noncontiguous method.
> 
> Fix this by removing the now unused alloc_noncontiguous and
> free_noncontiguous methods and moving the vmapping and mmaping of the
> noncontiguous allocations into the iommu code, as it is the only provider
> of actually noncontiguous allocations.
> 
> Fixes: b5c58b2fdc42 ("dma-mapping: direct calls for dma-iommu")
> Reported-by: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  drivers/iommu/dma-iommu.c   | 33 +++++++++++++++++++++++++++++++++
>  include/linux/dma-map-ops.h | 19 -------------------
>  include/linux/iommu-dma.h   |  6 ++++++
>  kernel/dma/mapping.c        | 37 ++++++++++---------------------------
>  4 files changed, 49 insertions(+), 46 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leon@kernel.org>
