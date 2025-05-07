Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCA670824
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 02:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746585020; cv=none; b=Ufn80mKdzmZ319G2OoO+4WMzktY8y8c2eXQAR4kxmJj3R4seL7iglYt2kTpuANLKHjrqnojZaeorwp5i7L6kZCzLwjfOKjPBK1g/tuKc3nqQx3waatgWY0tQuLn3Jmeqfyor6RM64kOvgkZCLgfkrWYTaNF52TZvGez9b2Bd2oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746585020; c=relaxed/simple;
	bh=SznfOR6U7IN2g/iqV6jv8KKSpwQxBIwzXtZCsVeUWAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/aRDe/tQlbzbxfp303pOyFlUBjArqjgqIUbtx5lEyju9yV3lETm6vL+m9QbxcH2MU2BOUkfGzLHrtPqHdSzP/gt7Sh5JqSbr44ULzqxn/atLVoL27keXXjVEJJMF8lVY7aC6K8qF8XuZWB46VrHRUrPvtA4JGIyE4nJaIC4x1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+1tR6kq; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+1tR6kq"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-523eb86b31aso1889401e0c.0
        for <iommu@lists.linux.dev>; Tue, 06 May 2025 19:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746585016; x=1747189816; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4svO715lvCEPXXLLCM+oy1RnywJCznU/v/M9mAtCezc=;
        b=Q+1tR6kqiea4H9Q/aezN2GaBrIOIgDddFY2gKQEy+nU9gfoZhHkP4jGhjEeBAQC1VW
         ubJkWwf6GHYs4lL5x8LhRILJXE1MbSTD6dWLS+PRTCQ+kFJ0iIdWaGSZ8tTv1F8oKaaq
         ElLzaGRVYb+PKn3A34iG2Q84BntqTNClYBa+Y908hNRlNxw8elLKhCXuqrg3VIImN2Us
         PZOrptj9ohEzHJU9ou6w+zhpQ8iV964Bw37OMy1Z2IWz/1Yozk829KshnJOyz6RU7uUq
         dBXSZGGDQx8BcJWDgXPJWvzGIVip6rT44cPdLqq4+gMzwOuEE3YYlcMO3A+d7L3bDvkK
         s5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746585016; x=1747189816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4svO715lvCEPXXLLCM+oy1RnywJCznU/v/M9mAtCezc=;
        b=KEKyatjL1ELAqCYBZtP3Tm1qGmc+QsOd7hdi/7LpYGOhG/YS48W6y/Km3tZI+E9Ng3
         950sFgVDE4vUll9Mlsgxsbu0B3MebdpS0U3C928af6w0NQ40GAJbCE/90nvT/NeT2d5f
         WJFUXxy2nqHmu2H+l+s3CgET1RzHgFcqXwGRBT0DU1F847QTODNRPbcvPkyLjPSE8nvy
         zlfryTdYMGhXqTtStVSoGW+tM7wsZmQBGrjCjdRwNLOthaS0U/Hz1qUx/hVW4g7ynOKo
         YJp/CrJd67qhYBJfWLl6INLuBr+DCKOW1B8VvBOi0JzEfm7ugKdwnBNk2noloOG8kF4D
         mR2w==
X-Forwarded-Encrypted: i=1; AJvYcCXnLa38YlMiczI3rZOUnH0wzsF48JAHUKAM7LEu4aoRVib2MAuicJgTk25r3aGe8jzbd3AATA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbUnaFzOm2w94GBWhKS0KX1i5H7qdIXrbQjE2hUaQPxFp1mNk5
	mpssi/JljJ7my+SMYDXKdF5QyRo0BF2cGrwomtmOY5hKTPZDPdkdF2SQepPpLD7/DJerYZOLh85
	+wXxiTO61jWuW9TxxMVFG85VaboA=
X-Gm-Gg: ASbGncv4OkL5qPFcXQflrfhRRFjNBcSu/N/UHlKiRm2JdcuUmknmOCTLl8XTEQRkSZk
	ikxUA4JSkzWFZfK44vTGHsdt33oXeW3ivPGf01+xXcNL7PazAV+K34OHzKOAmZ3fl+EVoHVDiwt
	igDYGm0+q8f4AQpy5lsko6tw==
X-Google-Smtp-Source: AGHT+IEdQ8qJRTe3nOcdVAGg66QPjgTWfepYf4RI/zrUWt73Ue904nbTHGUgW/makM6++UBpB7AgjR6Rg5Wfo7eSQ3c=
X-Received: by 2002:a05:6102:3f8f:b0:4db:154b:cb3b with SMTP id
 ada2fe7eead31-4dc73798314mr1541637137.3.1746585016544; Tue, 06 May 2025
 19:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250506030100.394376-1-xiaqinxin@huawei.com> <20250506030100.394376-3-xiaqinxin@huawei.com>
