Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FB34218A1
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175394; cv=none; b=szdpptThuhcrgPnkCsscXkk9HuHgdrr1m+qlc/K+IHVvfqGTTtVkAwFXKJDeBBkVGwywDiMC2wXntrqB0lVoS2HdMdnMngW/T9gO3Lcbu0LsnBDjy738ZTof3E/i8KRrZzp4y2XOYeV9VLWVxLvZ/TibFTleCKTPsAY+K5/TpXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175394; c=relaxed/simple;
	bh=lufFP1j2+8a/VDqN02ukHYuK7WPPw9TYBa516/C1kSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVzHWN0fpxeigXOkTQYJaBGLNahamnKbhA6CL4tNX+JmNOvGjFJp9rIIM8i5T0x8h21RD1JWWUpHZfoGk5Yp6t+m20vL9jw+HI1Rv55TIIkl6Nsn6NT4hS+Q3ANMwdxQl0Ty3yLgkixX72/XKqERcKA1Wn+sKJ21mCqeEokt4hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Rx3BNejL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Rx3BNejL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFB4B204C;
	Thu,  7 May 2026 10:36:26 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 607223F836;
	Thu,  7 May 2026 10:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778175392; bh=lufFP1j2+8a/VDqN02ukHYuK7WPPw9TYBa516/C1kSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rx3BNejLWFXtZUw1/U4pbhkLIMRpx+wkkQNdj2DSotWR92o32fJW0CBpuYQ8Jqd93
	 rRnfHevz11obJJw0ysvC7+++0wJMStpe5VUcmQWdGFuSBSUgdBht8lEoV7esLfqYw3
	 P66KHquUvH8/v4e0ghCK6e67i7BSv5z98RPcWdCs=
Date: Thu, 7 May 2026 18:36:27 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	m.szyprowski@samsung.com, will@kernel.org, maz@kernel.org,
	suzuki.poulose@arm.com, jiri@resnulli.us, aneesh.kumar@kernel.org
Subject: Re: [RFC PATCH v3 4/5] dma-mapping: Encapsulate memory state during
 allocation
Message-ID: <afzNm6ZmR6c8_SMk@arm.com>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-5-smostafa@google.com>
 <20260410180504.GE2551565@ziepe.ca>
 <aeJVh5VbkzxHDBEK@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeJVh5VbkzxHDBEK@google.com>

On Fri, Apr 17, 2026 at 03:45:11PM +0000, Mostafa Saleh wrote:
> On Fri, Apr 10, 2026 at 03:05:04PM -0300, Jason Gunthorpe wrote:
> > On Wed, Apr 08, 2026 at 07:47:41PM +0000, Mostafa Saleh wrote:
> > > Introduce a new dma-direct internal type dma_page which is
> > > "struct page" and a bit indicate whether the memory has been decrypted
> > > or not.
> > > This is useful to pass such information encapsulated through
> > > allocation functions, which is currently set from swiotlb_alloc().
> > > 
> > > No functional changes.
> > > 
> > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > ---
> > >  kernel/dma/direct.c | 58 +++++++++++++++++++++++++++++++++++----------
> > >  1 file changed, 46 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > > index de63e0449700..204bc566480c 100644
> > > --- a/kernel/dma/direct.c
> > > +++ b/kernel/dma/direct.c
> > > @@ -16,6 +16,33 @@
> > >  #include <linux/pci-p2pdma.h>
> > >  #include "direct.h"
> > >  
> > > +/*
> > > + * Represent DMA allocation and 1 bit flag for it's state
> > > + */
> > 
> > I'd explain this wrappers a pointer and uses the low PAGE_SHIFT bits
> > for flags..
> > 
> > > +struct dma_page {
> > > +	unsigned long val;
> > 
> > unintptr_t ?
> 
> I thought about that, but I don’t see unintptr_t anywhere in the
> kernel, it seems similar cases use “unsigned long” as in xarray.h

Jason meant uintptr_t. However, we have a similar pattern with struct
encoded_page as an incomplete type and encode_page() adds the bits
directly to the pointer. I'd use something similar as there's precedent
already.

-- 
Catalin
