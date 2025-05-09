Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DEE1372
	for <iommu@lists.linux.dev>; Fri,  9 May 2025 03:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746762744; cv=none; b=NTLgjbYqQIv/YA9/7bGlJ8VldoK8ies88VYjcuzMeF1uxCAt89WrduzndggLx7tEpzEiKjvpVzf/7K5R+SEqCLTQCIO3wBaFqHtCMZL4WmVolKmo5aOTRWSHhwWicKobIBu8XoqJDlBRSih4as8f2cKiIMewvjEgWHFBPgSKtYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746762744; c=relaxed/simple;
	bh=/rk0S+po0CpMnRGbNZnCyaDZ1IpsqAh1t7Yg4UItnTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jx8bqNoD2ta3D0ypst2sK92uqbHfwFZCDqr3EcJ2d32UdMRLF9KozgthojN4/+J3JGnjmbFImbC31powEf5IrJFX0gIDVS4pR6d7b64B0KimT/feYnGPY0437a65EmJcTQlQgOiNSC0/1RqhOuDoRYQILo/dcn08dRvcPp71gcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDqhwlVd; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDqhwlVd"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-879467794efso894813241.3
        for <iommu@lists.linux.dev>; Thu, 08 May 2025 20:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746762741; x=1747367541; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZtJpHVIJ93K8uv3nzoIfCvHtR5OdEc9EX11A6Us4YM=;
        b=aDqhwlVdaKv9FgDib4LG5s84h7MbmuovwCcHkI/mkKsS2pWZaOzCEMQ3HKWUMrONah
         3zPBQm7ZhYYU8YQnCVpGNszkr0kkSOMefpUdyJTh2wvJO75nOmrYyrlD1EmOxJeb2S6o
         GT0MYyIwxNhzr6R42qTpZ7qvj0Htp8Xw5Cldf7HUxzjNRn/smCKGqZl3JNakSbYIupql
         XUB3qHar2Ncgz98lI/Cmb5ErnKFLF89EPo9BLcxrzYSy133f20wucGfHBigeftkexJgF
         L5SRfTR9OtrjG+aZZlHFnZUXpXh9N/YInKteuVK2z+03Mo63UQ9YXXckz48FAZ5Mn5vv
         XqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746762741; x=1747367541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZtJpHVIJ93K8uv3nzoIfCvHtR5OdEc9EX11A6Us4YM=;
        b=qXds2sCz8iAlGYHLbYS631DZtNKRhxFlmDY4kXRFEI4z6fS5Brs6EBDDKk6avD6vly
         LqlpMPuJhHgUqAzaq5coEBsrUuAR+xXEWW1CAqSf8A0ME7OjMrXiLdoNl6CmEkd/94/8
         hoeanAf7V8Qcix0BqfbPfT8luQZzZVh8jNNIXm0jDXqY22PJ5Fqzf+MaJgJCs2atJlFH
         YS/tciYUK1lieMiWzHGbAtEKGjrN6CtI+rSoJ9sKyWGKyrvpvd1W78L/Wh2T0MFPNY3U
         52LN5RyJIYarq6yOyZQrOWtE5RtiBrHCew2PagHtSWC/+PWdYz+LncUujUMBIrz80/lk
         S26w==
X-Forwarded-Encrypted: i=1; AJvYcCWvCCy7axPzN58VQF4lsW+ejtTC5abNaztlsoy4Ck7R06J6lyufu0EEKjSNcYop+EwOpV5dBw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcOy5+qzKKwJ4qOCTo4hIUxNgFvIHEqVwGty07YQkNzhAccItr
	fsejLENfSaDtU4LTgSOxEzbOBlIbeGxdp9dT4Av4Tu6Juw7IGMlQBvpGN3k/6ceyEftlUjTZwz8
	zUoqyR8fLYlje/wNM732ORR8Y/S/f8GBH
X-Gm-Gg: ASbGnctZ+62bbJO//vTKjPgwgIyTRAWAxv00rijhXGSYM2V/usfKarHXmSXIoGhowb1
	YV/seXsQe7wlkazkdOc0lYBR+BMMz0dPZ3Bw3HPIgZ+3sirfVhkb2T+mE+ihg+CuVTdkizSo8H1
	UALJyUDsLfhFGZfqc5P7VXByNPiAbHKcJb
X-Google-Smtp-Source: AGHT+IF/FZbeR1JzSQGpji4YArl8egk9e/tJo4Cdye8RmX0cu/HaSz/KiEG4E6WHjuAGaZcp6ELLuyTEOBTAEV5jUFM=
X-Received: by 2002:a05:6122:7d0:b0:529:2644:676f with SMTP id
 71dfb90a1353d-52c53dc0a0cmr2047694e0c.8.1746762693593; Thu, 08 May 2025
 20:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250509020238.3378396-1-xiaqinxin@huawei.com> <20250509020238.3378396-4-xiaqinxin@huawei.com>
