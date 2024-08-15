Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0DB1714AC
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723723609; cv=none; b=lYbVJE6KJEAl7DtWSeep0ywv2UOaurqdCmTgGGjqca81r6PuOigLgsX+C9GfGBV7kIJ7RI+z17uVQzbImWmJAZ0Tk60FUTXu6/mZM4phep2ncsGRDO3DKp2t79ugbS2swEg7q4nOUrygbdFJyRoDsd2sMZjm7bRkmv/2ubhVK9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723723609; c=relaxed/simple;
	bh=uveJ8w6kuDKNwrmp5pXf26ypCO7yq++W7SiFSpS31B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6vW+uTW7FIQRofa4K+agO2he6XxpdmZ53BHjQt+zjjLcZ8hEnwXy7oFGeqvc96X4RAGxQ3DxBoPWmQxH7OSzwfEj0O6xkE8Xm+tE7NyYaqYCTzpymWAzkkD9U1/cgtdGWD4e48hmGwZEQuMmK2xjtb+FhXodu2RiDemSPPz7MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BrGVIs1N; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BrGVIs1N"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a337501630so56530585a.3
        for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 05:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723723607; x=1724328407; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hr4E58oRSlojKYyvjb6raU+5d7kHhDDWcSg78FeETeg=;
        b=BrGVIs1N43H91kPBqhDMaaXPY6uC6fSigufpokeLkBYcXjPwCSNhMIVMMjiHTATA4b
         ouFWxAaZzADqPpV+f4VI2joySbRAUhB2G6XVTvgyvcVRKptmC7K4AlkaB0Lu/B0m355O
         aJnw0ouiXWZ4QqR1dVIOt+V+ygFrvd2acUtMMSa9sEkzn/3dChriWNCbzbnYaY+kwRyi
         v8lnVypZvsS0ZeKusccIRcoA1zx7UcESuWiRB8/DJiqtYTQX86kmQTyqKatuL3iwb+4d
         dWoxFcQsB3loiwCBB/eMQZkSrN59Z0E76TRPqPN7myNesFBhN0rGzRK2WQzUtFXIvB5I
         hV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723723607; x=1724328407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr4E58oRSlojKYyvjb6raU+5d7kHhDDWcSg78FeETeg=;
        b=Wnl+RAONnyd04dfDv9F0ReKMIPaMoJRpSFWSfK4SMFuEsjNDKq0iGDuSK+u1pHV+xg
         tYSCBINAYLC1vkpAiVWQnnmsCagQomWBlFyIMfjvd9+eL3KNXAULH/KyfbztbJ2x0eIF
         uyJu/iqMmz8PEcSqsmomp4HyvQ6AYkPvA40k3IB7/n2zulcWKcnFL04PwdAbY70T7RGP
         dE7TdIbvmuxxfiw1zUKPSs7Aoco9OsqyF16BvToEqN+EJTgbzydUkpzXmjOlp6lgZaku
         iucYWRK8yGJamjhLDAJbMmSZZPWr3VpMG6Tb8iRKNqNy6g3WHLXr7BnueZhxR7P/lWaq
         G+9w==
X-Forwarded-Encrypted: i=1; AJvYcCU7PXEiY19iQrADCQyu5XsUmJnLeo1P+RBzaq9mdP2bg+FqJoDTHYM0eGgqVyZkOjdE9DsvOX22sZEVuRZzdPJPck6r9e8=
X-Gm-Message-State: AOJu0YwnffxDEfqzCPWIIySy8XzWsdDitzhGPIe8kJyEZs5EOMc/OBkw
	gCVTfVy5J0Ap9MjH8Irsk0KC+jDEWSYBwg1/i3NxKqu4JyDaxD6m4KMjXHhY9Es=
X-Google-Smtp-Source: AGHT+IEVYQLKcB+BDHqW0CoQRVm2Fen7oEdm+gWp7c62CjP214H/a2sHkXJ4ifu64Ci1C2h8LkxIEA==
X-Received: by 2002:a05:6214:5d8e:b0:6b5:4a2:79a2 with SMTP id 6a1803df08f44-6bf5d1a3018mr50970416d6.28.1723723607021;
        Thu, 15 Aug 2024 05:06:47 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fef4897sm5777456d6.110.2024.08.15.05.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:06:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1seZFd-002m27-9t;
	Thu, 15 Aug 2024 09:06:45 -0300
Date: Thu, 15 Aug 2024 09:06:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix a NULL vs IS_ERR() check
Message-ID: <20240815120645.GE3468552@ziepe.ca>
References: <9208cd0d-8105-40df-93e9-bdcdf0d55eec@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9208cd0d-8105-40df-93e9-bdcdf0d55eec@stanley.mountain>

On Thu, Aug 15, 2024 at 02:25:00PM +0300, Dan Carpenter wrote:
> The arm_smmu_domain_alloc() function returns error pointers on error.  It
> doesn't return NULL.  Update the error checking to match.
> 
> Fixes: 52acd7d8a413 ("iommu/arm-smmu-v3: Add support for domain_alloc_user fn")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Yeah, looks like this was missed during a rebase

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
