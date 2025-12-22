Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B8F2FFDD6
	for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 21:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766437979; cv=none; b=A5RRhe4Ya3Pt4o8ZaYKXQEF8cbq8OS3x99nBIusujhLU12UuE6rbv8cOhECL0Vcb8HZy52hx+bmgbhS7zAPHx5ZjrLl/rqjMmSx7Zlc1oZZip2v/6NPVwuKlgVU0SsSk9gEU3xzS1UwwvTenayX5/85NHFmKR2wMDTm6ApoU6rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766437979; c=relaxed/simple;
	bh=671Vugf3UIPhhPctowJbiht/G/9mDUO30vdO29Z+OP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COT81UnPTBb8GlFSlt3+6dxMF76DjYsVQfjFYP+6C2Hfip59naKcEOBcSw0V78UAULPdgNdR7adUdj7Mws+gKUpSy1BssiHSyoCm/SWaGWTfvU72G8KztDS3NPEeoQaOGUen2MUimC+jKBbCbgtRHaWm9aS+ZXiyrB/R6LVbWAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQUxUX/h; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQUxUX/h"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88a367a1db0so72056216d6.3
        for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 13:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766437976; x=1767042776; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cS7r1WMYr/uN9zT9E76vDgjzoaHdZM9vVeea6K8465w=;
        b=mQUxUX/hTypbWqo7FzS+f4FZw4IVEBKgBi07L7bODHscaXdN47GxpSrP67ZNq/VH8P
         uwJfHsHOrR/APsroWRvcGJUwogb6/6dx4KBz2hjl1akHVsUggD35Xc5/V1iBrjCYh12W
         yojBTOH4NP3ueiVyfBeYMGzo01Z8ms/6oIIixQhCbBDreMLypAnBCDdcOFp9xeeBAdPt
         0Z93GWB5wyfJmwBulda+YwoK1dOOGDj3O8nj151z6StW1CM39kRrcBPdqlMbM8R3I2cs
         +i5t9EuHhhUTW/8mp1mYxjL+xD8aV+ILw8Ybts11netSCOoygHPfMrQrBcqb1UoWSq+j
         C3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766437976; x=1767042776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cS7r1WMYr/uN9zT9E76vDgjzoaHdZM9vVeea6K8465w=;
        b=EWs6NFqdhp56CPFQJaLk2drEwD4BrBBfYfp6YLxOHn3zAOq9Yv93UW56RL18EO2o1M
         McdcuHOQjrsATmWY03S9MAEqoe1K/6lo0zzMPrYklPeC947FBiampvvuAD96dSQVHlbk
         hlQsslCzZtoGXHYSGZ3M6r4pGkvR5CMDGmgxS/Pl+oz9sgDdwIb4Gr6tV6Vohdf3gmzS
         0MMvLJAM2qdqoaLEY4pMliqh8HJOUxNYa/OKDDdgq45i++Hbqs0zKhoKKtL84kC5jfxn
         cHhxOj3gh4QMV9ziB7KWujrFO0F7jQo3hILVjrCjTlw8nmPi1JJEhGCBHkkGyfrBFYkn
         vCuA==
X-Forwarded-Encrypted: i=1; AJvYcCUHmlRxB/NpDHBzkKYeEwHCMmleK0ztSX0qeJppeIXA3QlH5XYOp3LwbhA7zJkNp/Dm2C3jUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcW41zFv9MXn3V1EvR0dgvx4Eem7qgQyIV0IEC5h3tVDvpJu5L
	lmxGJSwYQ/lW+ZebqEY1C1ST3DQyRpmnUgfMJCSEvf4eEvhb89MzCVUhzK8rMPSZuUJB+MnWIXY
	3N6KPeknALcwOQ7xz4r7tcm08RXVI9wI=
X-Gm-Gg: AY/fxX7uxesRuC7EhKuswZugbf9uQoXyuavyeUWNdWo7Mnr5d5g1VR0G+Jrcu2YGfU4
	Mi4vPrgyx71wybJYfRvhu1WD3aS9MT3M24Jx2U+AYXwiF19LILPxeMnpU/x9AjjqJ38HJZICcBI
	TL7sp/8F+pIe6sj/GO0i9yxP1Byp6gxU0YLIfjI1xHh71hgcR+7l26ddozsDlgDVLVw66fyiccl
	CnxyyjKR+w5TTe3zwM66BYnjO9ppmGgUl2W626Nt6CMb8dnWIgmy686k1YDI30lAMlJg846EkB1
	RTM9
X-Google-Smtp-Source: AGHT+IEpFt2TIFjn8naTNw7fj8lW9oUYCIQQmyR3ceka2iWxogYasrnKgy6JbGYcfI58SspLvt9OH8N0sZ7z4rHhHy8=
X-Received: by 2002:a05:6214:328e:b0:889:7c5b:8134 with SMTP id
 6a1803df08f44-88d82138446mr202099816d6.27.1766437976086; Mon, 22 Dec 2025
 13:12:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251222153246.2220659-1-xiaqinxin@huawei.com> <20251222153246.2220659-3-xiaqinxin@huawei.com>
In-Reply-To: <20251222153246.2220659-3-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 23 Dec 2025 10:12:44 +1300
X-Gm-Features: AQt7F2p2TdlkyqpaT9wtLaye9eDB02KUzOhSqB0izlk_ORlRWm4iaRYR8eHl5rc
Message-ID: <CAGsJ_4xqDWu+AanD0RRMcAEtzje45p8WsaUtCtarO1nf4iECeQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] dma-mapping: benchmark: add support for dma_map_sg
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: jonathan.cameron@huawei.com, wangzhou1@hisilicon.com, 
	iommu@lists.linux.dev, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 4:33=E2=80=AFAM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
