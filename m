Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0787115C152
	for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724183584; cv=none; b=dGvOQa66ryLATr1PkoW/i/J6aeuIxAmuHb5Y+8dZCOPQL6FS4xHCqvQ6jC6H1RB4261SZX6KvRMa3AhcDJl5Ugi5e9AFtjv00vMCP68Jlwerbe7ZAfI259A53jujPEqfip3lXXm5nxgB2mE/mywXvvEC1RyPflkS1MVgBOCjp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724183584; c=relaxed/simple;
	bh=f2EDYJYaLCiAoxFHTZr78tEIJO4+g6e/klYwcujCItM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0CFGQBApAM60Wky2KmPNg5RYNi0en6URaeMKMef6ishYVPQdI0T1wYvUXekNzMX2eLS3u4rLNqqZhESiy3AduEc9mLYQJtLcOMOj/hLK3SmjmTqCgrCDxQbG6Y60FB6x1qUVxRNhv7sQy5BGS62Ic6EijbBqt5GWYnFswMLI1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M59SPv75; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M59SPv75"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-429d1a9363aso3145e9.1
        for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724183579; x=1724788379; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yp4vfYpCGOdYBS/m6HmbaB98zMN6C60AGpKXCWzp5n0=;
        b=M59SPv75VJ4cuxFAj1LBtKbLzZPUb2N6KD90Z02uWfyU/uRBAuMxtvNPiYs8vBDeYM
         5YQijTQkKlNCGG1FBtuKa68GlylMtwOjaYFXokx+0Im72HetE/VSE2y+M+yFqctBXFwy
         IzgXU7BcK4Xec5Q7lnhbvBpjaM7AJee+W6rcRQf6hJfrZcdFiDD0Kd9kElcWg8sCPz2V
         Xg0J2hsGNThrRdUHFGh2fx+O6IdIDVoEX8SH94pu+4CTIb5BKLhmMDajOYr/xL3kCo07
         J1d9NT347MmxijtwlPgxPgCGenX4Ng7/d1dqkImhv61D3aRSSUXsqJEhSW3N1z5CJimT
         2m2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724183579; x=1724788379;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yp4vfYpCGOdYBS/m6HmbaB98zMN6C60AGpKXCWzp5n0=;
        b=wsbneAJ7ioPsf+AA8Ds/kuE5QYYNp4QUbBuBPdafR70bUyIIeZKoAicWPQGVki/ph4
         EcNEh5HfSOT0OxJLM6cVH3hKZ3B5cTLZaCnf5HDg0CWTCa9LkrPd9UL/g0n4kgPhx7rR
         ImzFahBO+blzIveu7RoeUq7FsG/fQ9qchx8q012JsSdQf1MehV4xh8B9fSMdMAdu3M88
         vXcvPhlnzviocZ1RDs+Z/hb0ZDGxi9kRUgbGLQk5wdtj9tUEVtudroPHwVUgCajQ7MeS
         KFKmwApj/lHHegQhXz5jv+3bi5M6qkiHwWSTz+8K+0apxuZqMcCPc7yXVOfG7/sAmVit
         y4RA==
X-Forwarded-Encrypted: i=1; AJvYcCU1B9lAfNuYqVNn+61GB3wE9wrLDOfSELZqHIeEPFaYwKnel0TL7B7n5UUze95YICSuXcXB/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8lxbO8Hyqbkq++jbuN07rH2eSfd9wXhI4DXqawXzZ8ZTU5UnB
	LYJSPERNeWg05ZqwcksisEXmSMJIk2t/O5bxSUOKXw/dYQR8lrXoxxT03nfr8w==
X-Google-Smtp-Source: AGHT+IEIPDf3d+uDL/Y/8Kxr91qxpv+48637k6O2srNTmFhDwf9KvmOeUX+rRg1Oapmp/C3vcKZSsw==
X-Received: by 2002:a05:600c:1f07:b0:424:898b:522b with SMTP id 5b1f17b1804b1-42ab78c1aa8mr1113155e9.1.1724183578856;
        Tue, 20 Aug 2024 12:52:58 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898b89bdsm13811059f8f.112.2024.08.20.12.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 12:52:58 -0700 (PDT)
