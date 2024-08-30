Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356231B652F
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033250; cv=none; b=rg0Q8gnEN/pOVPudW5OtJ2sOmTe7L4Y3zP4ugl3qJ2b3CskMQromaw0iF5A+NOOKL6Qn8be63KcMYYsGq1HEEPouFNisGTdZBrkvuH+J7muOJfuLkmW5Lm3ND/DZvpT45d7V1+hULplQOkR/pvqBAYpX2VfLNgHgOADoBSUMznQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033250; c=relaxed/simple;
	bh=jbMTfg+uDRYs2k1IxLMPWLaXOBcla/O/urjT8XyOs2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCM3g9TV7sL3ZGDfFrrE4GDwSDzVFL4a673xn1ipH5VH6OA+40huUeKRT/njyxV2N8zfyMikpZ3lpFuZqw9Jkqsdxs5HZGz2INc/0dmJqDruvHsqBRAg+esv/9clAH8DtSq8+n04Xn0mQhvSM017rgdf6r+oZM/eLqx/fuZUhOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1e5bsnNA; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1e5bsnNA"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d87176316eso531082a91.0
        for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725033247; x=1725638047; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zFrMVsJYl3sotqJz8TrPZcTYV/4zTZNt2ckjtky3/Y=;
        b=1e5bsnNAeX/fIilP+fMxoPpDmnT7o/oRienfk4O4eMi/eslY35QSutCIGMfC4L6cEG
         6oYFVRvjcqr4VlQYTnoya68DWzhkhrzLuORyOJ5xDMZnBaB560aJuQQ+5xrWpOezrakf
         J9BvUXLlUS2/alHYtKIUmQLmSWFF+J8Ya1IAdNprXW00PYez913zQhz2+yvoTmbqXwOt
         Pot9PqoDbTe8muGIOJ8oJFg8P8NZLYVLfZdaJdLDVi035rzYTmMaXLdgU+RKMKqR6V0T
         a9rSbN2PXwA+wheR2i4EbZ949D0QvJysuhGPoBjQI92eIpDQiOe/XOoQPRwUM8MS1XtI
         Xvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725033247; x=1725638047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zFrMVsJYl3sotqJz8TrPZcTYV/4zTZNt2ckjtky3/Y=;
        b=iwXyAZm+bWdczm+iA8AEwQ7wEbzIiERcWtyQat/M9/jdqGa7AGx8M9SooZ8ZrVUxCe
         GmqMx9nYTU0bM5RhQ7tca33R6yLSslJrGEwCJUekfJAt8W0YTV0BZv0zXP56nb3JyIxa
         u5flkcPE5GTStdvcFD0klZXLqtSE4ni71y3HVqVUeKWBS4u5TkaUxZlPpLL3tvngNrX6
         m8C3b/iYx68SqdPGU19H9bCMPFDF3Fn0oUIT4+ODDcEZ8M362thCbITHXMRbNK84CteO
         TTvsKCuZPV4YA8ShVaI2MzsyIzlzPG7796Acigmy7CHXiMJNdixtKk7BBU5ZNCH53Zxt
         GJ0A==
X-Forwarded-Encrypted: i=1; AJvYcCUaeLdwRpXUGgevCBx0yKExdwH+55nhVrEg+0TC1GQ37KGdESsY6LzDwVgY/MtNxFTYn9ztxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJwTmif7knZNQTrqeJSM33T0uE9p5STfzo0l6/TOT+lsADIfZN
	fdkR02E7JQdDfKKfZ1Gtj43UGEgo9CJD/TiztDyjvM2EWtDSvi7YmJL49sWjXdXcCiPtlsV6J/z
	w0+HDmR1kgN6O0FksOA327AFf+HoDzMzE18MsOA==
