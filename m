Return-Path: <SRS0=0w8+=BR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956ADC433DF
	for <iommu@archiver.kernel.org>; Fri,  7 Aug 2020 19:59:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61CC72086A
	for <iommu@archiver.kernel.org>; Fri,  7 Aug 2020 19:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG4AtesE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CC72086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 320C488A3D;
	Fri,  7 Aug 2020 19:59:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g1s5d3y5xbwa; Fri,  7 Aug 2020 19:59:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CF53088ADA;
	Fri,  7 Aug 2020 19:59:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDB43C013C;
	Fri,  7 Aug 2020 19:59:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF282C0051
 for <iommu@lists.linux-foundation.org>; Fri,  7 Aug 2020 19:59:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A8FD088CE6
 for <iommu@lists.linux-foundation.org>; Fri,  7 Aug 2020 19:59:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FAKFkxngrLV4 for <iommu@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 19:59:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2849F88B31
 for <iommu@lists.linux-foundation.org>; Fri,  7 Aug 2020 19:59:55 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id k20so2916247wmi.5
 for <iommu@lists.linux-foundation.org>; Fri, 07 Aug 2020 12:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=syZktjcepY0vNc63q2VaOQLWA1fKYYMREF207iDmj8M=;
 b=PG4AtesEbVmdpNxayBlppShCjBdDC2bnYjhPF+wa3V0YTXmVsV+LXB1rZq6D56XHXd
 Ljtxvsyn7xdzl9zcM0kLHY7xV0mqM0unWx8Z9WfzYXMJOMnltLUAVnNkdr7DIoVp38cL
 VR6W/n6O8gZ/Zm8jaWup2PqlZZwEI6sGvuAnv7Q3pCVK69HpN00G3wf6wIMAyeFWhyBr
 ReVfh8HxCzZHBlIdr+0+FXgM7rzoqOsOWI5ur4pRwvbvEKGr9HbV+0HrugInX/IkMtRf
 nqvlfrJxJMfL+FhqlNs7Y9/UQKKu60CzDU0SVmKjUbK3xmzte/uHbD565BI7QSPTcXSU
 J3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=syZktjcepY0vNc63q2VaOQLWA1fKYYMREF207iDmj8M=;
 b=ryME8cl2Pj7cicNWrfYhWZ0Sot4YyruWk1/QvsifZU4rrgTlrvt+OtxvGFrKWBbf43
 hEVsuBUW0h/7pFU19ZZ066I8Zm51K6oCcj5lsI3JIs816yhPmyaCgyJgtT6eAYfChBGg
 fjCPapiPyo9yce3/00cddAnC46oy6nCjrYGKqogazckcQlWHW1B1sQJRzIeqrt3BUOyj
 B7seDY/AXsJA8PiMvjnLZxM9ZxUm6pUFq082FUTWRHu6JwHO/XYqDkugHmHdkr0sTYUl
 GNufV5ma4ASDIUESef2hsWRtdQFe06XowubCedHv7isGri2ciGE/bdBdM1dYN6DlMykm
 7HoQ==
X-Gm-Message-State: AOAM530QMLoSXeS/1SeTIueRwDRzThp7ZdE1EWpX1Sg7q/dXZUUKosy1
 QAVZi1QXI0URGPDeWVswTz8s+6U+vW73FNRu/s4=
X-Google-Smtp-Source: ABdhPJx4Qzp5/KvwYGLxwbL5y+B7itSkoeGkgu40KGhxhqPxnPpNPyE08am+leRP+rX0L+h8iNqO9z4Jw4+caqkiteY=
X-Received: by 2002:a1c:2dcb:: with SMTP id t194mr13696946wmt.94.1596830393486; 
 Fri, 07 Aug 2020 12:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200803193547.305660-1-jcrouse@codeaurora.org>
 <20200803193547.305660-10-jcrouse@codeaurora.org>
In-Reply-To: <20200803193547.305660-10-jcrouse@codeaurora.org>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 7 Aug 2020 13:00:37 -0700
Message-ID: <CAF6AEGvum9zLj41Ds+8+Q7qaMctwtcsEpC5aHGHZjb=piZO-QA@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v11 09/12] drm/msm: Add support to create a
 local pagetable
To: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Sean Paul <sean@poorly.run>, Will Deacon <will@kernel.org>,
 David Airlie <airlied@linux.ie>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, freedreno <freedreno@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Aug 3, 2020 at 12:36 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Add support to create a io-pgtable for use by targets that support
