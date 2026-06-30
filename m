Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206922424C
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782836293; cv=none; b=mRl8ZGHhJhy7kvschIpI+xCuL3yAz65zBmBL9Tdhvim2Bq8E9YQIZ8Kd2cdb8r8W/ygDLd6ZEnjoJmHjFSDVjtArbwlaUhcjk1pXjMKLn44TmAZJmAieWjOCBHhdjJRcISsAkMzUEfnl8CuvA6Gzu7XEOFJKFNUSmk+EtvNUlNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782836293; c=relaxed/simple;
	bh=bEJ6UV/Ig3Wnd5uyEVVm52U1d7GhtJ5Yxfqjfeq0uC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfkdtzJSultIZWzvhyroUk3Q8Qtld5sDtpe/UH1+odEBspsr79vjggJ+lbF527gAHOJKdxCWt6Kwhf1Cy/QNlDz5KQxNmS6vX5PeHDby7flZ8YJp/MwAfWLz56l8kB1GMW4+exXaAPld07177Z/5dmfApcnwv6WJX0O/TW3WnD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lEqNic2R; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lEqNic2R"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so15438706d6.1
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 09:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1782836288; x=1783441088; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rGel1rvdm2vqYO1DEls9OmTRzPQ+QRBZhk43D5aDGso=;
        b=lEqNic2RdtxmX4s3RdtW1PjmHl8aSxgJVvl3jP443fEsF7IT0zep+zFELu8YOHSe4Y
         xXtn2ootebNPP/db90JF3fYcBlqXmE4MSzoG+w/yP1u2HnfYqX4EqmLTi1ups0Nt6eCG
         74mjhhw2bO3XvHjrYDC+ZeT7aJ/h/PSl7jR9soGVTo1uHYNxZgWdU2E7Ms9wfNg4vgfX
         rLLwypdH2iOJlJzXKoFbh2QXnqC+31PrdKdjdztOD71M41ddL37dnSy/XU/V1vFX5Z7V
         N7Di6MB8RJk50J90IAS332ToR6FWmMZQEmPlRmzDr9T0xyKz8iGbEREnPhum3q+XL/mN
         vDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782836288; x=1783441088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGel1rvdm2vqYO1DEls9OmTRzPQ+QRBZhk43D5aDGso=;
        b=ZBMXgk4KrJU+S9E0qGttcOAvSBiWZeG7uAdEYnfEQQmrzNm4NK8k25H28gfhEK7Lpk
         khNftvJRqA8weRLL5j1ukESW7sXvjVOQ3qCZ/4JxGWxOjsyyT4PBNHAvA10NTmfrPKjx
         oupmiU48aWB7MnwZQxn8yRCaJ23w6gOWpq3n5fNmSYeC/rVFwFn6DUtWsJDVxZXf6fMd
         gGDcjtY6RI6HZzp00kM1r3PuKPtlF0lE5dyAKlxuBeXoIgkCHuhfR/dYKndZzxAm4Zo8
         IztYbtTfnJGqsRyGplGtxdOqy+jQ2TnGeAx93jDL/ZRBz3NZn/Yb8MpQW+04cy6gM4+5
         ep/A==
X-Forwarded-Encrypted: i=1; AHgh+Rpfoj1HSb77MqijzyY15DQOW/bV93QbsGmWtjc6qJq3i/jFMokW4amm77On6iyfamDohjDoKA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgY2UVWg2fPjaHTvNeHDTPADkuHR1qENn1ueeX3mvVkMoqsCn+
	iMu8MFpOKcY4GY4G9YIps9uevJME37xlEgR4yPE1PNjCetNMxPuxDEgkp1WUq1ZaJcg=
X-Gm-Gg: AfdE7cmnbQb443CqzRoXFTlD/b9J++mq1QSBAm2Of7fhXo2LHwE2iWHcLpx3PlOz9UQ
	XBZAx0FEnI/2BnDaixaXfp9OhElEDMsC0P7nR2PYdH+ZdvGDVJ3gYtNNF/S8sYDKMRHUdvNmWCY
	FtKseaiyBkC18PLGTT2ad1VAvvS8tzXJLBgoOkPfYGGOjf6Fq1YutXZU4WYTJxR5LHX6U6bnYnI
	ZdYH52UuSzmvW1e9czePxU6YxpK0zwQ1z+OPmvKNACSIc66fcOlUEcaZZXGV7ynmmTk4pkTmH7l
	b6T3KQEk5tOd0j+payMH4nv1+Y5JGP+MjCcGxK6exjTYoyrrD0eY7nHSREhlQxvhIY/A50NQIql
	qplmSj/uOWw4o1DQpLdy1IgH/gXxGePMmdzYrAvcYM7D4wWmjtoMLpJzv7atPKhkdcLbKvT3+qS
	XTzU8OA5TxdkvmQTtqEXvgpsvhXFf/+OZozh1JdfprWsdXondQtq5TBlR+DtAKcCBNCWo=
X-Received: by 2002:ad4:4a6e:0:b0:8f0:1b69:25d2 with SMTP id 6a1803df08f44-8f1ba1b1e7bmr44221716d6.23.1782836288213;
        Tue, 30 Jun 2026 09:18:08 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f24723defcsm15060566d6.49.2026.06.30.09.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:18:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1web9x-000000028Ii-0dcm;
	Tue, 30 Jun 2026 13:18:05 -0300
