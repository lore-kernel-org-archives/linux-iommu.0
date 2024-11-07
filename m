Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8F18BEC
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997704; cv=none; b=KaR2VmtpMb3gTHPxSg5hmdv8cmfu5m02jtB75aAnNGTCAX+pb+vKf1ysuyvKra45TFZwOwh0j7km0I4EAllsfHmBqHztWmMR409e/tTyNTtHkHNnegyrIXOeEwOIOlmGUGlhJlql79ST2g/zqIvmo0fKY+Yp/6p8OZ9RBjkt4fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997704; c=relaxed/simple;
	bh=44Fb6+UKl09hKKqbvpTOMeKUXcDtZgboEtHo3NLmzGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uwt6KIshdoaztQD9VZLGLy6hH+I5CosGpvtO2VpI31EIhzq5T5IN9MCQiHgqzXEB6GvNuBz/YsqQATRwDo9KeESvsA4lp8ntI6o7QdBixvWcCk1oJSSZomxKA8u/qYkpchU2smRSlCywFjq2RxUp5MlMem8cxxj97w3ha+5OSoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=aQKRTKVM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="aQKRTKVM"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so165624466b.0
        for <iommu@lists.linux.dev>; Thu, 07 Nov 2024 08:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1730997701; x=1731602501; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9XrMMh3/6jKfxgBvb9B39K7/szH3g2Df3ueLyIXWGk=;
        b=aQKRTKVMqQmnDDcCg5R3fT1XqU9RQ5PtkjXElusATIrWjf9s5m/BrJxbNjHN6pezh7
         wKrsR7FUZBsYYOQpmpAn04hCcZ3zyq4unxLpe0hX1ihP2V/pTYqBQ6vURy9x1QbObzYv
         vACD2a5ccPE/da7SiA1KYQoS9A86yugPN7DUP45FT8APMpa+zlUWqlfk1Zz1xYKZ5wgm
         GnXtveSQ5EpwnApGqwXXbUCYP0pcuy8S6qmBp0NvUL3jhCoRGrncVN2vyqUkYrogE0df
         9RmNj28H+kGfWM/GMCKfpytKyNi7vlOse+49g49vvvPyw1741bPlVKZxs06CbK2sgvms
         MIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730997701; x=1731602501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9XrMMh3/6jKfxgBvb9B39K7/szH3g2Df3ueLyIXWGk=;
        b=AKAgUP+0AnL5anusNaqbdCfla+asiWJgeqrM6S/MraZ7WBbVH4K816NN7kNKiF8TU/
         JvhE8zFHhfK9WVoLEzzvQ/5cKaX0lQtnlTv0Ui358MI8goIPJYsmc4e54HrIUzFDYIOI
         hakttqXDY2UQ/L1zqLMqmenv1+z52EMSEg6GdumpfR2G/7syjh0P3vsYDIIS9il1UsBQ
         rWD+hrpdFEB8PKyUuZVsDCqQmg1OjwuFTNvWoA09Pg42igYtjU5z8MMu+97OwgGZMC7E
         nDs1Am2jz7Qv1vfiDp3EKGEbigqYvHC6G+VY1Im2+VGBrouWIQE5FL2bzwyxfrXm4AMY
         P2fA==
X-Gm-Message-State: AOJu0YzJPg5vfd850L+mz01rc3TSQug4jybbxLIRrrYfiZhCTxxzvhcy
	A83CxuPTbQQbv27UNqGD5Qhrg6/Tx3cfa17ij7KNvo9XN8wzoMTKGUoBrqWXMlI=
X-Google-Smtp-Source: AGHT+IGoYjUPTOzrAY5e5EufOknt6N62gHZK+veE80C7chcu3um68ZWUrZfZEthLlSgMmBUVcmxInQ==
X-Received: by 2002:a17:907:9604:b0:a9a:7f84:940b with SMTP id a640c23a62f3a-a9eeae9b3eemr80229166b.10.1730997700859;
        Thu, 07 Nov 2024 08:41:40 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a17635sm113837466b.17.2024.11.07.08.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 08:41:40 -0800 (PST)
