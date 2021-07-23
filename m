Return-Path: <SRS0=yZZ9=MP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1D5C432BE
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 21:42:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FCBA60EB6
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 21:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FCBA60EB6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D35C83B51;
	Fri, 23 Jul 2021 21:42:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5tGDbogpcAJK; Fri, 23 Jul 2021 21:42:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EBBE183AE9;
	Fri, 23 Jul 2021 21:42:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4AACC0010;
	Fri, 23 Jul 2021 21:42:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1FF6C000E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 21:42:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3A4360715
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 21:42:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=atishpatra.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TmyaIEloRYQw for <iommu@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 21:42:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AAEEB606FD
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 21:42:01 +0000 (UTC)
Received: by mail-yb1-xb2f.google.com with SMTP id l145so4421832ybf.7
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 14:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atishpatra.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z4wRlXm54e3C3fuLfTWWm+AhBVsv03apMT1xPphwuac=;
 b=dB+dx1fxF4JegMhLECUyoU5542K4bedOLBloAj9atRP2r5OkvIja8syfi3HPvdd/g2
 qEbjfmLxW1YZ9GCendFo8POwz8rNKhQnjLbWNBt7Vo1FMgA16fFeVFumICSZ/kIjrPRg
 4m0PJyvKwTmK0lfdRFJDGf4snvmoLoCd+PGQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z4wRlXm54e3C3fuLfTWWm+AhBVsv03apMT1xPphwuac=;
 b=CHyZm0G3JsvFKvTUXZOqGsuXXSH8TccACf58ZchbJqy9awnOvWzHGfnPtFcnLOSECl
 XcE1KPcg/fkn2RtlLsD225dcmAAZoNfprNfHY966uarxVySw5dSAIB/094/V2T7Nl+Ut
 uM54K+wkciY/XJ1/xbjQc0yTd2/S+k6WaOA22fHCPPajXqfxs+y6zpnY6QBcbE8IgUY2
 c91/nl3cn5+cyINmgn3zJZhv8FwADTDXf0FZHOMNCKzfpx0AHbcvN/kFAkkgCFN0OGMP
 kF4FcgyOK6k2NBn+pcOq0uYmJIbxPViu1oyYozXzO3BmcabHK0LypIJZfRY4ekgdZQzo
 SuSQ==
X-Gm-Message-State: AOAM533K/XBswEFWWGXofGR9P9crZdGBvwsoCKtvAQojKswYHYJkg7rz
 SRaf0DGHdj74sQY3jk4zi0QOngVoU0D7FL8qS/bu
X-Google-Smtp-Source: ABdhPJyxNk4dBKh+nVb0yY5onNvD2+GMd5ddJFERs4q+Noxze2O0nDCTkCDvf/IfUkf03HDgO2GXZQt2BunJYA4hhxs=
X-Received: by 2002:a25:d015:: with SMTP id h21mr8642248ybg.202.1627076520639; 
 Fri, 23 Jul 2021 14:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210712061704.4162464-1-hch@lst.de>
 <20210712061704.4162464-7-hch@lst.de>
In-Reply-To: <20210712061704.4162464-7-hch@lst.de>
From: Atish Patra <atishp@atishpatra.org>
Date: Fri, 23 Jul 2021 14:41:50 -0700
Message-ID: <CAOnJCUJyBCwCzCAjpO2Kn4+eNx+FAGbbxotW4UqEnFVJN69GXQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] dma-mapping: make the global coherent pool conditional
To: Christoph Hellwig <hch@lst.de>
Cc: Vladimir Murzin <vladimir.murzin@arm.com>,
 Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Dillon Min <dillon.minfei@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Sun, Jul 11, 2021 at 11:25 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Only build the code to support the global coherent pool if support for
