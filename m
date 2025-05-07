Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1D419047A
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 02:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746585564; cv=none; b=HHNU9OUtK6XPAEq7OTCYeh5Z1wVnQJTi7vp6lh0xOG1HWj5TUDvyC/d6bnPp+IQEQFppoEYAxtr9leCIV2G3S3dV7LEKbKOpNyEHp05MdmmMRtuD6FoH1yy3IbbuyUfqs4nK8YkbFCkmY76VxIjYcKjSDiWxbw/VtKOGf98IP0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746585564; c=relaxed/simple;
	bh=AB6axM5YviGmQu+aK72+sPdzfV0gkW5k1I+CmPGnigo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZ93EneFcrAERwNrQwL1JAxvoj/2si70+0UIZI5j7l9iehUE2IovHS4gHjmcv2XZ5NNOcW/xfuivB4MpeRzSTig2NrkUjTfPiL6etxVlCh83ThttaDXcePM+LtGIE5pFYx6erfATfsfdrhH0W8m3AOFq7+90HQ1YOXS2TWuej6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jm5484QH; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jm5484QH"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4c4f8799f8aso1778075137.1
        for <iommu@lists.linux.dev>; Tue, 06 May 2025 19:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746585562; x=1747190362; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wkWd3mpSwgn/ORyZrrLqXyFRvmqvQMNecHp4igLlJs=;
        b=Jm5484QHggju6c1re0wzKBBTXgmI+1PN47NvAhBzXYlHp9pWCQGT94GUaR4nKeQVnC
         JOhF3p/EP68OFACcLOmE+oeujXdkW9iH1m3S+SPij3QiSbD2NLK5F//LU+w6/67VbuBh
         sUKDyGwJ6i9uYW30AO4cJ/Qes9JhUw4s7xFH57U8HjTGfiZFpIsCywv/AZ6UkQU2R/6f
         xMPbymVG28wjRVCuUDWrfO6+ox/W3+5xvW5CHt+jDgmP0N86hr/IQ8VNSUyN4a9k7o+u
         5mU7vuypzq7ZGI4hQj1bGnNqlKLTwkSxAS+vSqMfQww2VrC02/CNLjxrrfsvFpNle6DT
         kk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746585562; x=1747190362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wkWd3mpSwgn/ORyZrrLqXyFRvmqvQMNecHp4igLlJs=;
        b=nGg+h1aseJh2c0BUZAaYQacCUzvMZWsC8OUhYF+eWUaoh2bT6IRDE3iqf2doMddxhd
         Q6AOBmGhhMVRBcqiVWr1uvtPP+ZT5QA/sdq0ZPOmAA4Dq4+UPAMfQNo4q+4Y06WBNwNk
         nysy1BlOcrCmOfCxwbpBSqlnhXuXYDokTebxbLbbQuZTIT/DeyYgbxJyeT1SkhB4tAUY
         TOjZQvlq/UkMpbd9lemT1JbwdLTDPy2Pnr2qpOW1AhPzEQfIARqwM6IZL4oZN65LeTjf
         10ij3MX1eHXaQamfHHZpHLRYJaofoPoxh7C/1UJWVKMvwhR9oKGqH7OlefF61KTm9a1H
         wzSA==
X-Forwarded-Encrypted: i=1; AJvYcCWljB/1oH7G2xnSv/jggvhxaLbPn4I+pJskJ4W6fbmYjEYYKQ9E6mwT5XTWI+i98KFtXsVuIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDnHqsP5+v2AvcXRNCN59KJgGPNX9KDKeUTHrEjpf72/bDZw+L
	R0910VUo4EvBKR7qvosFTiwtoGgOGuVuOzBBDd5v/+dMYZs0/Hn4BPv+bkWde9lFQFLYRfKF2my
	pSYMU+KRY74u9CDmq73ljRvgpTbK/hO25
X-Gm-Gg: ASbGncuV0lodzW5DL/eAr42ZtnSPUfJFaqcEOzitz4ot59zGuLpA+GC/CF/2bYVUC36
	TsVevzVnsjHxlFwTsM5Zl0lMVokZsYpC1Ie5N+Yp6o3cVzOG+v0Mon5jCmp/Ckj+ZLBWAml5/H7
	MSsOybm3yRJWQJRkTxdNQTFg==