> per-instance pagetables. In order to support per-instance pagetables the
> GPU SMMU device needs to have the qcom,adreno-smmu compatible string and
> split pagetables enabled.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>
>  drivers/gpu/drm/msm/msm_gpummu.c |   2 +-
>  drivers/gpu/drm/msm/msm_iommu.c  | 191 ++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/msm/msm_mmu.h    |  16 ++-
>  3 files changed, 206 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gpummu.c b/drivers/gpu/drm/msm/msm_gpummu.c
> index 310a31b05faa..aab121f4beb7 100644
> --- a/drivers/gpu/drm/msm/msm_gpummu.c
> +++ b/drivers/gpu/drm/msm/msm_gpummu.c
> @@ -102,7 +102,7 @@ struct msm_mmu *msm_gpummu_new(struct device *dev, struct msm_gpu *gpu)
>         }
>
>         gpummu->gpu = gpu;
> -       msm_mmu_init(&gpummu->base, dev, &funcs);
> +       msm_mmu_init(&gpummu->base, dev, &funcs, MSM_MMU_GPUMMU);
>
>         return &gpummu->base;
>  }
> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> index 1b6635504069..bc6a4bbc904a 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -4,15 +4,202 @@
>   * Author: Rob Clark <robdclark@gmail.com>
>   */
>
> +#include <linux/io-pgtable.h>
>  #include "msm_drv.h"
>  #include "msm_mmu.h"
>
>  struct msm_iommu {
>         struct msm_mmu base;
>         struct iommu_domain *domain;
> +       atomic_t pagetables;
>  };
> +
>  #define to_msm_iommu(x) container_of(x, struct msm_iommu, base)
>
> +struct msm_iommu_pagetable {
> +       struct msm_mmu base;
> +       struct msm_mmu *parent;
> +       struct io_pgtable_ops *pgtbl_ops;
> +       phys_addr_t ttbr;
> +       u32 asid;
> +};
> +static struct msm_iommu_pagetable *to_pagetable(struct msm_mmu *mmu)
> +{
> +       return container_of(mmu, struct msm_iommu_pagetable, base);
> +}
> +
> +static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova,
> +               size_t size)
> +{
> +       struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
> +       struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
> +       size_t unmapped = 0;
> +
> +       /* Unmap the block one page at a time */
> +       while (size) {
> +               unmapped += ops->unmap(ops, iova, 4096, NULL);
> +               iova += 4096;
> +               size -= 4096;
> +       }
> +
> +       iommu_flush_tlb_all(to_msm_iommu(pagetable->parent)->domain);
> +
> +       return (unmapped == size) ? 0 : -EINVAL;
> +}
> +
> +static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
> +               struct sg_table *sgt, size_t len, int prot)
> +{
> +       struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
> +       struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
> +       struct scatterlist *sg;
> +       size_t mapped = 0;
> +       u64 addr = iova;
> +       unsigned int i;
> +
> +       for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> +               size_t size = sg->length;
> +               phys_addr_t phys = sg_phys(sg);
> +
> +               /* Map the block one page at a time */
> +               while (size) {
> +                       if (ops->map(ops, addr, phys, 4096, prot, GFP_KERNEL)) {
> +                               msm_iommu_pagetable_unmap(mmu, iova, mapped);
> +                               return -EINVAL;
> +                       }
> +
> +                       phys += 4096;
> +                       addr += 4096;
> +                       size -= 4096;
> +                       mapped += 4096;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static void msm_iommu_pagetable_destroy(struct msm_mmu *mmu)
> +{
> +       struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
> +       struct msm_iommu *iommu = to_msm_iommu(pagetable->parent);
> +
> +       /*
> +        * If this is the last attached pagetable for the parent,
> +        * disable TTBR0 in the arm-smmu driver
> +        */
> +       if (atomic_dec_return(&iommu->pagetables) == 0)
> +               iommu_domain_set_attr(iommu->domain,
> +                       DOMAIN_ATTR_PGTABLE_CFG, NULL);
> +
> +       free_io_pgtable_ops(pagetable->pgtbl_ops);
> +       kfree(pagetable);
> +}
> +
> +int msm_iommu_pagetable_params(struct msm_mmu *mmu,
> +               phys_addr_t *ttbr, int *asid)
> +{
> +       struct msm_iommu_pagetable *pagetable;
> +
> +       if (mmu->type != MSM_MMU_IOMMU_PAGETABLE)
> +               return -EINVAL;
> +
> +       pagetable = to_pagetable(mmu);
> +
> +       if (ttbr)
> +               *ttbr = pagetable->ttbr;
> +
> +       if (asid)
> +               *asid = pagetable->asid;
> +
> +       return 0;
> +}
> +
> +static const struct msm_mmu_funcs pagetable_funcs = {
> +               .map = msm_iommu_pagetable_map,
> +               .unmap = msm_iommu_pagetable_unmap,
> +               .destroy = msm_iommu_pagetable_destroy,
> +};
> +
> +static void msm_iommu_tlb_flush_all(void *cookie)
> +{
> +}
> +
> +static void msm_iommu_tlb_flush_walk(unsigned long iova, size_t size,
> +               size_t granule, void *cookie)
> +{
> +}
> +
> +static void msm_iommu_tlb_add_page(struct iommu_iotlb_gather *gather,
> +               unsigned long iova, size_t granule, void *cookie)
> +{
> +}
> +
> +static const struct iommu_flush_ops null_tlb_ops = {
> +       .tlb_flush_all = msm_iommu_tlb_flush_all,
> +       .tlb_flush_walk = msm_iommu_tlb_flush_walk,
> +       .tlb_flush_leaf = msm_iommu_tlb_flush_walk,
> +       .tlb_add_page = msm_iommu_tlb_add_page,
> +};
> +
> +struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
> +{
> +       struct msm_iommu *iommu = to_msm_iommu(parent);
> +       static int next_asid = 16;
> +       struct msm_iommu_pagetable *pagetable;
> +       struct io_pgtable_cfg cfg;
> +       int ret;
> +
> +       /* Get the pagetable configuration from the domain */
> +       ret = iommu_domain_get_attr(iommu->domain,
> +               DOMAIN_ATTR_PGTABLE_CFG, &cfg);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       pagetable = kzalloc(sizeof(*pagetable), GFP_KERNEL);
> +       if (!pagetable)
> +               return ERR_PTR(-ENOMEM);
> +
> +       msm_mmu_init(&pagetable->base, parent->dev, &pagetable_funcs,
> +               MSM_MMU_IOMMU_PAGETABLE);
> +
> +       /* The incoming cfg will have the TTBR1 quirk enabled */
> +       cfg.quirks &= ~IO_PGTABLE_QUIRK_ARM_TTBR1;
> +       cfg.tlb = &null_tlb_ops;
> +
> +       pagetable->pgtbl_ops = alloc_io_pgtable_ops(ARM_64_LPAE_S1,
> +               &cfg, iommu->domain);
> +
> +       if (!pagetable->pgtbl_ops) {
> +               kfree(pagetable);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       /*
> +        * If this is the first pagetable that we've allocated, send it back to
> +        * the arm-smmu driver as a trigger to set up TTBR0
> +        */
> +       if (atomic_inc_return(&iommu->pagetables) == 1) {
> +               ret = iommu_domain_set_attr(iommu->domain,
> +                       DOMAIN_ATTR_PGTABLE_CFG, &cfg);
> +               if (ret) {
> +                       free_io_pgtable_ops(pagetable->pgtbl_ops);
> +                       kfree(pagetable);
> +                       return ERR_PTR(ret);
> +               }
> +       }
> +
> +       /* Needed later for TLB flush */
> +       pagetable->parent = parent;
> +       pagetable->ttbr = cfg.arm_lpae_s1_cfg.ttbr;
> +
> +       pagetable->asid = next_asid;
> +       next_asid = (next_asid + 1)  % 255;

nit: extra space before '%'

> +       if (next_asid < 16)
> +               next_asid = 16;

nit: next_asid = min(16, next_asid)

?

BR,
-R

> +
> +       return &pagetable->base;
> +}
> +
>  static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
>                 unsigned long iova, int flags, void *arg)
>  {
> @@ -85,9 +272,11 @@ struct msm_mmu *msm_iommu_new(struct device *dev, struct iommu_domain *domain)
>                 return ERR_PTR(-ENOMEM);
>
>         iommu->domain = domain;
> -       msm_mmu_init(&iommu->base, dev, &funcs);
> +       msm_mmu_init(&iommu->base, dev, &funcs, MSM_MMU_IOMMU);
>         iommu_set_fault_handler(domain, msm_fault_handler, iommu);
>
> +       atomic_set(&iommu->pagetables, 0);
> +
>         ret = iommu_attach_device(iommu->domain, dev);
>         if (ret) {
>                 kfree(iommu);
> diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mmu.h
> index 3a534ee59bf6..61ade89d9e48 100644
> --- a/drivers/gpu/drm/msm/msm_mmu.h
> +++ b/drivers/gpu/drm/msm/msm_mmu.h
> @@ -17,18 +17,26 @@ struct msm_mmu_funcs {
>         void (*destroy)(struct msm_mmu *mmu);
>  };
>
> +enum msm_mmu_type {
> +       MSM_MMU_GPUMMU,
> +       MSM_MMU_IOMMU,
> +       MSM_MMU_IOMMU_PAGETABLE,
> +};
> +
>  struct msm_mmu {
>         const struct msm_mmu_funcs *funcs;
>         struct device *dev;
>         int (*handler)(void *arg, unsigned long iova, int flags);
>         void *arg;
> +       enum msm_mmu_type type;
>  };
>
>  static inline void msm_mmu_init(struct msm_mmu *mmu, struct device *dev,
> -               const struct msm_mmu_funcs *funcs)
> +               const struct msm_mmu_funcs *funcs, enum msm_mmu_type type)
>  {
>         mmu->dev = dev;
>         mmu->funcs = funcs;
> +       mmu->type = type;
>  }
>
>  struct msm_mmu *msm_iommu_new(struct device *dev, struct iommu_domain *domain);
> @@ -41,7 +49,13 @@ static inline void msm_mmu_set_fault_handler(struct msm_mmu *mmu, void *arg,
>         mmu->handler = handler;
>  }
>
> +struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent);
> +
>  void msm_gpummu_params(struct msm_mmu *mmu, dma_addr_t *pt_base,
>                 dma_addr_t *tran_error);
>
> +
> +int msm_iommu_pagetable_params(struct msm_mmu *mmu, phys_addr_t *ttbr,
> +               int *asid);
> +
>  #endif /* __MSM_MMU_H__ */
> --
> 2.25.1
>
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
