Return-Path: <SRS0=VUzA=NI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11853C4338F
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 03:24:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8342C60FA0
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 03:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8342C60FA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39A8D607BF;
	Tue, 17 Aug 2021 03:24:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YvSf3tyaS24h; Tue, 17 Aug 2021 03:24:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B0F1460798;
	Tue, 17 Aug 2021 03:24:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95178C001A;
	Tue, 17 Aug 2021 03:24:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4889C000E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 03:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A103D607BF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 03:24:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Q3bFeWm-eWE for <iommu@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 03:24:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1865F60798
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 03:24:37 +0000 (UTC)
Received: by mail-yb1-xb2e.google.com with SMTP id w17so36821731ybl.11
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 20:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atishpatra.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R7t78EbJ4SBQR4PW9PP+EHALfMTimXWJ4a8o/k9vg3E=;
 b=TvFFwtmlL3L2+ir/JLvkG9HSbp6wG0WN7eoWHjuvbqXI/776osypQlgOrDrJUXLFjL
 94vLmlXhpIhhPlKhhiwszEk5kK6XzKmgsMfM/A3jvpMEuqbVyeX3vxyGQeKdQZFR3yr3
 Ioj8WJTKLQsxO2rclDVfBKJYXSWlDN3Tu90wM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R7t78EbJ4SBQR4PW9PP+EHALfMTimXWJ4a8o/k9vg3E=;
 b=JDdFHyq8n5p3DlgCm5jMaxSoLK3uL5qbJQJUk/Apu9UHTWXzWf3c7fcmXd+GyTyV6i
 QgJJKzz3fTrnOMVatn3RTgCtr8QEwrvYpPp+qh9eLqo+WF/mt6d8HiuGpQC8k3iQiVrO
 UAWI966rpeACWG+HotaemUyFGrtKSGeej63bDc5kibz86sQWMO61hfsTSen4Fjvj8s8u
 Obx4GHWhAT5x57WjGG/Lx8zMnFtX/AaKG3yNMQN91bgo1NQfwtIRxb+kb/iYDxfmh9M5
 Y/kTgs6/VjwZ71JtHl6EL85IbxEUYLtCqezHcMOr7wLBAxFqLhWxNocLBbAkIZPVX6Qe
 3D/A==
X-Gm-Message-State: AOAM533lAMKlypZ0Z9QOVLldzMvlekPTVVyZKDHNW4x4QdQW90ZhHOsI
 CMYbrMb4/VxeWOkhQlQX7cgQceUUoJpNdNxZERhi
X-Google-Smtp-Source: ABdhPJzKYOIuc7NAVJ7T2p4GvCqFkDmXaCHT1oHt/jMQX6BHv/wp7fy0gQ89E1PH6Sc5hPjbcFazBGEGNlpJr4nUvig=
X-Received: by 2002:a25:3f85:: with SMTP id m127mr1773427yba.21.1629170676840; 
 Mon, 16 Aug 2021 20:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210723214031.3251801-1-atish.patra@wdc.com>
 <20210723214031.3251801-2-atish.patra@wdc.com>
 <CAJF2gTT+zS=ySrmQUzVe7hf56E2K7XoGjzMyeaH5oFPUNwFqZA@mail.gmail.com>
In-Reply-To: <CAJF2gTT+zS=ySrmQUzVe7hf56E2K7XoGjzMyeaH5oFPUNwFqZA@mail.gmail.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Mon, 16 Aug 2021 20:24:26 -0700
Message-ID: <CAOnJCU+Sebr-3zt-xy9F6hGb8qj30QsH_SQvEkrvWhw6sVmbcw@mail.gmail.com>
Subject: Re: [RFC 1/5] RISC-V: Implement arch_sync_dma* functions
To: Guo Ren <guoren@kernel.org>
Cc: linux-riscv <linux-riscv@lists.infradead.org>,
 devicetree <devicetree@vger.kernel.org>, Guo Ren <guoren@linux.alibaba.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Atish Patra <atish.patra@wdc.com>,
 iommu@lists.linux-foundation.org, Albert Ou <aou@eecs.berkeley.edu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Tobias Klauser <tklauser@distanz.ch>, Frank Rowand <frowand.list@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Aug 16, 2021 at 6:48 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Sat, Jul 24, 2021 at 5:40 AM Atish Patra <atish.patra@wdc.com> wrote:
