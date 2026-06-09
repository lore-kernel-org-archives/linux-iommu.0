Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F78C2DC32C
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016470; cv=none; b=QUhHgNYP3mgo+x+krOLHL8wXFmnQJ+zJE3C4xjuDzNVWfOXFATXkwPMIcLDOujPQj6owcge0xwxxnfBPfgINOYmTJV9pYApIeOktZ0g4eEpiItOP8san4vkSHwnlS1jMwfhwFH7R4jF3xWe7nDxpoMt9YMdBQXlo62poEnxP6Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016470; c=relaxed/simple;
	bh=flX4syNBceOQnZIne8mUXe1H3ubYr57A93RZ+UOuZeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrL4G1TO+jtlSNeyqYScF+I8+prpWSCUJzo5WcNbteTldsKl0EY2HAKLG2k29hr8UV5TAkfRTeNPRlcrdXqJJmPdsEsZNBwAhs/B7cseCm/DCVfQpI7sKE3WXSL9KLq/GOotHarAmQ7DGtsRvknDSRqcxdaNjQq5gOo6DusUBGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XnMjILTm; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XnMjILTm"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-91562bf6c12so689784285a.2
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781016467; x=1781621267; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jVABLuHAzbvMd8rLAYuqriN8lpaGXdnOhBwKXzGn2mk=;
        b=XnMjILTmRQFadu4F8KAup53ig5bqhRy5N15beV2iCbaEdf/oMwudFTu1iwuC//Js5q
         BTL4/3AmVpHq75GkKyDwNZLLwPcUIQ4o64bS9JP+a3/vhYphLyTrml0IA5XrNhJRhs+h
         RziC1m6JySO8ykEzypxC+Eo+IrXJKn43E2lZ75DJmhfahj56BaVgWQtemXkRY/yR4o/3
         PYkzrCXLde8NdWP7/7qjPsKleunp5qbhFMGNHOlMiTCZWGspE//Gfa+OjuUrLl0JkVeS
         EjD3azH7dRuvsfeJJXaXVsrDOCPqv7rv5zPpDGggVpv6NJHZhG67659xUlDItYkN26XY
         X5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016467; x=1781621267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVABLuHAzbvMd8rLAYuqriN8lpaGXdnOhBwKXzGn2mk=;
        b=SrP7y/3kUPFl9yO7CswyBtSXl0oKg9BEMTmQReFTWDyhYgB6CXuH2w14nm4sf1DMEy
         Va50zNzBsCcNWozUiEqxwCtmgJpODLS1dojVDrKQrGxthDwWgXT5xM/D4Aqpu8BbTD5F
         zM5FDE7wC0iXOzEEQiueEw4WXEWiZUSTu8AO89D/qol6qpI9kMfUbjY3D/Fmd+UyOFR1
         68uPKozY3X6mx3R8bxoeC5aRlPP1b5zIDbNN1yIzTUf/NKPiPEh8VhAAv8578UZjxG/H
         BIKYh6bqzvbiLKKZVUGZSrmCYdx3a4/KfNiL8w4fcnN05kG9oZIbCuDPPCyre5/LMzKt
         hREw==
X-Forwarded-Encrypted: i=1; AFNElJ871v/m/c1babPlDwdL3R965PkSQm6ZecipS1EVN6SW+2SkEi2ex0p/fTd9kxcawx4F/Y7xUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMsLWu/+7C7X4a8H8IRZLA5+Uv2ma/ZqVXnRrHnMN7/xjmNnrd
	Vkt+f/H/7oBmfj9bzzZsM3watw5fdP2TQOUBsiY6pH5yv0Y/VdG/jc2aJZOBslAhm8k=
