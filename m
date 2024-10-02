Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6619E13CFA6
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727897789; cv=none; b=RwD/N/E7cYaWI73dTwQOX/7iHTtjl9OQLiD9Y1C+DfEpvvm2NF8LJpVyPkYpYRHuDgop3+NYFvxL4ha0/n0k6ygn0EIAGvu23KtQroPBb3TD+prIdougQ8G5FRuL97MVM6/Vjza/z1Jj7/ngopKNbEUcyPmfOnhZVW2uLDLM7Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727897789; c=relaxed/simple;
	bh=PTwiRQVMVK8J1ZJ4VJcovCROI9oOEcPu4oZo8tvHK5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5lbfnJbVkQ1IBhvzcq6Ln5jxSRedGVmQhhwgjFJPACDwSFBq3SKlDpfh+C5vcvkUbvlzSjra5yU3tzT2TRsHVsf8W00Ert/gyrcS/A9eKA5rpgPW0EeAA8AXikO15W4PGR5GAPTs9MDu4SaCD/lgtvXGbtRpJ019zHwlAUemyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KMLFCQFr; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KMLFCQFr"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-84eaa79a00fso53025241.2
        for <iommu@lists.linux.dev>; Wed, 02 Oct 2024 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727897786; x=1728502586; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eJuEg2luqRfFWaM6QLHdJgzT/79/CqfjW48zFHGPNLk=;
        b=KMLFCQFrWGkgDn5+g3l6gWQtf9qYJzVjoFMYrOiCr2Sh3r99yxHbAkkPT3RWRqyGWa
         mSXTQgFQNzdkSJ10ao+inU4ZFqMFo/HqlJMIQoqfXMfZSi4a4Wb+uXv54TuPWOOhjAwx
         l7fN7qtB1XPFB2xAN+XAzX/Ex0SvEeg8j3+I6Ntx5JGIODfq6VJrkxrd5qc1SVb3JHCW
         aBFoLmndNEFVWXmebDsBMPE+Zp9WI6B34o7rMp2ysyyUXdLDAkEYOsOOlqhX+809bQfx
         wy1b7SoHejkktAKk/joir1O6UenL9eeDcbwztVPmxXTU3FOEbd/Vd5cZi2y69qL14mTq
         89Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727897786; x=1728502586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJuEg2luqRfFWaM6QLHdJgzT/79/CqfjW48zFHGPNLk=;
        b=I21jG92CHgkXPrZN7eQJiL0cfN5L2yucOSzWEiqgwR49BFyr065F+qvSwqpWFdRPuX
         tgmtGHJg33kdTrJ+WD1JCUrvfAx3MW/d/2dC+u+Ov7UhiLrb3rONZbRyTBP/txMw4ixk
         WHld3T3eYRJsVx09kZeFbyBdI3bnYcYbkKexFM0jsLoyDrgS8W3oyUPAQW9V2nOV7qMX
         2n7yA51zfxdD0DbUO7PZUfbHYEZAQt7vPXTM/dqzTtF53+I0kHQIcaxJauphGPKF5aAz
         c8vRt+PrGddQAux9RHmeu7FYCVK3gA3/9dvxfMyIie13yrn5r76rlz0cIrU+2wcZGzue
         DdZg==
X-Gm-Message-State: AOJu0YwBl7SjYIqYN/Jtw7shfvAqRmrg3ScbhOysfIn6fuhuXak6e4RN
	PqAZfp1px23r61HW4z4n2E6xuQUj3ANXYap7sMncft9Kz4K6xwvygc4bti9VqJc=
X-Google-Smtp-Source: AGHT+IGi3IwQK6XewLzoUOM0rzhN5X/v9fKtZAtS3mlITfjgHXQkAHo1zzesopU2w+FDqWAtkbDeWw==
X-Received: by 2002:a05:6102:370d:b0:4a3:a137:b9b with SMTP id ada2fe7eead31-4a3e68519b1mr3388468137.11.1727897786355;
        Wed, 02 Oct 2024 12:36:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f2b6dabsm59495321cf.27.2024.10.02.12.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 12:36:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sw597-00ADmY-1L;
	Wed, 02 Oct 2024 16:36:25 -0300
Date: Wed, 2 Oct 2024 16:36:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 8/8] iommu/amd: Implement global identity domain
Message-ID: <20241002193625.GS1369530@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-9-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911101911.6269-9-vasant.hegde@amd.com>

On Wed, Sep 11, 2024 at 10:19:11AM +0000, Vasant Hegde wrote:
> +static struct protection_domain identity_domain;
> +
> +const struct iommu_domain_ops identity_domain_ops = {
> +	.attach_dev = amd_iommu_attach_device,
> +};

It is fine for now, but attach_dev really should be a function that
just does identity and what is left should really just only do
paging. Same for blocked. That simplifies the flows quite a bit..

It would also be really nice if the identity_domain and blocked_domain
was not a struct protection_domain like all the other drivers have
managed..

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
