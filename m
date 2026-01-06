Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EDD29B793
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 21:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767734288; cv=pass; b=r0o5kNfHtzyzAx5IjKR3A4FW3Qr+FHsk9eMte8GZD/qVmC4uMaT7RfCgYGQT9gjdsgnjXw/pVH0QVsoTvC6XXKB9BrlcxJ5AYuS87GlwxvZMVoYiPfyB5Lep07ytA+yrb1tDT2wIrE7GAjkO7TWDJMdl2bSw24bgIgH2QirBfPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767734288; c=relaxed/simple;
	bh=kMIkUWBlWm7enz1u486qiHHr+t+9Ar5m0amjgXvmaCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aL70QqB+Qw4YkwvyqqDIBLWRsR92p5Pn71D9gCLrF8Vu6i8ejp/h49Kh6iJt4tPgGGllnw0VO+4CZi4jM0fuC/EI7U74WHJCn6sqY/3wW4TMJSf3rw7TOLmiCRO2FWIre1tTkhPhBN6ZFguFwdCvY6BUu8nmN6or4ZuO228fmt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kq6uaB3Y; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kq6uaB3Y"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-121adc0f1e5so1959c88.0
        for <iommu@lists.linux.dev>; Tue, 06 Jan 2026 13:18:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767734286; cv=none;
        d=google.com; s=arc-20240605;
        b=NJNwtfq3/H+KNoPRzogny1nyfcRg5EeyknwcPvK3YSrUK1Xk5U4s2LhJW6+CNgXqqu
         y/IL5y54LtohyLPia2NEU7ZYjEatY63Fp834yyfjBxCpjyr90NSAXMLBfPT45A/j6dHk
         6WInJmUYK1iJPmrBRqrRwNPMh17lLL1H/b8OZk/EwOHrLcSEG4oHhLIYIDJ+boVye+2B
         VKaEYlC2NyPTGjCQpq0zcUMRlZh+5mDf83cBUvkfEa4uhkoj56CU9B/xweaVEqQ0hIW9
         bEh0KqYBjIZ7M0Ocs1JBz+QzKPWRp59+f2kz+BHKoC+zmPZbFX5wU+sQtBDBGI1cQone
         7EGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xs4wYR5ihtYfkrcnwnzlMK7Ux63wyubPNcFx3ioLljA=;
        fh=tmqQ0cm759o4KHcR4BIDzmceuadj8+o0kG8VhiJAwus=;
        b=TNxQtJqgrlhuDpsKMaxRz8NKT54xULeg4qG8Z7i/YH/GAW4y0esmJ0IQcq4UFIgOJ7
         SiuxLwG2enf7BZDsMSp6nrDd2eqOM63j00ICp7Kr84izzhMJ0czj1ZXL02g22oUr9qVZ
         6jzUxzQtFocAnzma9dNopxuIDlcKFIApnDSWwfjgnEaMb+6MpWQliyHtY9aSER4Ko95N
         aPAbDTZq5BKT09ZXfs/5I2LgkKVun/VaLP97h37ApN9ppiEg5pnmCVRXLocSlY0a3BIZ
         bZWLQG2mjEZsfzOcvDwujPkaulYXPA13hNQxqmzmLihhRutnLCuH3kB+NHaHfsBhNfRv
         +mwg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767734286; x=1768339086; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs4wYR5ihtYfkrcnwnzlMK7Ux63wyubPNcFx3ioLljA=;
        b=Kq6uaB3Y8o8uB8y1/Ubbnis/BsWBpdI70jVkED2ArQQzZToV1NC8uZiHPCu2oT1IK2
         I8FvxmF+mYuRkgQr9xiV87hoUGWA7PbY48sgc0x3RA07nch0Lku8UNAbP+xymJgRpql7
         yPXPjQGwNssp6i6hdp+pn3HgGhSkNMrPzP+Y1IVoV27AnZMuSg2ofJZnYY1/pBYML7GE
         NQUgb+pyeAqU3kFiH3VU3YJSpln4KwC5X3/uMQkOeODqmJMt/FDiBWUKAIv9qbmpMspx
         4r4NVxmlEOGAtvoFiNkw+tSq/KdtzwcGNRzy3COTSGhU7rDsRvTbZHioZs3RtqlKjfzJ
         oPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767734286; x=1768339086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xs4wYR5ihtYfkrcnwnzlMK7Ux63wyubPNcFx3ioLljA=;
        b=HOQGxb0FTeXfkvlwHM+BsB4qXn6LLP5t2+FuihUObR1uayleT6S9hrYSrXd0dijCf5
         oiGHb/hKtLfd4g2i9NavbbFgcOacDvlUW2iXagHfYL4gax1vkt+vpwciG/ykl6kYrPBp
         6xNeFxeNOPCcaosaqwdzVyUINlur/aZe2ib92Fu5uVI+Wu9j+E1LGCjy0KGXukW7/hLd
         Vp+zvCYqEKBx8yXS0tp4aRDcFJlA8Tfd/G6GIrilqPIb0NfWzLne+KiYpkuM+jJ+hZuI
         vy5BcQ2Sveb7xYLGXCHdF9Q7ET9lrKABNXG1PGtC5dzzyYyo+ktWfeiBWefwN3mLcoMm
         NqGA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ8th1Hvhnad25pBosIVG5dezVFBzPa+3UzPX7tgK2JDIypXc3WClkqx/JOcg7gP4GA5CEzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmTfcbldl4VVcZgkt7KkL86BgeuU7bERchaWUzLvXOMGBa5yCZ
	pbEmY5F5s9f+6sERiDyrQR4cd7PqK9LyJUtu+25P7D1sOndtG96DAUqlG+dJcNlbpDcZFk1F1nH
	d5hDJVeZZV/tMwsj8hhoSpGNMSmpuHLoMQi1/DyTc