X-Gm-Gg: Acq92OEc5OrTK5gioVgrKIXxT/nAjUXEuUDYvXr+0XXFuT94j2liEOfvbn4EA81NCf1
	uAAS7bgnfY4LsbK5/cO+oz1VemuoFd7P/loapzyG6Clu/oLEbSlJXO+5X7zqBWAMbaTO9xSI2PK
	vafNGGX+XCTeflDR9CbjgI9GC6aZPmLCmC75QxTOLFkb7JlUVXYlFLzKYftrfwsKnDnVzyljnim
	4eEDV0Vry22UBblT1Hv1DAg60GJbz37Fzz9fFlXqtIunVRKI9SILEZyl3cwHpju3jHfsuCZ9eXO
	z7Ks8qQTvWRgH0Zi4niSj1Yvo6OS8SiZNEg+9wKRENa04rPU3sNmam0/hVixrCe6Gf9Ut9v+pMC
	rIwVu+Sw6+0vd/aS0f0Ul5+OJ+01LFpX/PE0Y7pZzfcDRVeOHLK08ZEtI3ffd3+GTg+8RbrLpYe
	7kR2xYCh0mokXLVJwvyn1dQgIn5xt2Q3K03rHpidJe74kG+NCzeia0cHiGatuOBBByEG9Oox58m
	iCsTFZd2P1umYz8
X-Received: by 2002:a05:620a:4886:b0:915:9efe:6dd8 with SMTP id af79cd13be357-915a9db8256mr3196001885a.42.1781016467473;
        Tue, 09 Jun 2026 07:47:47 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a411333sm2254245885a.46.2026.06.09.07.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:47:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWxk2-000000025BT-2DH0;
	Tue, 09 Jun 2026 11:47:46 -0300
Date: Tue, 9 Jun 2026 11:47:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20260609144746.GL2764304@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aigYbK12D8uKQvJF@arm.com>

On Tue, Jun 09, 2026 at 02:43:08PM +0100, Catalin Marinas wrote:
> On Thu, Jun 04, 2026 at 02:09:39PM +0530, Aneesh Kumar K.V (Arm) wrote:
> > This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
> > dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
> > are handled consistently.
> > 
> > Today, the direct DMA path mostly relies on force_dma_unencrypted() for
> > shared/decrypted buffer handling. This series consolidates the
> > force_dma_unencrypted() checks in the top-level functions and ensures
> > that the remaining DMA interfaces use DMA attributes to make the correct
> > decisions.
> 
> Please check Sashiko's reports, it has some good points:
> 
> https://sashiko.dev/#/patchset/20260604083959.1265923-1-aneesh.kumar@kernel.org
> 
> I think the main one is the swiotlb_tbl_map_single() changes which break
> AMD SME host support. There cc_platform_has(CC_ATTR_MEM_ENCRYPT) is true
> but force_dma_unencrypted() is false. Normally you'd not end up on this
> path but you can have swiotlb=force.

IMHO that's an AMD issue, not with the design of this series..

The series is right, a device that is !force_dma_decrypted() must be
considerd to be a trusted device and we must never place any DMA
mappings for a trusted device into shared memory.

That AMD has done somethine insane:

bool force_dma_unencrypted(struct device *dev)
{
	/*
	 * For SEV, all DMA must be to unencrypted addresses.
	 */
	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
		return true;

	/*
	 * For SME, all DMA must be to unencrypted addresses if the
	 * device does not support DMA to addresses that include the
	 * encryption mask.
	 */
	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
						dev->bus_dma_limit);

		if (dma_dev_mask <= dma_enc_mask)
			return true;
	}

Is an AMD issue. We already have an address mask limit system built
into the DMA API, arch code should not be co-opting the CC mechanism
to create a special pool for address limited devices.

The correct thing is to ensure the DMA API is checking any address
limits on the actual true dma_addr_t, not on an intermediate like a
phys_addr before it is adjusted with any C bit. Then it is a normal
low address swiotlb bounce like any other.

I think we can ignore this Sashiko remark, in real systems the use of
swiotlb for 64 bit devices is very rare. Though it would be good to
remove this code from AMD...

Jason