> it is enabled.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Dillon Min <dillon.minfei@gmail.com>
> ---
>  include/linux/dma-map-ops.h | 18 +++++++-------
>  kernel/dma/coherent.c       | 47 ++++++++++++++++++++-----------------
>  2 files changed, 35 insertions(+), 30 deletions(-)
>
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 7e49bb86a0c0..9b79aa4dd300 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -170,13 +170,6 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
>  int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
>  int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
>                 void *cpu_addr, size_t size, int *ret);
> -
> -void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
> -               dma_addr_t *dma_handle);
> -int dma_release_from_global_coherent(int order, void *vaddr);
> -int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
> -               size_t size, int *ret);
> -int dma_init_global_coherent(phys_addr_t phys_addr, size_t size);
>  #else
>  static inline int dma_declare_coherent_memory(struct device *dev,
>                 phys_addr_t phys_addr, dma_addr_t device_addr, size_t size)
> @@ -186,7 +179,16 @@ static inline int dma_declare_coherent_memory(struct device *dev,
>  #define dma_alloc_from_dev_coherent(dev, size, handle, ret) (0)
>  #define dma_release_from_dev_coherent(dev, order, vaddr) (0)
>  #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
> +#endif /* CONFIG_DMA_DECLARE_COHERENT */
>
> +#ifdef CONFIG_DMA_GLOBAL_POOL
> +void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
> +               dma_addr_t *dma_handle);
> +int dma_release_from_global_coherent(int order, void *vaddr);
> +int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
> +               size_t size, int *ret);
> +int dma_init_global_coherent(phys_addr_t phys_addr, size_t size);
> +#else
>  static inline void *dma_alloc_from_global_coherent(struct device *dev,
>                 ssize_t size, dma_addr_t *dma_handle)
>  {
> @@ -201,7 +203,7 @@ static inline int dma_mmap_from_global_coherent(struct vm_area_struct *vma,
>  {
>         return 0;
>  }
> -#endif /* CONFIG_DMA_DECLARE_COHERENT */
> +#endif /* CONFIG_DMA_GLOBAL_POOL */
>
>  /*
>   * This is the actual return value from the ->alloc_noncontiguous method.
> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> index 160d4e246ecb..c05408902a68 100644
> --- a/kernel/dma/coherent.c
> +++ b/kernel/dma/coherent.c
> @@ -20,8 +20,6 @@ struct dma_coherent_mem {
>         bool            use_dev_dma_pfn_offset;
>  };
>
> -static struct dma_coherent_mem *dma_coherent_default_memory __ro_after_init;
> -
>  static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *dev)
>  {
>         if (dev && dev->dma_mem)
> @@ -191,16 +189,6 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
>         return 1;
>  }
>
> -void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
> -                                    dma_addr_t *dma_handle)
> -{
> -       if (!dma_coherent_default_memory)
> -               return NULL;
> -
> -       return __dma_alloc_from_coherent(dev, dma_coherent_default_memory, size,
> -                                        dma_handle);
> -}
> -
>  static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
>                                        int order, void *vaddr)
>  {
> @@ -236,15 +224,6 @@ int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr)
>         return __dma_release_from_coherent(mem, order, vaddr);
>  }
>
> -int dma_release_from_global_coherent(int order, void *vaddr)
> -{
> -       if (!dma_coherent_default_memory)
> -               return 0;
> -
> -       return __dma_release_from_coherent(dma_coherent_default_memory, order,
> -                       vaddr);
> -}
> -
>  static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
>                 struct vm_area_struct *vma, void *vaddr, size_t size, int *ret)
>  {
> @@ -290,6 +269,28 @@ int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
>         return __dma_mmap_from_coherent(mem, vma, vaddr, size, ret);
>  }
>
> +#ifdef CONFIG_DMA_GLOBAL_POOL
> +static struct dma_coherent_mem *dma_coherent_default_memory __ro_after_init;
> +
> +void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
> +                                    dma_addr_t *dma_handle)
> +{
> +       if (!dma_coherent_default_memory)
> +               return NULL;
> +
> +       return __dma_alloc_from_coherent(dev, dma_coherent_default_memory, size,
> +                                        dma_handle);
> +}
> +
> +int dma_release_from_global_coherent(int order, void *vaddr)
> +{
> +       if (!dma_coherent_default_memory)
> +               return 0;
> +
> +       return __dma_release_from_coherent(dma_coherent_default_memory, order,
> +                       vaddr);
> +}
> +
>  int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *vaddr,
>                                    size_t size, int *ret)
>  {
> @@ -311,6 +312,7 @@ int dma_init_global_coherent(phys_addr_t phys_addr, size_t size)
>         pr_info("DMA: default coherent area is set\n");
>         return 0;
>  }
> +#endif /* CONFIG_DMA_GLOBAL_POOL */
>
>  /*
>   * Support for reserved memory regions defined in device tree
> @@ -377,6 +379,7 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
>         return 0;
>  }
>
> +#ifdef CONFIG_DMA_GLOBAL_POOL
>  static int __init dma_init_reserved_memory(void)
>  {
>         if (!dma_reserved_default_memory)
> @@ -384,8 +387,8 @@ static int __init dma_init_reserved_memory(void)
>         return dma_init_global_coherent(dma_reserved_default_memory->base,
>                                         dma_reserved_default_memory->size);

dma_reserved_default_memory also needs to be moved inside
CONFIG_DMA_GLOBAL_POOL because
all the usages are already part of that config.


>  }
> -
>  core_initcall(dma_init_reserved_memory);
> +#endif /* CONFIG_DMA_GLOBAL_POOL */
>
>  RESERVEDMEM_OF_DECLARE(dma, "shared-dma-pool", rmem_dma_setup);
>  #endif
> --
> 2.30.2
>
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
