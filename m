Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A0B238D3B
	for <iommu@lists.linux.dev>; Mon, 17 Feb 2025 20:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739825960; cv=none; b=pHoe4oodgdTzCkx02p2pRiZFixalDQan4CWxV4sFXgCku7S16MvV5M5Exuc1SNfcV2empxAhzsRggZjeHW0JNqqQDN5Qi4w8q6RCxkhZa1DrJpQkK8rXeHwFVB5uE53efFQlXHxwI9dsvbFaB7ghsr5+heVncPXriCOT373qhOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739825960; c=relaxed/simple;
	bh=WuU8p6064CgpWvovK2DNE1efAG5dEUZEugUzVJuJNg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJU//uTDqXhtxYItFlssE07bdt8iX2HI/MNI6k/0ZcG+8qcwvFWbC0usoLsw/RxqUoqQVMiqspRHr9G3fgUuRJLXjZ0ISdqG/kiJ/4gE8wkqj1AHZrcH9UVrEp74D4ED5X8Gsj8BCIwHT8H8V+gsAxqyYdPRXKy1YzXKO30s5ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncBaSJXx; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncBaSJXx"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4ba0eb3b0f9so1231618137.0
        for <iommu@lists.linux.dev>; Mon, 17 Feb 2025 12:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739825956; x=1740430756; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gN9C6GJ3vbuBk+DYa6AYbjdNka3yXQK1xjjdcHzYn2Q=;
        b=ncBaSJXx4p5dlOV+aelmZMhwgs2zBhZ0++bz5ZxCutwWg/+r6MqVGGO/x71UcbavVt
         qvStqW/vDBKbte5jRLm/Q3XVPGxH2B3OA0LUAKO1s+TAx8HlgK4YeUfKs3gXxaDrii+s
         ethVIECXkf7erHhQxd8yVt4Nns7WwOWvjGevkRs5czCiRgsrn4mIWutne0YY5jIKZonn
         CYTjDWlKYCYqz4wftwY6SF/zepMyBtASgtOiL5Zh4S+XyFPxYSUrwDxBo9HObo0qwINg
         FyIVXkWMLPDWJaru0wSH6nmvJb1o5FgOHVGxmWSgrpPfROpkFEAu00jvDBlZNvUlVr/c
         QRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739825956; x=1740430756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gN9C6GJ3vbuBk+DYa6AYbjdNka3yXQK1xjjdcHzYn2Q=;
        b=nNv1y+FCWMpRz2tm0V9VxljsTbJL1iddNyQxkbj7e+PhAnKwQujW8u5JD7+uykxt8g
         RnJ+McX+NN9M3fJgJsFNF+q5JHsDXi3oYJEYWqbPjySLg6fz4AD9Ph3ZxW7uKJAkroSZ
         h89hAwsbN86suIJFTXu0Lgdud33xivstf3aBPBRShkisXK14uoXEFFmoH4T1jqLZEkRs
         uXgd1311bbnvQKk9/hLwVBNKdg6+sKS6Z3QOdPi3CNTze4YazyipMzS9JmRff6GNxBv7
         SLO/6tNLB96b8ofHEgOEa2tQhK9GNd5tB7Y8ypIyORDRXI1u8gMGCN5gAgQMDniTIWTO
         326A==
X-Forwarded-Encrypted: i=1; AJvYcCUjcXX/mnI8lZnogPx5tHpEXt/gv/hDoD6uDpEV+j2wISPJI6snAoqZQhKkD3sCAUNBxJRXqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKaYkmnTd/168yAtSazTFrO5J5piNvAT47NFqISG8v8BhZU/6v
	6apinN4slyJRyI6V7srYzoDP5Ceaeuu2lCqsllk/hUOK17GCVFVBHV05pZLG1GactNvmZqhLeBQ
	xOdb+NH6ehDZRAyKcfHjdXHAlP/g=
X-Gm-Gg: ASbGncuJNMfCIX41W/8sCKmN6Fd84V5EkQdM/LjWXHCJwV5RV56wBZS4NwUuKpLVuow
	sQ3Cp+/GRIs2UtqdidB6ImgOxNqxGWjoIyUzP26pUG5BufdmFmCA9102xKGgKhTgrAZ88fTvy
X-Google-Smtp-Source: AGHT+IFdaFX0/LJZFrJBYXEwXt2w/+z6Cc+X5KMG6NJcp3HawFYZtb+e5VkrS4tF5/vC93zwML9XTsstZR4xaLqSQxU=
X-Received: by 2002:a05:6102:26d6:b0:4bb:d7f0:6e70 with SMTP id
 ada2fe7eead31-4bd3fc60789mr4993862137.5.1739825956149; Mon, 17 Feb 2025
 12:59:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250212022718.1995504-1-xiaqinxin@huawei.com> <20250212022718.1995504-3-xiaqinxin@huawei.com>
