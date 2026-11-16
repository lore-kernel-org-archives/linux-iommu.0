Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794833336;
	b=hyMP+P95Ag0CdJrj/EErz56Tc8UqYGxF80mn3eFThvWJ9qrVfFghNPoXS3H8tzJZs/X1
	 MGWNXVg8eg+xURH43o6M5DwQNoZMAD4B7qjvpBfzCTiTPeNs5FDQxOl4KbxCWcA+RiU3X
	 F/uY3lZsfm0LHLT+9oEZltBbOR8eTJ/fLzonN+G6jjhJQQSspf6d7T2oQAfBY1RZZQNJ1
	 aFvhMrJJG6xmtiWjrTZmDAqlBZdf56GvyW154At/kqkZpiSLq2oKiQoVhgzoquCbueAk/
	 W2kYfqisXM3+SObjXAbOApZYQUA2TVkeL46aBg9mww5kFvcf9JhhX268mHh6esd00/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794833336;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=q+vj+2gwnCsvLuhkx5/eZ6hFIO5bSIxa0YO+wbxe2XI=;
	b=Zo9hFoQYAB2W0js3IDigEPetIYHo0oqPdBq2qMn6stvMirE5odp9Htai8feegYMA2OeV
	 beWpooMNsWPJw0YsPHyOGCyaat43WGBgRBJQ2qm37gtS1GLwTLve8Nl9WMR6nTqUqpevy
	 sibW5nGZ1VcEapUtL5Dyxl8Gypkqi1yc3RQvQ5CrL4N+4wXKXDFSbmr43Soe8sCwJJCqH
	 45LXX6K7vb9QZGQsCKvhg3ARYht951bOXjjwM5ejN7Qloij2YWmnV8mHg0eXR/Gj2wMeF
	 ti+QOLKonKw0xQCjVllC/3hB5FQ9cUrz6drP9e618Ovkddcj5TjixdCR50IRpBrVYrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=vXUnHieI;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA4A606A332
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 12:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEA4A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=vXUnHieI
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261116124853euoutp0247bd30011e6615c0b12ab274d95c0ad5~oh2gtv_GO2346623466euoutp02p
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 12:48:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261116124853euoutp0247bd30011e6615c0b12ab274d95c0ad5~oh2gtv_GO2346623466euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794833333;
	bh=q+vj+2gwnCsvLuhkx5/eZ6hFIO5bSIxa0YO+wbxe2XI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=vXUnHieIz2yw+ObZTGg5tyMTifGqwLhsQ1gYBSiha8L5jipBAijhFM7gQ3PAXm81c
	 w0U1TKaoclXlzKfmNLWjueZ41UJuTJfo5KujIPpzcYH2sEvV2rB46NnMrEYD28ih8p
	 y0KSQM2UEzOvKv20NF6qT2YhtGWVCAcx5sggoxY0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261116124852eucas1p1b150cae3b2b4f5dac6550d7236791c35~oh2gXEqqS3152131521eucas1p1p;
	Mon, 16 Nov 2026 12:48:52 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261116124851eusmtip129b1231d1435be7a0a2c4fa4d4861c9f~oh2fZOj-F3032230322eusmtip1O;
	Mon, 16 Nov 2026 12:48:51 +0000 (GMT)
Message-ID: <2be89ecd-2809-4182-b2c4-df062fcf68b6@samsung.com>
Date: Mon, 16 Nov 2026 13:48:51 +0100
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
Subject: Re: [PATCH 05/40] dma-contiguous: add dma_get_numa_cma_area()
 accessor
To: Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org, Greg
	Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>, Shuah
	Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
	iommu@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>, David
	Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	nh-open-source@amazon.com, linux-mm@kvack.org, Jonathan Corbet
	<corbet@lwn.net>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <a1294df95fbe0a2ef5cc3585824d396854c7242c.1794393490.git.graf@amazon.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261116124852eucas1p1b150cae3b2b4f5dac6550d7236791c35
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261111224311eucas1p1eb735607894271094a8934b187647ad5
X-EPHeader: CA
X-CMS-RootMailID: 20261111224311eucas1p1eb735607894271094a8934b187647ad5
References: <cover.1794300002.git.graf@amazon.com>
	<CGME20261111224311eucas1p1eb735607894271094a8934b187647ad5@eucas1p1.samsung.com>
	<a1294df95fbe0a2ef5cc3585824d396854c7242c.1794393490.git.graf@amazon.com>

