Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC1D40F8F4
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769829; cv=none; b=sXHHPVabWRuVRk3cBN8dI6ePuBmuQ7FuuLsA5vqx+Aud9HB88jQibo7MpzNZsw3/7P5g6r0Jn1eBSWXZeGvefa1ZCS6mcS4NjvLp+QhzYsva5EJNgVLLEgIXufhnd9267aCYg+kExdMjkmkBH/2i9WbkWBwTZW9mpCIHt/b6VoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769829; c=relaxed/simple;
	bh=G87smce+vNuHo88yX9surKXdFHW5En45v4bRTrGHlSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMdoBFEO+TKAPZbKoEV8kYRcu6m1Ql5KHL30Va16W7h8V/ir8h2t7XTVjZOl08GK4r3OiHN2Q2Z+znlT2zbQSw8D1W67jRYerm5aiJ1/uWYmdk2ifBGM+EGwHTlWM3XH4nofwJAVNnHCoZ2XWdA+dNuvsaMLUs6RpdC6zt9XCOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d3kUE0AZ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d3kUE0AZ"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a8bd9a881eso5965e87.1
        for <iommu@lists.linux.dev>; Thu, 14 May 2026 07:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778769826; x=1779374626; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i68MgXr4Uit+MmJrWGtw9NAg1hDWWWOTovHHIC3ey2A=;
        b=d3kUE0AZ1RNERfAydtJ5UpB0RjTOWcp5V8oiLzvHPG7RP6h7OB0MNwSSYLT+H28x62
         Jg4CVLn/48wHlplW+DMwL0FQ9F1t0s9T+heeBBYBfllit8k1wBF0mhvDZH60z9tjnJCr
         UiR4lKyIz1UtXI3qNss9DmAk0mnhZ9KEhvi31HYU4WAw/dQBWVp0hYB980WHZPEMorGO
         6lK+IKp/kJEQAvLt63niNJ7QXN4UeyYprgDvsrHKweI8GiGXuOrtMucyEAmhkTK6liJ8
         MIC1Y3XSfnGl+7QMmse5EgEE2xQOp+u15E30QOcHis6oO0h9HXQNSdDrB+lYAmauCigc
         2ZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769826; x=1779374626;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i68MgXr4Uit+MmJrWGtw9NAg1hDWWWOTovHHIC3ey2A=;
        b=emow7X15HQTTIT6cpoQNAuFbCY8A+FnusrKnFBR3AHPlcGpAmYrCJdp16oJJbuircp
         3wWuT2H1kfBqjexHRVlzm+h/6P3eXrFlF2KPdUYxw8+lKT5KdD3gELGTCM+zrPmrt61/
         L80N82F8QYrMQtyzn8iJ1YQX7G/xO0jOc8Kt40uwQjQeOC61dKxomB2fVMxE6m2s1UXw
         InPGVgx9VzGRxLC8orwjndLZczuSCsmeuOEhwdxGsBpk/goKPNd05q1EKRpozwtLx8cr
         Jb65vVn52yVDx8T0Dn3z2rAXcSnO2MmHn0FgKXGFLIAzis5brC3KyCPBHhnxk5A9Tkcq
         vxRg==
X-Forwarded-Encrypted: i=1; AFNElJ8kIHs5PGfMphUx3cuM2uyoPG5ubzDGHgY+VpCi1+JEJeZDu2M7lKTTLRTpgG+dCNGX/TeuqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeRMQHKEsYi575tKTW9Pz4sltPMTXBpCkYUbwO17Q6x0nBKeMX
	rxgPUi3TcZsVleQioK5Km3wob09sR6pJzmPrTeIa/jZ4W3OQuGcq2mevKjYZqFB/7w==
X-Gm-Gg: Acq92OEVr1spfQYpNU7wt0blTAb6A4KhzP3laNH/QpVdXXzKAoOu4btpU2NS3lJZZgN
	4Qpvd1HsUE5mv7My6iIoOKfMzmZJJW0U8eiCT1w20Kb+9XYtbCBVt7g6p4kGE912G9tUH4p+r98
	4FDhzJG1qto4fqfrD7o+tKGRVxPu45+XtixHKYMQ1+VOt6VmkzpWRXp9oSpDy89tV1bsnu97iR2
	R/gvIkjn7i1dpq8zF0vatWu4XOS9CE1HFS39rSi4RWHwNjElgBi3kSEDW4xvFWNaBUWmLCwLSij
	Jmi30OktM/wo9J/SEuV9cbvF6grQNRrPM86VSgdnc6XKAsj6bFRzEO83D+jpqCRUrp2af/D3lFX
	uvPJ7iRo01f/yioQFldr/Co8ex1mHY4WB0fP4xXXpblGgBDUqZqiTmoTn/oighsiBIFyPnDDiad
	Z2XJ6HZY5Xkle9viPKNM3nzQUprUvxpJT8Qlt2UftSsius6vPVvDuVrwQKtfXt8Q8wuRB1
X-Received: by 2002:a05:6512:66c2:20b0:5a7:478a:e6e1 with SMTP id 2adb3069b0e04-5a9282ddf8amr143960e87.5.1778769825580;
        Thu, 14 May 2026 07:43:45 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3945c885856sm6691881fa.5.2026.05.14.07.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:43:44 -0700 (PDT)
Date: Thu, 14 May 2026 14:43:39 +0000
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
Message-ID: <agXfm3mS_M3fvRrN@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <20260513172450.GR7702@ziepe.ca>
 <agW2lzJI-20DyJVe@google.com>
 <20260514123529.GZ7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514123529.GZ7702@ziepe.ca>

