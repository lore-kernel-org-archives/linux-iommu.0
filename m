Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE4C2853FD
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759327; cv=none; b=l9cOwdcX46+pQXkVTuBrHW+3bHdwftAcjqT6bwQyD/R4IPFA9+TY1qAOjNI9qkXupczAcj4E2l+rZFdK9nDaoc2OfiYFr+2pBJzBnoT1ziXCJCqDca1jTOQoPFNCJCmitZjDJqLPiVTEstQG2mEavwSoOGYbufRQi2VLmKa1pgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759327; c=relaxed/simple;
	bh=+VGeKixg0SpM8WcAOnGgarHeA/v+VDVyzEXlkLEx2+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npwce9JOOLBALr+9PaB458YZB86jzuJ1QnG9tdIokO6O2ISsWVSe7qyBSyRUVTUasIB9gtGNa7fQNUOMWzfzvZtStmlEV1s52VgJaBA4y7xMzDpAyAiFeh9eeosEVONuf6cwDsNBiiguUYPZyk0Yr6QGCfZLrxzMF0CLDyVVu6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wkx17Xt4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wkx17Xt4"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso93445e9.0
        for <iommu@lists.linux.dev>; Thu, 14 May 2026 04:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778759324; x=1779364124; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rg6bmFDt84HgfdmHQ5rMQfe5qNs0Lmh5zrMOKqozbmM=;
        b=Wkx17Xt4fhIxqXZITUEYDBMPyQR8IRrJ9KCFMt8rwPbUM3CKWsCqcHffyqMOtjh706
         BOi4NMW/LlgigkCBREdcfjKq2YuvFVDQjzHcmuKJxdxBz2mWqJqQZY6IaC+vC61ZVZKg
         4xjZl2m10LkFDp2R0H50PQz2sMowmkLCSBUodey0Je/NODFBJyb8JMTD09nzCoo2Mn5W
         wzDXkwVNxvxp0HXOTGFj+BtV5QmVB6tfmuwHtMiaysztRITkMUUYfa6fnzO2vnyXiHSB
         exTbcRvSrKQTG0Zrx7fuAs7TJ8LJqjV2N6w0SGXbG4nC6yfsmXATkZJtSwjpY0faxkyw
         pCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778759324; x=1779364124;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rg6bmFDt84HgfdmHQ5rMQfe5qNs0Lmh5zrMOKqozbmM=;
        b=cR9Kw0aswdLoLDz+LB4UjNSy5SajULcJpIHslBDJPJawRYXIDSST1E6nRGJwWqhLE5
         myhOYbyFC/rPrBsBCWAFA5Urhr7AvXDZzF7L/yaQ7Dmuiyr6RDsjT/1G0S+8uvxbSBDl
         8nYSeDF4cMoxnubtrn3q6K7eIOsade1JBx9+Xp5lN6nioEAhJWPjx9EMD6G6pxS+wM7/
         FS9lNhK4aHc35+XIxylYaFwipizZ1h54b1rIqeSugfKpu+wIUQb6iSX34i8y1MW3rZce
         FyqN2ZUAaRaavM34gb6RZiCtxjQsv7RSMyZmX7qZtrpIqGlJukB8g2xKIMd0i4VGOnD8
         ZEIA==
X-Forwarded-Encrypted: i=1; AFNElJ/H6OgvS77lWX/5R2ytkWpVeNd6eMjh1kXdUwuFWi5+MC5bskc/OaoOhkk+J429fCQDCXnrNg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfgBszb75ViBDgjxIANy99coSJW7uBgcRDJ1NlaiL2NqqPlXV1
	nMc1zP9OcGEaO3k+PT94C0HLJvhQnTt9aVpt1qTh2eWkc655ISAk8hI5YZKOv5Ai5g==
X-Gm-Gg: Acq92OHexo/mADCeyI/R15J4Nciznz8sIqxfX7FG5Xd923Jl28lnYwdlgRb1RY9SFQg
	1SKH2FlQMHU+wYG0XrnMAKGbcDQWfv0BzxHbRjF/uvAACbxGjB7pDXBFLEM/KXcZBENfbp13j0R
	ERQixNRv+Npy/vRPU08l9RE7ggPd5lfejDbPWYbviL86WDdCAFBj0d63JcHwCbxxMjyHIk7osm1
	rGAqRhycBPvVhF7iYCgzcY9IyvzpdGJ4mHWB0r6Ae8DEnTmbbO4ZaqzuY1QTXTMDF1b7yM+QtxL
	fXM5Du+8pD5KM3W0WvpDpNMIWwgMZjRhRdE5Bedh3L/JpNEUVSr5t27nXtkcFnA1rH1PoLSv4Zu
	8OCPLVYKgeaCY+eJOYDF+hLFzXWfPBRy7UkJ5bt39fZg278KnWo9XMkyGPypbhunXpXev3L4uQW
	21sFhhuBeHQ+LLKz6qelzDRisc+1NOKRlCXBthLcLvmIZgNm+EQRbD0eHo+0l9kfMzFU4=
