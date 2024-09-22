Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FD9637
	for <iommu@lists.linux.dev>; Sun, 22 Sep 2024 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727008871; cv=none; b=fjkQZjjFPeSjapRb1P+UKXS6ZKQXTUrplGGSmbUvZj8ZKwHYsqQLBj7kKlOeQhUS/KeFSpwBkXN03m5FArGHL9spMJns/9aPGK6U3u20ZEslZQt1CxdibKZp0xljf9IfutBuTl8+FIZl2uvvb6MzystinoOz/fin9AZMcvJe7gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727008871; c=relaxed/simple;
	bh=ns75xfATkjd11sxhGfeHQhDuAMg8CttNlkaI2FZHQEI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jBEjAJZsBpkEUnUcGP/Rb96ai4FXjal0GyTl6n1vcDCZmk+QmmVp3CrDihDm++JlDkXW+mTw1zdtI6rUmBYuUCfb/PBXHJmpn+u6G6Mkkdnn6H3jxcAh5gk/Vh/w0k/cG87qtKJCgVolWfr1/09so0MXLhjC9Cfdd62M/4rQJBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=hh/UZUph; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="hh/UZUph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1727008861;
	bh=GLI1uOocy2Wt+yuGPsr24nDocdDLCkbX/jhZuEQvHm4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hh/UZUphaBudruGzi+zqHJbZBHoC+p9FtLxtNIQtosgFbPoaGLvSJQBu+Sr17NG6L
	 TCYL/lX8Z3lKn3i9hzBr4vRt1dTx43Yx3ViM/T/VUwK9nwM/s2UoU3o38//20C1Jce
	 SU7KaHXKDIULO2whGHF1/yQCbZFYiXJK9uP9OUEI=