Date: Tue, 30 Jun 2026 13:18:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
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
Message-ID: <20260630161805.GJ7525@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com>
 <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca>
 <d4ef9a9f-18d9-40e1-9d02-87aeb9cb6540@amd.com>
 <20260619120309.GI231643@ziepe.ca>
 <9f20ce61-1edd-411e-a7c3-be541fb89cb4@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f20ce61-1edd-411e-a7c3-be541fb89cb4@amd.com>

On Mon, Jun 22, 2026 at 10:58:23AM +1000, Alexey Kardashevskiy wrote:

> > I think it was a big mistake for the AMD SME stuff to overload the
> > decrypted/encrypted CC stuff which should mean shared/private in a
> > guest context to also mean things about physical memory encryption in
> > the host. It is really confusing.
>
> It is a bit in the PTE which says "encrypted", what do you mean by overloaded?...

Encrypted meaning I'm using DRAM encryption on the host and Encrypted
meaning this page is private and inaccessible to the hypervisor are
very different things with very different requirements and is
confusing they have been overloaded in Linux :(


> > The SME side is just a bad arch choice, the real world doesn't work
> > well if you set high address bits in your dma_addr_t. I think AMD
> > needs to use those restricted swiotlb pool where it allocates this
> > very special "SME Disabled" memory that will have a low
> > dma_addr_t.
> 
> The generic __init iommu_subsys_init(void) calls
> iommu_set_default_translated() if CC_ATTR_MEM_ENCRYPT (==force the
> use of IOMMU) and eliminates the bouncing by default, pretty
> much.

Sure, I know, it is a gross solution to a self inflict error.

> We (AMD) do not really want to force Cbit in DMA handles and
> it is not happening unless "iommu=pt".

Lots of real HW won't work will because of this, so yeah you pretty
much have to. But also there is HW that is fine, like you can use a
mlx5 device and it will handle the C bit just fine.

It is pretty hacky to globally force the iommu mode because some
devices end up not working.

> > Then alloc and bouncing will get memory with a suitable
> > dma_addr_t. This has nothing to do with force_dma_unencrypted() which
> > is only a CC guest concept and nothing else in the OS should ever
> > touch decrypted memory.
> 
> True.
> 
> Although, with "iommu=pt" enabled, dma handles from swiotlb should
> not have Cbit so these swiotlb pages have to be unencrypted.

That is how it should ideall work, in this case the purpose of the
swiotlb pool is to provide low dma address memory because the device
cannot reach the normal linux dram addresses.

> As you mentioned in another mail in the thread, DMAing to
> unencrypted memory with mem_encrypt=on make no sense security
> wise. 

Yes, pretty much.

> May be enforce either mem_encrypt=on or iommu=pt is allowed at
> the same time but not both? I am worried though that some weirdo
> still has a use case for it.

Arguably it should be done per device. The problem is the iommu layer
doesn't know what the dma mask is until the driver binds so it can't
detect a device that is unable to reach any dram and switch away from
identity automatically. That would be much cleaner.

> > > I am looking for a way to set up my "sev-guest" device such as when
> > 
> > Whats a "sev-guest" device?
> 
> It is a platform device, presented in SNP VMs as /dev/sev-guest and
> the guest userspace calls ioctls on it when it needs VM attestation
> report/certificates/etc.
> 
> The sev-guest driver makes calls to the HV (GHCB protocol) to:

> 1) get report/certificates/measurements from the HV <- this is done
> via shared memory as the HV writes to it;

> 2) asks the HV to get the digests from the PSP <- this is done via
> encrypted memory (buuuut it is software encrypted and as far as the
> hw is concerned - it is shared - no Cbit, no RMP - these buffers
> contain plaintext headers of the PSP requests and cyphertext of the
> request/response body).

Ok, but here you have overloaded the word encrypted again :( Decrypted
memory containing ciphertext I think you mean

> > > dma_alloc_attrs(snp_dev->dev,...) happens, it allocates a page from
> > > the shared swiotlb pool (with no actual bouncing) and there is no
> > > obvious way to trick the DMA layer into doing that.
> > 
> > Why do you need this?
> 
> /dev/sev-guest uses only shared memory (from the HW standpoint), and
> it is normally lot less than 1MB. If hugepages are used, then today
> it allocates 4K pages (they come encrypted and likely backed with a
> 2M page), the driver converts them to shared to make that GHCB
> call. The conversion smashes backing 2M page to 4K pages (+RMP
> +IOPDE as there is possible ongoing DMA), which is a problem (I have
> mentioned it as "TMPM" before - a hw/fw helper to do the smashing).

Okay, but this has nothing to do with sev-guest at all, and should not
be solved uniquely for it.

The DMA API in general has a problem spraying allocations all over
system memory and fragmenting the RMP/GPT/etc and yes it needs a
solution, but it should be entirely in the DMA API and have no
special involvment with sev-guest. sev-guest should just make coherent
allocations and use them in the normal way.

> The idea here is that if swiotlb is already shared, the sev-guest
> could use that memory pool.

dma_alloc_coherent using the swiotlb pool instead of allocating and
converting in general is a reasonable proposal, IMHO. Again, nothing
to do with sev-guest.

Jason
