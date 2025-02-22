Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A13A1E2847
	for <iommu@lists.linux.dev>; Sat, 22 Feb 2025 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740206203; cv=none; b=h42bvOXujiildfne00OapercLQcmLJ66XKbkHLxQLP/PoTxmn8yEX7BHcC1NH9UbuuNnhyr6V9a0ewnP2K8ov8BIg/YeV5+BXQvLeMnIRR2exX0iN63fv/IB6e7bkbILvU8fA3Cvi+3EA8HeEPVg45VMmyrWXIoIkaL2bE9DrWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740206203; c=relaxed/simple;
	bh=NbHvaNtJ9wTWXhbLSUbclPme56pv4hPnVUBWAn7K2C8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvYn0zRtc4y0uofrFbXEiizaZPP/0BTvQ9Mswkz+WTSywQov4qoIkc3jSPXPZsO61aslzVxioqf/deKzMBFBW19oLJVFynjrOVw4NlXsEyIR49+sC+A48kykk6vWzlQ3PDcwyqo/VP6Q2HbWchExUA0lR9VBRQTMyjSnb/Go2+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJ0MzmLk; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ0MzmLk"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-860f0e91121so2646859241.0
        for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 22:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740206200; x=1740811000; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YGwL5RBVq8Qdj+TMsX15RjehdCN2IArkMCkkvIFTFQ=;
        b=lJ0MzmLkLzFJmOTPFoVs0IoeFpzMIw/cUzNTk+n74YNb+thHGb/noot1Hk+xRjHTot
         OQ8baXoqjm6o6q/Zx1L5/8SoF4R/+BadRVFJBuJ10GpxxDp00Kej7BxWcwQQm/epSsmZ
         qzOMaDRD+NBGFFaDDmpLLRxy0DJxOljfgcCxHDwISCOo/pZ3q7TMZHsK5tYpICrPIfSJ
         UR5n9Oal2YxabhEchoLFno2finIDoBLuTWQN4rTA4e/UGinZKh6NhC9ryDrmUWUNw3dj
         0LgwXSMqv2JwQRqb2U1k7qXxIEwCfhotknwI07bMyrm/inpfupNgnIH2OTAC0yHg9xed
         alrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740206200; x=1740811000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YGwL5RBVq8Qdj+TMsX15RjehdCN2IArkMCkkvIFTFQ=;
        b=a6K+kvEzuv6QcJDzznMrU415LzrI1RVQFvMqop0V1+i596mJ7a9z5qDdk85TjtfmH0
         G7ydX1vuhS2gXSEXKBhLxA04la2KFt+Pnpo8Q2geBYbxvlL8yDNAfyh/j57GlQ05VrnN
         IkSupvd3glKBpK2OVKtKLI62ER9Pnc4ZNX2qwy84CiKao2UlXxpH85CcttnZEphSgQgI
         aSfiKqPk2IxYkHSqBafHkN+hLaiopNoal/PB0q9R6hZBJDSlRJJB26SdE61NyFwUIabG
         wzvEDQgogWnwg4ek/VaFPQdPR/eo8Ep2MdWta5HzM6RMPp/AxcwcGTeCzqLoGe3q8ITP
         oIJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjfbivAYT0GJsQbYBZN/mVKZjdJXS0LYaKf6xExwsfueKPn5Ajw2jx+Sb8K//D0TqFrfc7eg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyat5/KY0aNsNZj+1zu2KhFC4BLs+ddcAzinIPBhuMbVMbweZnG
	9vfUviTIKwAIaJx1ZW9bKuIVpMHMIDS5EideWsP8uxmOursm2Z7JEAjbRlK3zGMtqfeeHBodBb8
	qPDVgUsKYMIRtjc9jx7rNI0OcD40=
X-Gm-Gg: ASbGncs0n8J5aUledMO2Iq5Qus/aTHV7H8SL9/HqpN6ZYCoR43SUnRe/1XJrW8X/kSv
	RqqM9vGCo4MElRoo6stHDtTXvkHH2fTZzwCKfVtJancrd5EzLgh+N6j9klmyit8g0D9MzTo/AGw
	dJNmeegdc=
X-Google-Smtp-Source: AGHT+IFDFUkvyoyF9PoM1a8L3olWXlzU3vBwSP/0LEGsIKC8JIRHZNQI/VT7SiHtnD52wUgAroXQDE1pg4ebQfZhcZQ=
X-Received: by 2002:a05:6102:2921:b0:4bd:22d9:b117 with SMTP id
 ada2fe7eead31-4bfc0fdf40bmr3604751137.10.1740206200062; Fri, 21 Feb 2025
 22:36:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250212022718.1995504-1-xiaqinxin@huawei.com>
 <20250212022718.1995504-3-xiaqinxin@huawei.com> <CAGsJ_4yDBT4rJyG4-Ow4T3xLq8VujBjG+-uxjnWUm_vW1nzT_A@mail.gmail.com>
 <43618c9167654c68945ec5e7d9bf69d5@huawei.com>
