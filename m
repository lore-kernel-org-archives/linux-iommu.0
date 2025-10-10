Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951851C5D44;
	Fri, 10 Oct 2025 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760092842; cv=none; b=uDmHEkrRJFv90OhNMaz+g77+NNJzWZT2GynCqiuzn+tk1svkk3Ef3ikMXSNuAGACZF/TieYvcDlRsgvOUrHB/4vDCFBlf8/4+KYbCIWc2sDcDchNyezCqSEdpFEMLcStg/VZqujCRtK6EZB+p/qBj/G6RDJmrLr75dctPDdndSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760092842; c=relaxed/simple;
	bh=UEdMcPCwmc82o2IhHH4TEQF2CtYU6nBQMLFrtes5iFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rF+IohER1GRnXOM+prIn/YQCGZ0edJzAHDoaiKX8gcRtWvfp4mgfTLnth97Z+pfNJKVU08ZktBt0pUO7EWVbe94IDNNkWVKCAFlDYqmgoHp5Vy1J5bFfzqJRZHfpkcQCEg2guNtQt1vzZxYsg1rFmF7plUmQWp0du3+OLOKjtFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B23C4CEF1;
	Fri, 10 Oct 2025 10:40:40 +0000 (UTC)
Date: Fri, 10 Oct 2025 11:40:38 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] dma-debug: don't report false positives with
 DMA_BOUNCE_UNALIGNED_KMALLOC
Message-ID: <aOjipm1vCJpgQQq1@arm.com>
References: <CGME20251009141522eucas1p2c89eadd93fb571c557d3d70975d8ae4f@eucas1p2.samsung.com>
 <20251009141508.2342138-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009141508.2342138-1-m.szyprowski@samsung.com>

On Thu, Oct 09, 2025 at 04:15:08PM +0200, Marek Szyprowski wrote:
> @@ -594,7 +595,9 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
>  	if (rc == -ENOMEM) {
>  		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
>  		global_disable = true;
> -	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
> +	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> +		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
> +		     is_swiotlb_allocated())) {

Maybe use is_swiotlb_active(entry->dev) instead for completeness. Either
way:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
