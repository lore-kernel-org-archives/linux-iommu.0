Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC48468D
	for <iommu@lists.linux.dev>; Mon, 26 Sep 2022 20:13:05 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id d82so7758563pfd.10
        for <iommu@lists.linux.dev>; Mon, 26 Sep 2022 13:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=YkdEJniatjR+ZtWbjW6dVhH3qCn68DZMiCuKOEEupvQ=;
        b=TjUQiCgIuIHFLHFTEDiSnnBcTv7cL4/7Ynd5pRr0pMtG94KvYPOQIM8NEu3DEnk8Tv
         ONS8XQof0kiA1Pd/x3nQ9jx1+374FmKe/wmdgLCbSMYU2iKAOMZxKSre+QyN2RfI4SMC
         bL0s9/92lM6lZI31ixRDwpGl3wQ+8J6lT9sumFBJ7uNaeV2PhOzAELCEgSQxrtnTTyN1
         75uGcV4s4BFGEfUf6gqPaA/q7ToCSuZFIvjx6YyKNkXWJbTG7fmYeGHpsUAnI+P+Yxho
         LFL66BpE7qDSdN0nH2/a1sjlx9V/o8YitzLgxDkATDj+hbJPu1/my/irf4b5WA5cJ37z
         hJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YkdEJniatjR+ZtWbjW6dVhH3qCn68DZMiCuKOEEupvQ=;
        b=OCQycj6XmkoHtjSdrmrAvbysq0F8PYZ1XJ290WJ/G5XyCQd3s8w9okgwbcg8mEDWwj
         Y0VT6RsA1gCAq/yO8aJ+w07ZZ8G3lpK/p2fRZY8D5UUAM5NY/h/P9hIdCVOVaw1VhBDe
         Birs4ikWpQEYLa+uyfFcMjXvvJkK1VR31+ZMknNo8EOYU8TPedeBxl3n1xzyOFCOA0W8
         yjBjX76vCKHreas6iiXkoflSrCMCvm1lm8pOzynBke0zfGAoVGG4R+D95EowwRjG457O
         iXmMg23kBadnieFyb0GB2ekp+/SdDsvUaPDjcZsvtmqhk+NJtNFCajHiOOyQHwgryjeP
         qPFw==
X-Gm-Message-State: ACrzQf1YHZNF2Ej6HRU+BYmjqK3TIvZLqukL6aQCmd98bQrVnxb294ka
	frF4Ohsi70ca9EGQuKL9bk63Nw==
X-Google-Smtp-Source: AMsMyM4KZsVpvOzN/Qv68U3ASF7rRbCJhaAIuqdahA2eXFU8qgl/Bcc4sOVeN/fs0qw0ds1z3HDxig==
X-Received: by 2002:aa7:985e:0:b0:557:cc92:34ae with SMTP id n30-20020aa7985e000000b00557cc9234aemr12908648pfq.66.1664223184536;
        Mon, 26 Sep 2022 13:13:04 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id x12-20020aa7956c000000b0054094544ae7sm12619883pfq.60.2022.09.26.13.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:13:03 -0700 (PDT)
Date: Mon, 26 Sep 2022 20:13:00 +0000
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>,
	Joerg Roedel <jroedel@suse.de>, jean-philippe.brucker@arm.com,
	Linux-MM <linux-mm@kvack.org>,
	kernel list <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev
Subject: Re: some likely bugs in IOMMUv2 (in tlb_finish_mmu() nested flush
 and mremap())
Message-ID: <YzIHzIxknGNba6CC@google.com>
References: <CAG48ez2NQKVbv=yG_fq_jtZjf8Q=+Wy54FxcFrK_OujFg5BwSQ@mail.gmail.com>
 <Yy3skVk/DvwVnPXD@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy3skVk/DvwVnPXD@nvidia.com>