In-Reply-To: <20250212022718.1995504-3-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 18 Feb 2025 09:59:05 +1300
X-Gm-Features: AWEUYZkaz_erMtIH_9ZSRhIBgB5LLNaeOovPv5qkk3rDjQ5IhCT-Wxr4Y907wiM
Message-ID: <CAGsJ_4yDBT4rJyG4-Ow4T3xLq8VujBjG+-uxjnWUm_vW1nzT_A@mail.gmail.com>
Subject: Re: [PATCH 2/3] dma-mapping: benchmark: add support for dma_map_sg
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: chenxiang66@hisilicon.com, yangyicong@huawei.com, hch@lst.de, 
	iommu@lists.linux.dev, jonathan.cameron@huawei.com, prime.zeng@huawei.com, 
	fanghao11@huawei.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 3:27=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
> Support for dma scatter-gather mapping and is intended for testing
> mapping performance. It achieves by introducing the dma_sg_map_param
> structure and related functions, which enable the implementation of
> scatter-gather mapping preparation, mapping, and unmapping operations.
> Additionally, the dma_map_benchmark_ops array is updated to include
> operations for scatter-gather mapping. This commit aims to provide
> a wider range of mapping performance test  to cater to different scenario=
s.

This benchmark is mainly designed to debug contention issues, such as IOMMU
TLB flushes or IOMMU driver bottlenecks. I don't fully understand how SG or
single will impact the evaluation of the IOMMU driver, making it unclear if=
 the
added complexity is justified.

Can you add some explanation on why single mode is not sufficient for profi=
ling
and improving IOMMU drivers?

>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>  include/linux/map_benchmark.h |   1 +
>  kernel/dma/map_benchmark.c    | 102 ++++++++++++++++++++++++++++++++++
>  2 files changed, 103 insertions(+)
>
> diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.=
h
> index 054db02a03a7..a9c1a104ba4f 100644
> --- a/include/linux/map_benchmark.h
> +++ b/include/linux/map_benchmark.h
> @@ -17,6 +17,7 @@
>
>  enum {
>         DMA_MAP_SINGLE_MODE,
> +       DMA_MAP_SG_MODE,
>         DMA_MAP_MODE_MAX
>  };
>
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index d8ec0ce058d8..b5828eeb3db7 100644
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
> @@ -111,8 +112,109 @@ static struct map_benchmark_ops dma_single_map_benc=
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
> +       int i =3D 0;
> +
> +       struct dma_sg_map_param *mparam __free(kfree) =3D kzalloc(sizeof(=
*mparam), GFP_KERNEL);
> +       if (!mparam)
> +               return NULL;
> +
> +       mparam->npages =3D map->bparam.granule;
> +       mparam->dma_dir =3D map->bparam.dma_dir;
> +       mparam->dev =3D map->dev;
> +       mparam->buf =3D kmalloc_array(mparam->npages, sizeof(*mparam->buf=
),
> +                                   GFP_KERNEL);
> +       if (!mparam->buf)
> +               goto err1;
> +
> +       if (sg_alloc_table(&mparam->sgt, mparam->npages, GFP_KERNEL))
> +               goto err2;
> +
> +       for_each_sgtable_sg(&mparam->sgt, sg, i) {
> +               mparam->buf[i] =3D (void *)__get_free_page(GFP_KERNEL);
> +               if (!mparam->buf[i])
> +                       goto err3;
> +
> +               if (mparam->dma_dir !=3D DMA_FROM_DEVICE)
> +                       memset(mparam->buf[i], 0x66, PAGE_SIZE);
> +
> +               sg_set_buf(sg, mparam->buf[i], PAGE_SIZE);
> +       }
> +
> +       return_ptr(mparam);
> +
> +err3:
> +       while (i-- > 0)
> +               free_page((unsigned long)mparam->buf[i]);
> +
> +       pr_err("dma_map_sg failed get free page on %s\n", dev_name(mparam=
->dev));
> +       sg_free_table(&mparam->sgt);
> +err2:
> +       pr_err("dma_map_sg failed alloc sg table on %s\n", dev_name(mpara=
m->dev));
> +       kfree(mparam->buf);
> +err1:
> +       pr_err("dma_map_sg failed alloc mparam buf on %s\n", dev_name(mpa=
ram->dev));
> +       return NULL;
> +}
> +
> +static void dma_sg_map_benchmark_unprepare(void *arg)
> +{
> +       struct dma_sg_map_param *mparam =3D arg;
> +       int i;
> +
> +       for (i =3D 0; i < mparam->npages; i++)
> +               free_page((unsigned long)mparam->buf[i]);
> +
> +       sg_free_table(&mparam->sgt);
> +
> +       kfree(mparam->buf);
> +       kfree(mparam);
> +}
> +
> +static int dma_sg_map_benchmark_do_map(void *arg)
> +{
> +       struct dma_sg_map_param *mparam =3D arg;
> +
> +       int sg_mapped =3D dma_map_sg(mparam->dev, mparam->sgt.sgl,
> +                                  mparam->npages, mparam->dma_dir);
> +       if (!sg_mapped) {
> +               pr_err("dma_map_sg failed on %s\n", dev_name(mparam->dev)=
);
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static int dma_sg_map_benchmark_do_unmap(void *arg)
> +{
> +       struct dma_sg_map_param *mparam =3D arg;
> +
> +       dma_unmap_sg(mparam->dev, mparam->sgt.sgl, mparam->npages,
> +                    mparam->dma_dir);
> +
> +       return 0;
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

Thanks
Barry
