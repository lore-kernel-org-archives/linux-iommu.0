Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B77E18643
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261958; cv=none; b=QnEFfrB7wFBnCOVKjU5ePv4KIY564A1F5e3fVB42MsehTBmvwcG/Jrh8Dc8YbBs0JczIqlxgSBWtRumrTAVBQ0zlilNGSAq3U9gVNW/Kp0Pai9coxq4VOgel4FIFZ7ltk68KwrQyWx01AAI4bWA1lq5OJfQNr0QOhLbmPb+ErUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261958; c=relaxed/simple;
	bh=opxE2sAKs8BmvPb3sigfZv+bAQ1BlxCHzutlCZ6pdeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgUjuf3p8/ujSrQH2/5bcVKnpWNQdlPiJONbUciMEZWiw6l72XwjGK9aElaHMem+tlvVNSsQIWci9WZ/mL8MHaUH724iMt1nfVtsN2/zqY7qGSgrcsLI0PJIFw2yK9+i4e+/FZ0SySuBU5H88bjHzq5X52hu2Hfxau9zQWXiKQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RtBRpgUu; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RtBRpgUu"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b1507c42faso134292785a.0
        for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 07:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729261955; x=1729866755; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z7CdlOG32AEy0vkPpZmdkyz7uC6JrduWNlCwOdYoEo=;
        b=RtBRpgUu72Dx2ME6dHsOTwICmkq1Qt3QG2dhrULHM2BF2b7zl3JAiBfQ59SrF+Op2A
         S7S4yi2TItjJDpoSigHI+9kMR/78mVoXS7Kma6+ebIbWfKd1Q3HMSDQVns1ZGPLRCM7Y
         cLmHhbItUcM2ZuYK7D9ozIj5MJBG9Can4sWtS/b3HQ49RJ2Ux+nQJbO/OPeAdY3YFLFm
         WD/9lX0u/FB9RKZRJpp/S4gR1rkGgR6oN/fphVV7KrvS0EKAF5aYnUB1tFIEB2xqeIxF
         ClOxuo1AmP010Iw0AHLEZ0JF3qOXmFm4MDqy3gEcvJysbzIrufyuwa2KEMAIXQ63PziS
         q3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729261955; x=1729866755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Z7CdlOG32AEy0vkPpZmdkyz7uC6JrduWNlCwOdYoEo=;
        b=qQY8dYNTDualj6u319orWLDx8x4WM72X66Bx4hr1IeFfTwpsRN1wb2+N48mh2GCkkP
         qQe9qPOblK+PJbEuumQXvCMxE2RRH51MnJrK3pkfZqqVhKVflAlq9T6e6TVXCQSNXnc6
         lNrENtEI6be7VoCr5UH740G00O1mmQoD1E3l8JtEZPRPT1gTixSspUporN20s902AGZ1
         01xpS3EVrUdzz7+6+WwTmRXHc6h74M7PPGuQnKf7C9gcJuS8294hy9QerbgAFV1zsGHU
         kBfYMwHCgx9QUndzcc6elVl5hpVFNT3dviPvJX1Vp127qd24XMs7324CNxyqH3NYVFc3
         fKcQ==
X-Gm-Message-State: AOJu0YzwelIhd1e4WfyWCq7IXqjIcfLW0tt/tZJYu29q6kWku0qPgbHY
	CsBu+MjsMj0t+eBBbsXXJXtmnk410O3TOkdfa7C2OmT5XXiMAG0TcYksxyIH5fU=
X-Google-Smtp-Source: AGHT+IEx8fqXlC3pp+k/FFhFJzjJ4VEFwtUMRY9CEO3vQboofvdH7t9pfxXSsUgP9In9GA76JtgwYg==
X-Received: by 2002:a05:620a:179f:b0:7b1:4222:b385 with SMTP id af79cd13be357-7b157657bc1mr379884885a.11.1729261955357;
        Fri, 18 Oct 2024 07:32:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b156ff0c5csm73854585a.122.2024.10.18.07.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 07:32:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1o1p-008Eta-Tx;
	Fri, 18 Oct 2024 11:32:33 -0300
Date: Fri, 18 Oct 2024 11:32:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v3 12/12] iommu: Create __iommu_alloc_identity_domain()
Message-ID: <20241018143233.GM948948@ziepe.ca>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-13-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017140137.6028-13-vasant.hegde@amd.com>

On Thu, Oct 17, 2024 at 02:01:37PM +0000, Vasant Hegde wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Consolidate all the code to create an IDENTITY domain into one
> function. This the legacy __iommu_domain_alloc() path from all core code
> paths, and preps it for final removal.

Ah some grammar:

Consolidate all the code to create an IDENTITY domain into one
function. This removes the legacy __iommu_domain_alloc() path from all
core code paths, and preps it for final removal.

> +static struct iommu_domain *__iommu_alloc_identity_domain(struct device *dev)
> +{
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
> +	struct iommu_domain *domain;
> +
> +	if (ops->identity_domain)
> +		return ops->identity_domain;
> +
> +	/* Older drivers create the identity domain via */

via ops->domain_alloc()

Jason