Date: Thu, 7 Nov 2024 17:41:39 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu
Subject: Re: [PATCH 2/2] iommu/riscv: Add support for platform msi
Message-ID: <20241107-dcdcb332d980a7120e9518ac@orel>
References: <20241106175102.219923-4-ajones@ventanamicro.com>
 <20241106175102.219923-6-ajones@ventanamicro.com>
 <d92ab280-bd1f-4145-8164-cebab1980f20@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d92ab280-bd1f-4145-8164-cebab1980f20@sifive.com>

On Wed, Nov 06, 2024 at 01:45:23PM -0600, Samuel Holland wrote:
> Hi Drew,
> 
> On 2024-11-06 11:51 AM, Andrew Jones wrote:
> > Apply platform_device_msi_init_and_alloc_irqs() to add support for
> > MSIs when the IOMMU is a platform device.
> > 
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  drivers/iommu/riscv/iommu-platform.c | 102 ++++++++++++++++++++++-----
> >  1 file changed, 84 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
> > index da336863f152..89aa622bcbde 100644
> > --- a/drivers/iommu/riscv/iommu-platform.c
> > +++ b/drivers/iommu/riscv/iommu-platform.c
> > @@ -11,18 +11,41 @@
> >   */
> >  
> >  #include <linux/kernel.h>
> > +#include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/msi.h>
> 
> If you respin, please keep these sorted.

Sure

> 
> >  
> >  #include "iommu-bits.h"
> >  #include "iommu.h"
> >  
> > +static void riscv_iommu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> > +{
> > +	struct device *dev = msi_desc_to_dev(desc);
> > +	struct riscv_iommu_device *iommu = dev_get_drvdata(dev);
> > +	u16 idx = desc->msi_index;
> > +	u64 addr;
> > +
> > +	addr = ((u64)msg->address_hi << 32) | msg->address_lo;
> > +
> > +	if (addr != (addr & RISCV_IOMMU_MSI_CFG_TBL_ADDR))
> > +		pr_warn_once("uh oh, the IOMMU can't send MSIs to 0x%llx, sending to 0x%llx instead\n",
> > +			     addr, addr & RISCV_IOMMU_MSI_CFG_TBL_ADDR);
> 
> Can this use dev_warn_once()? And should it really be only a warning?
> Configuring the IOMMU to write to some other address seems dangerous. I guess
> there's no clean way to handle this error, since this function cannot fail, and
> irq_chip_compose_msi_msg() isn't supposed to fail either.

I'll change it to a dev_err_once().

> 
> > +
> > +	addr &= RISCV_IOMMU_MSI_CFG_TBL_ADDR;
> > +
> > +	riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_MSI_CFG_TBL_ADDR(idx), addr);
> > +	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_MSI_CFG_TBL_DATA(idx), msg->data);
> > +	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_MSI_CFG_TBL_CTRL(idx), 0);
> > +}
> > +
> >  static int riscv_iommu_platform_probe(struct platform_device *pdev)
> >  {
> > +	enum riscv_iommu_igs_settings igs;
> >  	struct device *dev = &pdev->dev;
> >  	struct riscv_iommu_device *iommu = NULL;
> >  	struct resource *res = NULL;
> > -	int vec;
> > +	int vec, ret;
> >  
> >  	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
> >  	if (!iommu)
> > @@ -40,16 +63,6 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
> >  	iommu->caps = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAPABILITIES);
> >  	iommu->fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
> >  
> > -	/* For now we only support WSI */
> > -	switch (FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps)) {
> > -	case RISCV_IOMMU_CAPABILITIES_IGS_WSI:
> > -	case RISCV_IOMMU_CAPABILITIES_IGS_BOTH:
> > -		break;
> > -	default:
> > -		return dev_err_probe(dev, -ENODEV,
> > -				     "unable to use wire-signaled interrupts\n");
> > -	}
> > -
> >  	iommu->irqs_count = platform_irq_count(pdev);
> >  	if (iommu->irqs_count <= 0)
> >  		return dev_err_probe(dev, -ENODEV,
> > @@ -57,13 +70,60 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
> >  	if (iommu->irqs_count > RISCV_IOMMU_INTR_COUNT)
> >  		iommu->irqs_count = RISCV_IOMMU_INTR_COUNT;
> >  
> > -	for (vec = 0; vec < iommu->irqs_count; vec++)
> > -		iommu->irqs[vec] = platform_get_irq(pdev, vec);
> > +	igs = FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps);
> > +	switch (igs) {
> > +	case RISCV_IOMMU_CAPABILITIES_IGS_BOTH:
> > +	case RISCV_IOMMU_CAPABILITIES_IGS_MSI:
> > +		if (is_of_node(dev->fwnode))
> > +			of_msi_configure(dev, to_of_node(dev->fwnode));
> > +
> > +		if (!dev_get_msi_domain(dev)) {
> > +			dev_warn(dev, "failed to find an MSI domain");
> > +			goto msi_fail;
> > +		}
> > +
> > +		ret = platform_device_msi_init_and_alloc_irqs(dev, iommu->irqs_count,
> > +							      riscv_iommu_write_msi_msg);
> > +		if (ret) {
> > +			dev_warn(dev, "failed to allocate MSIs");
> > +			goto msi_fail;
> > +		}
> > +
> > +		for (vec = 0; vec < iommu->irqs_count; vec++)
> > +			iommu->irqs[vec] = msi_get_virq(dev, vec);
> > +
> > +		/* Enable message-signaled interrupts, fctl.WSI */
> > +		if (iommu->fctl & RISCV_IOMMU_FCTL_WSI) {
> > +			iommu->fctl ^= RISCV_IOMMU_FCTL_WSI;
> > +			riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fctl);
> > +		}
> > +
> > +		dev_info(dev, "using MSIs\n");
> > +		break;
> > +
> > +msi_fail:
> > +		if (igs != RISCV_IOMMU_CAPABILITIES_IGS_BOTH) {
> > +			dev_warn(dev, "\n");
> > +			return dev_err_probe(dev, -ENODEV,
> > +					     "unable to use wire-signaled interrupts\n");
> 
> Is the dev_warn() just to call attention to the following error? There's no
> guarantee that these two messages will be printed adjacently.

I'll drop the dev_warn since it was supposed to tie in with the dev_warn
above which was missing its endline on purpose, but your statement about
avoiding split logs means I should probably just do a complete log above
and complete logs here and...

> 
> > +		}
> > +
> > +		dev_warn(dev, " - falling back to wired irqs\n");
> 
> No need for the extra hyphen here.

