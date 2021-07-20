Return-Path: <SRS0=9TsP=MM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6AFC07E95
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 03:36:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C6BC6113B
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 03:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6BC6113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 778F5402BA;
	Tue, 20 Jul 2021 03:36:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kOd6NMYoTgeX; Tue, 20 Jul 2021 03:36:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 19D59400E4;
	Tue, 20 Jul 2021 03:36:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAF8BC001A;
	Tue, 20 Jul 2021 03:36:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0625C000E
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 03:36:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BE4824035B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 03:36:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T0N-DL383SlC for <iommu@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 03:36:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A74DE40320
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 03:36:05 +0000 (UTC)
Received: by mail-il1-x12d.google.com with SMTP id w1so17945297ilg.10
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 20:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jfs1xv5cKWVRJ1qtbdS51k1USQ3B8wtm35pXmmoKryU=;
 b=LFeTgoRuKZnHD0GvA1dTYaAuabVcP5fN21a9fEHVx9PnauoUp1lue+RNhnBFBte+AR
 M8imBX5vwCVTIIpu3Snmd7ZWwJSJezCeJwCyYgvVO4q11y3dGW6DSqYaR0aqyaHWO0zl
 H2KKj6kOlThtwW3DoQDowJuUB9H2dQdi3eM3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jfs1xv5cKWVRJ1qtbdS51k1USQ3B8wtm35pXmmoKryU=;
 b=E6I+MOd78jd7/6b6IAmNoN3Y7fPwTIRe3wy8C3eaUwlmMRGlqyLKwih14mh4Z8cVF8
 1IkLLCDdx2cwfzZp+M8CqrkwEEs31qKftdXG+HVicHPml3PsmC/MkUD5j7s9ONMptTbB
 w1pxxQV92fb7k1smlaTWwnKusm5851FlXtJO2YuK3Or/mgqhz9sWsl1YQTDW4pl0+IvQ
 xkdNCQKDpb/7S7ZzzYaZFeYg5obeGulPT7yXzhTz+WcYC5zlJHRldEDaa2wbkea+xpUD
 9z56dIHgVJZRmfYvzg4OGWvDQ3L6EWP6IIHM5Cnh6ZUWBvfeEyUK92KhXmsyohQDbif+
 rCvA==
X-Gm-Message-State: AOAM531tCV6xqWi03B2SZwiDPRK0zexOwhl2E8hxcP59D4mgx1naLxQV
 f4PwJxxBXSdW2UjkTW2LkjQyWfK2Qc9mQg==
X-Google-Smtp-Source: ABdhPJx+g9zTIFH/Slqp/hRTKO7QtgpRoQbbPfksNCv59qaHS94HUDIiIHVbNp4Tdw6aDBw4dyBgOg==
X-Received: by 2002:a92:1906:: with SMTP id 6mr18994470ilz.273.1626752164213; 
 Mon, 19 Jul 2021 20:36:04 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com.
 [209.85.166.41])
 by smtp.gmail.com with ESMTPSA id q1sm12041131ioi.42.2021.07.19.20.36.03
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jul 2021 20:36:03 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id u7so22430476ion.3
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 20:36:03 -0700 (PDT)
X-Received: by 2002:a5d:97c6:: with SMTP id k6mr18707977ios.69.1626752163074; 
 Mon, 19 Jul 2021 20:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210719123054.6844-1-will@kernel.org>
 <20210719123054.6844-4-will@kernel.org>
In-Reply-To: <20210719123054.6844-4-will@kernel.org>
From: Claire Chang <tientzu@chromium.org>
Date: Tue, 20 Jul 2021 11:35:52 +0800
X-Gmail-Original-Message-ID: <CALiNf28WYFs9ayvWp4XsK8YFL_=sy7Djb5_Mpj-egYjfRh4BEw@mail.gmail.com>
Message-ID: <CALiNf28WYFs9ayvWp4XsK8YFL_=sy7Djb5_Mpj-egYjfRh4BEw@mail.gmail.com>
Subject: Re: [PATCH 3/5] swiotlb: Remove io_tlb_default_mem indirection
To: Will Deacon <will@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 lkml <linux-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>
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

