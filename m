Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E661A137932
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008276; cv=none; b=Ju93GB3bCimxDpyFcpVnfitx9ihnkEMn0oRMWI7GhrFXfp6tOAJ4ohWkgMcZVvjae1wT6EDG/dddapS+5eKMplVVgW9CAXPoR00nIRrE0dvGdQTmTzkdSOdFINr49WvWZpDze1YkkmK7axapF8nlP9DSlBcxxrClHrHAC9MvBn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008276; c=relaxed/simple;
	bh=SE3enJ3+tdceVCfps+NDycMuiznsYPCmCITL3XMF+YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnL66tMjRdP9niP0W0OeHU7kynoUUJ71SiGTLl+X10Ij9UUFQyEia5LqWVXmkOfL9qs8a3NxWkx5VGY2bMLL4uVTDD5EQIy5L0e7wi28S1iJljr+3LIB6Lu/sqQxxciHOT8qNVOJeYPp+NBhbA68cEFThXR5MOh/UmRrlXjvSU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZJLeHF8I; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZJLeHF8I"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ee13dc0c52so38841591cf.2
        for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 10:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1764008274; x=1764613074; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Q4XGWFZAsNM37R1rQ1ombVOOPPk7RCpjRWEUHwD+PE=;
        b=ZJLeHF8IVapsls/XFwcjD9Hzy+SmPNa1Orf+UWQQBr4YDtaNCjDSER+7Nda8VAMIF/
         y3HQrusdE+yz9i9hrDlbU8L/NAqge0T1Q4zRUw2arS0dmbS29teokvIzVRmLHHHvwGxa
         P/qkmbkx1+4qDUBGDGEsCnWrLjBNoNo30AQfcvDRMYaOH6scg+xekH6R587aGHXaLf1A
         mIfmWXePysjR4vrPIC1R1p6qswcMlRFkYfDmycAOdCTm6HXI/lI3WbD12Kt52yCvNhaf
         Cy5w8/9UKioEnJTgMV5fcJF7kX+cSusyq/UkaawEMdkJhjxUa1IE/IVVKnNIMvlzOYvn
         /RWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764008274; x=1764613074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Q4XGWFZAsNM37R1rQ1ombVOOPPk7RCpjRWEUHwD+PE=;
        b=IcaaGAk/RB5cZ0IIfyB5dFrw8Svq1I09wzRgagjh1Z58YIA+0IT48WpBv3pLkb+MrO
         jEMzfUlhANTK7ybVxA1gaqbekkLLhY7yMvPvUsyA2xf297ddZU2vf+kMCsiX8J/xJJzm
         Q5ARe07z1KFE1puuT1ZNq1RIdok2xl9Qiwo5eCQx+ed1lK9qvM/JrzySAq7EBLkc7xfe
         nUpHbFltfkqJqIVs0iPiiSkAZmTuZsid9aAt5/fdnshI/3ogO+Dt2eTtrn6bdaGWpygk
         MgWeF0xpuPKfWRAgyeQCK4/qrcy346X0bqbKbnmA88Jdll2/HrGze+w813y6VIMhguco
         craQ==
X-Gm-Message-State: AOJu0YyvNV+Y/gIs+mbh3RhIx/JtJCVBKvIh+NW3JaPiu5tRs205JoY2
	eLjwGhxA2NURr9JdIfJV1cRmjk31MMeJwhHtRXSC9VkQC3cfdaJy3TsFLoP/v4Icejs=
X-Gm-Gg: ASbGncsPwsPmJOg0HN3z2JEcKfYH8YfsQfUy/JaTO0Ld9+liSZjM90mFcHkO/5Ni3BF
	SnlP7bOHKwN0fx5zpyZaMQ+MlPT0MFwEwGMiodWr4sSL6UWUUuhrvZWg8OyqVNDjfEuKmcUBlte
	Kyn/Fcf0bayc8Vm+7/OfaUlpTBmzgII44JCOhuMGs6vrGkg641lbWX8ukfP+PtNjVKUNxLGQR+1
	2uO1ruwwmdbccinAf08KRHzjuoddpKQhELDFiOvhs77ZbuY/IiDvkf151ZnGNSBFwcPnJhMNbwc
	mX/Qr53sFhQxT8GTMKlB3WLXZjjqbJlpOLCwlXj38yYSSESUTAc8D5jie/fn8Dh//S55h6biIZy
	Jre+BhMflAJmhFoVXV/WCW6fJOZ1Lg7gjRLcNsDtBlw98+q+4dlg9kXMQdCDyOoKxQRxWad9NM0
	eVFQfE1pzKlvtmqpYcdDqb9HFaRvtPzUv9xT2qp76gHQ+MLuvL82nVS7OH
X-Google-Smtp-Source: AGHT+IGrymCLbu6XzxcbFP6b8oUrfAOz3stICSOnVBiZzQk2Uy4On+diDpNFffli+zQ7ZB0/aTDqYg==
X-Received: by 2002:a05:622a:64f:b0:4e8:9ad9:f3da with SMTP id d75a77b69052e-4ee58ab0047mr160373601cf.30.1764008273775;
        Mon, 24 Nov 2025 10:17:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db58fsm997483085a.37.2025.11.24.10.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 10:17:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vNb8K-00000001xCt-3GkR;
	Mon, 24 Nov 2025 14:17:52 -0400
Date: Mon, 24 Nov 2025 14:17:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] iommu/dma: add missing support for DMA_ATTR_MMIO for
 dma_iova_unlink()
Message-ID: <20251124181752.GX233636@ziepe.ca>
References: <CGME20251124171014eucas1p21d3a0f2c10b43bfdb7861ee804f09951@eucas1p2.samsung.com>
 <20251124170955.3884351-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124170955.3884351-1-m.szyprowski@samsung.com>

On Mon, Nov 24, 2025 at 06:09:55PM +0100, Marek Szyprowski wrote:
> Commit c288d657dd51 added support for DMA_ATTR_MMIO attribute in the
> dma_iova_link() code path, but missed that the CPU cache is being also
> touched in the dma_iova_unlink() path. Fix this.
> 
> Fixes: c288d657dd51 ("iommu/dma: implement DMA_ATTR_MMIO for dma_iova_link().")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/iommu/dma-iommu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Did you find it by code inspection?

Jason
