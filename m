Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5097A33D6E3
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797029; cv=none; b=U3uHkfxW3TLE/sR1bI2Q3u9/nJuzL8mC5AxkUSG0HL2ZIfBaIN84SvANMum8UCpXGXAca+ApT2lG4er4HKU/AcKYJw1sYSFvdGpyt52akITHEc/4KABhIrguXAJzotZMnwFpap91VNEd6ncENMMdUbJui1et5L5d+AOMrH6TVas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797029; c=relaxed/simple;
	bh=HppPOGKgKIoggGCewCbUbyU4i7DooaPcpXs3DkDXKHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaGC+ar9i3ZaivU6Su4s0FCSci93UoXbV4RuMrNcilfDF+LFBZVtPBA9KMvbRUK21/c67gxAczlVEuIqJY11Vm83fMmrp5RdBMcrTN9icLYjd9Ga2EGvNGv8+Zxp11oFN5MLIZ4PI7cPCbhVdRPC5KhtTIEEv7Lhao7Rlr0Uz/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=od86ZYi8; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="od86ZYi8"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9159f631656so150975985a.1
        for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 08:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781797027; x=1782401827; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tm+jP+3WfoLtXaL6gn2l0sQY+Wj2XqJdxBBXikZyHQE=;
        b=od86ZYi8VRaxi2qBmcnKXDTVvWHYUg2ITZ+BWhwJC5Xq4DZduuGWhDf4r2SVOUkHYL
         kCazIUUTigHlG9eWZG0ThucwTn/bji4phU5IkUS9jTa26BPQXCy7C2SFfT9Gyt/KzN8S
         moB5YTUtIKiL6xpUsZU9AbKA4YtaSEpatfx+YKHChcCTWlREndGycDsHCYiYeIBIsPWX
         VFl7RaWs5qTzUSS2skP+k0NJUnoHYo6fRtF8NmGx7YHZrmLnPCf9FalDL1Emxtn3tEMW
         FoHWpv3vuLuyJJ/Kab1J5srUgEJkONl7hrBeQMuJC5zMLn9N4svmF/psqFFDb8AFesZY
         EP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781797027; x=1782401827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tm+jP+3WfoLtXaL6gn2l0sQY+Wj2XqJdxBBXikZyHQE=;
        b=kPs6mlwVtQ42cEOYwrlc91iR0qcIj8BG/xlJdFKiEgMaAY4Sb71MqByVteQmkJbj36
         rLVQnAz1tUns7GnkGDirRvjyjHUjOyPox4gjDmRLiZlwoHVNSIHeVua4iDFbujfQj3Ty
         Gx3Ov32+m4SdnjvHE7nPGDqA8rw44kptv7KsnCHzXzw47zTSesr31Lg45h5iEweduQh4
         aDoi7chkHJjG7X0uVbIzlf8Xd6RVbrB8JAmmTy/HbP0utcSvBIQqzHefxI4DQBoewVLw
         TrZXyYjk4qHaGRC8A2SDW9THqcooagsSFIvcj1fJGZEqzgZqc82vbvP58yuD6FLsYjpX
         JY/A==
X-Forwarded-Encrypted: i=1; AFNElJ8en1OuctcnvtQxvP6kZP3VHNOB8RsQl+l7l1ofQV0kZs3gMRpmqFf/AYr+ToOjd+fLLHRELA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz14eAZdgRGaS4faVo8QprEBTWxxRE0I806YW7S/A2JAaLLU86u
	RvdWgxCTTBwJyJIryaVRpN3b9AezR8GBEo/tRDhKV9KULot44jI0pK932WQLURGPy2s=
