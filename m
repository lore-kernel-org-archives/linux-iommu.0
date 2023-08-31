Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2505182DB
	for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 17:01:51 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1c1f8aaab9aso8298135ad.1
        for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1693501311; x=1694106111; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VCi4bsgMLCW5dXzntYC1D0i23asCQu6e0By0WrBIZ7I=;
        b=VHuhcw3Sc8OdnG9gmDSFM+ENBo+oZIZZPWweBKglxuv7XP5/m6tqiIEERp9ShUH4Jh
         0zD41A/Rr6piaF9M7F4TTZIV7d6yLEojBHT+7T4bILam6Y0tpk7npddSrESk2FbeuLbE
         5YhmrdDd1gX2pXW0YhbzfQWMXg1/hNBoIsFIgy3I+zkW9j0ezTu7rzZFhp1mgnZmgEJR
         GAFGW+oylpLl7qmd2VqXDa+9l1pxod7rOQEOm3yH7STHrCUuA/ns1sohffvM0DHPwiqT
         Hxl1XrQEWQ+EOHWo/GnfBLwex0TkOvVLhA9kRvDiUslC3g+5TJ0jI4OD8wBDsm2kSyUb
         gnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693501311; x=1694106111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCi4bsgMLCW5dXzntYC1D0i23asCQu6e0By0WrBIZ7I=;
        b=Y4TJu+cBSibBDk6P5YGjmMoGjt/x8Qf2IRGNQPWdGfypEgMb7cpMrMWCL2XN8vbIPX
         L/N1jz4+jVc6DCWZRSLJmtgQev/yTaNV7jcL5Vt2nS/aYQErDhLaVy7UY6kwJCcRAHqz
         kEZmBESV0LcVIZoOIRZcCAldNapZcMiZoQDBWeoYXq8v3DqFiGqQP7J2i5E1ujV1W+4q
         J5TLTTE1OMj22CiKLCPOCd/3/u0xBEvlokAGqR08sgy/a6TckbK0z6kMQCxyWaZQs5OB
         cMNB2aKv5FqEXrpV3Ak7ZDirrp1IfXlCVmJxAG/+DjYyBnWTaAzxQANLHO7Z3PymMbGq
         sdxA==
X-Gm-Message-State: AOJu0YxnOlFvJxwkFexi0eXEbWrDR6JsHPHpf7qIcXOzcoGCc3rsUx0W
	jBTWHQX5V1ELUEdYQfDZ65PiQA==
X-Google-Smtp-Source: AGHT+IF0n0k0xyVHlcaTzAiFBEkFfI2PFLOamIQl5zDA1qyTBDc0+oLn6UcUBAP/ylr8TZTxwS4Kgw==
X-Received: by 2002:a17:902:edc7:b0:1bc:2f17:c628 with SMTP id q7-20020a170902edc700b001bc2f17c628mr215330plk.56.1693501310549;
        Thu, 31 Aug 2023 10:01:50 -0700 (PDT)
Received: from ziepe.ca ([207.140.200.197])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f7cb00b001b9e9f191f2sm1493551plw.15.2023.08.31.10.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 10:01:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qbl39-000ITj-3G;
	Thu, 31 Aug 2023 14:01:43 -0300
Date: Thu, 31 Aug 2023 14:01:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Tina Zhang <tina.zhang@intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iommu: Introduce mm_get_pasid() helper function
Message-ID: <ZPDHd5LYeWa9avQO@ziepe.ca>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-3-tina.zhang@intel.com>
 <4d658766-688c-cda2-b4e1-60200a60a9b3@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d658766-688c-cda2-b4e1-60200a60a9b3@linux.intel.com>

On Thu, Aug 31, 2023 at 10:24:31AM +0800, Baolu Lu wrote:
> On 2023/8/27 16:43, Tina Zhang wrote:
> > Use the helper function mm_get_pasid() to get a mm assigned pasid
> > value. The motivation is to replace mm->pasid with an iommu private
> > data structure that is introduced in a later patch.
> > 
> > v2:
> > - Update commit message
> > - Let mm_get_enqcmd_pasid() call mm_get_pasid() to get pasid
> 
> Ditto.
> 
> > Signed-off-by: Tina Zhang<tina.zhang@intel.com>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 12 ++++++------
> >   drivers/iommu/intel/svm.c                       |  8 ++++----
> >   drivers/iommu/iommu-sva.c                       | 14 +++++++-------
> >   include/linux/iommu.h                           | 10 +++++++++-
> >   4 files changed, 26 insertions(+), 18 deletions(-)
> 
> Eventually perhaps we should have something like sva_domain_get_pasid().

There is never just a single PASID for a domain. That should not be
part of any of our APIs.

If we want to provide core code aide then the core code should have a
means to help the drvier maintain the attachment database for the
domain.

Eg maintain the list of RIDs, PASIDs, etc that the domain is linked
to.

But this is such trivial code I'm not sure it helps much

> Finally the iommu drivers only need mm->pgd, nothing else.

Yes, attaching the notifier and accessing the arch specific mm->pgd
should be the only driver touches of the mm_struct..

Jason
