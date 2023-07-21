Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB27E20F8E
	for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 19:29:16 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-668704a5b5bso2018676b3a.0
        for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 12:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689967756; x=1690572556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6PVgaqPhmt4wq0AWBCFQwFhvxfFvbSlDYNh4o0Ppojs=;
        b=GfaxQaKw5x3cV3SfUeA/pzqiy5kUPg0RiENjQHq5dJ46ftZgr6GcEH/8NPMVHUyb15
         On/HsOGxBo53R9kz/XnoR9KMjvnJ97KGyHZILWXEZUXDlYAOXodZDrfICC/dFZ/SBWkd
         1A9RMfpQiCSehrZEKBRYWCGM6pKRLOddyYpQM6Qny0c2Dyrj6km1I0ScE3lw/3LopZBU
         mHYA9vyZkoPJGJHI+Ym0bW0XfaN4vFlO0PPvWesldgcLxIRfysJNLp6bSRDAquiwOdvT
         eYGeNlDw9g03rR9btRmI3899ViEqGdpcH6xzhKko4eGdvLMWmTIAcasv3gC2fW/6G2ma
         6EnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689967756; x=1690572556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PVgaqPhmt4wq0AWBCFQwFhvxfFvbSlDYNh4o0Ppojs=;
        b=er+EJN5rCOhUbGVtUV1zo6aa+l3dtmEufugo37dCl3rI6BD7CQ3yvgbiKVV7za7SrH
         oOg+V7s+RhzUfi75omzH2PaIaEFnpzZ4oNUltgASVaGE3FtepsqVcjPxtC7NwAcEKZ+k
         Hkd92NMZBf11l4ofCIq4T1Z9sFeP6MHLPed3rluAQmTfuueEpvPEj551I4/w3T+DVzmj
         q1LbRgdNInPXyuh+5e/CsRdDeDo7TeJNSpNay3BkFA/IUuUGmf0W49erHuJmeuqZYUpK
         7uG2036NI33Nv3nsduTi9c/vcLpTVpuXKdfytS49Pdd9bD4ImbO4AF+uzECOAe8GkRGE
         Eb5A==
X-Gm-Message-State: ABy/qLa9CdZ0fJeavq1d+/ZX+nQqsArzY4lLyns3JYfESQVIC+2J5tkX
	Jm21jRdeucJzEp05yNJUZO6ARQ==
X-Google-Smtp-Source: APBJJlHhX/ECiPtAgKTdPj/SAH5GJPTRrsthr/G8wSLG2KG1XyYAjgc1lH1BQS59ustvdAeajObIAA==
X-Received: by 2002:a05:6a20:8f15:b0:137:293b:f9c0 with SMTP id b21-20020a056a208f1500b00137293bf9c0mr3542725pzk.33.1689967756135;
        Fri, 21 Jul 2023 12:29:16 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id i14-20020a63bf4e000000b0054ff36967f7sm3181162pgo.54.2023.07.21.12.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:29:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qMvoP-003IF4-QK;
	Fri, 21 Jul 2023 16:29:13 -0300
Date: Fri, 21 Jul 2023 16:29:13 -0300
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
Subject: Re: [PATCH v3 4/5] mmu_notifiers: Don't invalidate secondary TLBs as
 part of mmu_notifier_invalidate_range_end()
Message-ID: <ZLrciTXW9CfLCLar@ziepe.ca>
References: <cover.b24362332ec6099bc8db4e8e06a67545c653291d.1689842332.git-series.apopple@nvidia.com>
 <141e786b68527b1db9fc5a3259066c360448e7a4.1689842332.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <141e786b68527b1db9fc5a3259066c360448e7a4.1689842332.git-series.apopple@nvidia.com>

On Thu, Jul 20, 2023 at 06:39:26PM +1000, Alistair Popple wrote:
> Secondary TLBs are now invalidated from the architecture specific TLB
> invalidation functions. Therefore there is no need to explicitly
> notify or invalidate as part of the range end functions. This means we
> can remove mmu_notifier_invalidate_range_end_only() and some of the
> ptep_*_notify() functions.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  include/linux/mmu_notifier.h | 56 +------------------------------------
>  kernel/events/uprobes.c      |  2 +-
>  mm/huge_memory.c             | 25 ++---------------
>  mm/hugetlb.c                 |  1 +-
>  mm/memory.c                  |  8 +----
>  mm/migrate_device.c          |  9 +-----
>  mm/mmu_notifier.c            | 25 ++---------------
>  mm/rmap.c                    | 40 +--------------------------
>  8 files changed, 14 insertions(+), 152 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
