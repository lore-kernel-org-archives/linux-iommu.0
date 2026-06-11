Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890283BA24E
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178618; cv=none; b=Upv+7lqdkxVt83qfjhnYMAIfY1pir/m8a3YcyDFfkFMCz2P55NsgY0HKp9k5drZwhAzV9dKTbZSqCMkOUEZGzilyg5sDcmAkQEgPluHIpffEyA6LCCMo58dJnM45JAwO9rheH5UGFVT4Y8iP/lMbjRUKuUOpUVph8pBhrWU9d10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178618; c=relaxed/simple;
	bh=UmW9Vbd3ZtejVIzFUGtLzNmEE0KC+mhPuzfVyC+exsY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwbJIz3yzh/QYpZRqlnRgso4BPhsPWJVCnZ9ZErGtufEPIrx3crFXSE8Godh0Nq1c3SBHt4KTJDirZT08N0Hx6Na3BfKh5x9E0SUsjG5FsOTS1zC9FidIjEHKZIhv5UwZOiQ0hhuF7443Si3fDBtL+xO4Q4VpSMWpXxakumtdYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SU0EPj2U; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SU0EPj2U"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ee224f5fdso837652f8f.0
        for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 04:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781178615; x=1781783415; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=By5jxDRfMhWNJ3zdMqbqgKEuQjBAiR2dgY0SOpXrO1o=;
        b=SU0EPj2Us0ceCJ8TbEnR7titiyNlHBxJio35+26/Badcm/cdAIj448XyQbxNHQK/uv
         1X8wre3N7niaBtTspFNz2FWoFyepI1J6GNE9bHH23pTl+bwJM2WVnPH7l0dXFrT3XL/x
         lDP4LXRehOJpvyksiCOBPOqvqfzFWK3ARx93/3cPXtUzHcd902N3kKmL70AEtmkcNCUB
         s5NjZS2Ri9pA7ERIdTJmpC3WNQJJzhtWb97NuRoAXFzguAiYcueDJUZUUjEXB8z8sZgc
         VFH01dFyaiTf76b7kiYoiQTWL5czDpHHyWEiyWyHlYUsQyrtET2lWsxgcKxZiPewPOWc
         +ckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781178615; x=1781783415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=By5jxDRfMhWNJ3zdMqbqgKEuQjBAiR2dgY0SOpXrO1o=;
        b=smDFP9NWRGkn7G3Q4NIafie26ef3HJsk+n/yIJc7y/w4JNsFHeEBEHTEy0zw6SRwNp
         gNIPxaQ9JwVC38CJ2XsnGOjxG8uNVEWMMZvO32eSo5kR6Wpv0/FlBG/NzOtNJMqWdWwb
         cCjCGiO4cbnElsRjBTiCW+HE01VC+ramDY2BroTXBdVzjMzX5WRE3POzaYx2qErWxSlt
         DObmgDuuyMs3FaLqysJ85KjLPhtGKV6aRbJYYCp9tiLNGE4c7vGe93mc8RPL95UN8KNT
         tZtJbCrrTF8Gjw+n4mNlbaaCERLEfPp5FPUjVlm2QfMyAALwwgZ5CAOT/X+nn8lHO8zp
         ruzg==
X-Forwarded-Encrypted: i=1; AFNElJ+sp3IpDooS9uNJoowxC7HXpG+PHMFKH7rNAzoqcjLjHGMJbWFSNzleqtmcztG+cUUxiBiyFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyiFkMu69wUwPCsFnXiLUSGFgHZQdJHJjY2GCf4jr7JIlMXtvU/
	21DUsKDlvV18mmwAbectoxB6UCvrftUEHnc5b8rAabIt1kp++qLO83+FOzcNxJdVKfQ=
