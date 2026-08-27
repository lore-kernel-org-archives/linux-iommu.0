Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE83643B4B8
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847489; cv=pass; b=iI0hV092uUaMzwF2ueluWl0riKPPjZM/lq9dS9us4b8gHyQ4m/4M0vSwRrABvQB6znxfi1h6dzenZFTb+1FZvbKgPkvplgwVeAYbgQdrkL9WoXJm/UuNJbK95m1aDphVwSMh/czS8IF9EvX0J+YIjMKB3DrPXQBkAZQl8kLtXG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847489; c=relaxed/simple;
	bh=Bl9N4NIOdfVqZOwR5kgJa0N0qb0p2zQM+IJ95fURflg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=By3pt4AJYfKPovN6PbNMuK7XCY+KRBBFCIMUfhK+0db2bHbmVvNgGbsax7NUWrXC9KTVJEZ6hbsS5uUtpzOzM5Pk3GemOEqJufbGXKNVaFXKE9f+NVKpFIuiPNZkXU/rndksKlY4DHZZuzSJMdtiXc1k7E0FyqI05Ds98izAOk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jtJP+eV0; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtJP+eV0"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a5dce0aacdso13807a12.0
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 09:18:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787847486; cv=none;
        d=google.com; s=arc-20260327;
        b=s1btMMTVzP2s1rtIr2NoZJWeLZypjf9fozDbexYhZVfZu0uv6tcYHa6mxKS2z7ODei
         ZZm2XEyosh4RCfNVZQ4lmUj2YlzmkyKb1uPPcOQhZ0YO981BF7IqFoGWo1L9pgQMrKIh
         VDILAdZ8JzIMVoSqFD0rkRDqPtMQ+xSbEBb4HbUisQpFCUGIPLY9g7q5KOIkPyLukTAv
         Sx/8yQ6K9V2I77uYj6qehz1H5qKRzlDZkcZUHMA/aNZU20+8hBIkF/X+5z71zb9P51A5
         YgJnbAzu81V4kobM8x4je6GWTS2WSBg6DTmLCbibb57YfbuwD1HLxE5KFszFwCRVPpxN
         CgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m7ZkTNQPG4sK1dnK6dVjipvBVeIi19Kxu7dkafH7UEY=;
        fh=ja1UWhQ2ciwymFqNC/FUzqUl9Oi+DcWgrCjrLqhJivw=;
        b=nCfEVDGfS/+v0pgRNnAMQa/HOS3LJ4LuslwYIPu7kgS+vlGnjseyYnHerL1dpgfnQQ
         Ucd32lbr1AInvGAYGNTH8CWSD1j1MjIGcymPAeidI+sio0dWiHtOAqO1+vg20sdDOETP
         deaHCdbZd854xVYj5SqUS4qL2yNogarJLjqCqBy031sIDSqdEK8SqJfKJXFbUJ+yaHEc
         HTWgtmrzcBLq22x5QXgHnJzRa3yyoOJJhhrj+OV8GOmUogfQSVcaZ7EQaNo+SAxVcLy5
         Y49ErvYf+iNtsVfOurUaPw1GT/Z0M+LMeACB8trp/L56ao/P6mb3b+e7vKbQp8XENpQY
         RZfA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787847486; x=1788452286; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m7ZkTNQPG4sK1dnK6dVjipvBVeIi19Kxu7dkafH7UEY=;
        b=jtJP+eV09jVNFqaYC4GYWBz9PxdcnFWtjMXltu9F8e3rdYZ3iEU/fPpejI1MAytejf
         YLaLaNWqywq0PPeu+PbUW2f2ky7AL4T6q+52Lrtx1Dmsx+yEAvfyEm5m9M3E5XaAJkJO
         3Zz5x78ii1VRREW4UFHT92eOJ8uABtAdskOcX2+Hg7DEt2KljCQtDwlIh62hL3FfrBVI
         megDHkbtzJFOEmbuWRNWC2+8wC+XYY7I9SE8AxwLbqqSIx+vQ8Hy7vz+Z8rd+7dpzFkh
         6jhg0kIZuoGG/tLee+w1891odvQreo2lRgNITAM/sgRw4rB5qKCmUeMkoK5d4ufoGIfu
         GgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787847486; x=1788452286;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m7ZkTNQPG4sK1dnK6dVjipvBVeIi19Kxu7dkafH7UEY=;
        b=Bn90rBCkuPBi//uELoHKfvqBYvubwcwwcasZfIpnoIKiV3O0WS9KFBDqclOdNQ5J+L
         vgyRxn1v5skcFth9vrOnlrnj0UeJYNS7M27+UCyl+rG7MhFE4qQkpljWcRbhKaHBEy5i
         KT66SVgxhRaXGlQz9aWFLuHmQwgVVmWEj6MXHSBvAteWSMRLg8pqFDAnpaBRoONItDmd
         hqHyLF+hB3lVwwU1VCGJVXLBBuwBb4PmKX0+u/aQH+g7VkMEEb4sM7n7UxGLtQhCVLKq
         LcRYwEaWndpXJjCk4UHOhvc7/FHQNb4d/ZqwMvDKw5o0X8vAFM6x4kb9/inJPzQjThTS
         dBug==
