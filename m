Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C820396B99
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779138362; cv=pass; b=LQ06hjNqI3XuRIuE01VuzQtmb/luon22tXAK2yCTUNuA6FcliGMf85tQolxoOfLtPPZIPgLK+2qqnoOl3Cdwce3hpqke1WjzgK2JSECp+P3E3adsd06oVt1+RbOkAnwxSAkviI+o1ScBjc3wgLdiiCBzgxGJ1yRO/YELW/k3954=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779138362; c=relaxed/simple;
	bh=neSpT0cJH2Dzv88zkoZu5BKRcd3x3NbQE1TjpkeO0vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfIjshtvL74V5ixG9VK8MNhRUvhds8ra7nooN1CXcws8NYSpsFvQgmgJFL5Si7ZImUDEi3Hr/8TEXwMCJ8Hu9hVrofhLvbu9mSd2FlEwwud/6spKOgDVHZKTYwk5tLUHWMUrxVdzz6EV0yloFCZCLhzMgZ6njnfeormfLYYgF2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQ3afz/x; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQ3afz/x"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bcceb394417so338587866b.0
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 14:06:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779138359; cv=none;
        d=google.com; s=arc-20240605;
        b=HawTOkv9zwunSe+oOy2XiaXkf32M4esM9a17DO7HKaJVDoK5JHgJhPNMzzAR4/dhA4
         +gl+BcSOzCN/mhSWrs2QhBS/Ml2Yk5nFUgKLrNPi/HnpZ4hGh1G3w5xgLVGXVnS2VAq7
         bJ/sqFKAxBI0rQbTPqcbTVQFIKYcw6BDfV1aKnlYlT/RLlTOXCZAQWfzEWGAS21IzvRP
         brHXMEJ0FV0D+EPsQs2ihGJynLLRGDrASniMxmHYt8K/bgOC7JpFGca8aBxHgPdnBqda
         PpBNUy1OrEa3qjRdqdJDI1kej2QaUZ6vCgbskSAdfj4jR048Z7pQvc10DShw9mVK5Gpt
         +fmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TLMXl0qpkPUxInkyk4MfYDrsORdc6W4QRpC2Vx6JBpk=;
        fh=qxAlUEwuEzqqLxUEj0UTWwbdmjgKhoHBmaz68chIynw=;
        b=VXSnFQ+JIJf8PjH2XrgYqoux/FbRqFfBfaTO29tyCnA574zz9y4CSb2vC2ENpImRzi
         0FkYLQH/KLCTJt/jZcndC9GYtE0EbYtXvWq3jyXCnj8kqF45jIku1HuYmN0LGcsvbabq
         FZAM2W+XY81e3jZxpoZlrDUWjkjRICchXt5JqRlbfR1mXIsRV+GqUvUClAxexw5Hjyda
         25vgnV3IKq+cwIle11deHnRAeG9KLdLuYiqmJQib0BMwg0wjWRcIl/l9sDnHw9lkDOp+
         /1EdVDbG7f/8FJae5O+8QD0mxfYAVCZwY6eEppiV4aSoYchz082T7IyPoIj9NXoCbNGy
         Y0rQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779138359; x=1779743159; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLMXl0qpkPUxInkyk4MfYDrsORdc6W4QRpC2Vx6JBpk=;
        b=kQ3afz/xxnFq8NFqLLpofGcCUNO7BzPUhaUGZmfbpolkulVdjm1xI+T/8EHjJXE3Vy
         gUyptk6XR4IXc1trz+7k0kkGGqLGLlpO+ExVQzda5ozQJGW3OAa18F1Nre53+EY6V5sv
         aMGIzH6CchrfB8mrqQddrT2aE2O9OsE/fiWKTSBRW8LAqFPfNzKlb5OmIV4h9zsNd01c
         P2A6HFWnAddfkVgQ6oiiO2MuiLxzVXfDDFpw4QDAcvUkbtEV/du3cmVaY7NG40LvFSa9
         2B3LDAlejlkN34Uyh/AgQsDjrI6nqlw/fn0MQg19MFp9Iy00O6OKwYOIbMiLa4zctUVX
         ZMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779138359; x=1779743159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TLMXl0qpkPUxInkyk4MfYDrsORdc6W4QRpC2Vx6JBpk=;
        b=CXldzh+rYIQ2JbqOa7ycyA9B8J+DcuOZFy+x2yHqeUHCmhKdNADpjxXFrEvo0gEuhK
         i3bJ/6PoUXNvXxkDjaVeEk5Wh23YHUn75PAAm73W0yHaXZ0Hrgyx//I1ELH497Qjy8iN
         n2a9dWXpaIHrysBfhjh6B0J4CmyiRz9HbH9f5k2ywdvR8lfCHjFOUFvCV3PzGAElbeuv
         8B+1jQOlvQRCSqZUvwGeXcH8YNzBGfv7TfEW//6Rk+B2Boop1M5tCf4/Wb2pZAyVkDOT
         R6iGLX5af5Qw1q2lB987S74gVW4clIilvoZL3jiFBSbYbwlCiOYIpsAJRxkL/95IqM8x
         UUVg==
X-Gm-Message-State: AOJu0YzTOm7n3I2MiH/EYZifpOStWp8pPvDvX79H5nqA/kZAd9J69z6c
	mTNq9JpY7jgdhnDRNWmSDnDTwGyC98BTDkffOV9qR0z7WrKbF7V+gD0jHFQDyyeGGT1Pj9vUMlj
	435qRLqWvrlrDlOHsbc8+sNcS3icuiWk=
