Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CA21DFFB
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719588858; cv=none; b=I307+9dS8loagFzZZ24UHdinY990NIF1lPF4Ad7VWFnbCQ+pck84Ii/dGgejGyV76S7+2NiZxz0zur7Z3fVlIP4AzfnLNoBgXczwkVwXswVdE5i+poco609kYNIgEAZRd38M4uUDfzXrhNJb4S1hY9iOK7aPB95z9RynEQZDiqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719588858; c=relaxed/simple;
	bh=GoVfq2om/F6nerort+/4GH+Vzkx9PCEasrrWTiLPzZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbUGkF+LtYd2lAFvjZogcBw9loyc4TkEH+RdzIwOTDbibDFZcr6pRH0yHu+u5K8Nu2De9XfjS5dvMvmzBfR5MKsIoOZsqFBghEZnYnZDUkgko9IYNYvqjAGHCnK1tyF5/6TyFqzLd6hFwsLv8ucqtp7028eFYJkApwEG4ivz3FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lDIn7Njc; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lDIn7Njc"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-701fb69e406so336615a34.3
        for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 08:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719588855; x=1720193655; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fNBeoVGWJ8o5IlNtUPaVy2Ap1ITTuQSwYGMDRF6oNP0=;
        b=lDIn7NjcA0/YDprBuGcJgo+XAe61f74MKL+tkbhYc8HNsx4yKPFW1AlubSa8ya7RSK
         WX+MCiH3eZ/SflHlZK/+9HJd+FVJx2X/UUgN/qkG00tsk9FwYShiHIzNo+QvC2Zg+VaB
         X1gLVGuQsxTvoXroaico+fi2i7S9FoNhSnznx9YZQhmXzKmFF8cYF24NznAEFLZRLeII
         W3XJ5QNjQbbmiDIlOCqhafZHieT9H/sJJIfPLs1JAmxnDXX2IqG4CnSs9CjijWyVQT0K
         GBPk/KiQzNqYSlkV1TDIBAQYKYMfopRamByr0RRtLf9YXO7whjN8j2et3II4Q5Iny0uh
         mXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719588855; x=1720193655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNBeoVGWJ8o5IlNtUPaVy2Ap1ITTuQSwYGMDRF6oNP0=;
        b=BbWY0KEiQ8Vu663fUmpBHP9N/SFdIO5ldmSOPGv1eUkCOPbuJJEkWjC1VhB50pg6b/
         iqltqK1cRmjb19BxbWN9ZRKrlJayAzwdBDqJ3aJquWPRult1EbNOHRbXBouJuaQU2GBN
         M/3VQbL3uVke1NlQEnZaOSFqRmDr/1ZDmsiLbE7EJ2Pehn9lqLMv48N2PqrJCJYHXZWX
         2950iiFCBkIzRE2l9tYbFWUgcL2cHTfbz9tHEwYUQAg3FVx0rervjf07FfPyNfcIg1lU
         Dle80XtuyTR7utmBHph+8hzVng8CO8o5+sxItDlbAd6vSGF2XyvllnFTA3QiJONLSzhZ
         h04g==
X-Forwarded-Encrypted: i=1; AJvYcCVrtTnySSZH9Y5iJLZGJoaZziCPKTARqjn7k6WzaFhFnWAO/iUM/1pc2HIO/BkaIIXbiPQPCaR1iHOPM8w/IPjDgF+1o3c=
X-Gm-Message-State: AOJu0YzrNLcOk+5/uJxRkwm1PsOjixy/r1W3LJ7f1kQSSS1igJIwt0Nz
	LzxlpvGYRVYkc2s0i9Q5+dQ3CgmnJaIh/G3Ppxvl6jLdcp6uRK29iA1XTWXlZ4w=
X-Google-Smtp-Source: AGHT+IEoruB6e9WTnho71MIVXgCyw5Wu23ZcJ8aTVSz7dmDPLdoGfORyxW+YZCBNcEJ6sZAXc+gyuw==
X-Received: by 2002:a9d:7a93:0:b0:6fa:eda:a072 with SMTP id 46e09a7af769-700b1276edamr18877346a34.30.1719588855619;
        Fri, 28 Jun 2024 08:34:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d692ea2ccsm81856285a.88.2024.06.28.08.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:34:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNDc6-004BKk-Ci;
	Fri, 28 Jun 2024 12:34:14 -0300
Date: Fri, 28 Jun 2024 12:34:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support
 AMD IOMMU driver
Message-ID: <20240628153414.GZ791043@ziepe.ca>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <ece72a5e-e4fa-4fe9-9d03-ad31d7a4b212@linux.intel.com>
 <6df92d7e-6042-46df-971f-732e0ad4192d@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6df92d7e-6042-46df-971f-732e0ad4192d@amd.com>

On Fri, Jun 28, 2024 at 08:20:50PM +0530, Vasant Hegde wrote:

> > means the allocated domain requires PASID to support on both device and
> > IOMMU. If the hardware lacks this support, it should return failure.
> 
> Sure. Flag is fine for us. We can do
> 	domain_alloc_paging(dev, flag)
> 
> But that means:
>   - For IOMMU_DOMAIN_DMA[_FQ] : pass DOMAIN_ALLOC_FLAG_PASID
>   - DOMAIN_PAGING_UNMANAGED  : *No* flags

As I said, VFIO would have to set the flag once it gets PASID support,
which is likely to happen in a few months.

So this won't solve the problem you stated of poor DID caching.

IMHO if you want to optimize the DID assignment then that is a
algorithm contained in the driver and we don't need to disturb any of
the core code or uAPI for you to make that optimization.

JAson
