Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD00134F48C
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772527136; cv=none; b=I8oQ5tu9cZtntbbgDkjXX8HCVAZmojYiS2vze1HzyxdjoGvJF3p3yfIdfuneAK2lDwuLEN+zjHik2BdOph1BJVQiD9KnQSocEldtIgSHSiFJ2W1rvhz6hlYru4ioz/AwaQFDP5FBSn4O/nBii+90yHn0tmJ1xqW9YUFM1T4F0eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772527136; c=relaxed/simple;
	bh=QDQnInAsL2Qfmw6FBVNREV/abj8/0FdHTJn7iIXG0qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIIfbJ8DVldovFYkHLuRXJkRD5itQiFV/K834nXX1l7RWJvgWh7lNGWqfkYHjLKUjCfMNuoe39kzr4Z2ygDjhGzJ7mu1kOdhOwfpM/yAha/Y8/5V5sAA25Sx8Vq651iJJKYEI68tnpAC28/L6nD6HHTgcrwdXTYcA12SI7qB0/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R16Bq374; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R16Bq374"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772527133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rd+HXuut1lETpru3dBBpsGK37Q80G0fWm9xDLYLkL1U=;
	b=R16Bq374S54q5wDM6Op7gAMOLqSSmOGRbvoHL5R1nSB6uth02um30JTNSls6kNaeMBTEFK
	G9KF4NG57l1YGtMcWoXipWbtKMItCGh+2mEROErIpJiBkkmvgWdliDAeOeXZHpEjKJSCsa
	mlzT7aCg6CYHsA3gb9YZtDpJL+0cqJY=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-aD_K1-YdNE-l2hkEJ68JjA-1; Tue, 03 Mar 2026 03:38:52 -0500
X-MC-Unique: aD_K1-YdNE-l2hkEJ68JjA-1
X-Mimecast-MFC-AGG-ID: aD_K1-YdNE-l2hkEJ68JjA_1772527132
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-64adb64a043so5966439d50.3
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 00:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772527132; x=1773131932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rd+HXuut1lETpru3dBBpsGK37Q80G0fWm9xDLYLkL1U=;
        b=FTCdf++UIYZKlAab/JFOq3ctPCSCBwnXM2ApjbKGF9k6Zs0k8iDihspSp7nil1kJIE
         feQXqNr2wYJ57aPUrzWmORC8z1qognSGwwDRHFYL338xEquhEJteaQ3NzXubsjzUX1fF
         fLgRSQyMcp4mrbf72Zm+o1DSI0MgUOOFKOVKQ8kqCFJJZYdnOG/3bLiqeoSZz5oG+Sf/
         B0YRtKemyJKUUi0bk9rMA2o6LF6wn0R59hdNWeNwO3pj9S6qGL24Z29raQUxPQ6tWEiR
         N928/bPcwT7vI8JaR/qh947c98UfYjM6LZR7jHaZvf83J3pUKE9QQK8YMuTfBbOA7rxJ
         jrGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvnwsVUTQtUSLuzFZzZ1WRQ8TNWlFOGyLNW9dYyx0RY3sM55m36Jo8dHfN3KG1+/FWbrq6sw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgBQvgrvlt0PT4otWTpndsIShATyoyLMUmOQ9s33WzfxdsQU/n
	BG5Wm8oz0Gh9d+MHPCHdgYG0OhlRKXPaS5j8bHd0WVcj0JGcT4+FvPP/Zf6RX+aPWhE4sCcjW9i
	MdZ4kEIYJsxPP99arDhva8oCeIxE9duREDrZ/DS7YU2RTfgrdUfTqmqd+plEBKHCctfSNds3G3z
	Xo7ho8wqaUzv5Snq6/DKgmasWKTNV4puU=
X-Gm-Gg: ATEYQzyVAZpoemmSzkqeyKHPA37+C9kY06G0wFAeRXiIXmK6ggeYRoFIUGIXX58V+2/
	rf87to9U28St6jghBo1AHGbNuYGVykTb4zfUdQw2zKk5Ly18gpRae9MFNSH0g9J/D16aEtUOlu9
	GmV/BEnIyBoh039hTWF4rdhHor+Am0ZDRUzMYcrpoFlmMfdsq+2fY+2PeIgzYKBR0Bc2XM4ezct
	A==
X-Received: by 2002:a53:ee60:0:b0:64c:9abc:27d5 with SMTP id 956f58d0204a3-64cc204847dmr10424752d50.2.1772527131943;
        Tue, 03 Mar 2026 00:38:51 -0800 (PST)
