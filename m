Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652EE48C8A7
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998839; cv=pass; b=pM6lzJJiMqW811v0NJTrGXGYeVmM+uzETs3bS5JeCnv+Ufcln5VYSKKM5+WdrxBPuAwn2hy4Zte+7Ggbilmqfa2ehAki7YMCj/98mIeuK8++uG2UdftDOW+IANe1bnBpY4HFe2dtbhGrxS4Vom+bZePqxPltcfPX9NshxtllHIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998839; c=relaxed/simple;
	bh=NKq95oMiYqRZUG2FliwX8bp5o3L2f+407SarXI1ZbHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqHloPqVEBThTjwdXlbzU8yw7B1cfvUMy3YucUKySE1xnw2NDMxpsrC2vdKSgWhSs2VhC4zrFhZMwen5MbsuTy3aiscTv/VSRg3tq9jnfON2nPDZe3q0MIEOkUvm/BXBmhtlWV5H++ZSEeG+7Fsl2S0FFTMpfMeNZdHjXBFGcdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=CIHRY5vD; arc=pass smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="CIHRY5vD"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-691de293326so2933931eaf.3
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 09:33:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777998834; cv=none;
        d=google.com; s=arc-20240605;
        b=b72Lxv8Dp4wZw2pczjLQWo12VrAiyk986q3d0r4ea8CaX7hXul0kcz41jBffWffRl5
         nuAFylpy4fFjZRVj51luBNrIIgMyWMPBUL0/Fp9iS1Paz9/Udh0idcmon5Vgb0Q20csm
         MahByg3G1UUp0Mqzh4RjUJZab1on1NJFIDr5Oi6TaHE4mw6+iYzvCfpUdg0Emm/4nCEH
         c3vT/QxpolO9afysVOkCaBqcy+LARgOAL/M+GZ6xxkDj3RBZjkAShW0UhU4TB4+ErHHT
         XgfWijl1CAfi9L2rgK0Ae5JifnvyJUAJTAG2RSUXsue4MReMb4QHVOJscAn+DXJZJCP9
         Mh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vtpazpB/8eE6pYzC9wjuU+7s+d59WdlAMcKHmpMIbC4=;
        fh=pZSIxzjmhu5qYSpCsVf/XV1iTYNhEllKX72hAzQbonI=;
        b=S2chgCiYYL+aYqDHhrty/HFhSUCMQDOF9UqvWIKkBVoKUtvmA9Z2Fg1+i0VKXWQ3jI
         Iut9fM1lHLR1IG4b3CvV8/peqEdf3l4tRKyuK30gjVpJatpYT44maS7xQoyFBtjERsOl
         eWP2XbDQQGa3MaicIDfcvKkqixtFxrnD9xGWJx/f4vzQIKg2ql/bCnDnJtweSjLrjPvx
         PpoV286GS5+1cZbvUp0K/NabI2dqU4x52OehsHVq6FRuskeLo4+RHRd6bZNwG4agCreh
         snKcy78bHd0sFbdCMpgCV0lZUxZF8VNRIs8uCh82/l/SBuBQ2OW9jIvi8JZsVJrHQuAf
         Ie2g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1777998834; x=1778603634; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtpazpB/8eE6pYzC9wjuU+7s+d59WdlAMcKHmpMIbC4=;
        b=CIHRY5vDxlufcfXnZnRBUymWBwQ70ytCrdpTLZ5Z07Q/SP9NG2HTOVSRBqf0Ok8Bi0
         +aCnZvIfa7qTGDECittokiS12aSbYeRch1Z6NSOh90AtGH65UhvyqeUhF9P5Ff3F41Gh
         NF4DdCnd67P3uriiAlGprBOTViSTqImcp8l5ov5iMJ11S0Xex5yAT8NhrjYJCDSSNU9B
         +xU0dBh9fYgTMSRI1gM4C5kgXIL7ENHqfv1ep4MuoPzwTUwzajAMWQEAQYGdOEF567DZ
         vkNIZZyeRUVSKUGv9wABNiYlxL0hZZjHJbZukQR3624y6Db+jnb+nm+EI+oS1Wt1dk8H
         3W0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777998834; x=1778603634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vtpazpB/8eE6pYzC9wjuU+7s+d59WdlAMcKHmpMIbC4=;
        b=Ei2IU37gXXlIWZQ/y+b3UnTSAlPA0wjPx6NAcp1qAT6yJX7h3xpYyRo6sVBoLUQRN+
         BkPzHXMOCCVP5R2f9ao3B8fQCBjdwI/07dHhImoVQtU48diHPA7R3CXAijvYB0CQVpJp
         1DFz752fNdsd5SMNSmzPG135+tknV4W2luVckZolbxLrCduL2yc5H4qYNF51x7oX7vFU
         7Mfwwi4fUu0oFkPkU+pt5oBa16Xv4uQ65eLtfW/ErQWxEkr9mOZynzy7o3S7NhZ3Mgap
         3MAXRTTUmfG6t0Yj1lS1qQXyoJsCTvYnE9EBdDhklhp9pFaAKl+TOw+TD2Rv+J95pLrR
         2B1g==