X-Google-Smtp-Source: AGHT+IHqww2BN0wkQwPYdMhnQTg3TxCGlp9Mk+rODktSERGIPDWIjWzjq9myksdgfoZJdBK+HY3p2Z1cUXjFTbwu1Bo=
X-Received: by 2002:a17:90b:17c5:b0:2c2:d590:808e with SMTP id
 98e67ed59e1d1-2d86b00d06fmr4398660a91.13.1725033247242; Fri, 30 Aug 2024
 08:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1718388908.git.tjeznach@rivosinc.com> <e2792d6559f9f3e02b2243538647ef60f14176fd.1718388909.git.tjeznach@rivosinc.com>
 <CALw707q=B4h4CF3CvJOiRMMYqzvO_NG+taMLzZquCP=A9bgu0g@mail.gmail.com>
 <CAH2o1u5qU8y=FHRANQ74WnGfMim24Pho2av17rE5ZObZywjB4g@mail.gmail.com> <f330e50c-677a-4982-8ede-dd1e35cc3954@arm.com>
In-Reply-To: <f330e50c-677a-4982-8ede-dd1e35cc3954@arm.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Fri, 30 Aug 2024 08:53:56 -0700
Message-ID: <CAH2o1u7OO5C7+0uhXg_pVWAekT4=EzZe_uMpziLCun769iLDPA@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] iommu/riscv: Add RISC-V IOMMU PCIe device driver
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jim Shu <jim.shu@sifive.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Anup Patel <apatel@ventanamicro.com>, 
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com, linux-kernel@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nick Kossifidis <mick@ics.forth.gr>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 8:49=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 30/08/2024 4:37 pm, Tomasz Jeznach wrote:
> > On Fri, Aug 30, 2024 at 12:04=E2=80=AFAM Jim Shu <jim.shu@sifive.com> w=
rote:
> >>
> >> Hi Tomasz,
> >>
> >> QEMU RISC-V IOMMU will switch the PCIe vendor/device ID to Red Hat one
> >> [1] in the latest v6 patch.
> >> Will we also support the PCIe ID of Red Hat one in the Linux driver?
> >>
> >
> > Absolutely yes. I've been holding of with adding Red Hat PID/VID to
> > limit number of changes outside iommu subsystem in this patch series,
> > planing to sent single change adding new PCI IDs once this series is
> > accepted.
>
> It shouldn't entail any changes outside this code - per pci_ids.h,
> PCI_VENDOR_ID_REDHAT is already defined, while the individual IOMMU
> device IDs *should* stay local to this driver as the only user of them.
> Similarly, the Rivos vendor ID would only warrant factoring out once
> another driver turns up wanting to share it.
>
> Thanks,
> Robin.
>

Ok, keeping device ID local will make the change simpler. Will add in
next revision.
Thank you for this comment.

Best,
- Tomasz


