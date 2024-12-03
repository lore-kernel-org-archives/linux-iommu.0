Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FFF1F8933
	for <iommu@lists.linux.dev>; Tue,  3 Dec 2024 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243244; cv=none; b=R/jtZ7/6sLj+mc4ASBh+FcI027VQ/d6zjzgZkI8SOIFyxRGVQu5YjfyY8M79bw9ox39gcOjfYA2C2E7phJcgn9x+R6MlEEr0oagucVriExRNhlqNzabuhgR5tP8yzJEg/w3QN2SkNSiUzUWuNPGMyUZ1P+RiC6uFESgNZ9Lz2TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243244; c=relaxed/simple;
	bh=t9FtTjl2Qd2XU4K0SKkWVUPjBtdLw/kWMASthxIoOwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gb47shkhEQeUyuvmdxGLIQ3wtJb7eRP7XYpwScT7vkxWI29u9w/7Inu0IrHm9fUspuqMQ2Vp0rww6bOB+u06IkjqBl4vIe7pYNcSpn0TtpnHPXTflSYFfSaQpt4lipYgYh7xhLDD2ophcQx9sEuNuhKZIWDKwA9G0caWyFLf9T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=GP31QH/0; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GP31QH/0"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d0ccd931a3so4700888a12.3
        for <iommu@lists.linux.dev>; Tue, 03 Dec 2024 08:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1733243239; x=1733848039; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KupetNXY4u45/xmKXxyRB+jVlLoly3QUtfmqm/1xvDw=;
        b=GP31QH/0oIri6fCzUkVS1XC7P7UB6OKQTrfH2doYd1q4IR7Y4U9MjKyT7StMXn/dEP
         uGrxr3UznP114A/ffi4Wa53ykVsupL0VjjbLK/PQr1BxeRqPvL5OBVi+gwZ5pQ96IxH8
         2DP/JDEh/+BROMxWLMEemtod8s7cTx0XJ52yzhe2Lj+0rPlnWigSyauahjwjRiJpIkfg
         T4wCCrVV1zpywmSCZK6a1yoNqvJ5RKuK6pbvMbC9cs+yEchOxsR+/sQgnRBGZG2hwmrF
         Se735Ig7QAaODM16lbCZbSLFOBJw20lLHv89N/KBghPGLYMgf19VT9J85h07yOmVUsdd
         KulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733243239; x=1733848039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KupetNXY4u45/xmKXxyRB+jVlLoly3QUtfmqm/1xvDw=;
        b=AoiXWMRZIHkKswTWf4Bgxsh2253prysmpbjxsWhWepsIqyPZERCNwmjuag9Gr4ybIn
         SOTgylYhqty1L3mXKZO2bAB016Zx1+BK3kafBzoPqnhdYCuZOgR1wSHBvLN7ITk+pRiX
         D85me1SRmVhZ4HiJ9wXQ7DcUmmgsRnt8wpqcLCzJTyS4NMRd93phByEbIRXdF2Qqx/DM
         Usg6t2pGBxtIzdVVvWPNUQhjuwmvAaHsSZsJ4yYq92ZkAmSHML8po5xX21oZbnpoGRMp
         boeYS3NTY5NHXbZ03EPcxC4q58H5nAfYp836VZn0enF6l8RQSdPnXCKg4e972fiGtV9v
         cDWA==
X-Gm-Message-State: AOJu0YyTNOoem2b9xSG/V164ctEck143UhkQCSOcKt4b7BI4zYiDs3Dk
	1sXvdiaDBTuzBsXmoTnp21/Y2KfuatG7rR+TLWGF7ST8PkeMuh1PYeCgs+01xTA=
X-Gm-Gg: ASbGnctcP1R9KKW5BdWb/y/pATlK+4BnF0nyDpEPJ/igsg+X5aE/ncdR0xO7oxUxgf8
	75uKXPj3vfihcK/+ydsU4KEPOpVImPk1p0ZDEfm1EynGhFFAtRGnGqzZMWWaQsd24G5cxJ6dNEF
	CFH5O5aO1nEzrPCNtMXc6Td5uwe1zMNfURK85UMvYntDl7dknG4yWVruulFO+XMUVTBfpSJMua9
	btXJ8kLT85RTR0k6ErtYeXqp7AFnkfuV5h+yZEOXHA5onEn74cdVJvHPmhLs77bbaRTYELgJNCR
	jv8HuaLauJwone0Tu6zPOcK0CunEZT5V8fA=
