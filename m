Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486A070805
	for <iommu@lists.linux.dev>; Tue,  1 Jul 2025 03:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751341666; cv=none; b=Q02kRQBgFH3Ifu7tf20EdHrNzfDHwz/SAnHY4aFYyFeJ9nn6cgqK3ApTXJZNq/o+2q2ktGj6+EXwL+b+9ibVJe3YUGUf2QbpZTulRxJpW6qOW30Cqwi7h8TgltmPRGnkHzWtn4sY/OgoNoZsiRHFqMdm+PrZyezR7BfVLbrvFoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751341666; c=relaxed/simple;
	bh=pxIbsYpOLc6LPCX7Y2ZibVmY1Hku+f+8eNIhpZl5XhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BP/CdtrLwc1cKO/644vxsIm3sDDUYUSHyzI7S/kzLZEFpSXj82wVjM63SrGFMn9EVRWsvZZRuqt5A+PKitvsQfgoZ1oszKC5MAY8U65cA+oVFUPkSurxtkdwbsP3PYg9C2uJjZgTfnxHzIL7jUhWJu3+j4pGobFaKJf5c8bUHnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=AlLkQpED; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="AlLkQpED"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234d366e5f2so34332615ad.1
        for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 20:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751341664; x=1751946464; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q70BTMXv+elr6mx+h6qORt+5RlAkLGyM2dZSnSb4WnM=;
        b=AlLkQpEDZoxk7T64FzgZP8uxCep0h8yu4hvcmOWeMxTEBDbdLx/TtsOSrBVZofj8OX
         S7ySr66PEJxLZH9273QPRkXCPx/sS6zsGRMCAinW6BvedJCHgpaW2l9cdREc0Fxw8xVA
         cu5bJfmt711W4rg8rTBcDbxk/Z9uCzikJ/1gbQZ0j/A6L2fJL8TPsWXJXJMDWj2HPJM+
         s0oWmQMEG133p8n7PkyRozImj/rxgemn3NVq34uLZUem947ShQbHXh8yqklU86uG6P+C
         6aFFi6HdShvZBYNrXzQt3OtdXaYoydmWNOO3xxhpW8VA/2EPXgrWqyOn3807HMGy+rbb
         G7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751341664; x=1751946464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q70BTMXv+elr6mx+h6qORt+5RlAkLGyM2dZSnSb4WnM=;
        b=b8VwV6UZykfrKKtPpY0ZQXeK4KypiaP8j19phTX1cd277VJ1XWOiCR6TLin6ZPsJfY
         90CFMOmtKK0iBSoEujrsR64/00ysd23c0tYIjJenI+obqKOIxk1hwLlWS7ETU20UPewa
         7sDKyg/ILyzNJthrLLc7ApSLJ8MNSWzsRPJpa3T2diJ/IudJMrp6J+c7bnuYIom+MBpW
         iGDCNThdqD8pVzsty4CAOVRTeXfLjtq9SEzmSScj3vaNP03y6POH1QzzBFMT+FRdFmGD
         BiXtf/BuiLZaoXZ98Q9pLUmffPoos14lBVP0HGNILGIzvskbwrcaV0cDmBuaJ+r6nz3A
         FVXg==
X-Forwarded-Encrypted: i=1; AJvYcCUr6UPqluC9pbAwkjvYJEKTCdKiUUw+R59HLICvqYzw/8207zhltFurffb1zsJ0CMORIpCWgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBjwJbxhVuLzDaKS4jgDGJ6g2kWMRms0iL6VXqPtOPICI4VYkd
	TSYTHL6gmYiqoB5yc7XtpGUJsTDHIG0aOhbWbO7K9GTu73chfbTtATw4200ogrZjuqA=
X-Gm-Gg: ASbGncthoFzYzS3DFyoa996aJiHLx1rYxfJKO3wSxO8kpop2MKDPkxkZaF3eO5ueqmc
	UCPm9m8l/qoPlMle+lYW9cjI3zGAA4UpTdtg93kmQWlmyTReRe4VzhAGMwQonGJp72vsSb5zPby
	p0JAzBUn88ST8aaLe2Tm56NMn8Ud9ATvnP4OEPgxkYV3qEG2rlmzeW7zWJoLeTWk+5rZEHVSpc/
	GwMl9lJ1vu6Q1abuyWZjI6oaYTaLq06PSN/oPLxens6fkMu8vLrTvnZ1FdZ5+1GxYpb9VDA7N66
	j72gFy0Y+1GaROKcWUz1Wh7A79gAXK+LhiWGo4faPodojJ9V5FLsA39yu77QC7UGqjx/wA==
