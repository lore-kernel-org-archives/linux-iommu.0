Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FA23A6B61
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224412; cv=none; b=CpJ+nCtq+e996bn5ToscQU5w8HQQD8abt90NBE0Ob8fIqviPjFd7s2bvQwAnH1H7QOl9MIgHh5smXhVPgdyzuaHSG/LE92L31YT2rP6Vbm73Ius8BG0yIe8rla1Yjg4qZL10fvcdJpchsybmcxoa8Rl513Wz/6Yd3ZB3D6Jorx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224412; c=relaxed/simple;
	bh=zQ4pRyC74bQdatJMqb9Q5rSzwpmdFScCFkWBetWIsAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foGSP52Hk8KYRNXQMyw7gaF5zZ4MrwwMAsNRvRM/4c2GNzol/GI+ra55YYNPiByNp7kTVRQ5B1tmZglGPiM5FBPfcGlVlArVUsNqnL2rbwY0Md96Q7tnQCrSdRc+oHnfZqHtjFJzqntDGeSr2FahbHWtnJpu2ztUWN+Qdq4geNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwPrKuVf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwPrKuVf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773224407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6mRyVx+YrC5DSUDlXY1ArM5PElu2qfP9n48BX5eF4Y=;
	b=hwPrKuVfmC+4snj6e3xP26UkgdrF0US2qWLHjya4cagcSR8NGSmK9PR9bEU/Go9oZhTjHI
	nee9jRzBeOBSVl9AFR8qEHkZW1wKfHdS0mGvy7/chIE7pMZpA4m6AMca+6kPFr5uZP4N5D
	Bv/mdj7MnevyuqZVGdsbJo9R6S1CRpY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-0eINqGAPO9KDw5QOsvdZ4A-1; Wed, 11 Mar 2026 06:20:06 -0400
X-MC-Unique: 0eINqGAPO9KDw5QOsvdZ4A-1
X-Mimecast-MFC-AGG-ID: 0eINqGAPO9KDw5QOsvdZ4A_1773224406
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-79878791ec6so236650967b3.3
        for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 03:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773224406; x=1773829206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K6mRyVx+YrC5DSUDlXY1ArM5PElu2qfP9n48BX5eF4Y=;
        b=k9bD6VYcCV5KOFZlmCGvORKJTTlbiEfTa4FEuiPes3Tvoy03EXKAOQpsUxs8Fy3uRu
         ryDqnDdBuLiVhutCmlUbhuPAvw3d/wKCQ1t1Y5vf3AA1ex1jUGJdZHlaGUaz6/1Cuu9K
         Zg4B3NOOJzrIKFKxq/N8nwB8SxrgSWMxRxyf5HbRqa1iJd6rUkgg3eyr+XvsfIFoP5lQ
         L8i634P3awHOWpoAtPbXYIc4oalCuSzYT/P79luR/nuVpWUlIBSdgmuSWUAeMhoGTWgn
         D3OqAFM5kI9CaHmSz/LNF0F/oZyNG2qC3A7e63leshAQwKKDd2f4azF3nbTpPomdsPah
         klmw==
X-Forwarded-Encrypted: i=1; AJvYcCXScCUZ/DWM237ewH+49ICEyVvIgfFjnLO0Z3rgEs/3NKFecz+iuABhzckvgq5NPWhIvMKA6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGNfFgq4UjYwGyl2EuWBAdyD0xpKkBQKO4Ar6qt5YwNMZH5m0F
	kG9sy0cTifwXGde+Rd0elz0EP3KIfgUFxyHwmY/1i3vVcbdH+8kqebGh462yDZfY6LWYYiug8EC
	7qX/cHuR1YUs3DM2iVVzn3t9qrzsKT/P5YQC6sgt8eA8BzhH4nqdItwj8yq2wRdrgYt1tJz3HAM
	0VYynZBw6oXpW3o/c+qB5gPvU4mdthKK8=
X-Gm-Gg: ATEYQzzQ4sAzh2XgYfzg1c9wDnlc5tv3c808HWlfot5rewGs80EhFcxmFnAXGWTsFrN
	LDmDEjL29OzMZYtFULoOphLoOT9eli6t+e1QtDMbR4qiE7gmDzbiC7XKE0r4QmKf67i2bZ5/gT3
	mSAkPVvgl6kb62JDH/Csrv1SDgi1wRKBDRRa4xF5fRa23bAWFp0SZ5kfW3SGloGnX6gHUHRqY3y
	A==
