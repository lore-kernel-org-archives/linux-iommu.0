Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AD21F8AC4
	for <iommu@lists.linux.dev>; Tue,  3 Dec 2024 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243869; cv=none; b=IFGZwp5DoVgBgKhE4XwlAnB8lZFvj5b6grPL83koWQt84654xATfcIjXVTjYZitNP5BBVa8iePwakwwrisJXtE5Yl+rpSkTzPMUHJX4GzAzy5jiHjM7qOEVYVKVw0CQ+53RyiB0pI6/5+o3vPBQnxkY/ruSldcZpqrM+I6Ns8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243869; c=relaxed/simple;
	bh=ofyNNqa9LTqECGe/gznO0EdfOgfFJo0pEY4QR+7Ei5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8olXxMgtkPGeaG3aExjKj9kMxVOq5LGHeN7mOtFYbIcAMB6Mz2V5RQ3T5BcwabK8E80IHdO1aB8HIjKkFs7f5iFDaUiQIdv4h6NP0G0u+DrJyruK6M/ovn3GE5dSEfbsZh524Fy69Zuc0j7tqx7RUEVkOMfuUMQ1KFtY16P0Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=IRVHVCVh; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="IRVHVCVh"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-84183532291so228664439f.2
        for <iommu@lists.linux.dev>; Tue, 03 Dec 2024 08:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1733243866; x=1733848666; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVEw9Z9xC+e2116o+1WJfODi8M47QRe9C2e4ZFiB9Qs=;
        b=IRVHVCVhOUpb1/4FoOC+DhtGLy3ZhlpEdaqMG6CT4O/H4gLPyNqBJWv0DcDFmHYH/C
         rtMGcl4VhYv+COCRhSlrPsY2b4M7v2uhMf08st3dYo4NhMAB8l9J6t7QFpEKBRgd3tmy
         Imyb7PojyYOMJBdsdv26HpuTleJSv6ZPGcxd7z+RCMWJ9BPmWTKKFSdcvOToPhJsNN6s
         bWevdO5vqefnI0fkMbzlEpozBk1yNBzDFGS2laC/+F8GppXpCybNATtlkoG69xJHBO5p
         y3Kb4U048JYffx3iGzpC68Noif5S18lLM65StwcqhINdA5SE8kvG7vh46GYQFFxz2Wfc
         Efnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733243866; x=1733848666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVEw9Z9xC+e2116o+1WJfODi8M47QRe9C2e4ZFiB9Qs=;
        b=Y/VyMymoud3dh/W7KdE89n+kfv4FHKmlJVlDfeCa8P+vHC5oCllyVfF8h5ukBkN7yE
         2/5z9YsG6/LYW5XH37pP16Dq1c2w4f90VFXhB0IYBZey4xzBV7MWTIm4BP8xAD904nX/
         97mUj5MFKsnplsXxTvBpqCCxOCo027zbCpRIsfPJkLJqbsaqlfUlILfL+cIZ6mgwvelf
         TjRFhJt0gJvjdm6ezr2eY2J39xDkVdtH5amfVruDb0M3X8KxuK2LizC4j7kXj7bv6ZsG
         WIcNW2LwSDKZ3mwoN94u6vlZnhu1cYtEJH81+YEYEURdjinZsCNEr410HAMBr4WYqvNa
         58TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA1lG3gAbGEYjKusgFckk+n4vQ5Q8U5DTmxrRsLZ4qkjYrZltNO3wNFDDYE/ZQasEZl9tHmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGOoktEwsVfGy6WJ7wVdario+5nLsXUbo2YJlnyXbyxW4vVCKR
	KT26ca982ZCSLHkWnZ24larkA0Qi4QuncpJpRm+OgU9+Oli4D9fRzV2o/dmaK0lrD4gcE1RUCbO
	70inh4pIdi7gnimLxIZIY3y6dKeXRth5Z2p2acg==
