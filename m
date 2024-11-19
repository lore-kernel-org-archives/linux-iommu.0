Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617783F9CC
	for <iommu@lists.linux.dev>; Tue, 19 Nov 2024 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732024853; cv=none; b=InYqi4MasW5xo0uk7xpPnlPM6ry8HTc5VtPr+NOdnYSi2Ta0wcVU4rY6WaX3ios590m8bO6s6OJWBBZlMvwAmnNARy6AdSaWQfe+eZI8TNgW35rTALqPgqFsK8Gt0X2xCej0xl9Z8hH3CWvrWqBtqGRadcM8fXPVUnxWBgSjo28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732024853; c=relaxed/simple;
	bh=kf3Z6I24SKWn5bdSsa1E0NrkCUFicEWYJkJii1hPtGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCdbr9JbtPQExBP1E0wSOzQxrwVhcR+fkEQ+QG+6jJuwDa6Ibp2jpdYcCEkMYpzAQHeqibKo/Jo53AelOsoYFAH4DhHIZV4my+sOpWQwFQqzH5CyyDB1BCxgMPeJAyjxsLA1A7H4ifZIL5g4MC4ZBHTFAtnDw0ZLSrnrtIoxE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZPSzbu7s; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZPSzbu7s"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4609c96b2e5so6081801cf.0
        for <iommu@lists.linux.dev>; Tue, 19 Nov 2024 06:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1732024849; x=1732629649; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=utcZjeJ4axtWtuvENXsYE5WdR2pTF/ksB5rq4r17jag=;
        b=ZPSzbu7sM0tOgEl7n0WV1ElAo2j/ec9/12HyCloP9BxHRrSEsfXuqv87QSr3hW1I2/
         yZxQUDYVOtOjNiPQ+DuuLAFbm0uhGT/ZVTaH58+6LJMLC31GsIIUAJhMrX4XqSXbva1G
         zqa4A61qdlSY1WYFD0wga+zhug12/PaKs/WuaNlzbhhPBnrFPM8quIx4WdhiwWSb/pTl
         KXn5nFbJC3Z6NnnRk4TcoFquVV2d3YoegG4IrLdrznrA0snrAaBAh9meYyuwvno6HUx4
         Wat6b2NQD5wZtBcF2gws0MGtmKGdFSvL3IdIcY7twnZnHLPGdmIiXTS1Rih3kKE7h6A0
         YerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732024849; x=1732629649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utcZjeJ4axtWtuvENXsYE5WdR2pTF/ksB5rq4r17jag=;
        b=Z/tod9lM7LEUjIzydX9XAzQaALwfZyPEZJmCg5bWB3DAK2mfdOy0cg+sulpGszX2DC
         XjPGBDIzFacHHqLlcDlcC5auemC2n0M2AgDdNSgZygUekLl/M6dq+Ih0A44RKBB+eFOs
         PCjUi+aIZi98/sRzTD6hu7oHX5v3UsZX5eH6rFMHzg9Wlb6s2gBUidznJGJixGSsp9Re
         f8ppgTWNQknRG4FWMuOJIADRFEnY10Y9WOeTSdP+qdLtnWJwiIw/P73M8bMFVhPz1AaP
         ZsE/LdAtM4Sb1089VgjFHa2KUUMZ7onfgMfzmh7JgsPrlZ6X+qK9XCE7xa7Wdf5+SjjX
         miSw==
X-Gm-Message-State: AOJu0YwvMzglpBUj66XgErx4Vlym7dES1mlMQajby1xiXTxVaS9005aV
	BCGQj/rNK1VoUF0JL1OOaxilrXR1UDXt9muHfpP1GLHTPIsLHwObI8a8XW3Jr7I=
X-Google-Smtp-Source: AGHT+IHKbzbz2zzGHIA7vNzQrKdrVbH22etzYZttFKms0g8ZJKuTulmGaSp4Zqq0m5k19nTsP7U0iw==
X-Received: by 2002:a05:622a:10f:b0:45f:788:b1b1 with SMTP id d75a77b69052e-46363e2f7d2mr196949061cf.25.1732024849064;
        Tue, 19 Nov 2024 06:00:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46392c3c22fsm11239771cf.86.2024.11.19.06.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 06:00:48 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tDOmd-00000003DsE-272U;
	Tue, 19 Nov 2024 10:00:47 -0400
