Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C9F30ACE5
	for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766437440; cv=none; b=jGR34hUiQR+MKLPLr8nrOZBXJszl/0yCb18Hds6zQxYNQ5FljKowWp4t9rcHYQRi+pu2cE+LzXQNXJ66EYOk+5d8WlWTATFa456+k/lIPH/bQPY2HDpPBc4bUaGMl/vN+w6WDt4LPJv321d3+I4Wg40jiyQrNicjasLrarveCEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766437440; c=relaxed/simple;
	bh=t7Cw3Kgx4tSwLlRpxXlFn1CIah9A1gMPnrMy0e9WyRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2HrRERBHzgEFHdoOVfHqbvUN6nE/8UdvsgMXSh5WLd0HG10wwicVLsdmfKPF5hWlc6+vTVa+4e0KK76dcPgh+ZRUkv8YVE88eIMXeP/6ppbvITlzWBi8RPEVJdLoQf5mSqb9EOliCNEFFPNMmGGqHtVodxOBImID2Y+y9NrbtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMzpWHr2; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMzpWHr2"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88fca7bce90so22195896d6.3
        for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 13:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766437437; x=1767042237; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEseg8cQiDDOsmMM6zg+PySjyHgt1YQbzxnnEX+Mxnc=;
        b=IMzpWHr2Akpoc/uXueWwnPKEDeNANVvGucikIbr93tl+hpWbCEoOn+Y3jizPFMVRYf
         4vPRgKdZBdKxt58RShOaDnpLNX+T4dNeuwiZ7VXMwNa9MpvAkFGs5qk7kO/hyGRiEaMg
         YDrhTYx8U40NXGzmKNF5M85/pSrhkZ6zsPC+mnfE4kO8xh4oLzraLaIIv88XVW1Aqii5
         +c3Z3T+542nSDswvsxX9R2HiZy/7mVogDc6n4JnZkBoPhTwJo08ct1bK4gOYrmDaXtm3
         7UUg7jLjnL08jFFB5c8C0BLPTRoJ1/uIVcH5vyWyHpM/2RMyvymou+RULePK8Ffxd0/y
         /Jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766437437; x=1767042237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MEseg8cQiDDOsmMM6zg+PySjyHgt1YQbzxnnEX+Mxnc=;
        b=hTi9KSjFjmPpbMc1nrut7AU5r6LJvYWS8OZfLKHGvIydBYhLPS11o6IBfhloVWmre0
         mwDJLVSDDYBxZueovIKeUVfGQB33ECK9xEtwha6lrvXBzxrpM0/5/FbQYJUy+YfNYRPN
         uzxetNBJplPKy29MWIGUpLPdnBZNH3Aoc6oXOle1UfUIMBX0qSjd92XJXqM7cxA29nEA
         XhndMtqRRoH/Y/zszldIpIsy6v0IhT65guK70HH/2jnzEiyodjuNSbuh9ytKQOssZg1/
         /XwwbuxqNcPXN5wIkZfeBMYScUXHBtITapIZFmb0PpajoWRhByAJfzLGO92BZ4/I0BdD
         CxOg==
X-Forwarded-Encrypted: i=1; AJvYcCWh2GlFrzrLIHJ7dYLnJSRPKx54d8iYEGzTvunKyUIkRB52+phOdwUHLEVNqn33YVR3I9SPUw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyp8gBUS85pRFbhUMTFX3P9i/I9i183BnGk7mXcRWuiUVqNmQht
	UcKX/kdZhXPjst3bqpnNjrCNNtHSCbVDeL8kc2Sf+eCv/0ftiWbZOHPMfktqtQEWhbaedjAxRlt
	IqLZ5VgaRnjrtKz+qWi3FbwNr3sxyQWA=
X-Gm-Gg: AY/fxX77IDerpq6R73N5iQlWzqhRsDpoNnwrQ8Gi+zhL9CWo1pNoZM35en+l/PB5r2c
	cS7glqI1/vh8j8Tn+xYDZobXYd9Y7en5X8SdwU/VNFfRYuucfp6dJjyvi44O92tuw5f6AksueaJ
	iVyQHhSvPv7F5P36lx4vxKn3PJDW0pv132ElwmfiYBrtCyAMQOnrtIhKWAhkdkcFtQlT9SS76VH
	uVnYhUIuiCqKkpyNXSv9rZhKmokR1Awv8cbDUsjElH9aZAkWutv0p3h37h+khO3mQ58yA==
X-Google-Smtp-Source: AGHT+IFaAH13xgccyNUUaCRMKXHdc+7Jkk9qaa08h8KJH9/KYsBtIEmg7YQ4RFgnMudm9Xwp85SaTKUtStPdfOrepL8=
X-Received: by 2002:a05:6214:8208:20b0:7e3:cc6e:3c89 with SMTP id
 6a1803df08f44-88d84fff436mr155649066d6.56.1766437437080; Mon, 22 Dec 2025
 13:03:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251222153246.2220659-1-xiaqinxin@huawei.com> <20251222153246.2220659-2-xiaqinxin@huawei.com>
