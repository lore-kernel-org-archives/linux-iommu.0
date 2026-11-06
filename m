Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794008489;
	b=hGZ5hghf25pNWEaOCEwqN/5IoSd9UEMaXe7DDyxs1a8rb9lYDaYKNa2wF+dOzkqMglyw
	 2/KHnPLv+U+lc9o61Py5ve5DzytbV3Vs5f6Hm7ZAOZ4RW+MggA8fl67vBzyqxsm8XkibS
	 ri1I7LZO4YDaxcd4leFFRIdS8u0+xNSwWv56v755sgbPeE+vdLdFIxO+uz71H9IvlapSi
	 AQdQbtK3JiXFIq3XVg3dahZB9MAJR+8y5EcZEIn696uaDQ2r8nE/1x75Dudn1RpwqX+Ye
	 I9OOmkfVSZgoyTY6we2aoVylUz7eszkgaNBHpsuj/cgtfqY5dQHNu++KGZ7cr53I8uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794008489;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=mwXkWhaoGZuVnDbiT+8l9VytpOALtyn1gB7Fo/dFec0=;
	b=RZBA3q98q72aQTqlYOisR68iuVnT/QAFC8yladZqSvajh+nJUzgLwALGZFUP4kPIh/zU
	 tSLLDVN0p0UyrQ8/eKKYVc1LIc7IikKfDpjqKwZQ6xsK7gQLo+c2i248fW9zv57JLRLTs
	 gqx8ELV6RVaDh9mMecP7GsDjZvMRnofGatd/f3TKTgUw++CtdRQCEsp8viiUZd1czCXa2
	 /BlUjMwqCmi5fGFw8PZHK+f50GnMpLa1YdpoRk0xI5Tee4L6hnrNDvpKs9z+dhU/VEF6M
	 Aso3JfkudAR+D3yjAtEkasw+C6tHPvOKR8GGtCVhODbpN+JcnsS8A8rrelFMQAuVe5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Mc5aGsxb;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0974606A32C
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 23:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0974606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Mc5aGsxb
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261106234124euoutp01a6bd9f3f794e0da8159f3ae00728e945~lmTZGqZiY2108521085euoutp01J
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 23:41:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261106234124euoutp01a6bd9f3f794e0da8159f3ae00728e945~lmTZGqZiY2108521085euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794008485;
	bh=mwXkWhaoGZuVnDbiT+8l9VytpOALtyn1gB7Fo/dFec0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Mc5aGsxbjN4/dIrM5d3Ttt1+UC3Uus88SdJlSmE47yFKIkuHFk66/St34MjbCzYUE
	 HxqvahV7An4Mng44BDvqN9PibfEw/7fqReGHVoWsU4NeTIhxRSUtSkROAp7HoCGPkD
	 UspmIsCTtdEXEqIcao+5YTRDJFfvtFUueooOlAzI=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261106234124eucas1p1aef42c95b282e08adcf39c0c4a0379d2~lmTYlZWhL2055920559eucas1p1G;
	Fri,  6 Nov 2026 23:41:24 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261106234123eusmtip1dcd2fdecd45b2e4325f37eaa9435507c~lmTX99o4U2536025360eusmtip1R;
	Fri,  6 Nov 2026 23:41:23 +0000 (GMT)
Message-ID: <5b38b9ca-a3af-45db-82a4-4e2cc4600796@samsung.com>
Date: Sat, 7 Nov 2026 00:41:23 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 01/11] dma-mapping: add dma_alloc_attrs_node() and
 dma_alloc_coherent_node()
To: Jakub Kicinski <kuba@kernel.org>, robin.murphy@arm.com
Cc: netdev@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	will@kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261106184433.761422-2-kuba@kernel.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261106234124eucas1p1aef42c95b282e08adcf39c0c4a0379d2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261106184452eucas1p2f15c3818e6319ab55abcde96840e112c
X-EPHeader: CA
X-CMS-RootMailID: 20261106184452eucas1p2f15c3818e6319ab55abcde96840e112c
References: <20261106184433.761422-1-kuba@kernel.org>
	<CGME20261106184452eucas1p2f15c3818e6319ab55abcde96840e112c@eucas1p2.samsung.com>
	<20261106184433.761422-2-kuba@kernel.org>

On 06.11.2026 19:44, Jakub Kicinski wrote:
> Coherent DMA memory is always allocated on the NUMA node of the device.
> That's the right choice for memory mostly accessed by the device, but
> some coherent allocations are accessed by the CPU on every operation.
> For example a NIC's descriptor and completion rings are written and
> read by the CPU servicing the queue, which may well be on a different
> node than the device. Placing such rings on the device's node means
> the CPU accesses remote memory in the fast path.
>
> Drivers work around this today by temporarily changing the node
> of the device with set_dev_node() around dma_alloc_coherent()
> (mlx4, mlx5, ixgbe, xgbe). This is racy against anything else
> looking at the device's node at the same time.
>
> Add dma_alloc_attrs_node() which takes the node explicitly, and
> a dma_alloc_coherent_node() wrapper. dma_alloc_attrs() now passes
> dev_to_node().
>
> The node is only a preference, the same as for kmalloc_node().
> Nothing takes it into account yet, following patches wire it up
> in dma-direct and iommu-dma. Allocations from fixed pools and from
> dma_map_ops->alloc implementations will keep ignoring it.
>
> Add an explicit new export instead of using static inline wrappers
> because we want the new API to be GPL-only.
>
> Reviewed-by: Björn Töpel <bjorn@kernel.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>


