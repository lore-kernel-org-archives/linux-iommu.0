Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F641F507
	for <iommu@lists.linux.dev>; Fri,  9 May 2025 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746762105; cv=none; b=Wko3XwhHma36HE7stpdUeatUVkig1v8rCc1euaM41yFGQpHOhKhXKeaf3hV1FfdP+8OhkSwDRlag30o/5nfU7IFL0fnuU1hCesl8/hw/bFDMAHmxjRBtUTjQ02EswBpRu5cQN//yTxRiF3DpVznFL/NlX5czzTHcJGJtttz0WAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746762105; c=relaxed/simple;
	bh=ARB54YDrGslElmmieC1dWlSnereaS+9XpQlvMSdPz+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgDK2UbJlHvDbPEibA426Jn4GiEBNuQFpmBe3DBnWpNuF0gdF8OMzf6U2PgusFxVNOAllAWUTpHgGVfDWwn5+LU8wYkwICga6l1cn5VRWmX+Gj0x2NPq/a4KoqGT0OyJUN9D3Jf62v/i3MP7+xPdxm6dMWEMcukXOGcAtp0zE7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxT4EUil; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxT4EUil"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4c325981002so548061137.3
        for <iommu@lists.linux.dev>; Thu, 08 May 2025 20:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746762102; x=1747366902; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TD4r662HPGkqrB2RFNkD8ouqrc7R9+3ahwBRVHPxv5g=;
        b=BxT4EUilnvcjUfd8jOlEcmDDHtMeeQoabB1coZPxthvdKoM/nljV82JWD0r0+dysy3
         2v3osMW/J8RBTV+NM4VezU/k0H2OLfi+I1RFvHjcgOq73e/xj/EdmgvHCiFLZl7WrzqL
         XzOtWe+eepSWXJ2fOWc3WJq628AFA3zhD1oFpwDBLie6PUXPjA9fwmfFPT/lbGRcP2cc
         4vkbsA+Vnk36hQ5pdfawzxHA8XEBjHElkXBD8dTJWqp/PrXTw7urH0gRpBlFL+KcL8dC
         W2XTYkGjW7W+Hce57I+KPoWax7WeQ3Xjqj/STrB8EkeppSUEEicQKQwC47nOyrR5OcTd
         Ln8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746762102; x=1747366902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TD4r662HPGkqrB2RFNkD8ouqrc7R9+3ahwBRVHPxv5g=;
        b=a64yqGG4tFyRX/WiKu6glW9Q1QURKDilAkkUCZrr4eCm/N2itccIU1dfk/lbILrXfl
         7WdsMGgf5jcwPRFh86kVyQYKvRuFntAFE+R0j3rWSUhs3dDg3JI+ZgvvcDrdrett9ZGk
         TBRZjT82Gyq8nweVdI2Z1Z8MUndvqhKzQFtwc57PeJ1LC77sHjY+Gs97hGGDxxFtMrVH
         TQg9K+FpmCzsvEyMEdIkE9TgOwiAQTPs4Bzthy/jGukPL9yCOSANqbsCUVF8jkHloGQu
         HRE7UgtZlXUWG8o4EAY6ht+Px0NykT/6TCL7Zu5ifRaqt8FdcsEq2Zbt2qGLj2+Quu9s
         Cl1w==
X-Forwarded-Encrypted: i=1; AJvYcCVX+7MrmnOKuxahK/AMnMx83K+rHzSAVq2c1NUd2epXpB6/EvzVuhdL6QrZ0zAWfAqJkcuZDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgUz6G6l89y7x6HC9Ad9NJBzfN0/F/PoDCSI3abGc3C5BxtfTl
	dTUrz5MvdLmGfarqIIqsHvHZ2W/P7CxceP7fRLzoqu/MM8gAYX/8G5t9jZhjmX6+hvaUNT2P6o1
	iRFygyOuUW+CyIc8Y5mxt0gyCiRg=
X-Gm-Gg: ASbGncvums4MYQkLokQVFwQdXfuJzb1PirTJE+fA+Iasg9DqkgsNgi79hF/0xMde9kB
	yTzHaUp9k0ziCLjXDUgkNhPHs7qYPQiciMs62Df48J37WMa5u/YNJV2+CeXfisLBKKhhT5n6rfx
	KWqQrq9JocqzTExfGQEUtt7Q==
X-Google-Smtp-Source: AGHT+IF75RwFThbsKChym3aI6TPaEKrrBkh65O/mRqjgySJ6N255FnbhHv2Tuj5RoLaSA5qsxj64wjTEvR+uUZ2L4V8=
X-Received: by 2002:a05:6102:5e97:b0:4c5:1c2e:79f5 with SMTP id
 ada2fe7eead31-4deed3cbab5mr1849166137.16.1746762102023; Thu, 08 May 2025
 20:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250509020238.3378396-1-xiaqinxin@huawei.com> <20250509020238.3378396-3-xiaqinxin@huawei.com>
