Received: from mta1.migadu.com (out-81.mta1.migadu.com [95.215.58.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150693612F6
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 05:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969952; cv=none; b=sTTzz7qSKnT02e+NFzi1UglChTAJ6oG1ZSk/r8kDrQa71tgAOCrzhDH9ovmwVcyHQeRvlpjgYiedmFBx2uP5Z+/Z7fq9lVcuS9k4fZvwC55zoRSCDUgbDfcgmq4gsQQ169IZDGfDBUWgau5YP5GBUsR6LKJamy0R4odKGRKZ+Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969952; c=relaxed/simple;
	bh=+3OQfzHRoTvBjBd8jB9/THE2C+GAiBoDPdOUT4cBopw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJTQS008sdxkI5Xk7/lFXDVSIBR417iVnWMOHhHDHAvl5u9a1aGBhSZ9q2Vbo2HSYW6+JTLJ0Z6keJ4Rug85Mv6q4ezwIYniRdfA5LgNJGFixUbdJk3EM94MmV9MI64HzUeOJ9CqenHfBduetRW8Q6Q1Yxc/IJN4O80yjqiNyCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AGqHNvoB; arc=none smtp.client-ip=95.215.58.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AGqHNvoB"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=+3OQfzHRoTvBjBd8jB9/THE2C+GAiBoDPdOUT4cBopw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789969947; v=1; x=1790574747;
 b=AGqHNvoBHNAK5Sgs8bbNFPB9LRfWqahsS8hsc3FUslRi1QNL9CbtcXuiBuAODhnoALewzvTz
 zAJKHdCmXss9/DvIqB5/J8rDlIqMR5eOYjWyZsTcomxdHzlJCmmDAyvIWSZur3TyrC6BPzAwIHN
 locxBrK8oD3Q849lc7AWjrUk=
X-Envelope-To: iommu@lists.linux.dev
Received: by mta12.migadu.com with ESMTPS id 3106e5e1082e60f1;
	Mon, 21 Sep 2026 05:52:26 +0000
X-Mizu-Trace-ID: 3106e5e1082e60f1
X-Migadu-Flow: FLOW_OUT
Date: Mon, 21 Sep 2026 13:52:24 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Wandun <chenwandun1@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, robh@kernel.org, saravanak@kernel.org,
	akpm@linux-foundation.org, pasha.tatashin@soleen.com,
	pratyush@kernel.org, m.szyprowski@samsung.com, mark.rutland@arm.com,
	kernel@xen0n.name, alex@ghiti.fr, hpa@zytor.com,
	ruirui.yang@linux.dev, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH v6 06/10] memblock: introduce MEMBLOCK_NODUMP flag
Message-ID: <arDGGOhKFueI90tJ@fedora>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-7-chenwandun1@gmail.com>
 <aqzxavL91icLw-Xv@fedora>
 <aq41nFRPtRWTQ7cK@kernel.org>
 <aq9UGXeqmCfuPHdD@fedora>
 <32b00102-0961-49e3-b780-74d6db182809@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32b00102-0961-49e3-b780-74d6db182809@gmail.com>

On 09/20/26 at 04:00pm, Wandun wrote:
> 
> 
> On 9/20/26 11:33, Baoquan He wrote:
> > On 09/19/26 at 10:11am, Mike Rapoport wrote:
> >> On Fri, Sep 18, 2026 at 04:08:10PM +0800, Baoquan He wrote:
> >>> On 09/02/26 at 03:31pm, Wandun Chen wrote:
> > ...snip... 
> >>>> +/**
> >>>> + * memblock_mark_nodump - Mark a memory region with flag MEMBLOCK_NODUMP.
> >>>> + * @base: the base phys addr of the region
> >>>> + * @size: the size of the region
> >>>> + *
> >>>> + * Mark the region as not to be included in crash dumps.
> >>>> + *
> >>>> + * Return: 0 on success, -errno on failure.
> >>>> + */
> >>>> +int __init_memblock memblock_mark_nodump(phys_addr_t base, phys_addr_t size)
> >>>       ~~~~~~~~~~~~~~^
> >>> Is it impossible to use at runtime even thought it claims to be generic?
> >>
> >> This should only happen at boot.
> >>
> >> Allowing modifications of memblock properties in runtime is a can of worms
> >> I don't want to open.
> > 
> > Thank you. This is why I said this can't be claimed as a generic way to
> > mark memory region as no dump. The generic way I'd like to see is
> > at any time of system we can mark any unwanted memory region as no dump.
> > And it won't impact the behaviour of the current system.
> 
> Thanks Mike for the explanation and Baoquan for the suggestion.
> I'll drop the "generic" related description in the next version.
> 
> 
> Baoquan, by the way, patch 2 is still awaiting review. It rewrites
> the riscv side of the code that patch 3 (which you've acked) then
> folds into the weak defaults, if you could take a look at it too,
> that would be very helpful.

I checked and looks good, I have added ACK. While RISC-V people can hold
it anytime if they have concern.