X-Gm-Gg: AY/fxX6gJLfDdHWHNnAus7k8ecesEtIPVV8xFeTQosiQWEi/sA8ttTzkv//hSDXHkJm
	jgOagSryJIHclP6OGX/Oj2thEPnHKaXjcjAqqRGDxO1Gz743cJTUtw4z79ZTywrzxSSMznLVST2
	HJLiBA4XQYC1ymAHUwuTzmXHLbRswNK/FgfoeMEqUI5J7FSIIjHlUKwagkuIw6Wao6FB21wVIht
	HV6nu2PtUXu26hyB3d6XuRDeuxtdF92P0l50GfTXLu9v37ZmQVDX1tdwPVnegIWKsrh/Xmt+AWW
	ppjCUIr+mZF92zF2TOv850s=
X-Received: by 2002:a05:7022:11d:b0:119:e56b:c1d5 with SMTP id
 a92af1059eb24-121f85a2c84mr37453c88.0.1767734285772; Tue, 06 Jan 2026
 13:18:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260106162200.2223655-1-smostafa@google.com> <20260106162200.2223655-3-smostafa@google.com>
In-Reply-To: <20260106162200.2223655-3-smostafa@google.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 6 Jan 2026 13:17:53 -0800
X-Gm-Features: AQt7F2qCrnBg0kXhETMA1MP9KFpVtvxrt0SQO0tr_xkvmJ_R9qPTToDvVX-GwBE
Message-ID: <CAAywjhQ-anM-+nPS=GXpuSf5abCAySA40iuYU-Bgh00hiqbfow@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz, 
	surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com, 
	baolu.lu@linux.intel.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 8:22=E2=80=AFAM Mostafa Saleh <smostafa@google.com> =
