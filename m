Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7681E53F
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="F1JWOWjr"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6ce2eaf7c2bso777329a34.0
        for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 09:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701366735; x=1701971535; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dEJkZfHY21+MgpNSYij29D5tRNZwoiHBNJGjnsZe1nw=;
        b=F1JWOWjrC5W2wh1UmaAX6UKEJJtGuEKXotOUnweniQgBVHGdnFoob8+3ZpEiXhbxBW
         7eb3zgjU1VU7RLMVGHrPGlVSwQ9y2Nh4N20Ue56pGYrPgD/YnPkCY7XHViqp3emgq13p
         Pq2eNt2d28Tqy7M3R2BpK5EjQ4ZHgWWhB/e9IoPGKKdtTXnlPbMHfa9Shqe2V2EEbe3y
         uAYIG9gUBuHh0IwrGmx9xbXhNJNRhS+hNVrFbTPlOa/PiNsFj25y6ehOf/mlksP29iHr
         773276HubrfcsC2GKJRmYXNKH683I3UA5w/j/spCgUseBs58qJTuGIObrRvRvOHgPjpV
         htRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701366735; x=1701971535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEJkZfHY21+MgpNSYij29D5tRNZwoiHBNJGjnsZe1nw=;
        b=Irohg925fN4QXDXzAxiJnMjDd0Dyb+6xx9llYEnfbp7yrE5X4jmLRJM2ex4/o6j+fx
         /oStIQnXwBNxZTe4And68FvUSMwQDu+Qt5+l2MFaGQnBvBqVypbOFz8GB7yr9/pG4DBh
         x+UHiDNNyj7ouHlT77eZNgcs3clTvv1uZD6/PgVe6VrHFRMV0e17on9ezg1vj/Jy0Glo
         GUjPHa+ekw+f3p2qZoY92bdAOljEdX1Z7x78RlaPwBsBkfqevp7vL2UQP5FeCiEANSkC
         F3JqZAl6LAumbxnlOjzI8Ng9zbLcogW4FVJ8S+0YTp9/lUk/QIwtV63UCmgrEA+BRAHj
         lowQ==
X-Gm-Message-State: AOJu0YyXUJzwOLFL2n6sLtV6dg6SM8b/MGs4rke/is5jz01DOaSuO+Bl
	JsiWIu9JKSxUo+DlUPl3/X4x0g==
X-Google-Smtp-Source: AGHT+IEAuWzP61yg+IBAfhtyxl2EcxuJScz0seHFAFC3nPdV8GCUX5E2bIokm1RyROBbpjxGhUQmmg==
X-Received: by 2002:a05:6830:1483:b0:6d8:1c20:85c3 with SMTP id s3-20020a056830148300b006d81c2085c3mr326213otq.20.1701366735265;
        Thu, 30 Nov 2023 09:52:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id i1-20020a9d68c1000000b006cd33d6fd5csm223135oto.11.2023.11.30.09.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:52:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8lCw-0069oJ-47;
	Thu, 30 Nov 2023 13:52:14 -0400
Date: Thu, 30 Nov 2023 13:52:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v2 8/9] iommu/amd: Make domain_flush_pages as global
 function
Message-ID: <20231130175214.GF1394392@ziepe.ca>
References: <20231122090215.6191-1-vasant.hegde@amd.com>
 <20231122090215.6191-9-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122090215.6191-9-vasant.hegde@amd.com>

On Wed, Nov 22, 2023 at 09:02:14AM +0000, Vasant Hegde wrote:
> - Rename domain_flush_pages() -> amd_iommu_domain_flush_pages() and make
>   it as global function.
> 
> - Rename amd_iommu_domain_flush_tlb_pde() -> amd_iommu_domain_flush_all()
>   and make it as static.
> 
> - Convert v1 page table (io_pgtble.c) to use amd_iommu_domain_flush_pages().
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h  |  3 ++-
>  drivers/iommu/amd/io_pgtable.c |  4 +++-
>  drivers/iommu/amd/iommu.c      | 22 ++++++++++++----------
>  3 files changed, 17 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
