Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EE718CC11
	for <iommu@lists.linux.dev>; Thu,  8 Aug 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122500; cv=none; b=YMj2L2D84nr1HJnhQjt6jRWNw+3oJKDK+0dUZ9zQqYoUUP/G2Ubwt9fBtj37h/aJWdHya8DZhEAi84rFhBKQRhS7GDEJDTEDJXEd5umwma+GrIN5mSFo3SBTZz/UIUqbvOFF9uzWOYV+iT3E+Od44Z5NJYH6fVK4OMAONU376F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122500; c=relaxed/simple;
	bh=3veunKM8nIt0HqNk1/nTOxdI95E1p0XMNGx+GTTRbzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzwibvsnADlxnQC+i8cABqoWVMgnjW+Z5yMz9K2YiAs8c9oVagqUcSOTV9opa52qdJrUV74E1ksVn/ESint01mVC29mgBMu8c+IbB/XfMBZ7JpnXub8kf6UZTBjXG/QmgBWeCL7thUQbR0HM3WFS71TN/l1a4E8XfUrcwggjz0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aTocG7mv; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aTocG7mv"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1d81dc0beso57617785a.2
        for <iommu@lists.linux.dev>; Thu, 08 Aug 2024 06:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723122497; x=1723727297; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nlfi3jmFTXPt+oEKMAh63QSvPGG0kU6p8K291my08Oo=;
        b=aTocG7mvumO5UHBlamD/I5wR++L5n0u97P3tpFGuQLv9xlMvlzEGaAZ0T652hBlduK
         gXjq41Z9mhBxB34uGttHsOMVY31CAX3sdDlynNlq65rdYm2xTENi0Es/f6m+Hz//TvSf
         w8hXljJ0e+pU+5Z1TZ3ZQXiTRWTa7c0UudC2eT/6tT+c3ayUfBxPRbVmUp+QEUsWb5mw
         mZXL6ch2qN5Xr2QME4lcTpvD5X15CjAk+SUPhoPfkP7pJ7y/04bfzhGiWRMkWQ65kZct
         06NuATH/tAcLhCHgEzhIgcOhDTsxNn6FxijLDpfXzzVtj+Q92kWp0a4rfrOOmetwr88F
         6WGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723122497; x=1723727297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlfi3jmFTXPt+oEKMAh63QSvPGG0kU6p8K291my08Oo=;
        b=mELHDOZTbYkqPkN6M7T2xs457HhrQ4k/vEmQjTFEFUFnkdSaK/COLzD6CMfM39MVfU
         LMJLj7rknHwLdS8RfsU8TChImhC3x9O9yh7QXWZUDx116cqz7luXfPKK9dqvJwYAuL0t
         o8f4psN4ohAWw6U2IhBUHo3rM1qs59temn0MxO5wy/t7J2kuIJqmRaqdcs9Fk78o6XY3
         IB0pHYZWcuGQ0Gy9P1zyvWE0ipvoxGygtnm5koglkBi0i3Fw4UgtaN9lPsXiC6GJgDrk
         TfAX08I752PZukbugUGHIJfQdMW/XT6hGNwpwmjTbwntxiDqGxQ3YOBhRfivSC0G5sF0
         KmjA==
X-Forwarded-Encrypted: i=1; AJvYcCWtsWozDIMx9aell1zI/qf4dBNC2vmoKGKphXUs6YrDx5KL+ghpMAKLgzXFjwwwiw6c/HbZoXrnV6wp0hi1ZoYoVSeO38k=
X-Gm-Message-State: AOJu0YyKLiPQ7VYfMxEN9aR3pKQ2Vd/YYR/unABYFf4BhbJUZEZ9Xgh4
	QSiyZCZDgV4tHZl2yLQI+Gh5bzUTS8/ec76yOf+k7L0Zr9/2ZNlF3coChCve7Vo=
X-Google-Smtp-Source: AGHT+IE5nXKMUXHOd3VpBUaSyAn22UZbXraCMae36xDzYJq2BlLnirSaBMnaT7Xccw7tYsnDT5Qz8A==
X-Received: by 2002:a05:620a:4002:b0:79d:7cfb:884e with SMTP id af79cd13be357-7a3817abbe5mr238928685a.4.1723122496776;
        Thu, 08 Aug 2024 06:08:16 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785e2ae3sm158403585a.37.2024.08.08.06.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 06:08:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sc2sI-008tMD-Cx;
	Thu, 08 Aug 2024 10:08:14 -0300
Date: Thu, 8 Aug 2024 10:08:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
Message-ID: <20240808130814.GA1985367@ziepe.ca>
References: <8e531f39-9d14-4d3b-8a52-c2e8ca026f9e@linux.intel.com>
 <098008f7-2b3e-405a-a096-947e5df560e6@amd.com>
 <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
 <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca>
 <20240808011629.GJ8473@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808011629.GJ8473@ziepe.ca>

On Wed, Aug 07, 2024 at 10:16:29PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 07, 2024 at 03:29:47PM -0300, Jason Gunthorpe wrote:
> > > @Baolu, Do we need to make any changes to intel driver?
> > 
> > I think Intel ignores this issue, they have nice HW and their RID can
> > use both of their supported domain formats in all cases.
> 
> On second thought it does need to accept, but ignore the new flags..

And probably HW that does not support PASID should reject the
IOMMU_HWPT_ALLOC_PASID flag at least.

Maybe IOMMU_HWPT_ALLOC_DEV_PASID can be reasonably ignored if the HW
doesn't support PASID.

That would mean the SMMUv3 hunk I sent doesn't have quite the right
validation.

Jason
