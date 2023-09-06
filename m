Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474E9DF5A
	for <iommu@lists.linux.dev>; Wed,  6 Sep 2023 13:44:51 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-54290603887so2254257a12.1
        for <iommu@lists.linux.dev>; Wed, 06 Sep 2023 06:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694007891; x=1694612691; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vjmXiVfaEDODvjU2FievJvSdcMcGvy4WGcnM9/YFUIw=;
        b=g1JCicY3ZkZVAzJ1t1kROx8GpZ1unpsdvRNQO6ecP9HHBrRe0zLAhO8iYD8+A7gYYJ
         Pi9IZeoPE9bbVySxNt1+Ei/PsuVZu0Qy7l5QhbS+DeuZUILmZeBfraI8vDqFf1WM1Y0j
         X2EQlkJAlwJ6Ll6tJLE9OI+DU7W/mdO5g01nwG0Hteo840HbMeUbroGI5NCBULdsu6ci
         fpPMBHBlDFB1k7RitFOjIMGtG5xkP3zvkIuFdrZNEXLvlAqzFtMirjKkHzzwEmXiRLow
         z/mB4riRnwp1jFZ0Ao3hSc54sZWvy2l4B7/MpQs9x3Fxi+NKjf5wZBZ7yoJDhZqJRdN1
         qMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694007891; x=1694612691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjmXiVfaEDODvjU2FievJvSdcMcGvy4WGcnM9/YFUIw=;
        b=FEwwP+keE78Lf4CHOdSLZBSJTaFQIQTlBmef4GqAMj15LLyWs52XOmX8Cocd9ka3ma
         Glcz1prbPb6mjCgOEG6mKQK3rLQT4VMlBAvxqWuxXFhv+c5GxYd3YUecGTgjbwV+qTUB
         5v8AIS3IKK07AX2UV680S/8tvAB82rhhcy8CUvAgh8vORHEJDD0gmG9NJKFFLUWIPRDi
         PeJWk84uMv3R/e4piTfF9nV7oejJLsR2KfBAVBVrWg2AWbZ8bW821uDauJ7AG1dB80OD
         Lgwm76U4mv5rzeCr4YsinOWPe2qFfT+RnGf9qz7z+FLmCftOWrI5EY3hC8QhH89H06W2
         l6IQ==
X-Gm-Message-State: AOJu0YzdHK91eWsmQSUxKbwrhkJaqNA3C6DLvHRoAjcnvyx4Q2CFY1lS
	ccy1PhGKj6WUEhVWaU42Xq8ePA==
X-Google-Smtp-Source: AGHT+IEL+RpSURCPPA5o67iyCeVVmbxChqKlkrpULXGfrkmSIXOBkNGq1NxIr8VMJglhyURY9OigNQ==
X-Received: by 2002:a05:6a20:12cd:b0:153:556e:a78d with SMTP id v13-20020a056a2012cd00b00153556ea78dmr2617805pzg.43.1694007891529;
        Wed, 06 Sep 2023 06:44:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id e14-20020a62aa0e000000b0065980654baasm10950757pff.130.2023.09.06.06.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:44:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qdspt-000yLt-Ck;
	Wed, 06 Sep 2023 10:44:49 -0300
Date: Wed, 6 Sep 2023 10:44:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux.dev,
	baolu.lu@linux.intel.com, Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2] iommu/tegra-smmu: Drop unnecessary error check for
 for debugfs_create_dir()
Message-ID: <ZPiCUcxaftqCi4UJ@ziepe.ca>
References: <20230901073056.1364755-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901073056.1364755-1-ruanjinjie@huawei.com>

On Fri, Sep 01, 2023 at 03:30:56PM +0800, Jinjie Ruan wrote:
> The debugfs_create_dir() function returns error pointers.
> It never returns NULL.
> 
> As Baolu suggested, this patch removes the error checking for
> debugfs_create_dir in tegra-smmu.c. This is because the DebugFS kernel API
> is developed in a way that the caller can safely ignore the errors that
> occur during the creation of DebugFS nodes. The debugfs APIs have
> a IS_ERR() judge in start_creating() which can handle it gracefully. So
> these checks are unnecessary.
> 
> Fixes: d1313e7896e9 ("iommu/tegra-smmu: Add debugfs support")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
> ---
> v2:
> - Remove the err check instead of using IS_ERR to replace NULL check.
> - Update the commit message and title.
> ---
>  drivers/iommu/tegra-smmu.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
