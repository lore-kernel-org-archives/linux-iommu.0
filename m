Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6449C2C11D1
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 08:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772179608; cv=none; b=WQh7n/kGVcyPjDCHdxOKbUKV4eSK7spmQo7AIp+V50kx0RuyJAc0ort5I4PQP0pFWx2t+UfrtSblZ0Ldxf/dvBxOvIKMuuiPraVsoPtMQ/beSF6ZSJLXXz3eV93WnZ93AoHbY+JyR9MfbVQjkiKXFeJgk08z0/qYd7ai4epgif4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772179608; c=relaxed/simple;
	bh=QO7vAxeAnl2qqLJnLfR9yx3/scFzuG14co62zMLiD2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGqe4u6K+7julZcEeM96Z7cdutFvwxkgQNdMajyssdSXyS4fMkjrF3wVbc8NmMSpivZB5YN/p5iVdlny4PRERWlk5NPs3bZnHuzZ3tC2gq70GNLXeryxX5/zoDsYNa9XbytTUm6MT4eFKwLQ2xjy+OBkbAio6WjyzWUW1J6vMsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=h0GKd3IU; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="h0GKd3IU"
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 8E58E3F158
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 10:06:42 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 6C7BC3F167
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 10:06:41 +0200 (EET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 6B2081FF386
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 10:06:40 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1772179601;
	bh=otMLF5KZhuT7c3k2mCRjlUbTmEWn7d4xNS1bFP+OvHA=;
	h=Received:From:Subject:To;
	b=h0GKd3IUUIDkqd2bdtk5MGvZQqnlU9XlS8KP5oohkUSLm/+W2/Gv8ZuNaBYiiNgN2
	 cm/RVPrmNkvtKHaVj3DwBoZ/2ciOdD9h91ZIlZc/z3MIlsJN9BRX3Sn9CAo/550mpA
	 6UAX6QL86f6DWXbRkJqpRBtyzz0Ybr3qCS+HtBfY2aPMIZSH8xAMJyMaaWZVdKi0Yq
	 EnOm0DdKO9YwB7xsuCnorbpy7mEssj9NW1N7ASZ5nFV0H+hJ4vB26AqxG23cJEXELq
	 uC9Z7Edk708zYAz0Bx7wqNLsNo//Tb0f1ah3y2X+NGPKzH8jZcx7yRzGo4qr1v6jFn
	 ahw6y1xwXr6nA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.216.43) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pj1-f43.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-358d7dcc230so1182701a91.0
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 00:06:40 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVjOSyg0x4RVcqgYaGNMj0FA/RZsFzgT37eXZgXTakZPO3jsFQuaeylu36rC5s5cuTEWS/JvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBqTKqVuVci7iqtq9t3rcq6qgEIEoXOdLcSfF2VD/lVISQo12a
	2C/BJSE2wUNNIfeYzl0l7VHdJ/M7p/z9CZvAFJ2SH2ddKBAyrlBZBJQBenIHzLRxUBgTjAHCxnC
	H+B/1/TudUpzo093NYnu+vtTc73B5x4U=
X-Received: by 2002:a17:90b:4c0e:b0:356:41c2:896f with SMTP id
 98e67ed59e1d1-35965c330f3mr1878658a91.7.1772179598893; Fri, 27 Feb 2026
 00:06:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260221235050.2558321-1-lkml@antheas.dev>
 <aZ36tRwNP8cRRX1l@ziepe.ca>
 <CAGwozwFPLLFfKP90fFrt-QC1rKPRCVo_iHuLm4roHX7erQ=Y5Q@mail.gmail.com>
 <aZ3/W8sw+gW5aTA5@ziepe.ca>
 <CAGwozwFKTeXW7_tPcUw8pYvNSoS9860mNJ=OUKCt2vEawYVOJA@mail.gmail.com>
 <6bac3817-9652-4146-ab44-2a9518c3b339@arm.com>
 <CAGwozwGXpVZ1ctUyZ79itwcX7RPjeLebFPWDVpNMq6-f_UtF3A@mail.gmail.com>
 <7e3a1d3c-64cb-43a8-bd2f-05b24a8d1611@arm.com>
 <CAGwozwGsh3_M+e35M2Ld7827W=w26-71xGXwgeEBu-ZcZGLACQ@mail.gmail.com>
 <20260227010317.GD44359@ziepe.ca>
