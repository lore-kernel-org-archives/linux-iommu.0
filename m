Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75562AF1D;
	Wed, 11 Sep 2024 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045513; cv=none; b=U5Pe7kx8kyNEWi1Xvfm66QjHdn45JiyGGJUIC3Fkx4MeXOfHKqnvmu7SipWugD78L+GpKIstVyqrmL3iZ6JKlP5Fmn8Vbxt5N00G+w6hWFnjFa02T6jDAE+Ru4jx5CZDa0RhSvBnszx4Ds2feyocG/2jDPDIK9jGF9bkODqdSL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045513; c=relaxed/simple;
	bh=K48R2AqNc1vFJQtIxz9U5zj+7HE5QnbwjJNno4GynFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvVvJNWJ0BuEGSJzriGvUzi9/6jV2Tug5UFd18OTX0TdiSu/1YEZsAmn7Ht97+us7khRG3RDTyZYh8wxn4dq28FDqHAa5Duy+YnXAaETFVDV2pDMIlt/nXN4BLgcsLXAEV1bzINmdXTApRd1ydzMYbqlCZmxNhQleKppGFjQbnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AekrqQzH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AekrqQzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F102C4CEC5;
	Wed, 11 Sep 2024 09:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726045513;
	bh=K48R2AqNc1vFJQtIxz9U5zj+7HE5QnbwjJNno4GynFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AekrqQzHiZY5vPZa6yk0wFld8leztOXpq9L/aM2A+Sp9NSQm+vSzafXIbL4MDJWa5
	 Tw6usR9VNpoM3iWiNMyAq6TeKDpgPs/GMs1KWkS3qel1zbKFZinSLASAoVk6oYXujn
	 A8wyCQY0KFJVBrsxjC7AZnsJjnQoptkwjbytpFZbUWwIby/HhxpGwhQwg8zlcAgt+f
	 h9L+ar4kIxtarjEIyobFW6n5TEY7VCtKphqLowsb79NII+wWeZk65hBiB9dbG55cyQ
	 pbmzep3VZk1p1/wr/+l2e9Ca/lfFhCHJIxNGmDBFa4UVqSku+m1v/c7yeeAHkFrwxw
	 fzBVKnm25+idg==
Date: Wed, 11 Sep 2024 12:05:08 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	regressions@lists.linux.dev, kernelci@lists.linux.dev,
	kernel@collabora.com
Subject: Re: [PATCH v4 2/2] dma: add IOMMU static calls with clear default ops
Message-ID: <20240911090508.GE4026@unreal>
References: <cover.1721818168.git.leon@kernel.org>
 <c3179690b16d790d5bfd7d0afabac9b90922ec28.1721818168.git.leon@kernel.org>
 <181e06ff-35a3-434f-b505-672f430bd1cb@notapiano>
 <20240911064305.GD4026@unreal>
 <20240911080445.GA5950@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911080445.GA5950@lst.de>

On Wed, Sep 11, 2024 at 10:04:45AM +0200, Christoph Hellwig wrote:
> On Wed, Sep 11, 2024 at 09:43:05AM +0300, Leon Romanovsky wrote:
> > Thanks for the report, I'm looking into it. However, it is unclear to me
> > why my patch is causing this issue. The change in dma_supported() should
> > produce WARN_ON [1] if new path is taken, otherwise, we return to
> > previous behavior.
> 
> dma-iommu never implemented .dma_supported and thus claims to support
> all dma masks.  To restore that behavior we'd need something like the
> patch below:
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 7550b5dc5e55df..d23a4d5a6b31a1 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -841,17 +841,19 @@ static int dma_supported(struct device *dev, u64 mask)
>  {
>  	const struct dma_map_ops *ops = get_dma_ops(dev);
>  
> -	if (WARN_ON(ops && use_dma_iommu(dev)))
> -		return false;

The below code still has merit. It is an error to have ops and take
dma-iommu path.

>  	/*
>  	 * ->dma_supported sets the bypass flag, so we must always call
>  	 * into the method here unless the device is truly direct mapped.
>  	 */
> -	if (!ops)
> -		return dma_direct_supported(dev, mask);
> -	if (!ops->dma_supported)
> -		return 1;
> -	return ops->dma_supported(dev, mask);
> +	if (ops) {
> +		if (!ops->dma_supported)
> +			return 1;
> +		return ops->dma_supported(dev, mask);
> +	}
> +
> +	if (use_dma_iommu(dev))
> +		return true;

I would simply put this hunk below if (WARN_ON ...) without any other
changes. Should I send a patch?

Thanks

> +	return dma_direct_supported(dev, mask);
>  }
>  
>  bool dma_pci_p2pdma_supported(struct device *dev)
