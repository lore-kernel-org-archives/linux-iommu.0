Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B863B3
	for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 13:20:25 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-686f090310dso1795698b3a.0
        for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 06:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691760024; x=1692364824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXPS/ZmwRr4ua4rZKlExOYiRUNc+7N1aw+T2ktT+PjI=;
        b=DR6aQWGZGVHBs3FkG//6eAAbrwBk2N4DUxR36CaaYy4Am4qe8u6M1Ib+SYc3zZhTxd
         iSKJjCp1xL0YRX5pxPMG1Hdc57yMxfpeRfmb+GjrgXQOc0ujT8WhEaAxVcRzZa0GH1nq
         zps83RcM6l7EScWqEXNYsp+rX7v2/vJjSMKBACqYwgmWsDRMgiKNvnzhFlxoKx/IV5HN
         UXftlKGp2QnKcEOnQntN8ZMHzrGLvqxyORow2FLdCXDxsgITOeOP7jMsyoO1tKG/o3ey
         fhIx7DUQN58sR8/qlTHZSNo1YLdwqWkeA33P0dxplFa9Gz8G8ZdgdWMyzQOYZihI4lkm
         gpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691760024; x=1692364824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXPS/ZmwRr4ua4rZKlExOYiRUNc+7N1aw+T2ktT+PjI=;
        b=ZrqT31v7crhn0uqHQcQuGiswuq1PtY08wtyrgkiZEcKVHBkIEMo04IC/+jIEvqNXZG
         3pyAXZyts6xuWVXI+ffqypgQyb1RAIAdQTJpmUoX+0vR2VrddSD4Q53sEIy0WM0dmqNr
         nyFSh3NgBG+KcfJmtMQD1maoZbldlBWW7/8FZ0gEIgDc+oZQ69vMjGCV4dolwGboscaU
         hjqnoHYt8Y2Ld5nr3S0f+EOw5iVHOIROhBJH9npJdTO9tJ1h1Mw0n8xFRBDwbgW2pMQR
         ZpglGdH8Knxcps5yCazqZKb4MZSZUFjyVau6VfZLqF04Ro4Iyn/KJJ1DQXF9c1UDZ/J+
         ZKtA==
X-Gm-Message-State: AOJu0Yxs1F2+DTkeOFeYc9bvIJWI+Y0fL7E5M3Klb4V9wL+2oqgnNiLR
	J93wM/Ky/ETiy0prJFO2s4FQxA==
X-Google-Smtp-Source: AGHT+IHPhpN1LHHybOsv38sSoXsBFKL4rQV8NJcC+EVyht1bVtcKmZl9knrcIbBhEzUzELAYNckpQg==
X-Received: by 2002:a05:6a20:a103:b0:141:a70:6c26 with SMTP id q3-20020a056a20a10300b001410a706c26mr2652265pzk.57.1691760024584;
        Fri, 11 Aug 2023 06:20:24 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id d5-20020a637345000000b00528da88275bsm3360055pgn.47.2023.08.11.06.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:20:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qUS3y-005R5K-PM;
	Fri, 11 Aug 2023 10:20:22 -0300
Date: Fri, 11 Aug 2023 10:20:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH 06/11] iommu/amd: Refactor helper function for attaching
 / detaching device
Message-ID: <ZNY1ligeAdFmILoT@ziepe.ca>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-7-vasant.hegde@amd.com>
 <ZNJhw8RRvJZ+R61y@ziepe.ca>
 <f08fc678-0bff-1e3a-302d-f673c952462d@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f08fc678-0bff-1e3a-302d-f673c952462d@amd.com>

On Fri, Aug 11, 2023 at 03:37:25PM +0530, Vasant Hegde wrote:
> Jason,
> 
> 
> On 8/8/2023 9:09 PM, Jason Gunthorpe wrote:
> > On Tue, Aug 08, 2023 at 10:02:27AM +0000, Vasant Hegde wrote:
> >> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> >>
> >> To use the new helper function for setting up GCR3 table.
> >>
> >> If system is booted with V2 page table then setup default GCR3 with
> >> domain GCR3 pointer. So that all devices in the domain uses same page
> >> table for translation. Also return page table setup status from
> >> do_attach() function.
> >>
> >> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> >> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> >> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> >> ---
> >>  drivers/iommu/amd/iommu.c | 54 ++++++++++++++++++++++++++++++++++++---
> >>  1 file changed, 50 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> >> index cc42732820dd..4fed3fbe069e 100644
> >> --- a/drivers/iommu/amd/iommu.c
> >> +++ b/drivers/iommu/amd/iommu.c
> >> @@ -1821,15 +1821,41 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
> >>  	amd_iommu_apply_erratum_63(iommu, devid);
> >>  }
> >>  
> >> -static void do_attach(struct iommu_dev_data *dev_data,
> >> -		      struct protection_domain *domain)
> >> +/*
> >> + * Note: This is currently used when booting w/ amd_iommu=pgtbl_v2
> >> + */
> > 
> > I would drop all this commentary about amd_iommu=pgtbl_v2. That
> > command line option should be removed.
> 
> AMD IOMMU can boot with PT, V1 page table and V2 page table. We need a way to
> tell what page table we want to use. Hence we have these command line options.
 
No, you don't, it is wrong.

PT or not is controlled only by the core code using existing common
mechanims. Not by iommu drivers.

For v1/v2 kernel needs to automatically select the best page table
option, not try to make an admin figure it out with a command line option.

I expect it to be removed in due course.

Jason
