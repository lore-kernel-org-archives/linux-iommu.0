Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C6F352FBB
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767724933; cv=none; b=gS1GxegLKxLQSpB/N1zXkrifIJuwZa5M3wNvMy5ljlM6rxU9FjVwCwX7mJ2cqbDfLIS7Q/ZzdnQxEk0iaFHp0+RTnBxCdXQqq4ymj0DKy1/jRtITNe+ImrRHcpn/u27zhKCjupFaSG998DmTQR+ZTMwzGXOyw1E4OZ9+l6ATDVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767724933; c=relaxed/simple;
	bh=AdGpRXl8KQ0FVqwOIuOubcueXdDNpP9wX8eW3KMHMfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugLYttIidplygxsn11f7QWOTtxjsas+Nmr7/cVuy9tg6ci9tBhf5fwRfAYhOpF5d/AoGa+8k8NYT7WOM/dvu7rQrnMAalx1K484WgI5a/XGjxu+N5gpoukZIDSdrEyafj3bzGPAjPP2PcLq128TZ+BaSvniezN8bL7OWT/U4yUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5NIWu/2; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5NIWu/2"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5dd88eef2f3so446834137.3
        for <iommu@lists.linux.dev>; Tue, 06 Jan 2026 10:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767724930; x=1768329730; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIXoBgSYkP/sd1BWOcNCLESjfDQLcEW6GaW2Kbu8M0A=;
        b=M5NIWu/2Drt4ug0PofbUhLJuRHm/womHtbvNBeBOX5zPMQn7nf9+p0WTXxEYbyJD42
         e84HY9VyAZl522eCXnaaG94w656izFBoTDk5QRsXsAzt4sHaJB/HSgAf/wbfNhSf2DwI
         W0/hPUaDPhK0ZvU2RFoXCDk9sDsPJCKXPagn/OgMw1LTAWITNkjsC/A5fHrVUug5cJi+
         zwEy1heIH18sjC00gwCBGYv8t5HLx/337Gq9w72UHR2w4x5Wbnpx0DmW4bmezfvBsPDD
         IWsoV124kLvP8jd3g3TxZiCUTB76urgCqLaOShYm5iTP+voxKOAhga9UQzVai/iyDQq6
         ijUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767724930; x=1768329730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CIXoBgSYkP/sd1BWOcNCLESjfDQLcEW6GaW2Kbu8M0A=;
        b=EEknz28NRL6w1XFi5o3RECFkn9XEV1obzxA0vsAvhdN8KCPP/zuTXpW3SeM/PBhO1/
         48esdnq7ZY3EUsCRS/+TvtwTvAPqmgoEMR8bKZ789F+09ryBgrZUvtR9/D8ygT5IG3fG
         rFOsnA/VbzvWx2LjDcRo9BlUerFVYZvJ5GFV1xpPgX5T70IfbuAVzO3KFK14ilHKDRlf
         I8E94B9zMwSuA5r6B9MFpEAeDI2FT9BtYtxr4Io1vkW/BRYqizkCByOFOPGWwp651XX/
         kiES/ggLrt1bTyNWB8OEy0cy2i0NyBgFQUOnndueGa1ZqVG4TBuDWVwkcB5jJV5tujEZ
         6YXg==
X-Forwarded-Encrypted: i=1; AJvYcCUwNwZZioxK9PxkQSTjAOvPMQWNxi9jZ6y9Q8FLDbSrZYVi1C/+59wtmNiixqyhMO149TkO3A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyz7Nbv1jp0CmGFSztwjbjSIicxZd2MKU3UAgbX9nL1KpdcGIex
	1bt4LuwMP0j5BqAxKCR9bCzKNWgT2N8hHJ+/jzW4zL7gY0DQjqLFRx+kloQVnDZBvZ4w6pP5Sp0
	v5Li2haTY0qZ/RLYdHtP0FCB+1O91IWs=
X-Gm-Gg: AY/fxX7ayVg3nBpCaIBT37ISVHo0yudySGWXAnu/CKuta//PYLaExYsbd4aEwXAkm33
	i3DkR3dwH63XB51gopRwOzx037Oa4XAaZ5OFs/W1M6IYMuZkezRC8GyEBKaq/BsX27gqXAwDvt3
	bmCEOWimOg5Q6IAy4zbg1EV9TBDCNs2zv9EKOFWGslKd0bPC/yKpgKyrw1aG8j0JbfBz6WgwK10
	ztVSnWRXeE+b2dmgdfKFqAl7hNSouQ4nuLWVG8vu4PdTUbvwM9MIPhXjlF2vHt6Zhsh+A==
X-Google-Smtp-Source: AGHT+IGzdDZdJH61h073/MhkLoyFPUTEGFa4biMd35SsepoUxfnatinjaLQUW4RiSiTNL7sRRTPCzkdKJMTlCl0LUrk=
X-Received: by 2002:a05:6102:560f:b0:5df:aff3:c41c with SMTP id
 ada2fe7eead31-5ec744a174bmr1358450137.30.1767724928829; Tue, 06 Jan 2026
 10:42:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251226225254.46197-1-21cnbao@gmail.com> <20251226225254.46197-6-21cnbao@gmail.com>
 <20251227200933.GO11869@unreal> <CAGsJ_4yA83-K7PXiEtyidzF_j6qqKkt92z485KBS9+zGe_rjnw@mail.gmail.com>
 <20251228145041.GS11869@unreal>
