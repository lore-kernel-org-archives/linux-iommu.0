Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B43F312821
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583891; cv=none; b=LwyV3S3cBNvm8RdE0+GBrknLdRgsP5i3xN0fRJl1Dt3TIpqLV5X/6IKFjhoXWFTrf/lGBBmbJO6COeyj6h51c/vTBQeis8eQDQb+/KCmToLJf3jkiuBapWZ4BYj4fi520UXo3HpGfzSZYjCdUsBa9cwHZ5pv4G+I1WpuPbPScbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583891; c=relaxed/simple;
	bh=BpWkwcvk+ttbEIODEe3Jc2OawoiRUJhFdv7D7duHz60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRMKeOGlYav34BTsnG5yZ0Oae5ZPaQwSDWuhRDukECIa7oZXWeajrD1erUGoULnVUIosHUB50iw38RUIbUi3R844T7sHZloEnlU+hOvwKpRV8UqdDwoViltyaJxDrsJwlgtsIALLA55t4FFoA4C9LxAOixu7krWwbOY1RerWDaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1DDoihR8; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1DDoihR8"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ecfafb92bcso7421cf.1
        for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 09:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761583888; x=1762188688; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vt6j/nV+hL/aatsW20+tI1ruqJfiHv93rNFzUtULteA=;
        b=1DDoihR80Hq58R08rImjDw4YEbqH+R3BRQK6qNOKuj4hfK5Lzr8zYuZ2oqmAXAyGkg
         gH34AY1tJiQ7Nj3jsAEfYZQLzF72UzCU6JGbaCnmIDzXBfp02Vrate4OOI3Om/ZSVWQe
         U4UsQyf2MWuZ7AfcTY94xuNm8tlFpN3gcHfLuZzYqSlPL89nIhbj1BU1VZgI+gqy68mw
         sl5HfS7AWylIiMsDgx3aFuvhtWoiB6sgZhU4O/IZtfua6rnCzqesE4DaDSj+pcDdQJy5
         j29fnEA67kBuBvrVQOaR+ScWGttHXnbyyPsafgzD8ujp1TZDZQiInSLovcJiTlrtv6fd
         j+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761583888; x=1762188688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vt6j/nV+hL/aatsW20+tI1ruqJfiHv93rNFzUtULteA=;
        b=uqMuobv41p3u1BMEwZkOWSVeN7Jg0GIigV4pl2M7Sq30kzJAT106nzV41JcdPh50DB
         C/JweV4mIYsCricQ2+p4v4aXznqDhetsni1NR/Ag5vipSBb4nIRknxLXRzNt+mXfPzWK
         yNeor9BMvklN9y4PB5p3TyVabGqrDx+t/Fl0jIWiorqgrxEKDV/UIYcH1yU+BV8BfEhR
         Rns+ASuMcrUw3g/7kw8ZuD7QHRx5BO+Vwr1HCH9zPsBFZ/h82EEblW9Y+hmLk2JDXkfI
         aqV0/JM3zb0QjDwH9YxL4unpjUbrsRX2gkWZfpmQEWK4kC9tdmztPPaby7KaOrtbhgi6
         mEAg==
X-Forwarded-Encrypted: i=1; AJvYcCWgGwYVCVZ+4ddRIsanIA/g3/K68SA0i0guoDBumOuDWmDj27Z8nprrM+lpMndNJkw1ViZ0pg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLmOtsFmjmJev0yWtOHhTDF6BQB1hJLjMHJu2AGU2k2Le3qTl7
	DDAQDEmZxVyweWpKklC0qEZmzEX1rwKzZjWjF9hyGc966YmpP/6742I+/r+mDa+7HiO7FsWRmaa
	3rZ0CgJSbFdgc/ypBn6BHiq4MeqmKuJy8DAsRojDF
