Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293A8149DFA
	for <iommu@lists.linux.dev>; Tue, 19 Nov 2024 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732002582; cv=none; b=asAp4moHEtLhNgAB73fv0vm+9Cg8evJA73Kpr68raLNpTm5o68nWO3NrE/G/0K6P9/N8yRwBb0YQPqHTqmb8j80wRuv7qO0Q34DWKvZUlEPdrloKI3Jqa2Q94MRhPjM6t0tM9jVgQFDkI+qJEDJn+VD7yCqF4vTfR0r3lUP3QeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732002582; c=relaxed/simple;
	bh=IaOmPR/iyXz/gE2tIqhYLRtRkctqg6/SvtDytNmpBsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ha6PWRlBdM6AOB122Y0KHSUDF3yMQbXhUtg0Hqkp3NxAQ8ZwIw5PWo/YvjVHUxK3mIYwOL2xaDHadnyCZEEC8vWnQ7Bvfivt6N3dPNhsywa12I6+a9k3/fy0jczpD6CU85GOpQk0n/gHO95J+Z1bPHiUEfIkDq2vckdK4ZqojJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Hpg7lW5e; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Hpg7lW5e"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-382423f4082so437661f8f.3
        for <iommu@lists.linux.dev>; Mon, 18 Nov 2024 23:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1732002578; x=1732607378; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NYBbT7qYRsGmfiJkt6bNI0oAoiQc6F6a4Czuh6tR0Qw=;
        b=Hpg7lW5eDrzUwjmJuJtlnWt7/u5fZ8RKUKLpmAvcJrh7mnb3PPhMb8IR+fuTYYN1WI
         7w877g8xXuaPdOwhzLzRGoJjoDWxtiV2roAIBQ8Ezxw3c58aLTWAFoinwgz/M7GTIvKT
         lHvIRDLxx8hvCu0uXmocmg7831jxXN5h4QgoXPsralozG7yyOmk02oWeOH3Y87Ou1ub3
         wICZtsitzkVvyP8WCTRsP18nXRfGxgKMT2oxtytx0VlygKtxUJXWDO39MN/ms0PV/tDW
         ydjC2AJ/AoUEX1rJ+SuAHk1vuhwnQHYROhxrJ/a3kQ4oMNB2mkDJweIz6MsfSSzRfXjP
         O6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732002578; x=1732607378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYBbT7qYRsGmfiJkt6bNI0oAoiQc6F6a4Czuh6tR0Qw=;
        b=ciQ3FBJDviyrVd+qrcX0vVd7E8fzhpcekPxbitTUG8h4YNSrQz00I9SLNLM/SniBJB
         Et/JmrIdd8pAdNbaA2BPElvtH18g22V/l4svdGn4EzyJlBya92p8BgGoQEcQoLAL5uTI
         n/ThnjCNeQdy4Bktyd+lZ1LR/el84t4k+xwGCokXDyZA7+F8MEWkgRpw4UpY36kuDVmD
         NdJncFcp01sCVx48YEkvcD8DaBNEHUdtMLf27gfZSrR3bAj0JhFO873ky/peifsIb7zC
         28eJKrUgSIDG/fThH+gHDV+iXld/C4ixrwY9pXGEwILbb/HRjqB5AP6jV1Psb4nKGqQz
         eJwg==
X-Gm-Message-State: AOJu0Ywhu5flrPwbhRggtqmUgybgDiREGvQJbGO3E/44C+S2ZHFYpcIi
	3tUtvM9ZRAEzMuNQtZEIEXB1MYCLCf4WN8loZ/DWIG91Q8/RpU8DkS0oXFzdKU4=
X-Google-Smtp-Source: AGHT+IFe5ZmtjhLXYqttDHgdk3C4AFgFbxG7y2tLe4XO1qVtRECgKa8Bx3LhB6YxSZPNMfHR5Z6PNw==
X-Received: by 2002:a05:6000:2d01:b0:382:5030:7b94 with SMTP id ffacd0b85a97d-38250307d48mr353908f8f.13.1732002578369;
        Mon, 18 Nov 2024 23:49:38 -0800 (PST)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382462dbb5esm5733966f8f.52.2024.11.18.23.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 23:49:37 -0800 (PST)
Date: Tue, 19 Nov 2024 08:49:37 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tjeznach@rivosinc.com, zong.li@sifive.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, anup@brainfault.org, atishp@atishpatra.org, tglx@linutronix.de, 
	alex.williamson@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu
Subject: Re: [RFC PATCH 08/15] iommu/riscv: Add IRQ domain for interrupt
 remapping
Message-ID: <20241119-62ff49fc1eedba051838dba2@orel>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
 <20241114161845.502027-25-ajones@ventanamicro.com>
 <20241118184336.GB559636@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118184336.GB559636@ziepe.ca>

On Mon, Nov 18, 2024 at 02:43:36PM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 14, 2024 at 05:18:53PM +0100, Andrew Jones wrote:
> > @@ -1276,10 +1279,30 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
> >  	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> >  	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
> >  	struct riscv_iommu_dc dc = {0};
> > +	int ret;
> >  
> >  	if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
> >  		return -ENODEV;
> >  
> > +	if (riscv_iommu_bond_link(domain, dev))
> > +		return -ENOMEM;
> > +
> > +	if (iommu_domain->type == IOMMU_DOMAIN_UNMANAGED) {
> 
> Drivers should not be making tests like this.
> 
> > +		domain->gscid = ida_alloc_range(&riscv_iommu_gscids, 1,
> > +						RISCV_IOMMU_MAX_GSCID, GFP_KERNEL);
> > +		if (domain->gscid < 0) {
> > +			riscv_iommu_bond_unlink(domain, dev);
> > +			return -ENOMEM;
> > +		}
> > +
> > +		ret = riscv_iommu_irq_domain_create(domain, dev);
> > +		if (ret) {
> > +			riscv_iommu_bond_unlink(domain, dev);
> > +			ida_free(&riscv_iommu_gscids, domain->gscid);
> > +			return ret;
> > +		}
> > +	}
> 
> What are you trying to do? Make something behave different for VFIO?
> That isn't OK, we are trying to remove all the hacky VFIO special
> cases in drivers.
> 
> What is the HW issue here? It is very very strange (and probably not
> going to work right) that the irq domains change when domain
> attachment changes.
> 
> The IRQ setup should really be fixed before any device drivers probe
> onto the device.

I can't disagree with the statement that this looks hacky, but considering
a VFIO domain needs to use the g-stage for its single-stage translation
and a paging domain for the host would use s-stage, then it seems we need
to identify the VFIO domains for their special treatment. Is there an
example of converting VFIO special casing in other drivers to something
cleaner that you can point me at?

The IRQ domain will only be useful for device assignment, as that's when
an MSI translation will be needed. I can't think of any problems that
could arise from only creating the IRQ domain when probing assigned
devices, but I could certainly be missing something. Do you have some
potential problems in mind?

Thanks,
drew