> ---
> v1:
>  - move before the patches wiring up the node in dma-direct, iommu-dma
>    and CMA (Robin)
>  - dma-api.rst: drop the NUMA_NO_NODE suggestion (Björn)
>  - docs: describe how the node is handled in the patches wiring it up,
>    drop the mention of dma_free_coherent()
>  - explain the separate GPL-only export in the commit message (Marek)
> rfc: https://lore.kernel.org/20261027022528.633359-5-kuba@kernel.org
> ---
>  Documentation/core-api/dma-api.rst | 13 +++++++++++++
>  include/linux/dma-mapping.h        | 14 ++++++++++++++
>  kernel/dma/mapping.c               | 26 ++++++++++++++++++++++++--
>  3 files changed, 51 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
> index 69d4ebe4f96d..5d079507ffa1 100644
> --- a/Documentation/core-api/dma-api.rst
> +++ b/Documentation/core-api/dma-api.rst
> @@ -57,6 +57,19 @@ The flag parameter allows the caller to specify the ``GFP_`` flags (see
>  kmalloc()) for the allocation (the implementation may ignore flags that affect
>  the location of the returned memory, like GFP_DMA).
>  
> +::
> +
> +	void *
> +	dma_alloc_coherent_node(struct device *dev, size_t size,
> +				dma_addr_t *dma_handle, gfp_t flag, int node)
> +
> +Same as dma_alloc_coherent(), but places the memory on the given NUMA node
> +rather than on the node of the device. This is useful for memory accessed
> +frequently by both the device and a CPU on a different node, for example
> +descriptor rings serviced by that CPU.
> +
> +Like with kmalloc_node() the node is only a preference.
> +
>  ::
>  
>  	void
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index efde0e5a58dc..f8529f761823 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -188,6 +188,8 @@ void dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
>  		enum dma_data_direction dir, unsigned long attrs);
>  void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  		gfp_t flag, unsigned long attrs);
> +void *dma_alloc_attrs_node(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs, int node);
>  void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
>  		dma_addr_t dma_handle, unsigned long attrs);
>  void *dmam_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
> @@ -273,6 +275,11 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
>  {
>  	return NULL;
>  }
> +static inline void *dma_alloc_attrs_node(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs, int node)
> +{
> +	return NULL;
> +}
>  static inline void dma_free_attrs(struct device *dev, size_t size,
>  		void *cpu_addr, dma_addr_t dma_handle, unsigned long attrs)
>  {
> @@ -626,6 +633,13 @@ static inline void *dma_alloc_coherent(struct device *dev, size_t size,
>  			(gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0);
>  }
>  
> +static inline void *dma_alloc_coherent_node(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, gfp_t gfp, int node)
> +{
> +	return dma_alloc_attrs_node(dev, size, dma_handle, gfp,
> +			(gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0, node);
> +}
> +
>  static inline void dma_free_coherent(struct device *dev, size_t size,
>  		void *cpu_addr, dma_addr_t dma_handle)
>  {
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 82e701648d60..1b1cd3bc4a40 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -630,8 +630,22 @@ u64 dma_get_required_mask(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dma_get_required_mask);
>  
> -void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
> -		gfp_t flag, unsigned long attrs)
> +/**
> + * dma_alloc_attrs_node - allocate coherent memory on a given NUMA node
> + * @dev: device to allocate the memory for
> + * @size: size of the allocation
> + * @dma_handle: returns the DMA address of the allocation
> + * @flag: GFP flags for the allocation
> + * @attrs: DMA_ATTR_* flags for the allocation
> + * @node: NUMA node to allocate the memory on, NUMA_NO_NODE for no preference
> + *
> + * Same as dma_alloc_attrs() but places the memory on @node rather than on the
> + * node of @dev. Like with kmalloc_node() the node is only a preference.
> + *
> + * Return: the CPU address of the allocation, or NULL on failure.
> + */
> +void *dma_alloc_attrs_node(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs, int node)
>  {
>  	const struct dma_map_ops *ops = get_dma_ops(dev);
>  	void *cpu_addr;
> @@ -681,6 +695,14 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr, attrs);
>  	return cpu_addr;
>  }
> +EXPORT_SYMBOL_GPL(dma_alloc_attrs_node);
> +
> +void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +		gfp_t flag, unsigned long attrs)
> +{
> +	return dma_alloc_attrs_node(dev, size, dma_handle, flag, attrs,
> +				    dev_to_node(dev));
> +}
>  EXPORT_SYMBOL(dma_alloc_attrs);
>  
>  void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

