Return-Path: <SRS0=9AUr=X3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01561ECE58C
	for <iommu@archiver.kernel.org>; Wed,  2 Oct 2019 12:05:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6DA221783
	for <iommu@archiver.kernel.org>; Wed,  2 Oct 2019 12:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DA221783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7A638E78;
	Wed,  2 Oct 2019 12:05:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 846E6E71
	for <iommu@lists.linux-foundation.org>;
	Wed,  2 Oct 2019 12:05:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
	[209.85.210.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5E5BE1FB
	for <iommu@lists.linux-foundation.org>;
	Wed,  2 Oct 2019 12:05:29 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id g13so14418332otp.8
	for <iommu@lists.linux-foundation.org>;
	Wed, 02 Oct 2019 05:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=wcJuYz8ap/PAa28X22SqN7rL8kWlSbf642LPdR37bT4=;
	b=gOeoXtqz54aC7xsi7pXghUYNjyg5olb99gBklogHgqemb4qM5Nf5B3BOEfQ9pabstY
	MI3QmcIX2aP+LAqwyOtnITFtNzDwzVI9HHY8AEStjPvz2KDFvLRgicdF/UhiIWxyjDvN
	yrvJDE3EAvt2I3k3BrvyHhCDdWubX5VW2yerLhFr8eLbSEWT6T49oqPaEYWd4fbwKDEz
	xceinZmZGDvz66mFTL7pR4+3je++X/WrjFzLe2kBMHN5eBn8X6fVxdLQJ9i7rh7wrgjV
	yarI8u/HUISmJ9DXQtAOmKVX5zACGfzrtUcjnDcCCctCdG7lTLaZ69XuV42ht3KdSiTD
	iB+A==
X-Gm-Message-State: APjAAAWXFxNxgtezBSvGwBEk5ToCBgT13fFIy8FGcNULmdcaT/y4ZoNs
	gycqzLmXwSA/l2Ae/6jOZjjAOFVTvFI+c98nMOo=
X-Google-Smtp-Source: APXvYqwlK3863lE2oH5kjnCtTsezs0gzi/uTSEHNnzTjlEZSZoMVYwNhQ0XeB42ghRAjqgTuNjHx2QzBQQTWVXkBvVI=
X-Received: by 2002:a9d:404d:: with SMTP id o13mr2433193oti.39.1570017928452; 
	Wed, 02 Oct 2019 05:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190830062924.21714-1-hch@lst.de>
	<20190830062924.21714-4-hch@lst.de>
In-Reply-To: <20190830062924.21714-4-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 Oct 2019 14:05:17 +0200
Message-ID: <CAMuHMdXxWp2=9n2LQA9KVH_ArOUnY78ZoiQ7ZsDMbTOGsEz4hw@mail.gmail.com>
Subject: Re: [PATCH 3/4] dma-mapping: introduce a dma_common_find_pages helper
To: Christoph Hellwig <hch@lst.de>
Cc: linux-xtensa@linux-xtensa.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Linux MM <linux-mm@kvack.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Christoph,

On Fri, Aug 30, 2019 at 8:30 AM Christoph Hellwig <hch@lst.de> wrote:
> A helper to find the backing page array based on a virtual address.
> This also ensures we do the same vm_flags check everywhere instead
> of slightly different or missing ones in a few places.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This is now commit 5cf4537975bbd569 ("dma-mapping: introduce a
dma_common_find_pages helper") in v5.4-rc1, and causes the following
warning during s2ram on r8a7740/armadillo, r7s72100/rskrza1, and
r7s9210/rza2mevb:

     sh-eth e9a00000.ethernet eth0: Link is Down
    +------------[ cut here ]------------
    +WARNING: CPU: 0 PID: 556 at kernel/dma/remap.c:93
remap_allocator_free+0x20/0x30
    +trying to free invalid coherent area: 6909579a
    +Modules linked in:
    +CPU: 0 PID: 556 Comm: s2ram Not tainted
5.3.0-rc6-armadillo-00027-g5cf4537975bbd569-dirty #113
    +Hardware name: Generic R8A7740 (Flattened Device Tree)
    +[<c010d4b8>] (unwind_backtrace) from [<c010b4d0>] (show_stack+0x10/0x14)
    +[<c010b4d0>] (show_stack) from [<c011d978>] (__warn+0xec/0x104)
    +[<c011d978>] (__warn) from [<c011d9d4>] (warn_slowpath_fmt+0x44/0x6c)
    +[<c011d9d4>] (warn_slowpath_fmt) from [<c011123c>]
(remap_allocator_free+0x20/0x30)
    +[<c011123c>] (remap_allocator_free) from [<c0111cc4>]
(__arm_dma_free.constprop.2+0x114/0x144)
    +[<c0111cc4>] (__arm_dma_free.constprop.2) from [<c03f193c>]
(sh_eth_ring_free+0xb8/0x114)
    +[<c03f193c>] (sh_eth_ring_free) from [<c03f1a00>] (sh_eth_close+0x68/0x8c)
    +[<c03f1a00>] (sh_eth_close) from [<c03f1f6c>] (sh_eth_resume+0x44/0x90)
    +[<c03f1f6c>] (sh_eth_resume) from [<c03b7d3c>] (dpm_run_callback+0x64/0xdc)
    +[<c03b7d3c>] (dpm_run_callback) from [<c03b80c0>]
(device_resume+0xbc/0x180)
    +[<c03b80c0>] (device_resume) from [<c03b89b0>] (dpm_resume+0x124/0x1b0)
    +[<c03b89b0>] (dpm_resume) from [<c03b8c5c>] (dpm_resume_end+0xc/0x18)
    +[<c03b8c5c>] (dpm_resume_end) from [<c0158d2c>]
(suspend_devices_and_enter+0x15c/0x5ac)
    +[<c0158d2c>] (suspend_devices_and_enter) from [<c01593bc>]
(pm_suspend+0x240/0x2f4)
    +[<c01593bc>] (pm_suspend) from [<c0157b48>] (state_store+0x54/0x8c)
    +[<c0157b48>] (state_store) from [<c0276ecc>] (kernfs_fop_write+0x154/0x1c8)
    +[<c0276ecc>] (kernfs_fop_write) from [<c0209f74>] (__vfs_write+0x28/0xe0)
    +[<c0209f74>] (__vfs_write) from [<c020acc0>] (vfs_write+0x98/0xbc)
    +[<c020acc0>] (vfs_write) from [<c020ae48>] (ksys_write+0x68/0xb4)
    +[<c020ae48>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
    +Exception stack(0xdd74dfa8 to 0xdd74dff0)
    +dfa0:                   00000004 000e2408 00000001 000e2408
00000004 00000000
    +dfc0: 00000004 000e2408 b6f36d60 00000004 000e2408 00000004
00000000 00000000
    +dfe0: 00000000 be9fc74c b6e991bb b6ed5af6
    +irq event stamp: 0
    +hardirqs last  enabled at (0): [<00000000>] 0x0
    +hardirqs last disabled at (0): [<c011b73c>] copy_process+0x520/0x14b8
    +softirqs last  enabled at (0): [<c011b73c>] copy_process+0x520/0x14b8
    +softirqs last disabled at (0): [<00000000>] 0x0
    +---[ end trace 22461a068edbf2c1 ]---
    +------------[ cut here ]------------
    +WARNING: CPU: 0 PID: 556 at kernel/dma/remap.c:93
remap_allocator_free+0x20/0x30
    +trying to free invalid coherent area: f39c52ba

     [...]

    +---[ end trace 22461a068edbf2c2 ]---
     SMSC LAN8710/LAN8720 e9a00000.ethernet-ffffffff:00: attached PHY
driver [SMSC LAN8710/LAN8720]
(mii_bus:phy_addr=e9a00000.ethernet-ffffffff:00, irq=POLL)

(the dirty is due to the need for "ARM: fix __get_user_check() in case
 uaccess_* calls are not inlined").

BTW, I cannot trigger the issue on r8a7791/koelsch, which also uses
sh-eth, not even when disabling CONFIG_IOMMU_SUPPORT and CONFIG_ARM_LPAE
(both are not set for the affected platforms).

> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -541,15 +541,6 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>         return pages;
>  }
>
> -static struct page **__iommu_dma_get_pages(void *cpu_addr)
> -{
> -       struct vm_struct *area = find_vm_area(cpu_addr);
> -
> -       if (!area || !area->pages)

This checks area->pages...

> -               return NULL;
> -       return area->pages;
> -}
> -
>  /**
>   * iommu_dma_alloc_remap - Allocate and map a buffer contiguous in IOVA space
>   * @dev: Device to allocate memory for. Must be a real device
> @@ -938,7 +929,7 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
>                  * If it the address is remapped, then it's either non-coherent
>                  * or highmem CMA, or an iommu_dma_alloc_remap() construction.
>                  */
> -               pages = __iommu_dma_get_pages(cpu_addr);
> +               pages = dma_common_find_pages(cpu_addr);
>                 if (!pages)
>                         page = vmalloc_to_page(cpu_addr);
>                 dma_common_free_remap(cpu_addr, alloc_size);
> @@ -1045,7 +1036,7 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>                 return -ENXIO;
>
>         if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
> -               struct page **pages = __iommu_dma_get_pages(cpu_addr);
> +               struct page **pages = dma_common_find_pages(cpu_addr);
>
>                 if (pages)
>                         return __iommu_dma_mmap(pages, size, vma);
> @@ -1067,7 +1058,7 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
>         int ret;
>
>         if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
> -               struct page **pages = __iommu_dma_get_pages(cpu_addr);
> +               struct page **pages = dma_common_find_pages(cpu_addr);
>
>                 if (pages) {
>                         return sg_alloc_table_from_pages(sgt, pages,

> --- a/kernel/dma/remap.c
> +++ b/kernel/dma/remap.c
> @@ -11,6 +11,15 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>
> +struct page **dma_common_find_pages(void *cpu_addr)
> +{
> +       struct vm_struct *area = find_vm_area(cpu_addr);
> +
> +       if (!area || area->flags != VM_DMA_COHERENT)

... while this one checks area->flags?

> +               return NULL;
> +       return area->pages;
> +}
> +
>  static struct vm_struct *__dma_common_pages_remap(struct page **pages,
>                         size_t size, pgprot_t prot, const void *caller)
>  {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
