Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5593090C6
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161050; cv=none; b=YXE4Nb7VtZHDwWIjkRJ20elpzKFZQmTlUFsrcr6F22BDvoQcippRodcAbGdoONPCWPPrfmKoPy+ODk2Vmx6SOh1R9LyIdQrbjrfExRYOOyMCfS0G2v/FSvY9/ZEJujHYLJpU0SkSSje0j89Bb6qMssb8BIrTHCWkE/Zw0wKxJ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161050; c=relaxed/simple;
	bh=ZXe/VJmMYtQ7XY7k/o02xTeBk/MRtI5puf0lBTZNUsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIK24Xcep+iuUIcwXg0H5Y4itUyZqn1rjG7qhWOOPo1oINnMJz42+YFIEe9XSU5DlXjM3qjhUe89sMyx3Jf98ZL75TAKA1yA1M+bvfMWDNbPye9DNyJ43byNrCTRJqpr8zSdXpAsKmYHO6syX6ia9AOdpjaPdbW4DHrrPlNBuGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=GWhnJH1O; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GWhnJH1O"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-92aee734585so36335239f.3
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1759161047; x=1759765847; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=thl1botW/6JnUO3NJgzLyWhXcvMbSjUKSouz8HBMgL8=;
        b=GWhnJH1ORrW6+KE+GOdK+5Jl3YE5/totcy0B+V6TOlYHQdLZ8Tu4lQhZaiI6Il5rUj
         9wT4BP8uAu1zZZNq0SAh1aYIS1yhnCbClIQUGaD6NJ/Cd0GWy1gLZsjL9qlAqKv25peU
         LjXVbsqX164n2PGqtNy/tVStb+qDejMBDSgyBppmLZdaGK0N0nzfo6SZUeLKyjDmCMrR
         cRZxr5YgpreM+OwKTHvZW05wpXrarkNFMqUEc9SQmXS0D67I22695DzmVaFvjHKb+7EO
         Z1PTBmcrlFVfNHE9lSmDUGxehx8QJGQdZho1azBR2zR4Oa70SI/ffj5mb7D8il4oNs5G
         9rhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161047; x=1759765847;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thl1botW/6JnUO3NJgzLyWhXcvMbSjUKSouz8HBMgL8=;
        b=cMyJeem3kZj3e4cUV/0/UQlsJbAIZ4zUNdyqLdlUKYSnfT+WJ/nR7iUvLOBr6QgzQW
         YzjEDNbzruSGKNNxYYPoSbP+QoKeTZKbv0dp3l72uwMbq2vG3oDq1fszAHD42dUH8ouC
         E7amPD7F6JNeEbovcoyBP+guR7wmiK5Abu+gcgHM+AxrrrE5z39a/4ErTMQqhT2Ka51z
         7mqwmOx1+ueEOTMxQiD08QPhG91PgzuS0vR5oOlvfdg/PCBu/aLbepcqHAQb2NAMLTDc
         VCP4OU52pjkRRZGcS73O2Ic+/NA1wbo4Yft7wWiGsxGQUec8BXGziC9kwnKr25BxVSBl
         ZK4Q==
X-Gm-Message-State: AOJu0Yx9MpWjbNqsSMbPk7Qc7OF5BmgCQNyu0uVUyc2MMo6lX4QohF1z
	q3kZJQ6KbeHgDRXXQ+TZCNpDnTuy3nOhUAmd1TmqMn3BcPtxoC7qntM/GD8lQ6r9nDc=
X-Gm-Gg: ASbGncvNna6BSs0NsKrRaNeaKUEJUsV+cgqbgp2WUe+7TT5JM+VEe79iRD5mOdKaYg6
	rr3q8HdAPJq6C4Rnv1Q/ztgusxtTXnyqz9N1gHySoJ3mssyPu38ak0EpmHR69fuKfvea/Td+hVP
	C5htG8axR7DV9X53Xbfu5WIhfad0AkoPLQErlrHZPlMYEY+EJOPKslr+BRwDPJYdJoo4Do9fM9R
	C/u+zy7+4ITIGWhScit9zGk56D7XgrEW6CyUKTHd8uNRqbSmlKYKlfbNTBpuVvaJyDyOu1CZovu
	irxEfnkrABWq/zU8z76EnBkTydPGyBcTaQUE0PnhtA/PmVmluEhaj1VVREY7Xpovjtx1CzwIaBi
	ulRtqRHAl70SoPcpbX6pjhQe1
