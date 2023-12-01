Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3F91BDC7
	for <iommu@lists.linux.dev>; Fri,  1 Dec 2023 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XabSGaIH"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1fa21f561a1so554798fac.3
        for <iommu@lists.linux.dev>; Fri, 01 Dec 2023 12:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701463700; x=1702068500; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sc0mXGdos+flIqYbEOETr4gKaCIcHlnZcTFOmVNNT/s=;
        b=XabSGaIHcJEEPF7oiKg41VsJucLowQ9rHTQjxjd7bxAIFjN8whmytXedzEVWIlulL9
         nSseIO3bJ3MK+eYOTILnRT4PL2YByIiMWsR25AfsMs0ksp0pDejfQZgW8HoASUO/JgxX
         J8WI5k6rTBTo5hG7HsWeM7XHYGFOmVjMYkw5jF9EbbdIEOGvR8LhMBUg4ccU4F43Izrp
         2/cefjN5RG5TvREBGmm9ttDudp1b1+mCzkAPCSoaGQkCCouve9H96HrK3z5nkW+AuFRz
         vdz2NKnb9UWhHwqnI9D/EUDvpVeeDDv8R6TC+QR2qCiN8MzgpgfPu+dqCt4OviOK2xmy
         UdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701463700; x=1702068500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sc0mXGdos+flIqYbEOETr4gKaCIcHlnZcTFOmVNNT/s=;
        b=LM2aD9TnHDcv1435uKcxzUNt6w7ENB7RqKA4/O7aPmchDe+CHEITFrLXlMA6mWS+2P
         n145MNexqhutjtT7PimkDsnj+TvmuJ/bPDcBTnf7Tvsid6y9xwpAWvPpbOC+DmzR5YHt
         XYwCj3QJ43kLIv/qDKO5CJBUj35Vj+yZAeCv2y0ap+dXIykEEH10UHRifAvCzX+HHW+Z
         peVLXFoL/PRpBAdnB0Vpz8lo15JFSdTQBVPIRTERVyIrrjFJW6rsjRbR79Q0d2TR6J64
         cAZRquXpUGpwUF5gavSEWr/D8D2aeEEUhxysLWTfHvZitOuH4Kg/Vc227QnON3trgMR5
         dJQg==
X-Gm-Message-State: AOJu0Yye/13K+7BSLyuokMiCthSxDvwOtWP1THl+vrNd/z/1Q+ZcW2eI
	10gP5iHGS1kYYiVaqjWzwl91Og==
X-Google-Smtp-Source: AGHT+IEZyyMyYdVZ/U2w+Y1ObRK14n0S0fw+H/3/e0+QnvNoXR/Lw9yKjEGoy++VknK7HJZ3jXY6+w==
X-Received: by 2002:a05:6870:698c:b0:1fa:789a:d12c with SMTP id my12-20020a056870698c00b001fa789ad12cmr337579oab.38.1701463700064;
        Fri, 01 Dec 2023 12:48:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id s9-20020a0c8d49000000b0067a245efd3csm1825633qvb.135.2023.12.01.12.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 12:48:19 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r9AQs-006OM7-TF;
	Fri, 01 Dec 2023 16:48:18 -0400
Date: Fri, 1 Dec 2023 16:48:18 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tina Zhang <tina.zhang@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>, torvalds@linux-foundation.org,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] iommu: Change kconfig around IOMMU_SVA
Message-ID: <20231201204818.GH1489931@ziepe.ca>
References: <20231128021635.5530-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128021635.5530-1-tina.zhang@intel.com>


On Tue, Nov 28, 2023 at 10:16:35AM +0800, Tina Zhang wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Linus suggested that the kconfig here is confusing:
> 
> https://lore.kernel.org/all/CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com/
> 
> Let's break it into three kconfigs controlling distinct things:
> 
>  - CONFIG_IOMMU_MM_DATA controls if the mm_struct has the additional
>    fields for the IOMMU. Currently only PASID, but later patches store
>    a struct iommu_mm_data *
> 
>  - CONFIG_ARCH_HAS_CPU_PASID controls if the arch needs the scheduling bit
>    for keeping track of the ENQCMD instruction. x86 will select this if
>    IOMMU_SVA is enabled
> 
>  - IOMMU_SVA controls if the IOMMU core compiles in the SVA support code
>    for iommu driver use and the IOMMU exported API
> 
> This way ARM will not enable CONFIG_ARCH_HAS_CPU_PASID
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  arch/Kconfig             | 5 +++++
>  arch/x86/Kconfig         | 1 +
>  arch/x86/kernel/traps.c  | 2 +-
>  drivers/iommu/Kconfig    | 1 +
>  include/linux/iommu.h    | 2 +-
>  include/linux/mm_types.h | 2 +-
>  include/linux/sched.h    | 2 +-
>  kernel/fork.c            | 2 +-
>  mm/Kconfig               | 3 +++
>  mm/init-mm.c             | 2 +-
>  10 files changed, 16 insertions(+), 6 deletions(-)

Try again, you need to cc the mm list and the x86 list

Jason
