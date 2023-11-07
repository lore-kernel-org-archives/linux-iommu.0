Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1703A2D796
	for <iommu@lists.linux.dev>; Tue,  7 Nov 2023 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OVbefJEx"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6cd0a8bc6dcso3631100a34.2
        for <iommu@lists.linux.dev>; Tue, 07 Nov 2023 05:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699363709; x=1699968509; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DfhDx5tzpp+vZxgrELyME2o73CjluSnAr0PRfsry6TA=;
        b=OVbefJExcIfhstYgnFFn443QDrzOGx9GyoUF4fq7Dng/k2G3fkV0vfnVvBAP74vxgP
         ebcbgyKzyKvcm8Y59Au+32hapXVi+lGYON3gRRIz7RxFBK6XDwby5qDYzARpWTD3a3RJ
         jh0IREhgHcIMadipjcwJHRKSLUhMxtQBt8OsifxORweI2SsRAb+j09Az/5CmI3B5VyEB
         awquvqoVIGuPRBqna+pZAb0QABOi+UnkYvQBXB4tc00QgDSYJdIJ2iSJp0rbMVx0vuSE
         ei0oed6pLaA4Ij/QNJs9o9K7TqXneHp/ndE7ipIQeqpI+suq1nPZh2zntOjUEpFK6yy5
         Memw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699363709; x=1699968509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfhDx5tzpp+vZxgrELyME2o73CjluSnAr0PRfsry6TA=;
        b=Zo4pv6VmsVaGiY8c3z7Zj3J9/PKJ6R2g8aadVOqq4Pb+KyoGiz1z17Zw7QODr4oGt2
         kpmgKp0/iV/XQ4xUjrdZUterB7qgVHCfKeGaAdO6n8tT/Q4IQBVsMyHwnTU4nwYyZjXs
         OadqN6UvznXIH1gArboT8/FbveHLVlbydKjPFvDRd7w8aqYxE8unOuTq/zJZV/fF/kVF
         0PiPapWhfDGHztNzsewK0pYMcfppZYNZiJGJZuDMXMcIOedHuM7QXiRr1MHRZ351lpkd
         MKK7QTrOgQuEUlNF4lx2kbXQIh4CChI1amwSa7qyfumnKqhTkJwZrr9p1fyf4fentyfw
         tECw==
X-Gm-Message-State: AOJu0Yxk4dwRom1Ds/YaZ1lKLFCejeZLUntQYuDbx7YmEH8gLFoJgHtq
	pF3X7iw4YxXMklrgnStmG+KflA==
X-Google-Smtp-Source: AGHT+IGaoY78TWGT3TBRxuZrey4aD2XMFTifuUS6uOjBse+OIRQqWA5Tr8SSO5qQT06d4fOT8DCggQ==
X-Received: by 2002:a9d:7dd9:0:b0:6cd:7f60:7791 with SMTP id k25-20020a9d7dd9000000b006cd7f607791mr32494249otn.37.1699363709038;
        Tue, 07 Nov 2023 05:28:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id x3-20020ac87a83000000b004198f248e8dsm4327299qtr.76.2023.11.07.05.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 05:28:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r0M83-001Vhk-W9;
	Tue, 07 Nov 2023 09:28:27 -0400
Date: Tue, 7 Nov 2023 09:28:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 10/13] iommu/amd: Refactor helper function for
 attaching / detaching device
Message-ID: <20231107132827.GY4634@ziepe.ca>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-11-vasant.hegde@amd.com>
 <20231106172931.GM4634@ziepe.ca>
 <f23aaa41-b22e-b274-5774-6317ba643e8a@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f23aaa41-b22e-b274-5774-6317ba643e8a@amd.com>

On Tue, Nov 07, 2023 at 11:25:49AM +0530, Vasant Hegde wrote:

> >  RID domain=BLOCKED & PASID - ?? [V=1, TV=0, GV=1, GIOV=1 with GCR3 entry 0 being non-valid] 
> 
> I haven't thought this scenario. Why do we even need this case?

It is triggerable by iommufd, it has to be supported.

You understand I'm going to insist that *all* of this is fixed before
you can progress with any new iommufd features, right? We must have
drivers implement the APIs correctly when they are exposed to
userspace. I sent patches fixing SMMUv3, we will have to make the same
fixing for AMD and Intel too.

> > Did I get it right? If so GIOV should ultimately be deduced based on
> > what domain the RID has?
> > 
> > Look at how the SMMUv3 stuff ended up. Their STE is the same purpose
> > as the AMD DTE. There are alot of combinations here, it was hard to
> > make a code flow that was clean. It turned out pretty good when the
> > DTE was generated in the ops->attach based on a calculation of exactly
> > what the current configuration is, because we already know what we are
> > in alot of detail at that point.
> > 
> > eg we know if we are attaching an identity domain and PASIDs are in
> > use that a single specific DTE should be created. So just call a
> > function directly to get the required DTE.
> > 
> > IOW - I'm not sure it really makes logical sense to store giov in
> > gcr3_info.
> 
> We had a choice of having a giov flag inside gcr3_info as it tells how to
> configure GCR3 related bits in DTE -OR- having a extra logic to calculate it
> every time. I can be calculated.

The codepath that determines the DTE will know already what the value
should be. Again look at how SMMUv3 turned out, the GIOV is very
similar to S1DSS.

> >>  	dev_data->domain = domain;
> >> @@ -2080,11 +2103,27 @@ static void do_attach(struct iommu_dev_data *dev_data,
> >>  	if (domain_id_is_per_dev(domain))
> >>  		dev_data->domid = domain_id_alloc();
> > 
> > At some point this is the wrong place to put this, the domain ID is
> > logically associated with the gcr3 table, it should never be used if
> > there is no gcr table allocated, and it should be freed once the gcr3
> > table is freed.
> 
> Domain ID is decided based on page table type (and may be based on PASID later).
>  That's why I have a function to decide whether to allocate ID or not and it
> should be done in this path only. So that we can configure DTE.

The page table type determines if the GCR3 table is loaded, the domain
ID is needed if the GCR3 table is loaded.

Logically the domain ID is part of the GCR3 table.

Jason
