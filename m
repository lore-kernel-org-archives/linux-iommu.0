Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2367C433E0
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 14:35:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B03206D4
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 14:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDcWgigW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B03206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 694F221135;
	Mon, 18 May 2020 14:35:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3stBXF4BmPBa; Mon, 18 May 2020 14:35:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7F09420794;
	Mon, 18 May 2020 14:35:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60B0DC0881;
	Mon, 18 May 2020 14:35:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59DB8C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 01:27:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 46B64883F0
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 01:27:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uwhWiEPmaCmb for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 01:27:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5666E883C2
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 01:27:24 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id d207so18271755wmd.0
 for <iommu@lists.linux-foundation.org>; Sun, 17 May 2020 18:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uZfH/yW2EkwOl9gEcet4jN7ZXi9BLKHqqQrfr1sC6ac=;
 b=vDcWgigWf+8ZKsquN2u4JqfQ8umHJX5fe46rUTGhJECREweESiSfWnUn0R+kFnVYzL
 Po+JjR2lydKpGPNuAuKUfwyrCt05L9FE2SiboNT/Di3jcIyohybAZ7DEy0Rfme5FXmov
 hLdWtACwrYRBlLG0QN8oUbUrydmDczxFu2izF8ScEASNprtdB5wc/pnUdJmba6hRwV9n
 aHCMGNU+KjzWjQTSpCRhc4bWnVvgd0rJg1YDnGNoSnyOoDtovxLu56C1biuKkr+dRjvW
 tJZ3MvsoObtcyH+Pvwi+VeXvwxYehRqFZ5a/TM/TAH2YVIfFH9U6+mtgTNk5l3SnaaaD
 oGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uZfH/yW2EkwOl9gEcet4jN7ZXi9BLKHqqQrfr1sC6ac=;
 b=uSG83J5nwMxRhDlqQHYKML6BCOTG9eCg4EwAWNiR6zPbfF+bdxJkwtSj0Vbn2tR2dZ
 jLh3mCCHGHCd91lndXWFVHLOHtFwXUzzr+qHziekG/BWnthEDBqk6yUscCgRs/FuxWK6
 gu9BB8LJtDSMlZDVJ3dhg76pu53UGFCUJbtXBaBbd72u8UnV7aYvymewdj5hmIjsb92D
 xNX/anHGndzPnt38+EJaea+jvWoqZEn/AmEtDEdih8/FVY27qlCBWmTbphUMHEcIA044
 LukfCLSH0Qbz2LYMXwc8u+d62AXoPMPL6m6uJCZGit84znpL6MB2OVDHJ5qPx2EiLFAj
 QKuw==
X-Gm-Message-State: AOAM531wVBZqIqAae5HhYs5avAeMwaEZdyLbhiXat4aRb5MHEoAtbqJu
 CwV2TZoYZ62sdOBE4RC6bopciDF3e7CsL7C2xfA=
X-Google-Smtp-Source: ABdhPJwYXjut1W+agJe7qHIAazerG/VY4Qh5rG0NKf6TSwEA+kmhHmC2ZVellCufA3F7oGA23ea+FfJqOJUfr5uzS0A=
X-Received: by 2002:a05:600c:2255:: with SMTP id
 a21mr17035637wmm.67.1589765242888; 
 Sun, 17 May 2020 18:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <CGME20200513133305eucas1p15187ed8fa1e4af181cafa5c65ddab4cd@eucas1p1.samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <20200513133245.6408-13-m.szyprowski@samsung.com>
In-Reply-To: <20200513133245.6408-13-m.szyprowski@samsung.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Mon, 18 May 2020 09:27:11 +0800
Message-ID: <CAKGbVbsSPhQY5zEBGPQtyhLu38w=Hw73OQr6UiV_dHC46DescQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/38] drm: lima: fix common struct sg_table related
 issues
To: Marek Szyprowski <m.szyprowski@samsung.com>
X-Mailman-Approved-At: Mon, 18 May 2020 14:35:33 +0000
Cc: lima@lists.freedesktop.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
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

Looks good for me, patch is:
Reviewed-by: Qiang Yu <yuq825@gmail.com>

Regards,
Qiang

