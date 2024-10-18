Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF65517E00F
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 12:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255413; cv=none; b=f01tAGg6SDu4rGbU7sozm30ti2FlPnIyv1G5x1aNHmLMT6bY/ONGNSlmMG9wuBzYGQsCFuIlu6TE41O6SynsBCA0ZeMfqaqAdPGc+xAzFkWlaPAV3lwSE2vGSLXXcVnoCiLQqjwy83M2/strgVdZ2vIGK0tyBOlXUL6hH739jpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255413; c=relaxed/simple;
	bh=F8MoeUBFOPz8eAEBkqe1stDgaRxHT6izAaipd5mTTJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqG+dffHLQ4l9coY24zuH0MKztGjn4zzW/oZCnHXyXjzpG6razu1jc8wfUEf1Z6P5EJdU6GexZi5daqnHku9d6rPAORgzZg9Q+a1bWM59r2ITc9NtmecuajNOwXDFH+S3YgitBV6Cb593Fmsy4jODldxFHfSS5OXixFtnlDjMfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RMjWTuqY; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RMjWTuqY"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460963d6233so12093391cf.2
        for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 05:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729255410; x=1729860210; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgiKJw2eG4CAxMQopz3/dTwbAKWkyucQSj+XKyAUj5E=;
        b=RMjWTuqYj4RpBOxmjxjJ5gkh39SjJoHxR9mqiHjvdrgRWwrs0jA/AHDJiSj49b1ju+
         MTSSd1cFpAhl7W+Y4CMwObJqBszB+88bjQc09U3woXx1bgykmPx5l+KqiqYuaiwIFKwv
         uumGekZ2Tt0+NrzE1bgSH8zIZR6To+teCBtECFGd7+ATa5H9e/wQGwp6m7IVlh1Q0mma
         pYhP0lqb8f2tNc7kaAnJAF61DR9f3PMHZ76/QJIcX70rVLU1ry6qfCG2bgnniBU+20VS
         yWgojyzC6teZlyNF3ni/6yKgivEtap12BhPm4sQOyyC3t0/Jwsrt6Pz6qqDtVBo7hXdi
         hbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729255410; x=1729860210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgiKJw2eG4CAxMQopz3/dTwbAKWkyucQSj+XKyAUj5E=;
        b=sdeXppUI1s15C0DPT7hhQ9mzOSPJ4exyHakmrRz0UG4CiOeGQZjsdxWWcXyjKwHrBN
         UlRzLUeKbhOix46DCcTUWdY/OzM1Vb0vpXyqtpiYv2h9fUyw1hKCWq9DMrdFQFcXOXrL
         mob2v9KMutu0DJmLGIbZkQDi+oiWmk394rmPCYfYoXY4QTh49TVi/zMc4PYNpTfCB+pY
         1vO0TTiZ1AVZe/MXzZlzcQvBU046KbizNmTcT9vUfRNw00icK++dMzNKcvn8v5cp8+/m
         kOPGfY5lKlO8bwuTjzaRjuZ4agmL9Y400Zbnrmc5gJ8w/1YODrelGrJzTgAPgW3JRUjp
         mtSw==
X-Forwarded-Encrypted: i=1; AJvYcCX9pzHAZ76M+wqaIea6uRRyHnW31/5MWPaK4kulNAZssO039QMlWBgtkwBeZkXRDTasrPXkjw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5O2WftzUCScbFd5ganT2Zjc36tFZoPh5z2riLhxKPK350LzPx
	N7mreJvGjpQBZ8/98xaU8AXZoMWzHlIMzGeE7zWNp7sVBsfPsFHsG0E9nTcsQmo=
X-Google-Smtp-Source: AGHT+IGdCmPjvorf+beBM968wNP7ve8yIkR60KTDGOTdJ5cA6KLOZzXOKsWAzA/ih4dUmmTA3K4Sew==
X-Received: by 2002:ac8:7f04:0:b0:45f:5f6:9886 with SMTP id d75a77b69052e-460aeceadc2mr24223181cf.10.1729255409703;
        Fri, 18 Oct 2024 05:43:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460ae996ea7sm6972291cf.49.2024.10.18.05.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:43:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1mKG-007g5i-Cc;
	Fri, 18 Oct 2024 09:43:28 -0300
Date: Fri, 18 Oct 2024 09:43:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
	kevin.tian@intel.com, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v3 03/12] iommu: Add new flag to explictly request PASID
 capable domain
Message-ID: <20241018124328.GE948948@ziepe.ca>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-4-vasant.hegde@amd.com>
 <798b486e-ec49-4f51-89d4-a2083bdaddf1@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <798b486e-ec49-4f51-89d4-a2083bdaddf1@linux.intel.com>

On Fri, Oct 18, 2024 at 11:43:02AM +0800, Baolu Lu wrote:
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9f6b0780f2ef..d7546ab18e18 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3539,12 +3539,16 @@ intel_iommu_domain_alloc_user(struct device *dev,
> u32 flags,
>         }
> 
>         if (flags &
> -           (~(IOMMU_HWPT_ALLOC_NEST_PARENT |
> IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
> +           (~(IOMMU_HWPT_ALLOC_NEST_PARENT |
> +              IOMMU_HWPT_ALLOC_DIRTY_TRACKING) |
> +              IOMMU_HWPT_ALLOC_PASID))
>                 return ERR_PTR(-EOPNOTSUPP);
>         if (nested_parent && !nested_supported(iommu))
>                 return ERR_PTR(-EOPNOTSUPP);
>         if (user_data || (dirty_tracking && !ssads_supported(iommu)))
>                 return ERR_PTR(-EOPNOTSUPP);
> +       if ((flags & IOMMU_HWPT_ALLOC_PASID) && !pasid_supported(iommu))
> +               return ERR_PTR(-EOPNOTSUPP);

I think the decision here should only be about supported domain
type. Like on AMD if the iommu instance doesn't support v2 then it
should fail.

If there is some other thing that says the instance supports pasid,
that should be checked during attach time only.

IIRC intel can use either page table format for pasid, so it probably
doesn't need to do anything here?

Jason
