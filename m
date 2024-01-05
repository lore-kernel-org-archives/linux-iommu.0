Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422CD3608B
	for <iommu@lists.linux.dev>; Fri,  5 Jan 2024 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hTPa3csW"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2055f5ad1f2so686813fac.0
        for <iommu@lists.linux.dev>; Fri, 05 Jan 2024 11:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704482078; x=1705086878; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BYaH7wh5XET4G4kpwU2CUZ2+f7v4KPCcD8P7PDz+AVo=;
        b=hTPa3csWVyd5vN7asjBIRAJNtop46g6A4GOd3VJ2+/UDWS0QBL+a/xpOWWjcIT0zS8
         xnmB3s4VmM4wWQqes3+v4zaAw16KMoGqj0QjPAmhLBvEEf38zQxJykBqcqzjkyeG4GF/
         h+hjH3Zotax/NICpSXZVZZGjeJXNFXasvNFQQoh9Ji4TUSnNQxghy4/GIfi9hsEC+ksG
         Gk0FOGA7p2mNi5e/CuA2btTtazbxFDMaC6Np+XMvqbA2LMQl5i79D5ZCfcj5J/dgsZmM
         RG7Sody55+6+rLCF0RnaM2Ck5SQI0jLi+MPLIM2z5/gocYhM2+aG+eWj+CJDIsn0LdrN
         ajOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704482078; x=1705086878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYaH7wh5XET4G4kpwU2CUZ2+f7v4KPCcD8P7PDz+AVo=;
        b=Igoig+5j3Tft/jIWy5KnSxBVlSNcva6WOoLnOdpTgGIobUsUixL2+Do+JEoqfvRsmf
         /DhpSpgcgbYgrIenqblvPzZEdjnaxjQlVB/+DUXAygzPQcuKE5MdjUCRs+HC+GSXTWu8
         aTqh2vGwBMr3wEZrJvU3Z630vFhMxL48DSgEkRyNn3iC4UJ0I2sfNYRHqTd2qzYJ7ps1
         S3xcmf7CUTlGq6Q5RWd+4E1vfcau+KfjgeLKjPJPf3BewJ3+CoYiLznPX6m24FrBHPTh
         JL9rVjEs04KhZxXAfmGJMNNnWaachYIxziudvwWtnBk1FQUKjBg/lHmOLyDcmms/NWui
         q3aA==
X-Gm-Message-State: AOJu0YwRgaX7d/blwBDJWGl0tCDMkc0YJw6qjQQaSNkviRVUAN0UGEu9
	4VCU42VnqCD3T1hPDlsg2RduwC4bUcz5W7AmwMGNnJuhb6U=
X-Google-Smtp-Source: AGHT+IHKxgmtAQmAw0BxCGrygjbkRjXtF7OEWnImWxjm97QO9m/6b7KzsNI1jMTlzks86uCNB6T4zA==
X-Received: by 2002:a05:6870:639f:b0:205:cf67:994c with SMTP id t31-20020a056870639f00b00205cf67994cmr2040822oap.2.1704482078319;
        Fri, 05 Jan 2024 11:14:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id i8-20020a37c208000000b007817091b53bsm794414qkm.97.2024.01.05.11.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 11:14:37 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rLpeP-001VbC-CP;
	Fri, 05 Jan 2024 15:14:37 -0400
Date: Fri, 5 Jan 2024 15:14:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v4 11/16] iommu/amd: Refactor attaching / detaching
 device functions
Message-ID: <20240105191437.GQ50608@ziepe.ca>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-12-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212085224.6985-12-vasant.hegde@amd.com>

On Tue, Dec 12, 2023 at 08:52:19AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> If default domain is configured with V2 page table then setup default GCR3
> with domain GCR3 pointer. So that all devices in the domain uses same page
> table for translation. Also return page table setup status from do_attach()
> function.
> 
> Note that current patch configures GCR3 table with MAX supported PASIDs.
> Ideally it should use 1 level PASID table as its using PASID zero only.
> Later in SVA enable path it should be reconfigured to support MAX PASIDs.
> This will be fixed later once SVA support is upstreamed.

??

Given this driver doesn't support PASID at this point you should just
allocate a 1 entry table in this patch.

When PASID support is added then you have to allocate a MAX pasid
table or implement atomic resize.

The patch looks fine otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
