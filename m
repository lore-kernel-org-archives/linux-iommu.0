Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE761EE7A1
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742455531; cv=none; b=r2EKNGo/4Me3hqSg2ZL9aGlwtTud3kGS7BEsCJE/RHJqg9jdEXd+MJIZY+dKJ5NbAOJAYryNbRtaq3wjzSJ+1ZeQ0wSBWbkuRVfLhVnIvcPQpbWlS1lxAmKyPBV7Xx09HTgEl/ny913j8mnQ6j56B6P3o09u/Jwmcp05EMbGBow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742455531; c=relaxed/simple;
	bh=Afr1GH9tL1luWC71y9L/q0LNPFsbcN+nsNxWQJRlFjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrictqdCCKPmU5+c12FrVhrfpyN+3WQw92Jkd9nUAp9gH2SVktwCLQG/9Ew3AoOpoe9oh1e2DFXakSLI1HCETsNO1GNesVBTQLanPzgs2uvwnVKzsPqH2KQcR5AOCI1j+OqjUpz5C6nJDN6y92PAsQ1M/m2EAImYuwMvH2Eml7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wn1/G5np; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wn1/G5np"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2263428c8baso102115ad.1
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 00:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742455529; x=1743060329; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MS6MAbgYesW5WGSakhAHYwH43HMZi8cWhVXf+Y1buQ0=;
        b=wn1/G5npk9MJNBJBlfEJw151L1b5DElkZJsGtNExV828hJX/a+CvAHQaMy9FZM0S77
         SJNusOe8QFVHt6/IcEuKsmJLO1wrbTlCnYriEkkGBaO9808j8HpcAgl3UQM7gTOqJ+A+
         I29P1L9yed1bcd8dY2wBdcxU2JUk3roJ0iifCpNouQsN8R+guc1PRiIedrmrjp5Eiv84
         +z4OzA0D6To98cV3ebU0maOZHamd2NdMTsRJnJ60NftX+Rq12eRfl0F1BfGNfID6HTsB
         6m68Jf5d7GlL8ODdopJQTlzKfYsjBSxOsLqh0Mx6haitJ0ecWkUqEdIkV8/lAkok1UlL
         3NEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742455529; x=1743060329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MS6MAbgYesW5WGSakhAHYwH43HMZi8cWhVXf+Y1buQ0=;
        b=nlsqfYaSY0fIWsv2NDLwVDTIB9dJnI+EgtsS52gCmBR+Hsd9PRY+9FLlaZiP+Ce399
         Z9j+YzfiM9Fh3n5SNV0oYOvqGpIWTwbhOTqMP3KUvSmScetVjM1l9Fhiv2oOANrfRFjW
         U7ukKiBWaYRdWEwpiyCqaqhfyrsPHoTdbhYi5DBifgcizI8bTOrrWaIvIGCYs7NUygZ0
         xxqDb9AIha1wcU7zrwbbjJt/WTIpTAr8Y/LPWrL1TrE8bw7D6qtmj5K94p0ntiVZ8ZhR
         4HF0ccBtg5kzfURqmPkdtKsg5Ev+L7sziIfGhqNGYa8H3naIflpJ4OK5N8iSnhuSvEE1
         xyog==
X-Forwarded-Encrypted: i=1; AJvYcCV851u0q4KoFso+fOcPFpozKqvqtBCvK/s1yptynGNz/AB6P6WlwU10OFrnGJBe/Q71XV62mg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwiCTlG+EAj5wJ/6bUAceYWCEBxWgbZ+ILBleCUZLG+3qam0MBi
	7rZ/I7z/p6EdoELX5FIfOZBofT5DznJqsCUpnqdTouj/moUohtOAl3lYbyCIqA==
X-Gm-Gg: ASbGncu8ABeOkV+jOQC5X9i29FAKev3MS500oUT3q5M3NWKWMq2dbvHVu2HLC6Cnnfn
	lFdf9fsRwaQ6EVyAmJyEr4HeuPjQgfP1vTuylTFbueM/UIy7RecCEgAnSLtQQyQ8zc+YQjZDh8U
	sMhJikg3TNVz/YCyO+7GBB0EF2Yc8n0Ivir7yEy13DHNPQTT1tpZgQnLZs4e4++13jQag1Q8YjH
	+i3B2rLi/xMWCMPqF1h+oc5jri2mVC5lQ0LN1DSCwUmqVk1fHJX7tAF5XpZvSJ8uJYOQJvW/cfg
	LDOtfQ+kLAnXsK6NOoTGJGVKnjTtl0VrtXwK/j9+7aggsC2CxwbTi0giCuPchkDCOpTLpIvm5ik
	N9Ro=