In-Reply-To: <20250506030100.394376-3-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 7 May 2025 14:30:05 +1200
X-Gm-Features: ATxdqUFNaSx8vLRgaXQvYHswVMU1YW8ewJcP9JYFNqr9iEGTSzlrviy0h9P2_qY
Message-ID: <CAGsJ_4wgxgXs6pyYUTNFmNmqHSWtPbKSUnMCzf8=rvOdhgJ04Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dma mapping benchmark: modify the framework to
 adapt to more map modes
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: yangyicong@huawei.com, hch@lst.de, iommu@lists.linux.dev, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 3:01=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> wr=
ote:
>
> In this patch map_benchmark abstract in four interface: prepare, unprepar=
e,
> do_map, do_unmap. When there's a new mode to add, need four steps:
> 1) Add the mode in map_benchmark.h
> 2) Defines the mode param, like struct dma_xxx_map_param, and this object
>    will be return in prepare and as input parameter in other ops;
> 3) Defines the ops functions:prepare, unprepare, do_map, do_unmap.
> 4) Add the new mode in dma_map_benchmark_ops.

There are too many irrelevant details.

We're more interested in the reasoning behind this change than just the cha=
nge
itself. There should be some explanation of the purpose.

>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>  include/linux/map_benchmark.h |   8 ++-
>  kernel/dma/map_benchmark.c    | 120 +++++++++++++++++++++++++++-------
>  2 files changed, 104 insertions(+), 24 deletions(-)
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
> index cc19a3efea89..f04973eba1d8 100644
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
> @@ -31,17 +32,97 @@ struct map_benchmark_data {
>         atomic64_t loops;
>  };
>
> +struct map_benchmark_ops {
> +       void *(*prepare)(struct map_benchmark_data *map);
> +       void (*unprepare)(void *arg);
> +       int (*do_map)(void *arg);
> +       void (*do_unmap)(void *arg);
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
> +       struct dma_single_map_param *mparam __free(kfree) =3D kzalloc(siz=
eof(*mparam),
> +                                                                   GFP_K=
ERNEL);
> +       if (!mparam)
> +               return NULL;
> +
> +       mparam->npages =3D map->bparam.granule;
> +       mparam->dma_dir =3D map->bparam.dma_dir;
> +       mparam->dev =3D map->dev;
> +       mparam->xbuf =3D alloc_pages_exact(mparam->npages * PAGE_SIZE, GF=
P_KERNEL);
> +       if (!mparam->xbuf)
> +               return NULL;
> +
> +       /*
> +        * for a non-coherent device, if we don't stain them in the
> +        * cache, this will give an underestimate of the real-world
> +        * overhead of BIDIRECTIONAL or TO_DEVICE mappings;
> +        * 66 means evertything goes well! 66 is lucky.
> +        */
> +       if (mparam->dma_dir !=3D DMA_FROM_DEVICE)
> +               memset(mparam->xbuf, 0x66, mparam->npages * PAGE_SIZE);
> +
> +       return_ptr(mparam);
> +}
> +
> +static void dma_single_map_benchmark_unprepare(void *arg)
> +{
> +       struct dma_single_map_param *mparam =3D arg;
> +
> +       free_pages_exact(mparam->xbuf, mparam->npages * PAGE_SIZE);
> +       kfree(mparam);
> +}
> +
> +static int dma_single_map_benchmark_do_map(void *arg)
> +{
> +       struct dma_single_map_param *mparam =3D arg;
> +
> +       mparam->addr =3D dma_map_single(mparam->dev, mparam->xbuf,
> +                                     mparam->npages * PAGE_SIZE, mparam-=
>dma_dir);
> +       if (unlikely(dma_mapping_error(mparam->dev, mparam->addr))) {
> +               pr_err("dma_map_single failed on %s\n", dev_name(mparam->=
dev));
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static void dma_single_map_benchmark_do_unmap(void *arg)
> +{
> +       struct dma_single_map_param *mparam =3D arg;
> +
> +       dma_unmap_single(mparam->dev, mparam->addr,
> +                        mparam->npages * PAGE_SIZE, mparam->dma_dir);
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
> +       void *arg =3D dma_map_benchmark_ops[map_mode]->prepare(map);

It's a bit awkward. Let's try something like this instead:

struct map_benchmark_ops *mb_ops =3D &dma_map_benchmark_ops[map_mode];

then
mb_ops->prepare()/map/unmap/unprepare etc.

And can you find a better name than "arg" which is meaningless, mparam?

> +
> +       if (!arg)
>                 return -ENOMEM;
>
>         while (!kthread_should_stop())  {
> @@ -49,23 +130,10 @@ static int map_benchmark_thread(void *data)
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
> +               ret =3D dma_map_benchmark_ops[map_mode]->do_map(arg);
> +               if (ret)
>                         goto out;
> -               }
>                 map_etime =3D ktime_get();
>                 map_delta =3D ktime_sub(map_etime, map_stime);
>
> @@ -73,7 +141,8 @@ static int map_benchmark_thread(void *data)
>                 ndelay(map->bparam.dma_trans_ns);
>
>                 unmap_stime =3D ktime_get();
> -               dma_unmap_single(map->dev, dma_addr, size, map->dir);
> +               dma_map_benchmark_ops[map_mode]->do_unmap(arg);
> +
>                 unmap_etime =3D ktime_get();
>                 unmap_delta =3D ktime_sub(unmap_etime, unmap_stime);
>
> @@ -108,7 +177,7 @@ static int map_benchmark_thread(void *data)
>         }
>
>  out:
> -       free_pages_exact(buf, size);
> +       dma_map_benchmark_ops[map_mode]->unprepare(arg);
>         return ret;
>  }
>
> @@ -209,6 +278,11 @@ static long map_benchmark_ioctl(struct file *file, u=
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
