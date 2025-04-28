Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965F4207DEE
	for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745845015; cv=none; b=jRnxmB9xvznqOThg+wDHBBn8HD5P6whkavNqZMrgqeqftYv8yjzv9ptAg3XWrTyw5CIdIOUcxRuYyfFbnNDP0T9QK+xG09LBVPFE9wpV98sYm/mwOKwFqrZTJKupLSmXMU/FlxpO8XRwlvc6s+yQhVsZRYkPtgE7B2kKaKHEbGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745845015; c=relaxed/simple;
	bh=f1xeVfmV3OMLaA+3xczj/fn6B8fLlnlor14DyfaY/mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBdZtXBCDCIZdRpzNap9h7gteGSyZ7bnNHpll4+GMxjiYanji1HiPKyQPtzJTCcl00umbbaP4NIxwuE4BmkU6WGdJtuLfLvK539eih0eEk9qKx/MWFIWJgC1C54p8Y0Rubpb8AwGnkU8gc43iRI7zirJDdjYdFCw+D1fJuKtdfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3AA4D68C4E; Mon, 28 Apr 2025 14:56:48 +0200 (CEST)
Date: Mon, 28 Apr 2025 14:56:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ian Abbott <abbotti@mev.co.uk>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [PATCH 4/4] comedi: allocate DMA coherent buffer as individual
 pages
Message-ID: <20250428125648.GC27794@lst.de>
References: <20250415114008.5977-1-abbotti@mev.co.uk> <20250415114008.5977-5-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415114008.5977-5-abbotti@mev.co.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 15, 2025 at 12:35:59PM +0100, Ian Abbott wrote:
> +			vma->vm_start = start;
> +			vma->vm_end = start + PAGE_SIZE;
> +			retval = dma_mmap_coherent(bm->dma_hw_dev, vma,
> +						   buf->virt_addr,
> +						   buf->dma_addr, PAGE_SIZE);

I'm not  fan of the vm_start/vm_end manipulation, but I've seen it in
other places.  In a perfect world we'd have a dma_mmap_coherent_offset
or similar helper that encapsulates it, and then maybe later replace
that hack with passing on the offset.

> +			if (retval)
> +				break;
> +
> +			start += PAGE_SIZE;
> +		}
> +		vma->vm_start = vm_start;
> +		vma->vm_end = vm_end;
>  	} else {
>  		for (i = 0; i < n_pages; ++i) {
>  			unsigned long pfn;
> @@ -2407,19 +2421,18 @@ static int comedi_mmap(struct file *file, struct vm_area_struct *vma)
>  
>  			start += PAGE_SIZE;
>  		}
> +	}
>  
>  #ifdef CONFIG_MMU
> -		/*
> -		 * Leaving behind a partial mapping of a buffer we're about to
> -		 * drop is unsafe, see remap_pfn_range_notrack().
> -		 * We need to zap the range here ourselves instead of relying
> -		 * on the automatic zapping in remap_pfn_range() because we call
> -		 * remap_pfn_range() in a loop.
> -		 */
> -		if (retval)
> -			zap_vma_ptes(vma, vma->vm_start, size);
> +	/*
> +	 * Leaving behind a partial mapping of a buffer we're about to drop is
> +	 * unsafe, see remap_pfn_range_notrack().  We need to zap the range
> +	 * here ourselves instead of relying on the automatic zapping in
> +	 * remap_pfn_range() because we call remap_pfn_range() in a loop.
> +	 */
> +	if (retval)
> +		zap_vma_ptes(vma, vma->vm_start, size);
>  #endif
> -	}
>  
>  	if (retval == 0) {
>  		vma->vm_ops = &comedi_vm_ops;
> -- 
> 2.47.2
---end quoted text---
