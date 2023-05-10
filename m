Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9D31548F
	for <iommu@lists.linux.dev>; Wed, 10 May 2023 15:12:33 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-55a44a2637bso109180467b3.2
        for <iommu@lists.linux.dev>; Wed, 10 May 2023 08:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683731552; x=1686323552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coL2h1loXq0Q/LZaipmWI4lWtoYeVShAhhtPPbhWS60=;
        b=VCdK5z8cv2Z7THcPSi/A9TpzsVtzZLYSNGCd1KHVOqpj7kGN8eMmvzOKdy5SfoLl+v
         HPFVGx/E7HhvivCqUiusmuNg/5Bs4GcNBlhIy76jRTWJ5hnsb0SWlhKZfgd7HgkwQBHW
         ZTGextOvASREpFt3mrhVjawrQ0z2J6LXuRbQu/i2rvA1Do5kw6Pa30UyeWVR/pJXG5bu
         DGr9m8bWLpDXsG95x01bRaYPYHzwLPHwA4t59iN561Bne8vjqwmdL29Rky3QCw6a1UCa
         MdJ5BbfuPxvaHM2b4xeKyaRtEa2RvhBt+K4zIHGVyVVlhdvQySMuD4u+i4IxKqD94/bP
         WIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683731552; x=1686323552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coL2h1loXq0Q/LZaipmWI4lWtoYeVShAhhtPPbhWS60=;
        b=CDofHq5Nrmfl+k11oLRwTby3IdYr1RVshzpnnpljd5wkcHSGbbCySFJK7aXEWcBsJg
         agCv5cws0+82QeIBosEQn8SJosO9N60bZ6UL+ZfXryaMYCiANkSyQEETyNGbRaruuSwl
         g8rk4dqdYdX86JsIYM+3tgPqiwsbM7gX9gtOuPcuqc8gbMl/M9gzLvDrGAw1w+tq0NTC
         wUWmr1xzVOxCEhieWyIaw0PA1vcHOETKCCs38eMA/Q5yxXgiyFccDJ7FXTlmRXA1lbDw
         2tcZbpaec2K8/QKcHF8wufHznEFo8Y7+HgY6u71kZhY58wPjYlSkUGBQh7gIFMP/OA7B
         v/yQ==
X-Gm-Message-State: AC+VfDzB2SJCYM2RM9CqRZVFWeoIQK+MyNRLKKghoSy/Cg+1KjFslajC
	t6VLJBCso4yrHW4OlvtgKcyh3CHzyiKpMH8QvQw13A==
X-Google-Smtp-Source: ACHHUZ6mnlT4c0M7cTifPyZmp/HMS67pU1kZjGTFSBdczAlf7VlExTiibdhWUFvuLboPH+Hk5DJwgqnBobM9rfmmm2Y=
X-Received: by 2002:a25:19d7:0:b0:b97:1e2e:a4e5 with SMTP id
 206-20020a2519d7000000b00b971e2ea4e5mr17132767ybz.40.1683731552468; Wed, 10
 May 2023 08:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230508142842.854564-1-apatel@ventanamicro.com>
 <20230508142842.854564-8-apatel@ventanamicro.com> <38cb8b93-6f10-c269-e574-613ae6a9dd87@arm.com>
In-Reply-To: <38cb8b93-6f10-c269-e574-613ae6a9dd87@arm.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 10 May 2023 20:42:20 +0530
Message-ID: <CAK9=C2XoJzJBY4Rgxo0WDMOrOPO-ZVCT0J-z867FMCvvzFYFpA@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] irqchip/riscv-imsic: Improve IOMMU DMA support
To: Robin Murphy <robin.murphy@arm.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Atish Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 4:18=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2023-05-08 15:28, Anup Patel wrote:
> > We have a separate RISC-V IMSIC MSI address for each CPU so changing
> > MSI (or IRQ) affinity results in re-programming of MSI address in
> > the PCIe (or platform) device.
> >
> > Currently, the iommu_dma_prepare_msi() is called only once at the
> > time of IRQ allocation so IOMMU DMA domain will only have mapping
> > for one MSI page. This means iommu_dma_compose_msi_msg() called
> > by imsic_irq_compose_msi_msg() will always use the same MSI page
> > irrespective to target CPU MSI address. In other words, changing
> > MSI (or IRQ) affinity for device using IOMMU DMA domain will not
> > work.
> >
> > To address above issue, we do the following:
> > 1) Map MSI pages for all CPUs in imsic_irq_domain_alloc()
> >     using iommu_dma_prepare_msi().
> > 2) Add a new iommu_dma_select_msi() API to select a specific
> >     MSI page from a set of already mapped MSI pages.
> > 3) Use iommu_dma_select_msi() to select a specific MSI page
> >     before calling iommu_dma_compose_msi_msg() in
> >     imsic_irq_compose_msi_msg().
>
> The high-level design is that prepare ensures any necessary page
> mappings exist, then compose retrieves the appropriate page for the
> given message. I think it generalises well enough without needing a new
> op, it just means that caching a single page in the msi_desc up-front no
> longer fits, so that wants tweaking to allow compose to do a more
> general lookup.

Yes, usage of msi_desc_get/set_iommu_cookie() is the only problem.

To have minimal impact on other irqchip drivers, I added a separate
iommu_dma_select_msi() API but in the next patch revision I will
tweak iommu_dma_compose_msi_msg() to lookup msi_page based
on the existing MSI address in "struct msi_msg".

Regards,
Anup

