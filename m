Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1794A395AD4;
	Fri,  7 Aug 2026 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786135008; cv=none; b=GtdNxeH1438UmiNbzhi/BQkR+95c7/zm8adIdTnKayVKXF+0zkM8yaXdVrEsy9LP2Nf0GzxXd214r1isPERbsS3mximD6hokh96//XZvzQ652/6Pt7B0CTJGzAcsX2IFs6vjQt+RRA82y+GzguqnoIC6ncfbFGpBRuDiEpP81hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786135008; c=relaxed/simple;
	bh=oX0H/0PLbmXqsxsh4H/SHuST8ci26nAISVyBEmfd4u4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W4v7UXqbK2/72rMKJwNqlQnxl0gdmvhpLMWoWEZXytZaQsfSMeMC6ESj/NboQM1JnbzMznvh+F7PROJ6fmHNOmALzTPI/bWo1rMi46ZsdXEX9mrVM2XPT+6SoedKOrwBRpPmWnA2VgyvoLtUjebgSDgd3F2TEzCN0BBLnT2ja7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtGpy3vI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtGpy3vI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4C81F000E9;
	Fri,  7 Aug 2026 20:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786135006;
	bh=PC1DtOrjp0Hv15KMic8iAdGSREhJUEAqTIXRwqdUKtw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XtGpy3vIhNdQZ5bOKQHhJcUVty13P0F7Jl+A1pZhj52LZHkPXqFCxQkin+taKWA+V
	 kiODKh9GYM2RDnuos9aBb4LIPbxZJVciPPv14s0NDzR6vx52PcInkl7m3jasbQNtHj
	 wuULQjI1lMo38o+XIWRHZI7P7Hwo+Osc+GLammkj71FE9xGoQT9eKCoSdWd8bu/xra
	 Uga4aGivVrOZhGyiNg1O81p2jxYamQbPrJU/axJPrzsNZ6gy3EGxt7l40qexQGVwDU
	 dUh6LY8qbWrUFMB++ynMfMKGKibEgJaykoCwnXRsPexbj96sHbOb6Lj36U3t3kmvXM
	 /EZ9DzJ6FgvTQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>,
 linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
 tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 anup@brainfault.org, kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v3 07/19] iommu/riscv: Add IRQ domain for interrupt
 remapping
In-Reply-To: <875x1lekog.ffs@fw13>
References: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
 <20260807181713.228535-8-andrew.jones@oss.qualcomm.com>
 <875x1lekog.ffs@fw13>
Date: Fri, 07 Aug 2026 22:36:43 +0200
Message-ID: <8733wpekh0.ffs@fw13>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 07 2026 at 22:32, Thomas Gleixner wrote:
> On Fri, Aug 07 2026 at 20:17, Andrew Jones wrote:
>> +static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
>> +						unsigned int irq_base, unsigned int nr_irqs,
>> +						void *arg)
>> +{
>> +	struct irq_data *data;
>> +	int i, ret;
>> +
>> +	ret = irq_domain_alloc_irqs_parent(irqdomain, irq_base, nr_irqs, arg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	for (i = 0; i < nr_irqs; i++) {
>
> for (unsigned int i = 0; .....
>
> nr_irqs is unsigned after all
>
> The struct irq_data declaration want's to be inside the loop as that's
> the scope where it is used.
>
>> +		data = irq_domain_get_irq_data(irqdomain, irq_base + i);
>
>
>> +		data->chip = &riscv_iommu_ir_irq_chip;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct irq_domain_ops riscv_iommu_ir_irq_domain_ops = {
>> +	.alloc = riscv_iommu_ir_irq_domain_alloc_irqs,
>> +	.free = irq_domain_free_irqs_parent,
>
> https://docs.kernel.org/process/maintainer-tip.html#struct-declarations-and-initializers
>
>> +};
>> +
>> +static const struct msi_parent_ops riscv_iommu_ir_msi_parent_ops = {
>> +	.prefix			= "IR-",
>> +	.supported_flags	= MSI_GENERIC_FLAGS_MASK |
>> +				  MSI_FLAG_PCI_MSIX,
>> +	.required_flags		= MSI_FLAG_USE_DEF_DOM_OPS |
>> +				  MSI_FLAG_USE_DEF_CHIP_OPS |
>> +				  MSI_FLAG_PCI_MSI_MASK_PARENT,
>> +	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
>> +	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
>> +};
>> +
>> +struct irq_domain *riscv_iommu_ir_irq_domain_create(struct device *dev,
>> +						    struct riscv_iommu_info *info)
>
> You have 100 characters, please use them.

Oops. Just noticed, that this is IOMMU territory. So whatever the IOMMU
maintainers prefer :)
