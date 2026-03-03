Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECD637702F
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772527009; cv=none; b=U0a3EvX+VhqIBYtLC/5M6ClzCQoMdHmMy1P7xK3ZSy6y6c8aH/uLn/CTxT3rEY0C8zIri/XGTaZR9eogzemogmK2pvMa2l0JMcwt0zaT5Zk1zpr75vb6GEOYq43pcK1p60nyCuovlyqM8P/i7qVj/9toN3VmEaoimgP1uNY776c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772527009; c=relaxed/simple;
	bh=/0C0lfBaQnhgxXYzGZ+UN613lVOyS0k9lpohIJJcYWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIrFgMPqXnk3olpstg1spj5EnfYTS63xfSzLEKs6hOwvfzcjBkhGEGAMaD8VMrKcFTvMkaXknK/1b1zIanTtdYoelBcjIlkMlSlN5/tmjMKuFgNaD6PLyg1z8PRRlyvvkvy0Kz//2EdOjwF0KVaWuuGUj0K2JI0jvL2/MqSNCX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gy0vjgtM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gy0vjgtM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772527007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=viUy7hzMU4+O4xdoDCnRaeiIoPG6PXt0vSgDJ4O3NVU=;
	b=Gy0vjgtMie47zVtm0cfe4HXrlAx4rqq2ky4LBUvyJmZhlE4z9X+7G92bXyk/Czia8qy0ac
	Pz9SI3/wcc954WcczoqddznPUBhlyEXaQx7TjmS+haVFoRgubod7mG+tl9ERDoHdAqH3sG
	/1Xd8wCUr+bVVWCLoTxkBh8OKNous6Q=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-t_gxhyw9MVa6SLdHPoN9AA-1; Tue, 03 Mar 2026 03:36:46 -0500
X-MC-Unique: t_gxhyw9MVa6SLdHPoN9AA-1
X-Mimecast-MFC-AGG-ID: t_gxhyw9MVa6SLdHPoN9AA_1772527005
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-45f2793a34dso59435827b6e.0
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 00:36:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772527005; x=1773131805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=viUy7hzMU4+O4xdoDCnRaeiIoPG6PXt0vSgDJ4O3NVU=;
        b=d3b6PO37QAFDbiqv14n7HIPKHy7cKniRxgWBPLTwDgSyevZCAyNkpyh55vaEPaXkGe
         Y2eHU6PW+S3FKu169saYlvG8YM2APm/N+gXE2amSSj28oZymVLGJgAtolv2Ai1mfSxtd
         WR+f+bosU2bzLS9t0oWlMvGS/v+bhX8uE2ULCfANaJUlQ4Lex2rqPELv+fjcC2HWfwO4
         qHQ7z0Q1B7AkfvSHLyyiSZXRJfB9zIopPH4bqpt5xLrIKFeo3uLVud0xhHNBcD5GMhVI
         HnRZ/YByo4BLRJbvdlEkcdk3hrkUafzBiV4iu7PISRxapx0oziJQaVtStobSXsz0m9At
         rXwg==
X-Forwarded-Encrypted: i=1; AJvYcCW+Z36z1vkRKTkYqQs4MvLVYLvWXPVE8+2bs2KoDem+Dz36yYKjChW5gUbbNGN1FAhC+FnrNg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyh1r3s1MqlV0+EBYe7GrxAzve9pMjUal57k2tn3YUF3ZM62kuO
	3INvvOXrjsFagckXdfx5ndSEWFnjIKj75xJGYFYsHB2n2jycXcUTmg14Tk47zjpBzwk700fGtTP
	ll4gPoqJC/ENjPChyNYOok2ceFTox2QJHnyifloXipqWEz/W2ht3gF4ovuEwOcPRhQjhDArGhyC
	DsO9snxFL/JoAAq1xEyh7iCyqiGV2RUT4sriwE1ZgkZw==
