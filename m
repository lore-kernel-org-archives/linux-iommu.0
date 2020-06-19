Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BF8C433DF
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 14:45:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F5320A8B
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 14:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxLuXevQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F5320A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6B8A4899A5;
	Fri, 19 Jun 2020 14:45:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6HNBCK+dIWIk; Fri, 19 Jun 2020 14:45:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C011289910;
	Fri, 19 Jun 2020 14:45:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC8A9C0865;
	Fri, 19 Jun 2020 14:45:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0185FC016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 14:45:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E172721F76
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 14:45:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g4Hxw1kw4WE1 for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 14:45:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 1C5BE2288E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 14:45:06 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id p18so7815451eds.7
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 07:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n3TBE7tx6S7GnpZVCrwlr/3N+oOzUPGbvusmUOmG/T0=;
 b=AxLuXevQ37Qe6irR4ELS8KP+FbtI7KzXJI7NPPBrQFIdiz2bPyjW2dwsDyUEuAZ6Gj
 obAXbSqGvGp46HL1svoQ4ohhMLjIhlffXnHZ/rd6JE333aLAHAfe6p6IEAkDpMyo0pXz
 3gqCLLWBaQXFA+AKx51giDtpvGcOTXpNZQBkXRmjuL5/eK+mv5WjFpQ7EHYykN0iQqJQ
 5tiAnbC+hsmw05IcJKVRoieT8Q91BROe1dS0b8nEaqn6ub+ly4za5VRH9v4PT/EhZQS7
 GynsqTBgTG8dn/wZF0n7EHmYWJlx404GKADvC7euqmHvIFUdOyYzOlOpc7sXgaE5Mzfs
 JnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n3TBE7tx6S7GnpZVCrwlr/3N+oOzUPGbvusmUOmG/T0=;
 b=luneZbfF0Ieeiv3yoJQdxdMHLlpsFflbQJxkq02LUiNEMop2AqdwpffXOp17melaIJ
 cRKI1L2oHpLocEIcqcyhZjNAT6b206TcUl4z7m4fU3QnZoReJ5fWD90RYY45eREKTFGU
 yvwT43d2MUR4HFJ2Jcr6e5CW1sWoU9lLdSNxig4KfQDQKJjw7PU/PNrl1FYT4dFYvjE0
 id+eOHO+f1NifjIBHnDZX44/IjcYYfYOvMmlCGLPASAgRgQWMIODCJ+dk8++e61Wxg/r
 rsyBdKWMES2Iv+b5Sf45c2GN7GQ82XxesnGBjrU74cbkYsxfCIJdO8IXE0A6dTD5r02Y
 zrKw==
X-Gm-Message-State: AOAM532pdhSae7o11ZjJAxCE8jv+SSPfmHCciaLO9EPW0KWcfljZPeRa
 62qb3QH6GPlOr9D/tRIYzmevQK/4AcZFdF6XnaeP+B6d
X-Google-Smtp-Source: ABdhPJyrHWOsI7xCVBWiV5yZaFNfurId9widfkp7/AgosrKLWEbgVSdn17jhr9iXO5CndhUq8INILlVyez+GNc7k8GQ=
X-Received: by 2002:aa7:da14:: with SMTP id r20mr3712651eds.7.1592577904398;
 Fri, 19 Jun 2020 07:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200619103702eucas1p1c57147013bbac3968f6ba073caec68b5@eucas1p1.samsung.com>
 <20200619103636.11974-1-m.szyprowski@samsung.com>
 <20200619103636.11974-14-m.szyprowski@samsung.com>
In-Reply-To: <20200619103636.11974-14-m.szyprowski@samsung.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 19 Jun 2020 07:45:32 -0700
Message-ID: <CAF6AEGv9We+wD72_px3mucsXQuTFZ3ZX_CAA1LTysMBdiDcEFw@mail.gmail.com>
Subject: Re: [PATCH v7 13/36] drm: msm: fix common struct sg_table related
 issues
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: freedreno <freedreno@lists.freedesktop.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, linaro-mm-sig@lists.linaro.org,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Fri, Jun 19, 2020 at 3:37 AM Marek Szyprowski
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

Acked-by: Rob Clark <robdclark@gmail.com>

