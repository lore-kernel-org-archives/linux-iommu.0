Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B6D1BEEE
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 18:13:09 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6bca6c06e56so2211659a34.1
        for <iommu@lists.linux.dev>; Fri, 04 Aug 2023 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691172788; x=1691777588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HWapriQBKyOQaylwdOEIMCAKtuFPfG90G2uOIkliPVM=;
        b=do52FAxG0NdOnrOJFgOQCbGyEDIfuWMWdiC7EBbnTClcidnkL+3dvrfwfkm7XbHY3p
         YX2sfw4kOQLS4o2EiIxWPcSeXkGBhxXMdGZuG3tRn4KBSQRl0gZMSU7cs590IqXzvt+E
         /rYVe2qe+ncmfWjc3+Rg7X1qVuHcX97vDnLbxAUqOyaGIpLIu5/CEs3JY2iFMOtVBE83
         H+7BHEcjwlcad5UGQQrr9u6RIxi9Ilp5RW0Z3NGdocKyxAXt2PUzwuPSzpWHd1b/5AlW
         Jl4WRNDXrboRA4B0W099TveWtxJOiXZBJl24sfy2OKwZofC6/w46rRihmWhGqlagQrAC
         kjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691172788; x=1691777588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWapriQBKyOQaylwdOEIMCAKtuFPfG90G2uOIkliPVM=;
        b=B6JaleWzmLp2+dJsokDFCdF43SQshUyGTmRb1RjGVdP0w29tw1NrbpWXJEIJtJr8PR
         YXw6X7JRa4l9ZHNNScvQ+7jraYZauBEeheQoWaLYW/M9UF5+X8kxihHE8yReRLJfgbvW
         Igsj30cB0wmR5g3+m3T1+u4FQX+79Fdli3fsz8oHVNCupqPdBT9cJ/70Nbh9qSXHKH6A
         8ti7Csgv7c+OJAyUvmfiulPP8M0iHt1enklXXmdSeflwSbgSZOQBjkSVyXd5rayO5WLo
         vgMK+mRdE0tOx+sdXq0FMaS6q8ODM6S5uIZQRqARDyR/LIYHNsFhAvpJeP8XVa5k5Zpe
         h5Yg==
X-Gm-Message-State: AOJu0YwZ6eQi9hcbZlC4cNQVIDGcPKLh9fMzCy+gBF/IBFWQpoHHuyI+
	buYJDdjuNRJVOiwqVO5ZLP+4Aw==
X-Google-Smtp-Source: AGHT+IFokwKDq7zOkQqM7uC6YxM8UlsWZZ6Gb+wrMZ0Yrq2GjKReTodL+YXEhynw66z1Wt17fcBCxg==
X-Received: by 2002:a05:6358:711:b0:134:ed9b:15a7 with SMTP id e17-20020a056358071100b00134ed9b15a7mr2033635rwj.30.1691172788136;
        Fri, 04 Aug 2023 11:13:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id e16-20020a0cf350000000b006300ff90e71sm828485qvm.122.2023.08.04.11.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 11:13:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qRzIR-003vvi-4F;
	Fri, 04 Aug 2023 15:13:07 -0300
Date: Fri, 4 Aug 2023 15:13:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 06/16] iommu/amd: Introduce helper functions for
 managing GCR3 table
Message-ID: <ZM0/s6EkkT7eaehF@ziepe.ca>
References: <20230804064216.835544-1-vasant.hegde@amd.com>
 <20230804064216.835544-7-vasant.hegde@amd.com>
 <ZMz6fyAtKhuTk7HZ@ziepe.ca>
 <9564429b-e2ce-4ad2-aaf9-5f237bfaf87f@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9564429b-e2ce-4ad2-aaf9-5f237bfaf87f@amd.com>

On Fri, Aug 04, 2023 at 10:21:41PM +0530, Vasant Hegde wrote:
> Hi Jason,
> 
> 
> On 8/4/2023 6:47 PM, Jason Gunthorpe wrote:
> > On Fri, Aug 04, 2023 at 06:42:06AM +0000, Vasant Hegde wrote:
> >> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> >>
> >> Refactor domain_enable_v2() into helper functions for managing GCR3 table
> >> (i.e. setup_gcr3_table() and get_gcr3_levels()), which will be used in
> >> subsequent patches. Also re-arrange code and remove forward declaration.
> >>
> >> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> >> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> >> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> >> ---
> >>  drivers/iommu/amd/iommu.c | 66 +++++++++++++++++++++++----------------
> >>  1 file changed, 39 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> >> index d5569eec0fe9..135fa087ce47 100644
> >> --- a/drivers/iommu/amd/iommu.c
> >> +++ b/drivers/iommu/amd/iommu.c
> >> @@ -77,7 +77,6 @@ struct iommu_cmd {
> >>  struct kmem_cache *amd_iommu_irq_cache;
> >>  
> >>  static void detach_device(struct device *dev);
> >> -static int domain_enable_v2(struct protection_domain *domain, int pasids);
> >>  
> >>  /****************************************************************************
> >>   *
> >> @@ -1575,6 +1574,43 @@ static void free_gcr3_table(struct protection_domain *domain)
> >>  	free_page((unsigned long)domain->gcr3_tbl);
> >>  }
> >>  
> >> +static int get_gcr3_levels(int pasids)
> >> +{
> >> +	int levels = 0;
> >> +
> >> +	if (pasids == -1)
> >> +		return amd_iommu_max_glx_val;
> >> +
> >> +	/*
> >> +	 * Number of GCR3 table levels required. Level must be 4-Kbyte
> >> +	 * page and can contain upto 512 entries.
> >> +	 */
> >> +	for ( ; get_count_order(pasids) >= 9; pasids >>= 9)
> >> +		levels += 1;
> >> +
> >> +	return levels;
> > 
> > You missed to use the DIV_ROUND_UP
> 
> Sorry. I wanted to add comment to few patches separately. Somehow it got missed.
> 
> In our case,
>   00b=GCR3 table is single-level - PASID size 9 bits
>   01b=GCR3 table is two-level - PASID size 18 bits
>   10b=GCR3 table is three-level - - PASID size 20 bits.
> 
> Hence I didn't include DIV_ROUND_UP().

You literally coded a for loop to open code division :(

   levels = DIV_ROUND_UP(get_counter_order(pasids), 9) - 1;

Jason
