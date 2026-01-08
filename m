Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADC32F39C7
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 13:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767878538; cv=pass; b=Lxj85WaT2OWi1MOMxjgAYWK3dGLYpQS2eRRsNv9GPHZ5hbWNtwiJxaainHe4sJG+5VeNRAk9cypbMI2cUx5SNXl8m6XJRKvpycryK7jTTvDO+9qnFtSJyUY6iaFRiO0XAskAlqZ0VMMBs4T6aKlL4uLSsXxoyOQD1b4u8DkqBGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767878538; c=relaxed/simple;
	bh=a3LUib4hyDPdZLxfKqGnE9GqL++i+k4W4dayaOhhNZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B20km4E1IOgFamizjPGGijfdwO0XAPj225Nkh0N47RLWM+Rjz5rp1CvcgvNn3k33L4XvA2tPDjfSmqKDzlSv7ehGYd8GQUjbfJ/xdhTYRurcJ+eTuD4ziZhPPaw8eUxwyvGe7XV/vzXCoNFd4iMthTKxyz08TNkUocrPHiLGLCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HJG91yAV; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HJG91yAV"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ffbaaafac4so725351cf.0
        for <iommu@lists.linux.dev>; Thu, 08 Jan 2026 05:22:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767878529; cv=none;
        d=google.com; s=arc-20240605;
        b=Q9vZ4OQChqej8jk9V0Z1SNtpWB+mGDkh+d9kw5tEj0tAIJTKWgs70ApFKRvnhelI94
         eLBuQPHswemFwDiqWqHBA/IPJ/0dbZst66hoRdnTi+48zvwyXVnAsNKYEs4yeaqwqLnc
         oDwM7dyWAE1abEWkLTgRznIbKflbrcJQJf9blRskPGloK8W51v/ZOl+7Jrny27MlkjR8
         icip2IocaLeEt307RU3yv3RQ9UjpxQB3tskAq9/5be8z7kh3tiRgAbqHICZvQWLsk7K5
         Lcr5ZLGssFaPIP3Uh5CjcRc6o8MYmqZwCYEvnZhtQCwZ/dAFRBj7HYRn5w1Exgj8g4Oi
         Th+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UUwpAxZ0PDYNZc3h1MMX+qPvPoKglabLUwPyaMJykIM=;
        fh=nxdCfR/33i1WBL6DYcvFt+PFQitj6L8Sqbq46z6w2yo=;
        b=L+/pvzYLnv3aFHaIaKrq6syNukCrA+6BDb1I3u0fJuQZLKNJizxaofw3pnYP+Drii9
         S7DRkdi6K4hK8kWrQRHRMaQLyhboPjqDu/mPhG2hzjQP1yUqSrb41BtCCtL1ahHIwx21
         9W9FGCRulaRMHGA9dNoy54r8e4Gj1S1QZM0kDUBWVP8uqfyozYfy7dnZeJef7UQ9Ci3Y
         XNa+qxAiDroN6QnMloia2WbWz9vqruFImmtmLH9/+IIGNyqO3IDW1y0FV2ACSQOn43Ur
         lIIeO92+D/xqRl18rZYF9tTvLOYVO+Ge6bmMGTZAFENdafZPYHHLFHsbM1cnzzFkG4DJ
         MVkQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767878529; x=1768483329; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUwpAxZ0PDYNZc3h1MMX+qPvPoKglabLUwPyaMJykIM=;
        b=HJG91yAV6nK2SJZB2e30GUAI5KQcbfGGXaBC7IBNdfl+nngvH0Bt0su8y/6QdqhMPD
         6PIepdhQWiaPdSdnc3O2U58E/SXeYdaiJlS1oHSOiul9H5qysgKmPY2f2E317uzkJg2x
         oSUKhXJyxuivdekvn3S5kmBtIutC7RKcLyvcrguAaztfZJxDJ7F77vwx+tMCRuSUswYH
         nmGYAa2+v2b6ieTIzhlDEIYpP4TLIBL3JbhsvoqYSdq+8wEWvTfMD6540zwZ13egZ7ju
         boMRihHjMr4p7P3xNP4sWFau3HiuU0sKu8C9FN3cZINo92px3P+Ilo9grPfKA92CezXd
         ajEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767878529; x=1768483329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UUwpAxZ0PDYNZc3h1MMX+qPvPoKglabLUwPyaMJykIM=;
        b=vFObSqVB6rDxPqsKB/gRcTYA3N7iI81WWaOw1SHWkIVNJQOVdyDvCRryZNQq40oOlq
         pF9wxBSUxgNU1xSOWQlvkB8Zwi2Hu4HhFX1QvkG+LLTw/VxhTRz3N19+Ld7iVTNb8pXQ
         Ux5vkVo8ctFCpCa4+9Sd0rvbEq/eCdA+pqRzFUR1F3EH1SIyt2YcZw8R6r/3T16oec1F
         Hxr9LGFw+AWfNTqJft+22yAe4TLqbdfLC+BHDj6tv3mVsLtpltG/P4YddzpHXFqtE4Xa
         fkqFAjNYNRxX7iofbMA0jnOl6RuAGouubU/DCa2jHfglLtTUpD1HEqrmSNmm50Dx2L9v
         EXFQ==
