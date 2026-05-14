Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC5E2D061D
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762134; cv=none; b=Jgao2pcWDSfwGp5Ln1PEt0790e5DwvrrkBKiuXQuse+EJi02zpXgGe6gtVCXkbFllcr+qTFhrqPFZEdYHFs54QpSBt8yWf2PN3z2UDaAyVGX2kKaYJu9X9ElV0yyOEnxMoPL4bxCVjGC4ZDQ1gSo6ajf0GbcAxAoXEkP4Inpi5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762134; c=relaxed/simple;
	bh=DlRTtK+pet5LFFKBQ/8FceU5SmBcugQNcR+otGWnOYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2sGJHe2dz8ZPM2oYZCupgvbkNtJrq2R8yF9wQnIyqgMYqFg1gTbQhWALz6W3xoC7qtfXni0aF50Mj8fFUkXKLswRbj+TvTcb7EvXYsCxvASvqw/LSNVqxJCJz9GJfulWZkddVX//zeeZ+oGXKlAZTwGybm4Ntl9p9OJlTF5BZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nS7U2/95; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nS7U2/95"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-911449d9d03so44255585a.1
        for <iommu@lists.linux.dev>; Thu, 14 May 2026 05:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778762131; x=1779366931; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x0syXDbvsxMHU2qFtHkGrYSSCi/zfIXRFYXzTsoQZCg=;
        b=nS7U2/95lt3cY1+yNjv1ppKmZwxfDMR6isknSJVDNRt9GhfT9G1ZSVXivg3nawOqKE
         jckqjx1NVHP/6TVmyLyLNwukpJJdXmPu5XXFaUBLCxsYHfGTsg6IuE2fCpu4mjH2ny+U
         +44Q1fWAUaPaAkI9Iq7z/8GmnZ3ei1UgtS9qtXdyMdeRas4Fu7QiJaTjWKX/LDXH3qyv
         poWikQbJpc8Rfslh7YwZpxO5akKwsVaFwSDkNDzak73VoEvkvFeeNYBNcsskTovOl7D0
         KEn1zfbM8R7Fz2MKkCpdFCZ3cY4kxzAtKlMNNnqdk7XzVqudUb5Z8CAwEBaDXLAhFizW
         KnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778762131; x=1779366931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0syXDbvsxMHU2qFtHkGrYSSCi/zfIXRFYXzTsoQZCg=;
        b=EFfXO85f2YR2tjWSRtbSoHfakItqy6mOUoS/SsUtbqu8xi3OakawJRLaKC6JMzxePI
         ADkk8GL5MaYe0lFKl8PUE0gMT++GVT1RH3pK6R+6hh3o5uvve7SnieOqBCmZLECl66/r
         zyERwXzjnEqnzg/yJxJyVIV3i/MV6CbQraBSJfgKyzjzAV0u2ZO4N565lG4woStWuL6l
         bsjTK6gXXhFdo7GDS9QsYBvelAMiTT1trnGYg+MYDTZoSyAsfbnQs+E59J55aRE+Kz6+
         rHsx/EDY8h9/QPQIqcTZxBZc2Qlqq6wbD3iLVjpZjuT69HdB5iCCvuKcvfjQD2RIofz8
         Rgtw==
X-Forwarded-Encrypted: i=1; AFNElJ9xno6Fq6KWpfRjq5sEJp7ye+8YV0xqfxpKz1NxTDTaJt+9gizS6nnDraI7mWZsS02lDXK02A==@lists.linux.dev
X-Gm-Message-State: AOJu0YztwSC2kZAk/2sycamLXl69IduPbnWmrx07cPhAJ3R3kqPYh89b
	C2GrNK1Xuf+KaaJKXdC5R4EwxuiUrexXrMQZhgChL/OuEN+LrYgpZDzSyENaQfHVrn0=
X-Gm-Gg: Acq92OHSwbFB9chFwqZBPwblPmq/zirMRo9jVe45rbgnPtVBCtqAmrC9l61XNQ+0gta
	qYi2Zm8gszbKa2faOaue+gD6aS+vkIcdxezZ0pS3xgm3sruI9XGvPXCx9R3kBxnymlWMGFqIGbD
	6Mozj6rUigkQ8r653F5boeTIQThbxNr49o08WU13PqAjQGN9joox5/dWWuExyS0LROQPx1rV8Ap
	yCSuWuowv2wxme1olIyC7E2ERwyQqNrMWPgbO8ojUrgFSo6woENvoqhKqGmIitwtpuTsDtZCsOE
	UeJGzfh6GA8KWf1+r3FH9DBE7SCljXrCeE+oD6kpT44A1xa1GWOGUEF++nQPSbkxGJt5+Bv3aWg
	f8ZmdBvs+792Vof2/9Gwfrzebbjxnzg1kUtuCGkd5TS0r0FSpWQtVnTmjK3tGhdKw3zND2DuwIL
	hJKJJHSZfv0M8TvWAfxuGzTI7esgfdc265DMPwRCCUJgDt5LVQPRzaLRwbrLyor2xDeFiaGBWqu
	Fz4Ww==