wrote:
>
> Add calls for the new iommu debug config IOMMU_DEBUG_PAGEALLOC:
> - iommu_debug_init: Enable the debug mode if configured by the user.
> - iommu_debug_map: Track iommu pages mapped, using physical address.
> - iommu_debug_unmap_begin: Track start of iommu unmap operation, with
>   IOVA and size.
> - iommu_debug_unmap_end: Track the end of unmap operation, passing the
>   actual unmapped size versus the tracked one at unmap_begin.
>
> We have to do the unmap_begin/end as once pages are unmapped we lose
> the information of the physical address.
> This is racy, but the API is racy by construction as it uses refcounts
> and doesn't attempt to lock/synchronize with the IOMMU API as that will
> be costly, meaning that possibility of false negative exists.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/iommu-debug-pagealloc.c | 28 +++++++++++++
>  drivers/iommu/iommu-priv.h            | 58 +++++++++++++++++++++++++++
>  drivers/iommu/iommu.c                 | 11 ++++-
>  include/linux/iommu-debug-pagealloc.h |  1 +
>  4 files changed, 96 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-=
debug-pagealloc.c
> index 4022e9af7f27..1d343421da98 100644
> --- a/drivers/iommu/iommu-debug-pagealloc.c
> +++ b/drivers/iommu/iommu-debug-pagealloc.c
> @@ -5,11 +5,15 @@
>   * IOMMU API debug page alloc sanitizer
>   */
>  #include <linux/atomic.h>
> +#include <linux/iommu.h>
>  #include <linux/iommu-debug-pagealloc.h>
>  #include <linux/kernel.h>
>  #include <linux/page_ext.h>
>
> +#include "iommu-priv.h"
> +
>  static bool needed;
> +DEFINE_STATIC_KEY_FALSE(iommu_debug_initialized);
>
>  struct iommu_debug_metadata {
>         atomic_t ref;
> @@ -25,6 +29,30 @@ struct page_ext_operations page_iommu_debug_ops =3D {
>         .need =3D need_iommu_debug,
>  };
>
> +void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, si=
ze_t size)
> +{
> +}
> +
> +void __iommu_debug_unmap_begin(struct iommu_domain *domain,
> +                              unsigned long iova, size_t size)
> +{
> +}
> +
> +void __iommu_debug_unmap_end(struct iommu_domain *domain,
> +                            unsigned long iova, size_t size,
> +                            size_t unmapped)
> +{
> +}
> +
> +void iommu_debug_init(void)
> +{
> +       if (!needed)
> +               return;
> +
> +       pr_info("iommu: Debugging page allocations, expect overhead or di=
sable iommu.debug_pagealloc");
> +       static_branch_enable(&iommu_debug_initialized);
> +}
> +
>  static int __init iommu_debug_pagealloc(char *str)
>  {
>         return kstrtobool(str, &needed);
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index c95394cd03a7..aaffad5854fc 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -5,6 +5,7 @@
>  #define __LINUX_IOMMU_PRIV_H
>
>  #include <linux/iommu.h>
> +#include <linux/iommu-debug-pagealloc.h>
>  #include <linux/msi.h>
>
>  static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
> @@ -65,4 +66,61 @@ static inline int iommufd_sw_msi(struct iommu_domain *=
domain,
>  int iommu_replace_device_pasid(struct iommu_domain *domain,
>                                struct device *dev, ioasid_t pasid,
>                                struct iommu_attach_handle *handle);
> +
> +#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
> +
> +void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys,
> +                      size_t size);
> +void __iommu_debug_unmap_begin(struct iommu_domain *domain,
> +                              unsigned long iova, size_t size);
> +void __iommu_debug_unmap_end(struct iommu_domain *domain,
> +                            unsigned long iova, size_t size, size_t unma=
pped);
> +
> +static inline void iommu_debug_map(struct iommu_domain *domain,
> +                                  phys_addr_t phys, size_t size)
> +{
> +       if (static_branch_unlikely(&iommu_debug_initialized))
> +               __iommu_debug_map(domain, phys, size);
> +}
> +
> +static inline void iommu_debug_unmap_begin(struct iommu_domain *domain,
> +                                          unsigned long iova, size_t siz=
e)
> +{
> +       if (static_branch_unlikely(&iommu_debug_initialized))
> +               __iommu_debug_unmap_begin(domain, iova, size);
> +}
> +
> +static inline void iommu_debug_unmap_end(struct iommu_domain *domain,
> +                                        unsigned long iova, size_t size,
> +                                        size_t unmapped)
> +{
> +       if (static_branch_unlikely(&iommu_debug_initialized))
> +               __iommu_debug_unmap_end(domain, iova, size, unmapped);
> +}
> +
> +void iommu_debug_init(void);
> +
> +#else
> +static inline void iommu_debug_map(struct iommu_domain *domain,
> +                                  phys_addr_t phys, size_t size)
> +{
> +}
> +
> +static inline void iommu_debug_unmap_begin(struct iommu_domain *domain,
> +                                          unsigned long iova, size_t siz=
e)
> +{
> +}
> +
> +static inline void iommu_debug_unmap_end(struct iommu_domain *domain,
> +                                        unsigned long iova, size_t size,
> +                                        size_t unmapped)
> +{
> +}
> +
> +static inline void iommu_debug_init(void)
> +{
> +}
> +
> +#endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
> +
>  #endif /* __LINUX_IOMMU_PRIV_H */
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 2ca990dfbb88..01b062575519 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -232,6 +232,8 @@ static int __init iommu_subsys_init(void)
>         if (!nb)
>                 return -ENOMEM;
>
> +       iommu_debug_init();
> +
>         for (int i =3D 0; i < ARRAY_SIZE(iommu_buses); i++) {
>                 nb[i].notifier_call =3D iommu_bus_notifier;
>                 bus_register_notifier(iommu_buses[i], &nb[i]);
> @@ -2562,10 +2564,12 @@ int iommu_map_nosync(struct iommu_domain *domain,=
 unsigned long iova,
>         }
>
>         /* unroll mapping in case something went wrong */
> -       if (ret)
> +       if (ret) {
>                 iommu_unmap(domain, orig_iova, orig_size - size);
> -       else
> +       } else {
>                 trace_map(orig_iova, orig_paddr, orig_size);
> +               iommu_debug_map(domain, orig_paddr, orig_size);
> +       }
>
>         return ret;
>  }
> @@ -2627,6 +2631,8 @@ static size_t __iommu_unmap(struct iommu_domain *do=
main,
>
>         pr_debug("unmap this: iova 0x%lx size 0x%zx\n", iova, size);
>
> +       iommu_debug_unmap_begin(domain, iova, size);
> +
>         /*
>          * Keep iterating until we either unmap 'size' bytes (or more)
>          * or we hit an area that isn't mapped.
> @@ -2647,6 +2653,7 @@ static size_t __iommu_unmap(struct iommu_domain *do=
main,
>         }
>
>         trace_unmap(orig_iova, size, unmapped);
> +       iommu_debug_unmap_end(domain, orig_iova, size, unmapped);
>         return unmapped;
>  }
>
> diff --git a/include/linux/iommu-debug-pagealloc.h b/include/linux/iommu-=
debug-pagealloc.h
> index 83e64d70bf6c..a439d6815ca1 100644
> --- a/include/linux/iommu-debug-pagealloc.h
> +++ b/include/linux/iommu-debug-pagealloc.h
> @@ -9,6 +9,7 @@
>  #define __LINUX_IOMMU_DEBUG_PAGEALLOC_H
>
>  #ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
> +DECLARE_STATIC_KEY_FALSE(iommu_debug_initialized);
>
>  extern struct page_ext_operations page_iommu_debug_ops;
>
> --
> 2.52.0.351.gbe84eed79e-goog
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
