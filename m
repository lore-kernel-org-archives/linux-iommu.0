Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF746A1
	for <iommu@lists.linux.dev>; Tue, 18 Jul 2023 18:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9F2C433C8;
	Tue, 18 Jul 2023 18:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1689705381;
	bh=JgrHe5DZ5UnZ31Le+DdrjV7UqhJAEhx+BMwzO0I0pyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rSwv4V3DUswnOOwtuqviHoHg8mtQl8Mycp8naGrr017s7gsEUs+LUFgW78b59OlD6
	 RJ07+aYugwPVV2ffN02N+TbXLoW/RPNxLL/RW1q/hReBJmWPBWvyF6ARM4VWnVkHi/
	 WwOrnVSIGZK5bXjK7yuuDSaj1cyDMcQJVsSO4MIU=
Date: Tue, 18 Jul 2023 11:36:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alistair Popple <apopple@nvidia.com>, ajd@linux.ibm.com,
 catalin.marinas@arm.com, fbarrat@linux.ibm.com, iommu@lists.linux.dev,
 jhubbard@nvidia.com, kevin.tian@intel.com, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 nicolinc@nvidia.com, npiggin@gmail.com, robin.murphy@arm.com,
 seanjc@google.com, will@kernel.org, x86@kernel.org,
 zhi.wang.linux@gmail.com
Subject: Re: [PATCH 1/4] mm_notifiers: Rename invalidate_range notifier
Message-Id: <20230718113620.fb29217344238307c3be76d7@linux-foundation.org>
In-Reply-To: <ZLbSeO+XjSx1W795@ziepe.ca>
References: <cover.b4454f7f3d0afbfe1965e8026823cd50a42954b4.1689666760.git-series.apopple@nvidia.com>
	<c0daf0870f7220bbf815713463aff86970a5d0fa.1689666760.git-series.apopple@nvidia.com>
	<ZLbSeO+XjSx1W795@ziepe.ca>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jul 2023 14:57:12 -0300 Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Tue, Jul 18, 2023 at 05:56:15PM +1000, Alistair Popple wrote:
> > diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> > index b466172..48c81b9 100644
> > --- a/include/asm-generic/tlb.h
> > +++ b/include/asm-generic/tlb.h
> > @@ -456,7 +456,7 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
> >  		return;
> >  
> >  	tlb_flush(tlb);
> > -	mmu_notifier_invalidate_range(tlb->mm, tlb->start, tlb->end);
> > +	mmu_notifier_invalidate_secondary_tlbs(tlb->mm, tlb->start, tlb->end);
> >  	__tlb_reset_range(tlb);
> 
> Does this compile? I don't see
> "mmu_notifier_invalidate_secondary_tlbs" ?

Seems this call gets deleted later in the series.

> But I think the approach in this series looks fine, it is so much
> cleaner after we remove all the cruft in patch 4, just look at the
> diffstat..

I'll push this into -next if it compiles OK for me, but yes, a redo is
desirable please.