>
> Thanks,
> Robin.
>
> > Reported-by: Vincent Chen <vincent.chen@sifive.com>
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >   drivers/iommu/dma-iommu.c         | 38 ++++++++++++++++++++++++++++++=
+
> >   drivers/irqchip/irq-riscv-imsic.c | 27 ++++++++++++----------
> >   include/linux/iommu.h             |  6 +++++
> >   3 files changed, 59 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 7a9f0b0bddbd..07782c77a6eb 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -1677,6 +1677,44 @@ int iommu_dma_prepare_msi(struct msi_desc *desc,=
 phys_addr_t msi_addr)
> >       return 0;
> >   }
> >
> > +/**
> > + * iommu_dma_select_msi() - Select a MSI page from a set of
> > + * already mapped MSI pages in the IOMMU domain.
> > + *
> > + * @desc: MSI descriptor prepared by iommu_dma_prepare_msi()
> > + * @msi_addr: physical address of the MSI page to be selected
> > + *
> > + * Return: 0 on success or negative error code if the select failed.
> > + */
> > +int iommu_dma_select_msi(struct msi_desc *desc, phys_addr_t msi_addr)
> > +{
> > +     struct device *dev =3D msi_desc_to_dev(desc);
> > +     struct iommu_domain *domain =3D iommu_get_domain_for_dev(dev);
> > +     const struct iommu_dma_msi_page *msi_page;
> > +     struct iommu_dma_cookie *cookie;
> > +
> > +     if (!domain || !domain->iova_cookie) {
> > +             desc->iommu_cookie =3D NULL;
> > +             return 0;
> > +     }
> > +
> > +     cookie =3D domain->iova_cookie;
> > +     msi_addr &=3D ~(phys_addr_t)(cookie_msi_granule(cookie) - 1);
> > +
> > +     msi_page =3D msi_desc_get_iommu_cookie(desc);
> > +     if (msi_page && msi_page->phys =3D=3D msi_addr)
> > +             return 0;
> > +
> > +     list_for_each_entry(msi_page, &cookie->msi_page_list, list) {
> > +             if (msi_page->phys =3D=3D msi_addr) {
> > +                     msi_desc_set_iommu_cookie(desc, msi_page);
> > +                     return 0;
> > +             }
> > +     }
> > +
> > +     return -ENOENT;
> > +}
> > +
> >   /**
> >    * iommu_dma_compose_msi_msg() - Apply translation to an MSI message
> >    * @desc: MSI descriptor prepared by iommu_dma_prepare_msi()
> > diff --git a/drivers/irqchip/irq-riscv-imsic.c b/drivers/irqchip/irq-ri=
scv-imsic.c
> > index 30247c84a6b0..ec61c599e0c5 100644
> > --- a/drivers/irqchip/irq-riscv-imsic.c
> > +++ b/drivers/irqchip/irq-riscv-imsic.c
> > @@ -446,6 +446,10 @@ static void imsic_irq_compose_msi_msg(struct irq_d=
ata *d,
> >       if (WARN_ON(err))
> >               return;
> >
> > +     err =3D iommu_dma_select_msi(desc, msi_addr);
> > +     if (WARN_ON(err))
> > +             return;
> > +
> >       msg->address_hi =3D upper_32_bits(msi_addr);
> >       msg->address_lo =3D lower_32_bits(msi_addr);
> >       msg->data =3D d->hwirq;
> > @@ -493,11 +497,18 @@ static int imsic_irq_domain_alloc(struct irq_doma=
in *domain,
> >       int i, hwirq, err =3D 0;
> >       unsigned int cpu;
> >
> > -     err =3D imsic_get_cpu(&imsic->lmask, false, &cpu);
> > -     if (err)
> > -             return err;
> > +     /* Map MSI address of all CPUs */
> > +     for_each_cpu(cpu, &imsic->lmask) {
> > +             err =3D imsic_cpu_page_phys(cpu, 0, &msi_addr);
> > +             if (err)
> > +                     return err;
> >
> > -     err =3D imsic_cpu_page_phys(cpu, 0, &msi_addr);
> > +             err =3D iommu_dma_prepare_msi(info->desc, msi_addr);
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> > +     err =3D imsic_get_cpu(&imsic->lmask, false, &cpu);
> >       if (err)
> >               return err;
> >
> > @@ -505,10 +516,6 @@ static int imsic_irq_domain_alloc(struct irq_domai=
n *domain,
> >       if (hwirq < 0)
> >               return hwirq;
> >
> > -     err =3D iommu_dma_prepare_msi(info->desc, msi_addr);
> > -     if (err)
> > -             goto fail;
> > -
> >       for (i =3D 0; i < nr_irqs; i++) {
> >               imsic_id_set_target(hwirq + i, cpu);
> >               irq_domain_set_info(domain, virq + i, hwirq + i,
> > @@ -528,10 +535,6 @@ static int imsic_irq_domain_alloc(struct irq_domai=
n *domain,
> >       }
> >
> >       return 0;
> > -
> > -fail:
> > -     imsic_ids_free(hwirq, get_count_order(nr_irqs));
> > -     return err;
> >   }
> >
> >   static void imsic_irq_domain_free(struct irq_domain *domain,
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index e8c9a7da1060..41e8613832ab 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -1117,6 +1117,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 =
dma_base, u64 dma_limit);
> >   int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base=
);
> >
> >   int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr=
);
> > +int iommu_dma_select_msi(struct msi_desc *desc, phys_addr_t msi_addr);
> >   void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg =
*msg);
> >
> >   #else /* CONFIG_IOMMU_DMA */
> > @@ -1138,6 +1139,11 @@ static inline int iommu_dma_prepare_msi(struct m=
si_desc *desc, phys_addr_t msi_a
> >       return 0;
> >   }
> >
> > +static inline int iommu_dma_select_msi(struct msi_desc *desc, phys_add=
r_t msi_addr)
> > +{
> > +     return 0;
> > +}
> > +
> >   static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc, s=
truct msi_msg *msg)
> >   {
> >   }