X-Forwarded-Encrypted: i=1; AHgh+RpggBrGQJHyxISejRiL8IsFF2Tgk2ofOSX3Bf57K+cVXnRkxRo3IWDHVz5RW39akcxs3wYGNQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mCxO0kjSBPrJEjd385kfSd01HkHcCFqup/XxVYL8Vl61qPYYlz
	girhfE/9VuQmyk6VxFstuHIWxEV69zUCw67qnsZoGMrzt2+pTTPxfiLa+UvMyasOZXqNR1cvkel
	AuYOAtkFVE8p9sULp5shLRVwPAYdxrNm8MtMiYdw/
X-Gm-Gg: AR+sD117xKyCDbm5MdtgRK41QhZNjB2FOkuWMU2hOiLMRwmyIB1ng6G1/70/njaBuO4
	2XsRTbfANJgXNg4pZsHjyU9SzfuPdKOC84aEa5KK3/4EyHOlkuGcsODT3hVmizJv57a8dt9kCFG
	noGk/hLoaX40mS8x4+r+y5ztPq9dA2qDJbip4xV+hhLT8M+Sbt3JX4ioXL8tvya5V4ZB0s3lNWV
	U8b8fZuc0rNrRz960iVVPM5Sj2wQWqk0U7nPXZySUkTg5xVp1gvWO9cZJpemjE/C6haRkz0wYs3
	h3r2DHZMh6ODVzefYwkJLWoHYVt7TDqqqovBp/4L0CtVvNGx6iQEkt4qRBNnaXHaRsWJJLCY9a8
	vZg==
X-Received: by 2002:aa7:d514:0:b0:672:117e:55d4 with SMTP id
 4fb4d7f45d1cf-6a5f56fbb2amr67818a12.0.1787847485181; Thu, 27 Aug 2026
 09:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260827145855.1616223-1-xiangzao@linux.alibaba.com>
 <20260827145855.1616223-2-xiangzao@linux.alibaba.com> <apBiJk_zhaNjW0er@google.com>
In-Reply-To: <apBiJk_zhaNjW0er@google.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Thu, 27 Aug 2026 17:17:53 +0100
X-Gm-Features: AcwNN1WR6tg9hLH542gIZv7DpP21v-yYeSwugCbSEAU1tVFSn-44FUNwUbQjGhs
Message-ID: <CAFgf54qF=nyLvyOPKB=aLmWJ=C40ZTXeNaBhsdFgnzT3jyLKEA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu: Add __iommu_debug_unmap_phys() to drop refs by
 physical address
To: Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc: joro@8bytes.org, will@kernel.org, jgg@ziepe.ca, robin.murphy@arm.com, 
	baolu.lu@linux.intel.com, kevin.tian@intel.com, praan@google.com, 
	skhawaja@google.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 5:13=E2=80=AFPM Mostafa Saleh <smostafa@google.com>=
 wrote:
>
> On Thu, Aug 27, 2026 at 10:58:54PM +0800, Yuanhe Shu wrote:
> > The IOMMU_DEBUG_PAGEALLOC sanitizer takes a reference on each page at
> > iommu_map() time, keyed by physical address, and the only way to drop
> > them is the IOVA based iommu_debug_unmap_begin()/end().  A path that
> > tears down a page table with mappings still installed has no IOVA to
> > unmap with, so add a physical address based counterpart of
> > __iommu_debug_map() for those paths, sharing the counting loop through
> > __iommu_debug_update_phys().
>
> But the IOVA can be calculated when walking the table from freeing
> context or am I missing something?
>

Ok I am missing that it might not be possible to call in the table
(iova_to_phys) while it is being freed.