X-Gm-Gg: Acq92OF77tCt4n0XYGg47r5ytMIIwv9hgXuOvkC75BUi+5xJyFSYzQTQJJBmjqd3Q5H
	mQfYNLmCm7MD+g4VEwwL1unrY5nC95Km+m1l+QtX5ED/36Z/uJS11NUeeWic29e9Z/MlwrD0tdE
	XZfqckiqn4u4tDULFIzEI5sDRKQ1qXi+hrZRd3pktZLS/qLkfxdLnQeg/JBG4VJNCD2b4jquEzb
	VnUVC6q46ALDdAq9Hz+lA5sfqAGNfUHmVPubemZLgSe4H24wog/aJrRpa/1NsQX0WCWvtVmLfZO
	KJK+aYHII0CHnPazTqtGtHkSM91I/6SuIT57BscQFSn96lWCYwfa0TvIVzkZzFUHjmBqZcFi8x1
	A2jA4GrQzph7xVirqbyZTbA88twY8RJ3sRdk6hWlM8m1XQk6OUKmtHVRUbg==
X-Received: by 2002:a17:907:3c86:b0:bd6:5ab3:a63a with SMTP id
 a640c23a62f3a-bd65ab3b33cmr512415666b.45.1779138358549; Mon, 18 May 2026
 14:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260517042955.2218649-1-rosenp@gmail.com> <d6366078-3eb9-4445-9f91-27e1dc15970e@arm.com>
In-Reply-To: <d6366078-3eb9-4445-9f91-27e1dc15970e@arm.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 18 May 2026 14:05:47 -0700
X-Gm-Features: AVHnY4L2wE5z42c0QPh661vX8FWMfmmLBB6jtPfJ2cHD8NRF5bSBUk_GS03Nigg
Message-ID: <CAKxU2N--t89Lj--8Fk2wdJDZrMwV1sqyO_iggSXmBLxMy7KgDQ@mail.gmail.com>
Subject: Re: [PATCH] dma-direct: Clear pages before coherent remap
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 5:40=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 17/05/2026 5:29 am, Rosen Penev wrote:
> > Clear pages through their page mapping before creating a coherent
> > remap for dma-direct allocations. Some architectures implement the
> > coherent remap as uncached memory, where the generic memset() path may
> > use cache-only zeroing instructions that are not valid for the returned
> > CPU mapping.
>
> Which architectures?
PowerPC 44x See:
https://lore.kernel.org/all/2e3acfe63d289c6fba366e16973c9ab8369e8b75.163180=
3922.git.christophe.leroy@csgroup.eu/

Fixing it here exposed similar issues elsewhere. I've submitted
patches for those.
> I'd fear they're just broken in that case - there's
> every chance that once the caller gets a coherent allocation back, they
> could also invoke memset() on it - either explicitly, or automatically
> inserted by the compiler for a structure/array initialisation, or if the
> buffer subsequently gets mmap()ed to userspace then who knows what. If
> that's really a problem, this patch isn't going to solve it.
>
> It's rather the point that we clear the buffer the same way that the
> caller is subsequently going to access it (not least to minimise the
> chance of any other possible weird coherency side-effects).
>
> Thanks,
> Robin.
>
> > Keep the existing memset() for non-remapped allocations, but avoid
> > normal memset() on the remapped coherent allocation path.
> >
> > Assisted-by: Codex:GPT-5.5
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   kernel/dma/direct.c | 20 ++++++++++++++++++--
> >   1 file changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 583c5922bca2..76f7bf43bd28 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -8,6 +8,7 @@
> >   #include <linux/export.h>
> >   #include <linux/mm.h>
> >   #include <linux/dma-map-ops.h>
> > +#include <linux/highmem.h>
> >   #include <linux/scatterlist.h>
> >   #include <linux/pfn.h>
> >   #include <linux/vmalloc.h>
> > @@ -104,6 +105,15 @@ static void __dma_direct_free_pages(struct device =
*dev, struct page *page,
> >       dma_free_contiguous(dev, page, size);
> >   }
> >
> > +static void dma_direct_zero_pages(struct page *page, size_t size)
> > +{
> > +     unsigned long count =3D PAGE_ALIGN(size) >> PAGE_SHIFT;
> > +     unsigned long i;
> > +
> > +     for (i =3D 0; i < count; i++)
> > +             clear_highpage(page + i);
> > +}
> > +
> >   static struct page *dma_direct_alloc_swiotlb(struct device *dev, size=
_t size)
> >   {
> >       struct page *page =3D swiotlb_alloc(dev, size);
> > @@ -268,6 +278,13 @@ void *dma_direct_alloc(struct device *dev, size_t =
size,
> >       if (remap) {
> >               pgprot_t prot =3D dma_pgprot(dev, PAGE_KERNEL, attrs);
> >
> > +             /*
> > +              * Zero via the page mapping before creating a potentiall=
y
> > +              * uncached remap.  Some architectures cannot safely run =
normal
> > +              * memset on uncached memory.
> > +              */
> > +             dma_direct_zero_pages(page, size);
> > +
> >               if (force_dma_unencrypted(dev))
> >                       prot =3D pgprot_decrypted(prot);
> >
> > @@ -283,10 +300,9 @@ void *dma_direct_alloc(struct device *dev, size_t =
size,
> >               ret =3D page_address(page);
> >               if (dma_set_decrypted(dev, ret, size))
> >                       goto out_leak_pages;
> > +             memset(ret, 0, size);
> >       }
> >
> > -     memset(ret, 0, size);
> > -
> >       if (set_uncached) {
> >               arch_dma_prep_coherent(page, size);
> >               ret =3D arch_dma_set_uncached(ret, size);
>