X-Google-Smtp-Source: AGHT+IH7gk327UmY6C6eScZpxHXRC9XJhlTFKO90VrWRwUWHG19VAOUZaRB2R9AE7aS+Xnm+h8Ln6w==
X-Received: by 2002:a05:6602:341e:b0:928:c6cc:3b1a with SMTP id ca18e2360f4ac-928c6cc3cbfmr562321039f.18.1759161047242;
        Mon, 29 Sep 2025 08:50:47 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6a5ae2c1sm4845167173.63.2025.09.29.08.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 08:50:46 -0700 (PDT)
Date: Mon, 29 Sep 2025 10:50:45 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: "Nutty.Liu" <nutty.liu@hotmail.com>
Cc: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	jgg@nvidia.com, zong.li@sifive.com, tjeznach@rivosinc.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, anup@brainfault.org, atish.patra@linux.dev, 
	tglx@linutronix.de, alex.williamson@redhat.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, alex@ghiti.fr
Subject: Re: [RFC PATCH v2 04/18] iommu/riscv: Add IRQ domain for interrupt
 remapping
Message-ID: <20250929-816b2ab17977ffa1b9687fe2@orel>
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
 <20250920203851.2205115-24-ajones@ventanamicro.com>
 <TY1PPFCDFFFA68A1C49C083357FF49575AEF318A@TY1PPFCDFFFA68A.apcprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY1PPFCDFFFA68A1C49C083357FF49575AEF318A@TY1PPFCDFFFA68A.apcprd02.prod.outlook.com>