X-Gm-Gg: ATEYQzwHOBiOjx6NnfsL8oeKvfQ3XQIX1ZvqX5pJ5LT+es2ZFur+b0tIQ62oHix3jd7
	ttwywQOAXyCZdpomdHhS25qZ0EzgTHzSZdEz53VFb65f1nIVQTq8BtzefCTQqgu2kZ/DM5a5B2c
	7iRBpSWjXnuUO19eZ5rMl1BhKt/6Ll/n/0nxn5DpjK52u1QMxQGVmpjSq6KCbqXPytaM5PDtMqt
	A==
X-Received: by 2002:a05:6808:4a58:20b0:45f:13fe:4a3d with SMTP id 5614622812f47-464be9218c9mr5624887b6e.7.1772527005226;
        Tue, 03 Mar 2026 00:36:45 -0800 (PST)
X-Received: by 2002:a05:690e:2026:b0:64c:e819:1b63 with SMTP id
 956f58d0204a3-64ce8191c0fmr2298965d50.23.1772526612385; Tue, 03 Mar 2026
 00:30:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260227-dma-buf-heaps-as-modules-v2-0-454aee7e06cc@kernel.org> <20260227-dma-buf-heaps-as-modules-v2-1-454aee7e06cc@kernel.org>
In-Reply-To: <20260227-dma-buf-heaps-as-modules-v2-1-454aee7e06cc@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 3 Mar 2026 09:30:01 +0100
X-Gm-Features: AaiRm51O-7HLXl5WqAQFt8ndmggiU93wYFS2Jxqx5wmhO0yrhCBFx8LCXAa_vkY
Message-ID: <CADSE00KTKhzuB1vDj=hkBVE+5dq+=q3xRsj6dK_96Jhqi49OwQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dma: contiguous: Turn heap registration logic around
To: Maxime Ripard <mripard@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n5NWAhge3Vy-ZIKkdx5Fmm56Q7YQ7vLbD2gxMRh4P00_1772527005
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 2:23=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> The CMA heap instantiation was initially developed by having the
> contiguous DMA code call into the CMA heap to create a new instance
> every time a reserved memory area is probed.
>
> Turning the CMA heap into a module would create a dependency of the
> kernel on a module, which doesn't work.
>
> Let's turn the logic around and do the opposite: store all the reserved
> memory CMA regions into the contiguous DMA code, and provide an iterator
> for the heap to use when it probes.
>
> Reviewed-by: T.J. Mercier <tjmercier@google.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Albert Esteve <aesteve@redhat.com>