On Mon, Jul 19, 2021 at 8:31 PM Will Deacon <will@kernel.org> wrote:
>
> The indirection from the global 'io_tlb_default_mem' pointer to the
> static '_io_tlb_default_mem' structure is ugly and unnecessary.
>
> Convert all users to reference the static structure directly, using the
> 'nslabs' field to determine whether swiotlb has been initialised.
>
> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Tested-by: Claire Chang <tientzu@chromium.org>

> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/base/core.c       |  2 +-
>  drivers/xen/swiotlb-xen.c |  4 ++--
>  include/linux/swiotlb.h   |  2 +-
>  kernel/dma/swiotlb.c      | 38 ++++++++++++++++++--------------------
>  4 files changed, 22 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index ea5b85354526..b49824001cfa 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2848,7 +2848,7 @@ void device_initialize(struct device *dev)
>         dev->dma_coherent = dma_default_coherent;
>  #endif
>  #ifdef CONFIG_SWIOTLB
> -       dev->dma_io_tlb_mem = io_tlb_default_mem;
> +       dev->dma_io_tlb_mem = &io_tlb_default_mem;
>  #endif
>  }
>  EXPORT_SYMBOL_GPL(device_initialize);
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 785ec7e8be01..f06d9b4f1e0f 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -164,7 +164,7 @@ int __ref xen_swiotlb_init(void)
>         int rc = -ENOMEM;
>         char *start;
>
> -       if (io_tlb_default_mem != NULL) {
> +       if (io_tlb_default_mem.nslabs) {
>                 pr_warn("swiotlb buffer already initialized\n");
>                 return -EEXIST;
>         }
> @@ -547,7 +547,7 @@ xen_swiotlb_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
>  static int
>  xen_swiotlb_dma_supported(struct device *hwdev, u64 mask)
>  {
> -       return xen_phys_to_dma(hwdev, io_tlb_default_mem->end - 1) <= mask;
> +       return xen_phys_to_dma(hwdev, io_tlb_default_mem.end - 1) <= mask;
>  }
>
>  const struct dma_map_ops xen_swiotlb_dma_ops = {
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index d3b617c19045..b0cb2a9973f4 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -105,7 +105,7 @@ struct io_tlb_mem {
>                 unsigned int list;
>         } *slots;
>  };
> -extern struct io_tlb_mem *io_tlb_default_mem;
> +extern struct io_tlb_mem io_tlb_default_mem;
>
>  static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
>  {
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 992d73cdc944..7948f274f9bb 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -70,8 +70,7 @@
>
>  enum swiotlb_force swiotlb_force;
>
> -struct io_tlb_mem *io_tlb_default_mem;
> -static struct io_tlb_mem _io_tlb_default_mem;
> +struct io_tlb_mem io_tlb_default_mem;
>
>  /*
>   * Max segment that we can provide which (if pages are contingous) will
> @@ -102,7 +101,7 @@ early_param("swiotlb", setup_io_tlb_npages);
>
>  unsigned int swiotlb_max_segment(void)
>  {
> -       return io_tlb_default_mem ? max_segment : 0;
> +       return io_tlb_default_mem.nslabs ? max_segment : 0;
>  }
>  EXPORT_SYMBOL_GPL(swiotlb_max_segment);
>
> @@ -135,9 +134,9 @@ void __init swiotlb_adjust_size(unsigned long size)
>
>  void swiotlb_print_info(void)
>  {
> -       struct io_tlb_mem *mem = io_tlb_default_mem;
> +       struct io_tlb_mem *mem = &io_tlb_default_mem;
>
> -       if (!mem) {
> +       if (!mem->nslabs) {
>                 pr_warn("No low mem\n");
>                 return;
>         }
> @@ -164,11 +163,11 @@ static inline unsigned long nr_slots(u64 val)
>   */
>  void __init swiotlb_update_mem_attributes(void)
>  {
> -       struct io_tlb_mem *mem = io_tlb_default_mem;
> +       struct io_tlb_mem *mem = &io_tlb_default_mem;
>         void *vaddr;
>         unsigned long bytes;
>
> -       if (!mem || mem->late_alloc)
> +       if (!mem->nslabs || mem->late_alloc)
>                 return;
>         vaddr = phys_to_virt(mem->start);
>         bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
> @@ -202,14 +201,14 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
>
>  int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  {
> -       struct io_tlb_mem *mem = &_io_tlb_default_mem;
> +       struct io_tlb_mem *mem = &io_tlb_default_mem;
>         size_t alloc_size;
>
>         if (swiotlb_force == SWIOTLB_NO_FORCE)
>                 return 0;
>
>         /* protect against double initialization */
> -       if (WARN_ON_ONCE(io_tlb_default_mem))
> +       if (WARN_ON_ONCE(mem->nslabs))
>                 return -ENOMEM;
>
>         alloc_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), nslabs));
> @@ -220,7 +219,6 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>
>         swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false);
>
> -       io_tlb_default_mem = mem;
>         if (verbose)
>                 swiotlb_print_info();
>         swiotlb_set_max_segment(mem->nslabs << IO_TLB_SHIFT);
> @@ -305,14 +303,14 @@ swiotlb_late_init_with_default_size(size_t default_size)
>  int
>  swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>  {
> -       struct io_tlb_mem *mem = &_io_tlb_default_mem;
> +       struct io_tlb_mem *mem = &io_tlb_default_mem;
>         unsigned long bytes = nslabs << IO_TLB_SHIFT;
>
>         if (swiotlb_force == SWIOTLB_NO_FORCE)
>                 return 0;
>
>         /* protect against double initialization */
> -       if (WARN_ON_ONCE(io_tlb_default_mem))
> +       if (WARN_ON_ONCE(mem->nslabs))
>                 return -ENOMEM;
>
>         mem->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> @@ -323,7 +321,6 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>         set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
>         swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), nslabs, true);
>
> -       io_tlb_default_mem = mem;
>         swiotlb_print_info();
>         swiotlb_set_max_segment(mem->nslabs << IO_TLB_SHIFT);
>         return 0;
> @@ -331,10 +328,10 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>
>  void __init swiotlb_exit(void)
>  {
> -       struct io_tlb_mem *mem = io_tlb_default_mem;
>         size_t size;
> +       struct io_tlb_mem *mem = &io_tlb_default_mem;
>
> -       if (!mem)
> +       if (!mem->nslabs)
>                 return;
>
>         size = array_size(sizeof(*mem->slots), mem->nslabs);
> @@ -342,7 +339,6 @@ void __init swiotlb_exit(void)
>                 free_pages((unsigned long)mem->slots, get_order(size));
>         else
>                 memblock_free_late(__pa(mem->slots), PAGE_ALIGN(size));
> -       io_tlb_default_mem = NULL;
>         memset(mem, 0, sizeof(*mem));
>  }
>
> @@ -697,7 +693,9 @@ size_t swiotlb_max_mapping_size(struct device *dev)
>
>  bool is_swiotlb_active(struct device *dev)
>  {
> -       return dev->dma_io_tlb_mem != NULL;
> +       struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> +
> +       return mem && mem->nslabs;
>  }
>  EXPORT_SYMBOL_GPL(is_swiotlb_active);
>
> @@ -712,10 +710,10 @@ static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem)
>
>  static int __init swiotlb_create_default_debugfs(void)
>  {
> -       struct io_tlb_mem *mem = io_tlb_default_mem;
> +       struct io_tlb_mem *mem = &io_tlb_default_mem;
>
>         debugfs_dir = debugfs_create_dir("swiotlb", NULL);
> -       if (mem) {
> +       if (mem->nslabs) {
>                 mem->debugfs = debugfs_dir;
>                 swiotlb_create_debugfs_files(mem);
>         }
> @@ -814,7 +812,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>  static void rmem_swiotlb_device_release(struct reserved_mem *rmem,
>                                         struct device *dev)
>  {
> -       dev->dma_io_tlb_mem = io_tlb_default_mem;
> +       dev->dma_io_tlb_mem = &io_tlb_default_mem;
>  }
>
>  static const struct reserved_mem_ops rmem_swiotlb_ops = {
> --
> 2.32.0.402.g57bb445576-goog
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
