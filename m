Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C813D6497
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777048764; cv=none; b=oyqqBPxMwZMciMs8vAldPSSBgMp1rb2Zv2PaHigtkPIg3qTKgP7kUd9040v0zOrb6djMsKJNb5TmstXKiX8c61USVkbgv3ttD/MfWgtWLHFG4feMti5mStTI/yuIiNnYKDkHll3B9mCE/nPlDyTxIUbknucHYeX7fSSRnW7CQ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777048764; c=relaxed/simple;
	bh=c7Ret2AWgfDsaIm21hkMMD9rs9MLLV0BuDZ7Xo+ndwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQbHw8mVFc/0b755AwHJX1qmFIu5EK5QGW9twldB2BPV16e3C4QngL8Iq8+Z8K1zbRGa0PX/RaRFYGHMsM+gZC1g927G98duowyMe6uTD65OgAzw6cLZGoZWT00yTcK/SyPDnx8QasqhyqmRErEFYtE4x4tkle01A2FXbTPCAEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lqJoClaJ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lqJoClaJ"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8d6d5e45c43so914792885a.3
        for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777048762; x=1777653562; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=baVqOWXW0W679wCWJSOseh6T7DFu4rt5dV7U28qjPJU=;
        b=lqJoClaJwIPEx//OytQyDeditRKv9F3IM5Z+h3IhyK67nLpe7K6yvHfK15TvQStNoc
         TjJMV3lOMsBnqMUwsMMndfd+B0dHKIkqv8ht6fPqRr4bKc1n7Q9rdqJ+79CaDriYmUon
         AJrw808Ri249WAaEJ8qsb1/0+D1/IbKvVgaD80+j8FWgq+MoQ/ATfMYi2u7E6cr8wd3B
         iXL3Ys6DEU76Ym8IfD4lqVNXlc788sbkgadenaMEAFfWJ9OljhaVGY6WM+ixKHciev+U
         FrTpm2Jx0f8F7GspAc5hU+r1oniHGRblnjGaFiLavd9XudU5PRWBewvE6tBlEDqMZzzW
         aT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777048762; x=1777653562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baVqOWXW0W679wCWJSOseh6T7DFu4rt5dV7U28qjPJU=;
        b=UMMoB5+iYb+3pYR0falKT/r8Hid+eIdNfj9eTXCGjO7vtdb6TdGrKwMqGnGSpqvrVE
         5yWH40DH8UEr1fTMxRHZcN5d/cossAXoXMch3mfTbYCGDOvLEbiJ/mCzc6ly58X1Zeds
         4gQNhLqhUmW+nI9Q0Hr5J/CH8pSrcR1DkNZPDrOZ+DrT8nUOHerxHg01pTZJg3uit7pf
         wniEr/PMjawE5N4Ucx6mDwICT3N8BowQw/EnwXhByFQkN73bZqYS3d2PjP2Q3VUD52My
         hHqK9g/79a0rE7FWgyc8WCOnlpM2RDNhrEJsKQc+4r0RF5Kb3mGZ8jv3ywM7F9Vlf8PT
         /YGQ==
X-Forwarded-Encrypted: i=1; AFNElJ81EuoHMh1QIuoqbLwz042vw252XXQPnRKoCcAEiOZ49Y4f1Fr9H3I4ch0LTPCFye1rHpuyVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMNVUh9eNhhOPg4XG7oQRJvnsHV2EO51oA6/QguyY661Lrdp5A
	2XbvOfWpAp567Ucwk1ToMg79i22jr5QtMeLgBAte8KbYR6vjN1VvectEnDKDDss0pvI=
X-Gm-Gg: AeBDiesuhlQhGXIGOSYBsxh4DR2WX4eMZGaIeqF1UTv/8y8eUGyPoRFQuhD5ElQPmue
	YfB9I5dOMUIfHyN3ral9yWxU68PzRSZYRV0o6DCHPhOxUI7XWKLII4JqzANqrrW/fKUTtkMXsiu
	vbI/hp7eSdmnmZKt+bfiCnx6oT/DeNsFIokhkgRR3SleWonz3K39mGpp/kMtzmWTGzXNf2LNK4j
	zDv62s7BFQd41taZhCN77EEDl3I82A4cLMAInJnWSKQmXs1UkW4CEoq2EECkm69uGARbD+ACwBt
	Vl+tTGHZlRrrh1a3CJBxxmw9olo1d4nzSpLDZtCZEmuB9wp/7uq5X/Lzj8hBVi37/z1Eqr0UUcF
	Qo44cK/h7dEaBvmQJ+N/JglBgKL1w5/hZ4zJ8XxR1u/X83+BJTfGQeP7j7fCbt1ks4NptxKWBch
	haYN68LpX4YN2Vo9HXCUknYZwjbCQ7fVLqMBf/cZuGF7zIvp0cIcFAoZX04fNjEHuAwHxGL6bUV
	v46gioxqOJXm7TOt3yBpNkaE48=