> ---
>  drivers/dma-buf/heaps/cma_heap.c | 18 ++----------------
>  include/linux/dma-map-ops.h      |  5 +++++
>  kernel/dma/contiguous.c          | 26 ++++++++++++++++++++++++--
>  3 files changed, 31 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma=
_heap.c
> index bd3370b9a3f6d4e18885a1d0e8ba3f659b85ef47..f8a3d87f3ccee9630383ba285=
02eb40b10671cc2 100644
> --- a/drivers/dma-buf/heaps/cma_heap.c
> +++ b/drivers/dma-buf/heaps/cma_heap.c
> @@ -28,23 +28,10 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>
>  #define DEFAULT_CMA_NAME "default_cma_region"
>
> -static struct cma *dma_areas[MAX_CMA_AREAS] __initdata;
> -static unsigned int dma_areas_num __initdata;
> -
> -int __init dma_heap_cma_register_heap(struct cma *cma)
> -{
> -       if (dma_areas_num >=3D ARRAY_SIZE(dma_areas))
> -               return -EINVAL;
> -
> -       dma_areas[dma_areas_num++] =3D cma;
> -
> -       return 0;
> -}
> -
>  struct cma_heap {
>         struct dma_heap *heap;
>         struct cma *cma;
>  };
>
> @@ -412,22 +399,21 @@ static int __init __add_cma_heap(struct cma *cma, c=
onst char *name)
>  }
>
>  static int __init add_cma_heaps(void)
>  {
>         struct cma *default_cma =3D dev_get_cma_area(NULL);
> +       struct cma *cma;
>         unsigned int i;
>         int ret;
>
>         if (default_cma) {
>                 ret =3D __add_cma_heap(default_cma, DEFAULT_CMA_NAME);
>                 if (ret)
>                         return ret;
>         }
>
> -       for (i =3D 0; i < dma_areas_num; i++) {
> -               struct cma *cma =3D dma_areas[i];
> -
> +       for (i =3D 0; (cma =3D dma_contiguous_get_reserved_region(i)) !=
=3D NULL; i++) {
>                 ret =3D __add_cma_heap(cma, cma_get_name(cma));
>                 if (ret) {
>                         pr_warn("Failed to add CMA heap %s", cma_get_name=
(cma));
>                         continue;
>                 }
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 60b63756df821d839436618f1fca2bfa3eabe075..3007c68a8ec5b85990d1938d0=
4a2f05c1a71acdb 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -110,10 +110,11 @@ bool dma_release_from_contiguous(struct device *dev=
, struct page *pages,
>                                  int count);
>  struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t=
 gfp);
>  void dma_free_contiguous(struct device *dev, struct page *page, size_t s=
ize);
>
>  void dma_contiguous_early_fixup(phys_addr_t base, unsigned long size);
> +struct cma *dma_contiguous_get_reserved_region(unsigned int idx);
>  #else /* CONFIG_DMA_CMA */
>  static inline struct cma *dev_get_cma_area(struct device *dev)
>  {
>         return NULL;
>  }
> @@ -148,10 +149,14 @@ static inline void dma_free_contiguous(struct devic=
e *dev, struct page *page,
>         __free_pages(page, get_order(size));
>  }
>  static inline void dma_contiguous_early_fixup(phys_addr_t base, unsigned=
 long size)
>  {
>  }
> +static inline struct cma *dma_contiguous_get_reserved_region(unsigned in=
t idx)
> +{
> +       return NULL;
> +}
>  #endif /* CONFIG_DMA_CMA*/
>
>  #ifdef CONFIG_DMA_DECLARE_COHERENT
>  int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_add=
r,
>                 dma_addr_t device_addr, size_t size);
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index c56004d314dc2e436cddf3b20a4ee6ce8178bee4..14bd54fb758537f01a6fe2731=
8e7b683964e20b1 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -456,10 +456,32 @@ void dma_free_contiguous(struct device *dev, struct=
 page *page, size_t size)
>  #include <linux/of_reserved_mem.h>
>
>  #undef pr_fmt
>  #define pr_fmt(fmt) fmt
>
> +static struct cma *rmem_cma_areas[MAX_CMA_AREAS];
> +static unsigned int rmem_cma_areas_num;
> +
> +static int rmem_cma_insert_area(struct cma *cma)
> +{
> +       if (rmem_cma_areas_num >=3D ARRAY_SIZE(rmem_cma_areas))
> +               return -EINVAL;
> +
> +       rmem_cma_areas[rmem_cma_areas_num++] =3D cma;
> +
> +       return 0;
> +}
> +
> +struct cma *dma_contiguous_get_reserved_region(unsigned int idx)
> +{
> +       if (idx >=3D rmem_cma_areas_num)
> +               return NULL;
> +
> +       return rmem_cma_areas[idx];
> +}
> +EXPORT_SYMBOL_GPL(dma_contiguous_get_reserved_region);
> +
>  static int rmem_cma_device_init(struct reserved_mem *rmem, struct device=
 *dev)
>  {
>         dev->cma_area =3D rmem->priv;
>         return 0;
>  }
> @@ -504,13 +526,13 @@ static int __init rmem_cma_setup(struct reserved_me=
m *rmem)
>         rmem->priv =3D cma;
>
>         pr_info("Reserved memory: created CMA memory pool at %pa, size %l=
d MiB\n",
>                 &rmem->base, (unsigned long)rmem->size / SZ_1M);
>
> -       err =3D dma_heap_cma_register_heap(cma);
> +       err =3D rmem_cma_insert_area(cma);
>         if (err)
> -               pr_warn("Couldn't register CMA heap.");
> +               pr_warn("Couldn't store CMA reserved area.");
>
>         return 0;
>  }
>  RESERVEDMEM_OF_DECLARE(cma, "shared-dma-pool", rmem_cma_setup);
>  #endif
>
> --
> 2.53.0
>
>