X-Received: by 2002:a53:ee60:0:b0:64c:9abc:27d5 with SMTP id
 956f58d0204a3-64cc204847dmr10424739d50.2.1772527131449; Tue, 03 Mar 2026
 00:38:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260224-b4-dmabuf-heap-coherent-rmem-v1-1-dffef43298ac@redhat.com>
 <20260226-smoky-fancy-dachshund-1a2f92@penduick> <CADSE00+PwA-ZC9F2_rryi9XZaz9gPWd2qUA5NSaLQUs78gmvvw@mail.gmail.com>
In-Reply-To: <CADSE00+PwA-ZC9F2_rryi9XZaz9gPWd2qUA5NSaLQUs78gmvvw@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 3 Mar 2026 09:38:40 +0100
X-Gm-Features: AaiRm53owRtuWIif-EW8znMUUIlsgF8fdMlhGZ-WMbFVsOOUM3G5V6Owv7M9krs
Message-ID: <CADSE00LUJJRHxXnRZ6_xi-oRPXaS-0-+Jtjeua2HW=JvLdW0=g@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: heaps: Add Coherent heap to dmabuf heaps
To: Maxime Ripard <mripard@redhat.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, echanude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fmytaOFqh3vqNUZwryQC__mJqYKs8_9WsBwJxKxbxhI_1772527132
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 1:49=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:
>
> Hi Maxime!
>
> On Thu, Feb 26, 2026 at 11:12=E2=80=AFAM Maxime Ripard <mripard@redhat.co=
m> wrote:
> >
> > Hi Albert,
> >
> > Thanks for your patch!
> >
> > On Tue, Feb 24, 2026 at 08:57:33AM +0100, Albert Esteve wrote:
> > > Add a dma-buf heap for DT coherent reserved-memory
> > > (i.e., 'shared-dma-pool' without 'reusable' property),
> > > exposing one heap per region for userspace buffers.
> > >
> > > The heap binds a synthetic platform device to each region
> > > so coherent allocations use the correct dev->dma_mem,
> > > and it defers registration until late_initcall when
> > > normal allocator are available.
> > >
> > > This patch includes charging of the coherent heap
> > > allocator to the dmem cgroup.
> > >
> > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > ---
> > > This patch introduces a new driver to expose DT coherent reserved-mem=
ory
> > > regions as dma-buf heaps, allowing userspace buffers to be created.
> > >
> > > Since these regions are device-dependent, we bind a synthetic platfor=
m
> > > device to each region so coherent allocations use the correct dev->dm=
a_mem.
> > >
> > > Following Eric=E2=80=99s [1] and Maxime=E2=80=99s [2] work on chargin=
g DMA buffers
> > > allocated from userspace to cgroups (dmem), this patch adds the same
> > > charging pattern used by CMA heaps patch. Charging is done only throu=
gh
> > > the dma-buf heap interface so it can be attributed to a userspace all=
ocator.
> > >
> > > This allows each device-specific reserved-memory region to enforce it=
s
> > > own limits.
> > >
> > > [1] https://lore.kernel.org/all/20260218-dmabuf-heap-cma-dmem-v2-0-b2=
49886fb7b2@redhat.com/
> > > [2] https://lore.kernel.org/all/20250310-dmem-cgroups-v1-0-2984c1bc93=
12@kernel.org/
> > > ---
> > >  drivers/dma-buf/heaps/Kconfig         |  17 ++
> > >  drivers/dma-buf/heaps/Makefile        |   1 +
> > >  drivers/dma-buf/heaps/coherent_heap.c | 485 ++++++++++++++++++++++++=
++++++++++
> > >  include/linux/dma-heap.h              |  11 +
> > >  kernel/dma/coherent.c                 |   9 +
> > >  5 files changed, 523 insertions(+)
> > >
> > > diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kc=
onfig
> > > index a5eef06c42264..93765dca164e3 100644
> > > --- a/drivers/dma-buf/heaps/Kconfig
> > > +++ b/drivers/dma-buf/heaps/Kconfig
> > > @@ -12,3 +12,20 @@ config DMABUF_HEAPS_CMA
> > >         Choose this option to enable dma-buf CMA heap. This heap is b=
acked
> > >         by the Contiguous Memory Allocator (CMA). If your system has =
these
> > >         regions, you should say Y here.
> > > +
> > > +config DMABUF_HEAPS_COHERENT
> > > +     bool "DMA-BUF Coherent Reserved-Memory Heap"
> > > +     depends on DMABUF_HEAPS && OF_RESERVED_MEM && DMA_DECLARE_COHER=
ENT
> > > +     help
> > > +       Choose this option to enable coherent reserved-memory dma-buf=
 heaps.
