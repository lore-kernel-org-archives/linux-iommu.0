Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FEB1AB6F1
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244173; cv=none; b=an9YEZkO9QY0VlG/oSuFLypTFXdD58DHSRzyyk+wPAN3l7SfedLIidWhhZoyk0EMRj2xQZWqx6Z0GGlJFUADnvV5fcLkQSRX5rzRYPol0PnWrVkYDSmdpuf3zPd6/P9HmKF1u334jRLo5z/aWOEI/hytu27E5o+CeVB6Ps7+/+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244173; c=relaxed/simple;
	bh=F+2PpfgjzAxd5eTgzmtA9811HRwzmk6SihyZQnBi8BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mh12ht17HbYnFaHAacnRmr3IkfxU+sTC3aqftHg1h4Bb39F8FKyprrTNCokUmqOlxPN2C//wji6qeCHD0yClM8uIa6xqPzNmc3AFmiJVnGg3fGBK83O5bglGzdNx/nWIwEjxfiCJg61tiMc5ECFWvOtctRUYj9g1c2pdlh3IN3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M8U6GUIQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M8U6GUIQ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2681645b7b6so160775ad.1
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759244171; x=1759848971; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H4R6lGWGAQ1gnxosb2gwPcgs8a9GrC1uXsCsflzO0H4=;
        b=M8U6GUIQaHROW9YvdEwpYupJ8xAxUoj0t09uZrIQyPzoFiPe0voRptJNLpsGEdmtvk
         GjiZC57N/3AIufTd8zo7qQnMm9aWN8EPc6Wqg+nm627zvUpmy9AHPArBrz6H7chdAlPt
         jaIw6cs2vCwv39aAAvlNuCxMT8OLQBV/BS9wswEwAGKCDNtJGJBPFOIQxnnzSHfUhWq9
         UOz/UzfDWyx6fcMk9cXPmmV7VKFLmX8QXyHRvDuep7k9kM7xVk1MQ0uPT50ddoSs9Oxg
         xEYOtvPN+mYW/AbKxeFJsRY0l4VHDGJXoRjsj0cXC/QLCXOWlz49VqS6prGRp2/o63WD
         sjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759244171; x=1759848971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4R6lGWGAQ1gnxosb2gwPcgs8a9GrC1uXsCsflzO0H4=;
        b=vT4MOUkTG4rvgYHoBVj5htCPxs/6OVJ6FcLScGaztULqb0zgiRwJcXTHKuW8y3oGKh
         8qFCCChk0Bt9z/WgQGCLm3yZJL/jCOCC+1dbXxM0U8Wwdzh1QthMlm5mwkWYlkeWlD0Y
         s1dlOIE5CV60LyKA7nF0tqO8oE8q3jg6+M9BXJoTZ0nkqN96e3y3wmmDYTmjJwGxsr0+
         kMV3XJ8D64EwkiYQT0XSxCIHFBvVF9SvHs/MMqm91ImnwnSqcwjyuWL483tEB1yi08gp
         M9eLFuVtgZtT+QzJZ/iq+n5tt5zQIbjSR0gRxW5sGk3mNqOeIu5CKQHgE0qsTJUyvN4E
         GmZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbrfdSu66A1Vst7Vw5JilpWVyJD9/koV5H7ePUlSyuyFKdO5wpffW0bQ/sUtnNhirYsQTqow==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHvFgp4LRuwVWbWbBgtsfrZ8GhloETQk6HbjPQU+H04fKSspKE
	5qtS7VwPPfu3pTqfh+WDUzKM38tVBB02PvCDctNFYSdD+tqL5JXxmQ1jujHyesbsmw==
X-Gm-Gg: ASbGncs5ANs8dQzLK5l1fQ62zBeSdYKPyfeDcC1f+OkzfxIXefSrW775c/L+olGM6GQ
	3g3EgSFMBXi7YNKyUD2cGywnbafbpj9HHvW3+zQdmbJrvgaAWxnHrubuQ4jVnYL6YuAowO90R3F
	hACW5qaZFZaxfZjWZMJML2U4kL9KxfjfPN2jYkSjCBk48O+LwJutGr4wDAw7ALyplrBPQsDaMR+
	n/nPS7OG5k2hw137Qrx/FX8EIu0dfhpn+VU3bc2PCLW66SWvfxd5wE2YFPKWqvxfEzX2ZSLqYt0
	H5JK627tPkcGmXSiypG/dG/Zp81pPai2Qy73NAsRopxKkn77vtBOts0IKLTKukncVZAR2ixVcuT
	jXsnx7k8hRazwSo1FWGHgQzr+zgthineaIZutA8QGUrp3uOE79GVUWxFtsFB6DAXKM3FSGhhcSJ
	+UGCqHyhaGtPHFAMz0oCXpJQ==