In-Reply-To: <43618c9167654c68945ec5e7d9bf69d5@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 22 Feb 2025 19:36:29 +1300
X-Gm-Features: AWEUYZmZ43ciZTrQLWtWPOsCnhgKaVzwIodDrUSieFi9fiuaQUcU7kEBk6uvlbk
Message-ID: <CAGsJ_4zNTYsMkeBav7z=AKdm5CjB=Y73P1QBzq+9FS--z9t9Cw@mail.gmail.com>
Subject: Re: [PATCH 2/3] dma-mapping: benchmark: add support for dma_map_sg
To: xiaqinxin <xiaqinxin@huawei.com>
Cc: yangyicong <yangyicong@huawei.com>, "hch@lst.de" <hch@lst.de>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	"Zengtao (B)" <prime.zeng@hisilicon.com>, "fanghao (A)" <fanghao11@huawei.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 4:16=E2=80=AFPM xiaqinxin <xiaqinxin@huawei.com> wr=
ote:
>
>
>
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Barry Song <21cnbao@gmail.com>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B42=E6=9C=8818=E6=97=A5 =
4:59
> =E6=94=B6=E4=BB=B6=E4=BA=BA: xiaqinxin <xiaqinxin@huawei.com>
> =E6=8A=84=E9=80=81: chenxiang66@hisilicon.com; yangyicong <yangyicong@hua=
wei.com>; hch@lst.de; iommu@lists.linux.dev; Jonathan Cameron <jonathan.cam=
eron@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; fanghao (A) <fang=
hao11@huawei.com>; linux-kernel@vger.kernel.org
> =E4=B8=BB=E9=A2=98: Re: [PATCH 2/3] dma-mapping: benchmark: add support f=
or dma_map_sg
>
> On Wed, Feb 12, 2025 at 3:27=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com>=
 wrote:
> >
> > Support for dma scatter-gather mapping and is intended for testing
> > mapping performance. It achieves by introducing the dma_sg_map_param
> > structure and related functions, which enable the implementation of
> > scatter-gather mapping preparation, mapping, and unmapping operations.
> > Additionally, the dma_map_benchmark_ops array is updated to include
> > operations for scatter-gather mapping. This commit aims to provide a
> > wider range of mapping performance test  to cater to different scenario=
s.
>
> This benchmark is mainly designed to debug contention issues, such as IOM=
MU TLB flushes or IOMMU driver bottlenecks. I don't fully understand how SG=
 or single will impact the evaluation of the IOMMU driver, making it unclea=
r if the added complexity is justified.
>
> Can you add some explanation on why single mode is not sufficient for pro=
filing and improving IOMMU drivers?
>
> Hello Barry ! =F0=9F=98=8A
> Currently, the HiSilicon accelerator service uses the dma_map_sg interfac=
e. We want to evaluate the performance of the entire DMA map process. (incl=
uding not only the iommu, but also the map framework). In addition, for sca=
tterlist, __iommu_map is executed for each nent. This increases the complex=
ity and time overhead of mapping. The effect of this fragmentation is not o=
bvious in dma_map_single, which only handles a single contiguous block of m=
emory.
>

Thanks!
Please update your editor to ensure it doesn't respond with such long sente=
nces
without line breaks in the future :-)

Can you provide concrete examples or data showing how the newly added mode
improves profiling of the entire DMA map process? For instance, what limita=
tions
exist without this mode? What performance issues cannot be identified witho=
ut
it?