Received: from [192.168.124.11] (unknown [113.200.174.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 1A6EF1A3F6F;
	Sun, 22 Sep 2024 08:40:59 -0400 (EDT)
Message-ID: <f1cebb45f279cd21068acba1aac3bf438be7887c.camel@xry111.site>
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.12
From: Xi Ruoyao <xry111@xry111.site>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Leon Romanovsky
	 <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Date: Sun, 22 Sep 2024 20:40:56 +0800
In-Reply-To: <Zu_FDfHZAVzPv1lq@infradead.org>
References: <971fbb889da38ca4e60f3dedde29ea43e9338d68.camel@xry111.site>
	 <Zu1byUGU832iWBUp@infradead.org> <Zu2Bd50GdSxF_-eA@infradead.org>
	 <19e4bdbcda78ace200c78c56eb7173097337b921.camel@xry111.site>
	 <Zu5VoW1ZkViSOws3@infradead.org>
	 <9a84a7c6f943209cc87a54075ed22df37ebda5f8.camel@xry111.site>
	 <Zu7PW07FmBgs_dpI@infradead.org>
	 <38bc765eaba8a646a87ce14e1ff06f28d449fcd5.camel@xry111.site>
	 <Zu-kCdMau6127_vM@infradead.org>
	 <11368b7c0b7370aea61b3dda73e462fb70f306a7.camel@xry111.site>
	 <Zu_FDfHZAVzPv1lq@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Sun, 2024-09-22 at 00:19 -0700, Christoph Hellwig wrote:
> On Sun, Sep 22, 2024 at 02:56:57PM +0800, Xi Ruoyao wrote:
> > With SND disabled, b5c58b2fdc427e7958412ecb2de2804a1f7c1572 boots fine
> > (no oops), but the camera does not work.=20
> > f69e342eec008e1bab772d3963c3dd9979293e13 boots fine and the camera work=
s
> > fine.
> >=20
> > So the first bad commit is b5c58b2fdc427e7958412ecb2de2804a1f7c1572.
>=20
> Thanks a lot for the bisection!
>=20
> I took a quitck look what is special in the intersection of uvcvideo
> and that commit, and what springs to meind is that
> uvcvideo is one of the very few users of dma_alloc_noncontiguous, and
> while that and the free call for it got converted correctly, the
> conversion was missed for the vmap and mmap callbacks.
>=20
> Can you test the fix below?

Yes with the fix the camera is working fine now.  Thanks!

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 3672d619bcb691..2a9fa0c8cc00fe 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1038,6 +1038,21 @@ static void *iommu_dma_alloc_remap(struct device *=
dev, size_t size,
> =C2=A0	return NULL;
> =C2=A0}
> =C2=A0
> +/*
> + * This is the actual return value from the iommu_dma_alloc_noncontiguou=
s.
> + *
> + * The users of the DMA API should only care about the sg_table, but to =
make
> + * the DMA-API internal vmaping and freeing easier we stash away the pag=
e
> + * array as well (except for the fallback case).=C2=A0 This can go away =
any time,
> + * e.g. when a vmap-variant that takes a scatterlist comes along.
> + */
> +struct dma_sgt_handle {
> +	struct sg_table sgt;
> +	struct page **pages;
> +};
> +#define sgt_handle(sgt) \
> +	container_of((sgt), struct dma_sgt_handle, sgt)
> +
> =C2=A0struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev, =
size_t size,
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum dma_data_direction dir, =
gfp_t gfp, unsigned long attrs)
> =C2=A0{
> @@ -1066,6 +1081,24 @@ void iommu_dma_free_noncontiguous(struct device *d=
ev, size_t size,
> =C2=A0	kfree(sh);
> =C2=A0}
> =C2=A0
> +void *iommu_dma_vmap_noncontiguous(struct device *dev, size_t size,
> +		struct sg_table *sgt)
> +{
> +	unsigned long count =3D PAGE_ALIGN(size) >> PAGE_SHIFT;
> +
> +	return vmap(sgt_handle(sgt)->pages, count, VM_MAP, PAGE_KERNEL);
> +}
> +
> +int iommu_dma_mmap_noncontiguous(struct device *dev, struct vm_area_stru=
ct *vma,
> +		size_t size, struct sg_table *sgt)
> +{
> +	unsigned long count =3D PAGE_ALIGN(size) >> PAGE_SHIFT;
> +
> +	if (vma->vm_pgoff >=3D count || vma_pages(vma) > count - vma->vm_pgoff)
> +		return -ENXIO;
> +	return vm_map_pages(vma, sgt_handle(sgt)->pages, count);
> +}
> +
> =C2=A0void iommu_dma_sync_single_for_cpu(struct device *dev, dma_addr_t d=
ma_handle,
> =C2=A0		size_t size, enum dma_data_direction dir)
> =C2=A0{
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 9668ddf3696e71..b7773201414c27 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -24,11 +24,6 @@ struct dma_map_ops {
> =C2=A0			gfp_t gfp);
> =C2=A0	void (*free_pages)(struct device *dev, size_t size, struct page *v=
addr,
> =C2=A0			dma_addr_t dma_handle, enum dma_data_direction dir);
> -	struct sg_table *(*alloc_noncontiguous)(struct device *dev, size_t size=
,
> -			enum dma_data_direction dir, gfp_t gfp,
> -			unsigned long attrs);
> -	void (*free_noncontiguous)(struct device *dev, size_t size,
> -			struct sg_table *sgt, enum dma_data_direction dir);
> =C2=A0	int (*mmap)(struct device *, struct vm_area_struct *,
> =C2=A0			void *, dma_addr_t, size_t, unsigned long attrs);
> =C2=A0
> @@ -206,20 +201,6 @@ static inline int dma_mmap_from_global_coherent(stru=
ct vm_area_struct *vma,
> =C2=A0}
> =C2=A0#endif /* CONFIG_DMA_GLOBAL_POOL */
> =C2=A0
> -/*
> - * This is the actual return value from the ->alloc_noncontiguous method=
.
> - * The users of the DMA API should only care about the sg_table, but to =
make
> - * the DMA-API internal vmaping and freeing easier we stash away the pag=
e
> - * array as well (except for the fallback case).=C2=A0 This can go away =
any time,
> - * e.g. when a vmap-variant that takes a scatterlist comes along.
> - */
> -struct dma_sgt_handle {
> -	struct sg_table sgt;
> -	struct page **pages;
> -};
> -#define sgt_handle(sgt) \
> -	container_of((sgt), struct dma_sgt_handle, sgt)
> -
> =C2=A0int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt=
,
> =C2=A0		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> =C2=A0		unsigned long attrs);
> diff --git a/include/linux/iommu-dma.h b/include/linux/iommu-dma.h
> index 1bb55ca1ab79d7..7bf145a52d6a1a 100644
> --- a/include/linux/iommu-dma.h
> +++ b/include/linux/iommu-dma.h
> @@ -44,6 +44,12 @@ struct sg_table *iommu_dma_alloc_noncontiguous(struct =
device *dev, size_t size,
> =C2=A0		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs);
> =C2=A0void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> =C2=A0		struct sg_table *sgt, enum dma_data_direction dir);
> +void *iommu_dma_vmap_noncontiguous(struct device *dev, size_t size,
> +		struct sg_table *sgt);
> +#define iommu_dma_vunmap_noncontiguous(dev, vaddr) \
> +	vunmap(vaddr);
> +int iommu_dma_mmap_noncontiguous(struct device *dev, struct vm_area_stru=
ct *vma,
> +		size_t size, struct sg_table *sgt);
> =C2=A0void iommu_dma_sync_single_for_cpu(struct device *dev, dma_addr_t d=
ma_handle,
> =C2=A0		size_t size, enum dma_data_direction dir);
> =C2=A0void iommu_dma_sync_single_for_device(struct device *dev, dma_addr_=
t dma_handle,
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index b839683da0baf0..7911c754d9f42a 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -750,7 +750,6 @@ static struct sg_table *alloc_single_sgt(struct devic=
e *dev, size_t size,
> =C2=A0struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t=
 size,
> =C2=A0		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs)
> =C2=A0{
> -	const struct dma_map_ops *ops =3D get_dma_ops(dev);
> =C2=A0	struct sg_table *sgt;
> =C2=A0
> =C2=A0	if (WARN_ON_ONCE(attrs & ~DMA_ATTR_ALLOC_SINGLE_PAGES))
> @@ -758,9 +757,7 @@ struct sg_table *dma_alloc_noncontiguous(struct devic=
e *dev, size_t size,
> =C2=A0	if (WARN_ON_ONCE(gfp & __GFP_COMP))
> =C2=A0		return NULL;
> =C2=A0
> -	if (ops && ops->alloc_noncontiguous)
> -		sgt =3D ops->alloc_noncontiguous(dev, size, dir, gfp, attrs);
> -	else if (use_dma_iommu(dev))
> +	if (use_dma_iommu(dev))
> =C2=A0		sgt =3D iommu_dma_alloc_noncontiguous(dev, size, dir, gfp, attrs)=
;
> =C2=A0	else
> =C2=A0		sgt =3D alloc_single_sgt(dev, size, dir, gfp);
> @@ -786,13 +783,10 @@ static void free_single_sgt(struct device *dev, siz=
e_t size,
> =C2=A0void dma_free_noncontiguous(struct device *dev, size_t size,
> =C2=A0		struct sg_table *sgt, enum dma_data_direction dir)
> =C2=A0{
> -	const struct dma_map_ops *ops =3D get_dma_ops(dev);
> -
> =C2=A0	trace_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir, 0);
> =C2=A0	debug_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir);
> -	if (ops && ops->free_noncontiguous)
> -		ops->free_noncontiguous(dev, size, sgt, dir);
> -	else if (use_dma_iommu(dev))
> +
> +	if (use_dma_iommu(dev))
> =C2=A0		iommu_dma_free_noncontiguous(dev, size, sgt, dir);
> =C2=A0	else
> =C2=A0		free_single_sgt(dev, size, sgt, dir);
> @@ -802,37 +796,26 @@ EXPORT_SYMBOL_GPL(dma_free_noncontiguous);
> =C2=A0void *dma_vmap_noncontiguous(struct device *dev, size_t size,
> =C2=A0		struct sg_table *sgt)
> =C2=A0{
> -	const struct dma_map_ops *ops =3D get_dma_ops(dev);
> -	unsigned long count =3D PAGE_ALIGN(size) >> PAGE_SHIFT;
> =C2=A0
> -	if (ops && ops->alloc_noncontiguous)
> -		return vmap(sgt_handle(sgt)->pages, count, VM_MAP, PAGE_KERNEL);
> +	if (use_dma_iommu(dev))
> +		return iommu_dma_vmap_noncontiguous(dev, size, sgt);
> +
> =C2=A0	return page_address(sg_page(sgt->sgl));
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(dma_vmap_noncontiguous);
> =C2=A0
> =C2=A0void dma_vunmap_noncontiguous(struct device *dev, void *vaddr)
> =C2=A0{
> -	const struct dma_map_ops *ops =3D get_dma_ops(dev);
> -
> -	if (ops && ops->alloc_noncontiguous)
> -		vunmap(vaddr);
> +	if (use_dma_iommu(dev))
> +		iommu_dma_vunmap_noncontiguous(dev, vaddr);
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(dma_vunmap_noncontiguous);
> =C2=A0
> =C2=A0int dma_mmap_noncontiguous(struct device *dev, struct vm_area_struc=
t *vma,
> =C2=A0		size_t size, struct sg_table *sgt)
> =C2=A0{
> -	const struct dma_map_ops *ops =3D get_dma_ops(dev);
> -
> -	if (ops && ops->alloc_noncontiguous) {
> -		unsigned long count =3D PAGE_ALIGN(size) >> PAGE_SHIFT;
> -
> -		if (vma->vm_pgoff >=3D count ||
> -		=C2=A0=C2=A0=C2=A0 vma_pages(vma) > count - vma->vm_pgoff)
> -			return -ENXIO;
> -		return vm_map_pages(vma, sgt_handle(sgt)->pages, count);
> -	}
> +	if (use_dma_iommu(dev))
> +		return iommu_dma_mmap_noncontiguous(dev, vma, size, sgt);
> =C2=A0	return dma_mmap_pages(dev, vma, size, sg_page(sgt->sgl));
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(dma_mmap_noncontiguous);

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
