Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F233559E8
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549251; cv=none; b=UIqmfzhwF0TlJ3/zfQG1Jm/o2oqj+GgyLoHQmCgZ9IqtsRKNCIzsFh0zoCd74DwxRGoJDWbP+tHZRDomK/HeVJWFX3MspB4ljFT9vYfdX5lybi2c6y7YgFVaVWn31lX1FkPqANh3jawqdpbYG7H0EDjqcJNdxuXqSDPtt+qfoi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549251; c=relaxed/simple;
	bh=7MpbblFcPZi3wBjzTsxHXVpnWCSauFBEUdLtqyENUK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4GCs/3aCmCTW4g+mulG4ta1l94/klWZNJEe3zJqfeotwWTuRFIOilGBvaLPO5/h6yLa0v2XG6PKxH+Hl3AuUc8Gxjl0OH2OLPeDKqZ/TMwZQbd9KYsu+uJ3fx+IP1aZZZup0+O1Jd1zdax80SdJ1VJx6Ml1VAUlkPGFu7bmdj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATb9Hcfj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATb9Hcfj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772549248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67yY3F56XFWrwiaal1aRX9aq+ZjoX8WGlYCGFwR1Ay0=;
	b=ATb9HcfjF8+tBFdTlQbs8GYDvQCcBDrUJBIrxcKz6GkzwZlVmhkruCPfJ+YJkCZvhVfnYj
	Qc2VEeERPMFzRiRfuomTHkj0b+gixpZtppDtWzWb5MRJBbm2uKcdZajS6zm74rwvU8qbDe
	WoyVrI7YTNRmVTiLJY6bYq8eHmb0KAE=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-Wp8KxAT3NOCO7UTnZGms9g-1; Tue, 03 Mar 2026 09:47:27 -0500
X-MC-Unique: Wp8KxAT3NOCO7UTnZGms9g-1
X-Mimecast-MFC-AGG-ID: Wp8KxAT3NOCO7UTnZGms9g_1772549246
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-64ca2fce827so12175558d50.0
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 06:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772549246; x=1773154046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=67yY3F56XFWrwiaal1aRX9aq+ZjoX8WGlYCGFwR1Ay0=;
        b=GdB7JEvhIeLH3uxjd5ufe/jRuda5wtskC1K6BPfadfjauxtZ2JjGCx9mtKC5SXveFB
         kIfogQSxHd6rbdwudHaUZVeddK+T6xEGUbawzO3T3R7JRiPFGnKdCwR4WMI6Byi3kOPn
         tohkM4+KX20T6SwMLrpkHY+feTQjZVzxoQh10tSjkHGwXJknANH+fm5h/pMr1GVqSDq/
         hlb/BJ5GmSxaKfi1ShzqfPObkE4UFQKL6JbfXlhkHX708juud8FbAd7b1lCK8ziv0o1S
         1A/Rn030wTr27gU0lt0iFPsmiAevv3RaUxxzUbLfaMX/5CrhayTFUvTLipb4IEaqvWsw
         anTg==
X-Forwarded-Encrypted: i=1; AJvYcCXeMrQpuR6Hl4vlFYXGJjdtOlOLkDN3byFowqm/FuH95soJrmLrDeLtfnRrjk/DcqaLwaeQhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxe5s/xuKJb6osh5EMyB5cSopnf6bfAXjWkLtpwrTDbHiIc6Gi9
	+DwC2GComFgZc/vjqdznK4246xPGPu1VETpdaTJouZBvcnoWyDJY1IEvUI+feMpg7XiPdg5SIWb
	sNpAOdPDmQgm1bPH2wz4oqOo4Ux7wojmhnZBrRoPnB1NAPNi9KUsFL+3bjlApTuiIRmRcjSThTc
	gTXFy42J6EdAZKVQbyjpultoyrypjk8X8=
X-Gm-Gg: ATEYQzyo5YM4wJzDfuQfV9TEirZAzt+Y2r+/67Ztiu7AjMzrIYEN2oKI4JaDurY+8Tn
	MRFAo8uztBMyeJXKh1pFhA+a5cxjEN4G70oZFCfj5iZPGUX9maA30J/2ZEPfAmbdMsSs64CDkfs
	mWHHtLwwgR2t+v233/N1ZS8sRDzncQuCrQTbhQmn6K1QooRd+aUyj9vy5MPqCD0emPJiGo0sU/N
	A==
X-Received: by 2002:a05:690e:b4b:b0:64c:cfae:a9c4 with SMTP id 956f58d0204a3-64cedbb766amr1502449d50.15.1772549245624;
        Tue, 03 Mar 2026 06:47:25 -0800 (PST)