In-Reply-To: <20260227010317.GD44359@ziepe.ca>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 27 Feb 2026 09:06:27 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwExiRo9RhXOHj4wLpn6Tq0N_pKwAywcr7=SwAyaaZvNZQ@mail.gmail.com>
X-Gm-Features: AaiRm513OYJ6RmkM54QXvk5J04pmcga9sMv9jNWrqDo7ZH9MCX_MKRHSwBhDEAA
Message-ID: 
 <CAGwozwExiRo9RhXOHj4wLpn6Tq0N_pKwAywcr7=SwAyaaZvNZQ@mail.gmail.com>
Subject: Re: [PATCH v1] iommu: Skip mapping at address 0x0 if it already
 exists
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, dnaim@cachyos.org,
	Mario.Limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <177217960086.1012614.10878680806631410417@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 27 Feb 2026 at 02:03, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Feb 26, 2026 at 09:40:10PM +0100, Antheas Kapenekakis wrote:
> > I am still concerned about unaligned checks. It is a functional change
> > that can cause regressions in all devices. The approach of this patch
> > does not affect behavior in other devices. I would like for Jason to
> > weigh in.
>
> I think Robin's solution is very clever, but I share the concern
> regarding what all the implementations do.

I will send a V3 with a ternary instead. This way, only 0 is affected.
I will compile test now and test later today. I am impartial with either fi=
x.

```
phys_addr =3D iommu_iova_to_phys(domain, addr ? addr : 1);
```


Antheas

> So, I fed this question to Claude. It did find two counter points (see
> below for the whole report I had it generate):
>
>      Implementations that lose the offset
>
>      s390-iommu (drivers/iommu/s390-iommu.c:989): After the 3-level ZPCI =
walk,
>      returns pte & ZPCI_PTE_ADDR_MASK with no sub-page offset added back.
>      iova_to_phys(0) and iova_to_phys(1) return the same page-aligned PA.
>
>      mtk_iommu_v1 (drivers/iommu/mtk_iommu_v1.c:396): Looks up the PTE by
>      iova >> PAGE_SHIFT (discarding offset), then returns pte & ~(page_si=
ze-1). No
>      step adds the sub-page offset back.
>
> I checked myself and it seems correct. I didn't try to confirm that
> the cases it says are OK are in fact OK, but it paints a convincing
> picture.
>
> I doubt S390 uses this function you are fixing, and I have no idea
> about mtk. Below is also a diff how Claude thought to fix it, I didn't
> try to check it.
>
> So, I'd say if Robin is OK with these outliers then it a good and fine
> approach.
>
> Jason
>
> iova_to_phys Implementation Survey
>
> Entry point: iommu_iova_to_phys() in drivers/iommu/iommu.c:2502 calls
> domain->ops->iova_to_phys(domain, iova) via iommu_domain_ops.
>
> Category 1 =E2=80=94 Delegates to io-pgtable
>
> These drivers hold an io_pgtable_ops * and call ops->iova_to_phys(ops, io=
va).
> The actual walk happens in one of the io-pgtable backends listed in Categ=
ory
> 4.
>
>   -----------------------------------------------------------------------=
-----------------------------------
>   Driver        Function (file:line)                               Ops as=
signment          Notes
>   ------------- -------------------------------------------------- ------=
----------------- -----------------
>   arm-smmu-v3   arm_smmu_iova_to_phys                              :3767 =
                  Pure delegation
>                 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3471
>
>   arm-smmu      arm_smmu_iova_to_phys                              :1655 =
                  S1 with
>   v1/v2         drivers/iommu/arm/arm-smmu/arm-smmu.c:1387               =
                  FEAT_TRANS_OPS
>                                                                          =
                  uses hw ATS1PR