X-Gm-Gg: ASbGnct7+VvVD7/amEROpqCGtxcQghL2COenB6i5BYApQDFSTP2YI6s43yyyjHUYbeg
	FTNlu9Zse5cf82baD0SUjEM2LQTfw18kh9JUtlVqqc5vS28ccO/YSCiN0YXGVKn7BUV1D7kn8H2
	yZvuliWp51b4ty/DuuZs3spSZwB6fuGOhUnzelUBdCkybUqHFT3eOvTUwwiMtk7oZs6sc1WHucx
	aGZ97emzlMOh4jyAg5/eduUjZyEzM+D4pee4xfwYcSV25p7n4lCC9Os+Oh+DclgD42bKVVIzyhF
	4C2j5S5bCbDT8nhIhie9sDABgw==
X-Google-Smtp-Source: AGHT+IHSf6XBB13zoI4VmxW32VJTBDOaDjvKRIRZqFXtSwyDht+a+iclLHapLQWD5ps6mgchrQFlzxXZLRPkueBpaF8=
X-Received: by 2002:ac8:5f84:0:b0:4e8:b4dc:4c58 with SMTP id
 d75a77b69052e-4eba229dfc9mr12906661cf.12.1761583888008; Mon, 27 Oct 2025
 09:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com> <5-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <5-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 27 Oct 2025 09:51:16 -0700
X-Gm-Features: AWmQ_bk-2Q_pdXrZkw1tD93f2ALLMLAZxHMjv2ygRXcaD9JlPPU-k11kjCl7bDI
Message-ID: <CAAywjhTkm89boLCLibkhvsa3qJ0n4p37VF+e9sYdW0rvhTCnEw@mail.gmail.com>
Subject: Re: [PATCH v7 05/15] iommupt: Add iova_to_phys op
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, 
	Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
	James Gowans <jgowans@amazon.com>, Kevin Tian <kevin.tian@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 11:21=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> iova_to_phys is a performance path for the DMA API and iommufd, implement
> it using an unrolled get_user_pages() like function waterfall scheme.
>
> The implementation itself is fairly trivial.
>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/generic_pt/iommu_pt.h | 105 ++++++++++++++++++++++++++++
>  include/linux/generic_pt/iommu.h    |  19 +++--
>  2 files changed, 119 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_=
pt/iommu_pt.h
> index 564f2d3a6e11e1..5ff1b887928a46 100644
> --- a/drivers/iommu/generic_pt/iommu_pt.h
> +++ b/drivers/iommu/generic_pt/iommu_pt.h
> @@ -17,6 +17,111 @@
>
>  #define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
>
> +static int make_range_ul(struct pt_common *common, struct pt_range *rang=
e,
> +                        unsigned long iova, unsigned long len)
> +{
> +       unsigned long last;
> +
> +       if (unlikely(len =3D=3D 0))
> +               return -EINVAL;
> +
> +       if (check_add_overflow(iova, len - 1, &last))
> +               return -EOVERFLOW;
> +
> +       *range =3D pt_make_range(common, iova, last);
> +       if (sizeof(iova) > sizeof(range->va)) {
> +               if (unlikely(range->va !=3D iova || range->last_va !=3D l=
ast))
> +                       return -EOVERFLOW;
> +       }
> +       return 0;
> +}
> +
> +static __maybe_unused int make_range_u64(struct pt_common *common,
> +                                        struct pt_range *range, u64 iova=
,
> +                                        u64 len)
> +{
> +       if (unlikely(iova > ULONG_MAX || len > ULONG_MAX))
> +               return -EOVERFLOW;
> +       return make_range_ul(common, range, iova, len);
> +}
> +
> +/*
> + * Some APIs use unsigned long, while othersuse dma_addr_t as the type. =
Dispatch
> + * to the correct validation based on the type.
> + */
> +#define make_range_no_check(common, range, iova, len)                   =
\
> +       ({                                                              \
> +               int ret;                                                \
> +               if (sizeof(iova) > sizeof(unsigned long) ||             \
> +                   sizeof(len) > sizeof(unsigned long))                \
> +                       ret =3D make_range_u64(common, range, iova, len);=
 \
> +               else                                                    \
> +                       ret =3D make_range_ul(common, range, iova, len); =
 \
> +               ret;                                                    \
> +       })
> +
> +#define make_range(common, range, iova, len)                            =
 \