X-Received: by 2002:a05:622a:4187:b0:50b:37a1:a012 with SMTP id d75a77b69052e-50e36c419bcmr479897421cf.41.1777048762005;
        Fri, 24 Apr 2026 09:39:22 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae7fef0sm182965026d6.38.2026.04.24.09.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 09:39:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGJYn-00000003KVv-09ty;
	Fri, 24 Apr 2026 13:39:21 -0300
Date: Fri, 24 Apr 2026 13:39:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com,
	Zeev Zilberman <zeev@amazon.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow disabling Stage 1 translation
Message-ID: <20260424163921.GG3611611@ziepe.ca>
References: <20260422064431.GA49867@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
 <20260422162351.GK3611611@ziepe.ca>
 <aenp6FHzx9rtUQkZ@willie-the-truck>
 <aenqxasLJ8yKYqbT@willie-the-truck>
 <20260423142326.GP3611611@ziepe.ca>
 <aepRy7Gp7Ng85Zr7@willie-the-truck>
 <20260423223716.GS3611611@ziepe.ca>
 <aeuJQW8bGLY-O_vv@willie-the-truck>
 <20260424154256.GF3611611@ziepe.ca>
 <aeuT1-TB6dOT5ZQ2@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeuT1-TB6dOT5ZQ2@willie-the-truck>

On Fri, Apr 24, 2026 at 05:01:27PM +0100, Will Deacon wrote:
> On Fri, Apr 24, 2026 at 12:42:56PM -0300, Jason Gunthorpe wrote:
> > On Fri, Apr 24, 2026 at 04:16:17PM +0100, Will Deacon wrote:
> > > > > > STE/CD is pretty simple now, there is only one place to put the CMO
> > > > > > and the ordering is all handled with that shared code. We no longer
> > > > > > care about ordering beyond all the writes must be visible to HW before
> > > > > > issuing the CMDQ invalidation command - which is the same environment
> > > > > > as the pagetable.
> > > > > 
> > > > > You presumably rely on 64-bit single-copy atomicity for hitless updates,
> > > > > no?
> > > > 
> > > > Yes, just like the page table does..
> > > > 
> > > > I hope that's not a problem or we have a issue with the PTW :)
> > > 
> > > You trimmed the part from my reply where I think we _do_ have an issue
> > > with the PTW. Here it is again:
> > > 
> > >   The non-coherent case looks more fragile, because I don't _think_ the
> > >   architecture provides any ordering or atomicity guarantees about cache
> > >   cleaning to the PoC. Presumably, the correct sequence would be to write
> > >   the PTE with the valid bit clear, do the CMO (with completion barrier),
> > >   *then* write the bottom byte with the valid bit set and do another CMO.
> > 
> > I wasn't sure if you are being serious.
> > 
> > CMO + barriers must provide an ordering guarentee about cache cleaning
> > to POC otherwise the entire Linux DMA API is broken. dma_sync must
> > order with following device DMA. IMHO that's not negotiable for Linux.
> 
> The problem is with concurrent DMA (from the page-table walker) and I
> don't see anything that guarantees that in the CPU architecture. I don't
> think the streaming DMA API pretends to handle that case, does it? It
> relies on a pretty rigid ownership concept from what I understand.

I think you pointed out two things, ordering and tearing.

Ordering is OK. If I write a PTE, dma_sync, then command a device to
use that IOVA the PTW must observe the new PTE value. Otherwise
dma_sync isn't doing what Linux requires.

Tearing is a different issue, if the device uses the IOVA and races
with the PTE write changing it then you say maybe it can mis-read it
with tearing.

However, this race only happens if the PTE is currently non-valid or
being changed to non-valid. Meaning randomly you will be getting an
invalid IOVA event.

In non-coherent mode we don't allow SVA and we don't allow VFIO. Only
the DMA API and drivers open coding things.

For VFIO and SVA, yes, we need the HW to work and properly, userspcae
can trigger invalid IOVA, we can't tolerate a corrupted PTE.

In embedded I suppose you could make an argument you don't care about
it since invalid IOVA would have to be caused by a buggy kernel
driver, it should never happen, and thus this is really a debug
feature. If the race will never be hit in a working system maybe it is
fine to leave it as is.

Would be good to document this detail :)

> Of course I'd rather that the architecture said that our current code
> is fine, but if it doesn't then I don't have much choice, really. At the
> very least, we should minimise the number of places where we rely on
> non-architected behaviour and so keeping the CDs and STEs non-cacheable
> remains my preference.

So, I am convinced, PTW has that escape above that doesn't apply to
STE/CD. Those can be accessed truely at any time and we can't ever
leave a 64 bit value in a strange state.

Jason
