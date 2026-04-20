Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A016F2C029D
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776726102; cv=none; b=Ro1KX6Xa+FLqz0PHnPsAA0TzVmTa1G6NY8SqYnWblK3cOycpkXEZKOANflXRT0dSBaHR6BFpI1StThe605yjJMahMWuG18JCotKUdwyIPSa7DIcK0QayiXyNVzDxfA5DebH9FaZzzdX3mFC71MiV8sQ7uqtk4JU5834+QYHBdv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776726102; c=relaxed/simple;
	bh=vlC9NwXY9DCpD35y1NpvGBMnXFQwzvq4hoA7tHHLiH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8eehGzfsG5F6Th74zU3Rh5a8CI/rZu9IgBVm77lvNHsc/9eYdu+2GXhyKxyIlZI1pnFbXTjfIic29jZbNl4OkIMJF9lBZEpMoIxzBWiHIRHtJCqp6R44Oe5rfvy20sh/sxbNS/Z3N9hPTeSjuj0aSVQCA3EGrzJSorNKiU8KXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jxhnkyr0; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jxhnkyr0"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-69485d0e4beso532941eaf.3
        for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 16:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776726099; x=1777330899; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PW4xQG7nqF+lf+D3IisD78kFapb+PoH04igJOs6rmhM=;
        b=jxhnkyr0ieX30GFSeuHXeMl4LumfUEhRqoTQzZS1Pci2E62RPV4b9IzWXhg/AfR5Wh
         ah5FvmzO1DloqzrVzYD6j1/iibOSAReykGD76ySGOCWHnvMATGfRtbYuXC7KVeKIM1Yu
         OUUArleBJjBg/mg2GHhjct+nQUUe/Sjspxgpb+5e34+lwlxNVwSqe/yI8I4TZUjGiI9m
         Al+jrpcBitsrpGLgAdJc9Mz/UkmVsUAPR6hJP2djbabxe5JJkyuCLiBebCpSNWsln8Er
         jL3M9l+l4tSOfgiV49MgbyW8fQpIcsZ/WHyam848WTfq+laeWv7QbW7biDN7hbb1Vxox
         j2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776726099; x=1777330899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PW4xQG7nqF+lf+D3IisD78kFapb+PoH04igJOs6rmhM=;
        b=f4C9zO8+bWufdPRZGW2mywnGtA1c4Hk0sxNQw2breXAcYSHd6k/owmz4SaACCqf+c1
         FTSATiyBLsnFuHjsqfX68GoGPGGtVjPt8hCd5zrWgzCG6XfZ+rHsY3a1rxLq5gnEnw2H
         sPF4cozWgmvCbrgXDWNF/+h2LNLWKCDfaS3806CsVEaztrYg2EHrzJUsSUECVy0gIoMZ
         6TJS9BRsrmtTtREdp4rAHnhvD6B6zxnIBlwRjynYgfOUiXYyx8/UkHTJwgkNXOOYdGeE
         vFhGGmEsIuhb3HoOifQgePRiFtkEA4ov0l/rvnTN2Lnelp3ESoxS420J97bFPpQ4J+3t
         8hIg==
X-Forwarded-Encrypted: i=1; AFNElJ/nar/U+mJDB2KtGbL40gaXmvmKskUygK6Uo93XDjYZD4GbhkKD/ERYHjiYa0e7sIvEmA75eg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzILPLRnCFfF4OwpTKZgchwBrsrMZ3P/ZwuDJHIgBYK2vytyr0Q
	ZtvBhwH9WquzADkMQLmbdYnOatyN87KZl05XPR+9ZjMdqXCPmUncYrqsvuXy6S3apkO64bXUGTn
	LSafd
X-Gm-Gg: AeBDiesehjxwUtRngUcPCQqH10nk+wmQbgwVUNzruI/czqr5XWV9RJ3tHL4PhdDQT8/
	LwYCa3IU0GNiOysgH5zSzkx785vYBl0QjgA70v5lWIjL2JwFZu+I8OrBgVln9x5TM8to4hTgibn
	WJr4V6ZtU8DAaFLhLn9MvcvEQWfzT/xHy1P75/swIDc8X0FJIkNtXW9psAXolT9XmTjA6gisCle
	YDxrpv1GKymcjqJv6NO7CMY+ibEkP+UvNvbDb4gcUiod3GsG2y2KzsH9ES9PVt3oYv+HJ0zv/6A
	qnw/FdkqVp6/yxMB6luCirJfqmoQYBXMs2Ie0Cvimoj23IpJbVOwZ8zavO+gvF5wArXWk18M7Mg
	OFg6F9R65YlijXKWYnCt5ZbkyhoH6IAuf8mTxKoQdI7+Fr/1i16B6hFlvIbvrBmaV3GNGzf8az8
	JZ8L0GaRP2
X-Received: by 2002:a05:6820:1508:b0:694:9840:843a with SMTP id 006d021491bc7-69498408649mr135366eaf.7.1776726099292;
        Mon, 20 Apr 2026 16:01:39 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69493183021sm916652eaf.13.2026.04.20.16.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 16:01:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wExcX-0000000F9El-2c2Z;
	Mon, 20 Apr 2026 20:01:37 -0300
Date: Mon, 20 Apr 2026 20:01:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC] xen/swiotlb: avoid arch_sync_dma_* on per-device DMA
 memory
Message-ID: <20260420230137.GQ2577880@ziepe.ca>
References: <20260415-xen-swiotlb-v1-1-de24eda3c0fd@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415-xen-swiotlb-v1-1-de24eda3c0fd@nxp.com>

On Wed, Apr 15, 2026 at 11:08:36PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> On ARM64, arch_sync_dma_for_{cpu,device}() assumes that the
> physical address passed in refers to normal RAM that is part of the
> kernel linear(direct) mapping, as it unconditionally derives a CPU
> virtual address via phys_to_virt().
> 
> With Xen swiotlb, devices may use per-device coherent DMA memory,
> such as reserved-memory regions described by 'shared-dma-pool',
> which are assigned to dev->dma_mem. These regions may be marked
> no-map in DT and therefore are not part of the kernel linear map.
> In such cases, pfn_valid() still returns true, but phys_to_virt()
> is not valid and cache maintenance via arch_sync_dma_* will fault.
> 
> Prevent this by excluding devices with a private DMA memory pool
> (dev->dma_mem) from the arch_sync_dma_* fast path, and always
> fall back to xen_dma_sync_* for those devices to avoid invalid
> phys_to_virt() conversions for no-map DMA memory while preserving the
> existing fast path for normal, linear-mapped RAM.

I think this is the same sort of weirdness the other two CC threads are
dealing with.. We already have two different flags indicating the
cache flush should be skipped, it would make more sense to have the
swiotlb mangle the flags, just like for cc.

https://lore.kernel.org/r/20260420061415.3650870-1-aneesh.kumar@kernel.org

Then you know that the swiotlb was used and it should flow down to
here.

>   * physical address to use is returned.
> @@ -262,7 +267,8 @@ static dma_addr_t xen_swiotlb_map_phys(struct device *dev, phys_addr_t phys,
>  
>  done:
>  	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
> -		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dev_addr)))) {
> +		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dev_addr))) &&
> +		    !dev_has_private_dma_pool(dev)) {

Also this pfn_valid() is totally bogus. Unless DMA_ATTR_MMIO the phys
must have a struct page, be pfn_valid, etc.

This is why you are getting into trouble here, beacuse swiotlb created
a non-struct page address and passed it to lower layers without
setting something like DMA_ATTR_MMIO..

Jason