>                                                                          =
                  registers
>                                                                          =
                  (CB_PAR),
>                                                                          =
                  otherwise
>                                                                          =
                  io-pgtable
>
>   apple-dart    apple_dart_iova_to_phys                            :1021 =
                  Pure delegation =E2=86=92
>                 drivers/iommu/apple-dart.c:531                           =
                  io-pgtable-dart
>
>   qcom_iommu    qcom_iommu_iova_to_phys                            :605  =
                  Delegation with
>                 drivers/iommu/arm/arm-smmu/qcom_iommu.c:492              =
                  spinlock
>
>   ipmmu-vmsa    ipmmu_iova_to_phys drivers/iommu/ipmmu-vmsa.c:702  :895  =
                  Uses
>                                                                          =
                  ARM_32_LPAE_S1
>                                                                          =
                  format
>
>   mtk_iommu     mtk_iommu_iova_to_phys                             :1073 =
                  Delegation + 4GB
>                 drivers/iommu/mtk_iommu.c:861                            =
                  mode PA remap
>                                                                          =
                  fixup
>   -----------------------------------------------------------------------=
-----------------------------------
>
> Category 2 =E2=80=94 Open-coded page table walk
>
> These drivers implement their own page table traversal without io-pgtable=
.
>
>   -----------------------------------------------------------------------=
----------------------------------
>   Driver           Function (file:line)                 Ops assignment   =
    Walk structure
>   ---------------- ------------------------------------ -----------------=
--- ------------------------------
>   sun50i-iommu     sun50i_iommu_iova_to_phys            :860             =
    2-level (DTE =E2=86=92 PTE)
>                    drivers/iommu/sun50i-iommu.c:662
>
>   exynos-iommu     exynos_iommu_iova_to_phys            :1487            =
    2-level (section/large/small
>                    drivers/iommu/exynos-iommu.c:1375                     =
    page)
>
>   riscv-iommu      riscv_iommu_iova_to_phys             :1355            =
    Sv39/48/57 via
>                    drivers/iommu/riscv/iommu.c:1280                      =
    riscv_iommu_pte_fetch (:1166)
>
>   omap-iommu       omap_iommu_iova_to_phys              :1727            =
    iopgtable_lookup_entry helper
>                    drivers/iommu/omap-iommu.c:1596                       =
    (super
>                                                                          =
    section/section/large/small)
>
>   rockchip-iommu   rk_iommu_iova_to_phys                :1190            =
    2-level (DTE =E2=86=92 PTE)
>                    drivers/iommu/rockchip-iommu.c:651
>
>   msm_iommu        msm_iommu_iova_to_phys               :709             =
    Hardware walk: writes VA to
>                    drivers/iommu/msm_iommu.c:526                         =
    V2PPR register, reads PA from
>                                                                          =
    PAR register
>
>   s390-iommu       s390_iommu_iova_to_phys              :1186            =
    3-level ZPCI (region =E2=86=92 segment
>                    drivers/iommu/s390-iommu.c:989                        =
    =E2=86=92 page)
>
>   tegra-smmu       tegra_smmu_iova_to_phys              :1010            =
    2-level via
>                    drivers/iommu/tegra-smmu.c:806                        =
    tegra_smmu_pte_lookup
>
>   mtk_iommu_v1     mtk_iommu_v1_iova_to_phys            :593             =
    Flat single-level table
>                    drivers/iommu/mtk_iommu_v1.c:396
>
>   sprd-iommu       sprd_iommu_iova_to_phys              :423             =
    Flat single-level table
>                    drivers/iommu/sprd-iommu.c:369
>   -----------------------------------------------------------------------=
----------------------------------
>
> Category 3 =E2=80=94 Special / trivial
>
>   -----------------------------------------------------------------------=
--------------------
>   Driver         Function (file:line)                  Ops assignment    =
     Mechanism
>   -------------- ------------------------------------- ------------------=
---- ---------------
>   fsl_pamu       fsl_pamu_iova_to_phys                 :438              =
     Identity:
>                  drivers/iommu/fsl_pamu_domain.c:172                     =
     returns iova