X-Google-Smtp-Source: AGHT+IEntm19+wAegE0A4Y8cj9RYrZU5pcNk6Urbq0ph11Sf/Gp7h4+OtlFrJi2pn8Ef3knTj/h5xA==
X-Received: by 2002:a17:902:d492:b0:223:fd7e:84ab with SMTP id d9443c01a7336-2265f996dc8mr1978985ad.24.1742455529079;
        Thu, 20 Mar 2025 00:25:29 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68889f7sm128135485ad.12.2025.03.20.00.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 00:25:28 -0700 (PDT)
Date: Thu, 20 Mar 2025 07:25:20 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 5/5] iommu/arm-smmu-v3: Invoke pm_runtime before hw
 access
Message-ID: <Z9vCwLbwwjn-gVJ9@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-6-praan@google.com>
 <20250319120404.GD10600@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319120404.GD10600@ziepe.ca>

On Wed, Mar 19, 2025 at 09:04:04AM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 19, 2025 at 12:42:54AM +0000, Pranjal Shrivastava wrote:
> > -static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
> > +static int arm_smmu_attach_dev_ste(struct iommu_domain *domain,
> >  				    struct device *dev,
> >  				    struct arm_smmu_ste *ste,
> >  				    unsigned int s1dss)
> >  {
> 
> This can't be changed into something that fails! That would mess up
> all the error handling if it ever blows up.
> 
> > @@ -3214,8 +3287,8 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
> >  	struct arm_smmu_master master = dev_iommu_priv_get(dev);
> >  
> >  	arm_smmu_make_bypass_ste(master->smmu, &ste);
> > -	arm_smmu_attach_dev_ste(domain, dev, &ste, STRTAB_STE_1_S1DSS_BYPASS);
> > -	return 0;
> > +	return arm_smmu_attach_dev_ste(domain, dev, &ste,
> > +				       STRTAB_STE_1_S1DSS_BYPASS);
> >  }
> >  
> >  static const struct iommu_domain_ops arm_smmu_identity_ops = {
> > @@ -3233,9 +3306,8 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
> >  	struct arm_smmu_ste ste;
> >  
> >  	arm_smmu_make_abort_ste(&ste);
> > -	arm_smmu_attach_dev_ste(domain, dev, &ste,
> > -				STRTAB_STE_1_S1DSS_TERMINATE);
> > -	return 0;
> > +	return arm_smmu_attach_dev_ste(domain, dev, &ste,
> > +				       STRTAB_STE_1_S1DSS_TERMINATE);
> >  }
> 
> Because these functions are required to be non-failing.
> 
> This feels kind of wonky, if we need to update a STE but the PM is off
> then we just need to update the STE memory with some synchornization
> and do nothing else. We don't need to wake up the HW and issue a cache
> flush if the powered off cache could never have held a copy anyhow.

I agree, that we can elide TLBIs if the smmu is asleep (powered-off),
the main reason to wake up the hw is because `arm_smmu_write_ste` issues
a prefetch CMD. Again, it is possible that the smmu sleeps after this op
and the prefetch has no real benefit.

Maybe having something like rpm_get_if_in_use could potentially help
here, wherein we can check if the smmu is powered ON before going ahead
with issuing all the commands. Although, in this case we might lose
slight performance due to wake-ups caused by other clients, for example:

1. SMMU is powered off, client1 attempts to attach to a domain
2. We elide the prefetch CMD since SMMU is powered off
3. Now, another client2 served by the same SMMU, powers on the SMMU

I'm not sure how much of a performance loss this is and also on systems
with IO-coherent SMMUs (where the SMMU can snoop into CPU caches) this
may not be a huge drop, but I'd like to discuss the possibility..

Anyway, having *any* rpm implementation that causes us to lose TLB
content, will cause a hit on the performance, so maybe this
micro-optimization isn't worth at all?

Also, while we're at it, should we have a feature switch for users who'd
like to disable runtime PM for performance reasons? I don't think that
relying on the `power-domain` being present alone is sufficient.

Thanks,
Praan