X-Received: by 2002:a05:600c:a30a:b0:475:d905:9f12 with SMTP id 5b1f17b1804b1-48fd6bcf0b7mr839965e9.4.1778759323668;
        Thu, 14 May 2026 04:48:43 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdb26ac98sm47844535e9.2.2026.05.14.04.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 04:48:42 -0700 (PDT)
Date: Thu, 14 May 2026 11:48:39 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
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
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <agW2lzJI-20DyJVe@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <20260513172450.GR7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513172450.GR7702@ziepe.ca>

On Wed, May 13, 2026 at 02:24:50PM -0300, Jason Gunthorpe wrote:
> On Wed, May 13, 2026 at 02:27:14PM +0000, Mostafa Saleh wrote:
> 
> > > +		/*
> > > +		 * if platform supports memory encryption,
> > > +		 * restricted mem pool is decrypted by default
> > > +		 */
> > > +		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
> > > +			mem->unencrypted = true;
> > > +			set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
> > > +					     rmem->size >> PAGE_SHIFT);
> > > +		} else {
> > > +			mem->unencrypted = false;
> > > +		}
> >
> > This breaks pKVM as it doesn’t set CC_ATTR_MEM_ENCRYPT, so all virtio
> > traffic now fails.
> 
> How will pKVM signal what kind of memory the DMA needs then?
> 
> Does it use set_memory_decrypted()? How can it use
> set_memory_decrypted() without offering CC_ATTR_MEM_ENCRYPT ?

pKVM (hypervisor) doesn’t signal anything.
The VMM when running protected guests will use restricted dma-pools
for emulated vritio devices in the guest, which gets decrypted by
the guest kernel and hence shared with the host kernel, and then
traffic is bounced via the pool.

It’s also worth noting that bouncing here isn't just about visibility.
Because memory sharing operates at page granularity, bouncing sub-page
allocations through the restricted pool prevents adjacent, sensitive
guest data from being exposed to the untrusted host.

> 
> > Also, by design, some drivers are clueless about bouncing, so
> 
> Oh? What does this mean? We take quite a dim view of drivers mis-using
> the DMA API..

Maybe clueless is not the right word, I mean when virtio drivers use
the DMA API they don’t know whether it’s going to bounce or not as
that is decided by dma-direct (and in other cases by dma-iommu,
but not for pKVM).

> 
> > I believe that the pool should have a way to control it’s property
> > (encrypted or decrypted) and that takes priority over whatever
> > attributes comes from allocation.
> 
> We should get here because dma_capable() fails, and then swiotlb needs
> to return something that makes dma_capable() succeed. Yes, it should
> return details about the thing it decided, but it shouldn't have been
> pre-created with some idea how to make dma_capable() work.

That sounds neat, but at the end we have force_dma_unencrypted() in
dma_capable() which is just hardcoded to true/false by the platform.
How is that different from having the state static by the pool?

> 
> If dma_capable() can fail, then swiotlb should know exactly what to do
> to fix it.

dma_capable() returns a bool, I don’t think it can know what exactly
went wrong (based on address, size, attrs, dev...)

> 
> If pkvm wants to use the hacky scheme where you force a swiotlb pool
> configuration during arch init with force swiotlb that's a somewhat
> different flow and, sure the forced pool should force do whatever it
> is forced to.
> 
> But lets try to keep them seperated in the discussion..

While we can debate the aesthetics of the setup , this is
the exisitng behaviour for Linux, which existed for years
and pKVM relies on and is used extensively.
And, this patch alters that long-standing logic and introduces
a functional regression.

We can address this by either adjusting this patch or by changing
pKVM guests to be more aligned with other CCA guests which is
something I have been wondering about if it would help reduce
bouncing.

> 
> > And that brings us to the same point whether it’s better to return
> > the memory along with it’s state or we pass the requested state.
> > I think for other cases it’s fine for the device/DMA-API to dictate
> > the attrs, but not in restricted-dma case, the firmware just knows better.
> 
> The memory type must be returned back at some level so downstream
> things can do the right transformation of the phys_addr_t.

Agreed, I believe that will be needed at least for
SWIOTLB/restricted-dma -> dma-API interactions.

> 
> One of the aspirational CC things that should work is a T=1 device
> tries to DMA from a decrypted page, finds the address is above the dma
> limit of the device, so it bounces it with SWIOTLB to an encrypted low
> address page and then the DMA API internal flow switiches from working
> with decrypted to encrypted phys_addr_t.
> 
> If we can make that work then maybe the flows are designed correctly.

Mmm, I am not sure I understand this one, shouldn’t the device also be
notified about the switch in memory state, if it expects to read/write
decrypted memory, how would that work if the kernel changes it to an
encrypted one?

Thanks,
Mostafa
> 
> Jason