> > > +       This heap is backed by non-reusable DT "shared-dma-pool" regi=
ons.
> > > +       If your system defines coherent reserved-memory regions, you =
should
> > > +       say Y here.
> > > +
> > > +config COHERENT_AREAS_DEFERRED
> > > +     int "Max deferred coherent reserved-memory regions"
> > > +     depends on DMABUF_HEAPS_COHERENT
> > > +     default 16
> > > +     help
> > > +       Maximum number of coherent reserved-memory regions that can b=
e
> > > +       deferred for later registration during early boot.
> > > diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/M=
akefile
> > > index 974467791032f..96bda7a65f041 100644
> > > --- a/drivers/dma-buf/heaps/Makefile
> > > +++ b/drivers/dma-buf/heaps/Makefile
> > > @@ -1,3 +1,4 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)    +=3D system_heap.o
> > >  obj-$(CONFIG_DMABUF_HEAPS_CMA)               +=3D cma_heap.o
> > > +obj-$(CONFIG_DMABUF_HEAPS_COHERENT)  +=3D coherent_heap.o
> > > diff --git a/drivers/dma-buf/heaps/coherent_heap.c b/drivers/dma-buf/=
heaps/coherent_heap.c
> > > new file mode 100644
> > > index 0000000000000..870b2b89aefcb
> > > --- /dev/null
> > > +++ b/drivers/dma-buf/heaps/coherent_heap.c
> > > @@ -0,0 +1,485 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * DMABUF heap for coherent reserved-memory regions
> > > + *
> > > + * Copyright (C) 2026 Red Hat, Inc.
> > > + * Author: Albert Esteve <aesteve@redhat.com>
> > > + *
> > > + */
> > > +
> > > +#include <linux/cgroup_dmem.h>
> > > +#include <linux/dma-heap.h>
> > > +#include <linux/dma-buf.h>
> > > +#include <linux/dma-mapping.h>
> > > +#include <linux/err.h>
> > > +#include <linux/highmem.h>
> > > +#include <linux/iosys-map.h>
> > > +#include <linux/of_reserved_mem.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/scatterlist.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/vmalloc.h>
> > > +
> > > +#define DEFERRED_AREAS_MAX CONFIG_COHERENT_AREAS_DEFERRED
> >
> > I'm not sure we need to make it configurable. Distros are going to set
> > it to the user with the highest number of regions anyway. How about
> > using MAX_RESERVED_REGIONS for now?
>
> Makes sense, will do.
>
> >
> > >
> > > [...]
> > >
> > > +struct coherent_heap {
> > > +     struct dma_heap *heap;
> > > +     struct reserved_mem *rmem;
> > > +     char *name;
> > > +     struct device *dev;
> > > +     struct platform_device *pdev;
> > > +#if IS_ENABLED(CONFIG_CGROUP_DMEM)
> > > +     struct dmem_cgroup_region *cg;
> > > +#endif
> >
> > We might want to leave the dmem accounting out for now so we can focus
> > on the heap itself. That being said, it ended up being pretty trivial
> > for CMA, so maybe it's not too much of a concern.
>
> Sure. That allows us to follow the same patterns once the CMA series land=
s.
> I will strip all dmem accounting parts for v2.
>
> >
> > >
> > > [...]
> > >
> > > +static int __coherent_heap_register(struct reserved_mem *rmem)
> > > +{
> > > +     struct dma_heap_export_info exp_info;
> > > +     struct coherent_heap *coh_heap;
> > > +#if IS_ENABLED(CONFIG_CGROUP_DMEM)
> > > +     struct dmem_cgroup_region *region;
> > > +#endif
> > > +     const char *rmem_name;
> > > +     int ret;
> > > +
> > > +     if (!rmem)
> > > +             return -EINVAL;
> > > +
> > > +     rmem_name =3D rmem->name ? rmem->name : "unknown";
> >
> > If the reserved region has no name, we probably shouldn't expose it to
> > userspace at all. Using unknown will probably create some bugs if you
> > have several, but also it's pretty like to have a name at some point an=
d
> > thus we wouldn't have a stable name for the uAPI.
>
> Agreed. I will return an error code if no name is present.
>
> >
> > > +     coh_heap =3D kzalloc_obj(*coh_heap);
> > > +     if (!coh_heap)
> > > +             return -ENOMEM;
> > > +
> > > +     coh_heap->name =3D kasprintf(GFP_KERNEL, "coherent_%s", rmem_na=
me);
> > > +     if (!coh_heap->name) {
> > > +             ret =3D -ENOMEM;
> > > +             goto free_coherent_heap;
> > > +     }
> >
> > Similarly, we shouldn't use the coherent_ prefix for the heap name. If
> > the backing allocator ever changes (and between contiguous and coherent=
,
> > the difference is just a single property value in the DT), then the nam=
e
> > would change and userspace would break. We should directly use the name
> > of the region here.
> >
> > > +     coh_heap->rmem =3D rmem;
> > > +
> > > +     /* create a platform device per rmem and bind it */
> > > +     coh_heap->pdev =3D platform_device_register_simple("coherent-he=
ap",
> > > +                                                      PLATFORM_DEVID=
_AUTO,
> > > +                                                      NULL, 0);
> > > +     if (IS_ERR(coh_heap->pdev)) {
> > > +             ret =3D PTR_ERR(coh_heap->pdev);
> > > +             goto free_name;
> > > +     }
> >
> > We probably should use a faux_device here instead of a platform_device,
> > but more importantly, the heap itself already has a device allocated fo=
r
> > it (dev_ret in dma_heap_add).
> >
> > It's not in struct dma_heap yet, but there's a patch that moves it ther=
e
> > that we should probably carry:
> > https://lore.kernel.org/r/20210120210937.15069-2-john.stultz@linaro.org=
/
>
> Thanks for sharing the link! I will pick the patch.
>
> >
> > > +     if (rmem->ops && rmem->ops->device_init) {
> > > +             ret =3D rmem->ops->device_init(rmem, &coh_heap->pdev->d=
ev);
> > > +             if (ret)
> > > +                     goto pdev_unregister;
> > > +     }
> >
> > I'm not really a fan of calling ops directly. Maybe we should create an
> > of_reserved_mem_device_init_with_mem function that would do it for us
> > (and would be called by of_reserved_mem_device_init_by_idx and the
> > likes).
>
> Agreed.
>
> >
> > > +     coh_heap->dev =3D &coh_heap->pdev->dev;
> > > +#if IS_ENABLED(CONFIG_CGROUP_DMEM)
> > > +     region =3D dmem_cgroup_register_region(rmem->size, "coh/%s", rm=
em_name);
> > > +     if (IS_ERR(region)) {
> > > +             ret =3D PTR_ERR(region);
> > > +             goto pdev_unregister;
> > > +     }
> > > +     coh_heap->cg =3D region;
> > > +#endif
> >
> > Same comment than for CMA here: it should really be created by the
> > coherent memory region itself.
> >
> > > +     exp_info.name =3D coh_heap->name;
> > > +     exp_info.ops =3D &coherent_heap_ops;
> > > +     exp_info.priv =3D coh_heap;
> > > +
> > > +     coh_heap->heap =3D dma_heap_add(&exp_info);
> > > +     if (IS_ERR(coh_heap->heap)) {
> > > +             ret =3D PTR_ERR(coh_heap->heap);
> > > +             goto cg_unregister;
> > > +     }
> > > +
> > > +     return 0;
> > > +
> > > +cg_unregister:
> > > +#if IS_ENABLED(CONFIG_CGROUP_DMEM)
> > > +     dmem_cgroup_unregister_region(coh_heap->cg);
> > > +#endif
> > > +pdev_unregister:
> > > +     platform_device_unregister(coh_heap->pdev);
> > > +     coh_heap->pdev =3D NULL;
> > > +free_name:
> > > +     kfree(coh_heap->name);
> > > +free_coherent_heap:
> > > +     kfree(coh_heap);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +int dma_heap_coherent_register(struct reserved_mem *rmem)
> > > +{
> > > +     int ret;
> > > +
> > > +     ret =3D __coherent_heap_register(rmem);
> > > +     if (ret =3D=3D -ENOMEM)
> > > +             return coherent_heap_add_deferred(rmem);
> > > +     return ret;
> > > +}
> >
> > I appreciate you did it like we did for CMA, but if we ever want to mak=
e
> > that heap a module you'll end up with a dependency from the core kernel
> > on a module which doesn't work. The best here might be to wait a bit
> > until we have somewhat of an agreement on
> >
> > https://lore.kernel.org/r/20260225-dma-buf-heaps-as-modules-v1-0-210922=
5a090d@kernel.org
> >
> > > +static int __init coherent_heap_register_deferred(void)
> > > +{
> > > +     unsigned int i;
> > > +     int ret;
> > > +
> > > +     for (i =3D 0; i < rmem_areas_deferred_num; i++) {
> > > +             struct reserved_mem *rmem =3D rmem_areas_deferred[i];
> > > +
> > > +             ret =3D __coherent_heap_register(rmem);
> > > +             if (ret) {
> > > +                     pr_warn("Failed to add coherent heap %s",
> > > +                             rmem->name ? rmem->name : "unknown");
> > > +                     continue;
> > > +             }
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +late_initcall(coherent_heap_register_deferred);
> >
> > Why do you need a late_initcall here? Isn't module_init enough?
>
> When I tested this initially, I relied on direct invocations from
> cma/coherent.c to register new coherent heap areas. However it failed
> in `kzalloc_obj` calls within the register function. Then I read the
> article about boot time memory management[1] and saw other drivers
> collected info for deferred initialization at late_initcall(), similar
> to what I tried to do here. I honestly did not try with module_init().
> Since I will refactor this part to follow your previous comments, I
> will try to update if possible.
>
> [1] https://docs.kernel.org/core-api/boot-time-mm.html
>
> >
> > > +MODULE_DESCRIPTION("DMA-BUF heap for coherent reserved-memory region=
s");
> > > diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
> > > index 648328a64b27e..e894cfa1ecf1a 100644
> > > --- a/include/linux/dma-heap.h
> > > +++ b/include/linux/dma-heap.h
> > > @@ -9,9 +9,11 @@
> > >  #ifndef _DMA_HEAPS_H
> > >  #define _DMA_HEAPS_H
> > >
> > > +#include <linux/errno.h>
> > >  #include <linux/types.h>
> > >
> > >  struct dma_heap;
> > > +struct reserved_mem;
> > >
> > >  /**
> > >   * struct dma_heap_ops - ops to operate on a given heap
> > > @@ -48,4 +50,13 @@ struct dma_heap *dma_heap_add(const struct dma_hea=
p_export_info *exp_info);
> > >
> > >  extern bool mem_accounting;
> > >
> > > +#if IS_ENABLED(CONFIG_DMABUF_HEAPS_COHERENT)
> > > +int dma_heap_coherent_register(struct reserved_mem *rmem);
> > > +#else
> > > +static inline int dma_heap_coherent_register(struct reserved_mem *rm=
em)
> > > +{
> > > +     return -EOPNOTSUPP;
> > > +}
> > > +#endif
> > > +
> > >  #endif /* _DMA_HEAPS_H */
> > > diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> > > index 1147497bc512c..f49d13e460e4b 100644
> > > --- a/kernel/dma/coherent.c
> > > +++ b/kernel/dma/coherent.c
> > > @@ -9,6 +9,7 @@
> > >  #include <linux/module.h>
> > >  #include <linux/dma-direct.h>
> > >  #include <linux/dma-map-ops.h>
> > > +#include <linux/dma-heap.h>
> > >
> > >  struct dma_coherent_mem {
> > >       void            *virt_base;
> > > @@ -393,6 +394,14 @@ static int __init rmem_dma_setup(struct reserved=
_mem *rmem)
> > >       rmem->ops =3D &rmem_dma_ops;
> > >       pr_info("Reserved memory: created DMA memory pool at %pa, size =
%ld MiB\n",
> > >               &rmem->base, (unsigned long)rmem->size / SZ_1M);
> > > +
> > > +     if (IS_ENABLED(CONFIG_DMABUF_HEAPS_COHERENT)) {
> > > +             int ret =3D dma_heap_coherent_register(rmem);
> > > +
> > > +             if (ret)
> > > +                     pr_warn("Reserved memory: failed to register co=
herent heap for %s (%d)\n",
> > > +                             rmem->name ? rmem->name : "unknown", re=
t);
> > > +     }
> >
> > I think this should be split into a patch of its own. It's going to be
> > reviewed (and possibly merged) by another maintainer, through another
> > tree.
>
> That's fine. I will split it into another series then. I guess I can
> send it with a Based-On: tag or similar to link two series together?

Oof, never mind. I see now that the suggestion is to split into a
patch of its own, not a different series. I misread it last time.

That makes more sense now.

>
> BR,
> Albert
>
> >
> > Maxime