On Thu, May 14, 2026 at 09:35:29AM -0300, Jason Gunthorpe wrote:
> > > How will pKVM signal what kind of memory the DMA needs then?
> > > 
> > > Does it use set_memory_decrypted()? How can it use
> > > set_memory_decrypted() without offering CC_ATTR_MEM_ENCRYPT ?
> > 
> > pKVM (hypervisor) doesn’t signal anything.
> > The VMM when running protected guests will use restricted dma-pools
> > for emulated vritio devices in the guest, which gets decrypted by
> > the guest kernel and hence shared with the host kernel, and then
> > traffic is bounced via the pool.
> 
> That really does sound like CC and set_memory_decrypted() to me..
> 
> > It’s also worth noting that bouncing here isn't just about visibility.
> > Because memory sharing operates at page granularity, bouncing sub-page
> > allocations through the restricted pool prevents adjacent, sensitive
> > guest data from being exposed to the untrusted host.
> 
> That's a somewhat different problem, we have the dev->trusted stuff
> that is supposed to deal with this kind of security. We need it for
> IOMMU based systems too, eg hot plug thunderbolt should have it.

I see that it is used only for dma-iommu and for PCI devices.
However, I think that should be a problem with other CCA solutions
with emulated devices as they are untrusted. As I'd expect they
would have virtio devices.

> 
> Then CC issue is more that the DMA API can't decrypt random passed in
> memory because doing so often requires changing the PTEs pointing at
> the page so it would break everything if done transparently.
> 
> > > > I believe that the pool should have a way to control it’s property
> > > > (encrypted or decrypted) and that takes priority over whatever
> > > > attributes comes from allocation.
> > > 
> > > We should get here because dma_capable() fails, and then swiotlb needs
> > > to return something that makes dma_capable() succeed. Yes, it should
> > > return details about the thing it decided, but it shouldn't have been
> > > pre-created with some idea how to make dma_capable() work.
> > 
> > That sounds neat, but at the end we have force_dma_unencrypted() in
> > dma_capable() which is just hardcoded to true/false by the platform.
> 
> For now, the next step is it becomes per-device and dynamic during the
> device lifecycle.
> 
> > How is that different from having the state static by the pool?
> 
> statically attached pools to the device are not so flexible when
> devices have dynamically changing capabilities..

Pools can be per-device also. A device can have mutiple pools with
different memory attrs, which then can be matched by the DMA code
at runtime, it's not as flexible, but removes some complexity from
the guest code.

> 
> > > If dma_capable() can fail, then swiotlb should know exactly what to do
> > > to fix it.
> > 
> > dma_capable() returns a bool, I don’t think it can know what exactly
> > went wrong (based on address, size, attrs, dev...)
> 
> Yes, but I think the design is swiotlb is supposed to re-inspect what
> is going on against the limits dma_capable checks and then select the
> correct remedy..

I see, but that’s not part of this series, and probably would require
some rework so dma_capable() can return an error code (ERANGE, EPERM...)
so that caller can deal with that.

> 
> > While we can debate the aesthetics of the setup , this is
> > the exisitng behaviour for Linux, which existed for years
> > and pKVM relies on and is used extensively.
> > And, this patch alters that long-standing logic and introduces
> > a functional regression.
> 
> Yeah, Aneesh needs to do something here, I'm pointing out it is
> entirely seperate thing from the CC path we are working on which is
> decoupling CC from reylying on force swiotlb.

I am looking into converting pKVM to use the CC stuff, I replied with
a patch to Aneesh in this thread. However, I need to do more testing
and make sure there are not any unwanted consequences.

> 
> > We can address this by either adjusting this patch or by changing
> > pKVM guests to be more aligned with other CCA guests which is
> > something I have been wondering about if it would help reduce
> > bouncing.
> 
> Every time I look at pkvm I think it is just ARM CCA with a different
> design and no access to the unique HW features..
> 
> > > If we can make that work then maybe the flows are designed correctly.
> > 
> > Mmm, I am not sure I understand this one, shouldn’t the device also be
> > notified about the switch in memory state, if it expects to read/write
> > decrypted memory, how would that work if the kernel changes it to an
> > encrypted one?
> 
> Nothing on the device changes. In a CC world we put the device in a
> T=0 or T=1 state before the driver loads and the expectation from the
> DMA API is that the device will only use that T=x DMA type during
> operation.
> 
> A T=1 state device can access all of memory, private or shared. Any
> information the platform may need is encoded in the dma_addr_t or in
> the S1 IOPTEs.
> 
> So we never need to tell the device driver what kind of memory the DMA
> is targetting, and we NEVER expect a device in T=1 mode to have to
> issue a T=0 DMA to use the DMA API.
> 
> In a pkvm world it should be the same, the S2 table for the SMMU will
> control what the device can access, and if the SMMU points to a
> "private" or "shared" page is not something the device needs to know
> or care about.

I see that's because dma-iommu chooses the attrs for iommu_map().

In pKVM, dma_addr_t and IOPTE are the same for private and shared,
so nothing differs in that case.
We don’t expect pass-through devices to interact with shared
memory (T=0) at the moment.
However, I can see use cases for that, where the host and the guest
collaborate with device passthrough and require zero copy.

One other interesting case for device-passthrough is non-coherent
devices which then require private pools for bouncing.

Thanks,
Mostafa

> 
> Jason
