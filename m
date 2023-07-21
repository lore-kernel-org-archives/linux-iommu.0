Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2F920F8F
	for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 19:25:51 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5638180156aso858707a12.0
        for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 12:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689967550; x=1690572350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MMsZNxLO6ied/G62NsNmuJtbpPqA/ZDXuniKdHv3YB4=;
        b=XQzjypm8qf/fouvehrBkEZjx7rraTNYkUvdCKXn1r1gfZnRnhcrrwzmNXN35Uu7gzI
         8oZahINtXmo9uCfjOT5mfF9tPFqadYED4ml2Rvg4gr4OGGmk2vfi6ALPhCVFDbYVbCVR
         bizj8weYssavNq2IYvHIenQVmt+p9+kOYvZhgrRMHxTk+VUEpNpnyoTxavBUyIHeBvaf
         qo1QRc6+YoA80RoGKZsLsD7vsvUGziFJq2u5Wn3UEGI6GwRgyCcJvjby4g2TfS0YmrN7
         IaJoLwJh5sfemxuaaNtQypWoArXN7KcGOCwTG4BZdi4RfD5EEjDf6oZVJxfS3TMV68DT
         4znQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689967550; x=1690572350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMsZNxLO6ied/G62NsNmuJtbpPqA/ZDXuniKdHv3YB4=;
        b=hpYymcxIacl9Af83wCYVhaT8yLmauCfuSjJBDS8Y65dVa+pVFpvMJsfnyYeUTtRRTc
         cuZfwpiLdUBTQbtNnBLc9D1q6Ur3z6dVnD1eN+D32alLgl2mDm/WI3Eg7sJ9cL0cjWqx
         K1bjigh0ITEPVINqRieKEeyYk2yvvegEnli1yvTOct8g6pV1GkU2GQ+rtbnyf+NOQ0d5
         i2Go/URL7fotjQgObQTc/0nuB9yJbB+1SxPCXjyMqz13KMewbnaOlCf6eND46nDf0Bwe
         PvBDesvuYZa8VW4KfPJPi80eLU0C/9/kSW8T2jhsupZICcMNK9YXK/g2EGXtSjR/BBt+
         Dbtg==
X-Gm-Message-State: ABy/qLZTEAlS4WW/OwK3/5D++ii0oQBKs/QMWh8M3ZC8Ej6BOK0APg4m
	RNQ9XN5kaOgTdLpV7OQPU4j9bg==
X-Google-Smtp-Source: APBJJlEp8s38SXROq49pagsC5pVvuYXs5UAkGBJHAYanGZ9PMcBXp3bCvAhBUtgXgds2MFlgz7aUow==
X-Received: by 2002:a17:90b:2308:b0:262:f06d:c0fc with SMTP id mt8-20020a17090b230800b00262f06dc0fcmr2530695pjb.7.1689967550531;
        Fri, 21 Jul 2023 12:25:50 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090a8d8500b0025bd4db25f0sm2845416pjo.53.2023.07.21.12.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:25:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qMvl5-003ID1-Uq;
	Fri, 21 Jul 2023 16:25:47 -0300
Date: Fri, 21 Jul 2023 16:25:47 -0300
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
Subject: Re: [PATCH v3 1/5] arm64/smmu: Use TLBI ASID when invalidating
 entire range
Message-ID: <ZLrbu6vk6x7l6xwJ@ziepe.ca>
References: <cover.b24362332ec6099bc8db4e8e06a67545c653291d.1689842332.git-series.apopple@nvidia.com>
 <082390057ec33969c81d49d35aa3024d7082b0bd.1689842332.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <082390057ec33969c81d49d35aa3024d7082b0bd.1689842332.git-series.apopple@nvidia.com>

On Thu, Jul 20, 2023 at 06:39:23PM +1000, Alistair Popple wrote:
> The ARM SMMU has a specific command for invalidating the TLB for an
> entire ASID. Currently this is used for the IO_PGTABLE API but not for
> ATS when called from the MMU notifier.
> 
> The current implementation of notifiers does not attempt to invalidate
> such a large address range, instead walking each VMA and invalidating
> each range individually during mmap removal. However in future SMMU
> TLB invalidations are going to be sent as part of the normal
> flush_tlb_*() kernel calls. To better deal with that add handling to
> use TLBI ASID when invalidating the entire address space.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