X-Received: by 2002:a05:620a:4114:b0:8ef:c472:cd71 with SMTP id af79cd13be357-90facfa13d8mr999953285a.31.1778762131005;
        Thu, 14 May 2026 05:35:31 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba182540sm234520585a.4.2026.05.14.05.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 05:35:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNVHl-00000005B3F-3Oru;
	Thu, 14 May 2026 09:35:29 -0300
Date: Thu, 14 May 2026 09:35:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
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
Message-ID: <20260514123529.GZ7702@ziepe.ca>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <20260513172450.GR7702@ziepe.ca>
 <agW2lzJI-20DyJVe@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agW2lzJI-20DyJVe@google.com>

> > How will pKVM signal what kind of memory the DMA needs then?
> > 
> > Does it use set_memory_decrypted()? How can it use
> > set_memory_decrypted() without offering CC_ATTR_MEM_ENCRYPT ?
> 
> pKVM (hypervisor) doesn’t signal anything.
> The VMM when running protected guests will use restricted dma-pools
> for emulated vritio devices in the guest, which gets decrypted by
> the guest kernel and hence shared with the host kernel, and then
> traffic is bounced via the pool.

That really does sound like CC and set_memory_decrypted() to me..

> It’s also worth noting that bouncing here isn't just about visibility.
> Because memory sharing operates at page granularity, bouncing sub-page
> allocations through the restricted pool prevents adjacent, sensitive
> guest data from being exposed to the untrusted host.

That's a somewhat different problem, we have the dev->trusted stuff
that is supposed to deal with this kind of security. We need it for
IOMMU based systems too, eg hot plug thunderbolt should have it.

Then CC issue is more that the DMA API can't decrypt random passed in
memory because doing so often requires changing the PTEs pointing at
the page so it would break everything if done transparently.

> > > I believe that the pool should have a way to control it’s property
> > > (encrypted or decrypted) and that takes priority over whatever
> > > attributes comes from allocation.
> > 
> > We should get here because dma_capable() fails, and then swiotlb needs
> > to return something that makes dma_capable() succeed. Yes, it should
> > return details about the thing it decided, but it shouldn't have been
> > pre-created with some idea how to make dma_capable() work.
> 
> That sounds neat, but at the end we have force_dma_unencrypted() in
> dma_capable() which is just hardcoded to true/false by the platform.

For now, the next step is it becomes per-device and dynamic during the
device lifecycle.

> How is that different from having the state static by the pool?

statically attached pools to the device are not so flexible when
devices have dynamically changing capabilities..

> > If dma_capable() can fail, then swiotlb should know exactly what to do
> > to fix it.
> 
> dma_capable() returns a bool, I don’t think it can know what exactly
> went wrong (based on address, size, attrs, dev...)

Yes, but I think the design is swiotlb is supposed to re-inspect what
is going on against the limits dma_capable checks and then select the
correct remedy..

> While we can debate the aesthetics of the setup , this is
> the exisitng behaviour for Linux, which existed for years
> and pKVM relies on and is used extensively.
> And, this patch alters that long-standing logic and introduces
> a functional regression.

Yeah, Aneesh needs to do something here, I'm pointing out it is
entirely seperate thing from the CC path we are working on which is
decoupling CC from reylying on force swiotlb.

> We can address this by either adjusting this patch or by changing
> pKVM guests to be more aligned with other CCA guests which is
> something I have been wondering about if it would help reduce
> bouncing.

Every time I look at pkvm I think it is just ARM CCA with a different
design and no access to the unique HW features..

> > If we can make that work then maybe the flows are designed correctly.
> 
> Mmm, I am not sure I understand this one, shouldn’t the device also be
> notified about the switch in memory state, if it expects to read/write
> decrypted memory, how would that work if the kernel changes it to an
> encrypted one?

Nothing on the device changes. In a CC world we put the device in a
T=0 or T=1 state before the driver loads and the expectation from the
DMA API is that the device will only use that T=x DMA type during
operation.

A T=1 state device can access all of memory, private or shared. Any
information the platform may need is encoded in the dma_addr_t or in
the S1 IOPTEs.

So we never need to tell the device driver what kind of memory the DMA
is targetting, and we NEVER expect a device in T=1 mode to have to
issue a T=0 DMA to use the DMA API.

In a pkvm world it should be the same, the S2 table for the SMMU will
control what the device can access, and if the SMMU points to a
"private" or "shared" page is not something the device needs to know
or care about.

Jason