>                                                                          =
     (after aperture
>                                                                          =
     bounds check)
>
>   virtio-iommu   viommu_iova_to_phys                   :1105             =
     Interval tree
>                  drivers/iommu/virtio-iommu.c:915                        =
     reverse lookup
>                                                                          =
     (no page table)
>   -----------------------------------------------------------------------=
--------------------
>
> Category 4 =E2=80=94 io_pgtable_ops backends
>
> These implement struct io_pgtable_ops.iova_to_phys and are the ultimate w=
alk
> functions called by Category 1 drivers.
>
>   -----------------------------------------------------------------------=
---------------------------
>   Backend     Function (file:line)                     Ops assignment    =
   Walk strategy
>   ----------- ---------------------------------------- ------------------=
-- ------------------------
>   ARM LPAE    arm_lpae_iova_to_phys                    :950              =
   Visitor pattern via
>   (64-bit)    drivers/iommu/io-pgtable-arm.c:734                         =
   __arm_lpae_iopte_walk;
>                                                                          =
   covers ARM_64_LPAE_S1,
>                                                                          =
   S2, ARM_MALI_LPAE
>
>   ARM v7s     arm_v7s_iova_to_phys                     :716              =
   Iterative do-while
>   (32-bit)    drivers/iommu/io-pgtable-arm-v7s.c:644                     =
   2-level; handles
>                                                                          =
   contiguous entries
>
>   Apple DART  dart_iova_to_phys                        :402              =
   dart_get_last pre-walks
>               drivers/iommu/io-pgtable-dart.c:336                        =
   to leaf table, then
>                                                                          =
   single lookup
>   -----------------------------------------------------------------------=
---------------------------
>
> Category 5 =E2=80=94 generic_pt framework
>
> All these drivers use IOMMU_PT_DOMAIN_OPS(fmt) which routes iova_to_phys =
into
> the template function pt_iommu_<fmt>_iova_to_phys at
> drivers/iommu/generic_pt/iommu_pt.h:170. The walk uses pt_walk_range +
> PT_MAKE_LEVELS to generate a fully-inlined unrolled per-level walk; OA
> extracted via pt_entry_oa_exact.
>
>   -----------------------------------------------------------------------=
----------
>   Driver           Ops struct (file:line)                          Format
>   ---------------- ----------------------------------------------- ------=
----------
>   AMD IOMMU v1     amdv1_ops drivers/iommu/amd/iommu.c:2662        amdv1
>
>   AMD IOMMU v2     amdv2_ops drivers/iommu/amd/iommu.c:2740        x86_64
>
>   Intel VT-d       intel_fs_paging_domain_ops                      x86_64
>   first-stage      drivers/iommu/intel/iommu.c:3886
>
>   Intel VT-d       intel_ss_paging_domain_ops                      vtdss
>   second-stage     drivers/iommu/intel/iommu.c:3897
>
>   iommufd selftest mock_domain_ops etc                             amdv1_=
mock /
>                    drivers/iommu/iommufd/selftest.c:403,411,425    amdv1
>
>   KUnit wrapper    pgtbl_ops                                       Delega=
tes to
>                    drivers/iommu/generic_pt/kunit_iommu_cmp.h:86   io_pgt=
able_ops
>                                                                    for co=
mparison
>                                                                    testin=
g
>   -----------------------------------------------------------------------=
----------
>
> Sub-page offset handling
>
> When iova_to_phys(iova) is called with an IOVA that is not aligned to the
> start of the mapped page/block (e.g. iova_to_phys(1) when a 4KB page is m=
apped
> at IOVA 0), most implementations return the exact physical address includ=
ing
> the sub-page offset (phys_base + offset). Two do not.
>
> Summary
>
>   -----------------------------------------------------------------------=
-------------------------------
>   Implementation            Offset preserved?         Mechanism
>   ------------------------- ------------------------- -------------------=
-------------------------------
>   arm_lpae (io-pgtable)     YES                       iopte_to_paddr(pte)=
 | (iova & (block_size-1))