In-Reply-To: <20251222153246.2220659-2-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 23 Dec 2025 10:03:46 +1300
X-Gm-Features: AQt7F2qOpOuwc9HBVjvSUe0xDEsIGshZIgOjgqnQpMnnu7en2K_J5iEljmRnMr8
Message-ID: <CAGsJ_4y_xTJJRBzvSszg0qOAX7tAahJYzLaKcTPuJg6ctJsyUg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dma-mapping: benchmark: modify the framework to
 adapt to more map modes
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: jonathan.cameron@huawei.com, wangzhou1@hisilicon.com, 
	iommu@lists.linux.dev, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 4:33=E2=80=AFAM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
> This patch adjusts the DMA map benchmark framework to make the DMA
> map benchmark framework more flexible and adaptable to other mapping
> modes in the future. By abstracting the framework into four interfaces:
> prepare, unprepare, prepare_data, do_map, and do_unmap.
> The new map schema can be introduced more easily
> without major modifications to the existing code structure.
>
> Reviewed-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>  include/uapi/linux/map_benchmark.h |   8 +-
>  kernel/dma/map_benchmark.c         | 130 ++++++++++++++++++++++++-----
>  2 files changed, 115 insertions(+), 23 deletions(-)
>
> diff --git a/include/uapi/linux/map_benchmark.h b/include/uapi/linux/map_=
benchmark.h
> index c2d91088a40d..e076748f2120 100644
> --- a/include/uapi/linux/map_benchmark.h
> +++ b/include/uapi/linux/map_benchmark.h
> @@ -17,6 +17,11 @@
>  #define DMA_MAP_TO_DEVICE       1
>  #define DMA_MAP_FROM_DEVICE     2
>
> +enum {
> +       DMA_MAP_BENCH_SINGLE_MODE,
> +       DMA_MAP_BENCH_MODE_MAX
> +};
> +
>  struct map_benchmark {
>         __u64 avg_map_100ns; /* average map latency in 100ns */
>         __u64 map_stddev; /* standard deviation of map latency */
> @@ -29,7 +34,8 @@ struct map_benchmark {
>         __u32 dma_dir; /* DMA data direction */
>         __u32 dma_trans_ns; /* time for DMA transmission in ns */
>         __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a ti=
me */
> -       __u8 expansion[76]; /* For future use */
> +       __u8 map_mode;  /* the mode of dma map */
> +       __u8 expansion[75]; /* For future use */
>  };
>
>  #endif /* _UAPI_DMA_BENCHMARK_H */
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 794041a39e65..a6345c10901c 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -5,6 +5,7 @@
>
>  #define pr_fmt(fmt)    KBUILD_MODNAME ": " fmt
>
> +#include <linux/cleanup.h>

Are you still using scope-api and need cleanup.h?

>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> @@ -31,17 +32,105 @@ struct map_benchmark_data {
>         atomic64_t loops;
>  };
>
> +struct map_benchmark_ops {
> +       void *(*prepare)(struct map_benchmark_data *map);
> +       void (*unprepare)(void *mparam);
> +       void (*prepare_data)(void *mparam);
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
> +static void dma_single_map_benchmark_prepare_data(void *mparam)
> +{
> +       struct dma_single_map_param *params =3D mparam;
> +
> +       /*
> +        * for a non-coherent device, if we don't stain them in the
> +        * cache, this will give an underestimate of the real-world
> +        * overhead of BIDIRECTIONAL or TO_DEVICE mappings;
> +        * 66 means evertything goes well! 66 is lucky.
> +        */
> +       if (params->dma_dir !=3D DMA_FROM_DEVICE)
> +               memset(params->xbuf, 0x66, params->npages * PAGE_SIZE);
> +}
> +
> +static int dma_single_map_benchmark_do_map(void *mparam)
> +{
> +       struct dma_single_map_param *params =3D mparam;
> +
> +       params->addr =3D dma_map_single(params->dev, params->xbuf,
> +                                     params->npages * PAGE_SIZE, params-=
>dma_dir);
> +       if (unlikely(dma_mapping_error(params->dev, params->addr))) {
> +               pr_err("dma_map_single failed on %s\n", dev_name(params->=
dev));
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
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
> +       .prepare_data =3D dma_single_map_benchmark_prepare_data,
> +       .do_map =3D dma_single_map_benchmark_do_map,
> +       .do_unmap =3D dma_single_map_benchmark_do_unmap,
> +};
> +
> +static struct map_benchmark_ops *dma_map_benchmark_ops[DMA_MAP_BENCH_MOD=
E_MAX] =3D {
> +       [DMA_MAP_BENCH_SINGLE_MODE] =3D &dma_single_map_benchmark_ops,
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
> @@ -49,23 +138,14 @@ static int map_benchmark_thread(void *data)
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
> +               if (!mb_ops->prepare_data)
> +                       mb_ops->prepare_data(mparam);

Did you actually test it? and why don't you need prepare_data() sometimes?

Thanks
Barry