In-Reply-To: <20251228145041.GS11869@unreal>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 7 Jan 2026 07:41:57 +1300
X-Gm-Features: AQt7F2qVpIXArh0HsV3sq1RKrv0OCVapLrZHo6-0eziWiogqpS6BzLG8_AyfAb8
Message-ID: <CAGsJ_4yex5MKQkGtFr2zUcg4h0PtsFs2QVcE_NSfiyOn4qBzhQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] dma-mapping: Support batch mode for dma_direct_sync_sg_for_*
To: Leon Romanovsky <leon@kernel.org>
Cc: catalin.marinas@arm.com, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	will@kernel.org, iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Ada Couprie Diaz <ada.coupriediaz@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Suren Baghdasaryan <surenb@google.com>, Tangquan Zheng <zhengtangquan@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 3:50=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Sun, Dec 28, 2025 at 09:52:05AM +1300, Barry Song wrote:
> > On Sun, Dec 28, 2025 at 9:09=E2=80=AFAM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > On Sat, Dec 27, 2025 at 11:52:45AM +1300, Barry Song wrote:
> > > > From: Barry Song <baohua@kernel.org>
> > > >
> > > > Instead of performing a flush per SG entry, issue all cache
> > > > operations first and then flush once. This ultimately benefits
> > > > __dma_sync_sg_for_cpu() and __dma_sync_sg_for_device().
> > > >
> > > > Cc: Leon Romanovsky <leon@kernel.org>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > > Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> > > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > > > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > > Cc: Tangquan Zheng <zhengtangquan@oppo.com>
> > > > Signed-off-by: Barry Song <baohua@kernel.org>
> > > > ---
> > > >  kernel/dma/direct.c | 14 +++++++-------
> > > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >
> > > <...>
> > >
> > > > -             if (!dev_is_dma_coherent(dev)) {
> > > > +             if (!dev_is_dma_coherent(dev))
> > > >                       arch_sync_dma_for_device(paddr, sg->length,
> > > >                                       dir);
> > > > -                     arch_sync_dma_flush();
> > > > -             }
> > > >       }
> > > > +     if (!dev_is_dma_coherent(dev))
> > > > +             arch_sync_dma_flush();
> > >
> > > This patch should be squashed into the previous one. You introduced
> > > arch_sync_dma_flush() there, and now you are placing it elsewhere.
> >
> > Hi Leon,
> >
> > The previous patch replaces all arch_sync_dma_for_* calls with
> > arch_sync_dma_for_* plus arch_sync_dma_flush(), without any
> > functional change. The subsequent patches then implement the
> > actual batching. I feel this is a better approach for reviewing
> > each change independently. Otherwise, the previous patch would
> > be too large.
>
> Don't worry about it. Your patches are small enough.

My hardware does not require a bounce buffer, but I am concerned that
this patch may be incorrect for systems that do require one.

Now it is:

void dma_direct_sync_sg_for_cpu(struct device *dev,
                struct scatterlist *sgl, int nents, enum dma_data_direction=
 dir)
{
        struct scatterlist *sg;
        int i;

        for_each_sg(sgl, sg, nents, i) {
                phys_addr_t paddr =3D dma_to_phys(dev, sg_dma_address(sg));

                if (!dev_is_dma_coherent(dev))
                        arch_sync_dma_for_cpu(paddr, sg->length, dir);

                swiotlb_sync_single_for_cpu(dev, paddr, sg->length, dir);

                if (dir =3D=3D DMA_FROM_DEVICE)
                        arch_dma_mark_clean(paddr, sg->length);
        }

        if (!dev_is_dma_coherent(dev)) {
                arch_sync_dma_flush();
                arch_sync_dma_for_cpu_all();
        }
}

Should we call swiotlb_sync_single_for_cpu() and
arch_dma_mark_clean() after the flush to ensure the CPU sees the
latest data and that the memcpy is correct? I mean:

void dma_direct_sync_sg_for_cpu(struct device *dev,
                struct scatterlist *sgl, int nents, enum dma_data_direction=
 dir)
{
        struct scatterlist *sg;
        int i;

        for_each_sg(sgl, sg, nents, i) {
                phys_addr_t paddr =3D dma_to_phys(dev, sg_dma_address(sg));

                if (!dev_is_dma_coherent(dev))
                        arch_sync_dma_for_cpu(paddr, sg->length, dir);
        }

        if (!dev_is_dma_coherent(dev)) {
                arch_sync_dma_flush();
                arch_sync_dma_for_cpu_all();
        }

        for_each_sg(sgl, sg, nents, i) {
                phys_addr_t paddr =3D dma_to_phys(dev, sg_dma_address(sg));

                swiotlb_sync_single_for_cpu(dev, paddr, sg->length, dir);

                if (dir =3D=3D DMA_FROM_DEVICE)
                        arch_dma_mark_clean(paddr, sg->length);
        }
}

Could this be the same issue for dma_direct_unmap_sg()?

Another option is to not support batched synchronization for the bounce
buffer case, since it is rare. In that case, it could be:

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 550a1a13148d..a4840f7e8722 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -423,8 +423,11 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
        for_each_sg(sgl, sg, nents, i) {
                phys_addr_t paddr =3D dma_to_phys(dev, sg_dma_address(sg));

-               if (!dev_is_dma_coherent(dev))
+               if (!dev_is_dma_coherent(dev)) {
                        arch_sync_dma_for_cpu(paddr, sg->length, dir);
+                       if (unlikely(dev->dma_io_tlb_mem))
+                               arch_sync_dma_flush();
+               }

                swiotlb_sync_single_for_cpu(dev, paddr, sg->length, dir);

What=E2=80=99s your view on this, Leon?

Thanks
Barry