X-Forwarded-Encrypted: i=1; AFNElJ/q1WgD8wrk4iDre6em4pAU/ZlxF5oDrPywKZJc+H/UCe63Onv3QSKuRvRJ2XE5u+ZLBcWYsA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzh67sIl6t5rDw/FjHcPBcIK4q/O/2SW4RLBulZPwrFhdv0/W8l
	77uEYWncN5/2Hd1IptXqOSZ6qoIuR5gIkwiF7Jy+CN8q1bLkpNs8GeQHIMj4/4H+fxUexT/N/aX
	SQNjepVj6lTWJafNZp97KIk+i536cg4S/tr4hIdDoOg==
X-Gm-Gg: AeBDietfF78i62EwmtQW49fi0FrGYGqOZbEDOBdyeb8ToLlysKx9PfkKV7te+qwXo5d
	ZEGxIrF+GuSvbdkZJWUa4ZhrKBffsAt83OkTIpkHzF2kUCj8xydlfSQMq/P+qvYhjdaDJvNUvVC
	3mwZIfu48yWU1DmOpYSsJl+Nq2va5waN+SOzBfieDkmli8ymOVvtBnmVdVz/u1oZecanP1z5DMM
	stngBOo+dJ8DVG/COi4Pxcxg6mRSly46kdzmL4oNflh/dEOnBOr1S5wn8GkRp7mc7rubogsOCAf
	p3SC6XhQ0VNrRDxdfA==
X-Received: by 2002:a05:6820:6ae3:b0:694:89e2:74fd with SMTP id
 006d021491bc7-699981b5a39mr88918eaf.50.1777998834219; Tue, 05 May 2026
 09:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-54e7264d71b4+17cc3-iommu_riscv_inv_jgg@nvidia.com> <4-v1-54e7264d71b4+17cc3-iommu_riscv_inv_jgg@nvidia.com>