X-Google-Smtp-Source: AGHT+IGN1GMdTqZAPJCguumolenY1Wtb8nB6QKle+VjMdicMJz56dOOYCipT836/9qVM3LRjuPHcgA==
X-Received: by 2002:a17:903:fa3:b0:235:779:ede3 with SMTP id d9443c01a7336-23ac4680a0fmr213846545ad.41.1751341664573;
        Mon, 30 Jun 2025 20:47:44 -0700 (PDT)
Received: from sunil-laptop ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f1c40sm95714045ad.67.2025.06.30.20.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 20:47:44 -0700 (PDT)
Date: Tue, 1 Jul 2025 09:17:33 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v3 1/3] ACPI: RISC-V: Add support for RIMT
Message-ID: <aGNaVQEsZX7vmrFv@sunil-laptop>
References: <20250630034803.1611262-1-sunilvl@ventanamicro.com>
 <20250630034803.1611262-2-sunilvl@ventanamicro.com>
 <20250630-4a94187c794980bb830c539a@orel>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630-4a94187c794980bb830c539a@orel>

Hi Drew,

Thank you very much for the review!.

On Mon, Jun 30, 2025 at 09:55:09AM +0200, Andrew Jones wrote:
> Hi Sunil,
> 
> I found a few nits while skimming this.
> 
> On Mon, Jun 30, 2025 at 09:18:01AM +0530, Sunil V L wrote:
> > RISC-V IO Mapping Table (RIMT) is a static ACPI table to communicate
> > IOMMU information to the OS. The spec is available at [1].
> > 
> > The changes at high level are,
> > 	a) Initialize data structures required for IOMMU/device
> > 	   configuration using the data from RIMT. Provide APIs required
> > 	   for device configuration.
> > 	b) Provide an API for IOMMU drivers to register the
> > 	   fwnode with RIMT data structures. This API will create a
> > 	   fwnode for PCIe IOMMU.
> > 
> > [1] - https://github.com/riscv-non-isa/riscv-acpi-rimt
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  MAINTAINERS                 |   1 +
> >  arch/riscv/Kconfig          |   1 +
> >  drivers/acpi/Kconfig        |   4 +
> >  drivers/acpi/riscv/Kconfig  |   7 +
> >  drivers/acpi/riscv/Makefile |   1 +
> >  drivers/acpi/riscv/init.c   |   2 +
> >  drivers/acpi/riscv/init.h   |   1 +
> >  drivers/acpi/riscv/rimt.c   | 523 ++++++++++++++++++++++++++++++++++++
> >  include/linux/acpi_rimt.h   |  26 ++
> >  9 files changed, 566 insertions(+)
> >  create mode 100644 drivers/acpi/riscv/Kconfig
> >  create mode 100644 drivers/acpi/riscv/rimt.c
> >  create mode 100644 include/linux/acpi_rimt.h
> > 
[...]
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 36061f4732b7..96d64e0a7b97 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -16,6 +16,7 @@ config RISCV
> >  	select ACPI_MCFG if (ACPI && PCI)
> >  	select ACPI_PPTT if ACPI
> >  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> > +        select ACPI_RIMT if ACPI
> 
> Should use tab here.
> 
Okay.
> >  	select ACPI_SPCR_TABLE if ACPI
> >  	select ARCH_DMA_DEFAULT_COHERENT
> >  	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
[...]
> > +static inline int rimt_set_fwnode(struct acpi_rimt_node *rimt_node,
> > +				  struct fwnode_handle *fwnode)
> 
> I see this is a faithful port of arm's iort functions, but using
> 'inline' in source files is pretty pointless, so we could drop
> that.
> 
Sure.

> > +{
> > +	struct rimt_fwnode *np;
> > +
> > +	np = kzalloc(sizeof(*np), GFP_ATOMIC);
>
[...]
> > +	map = ACPI_ADD_PTR(struct acpi_rimt_id_mapping, node,
> > +			   id_mapping_offset + index * sizeof(*map));
> > +
> > +	/* Firmware bug! */
> > +	if (!map->dest_offset) {
> > +		pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
> > +		       node, node->type);
> 
> Should we have a pr_fmt() definition at the top of this source file for
> this pr_err?
> 
Oh yeah. Will add.

> > +		return NULL;
> > +	}
> > +
>
[...]
> > +	return err;
> > +}
> > +
> > +#else
> > +int rimt_iommu_configure_id(struct device *dev, const u32 *id_in)
> > +{
> > +	return -ENODEV;
> > +}
> 
> This is unnecessary since we have the stub in the header file.
> 
Right.

> > +#endif
> > +
>
[...]
> > +int rimt_iommu_configure_id(struct device *dev, const u32 *id_in);
> > +
> 
> ubernit: no need for this blank line
> 
Sure.

Thanks!
Sunil
