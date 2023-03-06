Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D4A7E
	for <iommu@lists.linux.dev>; Mon,  6 Mar 2023 09:30:00 +0000 (UTC)
Received: by mail-vs1-f51.google.com with SMTP id f31so8512942vsv.1
        for <iommu@lists.linux.dev>; Mon, 06 Mar 2023 01:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678094999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOQ6t3Hb9C299OKzxn9vICY4AIqbYxxJ8erDdZZ49aU=;
        b=VW0vtOBZReL5IfVc6CrKDixwOUjxdt9jKE2ldZ7BhrIezTaKKVLtlcYrN/UJuHkx86
         UyF1NtVD4t6KM9E8+OlWvJSG50UNwEeJUSoqiQ4hgmn8JO28HhmYs0JtZDZ6cHs+LJ0K
         J8rsGrHP/fyVmomrXecYR+y10Y5nsc9k1Ao8Z4PO7/BPtbpBbcLpz9o0cOMUmKUsKDbk
         W4OeiZGiHQs9gV8wAivsrSFXTDdXPNgIXylEzDKzdbmwa9QwFZ2s5TSfBQnAASr7RFyK
         z37RzMDO/ovF4I1fOOvNb9tzjXEo5pYgmWjKzdeBB/HF1tgcrO+5wvZ8plXXdaYKcQTd
         HYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678094999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOQ6t3Hb9C299OKzxn9vICY4AIqbYxxJ8erDdZZ49aU=;
        b=LeIlRedIdu00UrKfyRzYGFMevAO5bJ7iE9l7fAF22zjFEkruoIo4SCifRhJHluz9hA
         rXZC59P0aO94lP3KpGMkuAKiqBhZCeCbjq8umTB6BEz1HQoKoeDQ41vsOGkQYJdp6V1p
         PQaz50i8TlOE9qWzhhAvOq3b6wxwKt+JJ9hXnqIe7MqDCQrb50/kjKuorrBjHGLxPnVq
         TG4noyVG4+ff8WZ2XppOW8MxSFtjcKhSHbFQ6rTahnE79s/eGnM0tfC+cJ2j8HOS0dfI
         vS3UWv/B9wFSEyVPOvZd8fsBALp5s2Xn4X7iadoLT6iaEUwVK0NxX3Lq1/canFu+PAtP
         cO3A==
X-Gm-Message-State: AO0yUKVrY4GPLGx+pvLCzTAsygQ2w47LYFyHtoWfibVMT8LHirRODGax
	ePqtL7DrRgo4wSHVpu5NNHe0HgSVanKYuST/MyU=
X-Google-Smtp-Source: AK7set86Lm3AY41Vf+dGbOY9wLapotveMFNiJZuEOsa5W2MGjgRnSX60O1cUKx0lDz11KvC1KDn2/7aHlUOI90x2mic=
X-Received: by 2002:a67:ce0a:0:b0:416:e50f:8215 with SMTP id
 s10-20020a67ce0a000000b00416e50f8215mr6697779vsl.4.1678094999136; Mon, 06 Mar
 2023 01:29:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230306052613.411400-1-chunyan.zhang@unisoc.com> <d18d3026-a3a9-a92b-3735-f4045f96ff4e@linux.intel.com>
In-Reply-To: <d18d3026-a3a9-a92b-3735-f4045f96ff4e@linux.intel.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Mon, 6 Mar 2023 17:29:23 +0800
Message-ID: <CAAfSe-uXH1nAM4Er4UxQfVgVf24j1kFvi+fF3XRG+ucVwtS61A@mail.gmail.com>
Subject: Re: [PATCH V2] iommu: sprd: fix a dma buffer leak issue
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Orson Zhai <orsonzhai@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Mar 2023 at 13:57, Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 2023/3/6 13:26, Chunyan Zhang wrote:
> > The DMA buffer used to store the address mpping table is alloced when
> > attaching device to a domain, and had been released in .detach_dev()
> > callback which will never be called since this driver supports default
> > domain, that will cause memory leak.
> >
> > Move the dma buffer free before freeing sprd iommu domain to fix
> > this issue.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> > V2: Modified commit message
> > ---
> >   drivers/iommu/sprd-iommu.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
> > index ae94d74b73f4..4de2e79d2226 100644
> > --- a/drivers/iommu/sprd-iommu.c
> > +++ b/drivers/iommu/sprd-iommu.c
> > @@ -154,6 +154,17 @@ static struct iommu_domain *sprd_iommu_domain_allo=
c(unsigned int domain_type)
> >   static void sprd_iommu_domain_free(struct iommu_domain *domain)
> >   {
> >       struct sprd_iommu_domain *dom =3D to_sprd_domain(domain);
> > +     size_t pgt_size =3D sprd_iommu_pgt_size(domain);
> > +     struct sprd_iommu_device *sdev =3D dom->sdev;
> > +
> > +     /*
> > +      * If the domain has been attached to a device already,
> > +      * free the dma buffer first.
>
> Is it possible that a domain is attached to multiple devices or attached
> to a device multiple times? If so, perhaps the memory is also leaked in
> sprd_iommu_attach_device():

I managed the wrong patch, sorry for the big mistake.

>
> 233 static int sprd_iommu_attach_device(struct iommu_domain *domain,
> 234                                     struct device *dev)
> 235 {
> 236         struct sprd_iommu_device *sdev =3D dev_iommu_priv_get(dev);
> 237         struct sprd_iommu_domain *dom =3D to_sprd_domain(domain);
> 238         size_t pgt_size =3D sprd_iommu_pgt_size(domain);
> 239
> 240         if (dom->sdev)
> 241                 return -EINVAL;
> 242
> 243         dom->pgt_va =3D dma_alloc_coherent(sdev->dev, pgt_size,
> &dom->pgt_pa, GFP_KERNEL);
> 244         if (!dom->pgt_va)
> 245                 return -ENOMEM;
>
> as dom->pgt_va is not checked before setting a new pointer.
>
> If sprd iommu driver only supports one-time use of domain=EF=BC=8C perhap=
s put

Yes, it is the case for sprd iommu. I will add a comment in the next versio=
n.

Many thanks for the review,
Chunyan

> a comment around above code so that people can take care of it when the
> assumption changes.
>
> > +      */
> > +     if (sdev) {
> > +             dma_free_coherent(sdev->dev, pgt_size, dom->pgt_va, dom->=
pgt_pa);
> > +             dom->sdev =3D NULL;
> > +     }
> >
> >       kfree(dom);
> >   }
>
> Best regards,
> baolu
