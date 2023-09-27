Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F726F9E7
	for <iommu@lists.linux.dev>; Wed, 27 Sep 2023 16:45:25 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-77412b91c41so622571285a.1
        for <iommu@lists.linux.dev>; Wed, 27 Sep 2023 09:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695833125; x=1696437925; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mIokYTIkbGPHkN7+WVz2OOAQF+u/yc1WIWPiQgy85s0=;
        b=bEGzwdWrmN/qhMgEptpboiwNex3PJZhzf4rnEY74OuY6BSR/R+rsDTAopan21ob6e0
         9anE+7eFT/pCPPiEKiaRVDkkAb8Eq2pxaut+QAcnKyMaHEDc89a1IyNGq13cl8rZwZV5
         jJP+GUEo1dL8f8eJ28VqSxNjxnER1oOPdXSgWwh5qw1lgpWTAc5BBRU3Jk9dDOvIn3sy
         r/M5YJE03fTNWPxuDGEYYcZJmJH0N1f3QlFnIeQxVVase7wpWDFFVudKAWwyRbdKgOdL
         fYJJuRTiN5b3O8Sovq8KOaEZzkAEE+oEh96njAQDOH9Ral3FAEASjdb+XzzqTkJ+f9Ib
         Vbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695833125; x=1696437925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIokYTIkbGPHkN7+WVz2OOAQF+u/yc1WIWPiQgy85s0=;
        b=Y5jKH6TdDcr9T337B81tUpud4qEhFo7qWJAwakNehk6TUhRuYIVpztfQtRvw04DZUX
         ENM8AqWJxAaepi0gaB0LO9EW8Vub7baw2hyoFxP8zvGk8Jrr7LVQUhvL5/m6V45RmHxD
         B8REHXFoNJnRvo5WEuvWjXbkL3T0iLFm2ykyeXLBo5jKeqw51yazRGD9JMNRQrLrD58T
         Xe37hPB7iTBLH51TikIBopSX2QHcjpOZmFlE3VUYZfeHFZzk/VJj0nw9Tm2+CtMnaw3D
         GPExEPkNwtzGqzeL48MY2XmWIMYWwM1rFurpJ6J4iu99ntPBW3SuVX488+ynr1nQaFF6
         b4tw==
X-Gm-Message-State: AOJu0YwdbRjW42FKAp9EpUk7dYDBoyv/kbHFtP8X0tp2U3SNInDvGE1u
	rMEXOXNs2rL012X9/Cxuh2530Q==
X-Google-Smtp-Source: AGHT+IFfMS5nnVvVX8Z7HjPI0GcUUmFMQoDkdV5+XfkFQAuhSdHDE+NeeA/DBFTZ1XvIL9sQ1pawJQ==
X-Received: by 2002:a05:620a:269a:b0:773:a229:5a4a with SMTP id c26-20020a05620a269a00b00773a2295a4amr2551798qkp.25.1695833124885;
        Wed, 27 Sep 2023 09:45:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id w15-20020ae9e50f000000b0077423f849c3sm3777303qkf.24.2023.09.27.09.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 09:45:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qlXf9-001RP5-GK;
	Wed, 27 Sep 2023 13:45:23 -0300
Date: Wed, 27 Sep 2023 13:45:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 06/10] iommu/amd: Refactor helper function for setting
 / clearing GCR3
Message-ID: <20230927164523.GO13795@ziepe.ca>
References: <20230816174031.634453-1-vasant.hegde@amd.com>
 <20230816174031.634453-7-vasant.hegde@amd.com>
 <ZQHRTwYN4doUte5E@ziepe.ca>
 <0d47919e-cc2c-d151-f020-e2090fd1c287@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d47919e-cc2c-d151-f020-e2090fd1c287@amd.com>

On Wed, Sep 27, 2023 at 11:51:20AM +0530, Vasant Hegde wrote:
> >>  	if (pte == NULL)
> >>  		return -ENOMEM;
> >>  
> >> -	*pte = (cr3 & PAGE_MASK) | GCR3_VALID;
> >> +	*pte = (gcr3 & PAGE_MASK) | GCR3_VALID;
> >> +	__amd_iommu_flush_tlb(dev_data->domain, pasid);
> > 
> > This flushing doesn't seem to make sense to me, it shouldn't take in a
> > domain parameter.
> >
> > I'm reading the spec here so I may get this wrong but.. It looks like
> > the IOTLB cache is tagged by (DTE.domain_id, PASID)?
> > 
> 
> Yeah. It works, but name is confusing.

How does it work? You haven't explained anything about why does it
work.

Nothing guarantees that domain->id is per-device. It is emphatically
not, it is per-domain. It happens to act like it is per-device when
using the DMA API, as DMA API does not share domains across
groups. However iommufd does share domains and so this is not a
correct assumption.

You said below that you think the DTE.domain_id is per-device. I agree
that would fix this bug, if true. If it is to be per-device it should
come from the struct iommu_dev_data, not from the domain->id. This
should happen any time a GCR3 table is in-use. v1 mode is fine to use
a per-domain 'domain_id'.

> amd_iommu_device_flush_pasid_all(dev_data, pasid)
> {
>         // Flush domain
>        // Flush single device ATS
> }

That would make more logical sense, but it does not resolve the issue
of correctly choosing DTE.domain_id so the cache tags don't alias.

Jason
