Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55EF3D90
	for <iommu@lists.linux.dev>; Fri, 23 Sep 2022 15:38:49 +0000 (UTC)
Received: by mail-il1-f174.google.com with SMTP id l4so350631ilq.3
        for <iommu@lists.linux.dev>; Fri, 23 Sep 2022 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=IYqbNU1fZX4rzoxApDKFFKDnto7gL2nxgV8bIfOeFQo=;
        b=QgYgZ0SczN90S2LmGDoPyEcaSNhP800LDUhQmpMlD17ZLSVfdR/JKYP7ape2858og5
         BAh2C9isGH3RrUg6KckDzrm//AEYKZmRt3TqC2fidYCHaLUZO8jKYxh1rNbqacfFY1OZ
         ACkiBWfHHS/Rtg3tDNCLTMx01tk8+YJGwlWvdJ/R+SxzBGjOHIsKvGtiJ7r36aA8FxO7
         pWuXWUF3M2NtVqvOa5CWo3cO62pR4I92WbG4qnCklqGnL3d4QKKDm8HozZ/65W7zRRNv
         /4ws2MSB97r0rowNsVC34hrocLEqAxrnW/oHgVorGvjEa+JDc9e15SK++CbNu43R5Nm9
         ivRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=IYqbNU1fZX4rzoxApDKFFKDnto7gL2nxgV8bIfOeFQo=;
        b=fDN95uHs4lC2VpbpNxoTEdsdiIQzWLjEhZ0wWkfZ5GMN/CvVZB7+s8w0GkMZoCsr/U
         y+C3m87LIdVdLPVwvaiRgXdYOPjmumoWxQA0KeMelvv+k3bAqqsUGdz3sHyKAmcEw31V
         q+rnfdcD4MfSwE5odMKObFf3C/OTXXm3KjEPWWkdrZ3E/ui4YoUTMbUn8QXQlDoUFxb0
         UMRwjTfkTTECBFoQrTkkOlM/fEy8ZyqyXZ2ptN3KwmBoBBdBuR/fvDGSuLCkuT9fa4oY
         F2FbvM9taNhwjGbQtmz9cUaGDd7VwjnUUrlxNfP1JY1FkmQcbxQwM7nZ3YQ0TtIRHm9K
         gXMA==
X-Gm-Message-State: ACrzQf3xXYf6OiJ9zIqgSF/asvEauthJxAe1ynFnU0WPBlTywAtq1sZR
	zrMlPCgTXhDTrOgTFqLisdKm7qbLUa7d94TTUD7LiQ==
X-Google-Smtp-Source: AMsMyM4d/ic+EXhHlBsvB8fRatAdRHMpVHFKIEza947IkC134wotND2PFgIDPa+RKBjN0RImpPujGXCyVsPVVP4B8qg=
X-Received: by 2002:a05:6e02:1e06:b0:2f6:2666:e8ca with SMTP id
 g6-20020a056e021e0600b002f62666e8camr4229393ila.173.1663947528664; Fri, 23
 Sep 2022 08:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Jann Horn <jannh@google.com>
Date: Fri, 23 Sep 2022 17:38:12 +0200
Message-ID: <CAG48ez2NQKVbv=yG_fq_jtZjf8Q=+Wy54FxcFrK_OujFg5BwSQ@mail.gmail.com>
Subject: some likely bugs in IOMMUv2 (in tlb_finish_mmu() nested flush and mremap())
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Sean Christopherson <seanjc@google.com>, Joerg Roedel <jroedel@suse.de>, jean-philippe.brucker@arm.com
Cc: Linux-MM <linux-mm@kvack.org>, kernel list <linux-kernel@vger.kernel.org>, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi!

I looked through some of the code related to IOMMUv2 (the thing where
the IOMMU walks the normal userspace page tables and TLB shootdowns
are replicated to the IOMMU through
mmu_notifier_ops::invalidate_range).

I think there's a bug in the interaction between tlb_finish_mmu() and
mmu_notifier_ops::invalidate_range: In the mm_tlb_flush_nested() case,
__tlb_reset_range() sets tlb->start and tlb->end *both* to ~0.
Afterwards, tlb_finish_mmu() calls
tlb_flush_mmu()->tlb_flush_mmu_tlbonly()->mmu_notifier_invalidate_range(),
which will pass those tlb->start and tlb->end values to
mmu_notifier_ops::invalidate_range callbacks. But those callbacks
don't know about this special case and then basically only flush
virtual address ~0, making the flush useless. (However, pretty much
every place that calls tlb_finish_mmu() first calls
mmu_notifier_invalidate_range_end() even though the appropriate thing
would probably be mmu_notifier_invalidate_range_only_end(); and I
think those two things probably cancel each other out?)

Also, from what I can tell, the mremap() code, in move_page_tables(),
only invokes mmu_notifier_ops::invalidate_range via the
mmu_notifier_invalidate_range_end() at the very end, long after TLB
flushes must have happened - sort of like the bug we had years ago
where mremap() was flushing the normal TLBs too late
(https://bugs.chromium.org/p/project-zero/issues/detail?id=1695).
