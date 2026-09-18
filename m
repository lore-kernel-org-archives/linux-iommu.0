Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED89E38F250;
	Fri, 18 Sep 2026 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735062; cv=none; b=bNObdsSuzfI4Qjnbi49CGQ/kQoUOlbd23/XXBWsOoyHEInnKa16LMMDFqs2vmCyPlWW273Jx/tcIluLv8wiTBAMBl/U6dGY+lIJ+U/FTC+/SqFvoVFsJz7gTIRff4NhuRStB8Qdi8Fe4tqQtnXHM3lpJmb2gpi07xRI3+sOAEyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735062; c=relaxed/simple;
	bh=GRKtSV1oCx15Lx6vmy/Pr8Fys9refh9E8xXkh0/M9B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BI8ZGT4+/ZgjPQCsyS4StJyWArzAhNnMHNQHlMvr+eMQ2R6ajP550Blegvc21ZqdM/QZnriFgsRVWXVg1aDB8ddbej0mtAikicz+Yrot3pbeJS0m7R3n86RL5Qom5bqWviFlMk+t17mLAeyU5QDsQoLMFFL4AQRZepFFckIVRwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e62CO7nK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e62CO7nK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71B01F000FF;
	Fri, 18 Sep 2026 12:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789735060;
	bh=TlHPawVeVCEe2FE2C/DD5dJed6U8heXd2s/+SPtJ32o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e62CO7nKq2QG9a/NfuhcbhSfMZ1rOHxmQAjEIpPUqdxkwQrcLaULP3V4DmnlVDz1I
	 4daeOL9rPH7tZ7NaFy4/BrGrmiTn0dkoJv88eewIOgAPPNPlvDZEmtr4A9yED3kWG3
	 XM3twqz4pgSMCzNZzUnGIZig1+EVOPmhhWHAXCXLjNt7CNXiZUPwgA11zvO5jGcODH
	 C6mUcIYf2ah05vduJVFQxTComO+AZ9/XlhUQqGl5aOrPfNDXWeuHKbJp/R/7O55Dqw
	 ayXLlOOezwBAKotdSKY8Q8TFyyG1wJ9U7vkmekJt0euicFdmH3PKv1bpSN1zvGUH0D
	 vm8nbRbWhDAtg==
Date: Fri, 18 Sep 2026 15:37:36 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC 0/2] iommu/dma: Fix DMA_ATTR_MMIO swiotlb rejection
Message-ID: <20260918123736.GW13683@unreal>
References: <20260916-iommu-dma-fix-v1-0-a59a0c45ec5b@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-iommu-dma-fix-v1-0-a59a0c45ec5b@nxp.com>

On Wed, Sep 16, 2026 at 11:23:32PM +0800, Peng Fan (OSS) wrote:
> Commit f9374de14c0e8 ("iommu/dma: implement DMA_ATTR_MMIO for
> iommu_dma_(un)map_phys()") and commit c288d657dd515 ("iommu/dma: implement
> DMA_ATTR_MMIO for dma_iova_link().") added DMA_ATTR_MMIO support to skip
> swiotlb bouncing and cache flushing for MMIO resources. However, both
> implementations placed the DMA_ATTR_MMIO check inside the swiotlb bounce block,
> causing non-page-aligned MMIO mappings to be rejected outright instead of
> skipping the bounce and proceeding to create the IOVA mapping.
> 
> This breaks dma_map_resource() for any non-page-aligned device register when
> behind an IOMMU: DMA controllers that map peripheral FIFO addresses
> (e.g. SPI controller TX/RX data registers) through an IOMMU for per-channel
> isolation.
> 
> Both patches move the DMA_ATTR_MMIO check before the swiotlb block so MMIO,
> resources skip the entire bounce path and fall through directly to the IOMMU
> mapping function.

While I understand the rationale behind the first patch, why do we need the
second one? Do we want to allow unaligned addresses for the _link_ as well?
Current users don't need it.

Thanks

> 
> Tested on NXP i.MX95 with ARM SMMUv3 where the fsl-edma DMA controller maps
> SPI peripheral FIFO registers (non-page-aligned) via dma_map_resource()
> through per-channel IOMMU domains. Only the iommu_dma_map_phys() path was
> exercised; the dma_iova_link() fix is by code inspection of the same pattern.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Peng Fan (2):
>       iommu/dma: skip swiotlb bounce for DMA_ATTR_MMIO in iommu_dma_map_phys
>       iommu/dma: skip swiotlb bounce for DMA_ATTR_MMIO in dma_iova_link()
> 
>  drivers/iommu/dma-iommu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> ---
> base-commit: e6e35979777d646fe3c7c94dca7dd32fb25d45f4
> change-id: 20260916-iommu-dma-fix-9f55af1beb46
> 
> Best regards,
> --  
> Peng Fan <peng.fan@nxp.com>
> 
> 