On Fri, Sep 23, 2022, Jason Gunthorpe wrote:
> On Fri, Sep 23, 2022 at 05:38:12PM +0200, Jann Horn wrote:
> > Hi!
> > 
> > I looked through some of the code related to IOMMUv2 (the thing where
> > the IOMMU walks the normal userspace page tables and TLB shootdowns
> > are replicated to the IOMMU through
> > mmu_notifier_ops::invalidate_range).
> > 
> > I think there's a bug in the interaction between tlb_finish_mmu() and
> > mmu_notifier_ops::invalidate_range: In the mm_tlb_flush_nested() case,
> > __tlb_reset_range() sets tlb->start and tlb->end *both* to ~0.
> > Afterwards, tlb_finish_mmu() calls
> > tlb_flush_mmu()->tlb_flush_mmu_tlbonly()->mmu_notifier_invalidate_range(),
> > which will pass those tlb->start and tlb->end values to
> > mmu_notifier_ops::invalidate_range callbacks. But those callbacks
> > don't know about this special case and then basically only flush
> > virtual address ~0, making the flush useless. 
> 
> Yeah, that looks wrong to me, and it extends more than just the iommu
> drivers kvm_arch_mmu_notifier_invalidate_range() also does not handle
> this coding.

FWIW, the bug is likely benign for KVM.  KVM does almost all of its TLB flushing
via invalidate_range_{start,end}(), the invalidate_range() hook is used only by
x86/VMX to react to a specific KVM-allocated page being migrated (the page is only
ever unmapped when the VM is dying).

> Most likely tlb_flush_mmu_tlbonly() need to change it back to 0 to ~0?
> I wonder why it uses such an odd coding in the first place?
> 
> Actually, maybe having mm_tlb_flush_nested() call __tlb_reset_range()
> to generate a 'flush all' request is just a bad idea, as we already
> had another bug in 7a30df49f63ad92 related to reset_range doing the
> wrong thing for a flush all action.
> 
> > (However, pretty much every place that calls tlb_finish_mmu() first
> > calls mmu_notifier_invalidate_range_end() even though the
> > appropriate thing would probably be
> > mmu_notifier_invalidate_range_only_end(); and I think those two
> > things probably cancel each other out?)
> 
> That does sound like double flushing to me, though as you note below,
> the invalidate_range() triggered by range_end() after the TLB
> flush/page freeing is functionally incorrect, so we cannot rely on it.
> 
> > Also, from what I can tell, the mremap() code, in move_page_tables(),
> > only invokes mmu_notifier_ops::invalidate_range via the
> > mmu_notifier_invalidate_range_end() at the very end, long after TLB
> > flushes must have happened - sort of like the bug we had years ago
> > where mremap() was flushing the normal TLBs too late
> > (https://bugs.chromium.org/p/project-zero/issues/detail?id=1695).
> 
> Based on the description of eb66ae03082960 I would say that yes the
> invalidate_range op is missing here for the same reasons the CPU flush
> was missing.
> 
> AFAIK if we are flushing the CPU tlb then we really must also flush
> the CPU tlb that KVM controls, and that is primarily what
> invalidate_range() is used for.

As above, for its actual secondary MMU, KVM invalidates and flushes at
invalidate_range_start(), and then prevents vCPUs from creating new entries for
the range until invalidate_range_start_end().

The VMX use case is for a physical address that is consumed by hardware without
going through the secondary page tables; using the start/end hooks would be slightly
annoying due to the need to stall the vCPU until end, and so KVM uses invalidate_range()
for that one specific case.

> Which makes me wonder if the invalidate_range() hidden inside
> invalidate_end() is a bad idea in general - when is this need and
> would be correct? Isn't it better to put the invalidates near the TLB
> invalidates and leave start/end as purely a bracketing API, which by
> definition, cannot have an end that is 'too late'?

Documentation/mm/mmu_notifier.rst explains this, although even that is quite subtle.
The argument is that if the change is purely to downgrade protections, then
deferring invalidate_range() is ok because the only requirement is that secondary
MMUs invalidate before the "end" of the sequence.

  When changing a pte to write protect or to point to a new write protected page  
  with same content (KSM) it is fine to delay the mmu_notifier_invalidate_range   
  call to mmu_notifier_invalidate_range_end() outside the page table lock. This   
  is true even if the thread doing the page table update is preempted right after 
  releasing page table lock but before call mmu_notifier_invalidate_range_end().

That said, I also dislike hiding invalidate_range() inside end(), I constantly
forget about that behavior.  To address that, what about renaming
mmu_notifier_invalidate_range_end() to make it more explicit, e.g.
mmu_notifier_invalidate_range_and_end().