X-Received: by 2002:a05:690c:6c8d:b0:799:8e0:650d with SMTP id 00721157ae682-79917e8c718mr16762867b3.13.1773224405822;
        Wed, 11 Mar 2026 03:20:05 -0700 (PDT)
X-Received: by 2002:a05:690c:6c8d:b0:799:8e0:650d with SMTP id
 00721157ae682-79917e8c718mr16762427b3.13.1773224405335; Wed, 11 Mar 2026
 03:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260306-b4-dmabuf-heap-coherent-rmem-v3-0-3d00d36c9bc4@redhat.com>
 <20260306-b4-dmabuf-heap-coherent-rmem-v3-5-3d00d36c9bc4@redhat.com> <e8dd476f-1be8-46fa-bf56-65fe0bfe29a1@ti.com>
In-Reply-To: <e8dd476f-1be8-46fa-bf56-65fe0bfe29a1@ti.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 11 Mar 2026 11:19:54 +0100
X-Gm-Features: AaiRm503QUCz_UeNOHpuj6MY_LCrw1Fms09a66SZO_xC8DXmSb42NEleXoyrRCY
Message-ID: <CADSE00+-SQr3wGdgBmLowHPWE5bGxoyO4o20jZs4ma-71aOxUA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] dma-buf: heaps: Add Coherent heap to dmabuf heaps
To: Andrew Davis <afd@ti.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, mripard@redhat.com, echanude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qEiPon-x64aR7eFZRMjihDGsBuduhCpr5W5PVCmGlrQ_1773224406
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 4:34=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
>
> On 3/6/26 4:36 AM, Albert Esteve wrote:
> > Expose DT coherent reserved-memory pools ("shared-dma-pool"
> > without "reusable") as dma-buf heaps, creating one heap per
> > region so userspace can allocate from the exact device-local
> > pool intended for coherent DMA.
> >
> > This is a missing backend in the long-term effort to steer
> > userspace buffer allocations (DRM, v4l2, dma-buf heaps)
> > through heaps for clearer cgroup accounting. CMA and system
> > heaps already exist; non-reusable coherent reserved memory
> > did not.
> >
> > The heap binds the heap device to each memory region so
> > coherent allocations use the correct dev->dma_mem, and
> > it defers registration until module_init when normal
> > allocators are available.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >   drivers/dma-buf/heaps/Kconfig         |   9 +
> >   drivers/dma-buf/heaps/Makefile        |   1 +
> >   drivers/dma-buf/heaps/coherent_heap.c | 414 +++++++++++++++++++++++++=
+++++++++
> >   3 files changed, 424 insertions(+)
> >
> > diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kcon=
fig
> > index a5eef06c42264..aeb475e585048 100644
> > --- a/drivers/dma-buf/heaps/Kconfig
> > +++ b/drivers/dma-buf/heaps/Kconfig
> > @@ -12,3 +12,12 @@ config DMABUF_HEAPS_CMA
> >         Choose this option to enable dma-buf CMA heap. This heap is bac=
ked
> >         by the Contiguous Memory Allocator (CMA). If your system has th=
ese
> >         regions, you should say Y here.
> > +
> > +config DMABUF_HEAPS_COHERENT
> > +     bool "DMA-BUF Coherent Reserved-Memory Heap"
> > +     depends on DMABUF_HEAPS && OF_RESERVED_MEM && DMA_DECLARE_COHEREN=
T
> > +     help
> > +       Choose this option to enable coherent reserved-memory dma-buf h=
eaps.
> > +       This heap is backed by non-reusable DT "shared-dma-pool" region=
s.
> > +       If your system defines coherent reserved-memory regions, you sh=
ould
> > +       say Y here.
> > diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Mak=
efile
> > index 974467791032f..96bda7a65f041 100644
> > --- a/drivers/dma-buf/heaps/Makefile
> > +++ b/drivers/dma-buf/heaps/Makefile
> > @@ -1,3 +1,4 @@
> >   # SPDX-License-Identifier: GPL-2.0
> >   obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)   +=3D system_heap.o
> >   obj-$(CONFIG_DMABUF_HEAPS_CMA)              +=3D cma_heap.o
> > +obj-$(CONFIG_DMABUF_HEAPS_COHERENT)  +=3D coherent_heap.o
> > diff --git a/drivers/dma-buf/heaps/coherent_heap.c b/drivers/dma-buf/he=
aps/coherent_heap.c
> > new file mode 100644
> > index 0000000000000..55f53f87c4c15
> > --- /dev/null
> > +++ b/drivers/dma-buf/heaps/coherent_heap.c
> > @@ -0,0 +1,414 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * DMABUF heap for coherent reserved-memory regions
> > + *
> > + * Copyright (C) 2026 Red Hat, Inc.
> > + * Author: Albert Esteve <aesteve@redhat.com>
> > + *
> > + */
> > +
> > +#include <linux/dma-buf.h>
> > +#include <linux/dma-heap.h>
> > +#include <linux/dma-map-ops.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/err.h>
> > +#include <linux/highmem.h>
> > +#include <linux/iosys-map.h>
> > +#include <linux/of_reserved_mem.h>
> > +#include <linux/scatterlist.h>
> > +#include <linux/slab.h>
> > +#include <linux/vmalloc.h>
> > +
> > +struct coherent_heap {
> > +     struct dma_heap *heap;
> > +     struct reserved_mem *rmem;
> > +     char *name;
> > +};
> > +
> > +struct coherent_heap_buffer {
> > +     struct coherent_heap *heap;
> > +     struct list_head attachments;
> > +     struct mutex lock;
> > +     unsigned long len;
> > +     dma_addr_t dma_addr;
> > +     void *alloc_vaddr;
> > +     struct page **pages;
> > +     pgoff_t pagecount;
> > +     int vmap_cnt;
> > +     void *vaddr;
> > +};
> > +
> > +struct dma_heap_attachment {
> > +     struct device *dev;
> > +     struct sg_table table;
> > +     struct list_head list;
> > +     bool mapped;
> > +};
> > +
> > +static int coherent_heap_attach(struct dma_buf *dmabuf,
> > +                             struct dma_buf_attachment *attachment)
> > +{
> > +     struct coherent_heap_buffer *buffer =3D dmabuf->priv;
> > +     struct dma_heap_attachment *a;
> > +     int ret;
> > +
> > +     a =3D kzalloc_obj(*a);
> > +     if (!a)
> > +             return -ENOMEM;
> > +
> > +     ret =3D sg_alloc_table_from_pages(&a->table, buffer->pages,
> > +                                     buffer->pagecount, 0,
> > +                                     buffer->pagecount << PAGE_SHIFT,
> > +                                     GFP_KERNEL);
> > +     if (ret) {
> > +             kfree(a);
> > +             return ret;
> > +     }
> > +
> > +     a->dev =3D attachment->dev;
> > +     INIT_LIST_HEAD(&a->list);
> > +     a->mapped =3D false;
> > +
> > +     attachment->priv =3D a;
> > +
> > +     mutex_lock(&buffer->lock);
> > +     list_add(&a->list, &buffer->attachments);
> > +     mutex_unlock(&buffer->lock);
> > +
> > +     return 0;
> > +}
> > +
> > +static void coherent_heap_detach(struct dma_buf *dmabuf,
> > +                              struct dma_buf_attachment *attachment)
> > +{
> > +     struct coherent_heap_buffer *buffer =3D dmabuf->priv;
> > +     struct dma_heap_attachment *a =3D attachment->priv;
> > +
> > +     mutex_lock(&buffer->lock);
> > +     list_del(&a->list);
> > +     mutex_unlock(&buffer->lock);
> > +
> > +     sg_free_table(&a->table);
> > +     kfree(a);
> > +}
> > +
> > +static struct sg_table *coherent_heap_map_dma_buf(struct dma_buf_attac=
hment *attachment,
> > +                                               enum dma_data_direction=
 direction)