> +       ({                                                               =
\
> +               int ret =3D make_range_no_check(common, range, iova, len)=
; \
> +               if (!ret)                                                =
\
> +                       ret =3D pt_check_range(range);                   =
  \
> +               ret;                                                     =
\
> +       })
> +
> +static __always_inline int __do_iova_to_phys(struct pt_range *range, voi=
d *arg,
> +                                            unsigned int level,
> +                                            struct pt_table_p *table,
> +                                            pt_level_fn_t descend_fn)
> +{
> +       struct pt_state pts =3D pt_init(range, level, table);
> +       pt_oaddr_t *res =3D arg;
> +
> +       switch (pt_load_single_entry(&pts)) {
> +       case PT_ENTRY_EMPTY:
> +               return -ENOENT;
> +       case PT_ENTRY_TABLE:
> +               return pt_descend(&pts, arg, descend_fn);
> +       case PT_ENTRY_OA:
> +               *res =3D pt_entry_oa_exact(&pts);
> +               return 0;
> +       }
> +       return -ENOENT;
> +}
> +PT_MAKE_LEVELS(__iova_to_phys, __do_iova_to_phys);
> +
> +/**
> + * iova_to_phys() - Return the output address for the given IOVA
> + * @iommu_table: Table to query
> + * @iova: IO virtual address to query
> + *
> + * Determine the output address from the given IOVA. @iova may have any
> + * alignment, the returned physical will be adjusted with any sub page o=
ffset.
> + *
> + * Context: The caller must hold a read range lock that includes @iova.
> + *
> + * Return: 0 if there is no translation for the given iova.
> + */
> +phys_addr_t DOMAIN_NS(iova_to_phys)(struct iommu_domain *domain,
> +                                   dma_addr_t iova)
> +{
> +       struct pt_iommu *iommu_table =3D
> +               container_of(domain, struct pt_iommu, domain);
> +       struct pt_range range;
> +       pt_oaddr_t res;
> +       int ret;
> +
> +       ret =3D make_range(common_from_iommu(iommu_table), &range, iova, =
1);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D pt_walk_range(&range, __iova_to_phys, &res);
> +       /* PHYS_ADDR_MAX would be a better error code */
> +       if (ret)
> +               return 0;
> +       return res;
> +}
> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys), "GENERIC_PT_IOMMU");
> +
>  struct pt_iommu_collect_args {
>         struct iommu_pages_list free_list;
>  };
> diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/=
iommu.h
> index dc731fe003d153..5622856e199881 100644
> --- a/include/linux/generic_pt/iommu.h
> +++ b/include/linux/generic_pt/iommu.h
> @@ -116,11 +116,13 @@ struct pt_iommu_cfg {
>  };
>
>  /* Generate the exported function signatures from iommu_pt.h */
> -#define IOMMU_PROTOTYPES(fmt)                                           =
  \
> -       int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,          =
 \
> -                                 const struct pt_iommu_##fmt##_cfg *cfg,=
 \
> -                                 gfp_t gfp);                            =
 \
> -       void pt_iommu_##fmt##_hw_info(struct pt_iommu_##fmt *table,      =
 \
> +#define IOMMU_PROTOTYPES(fmt)                                           =
       \
> +       phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *do=
main, \
> +                                                 dma_addr_t iova);      =
      \
> +       int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,          =
      \
> +                                 const struct pt_iommu_##fmt##_cfg *cfg,=
      \
> +                                 gfp_t gfp);                            =
      \
> +       void pt_iommu_##fmt##_hw_info(struct pt_iommu_##fmt *table,      =
      \
>                                       struct pt_iommu_##fmt##_hw_info *in=
fo)
>  #define IOMMU_FORMAT(fmt, member)       \
>         struct pt_iommu_##fmt {         \
> @@ -129,6 +131,13 @@ struct pt_iommu_cfg {
>         };                              \
>         IOMMU_PROTOTYPES(fmt)
>
> +/*
> + * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops fo=
r the
> + * iommu_pt
> + */
> +#define IOMMU_PT_DOMAIN_OPS(fmt) \
> +       .iova_to_phys =3D &pt_iommu_##fmt##_iova_to_phys,
> +
>  /*
>   * The driver should setup its domain struct like
>   *     union {
> --
> 2.43.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
