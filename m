Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03913224885
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 05:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744005056; cv=none; b=CQOkl1Bykt6zekpDtfvaANA0WXzgGqMfRkwxPdF0t7ar63fGcdzVnabw50o63sPJDmW10/edUvaZ7NS5y+Ou9tBNd0QbSa4DKTk5o5XrqMRsgH4MNeQ5f6MvMLK+CUne91TwDi2lNTYB8/CGBieZZoMA1PRgHPjbpgBPfacKnHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744005056; c=relaxed/simple;
	bh=kKx4Mq6S60oDctpAHNOJ2iBB2kp8w70OG+S1g8NoT6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNF2S2/iGLmurutXF1bbvP0oPJf3zpC4S2sZ5BZSBLZaAGuEADd1quW5R6II4cuJhddQkCQYAetDdXu16jxhtY5z/zKzF14qji+Mz9ymFEIzYumrvxyTvvgDpMcw1Ppt67TxRnyW2RxpTJmMyNsQQQ5CzCUh3jRoFZmP+1kbrDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQVdC9M4; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQVdC9M4"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-51eb1823a8eso2122772e0c.3
        for <iommu@lists.linux.dev>; Sun, 06 Apr 2025 22:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744005054; x=1744609854; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TncwcfsEts2FxYnhK+A5JNwLq/UeBfz60NCy/dOZhg8=;
        b=OQVdC9M47RxLJjLmkbb1eY7iiw/6HkNiq6z04Wexdns4cmbuYmw6zCGV1eWle9z6Gd
         TL98Uj1GPH2Kn6Bz6GaeYzron0TnY7p//7kiSxzfPdlEoqbGq/o8H28hFDoZETXBKBKk
         Kxe5JxRSKeX7jwi2q9p2YF5f4UJwKK43LiVNdhr4mwBaP/1XeKrefLECogCvkV0eDqGt
         rh2Kz+oREi9CXGD8byf4DMmOC+ld+Dl8+g+idwDuxxsOlSVFFTXJ38AFg9lyc/KbTl4j
         /wpgkXnm+1m6sbSehD280cwYf4LiSoFHVsgQIkREwYEDHda+UF2aRfYyckAXmoMuAMnE
         6vkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744005054; x=1744609854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TncwcfsEts2FxYnhK+A5JNwLq/UeBfz60NCy/dOZhg8=;
        b=A1evh1OQN3pSTw+5PlUivilziIyPHyDbqt9+kThRpd2Qr2O9uGZjsbZBv93h99W6ZR
         Ba0UsFqwLYmWIpO5BLSIfwD0jatXy5OFhkexc9Ut5lNU3scRMT+EP3eSUgkUsCjQuDBb
         JooPBx/83fcnEiZHePjOl4yTvUvitkP1gWp98QXUDwpEK2RvyoPMrasaffFUCAf+COsu
         gPnSwqUdceze1+MgNlpjSsAZlDPC77rKNwdh9/SuofVnyeGQWOVYrchYgcC470I+y6im
         bt35SUaVe+pgl4mJKlPIJkBn2Re5GIhrskY3k56YCS0fcLVGhYm1y5qDq9BsxOJ9l2+k
         BrBA==
X-Forwarded-Encrypted: i=1; AJvYcCWssNBHiHTuBvI/PPol4IkTK/ti+kHgTUmL+Ui7vEP3duXy1InlkBbzuiOBRMeKluLNu7zwHg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1am9Mlb0MIPQrU7hWlv222CJBV8T2GZaBCyGPux+CV8fqww42
	aTIPk8M8Eh9ok3/XvpdtpY64lZgMJkb9iEYDKQIZ2FC6U8FGudvuu5LE8EMYrvsGMDmkF9KNowQ
	Ps0McXszZDFealdRrrqOJVPrX068=
X-Gm-Gg: ASbGnct/DYVrM4bKDOP0yFj/SWl66AgNU+c0ZITHDIpecoatDL/JuiAKI4vIWsGhuU8
	bHscTRfcosHMPdxMLEJkUwg1HJMsypks0M24SFRSv5pTSOTsKSCdC1kvc/WeDW5slu4HRRt+ixx
	cU9l/Ss3xErTVZeWI3IdOFWc825g==
X-Google-Smtp-Source: AGHT+IFvBUALOfbhAc7ZTDj+1qYBwV+DDke3iV0oHmxLiMrPhi01dySNUBoaRmlF207WvrrXWhLb5Q/d30UQFe8H+RU=
X-Received: by 2002:a05:6122:6585:b0:520:61ee:c7fc with SMTP id
 71dfb90a1353d-52764448721mr8144939e0c.4.1744005053724; Sun, 06 Apr 2025
 22:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250212022718.1995504-1-xiaqinxin@huawei.com> <20250212022718.1995504-3-xiaqinxin@huawei.com>
In-Reply-To: <20250212022718.1995504-3-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 7 Apr 2025 17:50:42 +1200
X-Gm-Features: ATxdqUEwAdwB6D5DagVzMUdZgoOsw1QIQSdcNIkWQDykU7LKqNsRceUjwcC4I-M
Message-ID: <CAGsJ_4x7u00HVsa11cw_r6Mb3x0Ls-9tCg2HcUs=KvoVX=Vhvg@mail.gmail.com>
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

Please add comments explaining that "granule" serves as  nents in SG
mode, and that each SG entry corresponds to a single page.
Otherwise, in single mode, the granule represents what we map and
unmap as a whole in a single operation.
I mean, make the code below clearly express what you are doing:

__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */


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

I assume allocation failures will already trigger their own warnings, so yo=
ur
pr_err isn't necessary. BTW, please replace err1, err2, err3 with something
meaningful.

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

void

> +{
> +       struct dma_sg_map_param *mparam =3D arg;
> +
> +       dma_unmap_sg(mparam->dev, mparam->sgt.sgl, mparam->npages,
> +                    mparam->dma_dir);
> +
> +       return 0;

drop it.

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