Date: Tue, 20 Aug 2024 19:52:53 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev,
	Alex Williamson <alex.williamson@redhat.com>,
	Hanjun Guo <guohanjun@huawei.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
	Eric Auger <eric.auger@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 2/8] iommu/arm-smmu-v3: Use S2FWB when available
Message-ID: <ZsT0Fd5FHS47gm0-@google.com>
References: <0-v1-54e734311a7f+14f72-smmuv3_nesting_jgg@nvidia.com>
 <2-v1-54e734311a7f+14f72-smmuv3_nesting_jgg@nvidia.com>
 <ZsRUDaFLd85O8u4Z@google.com>
 <20240820120102.GB3773488@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240820120102.GB3773488@nvidia.com>

On Tue, Aug 20, 2024 at 09:01:02AM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 20, 2024 at 08:30:05AM +0000, Mostafa Saleh wrote:
> > Hi Jason,
> > 
> > On Tue, Aug 06, 2024 at 08:41:15PM -0300, Jason Gunthorpe wrote:
> > > Force Write Back (FWB) changes how the S2 IOPTE's MemAttr field
> > > works. When S2FWB is supported and enabled the IOPTE will force cachable
> > > access to IOMMU_CACHE memory and deny cachable access otherwise.
> > > 
> > > This is not especially meaningful for simple S2 domains, it apparently
> > > doesn't even force PCI no-snoop access to be coherent.
> > > 
> > > However, when used with a nested S1, FWB has the effect of preventing the
> > > guest from choosing a MemAttr that would cause ordinary DMA to bypass the
> > > cache. Consistent with KVM we wish to deny the guest the ability to become
> > > incoherent with cached memory the hypervisor believes is cachable so we
> > > don't have to flush it.
> > > 
> > > Turn on S2FWB whenever the SMMU supports it and use it for all S2
> > > mappings.
> > 
> > I have been looking into this recently from the KVM side as it will
> > use FWB for the CPU stage-2 unconditionally for guests(if supported),
> > however that breaks for non-coherent devices when assigned, and
> > limiting assigned devices to be coherent seems too restrictive.
> 
> kvm's CPU S2 doesn't care about non-DMA-coherent devices though? That
> concept is only relevant to the SMMU.
> 

Why not? That would be a problem if a device is not dma coherent,
and the VM knows that and maps it’s DMA memory as non cacheable.
But it would be overridden by FWB in stage-2 to be cacheable,
it would lead to coherency issues.

> The issue on the KVM side is you can't put device MMIO into the CPU S2
> using S2FWB and Normal Cachable, it will break the MMIO programming
> model. That isn't "coherency" though.> 
> It has to be Normal-NC, which this patch does:
> 
> https://lore.kernel.org/r/20240224150546.368-4-ankita@nvidia.com

Yes, that also breaks (although I think this is an easier problem to
solve)

> 
> > But for SMMUv3, S2FWB is per stream, can’t we just use it if the master
> > is DMA coherent?
> 
> Sure, that seems to be a weird corner. Lets add this:
> 
> @@ -4575,7 +4575,12 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  
>         /* IDR3 */
>         reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
> -       if (FIELD_GET(IDR3_FWB, reg))
> +       /*
> +        * If for some reason the HW does not support DMA coherency then using
> +        * S2FWB won't work. This will also disable nesting support.
> +        */
> +       if (FIELD_GET(IDR3_FWB, reg) &&
> +           (smmu->features & ARM_SMMU_FEAT_COHERENCY))
>                 smmu->features |= ARM_SMMU_FEAT_S2FWB;
>         if (FIELD_GET(IDR3_RIL, reg))
>                 smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
> 
> IMHO it would be weird to make HW that has S2FWB but not coherency,
> but sure let's check it.
> 
What I mean is the master itself not the SMMU (the SID basically),
so in that case the STE shouldn’t have FWB enabled.

> Also bear in mind VFIO won't run unless ARM_SMMU_FEAT_COHERENCY is set
> so we won't even get a chance to ask for a S2 domain.

Oh, I think that is only for the SMMU, not for the master, the
SMMU can be coherent (for pte, ste …) but the master can still be
non coherent. Looking at how VFIO uses it, that seems to be a bug?

Thanks,
Mostafa

> 
> Jason