>
>   arm_v7s (io-pgtable)      YES                       iopte_to_paddr(pte)=
 | (iova & ~LVL_MASK)
>
>   dart (io-pgtable)         YES                       iopte_to_paddr(pte)=
 | (iova & (pgsize-1))
>
>   sun50i-iommu              YES                       page_addr + FIELD_G=
ET(GENMASK(11,0), iova)
>
>   exynos-iommu              YES                       *_phys(entry) + *_o=
ffs(iova) per granularity
>
>   riscv-iommu               YES                       pfn_to_phys(pfn) | =
(iova & (pte_size-1))
>
>   omap-iommu                YES                       (descriptor & mask)=
 | (va & ~mask)
>
>   rockchip-iommu            YES                       pt_address(pte) + r=
k_iova_page_offset(iova)
>
>   msm_iommu                 YES                       HW PAR register + V=
A low bits spliced back in
>
>   s390-iommu                NO                        pte & ZPCI_PTE_ADDR=
_MASK =E2=80=94 offset discarded
>
>   tegra-smmu                YES                       SMMU_PFN_PHYS(pfn) =
+ SMMU_OFFSET_IN_PAGE(iova)
>
>   mtk_iommu_v1              NO                        pte & ~(page_size-1=
) =E2=80=94 offset discarded
>
>   sprd-iommu                YES                       (pte << PAGE_SHIFT)=
 + (iova & (page_size-1))
>
>   fsl_pamu                  YES (trivial)             return iova =E2=80=
=94 identity mapping
>
>   virtio-iommu              YES                       paddr + (iova - map=
ping->iova.start)
>
>   generic_pt                YES                       _pt_entry_oa_fast()=
 | log2_mod(va, entry_lg2sz)
>   -----------------------------------------------------------------------=
-------------------------------
>
> Category 1 drivers (arm-smmu-v3, arm-smmu, apple-dart, qcom_iommu, ipmmu-=
vmsa,
> mtk_iommu) inherit the behavior of their io-pgtable backend =E2=80=94 all=
 preserve
> offset.
>
> Implementations that lose the offset
>
> s390-iommu (drivers/iommu/s390-iommu.c:989): After the 3-level ZPCI walk,
> returns pte & ZPCI_PTE_ADDR_MASK with no sub-page offset added back.
> iova_to_phys(0) and iova_to_phys(1) return the same page-aligned PA.
>
> mtk_iommu_v1 (drivers/iommu/mtk_iommu_v1.c:396): Looks up the PTE by
> iova >> PAGE_SHIFT (discarding offset), then returns pte & ~(page_size-1)=
. No
> step adds the sub-page offset back.
>
>
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index c8d8eff5373d30..8db16989270cd8 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -401,7 +401,8 @@ static phys_addr_t mtk_iommu_v1_iova_to_phys(struct i=
ommu_domain *domain, dma_ad
>
>         spin_lock_irqsave(&dom->pgtlock, flags);
>         pa =3D *(dom->pgt_va + (iova >> MT2701_IOMMU_PAGE_SHIFT));
> -       pa =3D pa & (~(MT2701_IOMMU_PAGE_SIZE - 1));
> +       pa =3D (pa & (~(MT2701_IOMMU_PAGE_SIZE - 1))) |
> +            (iova & (MT2701_IOMMU_PAGE_SIZE - 1));
>         spin_unlock_irqrestore(&dom->pgtlock, flags);
>
>         return pa;
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index fe679850af2861..57d27f3a984ed6 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -1015,7 +1015,8 @@ static phys_addr_t s390_iommu_iova_to_phys(struct i=
ommu_domain *domain,
>                         pto =3D get_st_pto(ste);
>                         pte =3D READ_ONCE(pto[px]);
>                         if (pt_entry_isvalid(pte))
> -                               phys =3D pte & ZPCI_PTE_ADDR_MASK;
> +                               phys =3D (pte & ZPCI_PTE_ADDR_MASK) |
> +                                      (iova & ~ZPCI_PTE_ADDR_MASK);
>                 }
>         }
>