> >
> > Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> > ---
> >  include/linux/map_benchmark.h |   1 +
> >  kernel/dma/map_benchmark.c    | 102 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 103 insertions(+)
> >
> > diff --git a/include/linux/map_benchmark.h
> > b/include/linux/map_benchmark.h index 054db02a03a7..a9c1a104ba4f
> > 100644
> > --- a/include/linux/map_benchmark.h
> > +++ b/include/linux/map_benchmark.h
> > @@ -17,6 +17,7 @@
> >
> >  enum {
> >         DMA_MAP_SINGLE_MODE,
> > +       DMA_MAP_SG_MODE,
> >         DMA_MAP_MODE_MAX
> >  };
> >
> > diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> > index d8ec0ce058d8..b5828eeb3db7 100644
> > --- a/kernel/dma/map_benchmark.c
> > +++ b/kernel/dma/map_benchmark.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/scatterlist.h>
> >  #include <linux/slab.h>
> >  #include <linux/timekeeping.h>
> >
> > @@ -111,8 +112,109 @@ static struct map_benchmark_ops dma_single_map_be=
nchmark_ops =3D {
> >         .do_unmap =3D dma_single_map_benchmark_do_unmap,
> >  };
> >
> > +struct dma_sg_map_param {
> > +       struct sg_table sgt;
> > +       struct device *dev;
> > +       void **buf;
> > +       u32 npages;
> > +       u32 dma_dir;
> > +};
> > +
> > +static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data
> > +*map) {
> > +       struct scatterlist *sg;
> > +       int i =3D 0;
> > +
> > +       struct dma_sg_map_param *mparam __free(kfree) =3D kzalloc(sizeo=
f(*mparam), GFP_KERNEL);
> > +       if (!mparam)
> > +               return NULL;
> > +
> > +       mparam->npages =3D map->bparam.granule;
> > +       mparam->dma_dir =3D map->bparam.dma_dir;
> > +       mparam->dev =3D map->dev;
> > +       mparam->buf =3D kmalloc_array(mparam->npages, sizeof(*mparam->b=
uf),
> > +                                   GFP_KERNEL);
> > +       if (!mparam->buf)
> > +               goto err1;
> > +
> > +       if (sg_alloc_table(&mparam->sgt, mparam->npages, GFP_KERNEL))
> > +               goto err2;
> > +
> > +       for_each_sgtable_sg(&mparam->sgt, sg, i) {
> > +               mparam->buf[i] =3D (void *)__get_free_page(GFP_KERNEL);
> > +               if (!mparam->buf[i])
> > +                       goto err3;
> > +
> > +               if (mparam->dma_dir !=3D DMA_FROM_DEVICE)
> > +                       memset(mparam->buf[i], 0x66, PAGE_SIZE);
> > +
> > +               sg_set_buf(sg, mparam->buf[i], PAGE_SIZE);
> > +       }
> > +
> > +       return_ptr(mparam);
> > +
> > +err3:
> > +       while (i-- > 0)
> > +               free_page((unsigned long)mparam->buf[i]);
> > +
> > +       pr_err("dma_map_sg failed get free page on %s\n", dev_name(mpar=
am->dev));
> > +       sg_free_table(&mparam->sgt);
> > +err2:
> > +       pr_err("dma_map_sg failed alloc sg table on %s\n", dev_name(mpa=
ram->dev));
> > +       kfree(mparam->buf);
> > +err1:
> > +       pr_err("dma_map_sg failed alloc mparam buf on %s\n", dev_name(m=
param->dev));
> > +       return NULL;
> > +}
> > +
> > +static void dma_sg_map_benchmark_unprepare(void *arg) {
> > +       struct dma_sg_map_param *mparam =3D arg;
> > +       int i;
> > +
> > +       for (i =3D 0; i < mparam->npages; i++)
> > +               free_page((unsigned long)mparam->buf[i]);
> > +
> > +       sg_free_table(&mparam->sgt);
> > +
> > +       kfree(mparam->buf);
> > +       kfree(mparam);
> > +}
> > +
> > +static int dma_sg_map_benchmark_do_map(void *arg) {
> > +       struct dma_sg_map_param *mparam =3D arg;
> > +
> > +       int sg_mapped =3D dma_map_sg(mparam->dev, mparam->sgt.sgl,
> > +                                  mparam->npages, mparam->dma_dir);
> > +       if (!sg_mapped) {
> > +               pr_err("dma_map_sg failed on %s\n", dev_name(mparam->de=
v));
> > +               return -ENOMEM;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int dma_sg_map_benchmark_do_unmap(void *arg) {
> > +       struct dma_sg_map_param *mparam =3D arg;
> > +
> > +       dma_unmap_sg(mparam->dev, mparam->sgt.sgl, mparam->npages,
> > +                    mparam->dma_dir);
> > +
> > +       return 0;
> > +}
> > +
> > +static struct map_benchmark_ops dma_sg_map_benchmark_ops =3D {
> > +       .prepare =3D dma_sg_map_benchmark_prepare,
> > +       .unprepare =3D dma_sg_map_benchmark_unprepare,
> > +       .do_map =3D dma_sg_map_benchmark_do_map,
> > +       .do_unmap =3D dma_sg_map_benchmark_do_unmap, };
> > +
> >  static struct map_benchmark_ops *dma_map_benchmark_ops[DMA_MAP_MODE_MA=
X] =3D {
> >         [DMA_MAP_SINGLE_MODE] =3D &dma_single_map_benchmark_ops,
> > +       [DMA_MAP_SG_MODE] =3D &dma_sg_map_benchmark_ops,
> >  };
> >
> >  static int map_benchmark_thread(void *data)
> > --
> > 2.33.0
> >
>

Thanks
Barry
