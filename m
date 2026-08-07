Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F38742FCDD;
	Fri,  7 Aug 2026 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786134739; cv=none; b=FMntBXt3CXJbMif6hbLoysfqhLEqjOdl6CtxBxpLRes5JrRg4j1r2ozVdqVcemYcBeixRJ88i6qydYjPDv3MJfdUa26kh58Z5LUu/6fiutnT9nb0ufWynBWV4M0ZUC4NcIYEt7VvQRcCxlST67knI93yBJmpXdhIc4U3waPHvt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786134739; c=relaxed/simple;
	bh=7b/c0J1XJQzot3tUGhyRSxcFCeynvvBx7G4A82OSrbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qrMqybxdGGn1omsmpo+XWXYnurKqIKoQwtHTIY+KjhTayrLkNnH9XsRCtJXOjnBKI9WPA9zJ8nYvQ1vIlT1tOw/f48Dz86pbgQke01OCDm1Az5OK19pYf+M5S6crlppexpAvIoxTGaqngO2C+28iwwl2s4DPQ5oAQHrclfU7Mv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxk/6jV4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxk/6jV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37021F000E9;
	Fri,  7 Aug 2026 20:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786134738;
	bh=3uOAPVT4qIKiHepPHx+S+k3QDO+sKm4WKIfRNtKoaZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=jxk/6jV4NqTB0UBMFmlgnHtdnp48iifIbhgKlkCsH4hiAZ5JWjm0Bp9fNGxy/2Hft
	 c5hOavgmztTex8PDi9yBGxiXgqOiqGu5rHhmRuZnWRVHoREWMxnI0m110sh9nHE6si
	 WkKoFc4VNicCiX1I+gmcJD1hSOprtb/8EsCj3cpFxEUsTcKeyaaajVX6/NsgBqg/2a
	 HYYL7C6gY9esKgxSGwjZMdkgu5McYsdsgIyoqNPLWoO1dlI5t7hNZLAUNGWSIPkbwa
	 2KBBxi1fP1fyzNTBQg6jf8q1hitOkNdrZCjqEULpPIj9dDq6WMGt8S1aARAMR3vk7g
	 HH+9l7FX1M+Nw==
From: Thomas Gleixner <tglx@kernel.org>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>,
 linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
 tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 anup@brainfault.org, kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v3 07/19] iommu/riscv: Add IRQ domain for interrupt
 remapping
In-Reply-To: <20260807181713.228535-8-andrew.jones@oss.qualcomm.com>
References: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
 <20260807181713.228535-8-andrew.jones@oss.qualcomm.com>
Date: Fri, 07 Aug 2026 22:32:15 +0200
Message-ID: <875x1lekog.ffs@fw13>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 07 2026 at 20:17, Andrew Jones wrote:
> +static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
> +						unsigned int irq_base, unsigned int nr_irqs,
> +						void *arg)
> +{
> +	struct irq_data *data;
> +	int i, ret;
> +
> +	ret = irq_domain_alloc_irqs_parent(irqdomain, irq_base, nr_irqs, arg);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < nr_irqs; i++) {

for (unsigned int i = 0; .....

nr_irqs is unsigned after all

The struct irq_data declaration want's to be inside the loop as that's
the scope where it is used.

> +		data = irq_domain_get_irq_data(irqdomain, irq_base + i);


> +		data->chip = &riscv_iommu_ir_irq_chip;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops riscv_iommu_ir_irq_domain_ops = {
> +	.alloc = riscv_iommu_ir_irq_domain_alloc_irqs,
> +	.free = irq_domain_free_irqs_parent,

https://docs.kernel.org/process/maintainer-tip.html#struct-declarations-and-initializers

> +};
> +
> +static const struct msi_parent_ops riscv_iommu_ir_msi_parent_ops = {
> +	.prefix			= "IR-",
> +	.supported_flags	= MSI_GENERIC_FLAGS_MASK |
> +				  MSI_FLAG_PCI_MSIX,
> +	.required_flags		= MSI_FLAG_USE_DEF_DOM_OPS |
> +				  MSI_FLAG_USE_DEF_CHIP_OPS |
> +				  MSI_FLAG_PCI_MSI_MASK_PARENT,
> +	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
> +	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
> +};
> +
> +struct irq_domain *riscv_iommu_ir_irq_domain_create(struct device *dev,
> +						    struct riscv_iommu_info *info)

You have 100 characters, please use them.

> +{
> +	struct irq_domain *irqparent = dev_get_msi_domain(dev);
> +	struct irq_domain *irqdomain;
> +	struct fwnode_handle *fn;
> +	char *fwname __free(kfree) = NULL;

https://docs.kernel.org/process/maintainer-tip.html#variable-declarations

> +	if (!irqparent)
> +		return NULL;
> +
> +	fwname = kasprintf(GFP_KERNEL, "IOMMU-IR-%s", dev_name(dev));
> +	if (!fwname)
> +		return ERR_PTR(-ENOMEM);
> +
> +	fn = irq_domain_alloc_named_fwnode(fwname);
> +	if (!fn)
> +		return ERR_PTR(-ENOMEM);
> +
> +	irqdomain = irq_domain_create_hierarchy(irqparent, 0, 0, fn,
> +						&riscv_iommu_ir_irq_domain_ops,
> +						info);

100 chars.

> +	if (!irqdomain) {
> +		irq_domain_free_fwnode(fn);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	/*
> +	 * The RISC-V IOMMU doesn't validate MSI data, so we can't set
> +	 * IRQ_DOMAIN_FLAG_ISOLATED_MSI. This means VFIO requires
> +	 * allow_unsafe_interrupts.

what is allow_unsafe_interrupts? A variable, a function a parameter or
what?

Please write comments which do not require to grep the tree.

Thanks,

        tglx
