Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C26A1DEFC7
	for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732295288; cv=none; b=AVmXz+rpmvg79MEShMmK/JMOGDxxUX6I1d54S5pw5ZaCeCByKbFJ1m9MbVAJFEjSh2a+I1TkWTmpmRFLmdF+H3ei0tmrRZBRevmVx2bPY20VCl+wsgNpQsFrv1JnEKgdQfKAH25I4syE6l8kuPdriH+2zrgN/rL3ipZLJjOEShQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732295288; c=relaxed/simple;
	bh=65Td0TnTUIzwe/pt9Jcl3ypj6q4zhZfthV5rP5mHkJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBz3MR5poeZmCLo08XDgR9s4ANsFCecbmzdbKZulgGmj7Fp/Ot2ZsA9pDcgAhcY84D0j6N04XGby7O85HF3xp7RZ/hdsC58rPGV3JdUZ0fSPLvnZ94PGrwa1Q5A7Nb21u6LuQAH65pWCUgAc9XbnX+HNq3iuso94dPsLqihb868=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=FFfnv/Jg; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FFfnv/Jg"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cfaeed515bso2998307a12.1
        for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 09:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1732295284; x=1732900084; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0DOX93bw5phi/WY0MT30BO5hYdUtb3juzdM+PG5dKU=;
        b=FFfnv/JgPCROi1JwVGsfARn8FdOIdPWyHNQAcizuYvgeYmB132rF5aNvKFThNx+3Oz
         PxH3e5nJB2REuSazv91tjx0GU1+v5eEkr39a5AYMUVPDDuV3FFAVU3wHCcb5tqM+NCkC
         SzN7l0uqyta4DYBwFfS5BqqP99tb7eRkzVDA7p6Fm+ZH15rNyEq7qglyJSsELB30zmGo
         56nIB3S8cr09GUt4zriaGbHZJ4OsgY9y364N2EtvkhPOghIRX+CNBuKNPx7socNq063R
         CK6qqV/Jb2KF4+l0Nz+b2qlqgnmhGujQ30QoFLnA4CK5x8hlb4FLOkLNoy1btQiJ2PZn
         Ge0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732295284; x=1732900084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0DOX93bw5phi/WY0MT30BO5hYdUtb3juzdM+PG5dKU=;
        b=kqYSLQzSQNJWdqEknw4v8gxEZrltxmiZmekUB5odYn30PtyP4n2/FpsFlEM56oebf5
         c1Wz+NQecG4wxZXrX6O+TTPuoMMDa9c0YENsWu8Jx91QsNRf+buwG3pv+Wjy63Pt04ZM
         yZTiAGIxuACVAgDFsaw8RTLlhYn7LNmkLdRrtcJXShJs98k9PG6gyxDUzpv1+Uc90U0E
         Mus7gnOmc/mNCXNKIHe+DpP599EqTRslt7A+pSmpPspueS9spQuPI7N9Lnb78foB1J4i
         GWzrrAYAgPacoHu/OX+3sbZWOwWxiYS0+6J3NdfGZ8dxOGURf0KZPZHLNZokuMTFFCtL
         EfUg==
X-Gm-Message-State: AOJu0Yz+Sxh2oUp7w1pSptzQLyjM2XR0t56qKYVEfiy/PLlF2819E+9J
	Hq3WjgXxU/DI0CwtE8AOn/WuW5qMEAVJnx6G78P5qjiMDwNyfWQXYqkFzTajBeA=
X-Gm-Gg: ASbGnctsGQIIF7sJ73GVL2IT8LnLi4v3efojKpIG+6x3sHBFflTVlzFAMCpQEGcJ3lu
	TmeflOujP4YV6Ap0Pd4CmdX/h0PrWqqdkXZkl9wzLZXituc1wgvITib5D0rIeqhXOPsw8Jl2FQi
	xMvzljgBiVo56xH2+vZYG40F2sWd4TW8eNgovAm58uJK88wYp/mUVvPoy7GI+3W3qv+yH+B+dba
	k/96k6uE9Buyd+XicxP40xd/y3gcTDZnRh7eX23lyGecFovTlWUv/ITT5yYb/CbT6VPhlAEj5CQ
	JzriEOeuNRKAulfgCPW8XaT/s25Ni2ymXvc=