In-Reply-To: <20250509020238.3378396-4-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 9 May 2025 15:51:22 +1200
X-Gm-Features: AX0GCFthyNPpdDu5Qsc5jKRSeqqB30O-QqH6KuGTdMdJ0WSfXKss_x2Eew6SNcQ
Message-ID: <CAGsJ_4xOX6Rnz7nrd3ZRCzjaTzqmvWoWQNq4JzfXRhwRKkPJjw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dma-mapping: benchmark: add support for dma_map_sg
To: Qinxin Xia <xiaqinxin@huawei.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: yangyicong@huawei.com, hch@lst.de, iommu@lists.linux.dev, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 2:02=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> wr=
ote:
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
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>

- stable@vger.kernel.org
+ Marek
+ Robin,

Once the minor issues below are addressed, feel free to add:

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  include/linux/map_benchmark.h |  43 ++++++++++----
>  kernel/dma/map_benchmark.c    | 103 ++++++++++++++++++++++++++++++++++
>  2 files changed, 134 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.=
h
> index 5294dfd1870f..bf8c9ade43fd 100644
> --- a/include/linux/map_benchmark.h
> +++ b/include/linux/map_benchmark.h
> @@ -17,22 +17,41 @@
>
>  enum {
>         DMA_MAP_SINGLE_MODE,
> +       DMA_MAP_SG_MODE,
>         DMA_MAP_MODE_MAX

DMA_MAP_BENCH_ ...

>  };
>
> +/**
> + * struct map_benchmark - Benchmarking data for DMA mapping operations.
> + * @avg_map_100ns: Average map latency in 100ns.
> + * @map_stddev: Standard deviation of map latency.
> + * @avg_unmap_100ns: Average unmap latency in 100ns.
> + * @unmap_stddev: Standard deviation of unmap latency.
> + * @threads: Number of threads performing map/unmap operations in parall=
el.
> + * @seconds: Duration of the test in seconds.
> + * @node: NUMA node on which this benchmark will run.
> + * @dma_bits: DMA addressing capability.
> + * @dma_dir: DMA data direction.
> + * @dma_trans_ns: Time for DMA transmission in ns.
> + * @granule: Number of PAGE_SIZE units to map/unmap at once.
> +            In SG mode, this represents the number of scatterlist entrie=
s.
> +            In single mode, this represents the total size of the mappin=
g.
> + * @map_mode: Mode of DMA mapping.
> + * @expansion: Reserved for future use.
> + */
>  struct map_benchmark {
> -       __u64 avg_map_100ns; /* average map latency in 100ns */
> -       __u64 map_stddev; /* standard deviation of map latency */
> -       __u64 avg_unmap_100ns; /* as above */
> +       __u64 avg_map_100ns;
> +       __u64 map_stddev;
> +       __u64 avg_unmap_100ns;
>         __u64 unmap_stddev;
> -       __u32 threads; /* how many threads will do map/unmap in parallel =
*/
> -       __u32 seconds; /* how long the test will last */
> -       __s32 node; /* which numa node this benchmark will run on */
> -       __u32 dma_bits; /* DMA addressing capability */
> -       __u32 dma_dir; /* DMA data direction */
> -       __u32 dma_trans_ns; /* time for DMA transmission in ns */
> -       __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a ti=
me */
> -       __u8  map_mode; /* the mode of dma map */
> -       __u8 expansion[75];     /* For future use */
> +       __u32 threads;
> +       __u32 seconds;
> +       __s32 node;
> +       __u32 dma_bits;
> +       __u32 dma_dir;
> +       __u32 dma_trans_ns;
> +       __u32 granule;
> +       __u8  map_mode;
> +       __u8 expansion[75];
>  };
>  #endif /* _KERNEL_DMA_BENCHMARK_H */
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 47a06b891db8..3a996be9fb22 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> +#include <linux/scatterlist.h>
>  #include <linux/slab.h>
>  #include <linux/timekeeping.h>
>
> @@ -111,8 +112,110 @@ static struct map_benchmark_ops dma_single_map_benc=
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
> +       struct dma_sg_map_param *params __free(kfree) =3D kzalloc(sizeof(=
*params), GFP_KERNEL);
> +       if (!params)
> +               return NULL;
> +
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
> +               if (params->dma_dir !=3D DMA_FROM_DEVICE)
> +                       memset(params->buf[i], 0x66, PAGE_SIZE);
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
> +       .do_map =3D dma_sg_map_benchmark_do_map,
> +       .do_unmap =3D dma_sg_map_benchmark_do_unmap,
> +};
> +
>  static struct map_benchmark_ops *dma_map_benchmark_ops[DMA_MAP_MODE_MAX]=
 =3D {
>         [DMA_MAP_SINGLE_MODE] =3D &dma_single_map_benchmark_ops,
> +       [DMA_MAP_SG_MODE] =3D &dma_sg_map_benchmark_ops,
>  };
>
>  static int map_benchmark_thread(void *data)
> --
> 2.33.0
>