X-Google-Smtp-Source: AGHT+IEKto9Z/ZQPK+LiszayWv4jowiWlKBwakXzvWFsQoNBQ3FBBuXDg73TnRLqqEz8s/+/yr7S4Q==
X-Received: by 2002:a17:902:f64d:b0:28d:195a:7d77 with SMTP id d9443c01a7336-28e2f8a16e6mr5318465ad.16.1759244170301;
        Tue, 30 Sep 2025 07:56:10 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c1867sm14193305b3a.35.2025.09.30.07.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 07:56:09 -0700 (PDT)
Date: Tue, 30 Sep 2025 14:56:04 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Daniel Mentz <danielmentz@google.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] drivers/arm-smmu-v3: Implement .iotlb_sync_map
 callback
Message-ID: <aNvvhFsfySp9mW93@google.com>
References: <20250927223953.936562-1-danielmentz@google.com>
 <20250927223953.936562-2-danielmentz@google.com>
 <20250929115803.GF2617119@nvidia.com>
 <aNp6fJNoehs8hMyF@google.com>
 <20250929124719.GJ2617119@nvidia.com>
 <aNsjFm56D8pnAKDp@google.com>
 <aNuieevIo9MuzBq2@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNuieevIo9MuzBq2@google.com>

On Tue, Sep 30, 2025 at 09:27:21AM +0000, Mostafa Saleh wrote:
> On Tue, Sep 30, 2025 at 12:23:50AM +0000, Pranjal Shrivastava wrote:
> > On Mon, Sep 29, 2025 at 09:47:19AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Sep 29, 2025 at 12:24:28PM +0000, Mostafa Saleh wrote:
> > > > On Mon, Sep 29, 2025 at 08:58:03AM -0300, Jason Gunthorpe wrote:
> > > > > On Sat, Sep 27, 2025 at 10:39:53PM +0000, Daniel Mentz wrote:
> > > > > > @@ -3700,6 +3713,7 @@ static const struct iommu_ops arm_smmu_ops = {
> > > > > >  		.map_pages		= arm_smmu_map_pages,
> > > > > >  		.unmap_pages		= arm_smmu_unmap_pages,
> > > > > >  		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
> > > > > > +		.iotlb_sync_map		= arm_smmu_iotlb_sync_map,
> > > > > 
> > > > > Shouldn't this avoid defining the op on coherent systems?
> > > > 
> > > > Does that mean we need to have 2 iommu_ops, one for
> > > > coherent/non-coherent SMMUs, as both can be mixed in the same system.
> > > 
> > > Yes, I think you'd have to do it with two ops..
> > > 
> > > It just seems wrong to penalize the normal fast case for these
> > > systems.
> > > 
> > 
> > I see we plan to set defer_sync_pte = true always. What if we invoke the
> > ops->iotlb_sync_map() only for incoherent IOMMUs? Maybe something like:
> > 
> > static int arm_smmu_iotlb_sync_map(struct iommu_domain *domain,
> > 				    unsigned long iova, size_t size)
> > {
> > 	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
> > 	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
> > 	bool is_coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
> > 
> > 
> > 	if (!ops || !ops->iotlb_sync_map || is_coherent)
> > 		return 0;
> > 
> > 	ops->iotlb_sync_map(ops, iova, size);
> > 	return 0;
> > }
> > 
> > If needed we can push the coherency check to the io-pgtable op
> > iotlb_sync_map() as well. Just an idea..
> > 
> 
> iotlb_sync_map is already NULL for coherent SMMUs, I beleive
> Jason's point is about that the iommu_ops.default_domain_ops
> will have the extra pointer which will be called by the core code
> anyway, which immediatly returns; wasting some cylces.

Ohh okay, I see.

> To avoid this we can have 2 sets of the default_domain_ops for
> coherent and non-coherent devices, to be chosen at domain alloc time.
> 

I guess it'd be better to have non-coherent def domain ops then.

> Though, It would be intersting to measure how much overhead does the
> current approach have in practice, maybe through dma_map_benchmark?
>

Yes, dma_map_benchmark can be used but its results won't reflect the
impact on scatter-gather workloads since the benchmark doesn't cover
dma_map_sg IIRC. I believe even a small per-call regression may get
amplified at scale though.

Thanks,
Praan