> Support for dma scatter-gather mapping and is intended for testing
> mapping performance. It achieves by introducing the dma_sg_map_param
> structure and related functions, which enable the implementation of
> scatter-gather mapping preparation, mapping, and unmapping operations.
> Additionally, the dma_map_benchmark_ops array is updated to include
> operations for scatter-gather mapping. This commit aims to provide
> a wider range of mapping performance test to cater to different scenarios=
.
>
> Reviewed-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>  include/uapi/linux/map_benchmark.h |   1 +
>  kernel/dma/map_benchmark.c         | 117 ++++++++++++++++++++++++++++-
>  2 files changed, 117 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/map_benchmark.h b/include/uapi/linux/map_=
benchmark.h
> index e076748f2120..5fa3745e1651 100644
> --- a/include/uapi/linux/map_benchmark.h
> +++ b/include/uapi/linux/map_benchmark.h
> @@ -19,6 +19,7 @@
>
>  enum {
>         DMA_MAP_BENCH_SINGLE_MODE,
> +       DMA_MAP_BENCH_SG_MODE,
>         DMA_MAP_BENCH_MODE_MAX
>  };
>
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index a6345c10901c..76c0e1d5ff08 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -16,6 +16,7 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> +#include <linux/scatterlist.h>
>  #include <linux/slab.h>
>  #include <linux/timekeeping.h>
>  #include <uapi/linux/map_benchmark.h>
> @@ -117,8 +118,121 @@ static struct map_benchmark_ops dma_single_map_benc=
hmark_ops =3D {
>         .do_unmap =3D dma_single_map_benchmark_do_unmap,
>  };
>
> +struct dma_sg_map_param {
> +       struct sg_table sgt;
> +       struct device *dev;
> +       void **buf;
> +       u32 npages;
> +       u32 dma_dir;
> +};
> +
> +static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data *map=
)
> +{
> +       struct scatterlist *sg;
> +       int i;
> +
> +       struct dma_sg_map_param *params =3D kzalloc(sizeof(*params), GFP_=
KERNEL);
> +
> +       if (!params)
> +               return NULL;
> +       /*
> +        * Set the number of scatterlist entries based on the granule.
> +        * In SG mode, 'granule' represents the number of scatterlist ent=
ries.
> +        * Each scatterlist entry corresponds to a single page.
> +        */
> +       params->npages =3D map->bparam.granule;
> +       params->dma_dir =3D map->bparam.dma_dir;
> +       params->dev =3D map->dev;
> +       params->buf =3D kmalloc_array(params->npages, sizeof(*params->buf=
),
> +                                   GFP_KERNEL);
> +       if (!params->buf)
> +               goto out;
> +
> +       if (sg_alloc_table(&params->sgt, params->npages, GFP_KERNEL))
> +               goto free_buf;
> +
> +       for_each_sgtable_sg(&params->sgt, sg, i) {
> +               params->buf[i] =3D (void *)__get_free_page(GFP_KERNEL);
> +               if (!params->buf[i])
> +                       goto free_page;
> +
> +               sg_set_buf(sg, params->buf[i], PAGE_SIZE);
> +       }
> +
> +       return_ptr(params);
> +
> +free_page:
> +       while (i-- > 0)
> +               free_page((unsigned long)params->buf[i]);
> +
> +       sg_free_table(&params->sgt);
> +free_buf:
> +       kfree(params->buf);
> +out:
> +       return NULL;
> +}
> +
> +static void dma_sg_map_benchmark_unprepare(void *mparam)
> +{
> +       struct dma_sg_map_param *params =3D mparam;
> +       int i;
> +
> +       for (i =3D 0; i < params->npages; i++)
> +               free_page((unsigned long)params->buf[i]);
> +
> +       sg_free_table(&params->sgt);
> +
> +       kfree(params->buf);
> +       kfree(params);
> +}
> +
> +static void dma_sg_map_benchmark_prepare_data(void *mparam)
> +{
> +       struct dma_sg_map_param *params =3D mparam;
> +       struct scatterlist *sg;
> +       int i =3D 0;
> +
> +       if (params->dma_dir =3D=3D DMA_FROM_DEVICE)
> +               return;
> +
> +       for_each_sgtable_sg(&params->sgt, sg, i)
> +               memset(params->buf[i], 0x66, PAGE_SIZE);
> +}
> +
> +static int dma_sg_map_benchmark_do_map(void *mparam)
> +{
> +       struct dma_sg_map_param *params =3D mparam;
> +       int ret =3D 0;
> +
> +       int sg_mapped =3D dma_map_sg(params->dev, params->sgt.sgl,
> +                                  params->npages, params->dma_dir);
> +       if (!sg_mapped) {
> +               pr_err("dma_map_sg failed on %s\n", dev_name(params->dev)=
);
> +               ret =3D -ENOMEM;
> +       }
> +
> +       return ret;
> +}
> +
> +static void dma_sg_map_benchmark_do_unmap(void *mparam)
> +{
> +       struct dma_sg_map_param *params =3D mparam;
> +
> +       dma_unmap_sg(params->dev, params->sgt.sgl, params->npages,
> +                    params->dma_dir);
> +}
> +
> +static struct map_benchmark_ops dma_sg_map_benchmark_ops =3D {
> +       .prepare =3D dma_sg_map_benchmark_prepare,
> +       .unprepare =3D dma_sg_map_benchmark_unprepare,
> +       .prepare_data =3D dma_sg_map_benchmark_prepare_data,

Instead of using both prepare and prepare_data, which are ambiguous,
it would be better to rename prepare_data to initialize_data.

Thanks
Barry
