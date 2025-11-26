Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D27E33C194
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764177301; cv=none; b=jDorysNyaF6d7g7qA/YpPL3ioV/+NiFh/QCEF5xxKdo/xQo/zz5zkNj0uiAzOaETSy+bXBnEQ0J3u/9IPoVzRki6bEbxaSaP09Cy0WLqNlAfG8KvXqrLJomy0apSDY3X26P/ZgpUS3TBhkjnGo9D1IyXoohtN9bp1cG5OQ9ea5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764177301; c=relaxed/simple;
	bh=PtsRSuhTAGk46kuxUoajoyLELu9AMNI0S2JlhVmehoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CB3vCYy8SddwipUed/peEU0/CN9EvyEVD5GVx01aDOg4o+nJiQ5hRO6GAfFeIXJ5DiKfMx6JJiPUHRD810l3YI+9TO+4uXVJZPCoAIBlOn/HymZyWNeZgnQp+BzqoCXpB9MF0jDGGqghyEQEm6TNWLcLUz0+A7GoqEpI2Ehq4lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZf3eCYn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZf3eCYn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A822C4CEF7;
	Wed, 26 Nov 2025 17:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764177301;
	bh=PtsRSuhTAGk46kuxUoajoyLELu9AMNI0S2JlhVmehoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fZf3eCYnP7gvNLdMBR2NUOJ8vjm3GV3ZpRJ9cLtTxGEbVOacjt+gEw8mJUbCP49fj
	 gkwhS5BeFn1FiS+qrAlDrIJGg06jsErofCJvUOcEjU4G3EZ45c+MOevgJ1KQDbPu2r
	 fYtsb7l9jbPDiCUc9RfUocrGapkhKhc89U6/7C6mz3QZDuIi5Um1NTk8aTvhOqirub
	 osqLyBu2nNRGtyVTOgRqRVR0dJ4z5mSfWPOr2W5Eo5KktKqwpak+/oxpuW42o77j0x
	 xGVuntHRGarniqdZ/jdX6BrZbBIs4ZfF0ZD7OoXnV4EwbuFLQWcEIXx/HS7DcE0GD3
	 hmatUmNVyMmNQ==
Date: Wed, 26 Nov 2025 19:14:56 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Will Deacon <will@kernel.org>,
	Shivaji Kant <shivajikant@google.com>,
	Jacob Moroni <jmoroni@google.com>
Subject: Re: [PATCH] dma-direct: Fix missing sg_dma_len assignment in P2PDMA
 bus mappings
Message-ID: <20251126171456.GH12483@unreal>
References: <20251126114112.3694469-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126114112.3694469-1-praan@google.com>

On Wed, Nov 26, 2025 at 11:41:12AM +0000, Pranjal Shrivastava wrote:
> Prior to commit a25e7962db0d7 ("PCI/P2PDMA: Refactor the p2pdma mapping
> helpers"), P2P segments were mapped using the pci_p2pdma_map_segment()
> helper. This helper was responsible for populating sg->dma_address,
> marking the bus address, and also setting sg_dma_len(sg).
> 
> The refactor[1] removed this helper and moved the mapping logic directly
> into the callers. While iommu_dma_map_sg() was correctly updated to set
> the length in the new flow, it was missed in dma_direct_map_sg().
> 
> Thus, in dma_direct_map_sg(), the PCI_P2PDMA_MAP_BUS_ADDR case sets the
> dma_address and marks the segment, but immediately executes 'continue',
> which causes the loop to skip the standard assignment logic at the end:
> 
>     sg_dma_len(sg) = sg->length;
> 
> As a result, when CONFIG_NEED_SG_DMA_LENGTH is enabled, the dma_length
> field remains uninitialized (zero) for P2P bus address mappings. This
> breaks upper-layer drivers (for e.g. RDMA/IB) that rely on sg_dma_len()
> to determine the transfer size.
> 
> Fix this by explicitly setting the DMA length in the
> PCI_P2PDMA_MAP_BUS_ADDR case before continuing to the next scatterlist
> entry.
> 
> Fixes: a25e7962db0d7 ("PCI/P2PDMA: Refactor the p2pdma mapping helpers")
> Reported-by: Jacob Moroni <jmoroni@google.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> 
> [1]
> https://lore.kernel.org/all/ac14a0e94355bf898de65d023ccf8a2ad22a3ece.1746424934.git.leon@kernel.org/
> ---
>  kernel/dma/direct.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