On Wed, May 13, 2020 at 9:33 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() function
> returns the number of the created entries in the DMA address space.
> However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
> dma_unmap_sg must be called with the original number of the entries
> passed to the dma_map_sg().
>
> struct sg_table is a common structure used for describing a non-contiguous
> memory buffer, used commonly in the DRM and graphics subsystems. It
> consists of a scatterlist with memory pages and DMA addresses (sgl entry),
> as well as the number of scatterlist entries: CPU pages (orig_nents entry)
> and DMA mapped pages (nents entry).
>
> It turned out that it was a common mistake to misuse nents and orig_nents
> entries, calling DMA-mapping functions with a wrong number of entries or
> ignoring the number of mapped entries returned by the dma_map_sg()
> function.
>
> To avoid such issues, lets use a common dma-mapping wrappers operating
> directly on the struct sg_table objects and use scatterlist page
> iterators where possible. This, almost always, hides references to the
> nents and orig_nents entries, making the code robust, easier to follow
> and copy/paste safe.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
> vs. orig_nents misuse' thread:
> https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
> ---
>  drivers/gpu/drm/lima/lima_gem.c | 11 ++++++++---
>  drivers/gpu/drm/lima/lima_vm.c  |  5 ++---
>  2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
> index 5404e0d..cda43f6 100644
> --- a/drivers/gpu/drm/lima/lima_gem.c
> +++ b/drivers/gpu/drm/lima/lima_gem.c
> @@ -69,8 +69,7 @@ int lima_heap_alloc(struct lima_bo *bo, struct lima_vm *vm)
>                 return ret;
>
>         if (bo->base.sgt) {
> -               dma_unmap_sg(dev, bo->base.sgt->sgl,
> -                            bo->base.sgt->nents, DMA_BIDIRECTIONAL);
> +               dma_unmap_sgtable(dev, bo->base.sgt, DMA_BIDIRECTIONAL, 0);
>                 sg_free_table(bo->base.sgt);
>         } else {
>                 bo->base.sgt = kmalloc(sizeof(*bo->base.sgt), GFP_KERNEL);
> @@ -80,7 +79,13 @@ int lima_heap_alloc(struct lima_bo *bo, struct lima_vm *vm)
>                 }
>         }
>
> -       dma_map_sg(dev, sgt.sgl, sgt.nents, DMA_BIDIRECTIONAL);
> +       ret = dma_map_sgtable(dev, &sgt, DMA_BIDIRECTIONAL, 0);
> +       if (ret) {
> +               sg_free_table(&sgt);
> +               kfree(bo->base.sgt);
> +               bo->base.sgt = NULL;
> +               return ret;
> +       }
>
>         *bo->base.sgt = sgt;
>
> diff --git a/drivers/gpu/drm/lima/lima_vm.c b/drivers/gpu/drm/lima/lima_vm.c
> index 5b92fb8..2b2739a 100644
> --- a/drivers/gpu/drm/lima/lima_vm.c
> +++ b/drivers/gpu/drm/lima/lima_vm.c
> @@ -124,7 +124,7 @@ int lima_vm_bo_add(struct lima_vm *vm, struct lima_bo *bo, bool create)
>         if (err)
>                 goto err_out1;
>
> -       for_each_sg_dma_page(bo->base.sgt->sgl, &sg_iter, bo->base.sgt->nents, 0) {
> +       for_each_sgtable_dma_page(bo->base.sgt, &sg_iter, 0) {
>                 err = lima_vm_map_page(vm, sg_page_iter_dma_address(&sg_iter),
>                                        bo_va->node.start + offset);
>                 if (err)
> @@ -298,8 +298,7 @@ int lima_vm_map_bo(struct lima_vm *vm, struct lima_bo *bo, int pageoff)
>         mutex_lock(&vm->lock);
>
>         base = bo_va->node.start + (pageoff << PAGE_SHIFT);
> -       for_each_sg_dma_page(bo->base.sgt->sgl, &sg_iter,
> -                            bo->base.sgt->nents, pageoff) {
> +       for_each_sgtable_dma_page(bo->base.sgt, &sg_iter, pageoff) {
>                 err = lima_vm_map_page(vm, sg_page_iter_dma_address(&sg_iter),
>                                        base + offset);
>                 if (err)
> --
> 1.9.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
