Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2B560EC9
	for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UAMoSEJi"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1f9e0e44fecso55462fac.3
        for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 12:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701289577; x=1701894377; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x6z49foDTI0A8Rsez/QUHUM8NOSZc6Sqb1M2eWkhgNk=;
        b=UAMoSEJi8hC43KdZ0YpeZtkhbvYVqc81o/G1DYqSiPVwa6h4z4mBj/omw66cz3oxHt
         Stwr9ZyK6YQxIFXVC8rjN4oWi7z/ElpH6r2vqIEgKMT3O8HN8bgy7Bul6vshSpWsJBCU
         sJm6GsgUBxNUrkXfkoPAL5tFokcPjrcBR2UmxXktNgVL6fVKTsiDH9I/Q67k1qbWCNEf
         B8iJO6CxqAR4HWCRsm7eRvyB/oSWVAafe2snj0joqFDIrgJ79hZXIyw2WpZOddTQa5wf
         r9Oy4TkQ2s60DFLWXu5kEYHLG/8+C7xZ1G+3qsjADvIUev5vYYMYk37wx7bsAjjesOcr
         0klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701289577; x=1701894377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6z49foDTI0A8Rsez/QUHUM8NOSZc6Sqb1M2eWkhgNk=;
        b=A20yKxWbDdKv/dYL/pVRyHVqueQ4rGGdoikCzx+fhRKOzmJmaERFtu19IOM89jEtb+
         UpgSbJ43u4J24KAuNPePG/i0tGw0RqRcbHtvMzLF9jslpwgDotMipynWv1l15sIACJFw
         NUdXj/cKVJv0j5QnvR93tWEkJ/4lHZHPvWjo1A/AcGdsATsj7+uwpRCrc/XhY5zaShab
         Ee4BzKExeDulTvKn+xQMcHtLKB1vdalx6x+wJXsZenZxefuEr0w9lOyYJkQwvP2r1Rof
         d+4HD14V3aKQWwIEgbXbJ9brB2BHn/YKmITM9lomjWKfJkc5k/Y9bqfIXuWdOlV/a93X
         D/HA==
X-Gm-Message-State: AOJu0Yz4yuI5Q8gSjM70T0yScOuZPRfksdGhz8dxSR8XkfFo313u4E84
	l+ze2OggbLTliOa998dG/QjEEg==
X-Google-Smtp-Source: AGHT+IFVTteECB+xmpu720088oIMXevUkET4BohI67g+jhntOHO27CDgUE+PEhM0GKWy+AP5H7nPKQ==
X-Received: by 2002:a05:6870:b05:b0:1fa:31a1:487c with SMTP id lh5-20020a0568700b0500b001fa31a1487cmr20181244oab.47.1701289577175;
        Wed, 29 Nov 2023 12:26:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id be5-20020a056830350500b006d6496747b6sm2115087otb.80.2023.11.29.12.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:26:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8R8R-005pZh-Up;
	Wed, 29 Nov 2023 16:26:15 -0400
Date: Wed, 29 Nov 2023 16:26:15 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iommu/vt-d: Add support for static identity domain
Message-ID: <20231129202615.GN1312390@ziepe.ca>
References: <20231120112944.142741-1-baolu.lu@linux.intel.com>
 <20231120112944.142741-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120112944.142741-5-baolu.lu@linux.intel.com>

On Mon, Nov 20, 2023 at 07:29:43PM +0800, Lu Baolu wrote:

> @@ -2311,6 +2316,13 @@ static int device_def_domain_type(struct device *dev)
>  			return IOMMU_DOMAIN_IDENTITY;
>  	}
>  
> +	/*
> +	 * Hardware does not support the passthrough translation mode.
> +	 * Always use a dynamaic mapping domain.
> +	 */
> +	if (!ecap_pass_through(iommu->ecap))
> +		return IOMMU_DOMAIN_DMA;
> +

Doesn't this return from def_domain_type completely prevent using an
identity domain?

I thought the point of this was to allow the identity domain but have
it be translating?

Jason