In-Reply-To: <20250509020238.3378396-3-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 9 May 2025 15:41:31 +1200
X-Gm-Features: AX0GCFuB48vrcdnnCZmO_2nSDqx3mdCAtJEfsOiM6mmty92yGKXhbSGyZ9OWbMY
Message-ID: <CAGsJ_4xmC5wP9ut7X6cj72xq1qNGdVCC==8c9FQpd3SbCQ-iNw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] dma-mapping: benchmark: modify the framework to
 adapt to more map modes
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
> In some service scenarios, the performance of dma_map_sg needs to be
> tested to support different map modes for benchmarks. This patch adjusts
> the DMA map benchmark framework to make the DMA map benchmark framework
> more flexible and adaptable to other mapping modes in the future.
> By abstracting the framework into four interfaces:prepare, unprepare,
> do_map, and do_unmap.The new map schema can be introduced more easily
> without major modifications to the existing code structure.
>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>

- stable@vger.kernel.org
+ Marek
+ Robin,

Once the minor issues below are addressed, feel free to add:

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  include/linux/map_benchmark.h |   8 ++-
>  kernel/dma/map_benchmark.c    | 122 +++++++++++++++++++++++++++-------
>  2 files changed, 106 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.=
h
> index 2ac2fe52f248..5294dfd1870f 100644
> --- a/include/linux/map_benchmark.h
> +++ b/include/linux/map_benchmark.h
> @@ -15,6 +15,11 @@
>  #define DMA_MAP_TO_DEVICE       1
>  #define DMA_MAP_FROM_DEVICE     2
>
> +enum {
> +       DMA_MAP_SINGLE_MODE,
> +       DMA_MAP_MODE_MAX
> +};

Using a more specific namespace=E2=80=94such as DMA_MAP_BENCH_SINGLE_MODE
and DMA_MAP_BENCH_MODE_MAX=E2=80=94would help avoid potential naming
conflicts.

