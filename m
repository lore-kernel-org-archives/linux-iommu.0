Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691411C289
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="orv6mREI"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-41808baf6abso13359421cf.3
        for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 09:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697212894; x=1697817694; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ycfz2fLX4FtJIFsDC8CYB30J8XEDrSO+zwRiByrlXwo=;
        b=orv6mREI5aioufSdrFedfRdLjLpHlOFa8hN7kpohGmTBHTQBmZtq+zp2Q6TKydk5U9
         OtxiAc+nkiFWMxdL7/RlgxCXnZPcItVICmnxW6ZFsaTofnlBYgsMmq3Nf7sUbYGMT2oS
         dN70H2u/ulwZKhixIkkWYebd1NDf32Rn/zFR3S6DrFOxsZEjv5rhsThlKWvu6Lp8o4h+
         8ABX4yzF5aAUJcDmoyk++PU2lWET7vL138HZqZnQWBmSEOID6L2HNOagNEX1v4gNYgZ5
         HhCmT/M2oqjsaGlWdmKm5cLEsKXONyM3MvU55wVDU0B8bzLKXZZq1BkRY+pvnMLcamNb
         LVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697212894; x=1697817694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ycfz2fLX4FtJIFsDC8CYB30J8XEDrSO+zwRiByrlXwo=;
        b=RfzDzhaMgJrx8QXNQuL/Q/4VfUiFoygWgwm9t53bCCLV1KFJK3QZ+J7XQ7NmiYrKqW
         HhP6P/doeyCWdkBtaWHiQvy3NM5k+0pIZBg95VkxA1v4dO3zQru7jjdjf+OD616K33Qo
         siYPDfqkohqw/6ozL6jDRGRViTHhtZc+4Cdjso7RX8GE+fe9/WITsXwMZQ+lm5E9ykl+
         lkVBD+ePNOo9c/U9PbFiYpDYTaeVSmADqWJQS05FpfVRD19jwBizoSIebSZaUDhokH4R
         RTICZfL4XXHhei5a0kDDZgWftR0TpRRGCFEZK+Zi7rCPtK2/o/bZNZKo42nRgvX6+w35
         I8rQ==
X-Gm-Message-State: AOJu0YzK7YLW+rVVT0t1aGbJntdPWG6FfZsYdPtD/a6IRYxHgnnvU9zM
	Vj7JGOBX4q65/soQGLp1ZYowwq+aqDZbu8JSu7c=
X-Google-Smtp-Source: AGHT+IENz129YBVzGkqNJrwT7+I8VYcIjEdtwqBgXjrxowY/PMTxOvoVcK7YT9TFBkdxQJW4wV+cmQ==
X-Received: by 2002:ac8:7e90:0:b0:3f8:71aa:f11d with SMTP id w16-20020ac87e90000000b003f871aaf11dmr34713453qtj.37.1697212893928;
        Fri, 13 Oct 2023 09:01:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id d14-20020ac8668e000000b00419c9215f0asm703047qtp.53.2023.10.13.09.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 09:01:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qrKbU-001VPE-Jz;
	Fri, 13 Oct 2023 13:01:32 -0300
Date: Fri, 13 Oct 2023 13:01:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 06/10] iommu/amd: Refactor helper function for setting
 / clearing GCR3
Message-ID: <20231013160132.GB282036@ziepe.ca>
References: <20230816174031.634453-1-vasant.hegde@amd.com>
 <20230816174031.634453-7-vasant.hegde@amd.com>
 <ZQHRTwYN4doUte5E@ziepe.ca>
 <0d47919e-cc2c-d151-f020-e2090fd1c287@amd.com>
 <20230927164523.GO13795@ziepe.ca>
 <497df4d9-2203-ad36-a5d1-97570b327a49@amd.com>
 <20231010143829.GA55194@ziepe.ca>
 <2189b86f-903f-0b4c-d0bc-3632639a477b@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2189b86f-903f-0b4c-d0bc-3632639a477b@amd.com>

On Fri, Oct 13, 2023 at 09:15:19PM +0530, Vasant Hegde wrote:
> 
> 
> On 10/10/2023 8:08 PM, Jason Gunthorpe wrote:
> > On Tue, Oct 10, 2023 at 11:32:53AM +0530, Vasant Hegde wrote:
> > 
> >> __amd_iommu_flush_tlb() flushes both domain ID and all devices within the domain
> >> for the given PASID. So it works fine. All these functions are reworked as part
> >> of invalidation series. Hence this function is not relevant anymore.
> > 
> > But the replacement has the same issue:
> > 
> > static int domain_flush_tlb_range(struct protection_domain *pdom,
> >                                   ioasid_t pasid, u64 address, size_t size)
> > {
> >         struct iommu_cmd cmd;
> >         int i, ret = 0;
> >         bool gn = is_pasid_valid(pasid);
> > 
> >         build_inv_iommu_pages(&cmd, address, size, pdom->id, pasid, gn);
> >                                               ^^^^^^^^^^^^^^^
> > 
> > (btw I have no issue/comments with the invalidate series, it just
> > doesn't go far enough to correctly support the iommu core's PASID ops)
> 
> Invalidation series [1] is cleaning up existing code. Device oriented flushing
> logic will be introduced in later series.
> 
> [1]
> https://lore.kernel.org/linux-iommu/20231006101624.5912-1-vasant.hegde@amd.com/T/#t

I'll look

> > It needs to correctly implement the driver op APIs we have defined in
> > the core code. In this regard it does not "work fine", you can see it
> > by code inspection that it is not producing a correct cache tag in the
> > IOTLB for domains attached via op->set_dev_pasid()
> 
> Domain centered approach works fine (not just limited testing) for enabling SVA
> with DMA API mode in host. Going to device specific domain ID will introduce
> performance penalty.

That is exactly what I mean by limited testing. "DMA API mode" can
only excercise a small portion of the defined API.

We can discuss ways to optimize in the driver, but for now correctness
is more important. (I also don't see the performance penalty given DMA
API is already creating per-device domain IDs)

> When we support PASID with UNMANAGED domain and vIOMMU we do need
> per-device-domain-id.

You need it now before you implement any PASID support, it is part of
the API.

iommufd will support SVA and iommufd will not be limited like DMA API
mode. A driver must implement the defined API correctly from the
start. This is what I'm trying to explain to you as the threshold.

> Anyway for now I have introduced per-device-domain-ID for
> as soon as I put device in V2 page table mode [2].

Great, thanks!

Jason