X-Received: by 2002:a05:690e:b4b:b0:64c:cfae:a9c4 with SMTP id
 956f58d0204a3-64cedbb766amr1502428d50.15.1772549245221; Tue, 03 Mar 2026
 06:47:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260303-b4-dmabuf-heap-coherent-rmem-v2-0-65a4653b3378@redhat.com>
 <20260303-b4-dmabuf-heap-coherent-rmem-v2-4-65a4653b3378@redhat.com> <20260303-rigorous-cow-of-saturation-23f87b@houat>
In-Reply-To: <20260303-rigorous-cow-of-saturation-23f87b@houat>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 3 Mar 2026 15:47:14 +0100
X-Gm-Features: AaiRm519G2sejRBJyA3Xs8Zi4JtzQv5MBBjaKxQXlykPb9RAYNkCbJ50N8lMMy0
Message-ID: <CADSE00+jCZSHi=OLbmOebBwnue5tjG7AFPKN76CbYDWYBcP+AA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] dma-buf: heaps: Add Coherent heap to dmabuf heaps
To: Maxime Ripard <mripard@redhat.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, echanude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2AyPUpC__miYLjtGNed1yA6JjGpzmkh6J6OHK-Y08LU_1772549246
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 2:20=E2=80=AFPM Maxime Ripard <mripard@redhat.com> w=
rote:
>
> Hi,
>
> On Tue, Mar 03, 2026 at 01:33:47PM +0100, Albert Esteve wrote:
> > Add a dma-buf heap for DT coherent reserved-memory
> > (i.e., 'shared-dma-pool' without 'reusable' property),
> > exposing one heap per region for userspace buffers.
> >
> > The heap binds the heap device to each memory region so
> > coherent allocations use the correct dev->dma_mem, and
> > it defers registration until module_init when normal
> > allocators are available.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  drivers/dma-buf/dma-heap.c            |   4 +-
> >  drivers/dma-buf/heaps/Kconfig         |   9 +
> >  drivers/dma-buf/heaps/Makefile        |   1 +
> >  drivers/dma-buf/heaps/coherent_heap.c | 426 ++++++++++++++++++++++++++=
++++++++
> >  include/linux/dma-heap.h              |  11 +
> >  include/linux/dma-map-ops.h           |   7 +
> >  6 files changed, 456 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > index 88189d4e48561..ba87e5ac16ae2 100644
> > --- a/drivers/dma-buf/dma-heap.c
> > +++ b/drivers/dma-buf/dma-heap.c
> > @@ -390,8 +390,8 @@ struct dma_heap *dma_heap_add(const struct dma_heap=
_export_info *exp_info)
> >
> >       heap =3D dma_heap_create(exp_info);
> >       if (IS_ERR(heap)) {
> > -             pr_err("dma_heap: failed to create heap (%d)\n", PTR_ERR(=
heap));
> > -             return PTR_ERR(heap);
> > +             pr_err("dma_heap: failed to create heap (%ld)\n", PTR_ERR=
(heap));
> > +             return ERR_CAST(heap);
>
> This looks unrelated and should possibly be squashed into the previous
> patch that introduces dma_heap_create()?
>
> > +static int coherent_heap_init_dma_mask(struct device *dev)
> > +{
> > +     int ret;
> > +
> > +     ret =3D dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > +     if (!ret)
> > +             return 0;
> > +
> > +     /* Fallback to 32-bit DMA mask */
> > +     return dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > +}
>
> Why do you need to mess with the DMA mask? I'd expect that device to be
> able to access everything.

When I tested I was getting: "reserved memory is beyond device's set
DMA address range", so I tested if it was fixed with
dma_coerce_mask_and_coherent() and/or dma_set_mask_coherent(). I did
not debug the value of coherent_dma_mask, but given the error I assume
it was not set properly? Ultimately, using the 64 bit mask fixed it,
and I added a 32-bit fallback to ensure support for 32-bit systems.

>
> > +static int __coherent_heap_register(struct reserved_mem *rmem)
> > +{
> > +     struct dma_heap_export_info exp_info;
> > +     struct coherent_heap *coh_heap;
> > +     struct device *heap_dev;
> > +     int ret;
> > +
> > +     if (!rmem || !rmem->name)
> > +             return -EINVAL;
> > +
> > +     coh_heap =3D kzalloc_obj(*coh_heap);
> > +     if (!coh_heap)
> > +             return -ENOMEM;
> > +
> > +     coh_heap->rmem =3D rmem;
> > +     coh_heap->name =3D kstrdup(rmem->name, GFP_KERNEL);
> > +     if (!coh_heap->name) {
> > +             ret =3D -ENOMEM;
> > +             goto free_coherent_heap;
> > +     }
> > +
> > +     exp_info.name =3D coh_heap->name;
> > +     exp_info.ops =3D &coherent_heap_ops;
> > +     exp_info.priv =3D coh_heap;
> > +
> > +     coh_heap->heap =3D dma_heap_create(&exp_info);
> > +     if (IS_ERR(coh_heap->heap)) {
> > +             ret =3D PTR_ERR(coh_heap->heap);
> > +             goto free_name;
> > +     }
> > +
> > +     heap_dev =3D dma_heap_get_dev(coh_heap->heap);
> > +     ret =3D coherent_heap_init_dma_mask(heap_dev);
> > +     if (ret) {
> > +             pr_err("coherent_heap: failed to set DMA mask (%d)\n", re=
t);
> > +             goto destroy_heap;
> > +     }
> > +
> > +     ret =3D of_reserved_mem_device_init_with_mem(heap_dev, rmem);
> > +     if (ret) {
> > +             pr_err("coherent_heap: failed to initialize memory (%d)\n=
", ret);
> > +             goto destroy_heap;
> > +     }
> > +
> > +     ret =3D dma_heap_register(coh_heap->heap);
> > +     if (ret) {
> > +             pr_err("coherent_heap: failed to register heap (%d)\n", r=
et);
> > +             goto destroy_heap;
> > +     }
>
> I guess it's more of a comment about your previous patch, but it's not
> clear to me why you needed to split dma_heap_add into dma_heap_create /
> _register. Can you expand a bit?

So first I tried to just use dma_heap_add() and then use the heap_dev
afterward to call of_reserved_mem_device_init_with_mem(), but if that
call failed, the error path required some kind dma_heap_remove()
function as the heap was already registered by then.

In the CMA heap for example, dma_heap_add() is invoked at the end of
the `init` function. Therefore, you do not have this issue, if it
failed it means the heap was not added and you just need to clean
everything else.

However, performing a remove() does not sound like something that can
be done safely. I've spent some time thinking on alternatives, but
splitting felt the best pattern.

This way I can:
1. Create the device
2. Call of_reserved_mem_device_init_with_mem
3. Register the heap

This places registration at the end, making every error path and
cleanup easy to handle.

Also, the `dma_heap_add()` code already seemed to handle these two
parts/phases implicitly with device_create(), so splitting felt
architecturally sound.

>
> > diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
> > index 1b0ea43ba66c3..77e6cb66ffce1 100644
> > --- a/include/linux/dma-heap.h
> > +++ b/include/linux/dma-heap.h
> > @@ -9,10 +9,12 @@
> >  #ifndef _DMA_HEAPS_H
> >  #define _DMA_HEAPS_H
> >
> > +#include <linux/errno.h>
> >  #include <linux/types.h>
> >
> >  struct dma_heap;
> >  struct device;
> > +struct reserved_mem;
> >
> >  /**
> >   * struct dma_heap_ops - ops to operate on a given heap
> > @@ -53,4 +55,13 @@ struct dma_heap *dma_heap_add(const struct dma_heap_=
export_info *exp_info);
> >
> >  extern bool mem_accounting;
> >
> > +#if IS_ENABLED(CONFIG_DMABUF_HEAPS_COHERENT)
> > +int dma_heap_coherent_register(struct reserved_mem *rmem);
> > +#else
> > +static inline int dma_heap_coherent_register(struct reserved_mem *rmem=
)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +#endif
> > +
> >  #endif /* _DMA_HEAPS_H */
>
> Do you still need that now that you switched to an iterator-like
> function?
>
> > diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> > index 60b63756df821..c87e5e44e5383 100644
> > --- a/include/linux/dma-map-ops.h
> > +++ b/include/linux/dma-map-ops.h
> > @@ -12,6 +12,7 @@
> >
> >  struct cma;
> >  struct iommu_ops;
> > +struct reserved_mem;
> >
> >  struct dma_map_ops {
> >       void *(*alloc)(struct device *dev, size_t size,
> > @@ -161,6 +162,7 @@ int dma_alloc_from_dev_coherent(struct device *dev,=
 ssize_t size,
> >  int dma_release_from_dev_coherent(struct device *dev, int order, void =
*vaddr);
> >  int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_stru=
ct *vma,
> >               void *cpu_addr, size_t size, int *ret);
> > +struct reserved_mem *dma_coherent_get_reserved_region(unsigned int idx=
);
> >  #else
> >  static inline int dma_declare_coherent_memory(struct device *dev,
> >               phys_addr_t phys_addr, dma_addr_t device_addr, size_t siz=
e)
> > @@ -172,6 +174,11 @@ static inline int dma_declare_coherent_memory(stru=
ct device *dev,
> >  #define dma_release_from_dev_coherent(dev, order, vaddr) (0)
> >  #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
> >  static inline void dma_release_coherent_memory(struct device *dev) { }
> > +static inline
> > +struct reserved_mem *dma_coherent_get_reserved_region(unsigned int idx=
)
> > +{
> > +     return NULL;
> > +}
> >  #endif /* CONFIG_DMA_DECLARE_COHERENT */
> >
> >  #ifdef CONFIG_DMA_GLOBAL_POOL
>
> To preserve bisectability, you shouldn't do it that way. Introduce this
> function into a preliminary patch, and then use it in this one.
>
> Maxime