X-Gm-Message-State: AOJu0Yznvd/3f4WknIvckskE3hLCJXHaw+s7JNAK0atOgE4UOeriYK/F
	pHTLl+KykCOVkB8lMr9W4GUzZ0dyb7n4ZOxRGVRilfW0BqRSXVII9cSQoM1Itz36AYh52y50M1H
	la5mZpzgT6g6hBS0oCLYVLjjcEwaxDUOb3/IZosQH
X-Gm-Gg: AY/fxX5BE1YzKqECOSF56gy9kxej97AxaiH31hy1Uja7NAE/uug+5DbzotRpW0F3fYU
	4Zb4bdaqSJ6iiCQMOR/kuymlfAhYWDY/2ha1eXEr0mmiTNwN240Q6cbfw/pzbrJYPJ3LOL22fD8
	2oX0OZHx+IKbSbpvw3YwJIvSb8TSyJk7z8FPCXZr3C9cNLP8wecBCkNDIQ4eAPkz05XMt8JtOOL
	bLW2yHlJFVJW7oyFejUkE6lWWP2yqQLwR7IKKGvbeOpGa6EDX5C6SmJGusoo4KjstfoPTZyS/PB
	lhAmzp+wn4SAfvGXxMf9ftxfDFAndg==
X-Received: by 2002:a05:622a:290:b0:4f1:9c3f:2845 with SMTP id
 d75a77b69052e-4ffc094e8e8mr8148651cf.9.1767878528486; Thu, 08 Jan 2026
 05:22:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260108113846.56179-1-smostafa@google.com> <56c39e62-0417-495d-a40e-99180a107777@arm.com>
In-Reply-To: <56c39e62-0417-495d-a40e-99180a107777@arm.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Thu, 8 Jan 2026 13:21:56 +0000
X-Gm-Features: AQt7F2oJd-G6BRgQsOUJ1Fsn5-oRiR5Pkxii3P307v5vqF9EVKhsthRl8tsstiI
Message-ID: <CAFgf54r_xyyu46ADB5rLj5jZ+doCVjyVaJaQZf5bnYfKZBkF7g@mail.gmail.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Drop DMA API usage for CMOs
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, will@kernel.org, joro@8bytes.org, 
	Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 12:52=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2026-01-08 11:38 am, Mostafa Saleh wrote:
