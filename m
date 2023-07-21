Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3613C20F8E
	for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 19:31:08 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1b8baa836a5so17070195ad.1
        for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 12:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689967868; x=1690572668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f3fNBXK6DdLEjSA1dgCCAp4qYAepk3u3d3m0rz5z1fE=;
        b=kDmWxsg8ZqlraY3EitIJv4Evr2CcqLMRY3qJJ8AcjlKJ3bFOzgBkDnjKefyYbdeSfz
         k86T0qkxGRO51XZTaYeEKipExFEf8j1Hv1UVrlMbeSWAAge69sWytNfaMcA7RqeT6zuL
         3L23q9S/iI50qzztXd/HyH2HoeCpvu0Z2gNnWlaIpHe3ERs66DUZ8IU1MTauRcMdzksf
         ILJCbJ6VdIAYJt/7FJu58WJgwsSS2VgS9zoptDQ2XjWHdUPjgabRgHusalzm4+RsCynb
         dnms2eGvIrcLiBFxG5n4oVrQg7cm8ONAc3J+1xhZDfp15hiSb0l0fBegQfffD1CHZhNd
         TBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689967868; x=1690572668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3fNBXK6DdLEjSA1dgCCAp4qYAepk3u3d3m0rz5z1fE=;
        b=X2RviLlGqPXcWT2Ze1zbGR5zrNrGc174MTYcAOs2gaLaHFEBrp1NNiBk02tBOY1O8C
         MCvql7uQTS4BQS+Wy2H6Fb8cyGCYGSctVS/PjaBUKD/m6/Uhvkz6iySBqUS1CEDlfc9o
         r2kNI2AFgeX8mkUjhdnEWMc36ubQVI+FBH0Foe3/CYJtuIWKUH4616TC0Axzr/AtXDoJ
         U5BoT9e979InoshCmqUIl9wRWZMGDOiROlb4jxhEOeHEjuyjrTx7JwIUhedsiswkock9
         vhy6kboTs7gH5N/G0Cvr4Z5QWN+sKMpXgM84tfxi2VLchcI0g8P2kd6sjecs355em0tr
         uHhQ==
X-Gm-Message-State: ABy/qLZ6iP+wjDL1SuLwGcq3Q+LDmEB5jctdCjq7lmXGecghm4bA/uPP
	IcLJhhRc7DbGiGZAqsIf9XjbVg==
X-Google-Smtp-Source: APBJJlHihJyY9wXFkjydx/6tfCAtPCW82R9C1y8RYnU52rOS6+M8sM4/6qnSkSyFxd3dSuGWl4EDkw==
X-Received: by 2002:a17:902:b418:b0:1b8:b2c6:7e8d with SMTP id x24-20020a170902b41800b001b8b2c67e8dmr2649069plr.66.1689967868340;
        Fri, 21 Jul 2023 12:31:08 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id r16-20020a170902be1000b001b8422f1000sm3860137pls.201.2023.07.21.12.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:31:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qMvqE-003IGg-98;
	Fri, 21 Jul 2023 16:31:06 -0300
Date: Fri, 21 Jul 2023 16:31:06 -0300
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
Subject: Re: [PATCH v3 5/5] mmu_notifiers: Rename invalidate_range notifier
Message-ID: <ZLrc+vEQcCEpI0wd@ziepe.ca>
References: <cover.b24362332ec6099bc8db4e8e06a67545c653291d.1689842332.git-series.apopple@nvidia.com>
 <3cbd2a644d56d503b47cfc35868d547f924f880e.1689842332.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cbd2a644d56d503b47cfc35868d547f924f880e.1689842332.git-series.apopple@nvidia.com>

On Thu, Jul 20, 2023 at 06:39:27PM +1000, Alistair Popple wrote:
> There are two main use cases for mmu notifiers. One is by KVM which
> uses mmu_notifier_invalidate_range_start()/end() to manage a software
> TLB.
> 
> The other is to manage hardware TLBs which need to use the
> invalidate_range() callback because HW can establish new TLB entries
> at any time. Hence using start/end() can lead to memory corruption as
> these callbacks happen too soon/late during page unmap.
> 
> mmu notifier users should therefore either use the start()/end()
> callbacks or the invalidate_range() callbacks. To make this usage
> clearer rename the invalidate_range() callback to
> arch_invalidate_secondary_tlbs() and update documention.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  arch/arm64/include/asm/tlbflush.h               |  6 +-
>  arch/powerpc/mm/book3s64/radix_hugetlbpage.c    |  2 +-
>  arch/powerpc/mm/book3s64/radix_tlb.c            | 10 ++--
>  arch/x86/include/asm/tlbflush.h                 |  2 +-
>  arch/x86/mm/tlb.c                               |  2 +-
>  drivers/iommu/amd/iommu_v2.c                    | 10 ++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 13 ++---
>  drivers/iommu/intel/svm.c                       |  8 +--
>  drivers/misc/ocxl/link.c                        |  8 +--
>  include/linux/mmu_notifier.h                    | 48 +++++++++---------
>  mm/huge_memory.c                                |  4 +-
>  mm/hugetlb.c                                    |  7 +--
>  mm/mmu_notifier.c                               | 20 ++++++--
>  13 files changed, 76 insertions(+), 64 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
