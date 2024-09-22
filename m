Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEF929A2
	for <iommu@lists.linux.dev>; Sun, 22 Sep 2024 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727015309; cv=none; b=m98UjG9TI6h+/Sug6ptbnbp32vqVJ41V4DFDdsK440B0uqQN1Q2jxVKJhYQN3cAjZjdTMO992naionAq0n/uRfDL1zr3NGBy+wwH0suKxtfhz9lmxxSTugIQnRmXSmvjqmVsALX9Z7MtZt6hpDSTXsHTBwl5KrlzP1dhAKEPm7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727015309; c=relaxed/simple;
	bh=AF4uU0bu5Cona9UPmfEIu5i2dZpDYRTImiYkTuJdMqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dngnxu/N28+TURbpu+SlxaE8rXityHjbxQt04Dx315C1s/x3m8A/Io8XDcaK1uI29w8XcXDMdkqKS69LrrngIim422iLJN7ghfNwLTELOYdW6viFBctMrRdW6++UmpBcqWX7qcRqeEFSoZPb+r8LUh5f4fzUTbd9QjmJsDaiobM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2jzy+OX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2jzy+OX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63B4C4CEC3;
	Sun, 22 Sep 2024 14:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727015308;
	bh=AF4uU0bu5Cona9UPmfEIu5i2dZpDYRTImiYkTuJdMqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q2jzy+OXwakXejjRCvWQD+pxtgsUyx3EshzMcb3pGWG5zdaj1G9BAUtHfn8LjjB/9
	 jjcRE/WCM5U9O1hzYHUjg5T4fqPFPaeaJYWwqdbYUExwkMusEOSEzK6aFw3JEY27fy
	 qmM2zXeYtRj1FAA/TkxJJ6BP20G1lhFOE4oTFaxR+0OulXyRYlLJf4NLosBnvJ+NEu
	 8m/+y4arsf3AcBZMjRXxuPMIz40zNXOS2EWFFI5lJXyG5A/9iIrkXU1zJtV9QfDwBF
	 O2MUxDCHthaiV3Twpq6CW4URyj2IkR3bBdLabyz04X/hBd36xH8ZPku4jzlmDkWL7a
	 nZXJ89syCEAoQ==
Date: Sun, 22 Sep 2024 17:28:19 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH 2/2] iommu/dma: remove most stubs in iommu-dma.h
Message-ID: <20240922142819.GD11337@unreal>
References: <20240922140743.1596763-1-hch@lst.de>
 <20240922140743.1596763-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922140743.1596763-3-hch@lst.de>

On Sun, Sep 22, 2024 at 04:07:35PM +0200, Christoph Hellwig wrote:
> The direct calls from mapping.c all guarded by use_dma_iommu(), so don't
> bother to provide stubs, but instead just expose the prototypes
> unconditionally.

I was afraid to do such a change because of fear that some compiler will
call to the !CONFIG_IOMMU_DMA functions without checking the condition.

Thanks

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/iommu-dma.h | 108 +++-----------------------------------
>  1 file changed, 8 insertions(+), 100 deletions(-)
> 
> diff --git a/include/linux/iommu-dma.h b/include/linux/iommu-dma.h
> index 7bf145a52d6a1a..508beaa44c39e8 100644
> --- a/include/linux/iommu-dma.h
> +++ b/include/linux/iommu-dma.h
> @@ -14,6 +14,13 @@ static inline bool use_dma_iommu(struct device *dev)
>  {
>  	return dev->dma_iommu;
>  }
> +#else
> +static inline bool use_dma_iommu(struct device *dev)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_IOMMU_DMA */
> +
>  dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>  		unsigned long offset, size_t size, enum dma_data_direction dir,
>  		unsigned long attrs);
> @@ -58,104 +65,5 @@ void iommu_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
>  		int nelems, enum dma_data_direction dir);
>  void iommu_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
>  		int nelems, enum dma_data_direction dir);
> -#else
> -static inline bool use_dma_iommu(struct device *dev)
> -{
> -	return false;
> -}
> -static inline dma_addr_t iommu_dma_map_page(struct device *dev,
> -		struct page *page, unsigned long offset, size_t size,
> -		enum dma_data_direction dir, unsigned long attrs)
> -{
> -	return DMA_MAPPING_ERROR;
> -}
> -static inline void iommu_dma_unmap_page(struct device *dev,
> -		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir,
> -		unsigned long attrs)
> -{
> -}
> -static inline int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> -		int nents, enum dma_data_direction dir, unsigned long attrs)
> -{
> -	return -EINVAL;
> -}
> -static inline void iommu_dma_unmap_sg(struct device *dev,
> -		struct scatterlist *sg, int nents, enum dma_data_direction dir,
> -		unsigned long attrs)
> -{
> -}
> -static inline void *iommu_dma_alloc(struct device *dev, size_t size,
> -		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
> -{
> -	return NULL;
> -}
> -static inline int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> -		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> -		unsigned long attrs)
> -{
> -	return -EINVAL;
> -}
> -static inline int iommu_dma_get_sgtable(struct device *dev,
> -		struct sg_table *sgt, void *cpu_addr, dma_addr_t dma_addr,
> -		size_t size, unsigned long attrs)
> -{
> -	return -EINVAL;
> -}
> -static inline unsigned long iommu_dma_get_merge_boundary(struct device *dev)
> -{
> -	return 0;
> -}
> -static inline size_t iommu_dma_opt_mapping_size(void)
> -{
> -	return 0;
> -}
> -static inline size_t iommu_dma_max_mapping_size(struct device *dev)
> -{
> -	return 0;
> -}
> -static inline void iommu_dma_free(struct device *dev, size_t size,
> -		void *cpu_addr, dma_addr_t handle, unsigned long attrs)
> -{
> -}
> -static inline dma_addr_t iommu_dma_map_resource(struct device *dev,
> -		phys_addr_t phys, size_t size, enum dma_data_direction dir,
> -		unsigned long attrs)
> -{
> -	return DMA_MAPPING_ERROR;
> -}
> -static inline void iommu_dma_unmap_resource(struct device *dev,
> -		dma_addr_t handle, size_t size, enum dma_data_direction dir,
> -		unsigned long attrs)
> -{
> -}
> -static inline struct sg_table *
> -iommu_dma_alloc_noncontiguous(struct device *dev, size_t size,
> -		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs)
> -{
> -	return NULL;
> -}
> -static inline void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> -		struct sg_table *sgt, enum dma_data_direction dir)
> -{
> -}
> -static inline void iommu_dma_sync_single_for_cpu(struct device *dev,
> -		dma_addr_t dma_handle, size_t size,
> -		enum dma_data_direction dir)
> -{
> -}
> -static inline void iommu_dma_sync_single_for_device(struct device *dev,
> -		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
> -{
> -}
> -static inline void iommu_dma_sync_sg_for_cpu(struct device *dev,
> -		struct scatterlist *sgl, int nelems,
> -		enum dma_data_direction dir)
> -{
> -}
> -static inline void iommu_dma_sync_sg_for_device(struct device *dev,
> -		struct scatterlist *sgl, int nelems,
> -		enum dma_data_direction dir)
> -{
> -}
> -#endif /* CONFIG_IOMMU_DMA */
> +
>  #endif /* _LINUX_IOMMU_DMA_H */
> -- 
> 2.45.2
> 