X-Google-Smtp-Source: AGHT+IHdd79PQPZ7+iToSs0C8fvEmrGY0++TLJ6JZXZMdw2nkdTXtkpt3KyVtShFY/vLe5kG+lOIUw==
X-Received: by 2002:a05:6402:524f:b0:5d0:81f3:18bc with SMTP id 4fb4d7f45d1cf-5d10cb4e3b7mr2985799a12.1.1733243237964;
        Tue, 03 Dec 2024 08:27:17 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0eb2d116csm2464485a12.61.2024.12.03.08.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 08:27:17 -0800 (PST)
Date: Tue, 3 Dec 2024 17:27:16 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tjeznach@rivosinc.com, zong.li@sifive.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, anup@brainfault.org, atishp@atishpatra.org, 
	alex.williamson@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu
Subject: Re: [RFC PATCH 01/15] irqchip/riscv-imsic: Use hierarchy to reach
 irq_set_affinity
Message-ID: <20241203-1cadc72be6883bc2d77a8050@orel>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
 <20241114161845.502027-18-ajones@ventanamicro.com>
 <87mshcub2u.ffs@tglx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mshcub2u.ffs@tglx>

On Tue, Dec 03, 2024 at 02:53:45PM +0100, Thomas Gleixner wrote:
> On Thu, Nov 14 2024 at 17:18, Andrew Jones wrote:
> > @@ -96,9 +96,8 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
> >  				  bool force)
> >  {
> >  	struct imsic_vector *old_vec, *new_vec;
> > -	struct irq_data *pd = d->parent_data;
> >  
> > -	old_vec = irq_data_get_irq_chip_data(pd);
> > +	old_vec = irq_data_get_irq_chip_data(d);
> >  	if (WARN_ON(!old_vec))
> >  		return -ENOENT;
> >  
> > @@ -116,13 +115,13 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
> >  		return -ENOSPC;
> >  
> >  	/* Point device to the new vector */
> > -	imsic_msi_update_msg(d, new_vec);
> > +	imsic_msi_update_msg(irq_get_irq_data(d->irq), new_vec);
> 
> This looks more than fishy. See below.
> 
> > @@ -245,7 +247,7 @@ static bool imsic_init_dev_msi_info(struct device *dev,
> >  		if (WARN_ON_ONCE(domain != real_parent))
> >  			return false;
> >  #ifdef CONFIG_SMP
> > -		info->chip->irq_set_affinity = imsic_irq_set_affinity;
> > +		info->chip->irq_set_affinity = irq_chip_set_affinity_parent;
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

Thanks Thomas. I gave your patch below a go, but we now fail to have an
msi domain set up when probing devices which go through aplic_msi_setup(),
resulting in an immediate NULL deference in
msi_create_device_irq_domain(). I'll look closer tomorrow.

Thanks,
drew

> 
> Note, this removes the setup of the irq_retrigger callback, but that's
> fine because on hierarchical domains irq_chip_retrigger_hierarchy() is
> invoked anyway. See try_retrigger().
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
>  drivers/irqchip/irq-riscv-imsic-platform.c |  131 +----------------------------
>  include/linux/msi.h                        |   11 ++
>  9 files changed, 32 insertions(+), 127 deletions(-)
> 
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -587,6 +587,7 @@ config RISCV_IMSIC
>  	select IRQ_DOMAIN_HIERARCHY
>  	select GENERIC_IRQ_MATRIX_ALLOCATOR
>  	select GENERIC_MSI_IRQ
> +	select IRQ_MSI_LIB
>  
>  config RISCV_IMSIC_PCI
>  	bool
> --- a/drivers/irqchip/irq-gic-v2m.c
> +++ b/drivers/irqchip/irq-gic-v2m.c
> @@ -255,6 +255,7 @@ static void __init gicv2m_teardown(void)
>  static struct msi_parent_ops gicv2m_msi_parent_ops = {
>  	.supported_flags	= GICV2M_MSI_FLAGS_SUPPORTED,
>  	.required_flags		= GICV2M_MSI_FLAGS_REQUIRED,
> +	.chip_flags		= MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
>  	.bus_select_token	= DOMAIN_BUS_NEXUS,
>  	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
>  	.prefix			= "GICv2m-",
> --- a/drivers/irqchip/irq-imx-mu-msi.c
> +++ b/drivers/irqchip/irq-imx-mu-msi.c
> @@ -214,6 +214,7 @@ static void imx_mu_msi_irq_handler(struc
>  static const struct msi_parent_ops imx_mu_msi_parent_ops = {
>  	.supported_flags	= IMX_MU_MSI_FLAGS_SUPPORTED,
>  	.required_flags		= IMX_MU_MSI_FLAGS_REQUIRED,
> +	.chip_flags		= MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
>  	.bus_select_token       = DOMAIN_BUS_NEXUS,
>  	.bus_select_mask	= MATCH_PLATFORM_MSI,
>  	.prefix			= "MU-MSI-",
> --- a/drivers/irqchip/irq-msi-lib.c
> +++ b/drivers/irqchip/irq-msi-lib.c
> @@ -28,6 +28,7 @@ bool msi_lib_init_dev_msi_info(struct de
>  			       struct msi_domain_info *info)
>  {
>  	const struct msi_parent_ops *pops = real_parent->msi_parent_ops;
> +	struct irq_chip *chip = info->chip;
>  	u32 required_flags;
>  
>  	/* Parent ops available? */
> @@ -92,10 +93,10 @@ bool msi_lib_init_dev_msi_info(struct de
>  	info->flags			|= required_flags;
>  
>  	/* Chip updates for all child bus types */
> -	if (!info->chip->irq_eoi)
> -		info->chip->irq_eoi	= irq_chip_eoi_parent;
> -	if (!info->chip->irq_ack)
> -		info->chip->irq_ack	= irq_chip_ack_parent;
> +	if (!chip->irq_eoi && (pops->chip_flags & MSI_CHIP_FLAG_SET_EOI))
> +		chip->irq_eoi		= irq_chip_eoi_parent;
> +	if (!chip->irq_ack && (pops->chip_flags & MSI_CHIP_FLAG_SET_ACK))
> +		chip->irq_ack		= irq_chip_ack_parent;
>  
>  	/*
>  	 * The device MSI domain can never have a set affinity callback. It
> @@ -105,7 +106,7 @@ bool msi_lib_init_dev_msi_info(struct de
>  	 * device MSI domain aside of mask/unmask which is provided e.g. by
>  	 * PCI/MSI device domains.
>  	 */
> -	info->chip->irq_set_affinity	= msi_domain_set_affinity;
> +	chip->irq_set_affinity		= msi_domain_set_affinity;
>  	return true;
>  }
>  EXPORT_SYMBOL_GPL(msi_lib_init_dev_msi_info);
> --- a/drivers/irqchip/irq-mvebu-gicp.c
> +++ b/drivers/irqchip/irq-mvebu-gicp.c
> @@ -161,6 +161,7 @@ static const struct irq_domain_ops gicp_
>  static const struct msi_parent_ops gicp_msi_parent_ops = {
>  	.supported_flags	= GICP_MSI_FLAGS_SUPPORTED,
>  	.required_flags		= GICP_MSI_FLAGS_REQUIRED,
> +	.chip_flags		= MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
>  	.bus_select_token       = DOMAIN_BUS_GENERIC_MSI,
>  	.bus_select_mask	= MATCH_PLATFORM_MSI,
>  	.prefix			= "GICP-",
> --- a/drivers/irqchip/irq-mvebu-odmi.c
> +++ b/drivers/irqchip/irq-mvebu-odmi.c
> @@ -157,6 +157,7 @@ static const struct irq_domain_ops odmi_
>  static const struct msi_parent_ops odmi_msi_parent_ops = {
>  	.supported_flags	= ODMI_MSI_FLAGS_SUPPORTED,
>  	.required_flags		= ODMI_MSI_FLAGS_REQUIRED,
> +	.chip_flags		= MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
>  	.bus_select_token	= DOMAIN_BUS_GENERIC_MSI,
>  	.bus_select_mask	= MATCH_PLATFORM_MSI,
>  	.prefix			= "ODMI-",
> --- a/drivers/irqchip/irq-mvebu-sei.c
> +++ b/drivers/irqchip/irq-mvebu-sei.c
> @@ -356,6 +356,7 @@ static void mvebu_sei_reset(struct mvebu
>  static const struct msi_parent_ops sei_msi_parent_ops = {
>  	.supported_flags	= SEI_MSI_FLAGS_SUPPORTED,
>  	.required_flags		= SEI_MSI_FLAGS_REQUIRED,
> +	.chip_flags		= MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
>  	.bus_select_mask	= MATCH_PLATFORM_MSI,
>  	.bus_select_token	= DOMAIN_BUS_GENERIC_MSI,
>  	.prefix			= "SEI-",
> --- a/drivers/irqchip/irq-riscv-imsic-platform.c
> +++ b/drivers/irqchip/irq-riscv-imsic-platform.c
> @@ -21,6 +21,7 @@
>  #include <linux/smp.h>
>  
>  #include "irq-riscv-imsic-state.h"
> +#include "irq-msi-lib.h"
>  
>  static bool imsic_cpu_page_phys(unsigned int cpu, unsigned int guest_index,
>  				phys_addr_t *out_msi_pa)
> @@ -84,19 +85,10 @@ static void imsic_irq_compose_msg(struct
>  }
>  
>  #ifdef CONFIG_SMP
> -static void imsic_msi_update_msg(struct irq_data *d, struct imsic_vector *vec)
> -{
> -	struct msi_msg msg = { };
> -
> -	imsic_irq_compose_vector_msg(vec, &msg);
> -	irq_data_get_irq_chip(d)->irq_write_msi_msg(d, &msg);
> -}
> -
>  static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>  				  bool force)
>  {
>  	struct imsic_vector *old_vec, *new_vec;
> -	struct irq_data *pd = d->parent_data;
>  
>  	old_vec = irq_data_get_irq_chip_data(pd);
>  	if (WARN_ON(!old_vec))
> @@ -115,14 +107,11 @@ static int imsic_irq_set_affinity(struct
>  	if (!new_vec)
>  		return -ENOSPC;
>  
> -	/* Point device to the new vector */
> -	imsic_msi_update_msg(d, new_vec);
> -
>  	/* Update irq descriptors with the new vector */
> -	pd->chip_data = new_vec;
> +	d->chip_data = new_vec;
>  
>  	/* Update effective affinity of parent irq data */
> -	irq_data_update_effective_affinity(pd, cpumask_of(new_vec->cpu));
> +	irq_data_update_effective_affinity(d, cpumask_of(new_vec->cpu));
>  
>  	/* Move state of the old vector to the new vector */
>  	imsic_vector_move(old_vec, new_vec);
> @@ -137,6 +126,9 @@ static struct irq_chip imsic_irq_base_ch
>  	.irq_unmask		= imsic_irq_unmask,
>  	.irq_retrigger		= imsic_irq_retrigger,
>  	.irq_compose_msi_msg	= imsic_irq_compose_msg,
> +#ifdef CONFIG_SMP
> +	.irq_set_affinity	= imsic_irq_set_affinity,
> +#endif
>  	.flags			= IRQCHIP_SKIP_SET_WAKE |
>  				  IRQCHIP_MASK_ON_SUSPEND,
>  };
> @@ -172,22 +164,6 @@ static void imsic_irq_domain_free(struct
>  	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
>  }
>  
> -static int imsic_irq_domain_select(struct irq_domain *domain, struct irq_fwspec *fwspec,
> -				   enum irq_domain_bus_token bus_token)
> -{
> -	const struct msi_parent_ops *ops = domain->msi_parent_ops;
> -	u32 busmask = BIT(bus_token);
> -
> -	if (fwspec->fwnode != domain->fwnode || fwspec->param_count != 0)
> -		return 0;
> -
> -	/* Handle pure domain searches */
> -	if (bus_token == ops->bus_select_token)
> -		return 1;
> -
> -	return !!(ops->bus_select_mask & busmask);
> -}
> -
>  #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
>  static void imsic_irq_debug_show(struct seq_file *m, struct irq_domain *d,
>  				 struct irq_data *irqd, int ind)
> @@ -210,104 +186,15 @@ static const struct irq_domain_ops imsic
>  #endif
>  };
>  
> -#ifdef CONFIG_RISCV_IMSIC_PCI
> -
> -static void imsic_pci_mask_irq(struct irq_data *d)
> -{
> -	pci_msi_mask_irq(d);
> -	irq_chip_mask_parent(d);
> -}
> -
> -static void imsic_pci_unmask_irq(struct irq_data *d)
> -{
> -	irq_chip_unmask_parent(d);
> -	pci_msi_unmask_irq(d);
> -}
> -
> -#define MATCH_PCI_MSI		BIT(DOMAIN_BUS_PCI_MSI)
> -
> -#else
> -
> -#define MATCH_PCI_MSI		0
> -
> -#endif
> -
> -static bool imsic_init_dev_msi_info(struct device *dev,
> -				    struct irq_domain *domain,
> -				    struct irq_domain *real_parent,
> -				    struct msi_domain_info *info)
> -{
> -	const struct msi_parent_ops *pops = real_parent->msi_parent_ops;
> -
> -	/* MSI parent domain specific settings */
> -	switch (real_parent->bus_token) {
> -	case DOMAIN_BUS_NEXUS:
> -		if (WARN_ON_ONCE(domain != real_parent))
> -			return false;
> -#ifdef CONFIG_SMP
> -		info->chip->irq_set_affinity = imsic_irq_set_affinity;
> -#endif
> -		break;
> -	default:
> -		WARN_ON_ONCE(1);
> -		return false;
> -	}
> -
> -	/* Is the target supported? */
> -	switch (info->bus_token) {
> -#ifdef CONFIG_RISCV_IMSIC_PCI
> -	case DOMAIN_BUS_PCI_DEVICE_MSI:
> -	case DOMAIN_BUS_PCI_DEVICE_MSIX:
> -		info->chip->irq_mask = imsic_pci_mask_irq;
> -		info->chip->irq_unmask = imsic_pci_unmask_irq;
> -		break;
> -#endif
> -	case DOMAIN_BUS_DEVICE_MSI:
> -		/*
> -		 * Per-device MSI should never have any MSI feature bits
> -		 * set. It's sole purpose is to create a dumb interrupt
> -		 * chip which has a device specific irq_write_msi_msg()
> -		 * callback.
> -		 */
> -		if (WARN_ON_ONCE(info->flags))
> -			return false;
> -
> -		/* Core managed MSI descriptors */
> -		info->flags |= MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS |
> -			       MSI_FLAG_FREE_MSI_DESCS;
> -		break;
> -	case DOMAIN_BUS_WIRED_TO_MSI:
> -		break;
> -	default:
> -		WARN_ON_ONCE(1);
> -		return false;
> -	}
> -
> -	/* Use hierarchial chip operations re-trigger */
> -	info->chip->irq_retrigger = irq_chip_retrigger_hierarchy;
> -
> -	/*
> -	 * Mask out the domain specific MSI feature flags which are not
> -	 * supported by the real parent.
> -	 */
> -	info->flags &= pops->supported_flags;
> -
> -	/* Enforce the required flags */
> -	info->flags |= pops->required_flags;
> -
> -	return true;
> -}
> -
> -#define MATCH_PLATFORM_MSI		BIT(DOMAIN_BUS_PLATFORM_MSI)
> -
>  static const struct msi_parent_ops imsic_msi_parent_ops = {
>  	.supported_flags	= MSI_GENERIC_FLAGS_MASK |
>  				  MSI_FLAG_PCI_MSIX,
>  	.required_flags		= MSI_FLAG_USE_DEF_DOM_OPS |
> -				  MSI_FLAG_USE_DEF_CHIP_OPS,
> +				  MSI_FLAG_USE_DEF_CHIP_OPS |
> +				  MSI_FLAG_PCI_MSI_MASK_PARENT,
>  	.bus_select_token	= DOMAIN_BUS_NEXUS,
>  	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
> -	.init_dev_msi_info	= imsic_init_dev_msi_info,
> +	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
>  };
>  
>  int imsic_irqdomain_init(void)
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -558,11 +558,21 @@ enum {
>  	MSI_FLAG_NO_AFFINITY		= (1 << 21),
>  };
>  
> +/*
> + * Flags for msi_parent_ops::chip_flags
> + */
> +enum {
> +	MSI_CHIP_FLAG_SET_EOI		= (1 << 0),
> +	MSI_CHIP_FLAG_SET_ACK		= (1 << 1),
> +};
> +
>  /**
>   * struct msi_parent_ops - MSI parent domain callbacks and configuration info
>   *
>   * @supported_flags:	Required: The supported MSI flags of the parent domain
>   * @required_flags:	Optional: The required MSI flags of the parent MSI domain
> + * @chip_flags:		Optional: Select MSI chip callbacks to update with defaults
> + *			in msi_lib_init_dev_msi_info().
>   * @bus_select_token:	Optional: The bus token of the real parent domain for
>   *			irq_domain::select()
>   * @bus_select_mask:	Optional: A mask of supported BUS_DOMAINs for
> @@ -575,6 +585,7 @@ enum {
>  struct msi_parent_ops {
>  	u32		supported_flags;
>  	u32		required_flags;
> +	u32		chip_flags;
>  	u32		bus_select_token;
>  	u32		bus_select_mask;
>  	const char	*prefix;