...here, which also means the hyphen should be dropped.
> 
> Regards,
> Samuel

Thanks,
drew

> 
> > +		fallthrough;
> >  
> > -	/* Enable wire-signaled interrupts, fctl.WSI */
> > -	if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {
> > -		iommu->fctl |= RISCV_IOMMU_FCTL_WSI;
> > -		riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fctl);
> > +	case RISCV_IOMMU_CAPABILITIES_IGS_WSI:
> > +		for (vec = 0; vec < iommu->irqs_count; vec++)
> > +			iommu->irqs[vec] = platform_get_irq(pdev, vec);
> > +
> > +		/* Enable wire-signaled interrupts, fctl.WSI */
> > +		if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {
> > +			iommu->fctl |= RISCV_IOMMU_FCTL_WSI;
> > +			riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fctl);
> > +		}
> > +		dev_info(dev, "using wire-signaled interrupts\n");
> > +		break;
> > +	default:
> > +		return dev_err_probe(dev, -ENODEV, "invalid IGS\n");
> >  	}
> >  
> >  	return riscv_iommu_init(iommu);
> > @@ -71,7 +131,13 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
> >  
> >  static void riscv_iommu_platform_remove(struct platform_device *pdev)
> >  {
> > -	riscv_iommu_remove(dev_get_drvdata(&pdev->dev));
> > +	struct riscv_iommu_device *iommu = dev_get_drvdata(&pdev->dev);
> > +	bool msi = !(iommu->fctl & RISCV_IOMMU_FCTL_WSI);
> > +
> > +	riscv_iommu_remove(iommu);
> > +
> > +	if (msi)
> > +		platform_device_msi_free_irqs_all(&pdev->dev);
> >  };
> >  
> >  static const struct of_device_id riscv_iommu_of_match[] = {
> 
