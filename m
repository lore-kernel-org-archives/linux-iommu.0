Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A13339A8;
	Mon, 24 Nov 2025 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764005193; cv=none; b=azpGG1y8j2h2CXvt7sSCiVhjcYic6Pq44b1cNZwIxdJSs8gsW5Iprb1EcCmgwnyKSdijlgbtOL4n9UaWETi+yEQ9YwIMYO/6tkhghe+n+xSOcADkyfDWPXCdOFMPHwDHQrmgcR6v9gnYH2qNjtUhLZj/UFC1cuM0wnwmmONLqKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764005193; c=relaxed/simple;
	bh=aVrqKcWMLvnBW7SymhxnWtPBjLUHnuszbbFYOp0e8pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eexV5U9OxwIhFpSZjY1S3Isq8HZQmsjFdNzCQ+j9ZXa5cElyN9Rdiqakj/heIimHu5egmJDIInNyFGKSOlWW49RFIaCXFkh75gk3ph1Cxfz/wND/zQ9xG6vaCrFAA366S26ImmN6CpPJH9PVX8UcrXXcoxZGJSWAJfCVxlLEo8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBcQlI83; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBcQlI83"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA1DC4CEF1;
	Mon, 24 Nov 2025 17:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764005191;
	bh=aVrqKcWMLvnBW7SymhxnWtPBjLUHnuszbbFYOp0e8pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBcQlI83IxUAzs9WJKfOTAkKHNmcpjD+DPQEKRpWVlky3kMb0GRG3RiAoe6GUhxe/
	 InlTIWWAhLZgwbqLkMbg4t+1HL56FxrkKDd9AdK4HfS8RDMIN/ZgZ/0SGmBGbJH6lJ
	 ZuXqJKlLABE2eExlvH2e4rV4PG1OaZQZ9/9+hVkn7Y1TSuBMuCti3dnxvj384pSXTT
	 qN0Zow9uH5V2+fj+vU3HMOwrpTWF8uI5P1o4fIz+r1R+T5/6D3Y3f+VaR775apBfub
	 LyBGoyjbT0JRdr3CMFdII3XtkRgu6qC2E68rYusRP/M9Q/D6106JhxwtubLqpSASkA
	 ZRJTs/W2t1+0w==
Date: Mon, 24 Nov 2025 19:26:27 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] iommu/dma: add missing support for DMA_ATTR_MMIO for
 dma_iova_unlink()
Message-ID: <20251124172627.GE12483@unreal>
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
> 

Thanks,
Reviewed-by: Leon Romanovsky <leon@kernel.org>