(let me know if you want me to take this one in via msm-next or if the
plan is to take the series via drm-misc)


> ---
>  drivers/gpu/drm/msm/msm_gem.c    | 13 +++++--------
>  drivers/gpu/drm/msm/msm_gpummu.c | 14 ++++++--------
>  drivers/gpu/drm/msm/msm_iommu.c  |  2 +-
>  3 files changed, 12 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 38b0c0e1f83e..e0d5fd36ea8f 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -53,11 +53,10 @@ static void sync_for_device(struct msm_gem_object *msm_obj)
>         struct device *dev = msm_obj->base.dev->dev;
>
>         if (get_dma_ops(dev) && IS_ENABLED(CONFIG_ARM64)) {
> -               dma_sync_sg_for_device(dev, msm_obj->sgt->sgl,
> -                       msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
> +               dma_sync_sgtable_for_device(dev, msm_obj->sgt,
> +                                           DMA_BIDIRECTIONAL);
>         } else {
> -               dma_map_sg(dev, msm_obj->sgt->sgl,
> -                       msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
> +               dma_map_sgtable(dev, msm_obj->sgt, DMA_BIDIRECTIONAL, 0);
>         }
>  }
>
> @@ -66,11 +65,9 @@ static void sync_for_cpu(struct msm_gem_object *msm_obj)
>         struct device *dev = msm_obj->base.dev->dev;
>
>         if (get_dma_ops(dev) && IS_ENABLED(CONFIG_ARM64)) {
> -               dma_sync_sg_for_cpu(dev, msm_obj->sgt->sgl,
> -                       msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
> +               dma_sync_sgtable_for_cpu(dev, msm_obj->sgt, DMA_BIDIRECTIONAL);
>         } else {
> -               dma_unmap_sg(dev, msm_obj->sgt->sgl,
> -                       msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
> +               dma_unmap_sgtable(dev, msm_obj->sgt, DMA_BIDIRECTIONAL, 0);
>         }
>  }
>
> diff --git a/drivers/gpu/drm/msm/msm_gpummu.c b/drivers/gpu/drm/msm/msm_gpummu.c
> index 310a31b05faa..319f06c28235 100644
> --- a/drivers/gpu/drm/msm/msm_gpummu.c
> +++ b/drivers/gpu/drm/msm/msm_gpummu.c
> @@ -30,21 +30,19 @@ static int msm_gpummu_map(struct msm_mmu *mmu, uint64_t iova,
>  {
>         struct msm_gpummu *gpummu = to_msm_gpummu(mmu);
>         unsigned idx = (iova - GPUMMU_VA_START) / GPUMMU_PAGE_SIZE;
> -       struct scatterlist *sg;
> +       struct sg_dma_page_iter dma_iter;
>         unsigned prot_bits = 0;
> -       unsigned i, j;
>
>         if (prot & IOMMU_WRITE)
>                 prot_bits |= 1;
>         if (prot & IOMMU_READ)
>                 prot_bits |= 2;
>
> -       for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> -               dma_addr_t addr = sg->dma_address;
> -               for (j = 0; j < sg->length / GPUMMU_PAGE_SIZE; j++, idx++) {
> -                       gpummu->table[idx] = addr | prot_bits;
> -                       addr += GPUMMU_PAGE_SIZE;
> -               }
> +       for_each_sgtable_dma_page(sgt, &dma_iter, 0) {
> +               dma_addr_t addr = sg_page_iter_dma_address(&dma_iter);
> +
> +               BUILD_BUG_ON(GPUMMU_PAGE_SIZE != PAGE_SIZE);
> +               gpummu->table[idx++] = addr | prot_bits;
>         }
>
>         /* we can improve by deferring flush for multiple map() */
> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> index 3a381a9674c9..6c31e65834c6 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -36,7 +36,7 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
>         struct msm_iommu *iommu = to_msm_iommu(mmu);
>         size_t ret;
>
> -       ret = iommu_map_sg(iommu->domain, iova, sgt->sgl, sgt->nents, prot);
> +       ret = iommu_map_sgtable(iommu->domain, iova, sgt, prot);
>         WARN_ON(!ret);
>
>         return (ret == len) ? 0 : -EINVAL;
> --
> 2.17.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
