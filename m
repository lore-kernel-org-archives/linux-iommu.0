Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136E83C5DDD
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420543; cv=none; b=AgdRp/Wyo1wtaqFdy7QWJwmw0kBihC5lP0R/mWW0C8Azn7aSsG6zAx3fk8h9tBoGuT+3k6KBvvUHEaoV+UIaRHIPcv+rHlgQZYX7v+Jf26KrhzMbuzWLSF1sHUaY7TyPpw+m0wPaIXuWik6xb4Z2REZjeCbullaVrayct19Dqzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420543; c=relaxed/simple;
	bh=e4FDWneWm4caYAk2Z8Pd9IIQPVmC4HPp7RipJsdtzfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ici0SO06Q+JUy48h8pqad4qXVjpFTj3drjkUNl3FNr4mCzmfKMfdFiW1aptOjPE92JzwchOFdp8W5R8Ex+T6Dyi7SCKDDkRZ2GYyNXKEQWHJMFLT0B2YDuyBVETBuZNHsZ6hkYasBm3gSRMEFq2OOiJGV1r3b1t2kd24TpPtNCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MEzT3k87; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MEzT3k87"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cd8d97aa2eso300688185a.3
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 09:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773420541; x=1774025341; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDL/0HBsEvanpcbs0FNAKxWYY/unIcv5AdpuWwFvyOg=;
        b=MEzT3k87o2ctBYixhKgU8ruPRGKDlIAel3YjyerJRn43Grspc5KY1LcQnXZh9McG5M
         FvSpQAWF3v+ntvK2wAtJgtmygHCePot/c2sF138Xxs1BpX7oXfm25D1VqhQkAruSHZB+
         KMtcYrfcRxYLYBcfBoLrPf0znAyIzNsJ1QXDEOaM23FyCaD+yDfAngt1cN4ERnI6Jb8z
         TLN5rZvjlhxCpTUGWhVvKRpbvrmCh/1IThXKWaP3gSqLeY28LDj1iXcqieYaw6tgMp5X
         dqJrrLycxjyZKGKSHwAcZB+HOD6OhgqJH5aEm2y7I08BaSbmOMDYt1kLRZv2NSVNosoA
         k6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773420541; x=1774025341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDL/0HBsEvanpcbs0FNAKxWYY/unIcv5AdpuWwFvyOg=;
        b=Uny2ee2249II8oUExsTb4MBi2YgwKb/wVlHorITf38sqrDEoNFWUFEYvSMjr+Uv1SN
         uCPFEoIuNqTSEfULP83LOjKo3kfwHqNBRVsPg4Qb+DBf9QH/aewmRQ7FyfPatdNE5j+/
         VlOlzki9daufGHPOMafJA6K6s3E5sZr3G13S7LOndA/AFKT10HSBRKl5thBh2MA+ChEL
         jnCvy+oBbG7IWpMxNpI/ZxORA0iXHG92jxapPjzl0ILVQwxADMwZhBJhaburgFdDk7pk
         87I1mwYKPv01eOFb3jIrlBhs+iWFeTLaSRuO79IgSS4TVpADpxboGpsFEVgQK6aYkwx0
         Oicw==
X-Gm-Message-State: AOJu0Yxo52luQou61cVwNa1vThZc2AicuJ2mzXKzA1vfLmFg6MFGv7Y/
	A12Pa9xaT51SQSn6Kzbx18txcuync0ABrTeHAP6yHBAsj8A/yVOlxbwAEgzGnAr2pi8=
X-Gm-Gg: ATEYQzxToMSlay7t6wlVoQseuPsxTZvr9kEtLZTJ8bGKVi9+6Jn46EIhYUok5DBvkzM
	Fro/D7FHpfizaOimuyQNDfo5u4+ANGPhBAjdaCu4Dn1oUpDLXh46zx27f9LUnKmT6yZ517OWsks
	q0M+usWPZM7CSQBLiciTaoGeXYrKi/GprB6FvzDwTwlY2xRPTuOFPjWbQsQFmnCrn3Y3dw26crs
	U6x0aDXfhbblzmkEYSlxVnmTtyVww52MT9h86tPa9DQ9E6P8WQ93qzac41LY/OZi8zOwwIZ0LPc
	gMQJecVQ78vX47ujCOqCY5W2w/OBzUyrUgjgoImxiBFeQ+ROr1O3ebpvtbij+QP/5r5t6UKAypi
	vU7GEtOkLO4O7T3OgOipr0DOPdLzdRZkAbVqYv64FAvJhnvUGyKX4+URoa7yd5ZL6YZ8w6Zocd4
	Oeyrmz/tqjBQp3nnOGNkTfmdKYD+iSVm0yHX0Fg4CvSQ9WS1Vjvy1X/v48Z46mOADJGYAqaMWSC
	0xqzkQGnEcoTXWVRjY=
X-Received: by 2002:a05:620a:170f:b0:8c6:bbfa:36af with SMTP id af79cd13be357-8cdb5b59a8fmr560875185a.40.1773420541011;
        Fri, 13 Mar 2026 09:49:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fda77bsm593097185a.18.2026.03.13.09.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 09:49:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w15h5-00000007JXP-3T3m;
	Fri, 13 Mar 2026 13:48:59 -0300
Date: Fri, 13 Mar 2026 13:48:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, baolu.lu@linux.intel.com,
	kevin.tian@intel.com, nicolinc@nvidia.com, nathanc@nvidia.com,
	mochs@nvidia.com, kjaju@nvidia.com
Subject: Re: [PATCH 1/2] iommu: Add device ATS not supported capability
Message-ID: <20260313164859.GF1704121@ziepe.ca>
References: <20260303150348.233997-1-skolothumtho@nvidia.com>
 <20260303150348.233997-2-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303150348.233997-2-skolothumtho@nvidia.com>

On Tue, Mar 03, 2026 at 03:03:47PM +0000, Shameer Kolothum wrote:
> @@ -271,6 +271,8 @@ enum iommu_cap {
>  	 */
>  	IOMMU_CAP_DEFERRED_FLUSH,
>  	IOMMU_CAP_DIRTY_TRACKING,	/* IOMMU supports dirty tracking */
> +	/* ATS is not supported and not used on this device */
> +	IOMMU_CAP_PCI_ATS_NOT_SUPPORTED,

Actually, on second thought, the kdoc should have more details about
what supported means.

Does this mean ATS is available and could be turned on ?

Or does it mean ATS is on *right now* ?

The drivers should be changing ATS dynamically depending on what
domain is attached.

I think the implementation follows the first option?

Jason