> +
>  struct map_benchmark {
>         __u64 avg_map_100ns; /* average map latency in 100ns */
>         __u64 map_stddev; /* standard deviation of map latency */
> @@ -27,6 +32,7 @@ struct map_benchmark {
>         __u32 dma_dir; /* DMA data direction */
>         __u32 dma_trans_ns; /* time for DMA transmission in ns */
>         __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a ti=
me */
> -       __u8 expansion[76];     /* For future use */
> +       __u8  map_mode; /* the mode of dma map */
> +       __u8 expansion[75];     /* For future use */
>  };
>  #endif /* _KERNEL_DMA_BENCHMARK_H */
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index cc19a3efea89..47a06b891db8 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -5,6 +5,7 @@
>
>  #define pr_fmt(fmt)    KBUILD_MODNAME ": " fmt
>
> +#include <linux/cleanup.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> @@ -31,17 +32,99 @@ struct map_benchmark_data {
>         atomic64_t loops;
>  };
>
> +struct map_benchmark_ops {
> +       void *(*prepare)(struct map_benchmark_data *map);
> +       void (*unprepare)(void *mparam);
> +       int (*do_map)(void *mparam);
> +       void (*do_unmap)(void *mparam);
> +};
> +
> +struct dma_single_map_param {
> +       struct device *dev;
> +       dma_addr_t addr;
> +       void *xbuf;
> +       u32 npages;
> +       u32 dma_dir;
> +};
> +
> +static void *dma_single_map_benchmark_prepare(struct map_benchmark_data =
*map)
> +{
> +       struct dma_single_map_param *params __free(kfree) =3D kzalloc(siz=
eof(*params),
> +                                                                   GFP_K=
ERNEL);
> +       if (!params)
> +               return NULL;
> +
> +       params->npages =3D map->bparam.granule;
> +       params->dma_dir =3D map->bparam.dma_dir;
> +       params->dev =3D map->dev;
> +       params->xbuf =3D alloc_pages_exact(params->npages * PAGE_SIZE, GF=
P_KERNEL);
> +       if (!params->xbuf)
> +               return NULL;
> +
> +       /*
> +        * for a non-coherent device, if we don't stain them in the
> +        * cache, this will give an underestimate of the real-world
> +        * overhead of BIDIRECTIONAL or TO_DEVICE mappings;
> +        * 66 means evertything goes well! 66 is lucky.
> +        */
> +       if (params->dma_dir !=3D DMA_FROM_DEVICE)
> +               memset(params->xbuf, 0x66, params->npages * PAGE_SIZE);
> +
> +       return_ptr(params);
> +}
> +
> +static void dma_single_map_benchmark_unprepare(void *mparam)
> +{
> +       struct dma_single_map_param *params =3D mparam;
> +
> +       free_pages_exact(params->xbuf, params->npages * PAGE_SIZE);
> +       kfree(params);
> +}
> +
> +static int dma_single_map_benchmark_do_map(void *mparam)
> +{
> +       struct dma_single_map_param *params =3D mparam;
> +       int ret =3D 0;
> +
> +       params->addr =3D dma_map_single(params->dev, params->xbuf,
> +                                     params->npages * PAGE_SIZE, params-=
>dma_dir);
> +       if (unlikely(dma_mapping_error(params->dev, params->addr))) {
> +               pr_err("dma_map_single failed on %s\n", dev_name(params->=
dev));
> +               ret =3D -ENOMEM;
> +       }
> +
> +       return ret;
> +}
> +
> +static void dma_single_map_benchmark_do_unmap(void *mparam)
> +{
> +       struct dma_single_map_param *params =3D mparam;
> +
> +       dma_unmap_single(params->dev, params->addr,
> +                        params->npages * PAGE_SIZE, params->dma_dir);
> +}
> +
> +static struct map_benchmark_ops dma_single_map_benchmark_ops =3D {
> +       .prepare =3D dma_single_map_benchmark_prepare,
> +       .unprepare =3D dma_single_map_benchmark_unprepare,
> +       .do_map =3D dma_single_map_benchmark_do_map,
> +       .do_unmap =3D dma_single_map_benchmark_do_unmap,
> +};
> +
> +static struct map_benchmark_ops *dma_map_benchmark_ops[DMA_MAP_MODE_MAX]=
 =3D {
> +       [DMA_MAP_SINGLE_MODE] =3D &dma_single_map_benchmark_ops,
> +};
> +
>  static int map_benchmark_thread(void *data)
>  {
> -       void *buf;
> -       dma_addr_t dma_addr;
>         struct map_benchmark_data *map =3D data;
> -       int npages =3D map->bparam.granule;
> -       u64 size =3D npages * PAGE_SIZE;
> +       __u8 map_mode =3D map->bparam.map_mode;
>         int ret =3D 0;
>
> -       buf =3D alloc_pages_exact(size, GFP_KERNEL);
> -       if (!buf)
> +       struct map_benchmark_ops *mb_ops =3D dma_map_benchmark_ops[map_mo=
de];
> +       void *mparam =3D mb_ops->prepare(map);
> +
> +       if (!mparam)
>                 return -ENOMEM;
>
>         while (!kthread_should_stop())  {
> @@ -49,23 +132,10 @@ static int map_benchmark_thread(void *data)
>                 ktime_t map_stime, map_etime, unmap_stime, unmap_etime;
>                 ktime_t map_delta, unmap_delta;
>
> -               /*
> -                * for a non-coherent device, if we don't stain them in t=
he
> -                * cache, this will give an underestimate of the real-wor=
ld
> -                * overhead of BIDIRECTIONAL or TO_DEVICE mappings;
> -                * 66 means evertything goes well! 66 is lucky.
> -                */
> -               if (map->dir !=3D DMA_FROM_DEVICE)
> -                       memset(buf, 0x66, size);
> -
>                 map_stime =3D ktime_get();
> -               dma_addr =3D dma_map_single(map->dev, buf, size, map->dir=
);
> -               if (unlikely(dma_mapping_error(map->dev, dma_addr))) {
> -                       pr_err("dma_map_single failed on %s\n",
> -                               dev_name(map->dev));
> -                       ret =3D -ENOMEM;
> +               ret =3D mb_ops->do_map(mparam);
> +               if (ret)
>                         goto out;
> -               }
>                 map_etime =3D ktime_get();
>                 map_delta =3D ktime_sub(map_etime, map_stime);
>
> @@ -73,7 +143,8 @@ static int map_benchmark_thread(void *data)
>                 ndelay(map->bparam.dma_trans_ns);
>
>                 unmap_stime =3D ktime_get();
> -               dma_unmap_single(map->dev, dma_addr, size, map->dir);
> +               mb_ops->do_unmap(mparam);
> +
>                 unmap_etime =3D ktime_get();
>                 unmap_delta =3D ktime_sub(unmap_etime, unmap_stime);
>
> @@ -108,7 +179,7 @@ static int map_benchmark_thread(void *data)
>         }
>
>  out:
> -       free_pages_exact(buf, size);
> +       mb_ops->unprepare(mparam);
>         return ret;
>  }
>
> @@ -209,6 +280,11 @@ static long map_benchmark_ioctl(struct file *file, u=
nsigned int cmd,
>
>         switch (cmd) {
>         case DMA_MAP_BENCHMARK:
> +               if (map->bparam.map_mode >=3D DMA_MAP_MODE_MAX) {
> +                       pr_err("invalid map mode\n");
> +                       return -EINVAL;
> +               }
> +
>                 if (map->bparam.threads =3D=3D 0 ||
>                     map->bparam.threads > DMA_MAP_MAX_THREADS) {
>                         pr_err("invalid thread number\n");
> --
> 2.33.0
>

Thanks
Barry