> Thanks,
> Mostafa
>
> >
> > Export the iommu_debug_initialized static key, as the generic_pt format
> > code using these helpers can be built as a module.
> >
> > Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
> > ---
> > Build tested as built-in and as a module (AMD_IOMMU=3Dn,
> > CONFIG_IOMMU_PT_AMDV1=3Dm).
> >
> >  drivers/iommu/iommu-debug-pagealloc.c | 30 ++++++++++++++++++++++++---
> >  drivers/iommu/iommu-priv.h            | 24 +++++++++++++++++++++
> >  2 files changed, 51 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iomm=
u-debug-pagealloc.c
> > index 80164df5bab1..a2e55164e6a4 100644
> > --- a/drivers/iommu/iommu-debug-pagealloc.c
> > +++ b/drivers/iommu/iommu-debug-pagealloc.c
> > @@ -15,6 +15,8 @@
> >
> >  static bool needed;
> >  DEFINE_STATIC_KEY_FALSE(iommu_debug_initialized);
> > +/* The generic_pt format code using the key can be built as a module *=
/
> > +EXPORT_SYMBOL_GPL(iommu_debug_initialized);
> >
> >  struct iommu_debug_metadata {
> >       atomic_t ref;
> > @@ -96,7 +98,8 @@ void __iommu_debug_check_unmapped(const struct page *=
page, int numpages)
> >       }
> >  }
> >
> > -void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, =
size_t size)
> > +static void __iommu_debug_update_phys(struct iommu_domain *domain,
> > +                                   phys_addr_t phys, size_t size, bool=
 inc)
> >  {
> >       size_t off, end;
> >       size_t page_size =3D iommu_debug_page_size(domain);
> > @@ -104,9 +107,30 @@ void __iommu_debug_map(struct iommu_domain *domain=
, phys_addr_t phys, size_t siz
> >       if (WARN_ON(!phys || check_add_overflow(phys, size, &end)))
> >               return;
> >
> > -     for (off =3D 0 ; off < size ; off +=3D page_size)
> > -             iommu_debug_inc_page(phys + off);
> > +     for (off =3D 0 ; off < size ; off +=3D page_size) {
> > +             if (inc)
> > +                     iommu_debug_inc_page(phys + off);
> > +             else
> > +                     iommu_debug_dec_page(phys + off);
> > +     }
> > +}
> > +
> > +void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, =
size_t size)
> > +{
> > +     __iommu_debug_update_phys(domain, phys, size, true);
> > +}
> > +
> > +/*
> > + * Physical address counterpart of __iommu_debug_map(), for teardown p=
aths
> > + * that destroy mapped entries without an IOVA.  The OAs must have bee=
n
> > + * accounted by a prior iommu_map().
> > + */
> > +void __iommu_debug_unmap_phys(struct iommu_domain *domain, phys_addr_t=
 phys,
> > +                           size_t size)
> > +{
> > +     __iommu_debug_update_phys(domain, phys, size, false);
> >  }
> > +EXPORT_SYMBOL_GPL(__iommu_debug_unmap_phys);
> >
> >  static void __iommu_debug_update_iova(struct iommu_domain *domain,
> >                                     unsigned long iova, size_t size, bo=
ol inc)
> > diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> > index aaffad5854fc..12528a40bcd8 100644
> > --- a/drivers/iommu/iommu-priv.h
> > +++ b/drivers/iommu/iommu-priv.h
> > @@ -71,11 +71,18 @@ int iommu_replace_device_pasid(struct iommu_domain =
*domain,
> >
> >  void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys,
> >                      size_t size);
> > +void __iommu_debug_unmap_phys(struct iommu_domain *domain, phys_addr_t=
 phys,
> > +                           size_t size);
> >  void __iommu_debug_unmap_begin(struct iommu_domain *domain,
> >                              unsigned long iova, size_t size);
> >  void __iommu_debug_unmap_end(struct iommu_domain *domain,
> >                            unsigned long iova, size_t size, size_t unma=
pped);
> >
> > +static inline bool iommu_debug_pagealloc_enabled(void)
> > +{
> > +     return static_branch_unlikely(&iommu_debug_initialized);
> > +}
> > +
> >  static inline void iommu_debug_map(struct iommu_domain *domain,
> >                                  phys_addr_t phys, size_t size)
> >  {
> > @@ -83,6 +90,13 @@ static inline void iommu_debug_map(struct iommu_doma=
in *domain,
> >               __iommu_debug_map(domain, phys, size);
> >  }
> >
> > +static inline void iommu_debug_unmap_phys(struct iommu_domain *domain,
> > +                                       phys_addr_t phys, size_t size)
> > +{
> > +     if (static_branch_unlikely(&iommu_debug_initialized))
> > +             __iommu_debug_unmap_phys(domain, phys, size);
> > +}
> > +
> >  static inline void iommu_debug_unmap_begin(struct iommu_domain *domain=
,
> >                                          unsigned long iova, size_t siz=
e)
> >  {
> > @@ -101,11 +115,21 @@ static inline void iommu_debug_unmap_end(struct i=
ommu_domain *domain,
> >  void iommu_debug_init(void);
> >
> >  #else
> > +static inline bool iommu_debug_pagealloc_enabled(void)
> > +{
> > +     return false;
> > +}
> > +
> >  static inline void iommu_debug_map(struct iommu_domain *domain,
> >                                  phys_addr_t phys, size_t size)
> >  {
> >  }
> >
> > +static inline void iommu_debug_unmap_phys(struct iommu_domain *domain,
> > +                                       phys_addr_t phys, size_t size)
> > +{
> > +}
> > +
> >  static inline void iommu_debug_unmap_begin(struct iommu_domain *domain=
,
> >                                          unsigned long iova, size_t siz=
e)
> >  {
> > --
> > 2.43.5
> >