On 11.11.2026 23:41, Alexander Graf wrote:
> With Nitro Sandboxes, we want to allocate per-NUMA memory from the DMA
> contiguous allocator, but have no per-NUMA struct device to pass in.
> dma_alloc_contiguous() takes the node from dev_to_node(dev), and the
> per-node areas sit in dma_contiguous_numa_area[], which is static.
>
> So instead, introduce dma_get_numa_cma_area(), which returns the generic
> per-NUMA DMA CMA area that cma_alloc() would use. This way, the
> nitro_enclaves driver can build its own generic CMA pool per-node
> allocation logic on top of those pools.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>

Take a look at the following patch and the patchset it belongs to:

https://lore.kernel.org/all/20261106184433.761422-5-kuba@kernel.org/


> ---
>  include/linux/dma-map-ops.h |  7 +++++++
>  kernel/dma/contiguous.c     | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index afaf2c12189b8..5f7138ea6899a 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -93,6 +93,7 @@ static inline void set_dma_ops(struct device *dev,
>  #ifdef CONFIG_DMA_CMA
>  struct cma *dev_get_cma_area(struct device *dev);
>  struct cma *dma_contiguous_get_area_by_idx(unsigned int idx);
> +struct cma *dma_get_numa_cma_area(int nid);
>  
>  void dma_contiguous_reserve(phys_addr_t addr_limit);
>  int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
> @@ -115,6 +116,12 @@ static inline struct cma *dma_contiguous_get_area_by_idx(unsigned int idx)
>  {
>  	return NULL;
>  }
> +
> +static inline struct cma *dma_get_numa_cma_area(int nid)
> +{
> +	return NULL;
> +}
> +
>  static inline void dma_contiguous_reserve(phys_addr_t limit)
>  {
>  }
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 90937dc7c627d..363b84284d087 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -443,6 +443,42 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>  	return cma_alloc_aligned(dma_contiguous_default_area, size, gfp);
>  }
>  
> +/**
> + * dma_get_numa_cma_area() - get the CMA area a NUMA node can allocate from
> + * @nid: NUMA node id
> + *
> + * dma_alloc_contiguous() picks a per-node CMA area from dev_to_node(dev),
> + * which a caller cannot override on a per-request basis. This accessor
> + * returns the area a specific node can allocate from, so a caller can
> + * cma_alloc() from the node it wants.
> + *
> + * A per-node area comes from numa_cma= or cma_pernuma=, or from
> + * CONFIG_CMA_SIZE_PERNUMA, which reserves the default area's size on every
> + * online node on top of the default area itself, all three of which are
> + * CONFIG_DMA_NUMA_CMA. Where there is one online node this returns the default
> + * area, so a host that reserved only cma= reaches its reservation through this
> + * accessor as well, and that holds however CONFIG_DMA_NUMA_CMA is set.
> + *
> + * Return: the area @nid can allocate from, or NULL if @nid has none or is not
> + * a valid node (including NUMA_NO_NODE).
> + */
> +struct cma *dma_get_numa_cma_area(int nid)
> +{
> +	if ((unsigned int)nid >= MAX_NUMNODES)
> +		return NULL;
> +
> +#ifdef CONFIG_DMA_NUMA_CMA
> +	if (dma_contiguous_numa_area[nid])
> +		return dma_contiguous_numa_area[nid];
> +#endif
> +
> +	if (nr_online_nodes == 1 && node_online(nid))
> +		return dma_contiguous_default_area;
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(dma_get_numa_cma_area);
> +
>  /**
>   * dma_free_contiguous() - release allocated pages
>   * @dev:   Pointer to device for which the pages were allocated.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

