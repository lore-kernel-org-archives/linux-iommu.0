Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A71C20FA8
	for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 19:27:07 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-66869feb7d1so1479132b3a.3
        for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 12:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689967627; x=1690572427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D1nGAoqkQE9tORj40d+ZOdFx3TBXwI2iMVqB+EH0J9M=;
        b=ho7FX/Gu/yFttlKppWHadCl+z3p3hJNnyUWo1gZ62PEyBJbQY6EYc+cgqOF/vQCsNL
         Mkj3evoOdg5kQNIS2GHTYB2bsdau7no004XCgCzhg70C7hzjuBTgqZBM8fhGLoNoppsr
         kqTwMYeEw+ixSgRXlOs7lxHbvsOYYXsbxRGJLY9Xj9ZAmOizPWpr0ddjxYm6D/ZBDDur
         8kFjVO0kxTqPNd2AEoeDXPQtEpGr6MWERNLupARD7mBgQc27VY17l2Dq7N7guA1ips9f
         8Sf/a3XpW02K8gKcfPE6pA/EbZNlePzntRg9/8m15RDd8Lh+iQ3IDCBxkHiaCB8eeHk6
         pVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689967627; x=1690572427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1nGAoqkQE9tORj40d+ZOdFx3TBXwI2iMVqB+EH0J9M=;
        b=OFELDW31UaRWAeJS+0CmCW4wK43n6QAKbr07EHa1jydrU0xSoP6i6UKFAo/OQ3djuL
         bPYLF5yWtGY9qZeWOZCeWlYkwnOxXVh6JtPQr8BlxhF39DNZFMboJ6+Kx9AMGVxztcNc
         AT7uWwOcaCYRhuO7BkyJ2gPJ4Ub3Cqa2G8ZNwmt/fBTT16TFgxDbH2t4EVCTvi80pDve
         ulWWX5a48Xb/mRiTejirpB5vd5ycKdVjDtu7aENtIWb4Jt7mvp0yE5Z3NcEJ+pAhXYti
         km6AbJBe70o5HMmyvu9LYPPhM1iny6foRo5rMvJRfZb3r27FAQ4EA/jxy80+HysD3mIX
         /erQ==
X-Gm-Message-State: ABy/qLY6nAZw9v7GNTaoOF3emwxNAyuvoaSIjUZmoel/ojHXj5cAOoGm
	RKxpcIq8jCDGJJlqwDVj1jEkVg==
X-Google-Smtp-Source: APBJJlEJHy5FiukXEMdXavX4iO5BgBEVLB0I27AjF1BNpwKJMi9kmjgl4tr0TNNlWYEs0Uxb6e5yVA==
X-Received: by 2002:a05:6a20:8e1f:b0:122:20c:fbb1 with SMTP id y31-20020a056a208e1f00b00122020cfbb1mr3108454pzj.44.1689967626960;
        Fri, 21 Jul 2023 12:27:06 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id g2-20020aa78742000000b0066a31111ccdsm3333938pfo.65.2023.07.21.12.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:27:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qMvmK-003IDr-B2;
	Fri, 21 Jul 2023 16:27:04 -0300
Date: Fri, 21 Jul 2023 16:27:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: akpm@linux-foundation.org, ajd@linux.ibm.com, catalin.marinas@arm.com,
	fbarrat@linux.ibm.com, iommu@lists.linux.dev, jhubbard@nvidia.com,
	kevin.tian@intel.com, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au, nicolinc@nvidia.com, npiggin@gmail.com,
	robin.murphy@arm.com, seanjc@google.com, will@kernel.org,
	x86@kernel.org, zhi.wang.linux@gmail.com, sj@kernel.org
Subject: Re: [PATCH v3 3/5] mmu_notifiers: Call invalidate_range() when
 invalidating TLBs
Message-ID: <ZLrcCI5fyBcj2myR@ziepe.ca>
References: <cover.b24362332ec6099bc8db4e8e06a67545c653291d.1689842332.git-series.apopple@nvidia.com>
 <86a0bf86394f1765fcbf9890bbabb154ba8dd980.1689842332.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86a0bf86394f1765fcbf9890bbabb154ba8dd980.1689842332.git-series.apopple@nvidia.com>

On Thu, Jul 20, 2023 at 06:39:25PM +1000, Alistair Popple wrote:
> The invalidate_range() is going to become an architecture specific mmu
> notifier used to keep the TLB of secondary MMUs such as an IOMMU in
> sync with the CPU page tables. Currently it is called from separate
> code paths to the main CPU TLB invalidations. This can lead to a
> secondary TLB not getting invalidated when required and makes it hard
> to reason about when exactly the secondary TLB is invalidated.
> 
> To fix this move the notifier call to the architecture specific TLB
> maintenance functions for architectures that have secondary MMUs
> requiring explicit software invalidations.
> 
> This fixes a SMMU bug on ARM64. On ARM64 PTE permission upgrades
> require a TLB invalidation. This invalidation is done by the
> architecutre specific ptep_set_access_flags() which calls
> flush_tlb_page() if required. However this doesn't call the notifier
> resulting in infinite faults being generated by devices using the SMMU
> if it has previously cached a read-only PTE in it's TLB.
> 
> Moving the invalidations into the TLB invalidation functions ensures
> all invalidations happen at the same time as the CPU invalidation. The
> architecture specific flush_tlb_all() routines do not call the
> notifier as none of the IOMMUs require this.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Tested-by: SeongJae Park <sj@kernel.org>
> ---
>  arch/arm64/include/asm/tlbflush.h             | 5 +++++
>  arch/powerpc/include/asm/book3s/64/tlbflush.h | 1 +
>  arch/powerpc/mm/book3s64/radix_hugetlbpage.c  | 1 +
>  arch/powerpc/mm/book3s64/radix_tlb.c          | 6 ++++++
>  arch/x86/include/asm/tlbflush.h               | 2 ++
>  arch/x86/mm/tlb.c                             | 2 ++
>  include/asm-generic/tlb.h                     | 1 -
>  7 files changed, 17 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