> > +{
> > +     struct dma_heap_attachment *a =3D attachment->priv;
> > +     struct sg_table *table =3D &a->table;
> > +     int ret;
> > +
> > +     ret =3D dma_map_sgtable(attachment->dev, table, direction, 0);
> > +     if (ret)
> > +             return ERR_PTR(-ENOMEM);
> > +     a->mapped =3D true;
> > +
> > +     return table;
> > +}
> > +
> > +static void coherent_heap_unmap_dma_buf(struct dma_buf_attachment *att=
achment,
> > +                                     struct sg_table *table,
> > +                                     enum dma_data_direction direction=
)
> > +{
> > +     struct dma_heap_attachment *a =3D attachment->priv;
> > +
> > +     a->mapped =3D false;
> > +     dma_unmap_sgtable(attachment->dev, table, direction, 0);
> > +}
> > +
> > +static int coherent_heap_dma_buf_begin_cpu_access(struct dma_buf *dmab=
uf,
> > +                                               enum dma_data_direction=
 direction)
> > +{
> > +     struct coherent_heap_buffer *buffer =3D dmabuf->priv;
> > +     struct dma_heap_attachment *a;
> > +
> > +     mutex_lock(&buffer->lock);
> > +     if (buffer->vmap_cnt)
> > +             invalidate_kernel_vmap_range(buffer->vaddr, buffer->len);
> > +
> > +     list_for_each_entry(a, &buffer->attachments, list) {
> > +             if (!a->mapped)
> > +                     continue;
> > +             dma_sync_sgtable_for_cpu(a->dev, &a->table, direction);
> > +     }
> > +     mutex_unlock(&buffer->lock);
> > +
> > +     return 0;
> > +}
> > +
> > +static int coherent_heap_dma_buf_end_cpu_access(struct dma_buf *dmabuf=
,
> > +                                             enum dma_data_direction d=
irection)
> > +{
> > +     struct coherent_heap_buffer *buffer =3D dmabuf->priv;
> > +     struct dma_heap_attachment *a;
> > +
> > +     mutex_lock(&buffer->lock);
> > +     if (buffer->vmap_cnt)
> > +             flush_kernel_vmap_range(buffer->vaddr, buffer->len);
> > +
> > +     list_for_each_entry(a, &buffer->attachments, list) {
> > +             if (!a->mapped)
> > +                     continue;
> > +             dma_sync_sgtable_for_device(a->dev, &a->table, direction)=
;
> > +     }
> > +     mutex_unlock(&buffer->lock);
> > +
> > +     return 0;
> > +}
> > +
> > +static int coherent_heap_mmap(struct dma_buf *dmabuf, struct vm_area_s=
truct *vma)
> > +{
> > +     struct coherent_heap_buffer *buffer =3D dmabuf->priv;
> > +     struct coherent_heap *coh_heap =3D buffer->heap;
> > +     struct device *heap_dev =3D dma_heap_get_dev(coh_heap->heap);
> > +
> > +     return dma_mmap_coherent(heap_dev, vma, buffer->alloc_vaddr,
> > +                              buffer->dma_addr, buffer->len);
> > +}
> > +
> > +static void *coherent_heap_do_vmap(struct coherent_heap_buffer *buffer=
)
> > +{
> > +     void *vaddr;
> > +
> > +     vaddr =3D vmap(buffer->pages, buffer->pagecount, VM_MAP, PAGE_KER=
NEL);
> > +     if (!vaddr)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     return vaddr;
> > +}
> > +
> > +static int coherent_heap_vmap(struct dma_buf *dmabuf, struct iosys_map=
 *map)