> > Driver implementation is generic and should correctly
> > interact with QEMU model and other hardware implementations of RISC-V
> > IOMMU specification.
> >
> > Best regards,
> >   - Tomasz
> >
> >> [1] https://patchew.org/QEMU/20240801154334.1009852-1-dbarboza@ventana=
micro.com/20240801154334.1009852-5-dbarboza@ventanamicro.com/
> >>
> >>
> >> Regards,
> >> Jim Shu
> >>
> >>
> >>
> >> On Sat, Jun 15, 2024 at 1:29=E2=80=AFPM Tomasz Jeznach <tjeznach@rivos=
inc.com> wrote:
> >>>
> >>> Introduce device driver for PCIe implementation
> >>> of RISC-V IOMMU architected hardware.
> >>>
> >>> IOMMU hardware and system support for MSI or MSI-X is
> >>> required by this implementation.
> >>>
> >>> Vendor and device identifiers used in this patch
> >>> matches QEMU implementation of the RISC-V IOMMU PCIe
> >>> device, from Rivos VID (0x1efd) range allocated by the PCI-SIG.
> >>>
> >>> MAINTAINERS | added iommu-pci.c already covered by matching pattern.
> >>>
> >>> Link: https://lore.kernel.org/qemu-devel/20240307160319.675044-1-dbar=
boza@ventanamicro.com/
> >>> Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
> >>> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> >>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> >>> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> >>> ---
> >>>   drivers/iommu/riscv/Kconfig     |   5 ++
> >>>   drivers/iommu/riscv/Makefile    |   1 +
> >>>   drivers/iommu/riscv/iommu-pci.c | 119 +++++++++++++++++++++++++++++=
+++
> >>>   3 files changed, 125 insertions(+)
> >>>   create mode 100644 drivers/iommu/riscv/iommu-pci.c
> >>>
> >>> diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfi=
g
> >>> index 5dcc5c45aa50..c071816f59a6 100644
> >>> --- a/drivers/iommu/riscv/Kconfig
> >>> +++ b/drivers/iommu/riscv/Kconfig
> >>> @@ -13,3 +13,8 @@ config RISCV_IOMMU
> >>>
> >>>            Say Y here if your SoC includes an IOMMU device implementi=
ng
> >>>            the RISC-V IOMMU architecture.
> >>> +
> >>> +config RISCV_IOMMU_PCI
> >>> +       def_bool y if RISCV_IOMMU && PCI_MSI
> >>> +       help
> >>> +         Support for the PCIe implementation of RISC-V IOMMU archite=
cture.
> >>> diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makef=
ile
> >>> index e4c189de58d3..f54c9ed17d41 100644
> >>> --- a/drivers/iommu/riscv/Makefile
> >>> +++ b/drivers/iommu/riscv/Makefile
> >>> @@ -1,2 +1,3 @@
> >>>   # SPDX-License-Identifier: GPL-2.0-only
> >>>   obj-$(CONFIG_RISCV_IOMMU) +=3D iommu.o iommu-platform.o
> >>> +obj-$(CONFIG_RISCV_IOMMU_PCI) +=3D iommu-pci.o
> >>> diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/io=
mmu-pci.c
> >>> new file mode 100644
> >>> index 000000000000..e675acceb290
> >>> --- /dev/null
> >>> +++ b/drivers/iommu/riscv/iommu-pci.c
> >>> @@ -0,0 +1,119 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +
> >>> +/*
> >>> + * Copyright =C2=A9 2022-2024 Rivos Inc.
> >>> + * Copyright =C2=A9 2023 FORTH-ICS/CARV
> >>> + *
> >>> + * RISCV IOMMU as a PCIe device
> >>> + *
> >>> + * Authors
> >>> + *     Tomasz Jeznach <tjeznach@rivosinc.com>
> >>> + *     Nick Kossifidis <mick@ics.forth.gr>
> >>> + */
> >>> +
> >>> +#include <linux/compiler.h>
> >>> +#include <linux/init.h>
> >>> +#include <linux/iommu.h>
> >>> +#include <linux/kernel.h>
> >>> +#include <linux/pci.h>
> >>> +
> >>> +#include "iommu-bits.h"
> >>> +#include "iommu.h"
> >>> +
> >>> +/* Rivos Inc. assigned PCI Vendor and Device IDs */
> >>> +#ifndef PCI_VENDOR_ID_RIVOS
> >>> +#define PCI_VENDOR_ID_RIVOS             0x1efd
> >>> +#endif
> >>> +
> >>> +#ifndef PCI_DEVICE_ID_RIVOS_IOMMU
> >>> +#define PCI_DEVICE_ID_RIVOS_IOMMU       0xedf1
> >>> +#endif
> >>> +
> >>> +static int riscv_iommu_pci_probe(struct pci_dev *pdev, const struct =
pci_device_id *ent)
> >>> +{
> >>> +       struct device *dev =3D &pdev->dev;
> >>> +       struct riscv_iommu_device *iommu;
> >>> +       int rc, vec;
> >>> +
> >>> +       rc =3D pcim_enable_device(pdev);
> >>> +       if (rc)
> >>> +               return rc;
> >>> +
> >>> +       if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM))
> >>> +               return -ENODEV;
> >>> +
> >>> +       if (pci_resource_len(pdev, 0) < RISCV_IOMMU_REG_SIZE)
> >>> +               return -ENODEV;
> >>> +
> >>> +       rc =3D pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
> >>> +       if (rc)
> >>> +               return dev_err_probe(dev, rc, "pcim_iomap_regions fai=
led\n");
> >>> +
> >>> +       iommu =3D devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
> >>> +       if (!iommu)
> >>> +               return -ENOMEM;
> >>> +
> >>> +       iommu->dev =3D dev;
> >>> +       iommu->reg =3D pcim_iomap_table(pdev)[0];
> >>> +
> >>> +       pci_set_master(pdev);
> >>> +       dev_set_drvdata(dev, iommu);
> >>> +
> >>> +       /* Check device reported capabilities / features. */
> >>> +       iommu->caps =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAPA=
BILITIES);
> >>> +       iommu->fctl =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL=
);
> >>> +
> >>> +       /* The PCI driver only uses MSIs, make sure the IOMMU support=
s this */
> >>> +       switch (FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps))=
 {
> >>> +       case RISCV_IOMMU_CAPABILITIES_IGS_MSI:
> >>> +       case RISCV_IOMMU_CAPABILITIES_IGS_BOTH:
> >>> +               break;
> >>> +       default:
> >>> +               return dev_err_probe(dev, -ENODEV,
> >>> +                                    "unable to use message-signaled =
interrupts\n");
> >>> +       }
> >>> +
> >>> +       /* Allocate and assign IRQ vectors for the various events */
> >>> +       rc =3D pci_alloc_irq_vectors(pdev, 1, RISCV_IOMMU_INTR_COUNT,
> >>> +                                  PCI_IRQ_MSIX | PCI_IRQ_MSI);
> >>> +       if (rc <=3D 0)
> >>> +               return dev_err_probe(dev, -ENODEV,
> >>> +                                    "unable to allocate irq vectors\=
n");
> >>> +
> >>> +       iommu->irqs_count =3D rc;
> >>> +       for (vec =3D 0; vec < iommu->irqs_count; vec++)
> >>> +               iommu->irqs[vec] =3D msi_get_virq(dev, vec);
> >>> +
> >>> +       /* Enable message-signaled interrupts, fctl.WSI */
> >>> +       if (iommu->fctl & RISCV_IOMMU_FCTL_WSI) {
> >>> +               iommu->fctl ^=3D RISCV_IOMMU_FCTL_WSI;
> >>> +               riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu=
->fctl);
> >>> +       }
> >>> +
> >>> +       return riscv_iommu_init(iommu);
> >>> +}
> >>> +
> >>> +static void riscv_iommu_pci_remove(struct pci_dev *pdev)
> >>> +{
> >>> +       struct riscv_iommu_device *iommu =3D dev_get_drvdata(&pdev->d=
ev);
> >>> +
> >>> +       riscv_iommu_remove(iommu);
> >>> +}
> >>> +
> >>> +static const struct pci_device_id riscv_iommu_pci_tbl[] =3D {
> >>> +       {PCI_VENDOR_ID_RIVOS, PCI_DEVICE_ID_RIVOS_IOMMU,
> >>> +        PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
> >>> +       {0,}
> >>> +};
> >>> +
> >>> +static struct pci_driver riscv_iommu_pci_driver =3D {
> >>> +       .name =3D KBUILD_MODNAME,
> >>> +       .id_table =3D riscv_iommu_pci_tbl,
> >>> +       .probe =3D riscv_iommu_pci_probe,
> >>> +       .remove =3D riscv_iommu_pci_remove,
> >>> +       .driver =3D {
> >>> +               .suppress_bind_attrs =3D true,
> >>> +       },
> >>> +};
> >>> +
> >>> +builtin_pci_driver(riscv_iommu_pci_driver);
> >>> --
> >>> 2.34.1
> >>>
> >>>
> >>> _______________________________________________
> >>> linux-riscv mailing list
> >>> linux-riscv@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-riscv