On Sun, Sep 28, 2025 at 05:30:26PM +0800, Nutty.Liu wrote:
> 
> On 9/21/2025 4:38 AM, Andrew Jones wrote:
> > This is just a skeleton. Until irq-set-affinity functions are
> > implemented the IRQ domain doesn't serve any purpose.
> > 
> > Signed-off-by: Andrew Jones<ajones@ventanamicro.com>
> > ---
> >   drivers/iommu/riscv/Makefile   |   2 +-
> >   drivers/iommu/riscv/iommu-ir.c | 114 +++++++++++++++++++++++++++++++++
> >   drivers/iommu/riscv/iommu.c    |  36 +++++++++++
> >   drivers/iommu/riscv/iommu.h    |  12 ++++
> >   4 files changed, 163 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/iommu/riscv/iommu-ir.c
> > 
> > diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
> > index b5929f9f23e6..9c83f877d50f 100644
> > --- a/drivers/iommu/riscv/Makefile
> > +++ b/drivers/iommu/riscv/Makefile
> > @@ -1,3 +1,3 @@
> >   # SPDX-License-Identifier: GPL-2.0-only
> > -obj-y += iommu.o iommu-platform.o
> > +obj-y += iommu.o iommu-ir.o iommu-platform.o
> >   obj-$(CONFIG_RISCV_IOMMU_PCI) += iommu-pci.o
> > diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
> > new file mode 100644
> > index 000000000000..08cf159b587d
> > --- /dev/null
> > +++ b/drivers/iommu/riscv/iommu-ir.c
> > @@ -0,0 +1,114 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * IOMMU Interrupt Remapping
> > + *
> > + * Copyright © 2025 Ventana Micro Systems Inc.
> > + */
> > +#include <linux/irqdomain.h>
> > +#include <linux/msi.h>
> > +
> > +#include "iommu.h"
> > +
> > +static struct irq_chip riscv_iommu_ir_irq_chip = {
> > +	.name			= "IOMMU-IR",
> > +	.irq_ack		= irq_chip_ack_parent,
> > +	.irq_mask		= irq_chip_mask_parent,
> > +	.irq_unmask		= irq_chip_unmask_parent,
> > +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> > +};
> > +
> > +static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
> > +						unsigned int irq_base, unsigned int nr_irqs,
> > +						void *arg)
> > +{
> > +	struct irq_data *data;
> > +	int i, ret;
> > +
> > +	ret = irq_domain_alloc_irqs_parent(irqdomain, irq_base, nr_irqs, arg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for (i = 0; i < nr_irqs; i++) {
> > +		data = irq_domain_get_irq_data(irqdomain, irq_base + i);
> Nitpick:  Would it be better to check if 'data' is NULL ?

A null irq-data here would imply a bug in the irq domain hierarchy
implementation and warrant a BUG_ON for the response. But, a null
dereference should give us the same backtrace, so I think we're OK
to leave things as they are.

> 
> > +		data->chip = &riscv_iommu_ir_irq_chip;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct irq_domain_ops riscv_iommu_ir_irq_domain_ops = {
> > +	.alloc = riscv_iommu_ir_irq_domain_alloc_irqs,
> > +	.free = irq_domain_free_irqs_parent,
> > +};
> > +
> > +static const struct msi_parent_ops riscv_iommu_ir_msi_parent_ops = {
> > +	.prefix			= "IR-",
> > +	.supported_flags	= MSI_GENERIC_FLAGS_MASK |
> > +				  MSI_FLAG_PCI_MSIX,
> > +	.required_flags		= MSI_FLAG_USE_DEF_DOM_OPS |
> > +				  MSI_FLAG_USE_DEF_CHIP_OPS |
> > +				  MSI_FLAG_PCI_MSI_MASK_PARENT,
> > +	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
> > +	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
> > +};
> > +
> > +struct irq_domain *riscv_iommu_ir_irq_domain_create(struct riscv_iommu_device *iommu,
> > +						    struct device *dev,
> > +						    struct riscv_iommu_info *info)
> > +{
> > +	struct irq_domain *irqparent = dev_get_msi_domain(dev);
> > +	struct irq_domain *irqdomain;
> > +	struct fwnode_handle *fn;
> > +	char *fwname;
> > +
> > +	fwname = kasprintf(GFP_KERNEL, "IOMMU-IR-%s", dev_name(dev));
> > +	if (!fwname)
> > +		return NULL;
> > +
> > +	fn = irq_domain_alloc_named_fwnode(fwname);
> > +	kfree(fwname);
> > +	if (!fn) {
> > +		dev_err(iommu->dev, "Couldn't allocate fwnode\n");
> > +		return NULL;
> > +	}
> > +
> > +	irqdomain = irq_domain_create_hierarchy(irqparent, 0, 0, fn,
> > +						&riscv_iommu_ir_irq_domain_ops,
> > +						info);
> > +	if (!irqdomain) {
> > +		dev_err(iommu->dev, "Failed to create IOMMU irq domain\n");
> > +		irq_domain_free_fwnode(fn);
> > +		return NULL;
> > +	}
> > +
> > +	irqdomain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
> > +	irqdomain->msi_parent_ops = &riscv_iommu_ir_msi_parent_ops;
> > +	irq_domain_update_bus_token(irqdomain, DOMAIN_BUS_MSI_REMAP);
> > +
> > +	dev_set_msi_domain(dev, irqdomain);
> > +
> > +	return irqdomain;
> > +}
> > +
> > +void riscv_iommu_ir_irq_domain_remove(struct riscv_iommu_info *info)
> > +{
> > +	struct fwnode_handle *fn;
> > +
> > +	if (!info->irqdomain)
> > +		return;
> > +
> > +	fn = info->irqdomain->fwnode;
> > +	irq_domain_remove(info->irqdomain);
> > +	info->irqdomain = NULL;
> > +	irq_domain_free_fwnode(fn);
> > +}
> > +
> > +int riscv_iommu_ir_attach_paging_domain(struct riscv_iommu_domain *domain,
> > +					struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +
> > +void riscv_iommu_ir_free_paging_domain(struct riscv_iommu_domain *domain)
> > +{
> > +}
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index a44c67a848fa..db2acd9dc64b 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -17,6 +17,8 @@
> >   #include <linux/init.h>
> >   #include <linux/iommu.h>
> >   #include <linux/iopoll.h>
> > +#include <linux/irqchip/riscv-imsic.h>
> > +#include <linux/irqdomain.h>
> >   #include <linux/kernel.h>
> >   #include <linux/pci.h>
> > @@ -1026,6 +1028,9 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
> >   		WRITE_ONCE(dc->fsc, new_dc->fsc);
> >   		WRITE_ONCE(dc->ta, new_dc->ta & RISCV_IOMMU_PC_TA_PSCID);
> > +		WRITE_ONCE(dc->msiptp, new_dc->msiptp);
> > +		WRITE_ONCE(dc->msi_addr_mask, new_dc->msi_addr_mask);
> > +		WRITE_ONCE(dc->msi_addr_pattern, new_dc->msi_addr_pattern);
> Since the MSI page table pointer (msiptp) has been changed,
> should all cache entries from this MSI page table need to be invalidated ?

That's a good question and I need to bang my head against the spec some
more for it. The invalidation guidance for a device context states that
an iotinval.gvma is only needed when dc.iohgatp.mode is not bare (and
currently it's always bare). However, the msi table needs an iotinval.gvma
(whether or not dc.iohgatp.mode is bare). So, as you suggest, I think we
need it and the spec could probably use some clarification.

> 
> Otherwise,
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
drew