X-Gm-Gg: Acq92OG2afJa0YVsOy28w+cPW+s9CAZJSlcSrk4Ke0LV1Hx1sCMO/2r0wD79jJLryUQ
	bJ553+IcA0VDzoHDhFKOP6bA0d/Drj/UQ0n3MasaAAJD13hkqYdhvNuEPHBwECL4fyl/j5s3NR0
	+4/yDugkOBDKHqxUclJnotn4chUXbijcA9aVC+TkGLbXB7Ddm10FoS3BqzNcczZaUu9P9q8Xw4P
	JCyBkBfTdFJtat3nhBqz/f7kiDtEEmykDLZKuSV3QT/HYaMctJWMPsEqt7gDO2StcE7rxSCcWKG
	vZ+GrJ+ELzuPObn/nrcod+U1x+Haj2gfdt2Nmxt+vJzSXlbX0UyzJq6ONjoi7adNzqFPaqOY1R8
	pSV0aL5Qzsaxx1M0dY5gnR2FvK/q7htN6cET+VF2FKIBUh8PhStODV8JKgR9WmEEc9zXXPbgkkn
	b9cJwaHBskJ+DGhwAHR3GPe0nsLnr+Hd4p7V1BtdQ7T8fFMFFPqclH5xKj/KREeiCn1U2JC4YoK
	tm8clSMjV4xngpJ/A7Yaxc/zx5PmevBYM1B5A==
X-Received: by 2002:a05:6000:2508:b0:460:1bf8:c959 with SMTP id ffacd0b85a97d-460673e3ae5mr1690022f8f.0.1781178614930;
        Thu, 11 Jun 2026 04:50:14 -0700 (PDT)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ed944sm83042430f8f.13.2026.06.11.04.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 04:50:14 -0700 (PDT)
Date: Thu, 11 Jun 2026 13:50:04 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, Marc
 Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>, Suzuki K
 Poulose <Suzuki.Poulose@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh
 <smostafa@google.com>, Alexey Kardashevskiy <aik@amd.com>, Dan Williams
 <dan.j.williams@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Gerald
 Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, x86@kernel.org, Jiri Pirko <jiri@nvidia.com>,
 Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 04/20] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260611135004.70d48daa@mordecai>
In-Reply-To: <20260611113740.GB1066031@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-5-aneesh.kumar@kernel.org>
	<20260609143242.GK2764304@ziepe.ca>
	<yq5aa4t1myw4.fsf@kernel.org>
	<20260611113740.GB1066031@ziepe.ca>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 08:37:40 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Thu, Jun 11, 2026 at 10:55:47AM +0530, Aneesh Kumar K.V wrote:
> > Jason Gunthorpe <jgg@ziepe.ca> writes:
> >   
> > > The sashiko note does look legit though:
> > >
> > > 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> > > 	    !gfpflags_allow_blocking(gfp) && !coherent) {
> > > 		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
> > > 					   gfp, attrs, NULL);
> > > 		if (!page)
> > > 			return NULL;
> > >
> > > I don't see anything doing the force_dma_unencrypted test along this
> > > callchain..
> > >
> > > I guess it should be done one step up in dma_alloc_attrs() instead of
> > > in dma_direct_alloc()?
> > >  
> > 
> > I think we should do something similar to what dma_map_phys() does here,
> > considering that we only support DMA direct with DMA_ATTR_CC_SHARED/DMA_ATTR_ALLOC_CC_SHARED.  
> 
> Yeah, I think that's the right idea for now..
> 
> > +	if (force_dma_unencrypted(dev))
> > +		attrs |= DMA_ATTR_ALLOC_CC_SHARED;
> > +
> > +	is_cc_shared = attrs & DMA_ATTR_CC_SHARED;
> > +
> >  	if (dma_alloc_direct(dev, ops) || arch_dma_alloc_direct(dev)) {
> >  		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
> > +	} else if (is_cc_shared) {
> > +		trace_dma_alloc(dev, NULL, 0, size, DMA_BIDIRECTIONAL, flag,
> > +				attrs);  
> 
> But it would be clearer to put the test in the iommu_ functions I
> think, since they are the ones that have the issue. We will need to
> fix it someday..
> 
> I think we can ignore the op-> functions, arches cannot support CC and
> still use dma_map_ops..

Hm, sounds reasonable. Should we probably enforce this at configure or
build time?

Petr T
