Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94883229
	for <iommu@lists.linux.dev>; Fri,  8 Jul 2022 18:13:19 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id w2so10473885ljj.7
        for <iommu@lists.linux.dev>; Fri, 08 Jul 2022 11:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xxakuRjObUCkye3AQ22V76C+V/wXWgeyU417sI5Erhk=;
        b=PyBdwpT1kw0OeeUw6KnFZnNBkmCt38SG1b76RSoRpK1WOdDZj894b0A0jFL7O5PKx+
         pUHfiV99aQJAcxfxTWtJLs5RXrnjz/xPTcGUsVVpqmdleDtM/GZOu0hn35XCT2PY3ipq
         SaE+FYpbHu24g1jgO23mGYgMKYAD2EBwkoaC1zx4VlSQ2YC+fT7rEGvvkuueN10p/b4g
         U3lPgzcYW7/HcxfRrz/6DAR1DKMU8Ki7pHUaUWqvexJ5WzcrKNGX3EcigmIZNLEDcLX/
         1WbECeQ03q2bCSJdvufKe2C+923wmsFO+0xpjv0d49bF3ePzdeZkKoVCb8jAa+7+Sxgp
         L7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxakuRjObUCkye3AQ22V76C+V/wXWgeyU417sI5Erhk=;
        b=xH1hiLz7VEObKFP433KPDOcTreeZ1lEJXd3smZFW2K9knGs/YlSERzzi780s2sztYf
         bH6B0j10AwN/r9ETpDkivw3hSpPkABXhQnU/UASRjRqCdCS4CpVzsVr1EvVKMPGzoWBu
         kP8XGRUiXS1Z4Q+hhSfBVJeXPfyDHJXul2xoPxGRq0sF0/NpjqdY2TIYsiSpg6Im+y7Q
         25n1RtaPCoAOwXhDEmtRgprfeXiJDjb2Q7c+Khau3YfOux6r+jKdfIgI/WD3kSq0T3Cr
         Fv+LNXFFhKX91AMfokRqzXHxPyyHgMHgiZ12zWpqC9hiLuUiVuBW0VuFLYP5E+YqGllv
         BbVw==
X-Gm-Message-State: AJIora97+NokD9u0GhoflUe3ePojHxkPgGnDr7w66o6sq+33VsgA/WSd
	EK17rNokkaC5o7RcqB1zm9fIBAQPChS4T/38AwE72w==
X-Google-Smtp-Source: AGRyM1s4khtAdDPD9uAtpQbZOOwGGF2BRshqhouC45A+O1rPRIXlXk8YUZSNdivuO908GgYbfwpcIOkx4P2VtlZmLr8=
X-Received: by 2002:a2e:bd11:0:b0:25d:4f94:ac79 with SMTP id
 n17-20020a2ebd11000000b0025d4f94ac79mr2689388ljq.4.1657303997519; Fri, 08 Jul
 2022 11:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
 <20220702213724.3949-4-semen.protsenko@linaro.org> <925751c3-83e8-02b8-6a8b-549290522a9e@linaro.org>
In-Reply-To: <925751c3-83e8-02b8-6a8b-549290522a9e@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 8 Jul 2022 21:13:06 +0300
Message-ID: <CAPLW+4kc86aOVspBz52vt+uhs8GXDNfekd-7jKhyNjUpi8XwLQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] iommu/exynos: Use lookup based approach to access v7 registers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Janghyuck Kim <janghyuck.kim@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, 
	Daniel Mentz <danielmentz@google.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	iommu@lists.linux-foundation.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 3 Jul 2022 at 22:29, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/07/2022 23:37, Sam Protsenko wrote:
> > SysMMU v7 might have different register layouts (VM capable or non-VM
> > capable). Check which layout is implemented in current SysMMU module and
> > prepare the corresponding register table for futher usage. This way is
> > faster and more elegant than checking corresponding condition (if it's
> > VM or non-VM SysMMU) each time before accessing v7 registers. For now
> > the register table contains only most basic registers needed to add the
> > SysMMU v7 support.
> >
> > This patch is based on downstream work of next authors:
> >   - Janghyuck Kim <janghyuck.kim@samsung.com>
> >   - Daniel Mentz <danielmentz@google.com>
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  drivers/iommu/exynos-iommu.c | 46 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >
> > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> > index df6ddbebbe2b..47017e8945c5 100644
> > --- a/drivers/iommu/exynos-iommu.c
> > +++ b/drivers/iommu/exynos-iommu.c
> > @@ -180,6 +180,47 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
> >
> >  #define has_sysmmu(dev)              (dev_iommu_priv_get(dev) != NULL)
> >
> > +#define MMU_REG(data, idx)           \
> > +     ((data)->sfrbase + (data)->regs[idx].off)
>
> I would expect to see users of this - convert all existing regs.
>