X-Google-Smtp-Source: AGHT+IF/XkOY4GQjpYCXPl+LezdUBEVxkKD2rbgN+/2Nf1zDxVzejnDRAwgAZ3WRWd49g/ubLvrnsObAmcdM0hxH+n0=
X-Received: by 2002:a05:6102:4a87:b0:4db:e6f:9c99 with SMTP id
 ada2fe7eead31-4dc73790663mr1599807137.1.1746585561769; Tue, 06 May 2025
 19:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250506030100.394376-1-xiaqinxin@huawei.com> <20250506030100.394376-4-xiaqinxin@huawei.com>
In-Reply-To: <20250506030100.394376-4-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 7 May 2025 14:39:10 +1200
X-Gm-Features: ATxdqUHz28oD3DpDcOYv89LGKjbYslfcFAHjeX8XOE2R7jR6z84CkVGv7ZsG958
Message-ID: <CAGsJ_4zBHVwc3A67Wff3u0aypuPv6h25B_YdDqG5j9FmBOXn8g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dma-mapping: benchmark: add support for dma_map_sg
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: yangyicong@huawei.com, hch@lst.de, iommu@lists.linux.dev, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 3:01=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> wr=
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
> ---
>  include/linux/map_benchmark.h |  43 ++++++++++----
>  kernel/dma/map_benchmark.c    | 102 ++++++++++++++++++++++++++++++++++
>  2 files changed, 133 insertions(+), 12 deletions(-)
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
> index f04973eba1d8..72cd2c5f839e 100644
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
> @@ -110,8 +111,109 @@ static struct map_benchmark_ops dma_single_map_benc=
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

I'm not sure we need `i =3D 0`; perhaps just `int i` would be sufficient.

> +
> +       struct dma_sg_map_param *mparam __free(kfree) =3D kzalloc(sizeof(=
*mparam), GFP_KERNEL);
> +       if (!mparam)
> +               return NULL;
> +
> +       /*
> +        * Set the number of scatterlist entries based on the granule.
> +        * In SG mode, 'granule' represents the number of scatterlist ent=
ries.
> +        * Each scatterlist entry corresponds to a single page.
> +        */
> +       mparam->npages =3D map->bparam.granule;
> +       mparam->dma_dir =3D map->bparam.dma_dir;
> +       mparam->dev =3D map->dev;
> +       mparam->buf =3D kmalloc_array(mparam->npages, sizeof(*mparam->buf=
),
> +                                   GFP_KERNEL);
> +       if (!mparam->buf)
> +               goto out;
> +
> +       if (sg_alloc_table(&mparam->sgt, mparam->npages, GFP_KERNEL))
> +               goto free_buf;
> +
> +       for_each_sgtable_sg(&mparam->sgt, sg, i) {
> +               mparam->buf[i] =3D (void *)__get_free_page(GFP_KERNEL);
> +               if (!mparam->buf[i])
> +                       goto free_page;
> +
> +               if (mparam->dma_dir !=3D DMA_FROM_DEVICE)
> +                       memset(mparam->buf[i], 0x66, PAGE_SIZE);
> +
> +               sg_set_buf(sg, mparam->buf[i], PAGE_SIZE);
> +       }
> +
> +       return_ptr(mparam);
> +
> +free_page:
> +       while (i-- > 0)
> +               free_page((unsigned long)mparam->buf[i]);
> +
> +       sg_free_table(&mparam->sgt);
> +free_buf:
> +       kfree(mparam->buf);
> +out:
> +       return NULL;
> +}
> +
> +static void dma_sg_map_benchmark_unprepare(void *arg)

The term "arg" is meaningless for a function argument, as it's already impl=
ied
that it is an argument.

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

int ret.

> +       if (!sg_mapped) {
> +               pr_err("dma_map_sg failed on %s\n", dev_name(mparam->dev)=
);
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static void dma_sg_map_benchmark_do_unmap(void *arg)
> +{
> +       struct dma_sg_map_param *mparam =3D arg;
> +
> +       dma_unmap_sg(mparam->dev, mparam->sgt.sgl, mparam->npages,
> +                    mparam->dma_dir);
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
barry