X-Gm-Gg: ASbGncvodRdge29SEcEFZGmLyoK+/eG1DlaAYvWLWR/2GUT4ZNqdAG1+tS37PAT4Tyz
	BQ66bsJLlqLJY+b81HSRbYpA6p9lAHDAbOA==
X-Google-Smtp-Source: AGHT+IEZS46Tt3F60SbyrRtm2o2atDwxxLqUtooVOzxuLEORF7+J61E8/7nJWNy4oOtVonZIMZTW80oPYgYr7U4CpuY=
X-Received: by 2002:a05:6602:1593:b0:843:e11e:e7e1 with SMTP id
 ca18e2360f4ac-8445b6da045mr370006839f.14.1733243866405; Tue, 03 Dec 2024
 08:37:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241114161845.502027-17-ajones@ventanamicro.com>
 <20241114161845.502027-18-ajones@ventanamicro.com> <87mshcub2u.ffs@tglx>
In-Reply-To: <87mshcub2u.ffs@tglx>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 3 Dec 2024 22:07:35 +0530
Message-ID: <CAAhSdy08gi998HsTkGpaV+bTWczVSL6D8c7EmuTQqovo63oXDw@mail.gmail.com>
Subject: Re: [RFC PATCH 01/15] irqchip/riscv-imsic: Use hierarchy to reach irq_set_affinity
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Jones <ajones@ventanamicro.com>, iommu@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tjeznach@rivosinc.com, zong.li@sifive.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, atishp@atishpatra.org, alex.williamson@redhat.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 7:23=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Thu, Nov 14 2024 at 17:18, Andrew Jones wrote:
> > @@ -96,9 +96,8 @@ static int imsic_irq_set_affinity(struct irq_data *d,=
 const struct cpumask *mask
> >                                 bool force)
> >  {
> >       struct imsic_vector *old_vec, *new_vec;
> > -     struct irq_data *pd =3D d->parent_data;
> >
> > -     old_vec =3D irq_data_get_irq_chip_data(pd);
> > +     old_vec =3D irq_data_get_irq_chip_data(d);
> >       if (WARN_ON(!old_vec))
> >               return -ENOENT;
> >
> > @@ -116,13 +115,13 @@ static int imsic_irq_set_affinity(struct irq_data=
 *d, const struct cpumask *mask
> >               return -ENOSPC;
> >
> >       /* Point device to the new vector */
> > -     imsic_msi_update_msg(d, new_vec);
> > +     imsic_msi_update_msg(irq_get_irq_data(d->irq), new_vec);
>
> This looks more than fishy. See below.
>
> > @@ -245,7 +247,7 @@ static bool imsic_init_dev_msi_info(struct device *=
dev,
> >               if (WARN_ON_ONCE(domain !=3D real_parent))
> >                       return false;
> >  #ifdef CONFIG_SMP
> > -             info->chip->irq_set_affinity =3D imsic_irq_set_affinity;
> > +             info->chip->irq_set_affinity =3D irq_chip_set_affinity_pa=
rent;
>
> This should use msi_domain_set_affinity(), which does the right thing:
>
>   1) It invokes the irq_set_affinity() callback of the parent domain
>
>   2) It composes the message via the hierarchy
>
>   3) It writes the message with the msi_write_msg() callback of the top
>      level domain
>
> Sorry, I missed that when reviewing the original IMSIC MSI support.
>
> The whole IMSIC MSI support can be moved over to MSI LIB which makes all
> of this indirection go away and your intermediate domain will just fit
> in.
>
> Uncompiled patch below. If that works, it needs to be split up properly.
>
> Note, this removes the setup of the irq_retrigger callback, but that's
> fine because on hierarchical domains irq_chip_retrigger_hierarchy() is
> invoked anyway. See try_retrigger().

The IMSIC driver was merged one kernel release before common
MSI LIB was merged.

We should definitely update the IMSIC driver to use MSI LIB, I will
try your suggested changes (below) and post a separate series.

Thanks,
Anup