Date: Tue, 19 Nov 2024 10:00:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, tjeznach@rivosinc.com,
	zong.li@sifive.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, anup@brainfault.org, atishp@atishpatra.org,
	tglx@linutronix.de, alex.williamson@redhat.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Subject: Re: [RFC PATCH 08/15] iommu/riscv: Add IRQ domain for interrupt
 remapping
Message-ID: <20241119140047.GC559636@ziepe.ca>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
 <20241114161845.502027-25-ajones@ventanamicro.com>
 <20241118184336.GB559636@ziepe.ca>
 <20241119-62ff49fc1eedba051838dba2@orel>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119-62ff49fc1eedba051838dba2@orel>

On Tue, Nov 19, 2024 at 08:49:37AM +0100, Andrew Jones wrote:
> On Mon, Nov 18, 2024 at 02:43:36PM -0400, Jason Gunthorpe wrote:
> > On Thu, Nov 14, 2024 at 05:18:53PM +0100, Andrew Jones wrote:
> > > @@ -1276,10 +1279,30 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
> > >  	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> > >  	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
> > >  	struct riscv_iommu_dc dc = {0};
> > > +	int ret;
> > >  
> > >  	if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
> > >  		return -ENODEV;
> > >  
> > > +	if (riscv_iommu_bond_link(domain, dev))
> > > +		return -ENOMEM;
> > > +
> > > +	if (iommu_domain->type == IOMMU_DOMAIN_UNMANAGED) {
> > 
> > Drivers should not be making tests like this.
> > 
> > > +		domain->gscid = ida_alloc_range(&riscv_iommu_gscids, 1,
> > > +						RISCV_IOMMU_MAX_GSCID, GFP_KERNEL);
> > > +		if (domain->gscid < 0) {
> > > +			riscv_iommu_bond_unlink(domain, dev);
> > > +			return -ENOMEM;
> > > +		}
> > > +
> > > +		ret = riscv_iommu_irq_domain_create(domain, dev);
> > > +		if (ret) {
> > > +			riscv_iommu_bond_unlink(domain, dev);
> > > +			ida_free(&riscv_iommu_gscids, domain->gscid);
> > > +			return ret;
> > > +		}
> > > +	}
> > 
> > What are you trying to do? Make something behave different for VFIO?
> > That isn't OK, we are trying to remove all the hacky VFIO special
> > cases in drivers.
> > 
> > What is the HW issue here? It is very very strange (and probably not
> > going to work right) that the irq domains change when domain
> > attachment changes.
> > 
> > The IRQ setup should really be fixed before any device drivers probe
> > onto the device.
> 
> I can't disagree with the statement that this looks hacky, but considering
> a VFIO domain needs to use the g-stage for its single-stage translation
> and a paging domain for the host would use s-stage, then it seems we need
> to identify the VFIO domains for their special treatment.

This is the wrong thinking entirely. There is no such thing as a "VFIO
domain".

Default VFIO created domains should act excatly the same as a DMA API
domain.

If you want your system to have irq remapping, then it should be on by
default and DMA API gets remapping too. There would need to be a very
strong reason not to do that in order to make something special for
riscv. If so you'd need to add some kind of flag to select it.

Until you reach nested translation there is no "need" for VFIO to use
any particular stage. The design is that default VFIO uses the same
stage as the DMA API because it is doing the same basic default
translation function.

Nested translation has a control to select the stage, and you can
then force the g-stage for VFIO users at that point.

Regardless, you must not use UNMANAGED as some indication of VFIO,
that is not what it means, that is not what it is for.

> Is there an example of converting VFIO special casing in other
> drivers to something cleaner that you can point me at?

Nobody has had an issue where they want interrupt remapping on/off
depending on VFIO. I think that is inherently wrong.

> The IRQ domain will only be useful for device assignment, as that's when
> an MSI translation will be needed. I can't think of any problems that
> could arise from only creating the IRQ domain when probing assigned
> devices, but I could certainly be missing something. Do you have some
> potential problems in mind?

I'm not an expert in the interrupt subsystem, but my understanding was
we expect the interrupt domains/etc to be static once a device driver
is probed. Changing things during iommu domain attach is after drivers
are probed. I don't really expect it to work correctly in all corner
cases.

VFIO is allowed to change the translation as it operates and we expect
that interrupts are not disturbed.

Jason