In-Reply-To: <4-v1-54e7264d71b4+17cc3-iommu_riscv_inv_jgg@nvidia.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Tue, 5 May 2026 09:33:41 -0700
X-Gm-Features: AVHnY4Jo2M_oYIkIR0EQC-NGrzHu318spP9O1zFNVhPiXz7QU2_Oa1GP5rSq1Uk
Message-ID: <CAH2o1u6--LxUM0L_yEGUZU7THzO8=kdYUSG6CwR0-H49ss0ECg@mail.gmail.com>
Subject: Re: [PATCH 4/7] iommu/riscv: Enable PT_FEAT_DETAILED_GATHER and pass
 gather to iotlb_inval
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, linux-riscv@lists.infradead.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Fangyu Yu <fangyu.yu@linux.alibaba.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 8:57=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> RISC-V can use the information from PT_FEAT_DETAILED_GATHER to
> compute the best stride to generate the single TLB invalidations.
>
> Pass the gather down to the lower functions and create a full-range
> gather for the flush-all callback.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/generic_pt/fmt/iommu_riscv64.c |  4 +-
>  drivers/iommu/riscv/iommu.c                  | 44 +++++++++++++-------
>  2 files changed, 31 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/iommu/generic_pt/fmt/iommu_riscv64.c b/drivers/iommu=
/generic_pt/fmt/iommu_riscv64.c
> index cbf60fffa9bf7d..b18fc4d109f538 100644
> --- a/drivers/iommu/generic_pt/fmt/iommu_riscv64.c
> +++ b/drivers/iommu/generic_pt/fmt/iommu_riscv64.c
> @@ -6,6 +6,8 @@
>  #define PT_FMT_VARIANT 64
>  #define PT_SUPPORTED_FEATURES                                  \
>         (BIT(PT_FEAT_SIGN_EXTEND) | BIT(PT_FEAT_FLUSH_RANGE) | \
> -        BIT(PT_FEAT_RISCV_SVNAPOT_64K))
> +        BIT(PT_FEAT_RISCV_SVNAPOT_64K) |                      \
> +        BIT(PT_FEAT_DETAILED_GATHER))
> +#define PT_FORCE_ENABLED_FEATURES BIT(PT_FEAT_DETAILED_GATHER)
>
>  #include "iommu_template.h"
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index a31f50bbad3535..556d5dc9c58681 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -929,12 +929,28 @@ static void riscv_iommu_bond_unlink(struct riscv_io=
mmu_domain *domain,
>  #define RISCV_IOMMU_IOTLB_INVAL_LIMIT  (2 << 20)
>
>  static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
> -                                   unsigned long start, unsigned long en=
d)
> +                                   struct iommu_iotlb_gather *gather)
>  {
> +       unsigned long start;
> +       unsigned long end;
>         struct riscv_iommu_bond *bond;
>         struct riscv_iommu_device *iommu, *prev;
>         struct riscv_iommu_command cmd;
>
> +       /*
> +        * When non-leaf page table entries were changed, the base spec
> +        * requires a full PSCID invalidation (AV=3D0) since there is no
> +        * way to do targeted non-leaf invalidation without the NL
> +        * extension. Force global invalidation to preserve correctness.
> +        */
> +       if (gather->pt.table_levels_bitmap) {
> +               start =3D 0;
> +               end =3D ULONG_MAX;
> +       } else {
> +               start =3D gather->start;
> +               end =3D gather->end;
> +       }
> +
>         /*
>          * For each IOMMU linked with this protection domain (via bonds->=
dev),
>          * an IOTLB invaliation command will be submitted and executed.
> @@ -1145,8 +1161,14 @@ static void riscv_iommu_iodir_update(struct riscv_=
iommu_device *iommu,
>  static void riscv_iommu_iotlb_flush_all(struct iommu_domain *iommu_domai=
n)
>  {
>         struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
> +       struct iommu_iotlb_gather gather =3D {
> +               .start =3D 0,
> +               .end =3D ULONG_MAX,
> +               .pt.leaf_levels_bitmap =3D 0xFF,
> +               .pt.table_levels_bitmap =3D 0xFE,
> +       };
>
> -       riscv_iommu_iotlb_inval(domain, 0, ULONG_MAX);
> +       riscv_iommu_iotlb_inval(domain, &gather);
>  }
>
>  static void riscv_iommu_iotlb_sync(struct iommu_domain *iommu_domain,
> @@ -1154,19 +1176,8 @@ static void riscv_iommu_iotlb_sync(struct iommu_do=
main *iommu_domain,
>  {
>         struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
>
> -       if (iommu_pages_list_empty(&gather->freelist)) {
> -               riscv_iommu_iotlb_inval(domain, gather->start, gather->en=
d);
> -       } else {
> -               /*
> -                * In 1.0 spec version, the smallest scope we can use to
> -                * invalidate all levels of page table (i.e. leaf and non=
-leaf)
> -                * is an invalidate-all-PSCID IOTINVAL.VMA with AV=3D0.
> -                * This will be updated with hardware support for
> -                * capability.NL (non-leaf) IOTINVAL command.
> -                */
> -               riscv_iommu_iotlb_inval(domain, 0, ULONG_MAX);
> -               iommu_put_pages_list(&gather->freelist);
> -       }
> +       riscv_iommu_iotlb_inval(domain, gather);
> +       iommu_put_pages_list(&gather->freelist);
>  }
>
>  static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_do=
main)
> @@ -1267,7 +1278,8 @@ static struct iommu_domain *riscv_iommu_alloc_pagin=
g_domain(struct device *dev)
>          */
>         cfg.common.features =3D BIT(PT_FEAT_SIGN_EXTEND) |
>                               BIT(PT_FEAT_FLUSH_RANGE) |
> -                             BIT(PT_FEAT_RISCV_SVNAPOT_64K);
> +                             BIT(PT_FEAT_RISCV_SVNAPOT_64K) |
> +                             BIT(PT_FEAT_DETAILED_GATHER);
>         domain->riscvpt.iommu.nid =3D dev_to_node(iommu->dev);
>         domain->domain.ops =3D &riscv_iommu_paging_domain_ops;
>
> --
> 2.43.0
>

Reviewed-by: Tomasz Jeznach <tjeznach@rivosinc.com>
