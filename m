Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4472B78285
	for <iommu@lists.linux.dev>; Fri, 19 Apr 2024 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713528736; cv=none; b=IBl1oxp6PRmVl0629MnXk03/DVi9ljgB5v/hP1Qi8bANYeAYdphah9ngit4cuAdVZZLtsJ48p6CWpduacvQQ2O8Io46nTyuXpxHRZ0erm3z5kIN0BexPoq11apQ/Q1ZrPLQ/eWpLlqQdgUwoD1Y+/z/cnwW5WTfucuZ5fCr6jNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713528736; c=relaxed/simple;
	bh=OwzCmo+HB8P8/gc/Nqkr8KAu49UD3Loo+NJxXKlsW2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmhJMHY1vKMO9SSIbir868RuYxNECLPVwXyJJSGeto2adB9wWZeiX0QbB2YRSIAMGEIM0pjHN+Ar//MORCMso0bq8xrrywRkbvCa6/FZh/k8krqzMmuF5RsSDfBsNi/oQfkqTGeG4nVsuwlPNunuI82YyRB++aJPbfzhIJy/mXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MtjRv5VV; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MtjRv5VV"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ea26393116so1191513a34.0
        for <iommu@lists.linux.dev>; Fri, 19 Apr 2024 05:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713528733; x=1714133533; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NQK8KuiS7o4R4B2xd5GKoamyZX+AdFtBqttq0jJDJjI=;
        b=MtjRv5VV1xj/AdFYT54bcFFfqs1ro4hAXtgxxckwc1n91b5P0yyd9gJludEXbmDkKz
         9s8MbeevmfUCZAy6/m0df5Tf8sh1+OaHZtH3KA4mHrgWuNJnJRF1TMgEYrr20f8ij1le
         UpviRD1jewink+qnLiETeSRbSjoVSYo1Lyjqv9giuvMplhVu4gqgLDkDTq6wRz3/bNJc
         WhDJp3zbtGy/4QT3AEEodAe9EknRY/n14my6XexDAijlKB7WlzJkucfT0edm+vk7CMwc
         egsFJrRi8GAfA7BWA6GnZI6VRuNNVzH2Rx8CttHQz2WdGKl5t0gQrx/COXmv0YrnJbcu
         bSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713528733; x=1714133533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQK8KuiS7o4R4B2xd5GKoamyZX+AdFtBqttq0jJDJjI=;
        b=AfYprK+FXij8p1OFJizuKVH+PpzzVZPbwSv3Z/D6aorggIRvFU/73Xj219KNdvOgNV
         0q4dkLJ1g5KxFWzSN1U6tSAwOBrtfShVbFM7R3jPsMQHIzHqEoJZzOVPr9SKJZl52F4Q
         cuEwpS7utdswCP4zbaRbQwSaxDWSsh5yCJa92U5C91s5/zfrRyQhgQU/FFIeN0NX8Ts0
         9MwhxWvEwdYXdstc4Qgzm81xs+DdaEKfA/7e2jOLEWENS6BGj8W+4hQMbfJuOl+69AY1
         u/BXbzZD70vdenbDyHZ8CvKU93mgPJTxdVCnaBoiZRsNsTD3ByUcXT3+TcimGFdAN+VW
         /TmA==
X-Gm-Message-State: AOJu0YxJJ4ObcxXPnZQmz3+ziOV65mRSMiUyqPHQ70Zck7BMdRbwkM0P
	06cSogZItdRIfD8K9ayJTDpGtJUUMWlzn84G/9xrp/+9QU6oPLqi5FsVR/dBctQ=
X-Google-Smtp-Source: AGHT+IGeAy2O+QD3V+vSapo2mv+vbFt0UqNr8c7/W+iiGCssAukpCy4utS5C8yLFkJAD7QSuTE/LKQ==
X-Received: by 2002:a05:6830:140c:b0:6eb:7296:213e with SMTP id v12-20020a056830140c00b006eb7296213emr1806203otp.10.1713528733194;
        Fri, 19 Apr 2024 05:12:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id n10-20020a0568301e8a00b006ebc38742a1sm680723otr.24.2024.04.19.05.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 05:12:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rxn6A-00FMxZ-Uh;
	Fri, 19 Apr 2024 09:12:10 -0300
Date: Fri, 19 Apr 2024 09:12:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	alexander.deucher@amd.com, Eric Wagner <ewagner12@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, stable@kernel.org
Subject: Re: [PATCH] iommu/amd: Enhance def_domain_type to handle untrusted
 device
Message-ID: <20240419121210.GA223006@ziepe.ca>
References: <20240419114715.6028-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419114715.6028-1-vasant.hegde@amd.com>

On Fri, Apr 19, 2024 at 11:47:15AM +0000, Vasant Hegde wrote:
> Previously, IOMMU core layer was forcing IOMMU_DOMAIN_DMA domain for
> untrusted device. This always took precedence over driver's
> def_domain_type(). Commit 59ddce4418da ("iommu: Reorganize
> iommu_get_default_domain_type() to respect def_domain_type()") changed
> the behaviour. Current code calls def_domain_type() but if it doesn't
> return IOMMU_DOMAIN_DMA for untrusted device it throws error. This
> results in IOMMU group (and potentially IOMMU itself) in undetermined
> sstate.
> 
> This patch adds untrusted check in AMD IOMMU driver code. So that it
> lets eGPUs behind Thunderbolt work again.
> 
> Fine tuning amd_iommu_def_domain_type() will be done later.

As long as this is done, and with the commitment that identity rid
with pasid will be eventually supported as well

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