X-Google-Smtp-Source: AGHT+IGtSa/c759tcXKL36hfS9NeLmo4AZHZNWZDIockuCHHkNSeQM+NVau/IABnZYXKpy1e8IALBA==
X-Received: by 2002:a05:6402:510c:b0:5cf:9a8:2bca with SMTP id 4fb4d7f45d1cf-5d0207b9aedmr2507880a12.31.1732295282728;
        Fri, 22 Nov 2024 09:08:02 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3b032esm1100517a12.19.2024.11.22.09.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:08:01 -0800 (PST)
Date: Fri, 22 Nov 2024 18:07:59 +0100
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
Message-ID: <20241122-8c00551e2383787346c5249f@orel>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
 <20241114161845.502027-25-ajones@ventanamicro.com>
 <20241118184336.GB559636@ziepe.ca>
 <20241119-62ff49fc1eedba051838dba2@orel>
 <20241119140047.GC559636@ziepe.ca>
 <DE13E1DF-7C68-461D-ADCD-8141B1ACEA5E@ventanamicro.com>
 <20241119153622.GD559636@ziepe.ca>
 <20241121-4e637c492d554280dec3b077@orel>
 <20241122153340.GC773835@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122153340.GC773835@ziepe.ca>

On Fri, Nov 22, 2024 at 11:33:40AM -0400, Jason Gunthorpe wrote:
> On Fri, Nov 22, 2024 at 04:11:36PM +0100, Andrew Jones wrote:
> 
> > The reason is that the RISC-V IOMMU only checks the MSI table, i.e.
> > enables its support for MSI remapping, when the g-stage (second-stage)
> > page table is in use. However, the expected virtual memory scheme for an
> > OS to use for DMA would be to have s-stage (first-stage) in use and the
> > g-stage set to 'Bare' (not in use). 
> 
> That isn't really a technical reason.
> 
> > OIOW, it doesn't appear the spec authors expected MSI remapping to
> > be enabled for the host DMA use case.  That does make some sense,
> > since it's actually not necessary. For the host DMA use case,
> > providing mappings for each s-mode interrupt file which the device
> > is allowed to write to in the s-stage page table sufficiently
> > enables MSIs to be delivered.
> 
> Well, that seems to be the main problem here. You are grappling with a
> spec design that doesn't match the SW expecations. Since it has
> deviated from what everyone else has done you now have extra
> challenges to resolve in some way.
> 
> Just always using interrupt remapping if the HW is capable of
> interrupt remapping and ignoring the spec "expectation" is a nice a
> simple way to make things work with existing Linux.
> 
> > If "default VFIO" means VFIO without irqbypass, then it would work the
> > same as the DMA API, assuming all mappings for all necessary s-mode
> > interrupt files are created (something the DMA API needs as well).
> > However, VFIO would also need 'vfio_iommu_type1.allow_unsafe_interrupts=1'
> > to be set for this no-irqbypass configuration.
> 
> Which isn't what anyone wants, you need to make the DMA API domain be
> fully functional so that VFIO works.
> 
> > > That isn't ideal, the translation under the IRQs shouldn't really be
> > > changing as the translation under the IOMMU changes.
> > 
> > Unless the device is assigned to a guest, then the IRQ domain wouldn't
> > do anything at all (it'd just sit between the device and the device's
> > old MSI parent domain), but it also wouldn't come and go, risking issues
> > with anything sensitive to changes in the IRQ domain hierarchy.
> 
> VFIO isn't restricted to such a simple use model. You have to support
> all the generality, which includes fully supporting changing the iommu
> translation on the fly.
> 
> > > Further, VFIO assumes iommu_group_has_isolated_msi(), ie
> > > IRQ_DOMAIN_FLAG_ISOLATED_MSI, is fixed while it is is bound. Will that
> > > be true if the iommu is flapping all about? What will you do when VFIO
> > > has it attached to a blocked domain?
> > > 
> > > It just doesn't make sense to change something so fundamental as the
> > > interrupt path on an iommu domain attachement. :\
> > 
> > Yes, it does appear I should be doing this at iommu device probe time
> > instead. It won't provide any additional functionality to use cases which
> > aren't assigning devices to guests, but it also won't hurt, and it should
> > avoid the risks you point out.
> 
> Even if you statically create the domain you can't change the value of
> IRQ_DOMAIN_FLAG_ISOLATED_MSI depending on what is currently attached
> to the IOMMU.
> 
> What you are trying to do is not supported by the software stack right
> now. You need to make much bigger, more intrusive changes, if you
> really want to make interrupt remapping dynamic.
>

Let the fun begin. I'll look into this more. It also looks like I need to
collect some test cases to ensure I can support all use cases with
whatever I propose next. Pointers for those would be welcome.

Thanks,
drew