>
> Thanks,
>
>         tglx
> ---
>  drivers/irqchip/Kconfig                    |    1
>  drivers/irqchip/irq-gic-v2m.c              |    1
>  drivers/irqchip/irq-imx-mu-msi.c           |    1
>  drivers/irqchip/irq-msi-lib.c              |   11 +-
>  drivers/irqchip/irq-mvebu-gicp.c           |    1
>  drivers/irqchip/irq-mvebu-odmi.c           |    1
>  drivers/irqchip/irq-mvebu-sei.c            |    1
>  drivers/irqchip/irq-riscv-imsic-platform.c |  131 +---------------------=
-------
>  include/linux/msi.h                        |   11 ++
>  9 files changed, 32 insertions(+), 127 deletions(-)
>
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -587,6 +587,7 @@ config RISCV_IMSIC
>         select IRQ_DOMAIN_HIERARCHY
>         select GENERIC_IRQ_MATRIX_ALLOCATOR
>         select GENERIC_MSI_IRQ
> +       select IRQ_MSI_LIB
>
>  config RISCV_IMSIC_PCI
>         bool
> --- a/drivers/irqchip/irq-gic-v2m.c
> +++ b/drivers/irqchip/irq-gic-v2m.c
> @@ -255,6 +255,7 @@ static void __init gicv2m_teardown(void)
>  static struct msi_parent_ops gicv2m_msi_parent_ops =3D {
>         .supported_flags        =3D GICV2M_MSI_FLAGS_SUPPORTED,
>         .required_flags         =3D GICV2M_MSI_FLAGS_REQUIRED,
> +       .chip_flags             =3D MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG=
_SET_ACK,
>         .bus_select_token       =3D DOMAIN_BUS_NEXUS,
>         .bus_select_mask        =3D MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
>         .prefix                 =3D "GICv2m-",
> --- a/drivers/irqchip/irq-imx-mu-msi.c
> +++ b/drivers/irqchip/irq-imx-mu-msi.c
> @@ -214,6 +214,7 @@ static void imx_mu_msi_irq_handler(struc
>  static const struct msi_parent_ops imx_mu_msi_parent_ops =3D {
>         .supported_flags        =3D IMX_MU_MSI_FLAGS_SUPPORTED,
>         .required_flags         =3D IMX_MU_MSI_FLAGS_REQUIRED,
> +       .chip_flags             =3D MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG=
_SET_ACK,
>         .bus_select_token       =3D DOMAIN_BUS_NEXUS,
>         .bus_select_mask        =3D MATCH_PLATFORM_MSI,
>         .prefix                 =3D "MU-MSI-",
> --- a/drivers/irqchip/irq-msi-lib.c
> +++ b/drivers/irqchip/irq-msi-lib.c
> @@ -28,6 +28,7 @@ bool msi_lib_init_dev_msi_info(struct de
>                                struct msi_domain_info *info)
>  {
>         const struct msi_parent_ops *pops =3D real_parent->msi_parent_ops=
;
> +       struct irq_chip *chip =3D info->chip;
>         u32 required_flags;
>
>         /* Parent ops available? */
> @@ -92,10 +93,10 @@ bool msi_lib_init_dev_msi_info(struct de
>         info->flags                     |=3D required_flags;
>
>         /* Chip updates for all child bus types */
> -       if (!info->chip->irq_eoi)
> -               info->chip->irq_eoi     =3D irq_chip_eoi_parent;
> -       if (!info->chip->irq_ack)
> -               info->chip->irq_ack     =3D irq_chip_ack_parent;
> +       if (!chip->irq_eoi && (pops->chip_flags & MSI_CHIP_FLAG_SET_EOI))
> +               chip->irq_eoi           =3D irq_chip_eoi_parent;
> +       if (!chip->irq_ack && (pops->chip_flags & MSI_CHIP_FLAG_SET_ACK))
> +               chip->irq_ack           =3D irq_chip_ack_parent;
>
>         /*
>          * The device MSI domain can never have a set affinity callback. =
It
> @@ -105,7 +106,7 @@ bool msi_lib_init_dev_msi_info(struct de
>          * device MSI domain aside of mask/unmask which is provided e.g. =
by
>          * PCI/MSI device domains.
>          */
> -       info->chip->irq_set_affinity    =3D msi_domain_set_affinity;
> +       chip->irq_set_affinity          =3D msi_domain_set_affinity;
>         return true;
>  }
>  EXPORT_SYMBOL_GPL(msi_lib_init_dev_msi_info);
> --- a/drivers/irqchip/irq-mvebu-gicp.c
> +++ b/drivers/irqchip/irq-mvebu-gicp.c
> @@ -161,6 +161,7 @@ static const struct irq_domain_ops gicp_
>  static const struct msi_parent_ops gicp_msi_parent_ops =3D {
>         .supported_flags        =3D GICP_MSI_FLAGS_SUPPORTED,
>         .required_flags         =3D GICP_MSI_FLAGS_REQUIRED,
> +       .chip_flags             =3D MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG=
_SET_ACK,
>         .bus_select_token       =3D DOMAIN_BUS_GENERIC_MSI,
>         .bus_select_mask        =3D MATCH_PLATFORM_MSI,
>         .prefix                 =3D "GICP-",
> --- a/drivers/irqchip/irq-mvebu-odmi.c
> +++ b/drivers/irqchip/irq-mvebu-odmi.c
> @@ -157,6 +157,7 @@ static const struct irq_domain_ops odmi_
>  static const struct msi_parent_ops odmi_msi_parent_ops =3D {
>         .supported_flags        =3D ODMI_MSI_FLAGS_SUPPORTED,
>         .required_flags         =3D ODMI_MSI_FLAGS_REQUIRED,
> +       .chip_flags             =3D MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG=
_SET_ACK,
>         .bus_select_token       =3D DOMAIN_BUS_GENERIC_MSI,
>         .bus_select_mask        =3D MATCH_PLATFORM_MSI,
>         .prefix                 =3D "ODMI-",
> --- a/drivers/irqchip/irq-mvebu-sei.c
> +++ b/drivers/irqchip/irq-mvebu-sei.c
> @@ -356,6 +356,7 @@ static void mvebu_sei_reset(struct mvebu
>  static const struct msi_parent_ops sei_msi_parent_ops =3D {
>         .supported_flags        =3D SEI_MSI_FLAGS_SUPPORTED,
>         .required_flags         =3D SEI_MSI_FLAGS_REQUIRED,
> +       .chip_flags             =3D MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG=
_SET_ACK,
>         .bus_select_mask        =3D MATCH_PLATFORM_MSI,
>         .bus_select_token       =3D DOMAIN_BUS_GENERIC_MSI,
>         .prefix                 =3D "SEI-",
> --- a/drivers/irqchip/irq-riscv-imsic-platform.c
> +++ b/drivers/irqchip/irq-riscv-imsic-platform.c
> @@ -21,6 +21,7 @@
>  #include <linux/smp.h>
>
>  #include "irq-riscv-imsic-state.h"
> +#include "irq-msi-lib.h"
>
>  static bool imsic_cpu_page_phys(unsigned int cpu, unsigned int guest_ind=
ex,
>                                 phys_addr_t *out_msi_pa)
> @@ -84,19 +85,10 @@ static void imsic_irq_compose_msg(struct
>  }
>
>  #ifdef CONFIG_SMP
> -static void imsic_msi_update_msg(struct irq_data *d, struct imsic_vector=
 *vec)
> -{
> -       struct msi_msg msg =3D { };
> -
> -       imsic_irq_compose_vector_msg(vec, &msg);
> -       irq_data_get_irq_chip(d)->irq_write_msi_msg(d, &msg);
> -}
> -
>  static int imsic_irq_set_affinity(struct irq_data *d, const struct cpuma=
sk *mask_val,
>                                   bool force)
>  {
>         struct imsic_vector *old_vec, *new_vec;
> -       struct irq_data *pd =3D d->parent_data;
>
>         old_vec =3D irq_data_get_irq_chip_data(pd);
>         if (WARN_ON(!old_vec))
> @@ -115,14 +107,11 @@ static int imsic_irq_set_affinity(struct
>         if (!new_vec)
>                 return -ENOSPC;
>
> -       /* Point device to the new vector */
> -       imsic_msi_update_msg(d, new_vec);
> -
>         /* Update irq descriptors with the new vector */
> -       pd->chip_data =3D new_vec;
> +       d->chip_data =3D new_vec;
>
>         /* Update effective affinity of parent irq data */
> -       irq_data_update_effective_affinity(pd, cpumask_of(new_vec->cpu));
> +       irq_data_update_effective_affinity(d, cpumask_of(new_vec->cpu));
>
>         /* Move state of the old vector to the new vector */
>         imsic_vector_move(old_vec, new_vec);
> @@ -137,6 +126,9 @@ static struct irq_chip imsic_irq_base_ch
>         .irq_unmask             =3D imsic_irq_unmask,
>         .irq_retrigger          =3D imsic_irq_retrigger,
>         .irq_compose_msi_msg    =3D imsic_irq_compose_msg,
> +#ifdef CONFIG_SMP
> +       .irq_set_affinity       =3D imsic_irq_set_affinity,
> +#endif
>         .flags                  =3D IRQCHIP_SKIP_SET_WAKE |
>                                   IRQCHIP_MASK_ON_SUSPEND,
>  };
> @@ -172,22 +164,6 @@ static void imsic_irq_domain_free(struct
>         irq_domain_free_irqs_parent(domain, virq, nr_irqs);
>  }
>
> -static int imsic_irq_domain_select(struct irq_domain *domain, struct irq=
_fwspec *fwspec,
> -                                  enum irq_domain_bus_token bus_token)
> -{
> -       const struct msi_parent_ops *ops =3D domain->msi_parent_ops;
> -       u32 busmask =3D BIT(bus_token);
> -
> -       if (fwspec->fwnode !=3D domain->fwnode || fwspec->param_count !=
=3D 0)
> -               return 0;
> -
> -       /* Handle pure domain searches */
> -       if (bus_token =3D=3D ops->bus_select_token)
> -               return 1;
> -
> -       return !!(ops->bus_select_mask & busmask);
> -}
> -
>  #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
>  static void imsic_irq_debug_show(struct seq_file *m, struct irq_domain *=
d,
>                                  struct irq_data *irqd, int ind)
> @@ -210,104 +186,15 @@ static const struct irq_domain_ops imsic
>  #endif
>  };
>
> -#ifdef CONFIG_RISCV_IMSIC_PCI
> -
> -static void imsic_pci_mask_irq(struct irq_data *d)
> -{
> -       pci_msi_mask_irq(d);
> -       irq_chip_mask_parent(d);
> -}
> -
> -static void imsic_pci_unmask_irq(struct irq_data *d)
> -{
> -       irq_chip_unmask_parent(d);
> -       pci_msi_unmask_irq(d);
> -}
> -
> -#define MATCH_PCI_MSI          BIT(DOMAIN_BUS_PCI_MSI)
> -
> -#else
> -
> -#define MATCH_PCI_MSI          0
> -
> -#endif
> -
> -static bool imsic_init_dev_msi_info(struct device *dev,
> -                                   struct irq_domain *domain,
> -                                   struct irq_domain *real_parent,
> -                                   struct msi_domain_info *info)
> -{
> -       const struct msi_parent_ops *pops =3D real_parent->msi_parent_ops=
;
> -
> -       /* MSI parent domain specific settings */
> -       switch (real_parent->bus_token) {
> -       case DOMAIN_BUS_NEXUS:
> -               if (WARN_ON_ONCE(domain !=3D real_parent))
> -                       return false;
> -#ifdef CONFIG_SMP
> -               info->chip->irq_set_affinity =3D imsic_irq_set_affinity;
> -#endif
> -               break;
> -       default:
> -               WARN_ON_ONCE(1);
> -               return false;
> -       }
> -
> -       /* Is the target supported? */
> -       switch (info->bus_token) {
> -#ifdef CONFIG_RISCV_IMSIC_PCI
> -       case DOMAIN_BUS_PCI_DEVICE_MSI:
> -       case DOMAIN_BUS_PCI_DEVICE_MSIX:
> -               info->chip->irq_mask =3D imsic_pci_mask_irq;
> -               info->chip->irq_unmask =3D imsic_pci_unmask_irq;
> -               break;
> -#endif
> -       case DOMAIN_BUS_DEVICE_MSI:
> -               /*
> -                * Per-device MSI should never have any MSI feature bits
> -                * set. It's sole purpose is to create a dumb interrupt
> -                * chip which has a device specific irq_write_msi_msg()
> -                * callback.
> -                */
> -               if (WARN_ON_ONCE(info->flags))
> -                       return false;
> -
> -               /* Core managed MSI descriptors */
> -               info->flags |=3D MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS |
> -                              MSI_FLAG_FREE_MSI_DESCS;
> -               break;
> -       case DOMAIN_BUS_WIRED_TO_MSI:
> -               break;
> -       default:
> -               WARN_ON_ONCE(1);
> -               return false;
> -       }
> -
> -       /* Use hierarchial chip operations re-trigger */
> -       info->chip->irq_retrigger =3D irq_chip_retrigger_hierarchy;
> -
> -       /*
> -        * Mask out the domain specific MSI feature flags which are not
> -        * supported by the real parent.
> -        */
> -       info->flags &=3D pops->supported_flags;
> -
> -       /* Enforce the required flags */
> -       info->flags |=3D pops->required_flags;
> -
> -       return true;
> -}
> -
> -#define MATCH_PLATFORM_MSI             BIT(DOMAIN_BUS_PLATFORM_MSI)
> -
>  static const struct msi_parent_ops imsic_msi_parent_ops =3D {
>         .supported_flags        =3D MSI_GENERIC_FLAGS_MASK |
>                                   MSI_FLAG_PCI_MSIX,
>         .required_flags         =3D MSI_FLAG_USE_DEF_DOM_OPS |
> -                                 MSI_FLAG_USE_DEF_CHIP_OPS,
> +                                 MSI_FLAG_USE_DEF_CHIP_OPS |
> +                                 MSI_FLAG_PCI_MSI_MASK_PARENT,
>         .bus_select_token       =3D DOMAIN_BUS_NEXUS,
>         .bus_select_mask        =3D MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
> -       .init_dev_msi_info      =3D imsic_init_dev_msi_info,
> +       .init_dev_msi_info      =3D msi_lib_init_dev_msi_info,
>  };
>
>  int imsic_irqdomain_init(void)
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -558,11 +558,21 @@ enum {
>         MSI_FLAG_NO_AFFINITY            =3D (1 << 21),
>  };
>
> +/*
> + * Flags for msi_parent_ops::chip_flags
> + */
> +enum {
> +       MSI_CHIP_FLAG_SET_EOI           =3D (1 << 0),
> +       MSI_CHIP_FLAG_SET_ACK           =3D (1 << 1),
> +};
> +
>  /**
>   * struct msi_parent_ops - MSI parent domain callbacks and configuration=
 info
>   *
>   * @supported_flags:   Required: The supported MSI flags of the parent d=
omain
>   * @required_flags:    Optional: The required MSI flags of the parent MS=
I domain
> + * @chip_flags:                Optional: Select MSI chip callbacks to up=
date with defaults
> + *                     in msi_lib_init_dev_msi_info().
>   * @bus_select_token:  Optional: The bus token of the real parent domain=
 for
>   *                     irq_domain::select()
>   * @bus_select_mask:   Optional: A mask of supported BUS_DOMAINs for
> @@ -575,6 +585,7 @@ enum {
>  struct msi_parent_ops {
>         u32             supported_flags;
>         u32             required_flags;
> +       u32             chip_flags;
>         u32             bus_select_token;
>         u32             bus_select_mask;
>         const char      *prefix;