> > As part of the KVM SMMUv3 series[1], we are trying to factor out
> > the kernel specific code from io-pgtable-arm so it can also compile
> > for the hypervisor.
> >
> > Jason pointed out that the DMA-API calls are not really needed [2].
> >
> > Looking more into this. Initially, the io-pgtable API let drivers
> > do the CMOs using tlb::flush_pgtable() where drivers were using the
> > DMA API (map/unmap_single) only to do CMOs as the low-level cache
> > functions won=E2=80=99t be available for modules.
> >
> > This was later moved to the core code [3], with possibility to
> > convert it to full blown DMA-API code if there was a use case.
>
> I don't understand that sentence at all.
>
> > However, no such use case appeared, and we can simplify the code
> > slightly by doing CMO directly instead of going through the DMA-API
> > functions just for CMOs.
> >
> > Although HTTU is not used at the moment, leave the
> > arch_sync_dma_for_cpu() in __arm_lpae_free_pages() as this is not a
> > hot path.
> >
> > Removing the DMA-API will also remove some extra checks ensuring that
> > the IOMMU can deal with physical addrs. we can add those check at
> > page table creation time (Something as use_dma_iommu/is_swiotlb_active
> > However, that seemed a little too much as Linux doesn't support such
> > topologies anyways.
>
> NAK - io-pgtable is regular driver code doing what is absolutely a DMA
> mapping operation. How would Panfrost calling arch_sync_* signal to hyp
> that the page is now being used for DMA so needs mapping/pinning at
> stage 2? We can't even say that that doesn't apply to "real" IOMMU
> drivers, since there do unfortunately exist cases where an entire "stage
> 1" SMMUv3 is upstream of a "stage 2" SMMUv3 such that it's only workable
> if the former is assigned to EL1 as just another black-box device, while
> only EL2 knows about the latter.
>

This is not about Stage-1/Stage-2 assignment or pinning, my simplistic
understanding is that we don=E2=80=99t deal with cascading IOMMUs, so the D=
MA
API here must go through DMA direct which boils down to CMOs.

My intention was to call CMOs directly instead of calling the DMA API
to make the code slightly portable (And EL2 can provide its
arch_sync_*)

> If "pagetable creation time" means alloc_io_pgtable_ops() as I've taken
> it to, how do you specifically propose to check that pages which haven't
> been allocated yet will definitely be valid for DMA in future? Also note
> that the only reason for the virt_to_phys() check (which *has* often
> caught genuine driver/platform configuration issues to a degree that I
> would be very uncomfortable removing it) is basically laziness, in that
> nobody's got round to doing the work to be able to keep track of kernel
> addresses separately from the DMA addresses in the tables themselves,
> and thus allow visibly-remapped pagetables - every now and then there
> arises a situation where that would be really useful, so it is still on
> my wishlist.
>

I see, thanks for the explanation. I was imagining checking if SWIOTLB
is active. AFAIK, it will be set if the device has a smaller DMA mask
than the CPU.
Probably, that doesn't cover all the cases, but I thought that any
system with such constraints would also be unusable with the current
implementation. However, the virt_to_phys() check would at least make
debugging easier.

Anyway, I will drop this.

> Frankly if KVM is going to have increasingly divergent requirements and
> assumptions about pagetables, then it should have its own pagetable code
> like it does for the CPU.
>

So far, KVM has no special requirements for the pagetable, it only
needs to provide implementations of CMOs and memory allocation.
In the last version __arm_lpae_alloc_pages() implementation was fully
different between the hypervisor and the kernel, I was trying to
simplify that.

Thanks,
Mostafa

> Thanks,
> Robin.
>
> > [1] https://lore.kernel.org/linux-iommu/20251117184815.1027271-1-smosta=
fa@google.com/
> > [2] https://lore.kernel.org/linux-iommu/20251216005834.GC31492@ziepe.ca=
/
> > [3] https://lore.kernel.org/linux-iommu/7c5584d3efa61ee6b0b87efb72f24f3=
2852aafb7.1438195011.git.robin.murphy@arm.com/
> >
> > Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >   drivers/iommu/io-pgtable-arm.c | 39 +++++++--------------------------=
-
> >   1 file changed, 8 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-=
arm.c
> > index e6626004b323..0da9195155ec 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -15,7 +15,7 @@
> >   #include <linux/sizes.h>
> >   #include <linux/slab.h>
> >   #include <linux/types.h>
> > -#include <linux/dma-mapping.h>
> > +#include <linux/dma-map-ops.h>
> >
> >   #include <asm/barrier.h>
> >
> > @@ -254,7 +254,6 @@ static void *__arm_lpae_alloc_pages(size_t size, gf=
p_t gfp,
> >   {
> >       struct device *dev =3D cfg->iommu_dev;
> >       size_t alloc_size;
> > -     dma_addr_t dma;
> >       void *pages;
> >
> >       /*
> > @@ -271,32 +270,10 @@ static void *__arm_lpae_alloc_pages(size_t size, =
gfp_t gfp,
> >       if (!pages)
> >               return NULL;
> >
> > -     if (!cfg->coherent_walk) {
> > -             dma =3D dma_map_single(dev, pages, size, DMA_TO_DEVICE);
> > -             if (dma_mapping_error(dev, dma))
> > -                     goto out_free;
> > -             /*
> > -              * We depend on the IOMMU being able to work with any phy=
sical
> > -              * address directly, so if the DMA layer suggests otherwi=
se by
> > -              * translating or truncating them, that bodes very badly.=
..
> > -              */
> > -             if (dma !=3D virt_to_phys(pages))
> > -                     goto out_unmap;
> > -     }
> > -
> > +     if (!cfg->coherent_walk)
> > +             arch_sync_dma_for_device(__arm_lpae_dma_addr(pages), size=
,
> > +                                      DMA_TO_DEVICE);
> >       return pages;
> > -
> > -out_unmap:
> > -     dev_err(dev, "Cannot accommodate DMA translation for IOMMU page t=
ables\n");
> > -     dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
> > -
> > -out_free:
> > -     if (cfg->free)
> > -             cfg->free(cookie, pages, size);
> > -     else
> > -             iommu_free_pages(pages);
> > -
> > -     return NULL;
> >   }
> >
> >   static void __arm_lpae_free_pages(void *pages, size_t size,
> > @@ -304,8 +281,8 @@ static void __arm_lpae_free_pages(void *pages, size=
_t size,
> >                                 void *cookie)
> >   {
> >       if (!cfg->coherent_walk)
> > -             dma_unmap_single(cfg->iommu_dev, __arm_lpae_dma_addr(page=
s),
> > -                              size, DMA_TO_DEVICE);
> > +             arch_sync_dma_for_cpu(__arm_lpae_dma_addr(pages),
> > +                                   size, DMA_TO_DEVICE);
> >
> >       if (cfg->free)
> >               cfg->free(cookie, pages, size);
> > @@ -316,8 +293,8 @@ static void __arm_lpae_free_pages(void *pages, size=
_t size,
> >   static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries=
,
> >                               struct io_pgtable_cfg *cfg)
> >   {
> > -     dma_sync_single_for_device(cfg->iommu_dev, __arm_lpae_dma_addr(pt=
ep),
> > -                                sizeof(*ptep) * num_entries, DMA_TO_DE=
VICE);
> > +     arch_sync_dma_for_device(__arm_lpae_dma_addr(ptep),
> > +                              sizeof(*ptep) * num_entries, DMA_TO_DEVI=
CE);
> >   }
> >
> >   static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgta=
ble_cfg *cfg, int num_entries)
>