I was thinking about doing that as a consequent patch (adding SysMMU
v1/v5 register sets). But ok, will add in v2. And will probably split
it per 2 patches:
  1. Rework existing driver to use register sets (lookup table). To
keep it as "no functional change" patch.
  2. Add SysMMU v7 support.

Also, I will probably replace MMU_REG() with more standard approach,
i.e. will add sysmmu_read() / sysmmu_write() functions instead. It
should make the code tidier.

> > +#define MMU_VM_REG(data, idx, vmid)  \
> > +     (MMU_REG(data, idx) + (vmid) * (data)->regs[idx].mult)
> > +
> > +enum {
> > +     REG_SET_NON_VM,
> > +     REG_SET_VM,
> > +     MAX_REG_SET
> > +};
> > +
> > +enum {
> > +     IDX_CTRL_VM,
> > +     IDX_CFG_VM,
> > +     IDX_FLPT_BASE,
>
> Isn't this called REG_MMU_FLUSH? If yes, it's a bit confusing to see
> different name used.
>

I used v7 registers naming, as I only added support for v7 register
set in this patch series. As I said above, I'll add SysMMU v1/v5
register sets in v2, and rename those indexes to have old register
names. Despite the differences between register names in SysMMU v1/v5
and v7, their purpose is the same.

> > +     IDX_ALL_INV,
>
> Isn't this called REG_MMU_FLUSH_ENTRY?
>
> > +     MAX_REG_IDX
> > +};
> > +
> > +struct sysmmu_vm_reg {
> > +     unsigned int off;       /* register offset */
> > +     unsigned int mult;      /* VM index offset multiplier */
> > +};
> > +
> > +static const struct sysmmu_vm_reg sysmmu_regs[MAX_REG_SET][MAX_REG_IDX] = {
> > +     /* Default register set (non-VM) */
> > +     {
> > +             /*
> > +              * SysMMUs without VM support do not have CTRL_VM and CFG_VM
> > +              * registers. Setting the offsets to 1 will trigger an unaligned
> > +              * access exception.
>
> So why are you setting offset 1? To trigger unaligned access?
>

Yes, as comment suggests, 0x1 offset is set intentionally to cause the
exception. That might be useful for debugging (if driver is trying to
access some non-existing register on some particular SysMMU version).
I'll improve the comment in v2.

> > +              */
> > +             {0x1}, {0x1}, {0x000c}, {0x0010},
> > +     },
> > +     /* VM capable register set */
> > +     {
> > +             {0x8000, 0x1000}, {0x8004, 0x1000}, {0x800c, 0x1000},
> > +             {0x8010, 0x1000},
> > +     },
> You add here quite a bit of dead code and some hard-coded numbers.
>

Ok, will remove those multiplier bits for now. It can be added later,
when implementing domains support (to use VM registers other than n=0
instance).

> > +};
> > +
> >  static struct device *dma_dev;
> >  static struct kmem_cache *lv2table_kmem_cache;
> >  static sysmmu_pte_t *zero_lv2_table;
> > @@ -284,6 +325,7 @@ struct sysmmu_drvdata {
> >
> >       /* v7 fields */
> >       bool has_vcr;                   /* virtual machine control register */
> > +     const struct sysmmu_vm_reg *regs; /* register set */
> >  };
> >
> >  static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
> > @@ -407,6 +449,10 @@ static void sysmmu_get_hw_info(struct sysmmu_drvdata *data)
> >       __sysmmu_get_version(data);
> >       if (MMU_MAJ_VER(data->version) >= 7 && __sysmmu_has_capa1(data))
> >               __sysmmu_get_vcr(data);
> > +     if (data->has_vcr)
> > +             data->regs = sysmmu_regs[REG_SET_VM];
> > +     else
> > +             data->regs = sysmmu_regs[REG_SET_NON_VM];
>
> This is set and not read.
>

It's used in patch 4/4. But as discussed above, I will convert
existing code (SysMMU v1/v3/v5) to benefit from register set as well.
Will send in v2.

Thanks for the review!

> >
> >       __sysmmu_disable_clocks(data);
> >  }
>
>
> Best regards,
> Krzysztof