> > +{
> > +     struct coherent_heap_buffer *buffer =3D dmabuf->priv;
> > +     void *vaddr;
> > +     int ret =3D 0;
> > +
> > +     mutex_lock(&buffer->lock);
> > +     if (buffer->vmap_cnt) {
> > +             buffer->vmap_cnt++;
> > +             iosys_map_set_vaddr(map, buffer->vaddr);
> > +             goto out;
> > +     }
> > +
> > +     vaddr =3D coherent_heap_do_vmap(buffer);
> > +     if (IS_ERR(vaddr)) {
> > +             ret =3D PTR_ERR(vaddr);
> > +             goto out;
> > +     }
> > +
> > +     buffer->vaddr =3D vaddr;
> > +     buffer->vmap_cnt++;
> > +     iosys_map_set_vaddr(map, buffer->vaddr);
> > +out:
> > +     mutex_unlock(&buffer->lock);
> > +
> > +     return ret;
> > +}
> > +
> > +static void coherent_heap_vunmap(struct dma_buf *dmabuf, struct iosys_=
map *map)
> > +{
> > +     struct coherent_heap_buffer *buffer =3D dmabuf->priv;
> > +
> > +     mutex_lock(&buffer->lock);
> > +     if (!--buffer->vmap_cnt) {
> > +             vunmap(buffer->vaddr);
> > +             buffer->vaddr =3D NULL;
> > +     }
> > +     mutex_unlock(&buffer->lock);
> > +     iosys_map_clear(map);
> > +}
> > +
> > +static void coherent_heap_dma_buf_release(struct dma_buf *dmabuf)
> > +{
> > +     struct coherent_heap_buffer *buffer =3D dmabuf->priv;
> > +     struct coherent_heap *coh_heap =3D buffer->heap;
> > +     struct device *heap_dev =3D dma_heap_get_dev(coh_heap->heap);
> > +
> > +     if (buffer->vmap_cnt > 0) {
> > +             WARN(1, "%s: buffer still mapped in the kernel\n", __func=
__);
> > +             vunmap(buffer->vaddr);
> > +             buffer->vaddr =3D NULL;
> > +             buffer->vmap_cnt =3D 0;
> > +     }
> > +
> > +     if (buffer->alloc_vaddr)
> > +             dma_free_coherent(heap_dev, buffer->len, buffer->alloc_va=
ddr,
> > +                               buffer->dma_addr);
> > +     kfree(buffer->pages);
> > +     kfree(buffer);
> > +}
> > +
> > +static const struct dma_buf_ops coherent_heap_buf_ops =3D {
> > +     .attach =3D coherent_heap_attach,
> > +     .detach =3D coherent_heap_detach,
> > +     .map_dma_buf =3D coherent_heap_map_dma_buf,
> > +     .unmap_dma_buf =3D coherent_heap_unmap_dma_buf,
> > +     .begin_cpu_access =3D coherent_heap_dma_buf_begin_cpu_access,
> > +     .end_cpu_access =3D coherent_heap_dma_buf_end_cpu_access,
> > +     .mmap =3D coherent_heap_mmap,
> > +     .vmap =3D coherent_heap_vmap,
> > +     .vunmap =3D coherent_heap_vunmap,
> > +     .release =3D coherent_heap_dma_buf_release,
> > +};
> > +
> > +static struct dma_buf *coherent_heap_allocate(struct dma_heap *heap,
> > +                                           unsigned long len,
> > +                                           u32 fd_flags,
> > +                                           u64 heap_flags)
> > +{
> > +     struct coherent_heap *coh_heap;
> > +     struct coherent_heap_buffer *buffer;
> > +     struct device *heap_dev;
> > +     DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> > +     size_t size =3D PAGE_ALIGN(len);
> > +     pgoff_t pagecount =3D size >> PAGE_SHIFT;
> > +     struct dma_buf *dmabuf;
> > +     int ret =3D -ENOMEM;
> > +     pgoff_t pg;
> > +
> > +     coh_heap =3D dma_heap_get_drvdata(heap);
> > +     if (!coh_heap)
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     heap_dev =3D dma_heap_get_dev(coh_heap->heap);
> > +     if (!heap_dev)
> > +             return ERR_PTR(-ENODEV);
> > +
> > +     buffer =3D kzalloc_obj(*buffer);
> > +     if (!buffer)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     INIT_LIST_HEAD(&buffer->attachments);
> > +     mutex_init(&buffer->lock);
> > +     buffer->len =3D size;
> > +     buffer->heap =3D coh_heap;
> > +     buffer->pagecount =3D pagecount;
> > +
> > +     buffer->alloc_vaddr =3D dma_alloc_coherent(heap_dev, buffer->len,
> > +                                              &buffer->dma_addr, GFP_K=
ERNEL);
>
> You are doing this DMA allocation using a non-DMA pseudo-device (heap_dev=
).
> This is why you need to do that dma_coerce_mask_and_coherent(64) nonsense=
, you
> are doing a DMA alloc for the CPU itself. This might still work, but only=
 if
> dma_map_sgtable() can handle swiotlb/iommu for all attaching devices at m=
ap
> time.

The concern is valid. We're allocating via a synthetic device, which
ties the allocation to that device's DMA domain. I looked deeper into
this trying to address the concern.

The approach works because dma_map_sgtable() handles both
dma_map_direct and use_dma_iommu cases in __dma_map_sg_attrs(). For
each physical address in the sg_table (extracted via sg_phys()), it
creates device-specific DMA mappings:
- For direct mapping: it checks if the address is directly accessible
(dma_capable()), and if not, it falls back to swiotlb.
- For IOMMU: it creates mappings that allow the device to access
physical addresses.

This means every attached device gets its own device-specific DMA
mapping, properly handling cases where the physical addresses are
inaccessible or have DMA constraints.

I'm not sure whether other approaches (whatever they may be) would be
better, as here we are leveraging a great part of the existing
infrastructure.

>
> > +     if (!buffer->alloc_vaddr) {
> > +             ret =3D -ENOMEM;
> > +             goto free_buffer;
> > +     }
> > +
> > +     buffer->pages =3D kmalloc_array(pagecount, sizeof(*buffer->pages)=
,
> > +                                   GFP_KERNEL);
> > +     if (!buffer->pages) {
> > +             ret =3D -ENOMEM;
> > +             goto free_dma;
> > +     }
> > +
> > +     for (pg =3D 0; pg < pagecount; pg++)
> > +             buffer->pages[pg] =3D virt_to_page((char *)buffer->alloc_=
vaddr +
> > +                                              (pg * PAGE_SIZE));
> > +
>
> Is any of this valid if the coherent pool in DT was marked "no-map;"?
> I'm sure the .mmap and .cpu_access function are not valid in that case.
> Our (TI) evil vendor tree version of this heap sets a flag in that case a=
nd
> avoids doing anything invalid when the region doesn't have normal backing
> page structs. This region is treated more like a P2PDMA area in that case=
.
>
> https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/drivers/dma-=
buf/heaps/carveout-heap.c?h=3Dti-linux-6.18.y#n372

I completely missed the "no-map" case. Thanks for the review and the
link! I will address this in the next version, using a logic similar
to the one from the linked driver.

BR,
Albert.

>
> Andrew
>
> > +     /* create the dmabuf */
> > +     exp_info.exp_name =3D dma_heap_get_name(heap);
> > +     exp_info.ops =3D &coherent_heap_buf_ops;
> > +     exp_info.size =3D buffer->len;
> > +     exp_info.flags =3D fd_flags;
> > +     exp_info.priv =3D buffer;
> > +     dmabuf =3D dma_buf_export(&exp_info);
> > +     if (IS_ERR(dmabuf)) {
> > +             ret =3D PTR_ERR(dmabuf);
> > +             goto free_pages;
> > +     }
> > +     return dmabuf;
> > +
> > +free_pages:
> > +     kfree(buffer->pages);
> > +free_dma:
> > +     dma_free_coherent(heap_dev, buffer->len, buffer->alloc_vaddr,
> > +                       buffer->dma_addr);
> > +free_buffer:
> > +     kfree(buffer);
> > +     return ERR_PTR(ret);
> > +}
> > +
> > +static const struct dma_heap_ops coherent_heap_ops =3D {
> > +     .allocate =3D coherent_heap_allocate,
> > +};
> > +
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
> > +     ret =3D dma_coerce_mask_and_coherent(heap_dev, DMA_BIT_MASK(64));
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
> > +
> > +     return 0;
> > +
> > +destroy_heap:
> > +     dma_heap_destroy(coh_heap->heap);
> > +     coh_heap->heap =3D NULL;
> > +free_name:
> > +     kfree(coh_heap->name);
> > +free_coherent_heap:
> > +     kfree(coh_heap);
> > +
> > +     return ret;
> > +}
> > +
> > +static int __init coherent_heap_register(void)
> > +{
> > +     struct reserved_mem *rmem;
> > +     unsigned int i;
> > +     int ret;
> > +
> > +     for (i =3D 0; (rmem =3D dma_coherent_get_reserved_region(i)) !=3D=
 NULL; i++) {
> > +             ret =3D __coherent_heap_register(rmem);
> > +             if (ret) {
> > +                     pr_warn("Failed to add coherent heap %s",
> > +                             rmem->name ? rmem->name : "unknown");
> > +                     continue;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +module_init(coherent_heap_register);
> > +MODULE_DESCRIPTION("DMA-BUF heap for coherent reserved-memory regions"=
);
> >
>