X-Gm-Gg: AfdE7clo9o3y7QAqLHMUdD9/Bjxw2p00TsTVHE/hZ/C60z9TxPVrZWS83Db15O3dhTr
	b9yhbmD05dQh/9KY6Pky5zjmtmAMBC+qGPOzGk/zInenNAP1nrZ2saHBQppmFIIvMLq1hhn2wlk
	q0pC0Vc3tMj/4DbccxpeIeJMOWwumcTP0Txcab6vfcX5bp89BD+abFO7oK/N2dM0KaRjm1OxJaj
	fDVGvfoMr1ikLXsQQ8TQITbPajIo9cYIb7SNONMPbttAIiO/9BQz/szXAYo6qTGFphIXI1o2QrL
	/NB+9zH+43O1nLC4R5njnQsUDwLWoxcSRMRWZmlruv9cML8VCEEHqujilel/f0JhhOvylHBcayj
	OZlCsOyOFuft0bhMdT9/pDTaXLspWXFQGqwhySxpgXAKLILZURwz7iYnmP0V3Xw1qV7eqDd7ehY
	jjIQx7G2VmIDY0rBnttcvDxWTmlvXrugmLEGJnU2xlQehgOwTg6+ycafySuHxsj0vl5wM=
X-Received: by 2002:a05:620a:469e:b0:915:8f64:604c with SMTP id af79cd13be357-91f082ff425mr678605385a.15.1781797026718;
        Thu, 18 Jun 2026 08:37:06 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f3c324sm2104263685a.21.2026.06.18.08.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 08:37:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1waEnh-00000002tSw-24HO;
	Thu, 18 Jun 2026 12:37:05 -0300
Date: Thu, 18 Jun 2026 12:37:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <20260618153705.GH231643@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com>
 <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aqzm4dz25.fsf@kernel.org>

On Thu, Jun 18, 2026 at 09:37:22AM +0100, Aneesh Kumar K.V wrote:
> Alexey Kardashevskiy <aik@amd.com> writes:
> 
> > On 10/6/26 00:47, Jason Gunthorpe wrote:
> >> On Tue, Jun 09, 2026 at 02:43:08PM +0100, Catalin Marinas wrote:
> >>> On Thu, Jun 04, 2026 at 02:09:39PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >>>> This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
> >>>> dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
> >>>> are handled consistently.
> >>>>
> >>>> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
> >>>> shared/decrypted buffer handling. This series consolidates the
> >>>> force_dma_unencrypted() checks in the top-level functions and ensures
> >>>> that the remaining DMA interfaces use DMA attributes to make the correct
> >>>> decisions.
> >>>
> >>> Please check Sashiko's reports, it has some good points:
> >>>
> >>> https://sashiko.dev/#/patchset/20260604083959.1265923-1-aneesh.kumar@kernel.org
> >>>
> >>> I think the main one is the swiotlb_tbl_map_single() changes which break
> >>> AMD SME host support. There cc_platform_has(CC_ATTR_MEM_ENCRYPT) is true
> >>> but force_dma_unencrypted() is false. Normally you'd not end up on this
> >>> path but you can have swiotlb=force.
> >> 
> >> IMHO that's an AMD issue, not with the design of this series..
> >> 
> >> The series is right, a device that is !force_dma_decrypted() must be
> >> considerd to be a trusted device and we must never place any DMA
> >> mappings for a trusted device into shared memory.
> >
> > swiotlb=force forces swiotlb, not decryption.

If force_dma_decrypted() == true then swiotlb must allocate from a
decrypted memory pool. It is right there in the name!

The hypervisor environment should *never* set force_dma_decrypted()
because all devices can access all hypervisor memory, up to their IOVA
limits.

> > So when I try "mem_encrypt=on iommu=pt swiotlb=force" with this
> > patchset, it fails to boot. But it boots with a hack like this:

On the host side I expect this to cause swiotlb to allocate encrypted
memory and bounce to it.

>  		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
>  		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
>  						dev->bus_dma_limit);
> +		/*
> +		 * With memory encryption enabled, SWIOTLB is marked decrypted.
> +		 * If SWIOTLB bouncing is forced, treat the device as requiring
> +		 * decrypted DMA.
> +		 */

And this is more insane logic. The right fix is to allocate the
swiotlb bounce from the *encrypted* pools when running on the
hypervisor which requires undoing this abuse of force_dma_decrypted().

Jason