> >
> > To facilitate streaming DMA APIs, this patch introduces a set of generic
> > cache operations related dma sync. Any platform can use the generic ops
> > to provide platform specific cache management operations. Once the
> > standard RISC-V CMO extension is available, it can be built on top of it.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/include/asm/dma-noncoherent.h | 19 +++++++
> >  arch/riscv/mm/Makefile                   |  1 +
> >  arch/riscv/mm/dma-noncoherent.c          | 66 ++++++++++++++++++++++++
> >  3 files changed, 86 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
> >  create mode 100644 arch/riscv/mm/dma-noncoherent.c
> >
> > diff --git a/arch/riscv/include/asm/dma-noncoherent.h b/arch/riscv/include/asm/dma-noncoherent.h
> > new file mode 100644
> > index 000000000000..5bdb03c9c427
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/dma-noncoherent.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) 2021 Western Digital Corporation or its affiliates.
> > + */
> > +
> > +#ifndef __ASM_RISCV_DMA_NON_COHERENT_H
> > +#define __ASM_RISCV_DMA_NON_COHERENT_H
> > +
> > +#ifdef CONFIG_RISCV_DMA_NONCOHERENT
> > +struct riscv_dma_cache_sync {
> > +       void (*cache_invalidate)(phys_addr_t paddr, size_t size);
> > +       void (*cache_clean)(phys_addr_t paddr, size_t size);
> > +       void (*cache_flush)(phys_addr_t paddr, size_t size);
> > +};
> I like the style like this than my previous patch which using
> sbi_call. The c906 has custom instructions that could be called in
> S-mode directly.
>

How are you going to include the custom instructions in the upstream kernel ?

> Hope the patch could be soon merged, after correct the
> DMA_FROM/TO_DEVICE/BIDIRECTIONAL and alternatives ops_set.
>
> > +
> > +void riscv_dma_cache_sync_set(struct riscv_dma_cache_sync *ops);
> > +#endif
> > +
> > +#endif
> > diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> > index 7ebaef10ea1b..959bef49098b 100644
> > --- a/arch/riscv/mm/Makefile
> > +++ b/arch/riscv/mm/Makefile
> > @@ -27,3 +27,4 @@ KASAN_SANITIZE_init.o := n
> >  endif
> >
> >  obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
> > +obj-$(CONFIG_RISCV_DMA_NONCOHERENT) += dma-noncoherent.o
> > diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> > new file mode 100644
> > index 000000000000..2f6e9627c4aa
> > --- /dev/null
> > +++ b/arch/riscv/mm/dma-noncoherent.c
> > @@ -0,0 +1,66 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * RISC-V specific functions to support DMA for non-coherent devices
> > + *
> > + * Copyright (c) 2021 Western Digital Corporation or its affiliates.
> > + */
> > +
> > +#include <linux/dma-direct.h>
> > +#include <linux/dma-map-ops.h>
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/libfdt.h>
> > +#include <linux/mm.h>
> > +#include <linux/of.h>
> > +#include <linux/of_fdt.h>
> > +#include <asm/dma-noncoherent.h>
> > +
> > +static struct riscv_dma_cache_sync *dma_cache_sync;
> > +unsigned long riscv_dma_uc_offset;
> > +
> > +static void __dma_sync(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> > +{
> > +       if ((dir == DMA_FROM_DEVICE) && (dma_cache_sync->cache_invalidate))
> > +               dma_cache_sync->cache_invalidate(paddr, size);
> > +       else if ((dir == DMA_TO_DEVICE) && (dma_cache_sync->cache_clean))
> > +               dma_cache_sync->cache_clean(paddr, size);
> > +       else if ((dir == DMA_BIDIRECTIONAL) && dma_cache_sync->cache_flush)
> > +               dma_cache_sync->cache_flush(paddr, size);
> > +}
> > +
> > +void arch_sync_dma_for_device(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> > +{
> > +       if (!dma_cache_sync)
> > +               return;
> > +
> > +       __dma_sync(paddr, size, dir);
> > +}
> > +
> > +void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> > +{
> > +       if (!dma_cache_sync)
> > +               return;
> > +
> > +       __dma_sync(paddr, size, dir);
> > +}
> > +
> > +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> > +               const struct iommu_ops *iommu, bool coherent)
> > +{
> > +       /* If a specific device is dma-coherent, set it here */
> > +       dev->dma_coherent = coherent;
> > +}
> > +
> > +void arch_dma_prep_coherent(struct page *page, size_t size)
> > +{
> > +       void *flush_addr = page_address(page);
> > +
> > +       memset(flush_addr, 0, size);
> > +       if (dma_cache_sync && dma_cache_sync->cache_flush)
> > +               dma_cache_sync->cache_flush(__pa(flush_addr), size);
> > +}
> > +
> > +void riscv_dma_cache_sync_set(struct riscv_dma_cache_sync *ops)
> > +{
> > +       dma_cache_sync = ops;
> > +}
> > --
> > 2.31.1
> >
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
Regards,
Atish
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
