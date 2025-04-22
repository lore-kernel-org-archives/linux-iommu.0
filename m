Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB521A76BB
	for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745348966; cv=none; b=eZdWiK9LcGeeeyTkMPljMc5B6YSpxg7Nd26lei5Jo3F1CE/TL9zTugtzug2tVIIJC1YyquGG0uUsdHhqEeLOa9JxgNyqYbKL7/NqKojpEdEdT4btB5v0I3HincRhT/xWJ4O3Cg+L5yUziVAZsZirVMAdSof8LB6Yan5ZWiz1Mxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745348966; c=relaxed/simple;
	bh=Dm1Bdw5Cwxm1RgWBTZQDppgB/DUjE2ED8xVVUD6VHrY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdiWRlwFqH0D7PYIhLAb6fmb4ZUfbIgvApU6e52IucDrkfofdUXY9iIuuSGsBhNmr4pFIQ7vmYfaWubX3fJBhrzKK2eBmyOdYgHZ1Ofilg7Y78XzXYbJTP03WtBjutqhEY3/hMvdC0bAu1AZLgljk4duvYG5NQT6p0MAWIDN9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cfVuma0O; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cfVuma0O"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c554d7dc2aso882916985a.3
        for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 12:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745348962; x=1745953762; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l5KwgOa0BGBtglnb/EmAwT1KJYw0ByggohSX6F5Qhzg=;
        b=cfVuma0OCO9K2u3FiD/U5FdKIOdmiHpjnKyWHuCtHWjSZzr9gK/OE5eUBg7rD6IXoE
         b1mWhQLHgqh6XjYMkYXaocdv6bnfpUzGPqeLgl1eUZduLLgAmBc9JyOxQc7WfTccbDwo
         EQZLbts+g4PkwjnvubdVCaPIc019GjGaF2mLCpWXgp4A4pxnN9DNYAJ8OyYD1nR0nj3n
         SyM1Pidy8ZKYQhHiqtpIMrnf1/qWMcpjbbEPwWpNnf4lKUApsXY2mD8znNcNbcoYXMm8
         JZ4iK6JNq1K17F8QQXiK2nyDVKGyw4AENM0kCuz9TF3ySzMRsmnt2Nkl53XYVcDIa1kj
         WVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745348962; x=1745953762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5KwgOa0BGBtglnb/EmAwT1KJYw0ByggohSX6F5Qhzg=;
        b=U0O3U0+tLY0R3z3zkb1sjcYiHQqKBEzVJTMQR/4AnxWo6PljmYSk0SrS2duk0JRMlo
         ensWFZBf1QHM+uk+uRBJVGIxvXmm2joW/izysY/icf5jSJqbK7lrM6fCJ495NZwrpWSg
         mwl4EAsLrMMTtsWpnmQWpdhgZfz27oR4L6irUutWEbpQvWUC+/Bk2s+kwMfvg6jxNU15
         EHey/Sg+dsn9BOUrrytzdFLjqVnp7SFLBbh+EU1KtZNuehp9b7+Lo4vMq0aZv9skIyn3
         YdldjL6d1dzLQl9z25e7xgn294WC/2ozh3eaxPbEBm/FFA2/l+pCbLbtwnrhzAfm9lVX
         qeww==
X-Gm-Message-State: AOJu0YzyBI+gJodJyIaQ7Bh9p9aTw2hR1ExzhzG+oTw97DT1rqz5cKa7
	icqMX3q0yii2gPgN3aAMton7MX2naZ4qv6Z4lAwtzRVwykzi964LCWOwjy9fKw0QBspjX0AzSXT
	O
X-Gm-Gg: ASbGncu3AiMhGPIhNZ4Vl1A/iTxrhBb1eS7pO1am92+Xy44aUhQePg6qbWA7Kxr25lX
	dv05NAE6OP5EQV5/EeAzQXWTzpFZSOWeXl3ShpI2DwMMjdrcdfV1pfr8Ct2DsykUXZ0O1Bk2nc0
	PiuVAaBmelcuA/8C0fjiwoPkhUBs56+MVqmRxVXdfRO78izqHpHA0wJ1bjXg42SqgrsaObaYaU+
	AWzH2lkugN79YdHWPENOzrVDNtpFe4z2RuqAluB9VOq+clCpANQf8x08oRNJIGasNx8FDyUAuLm
	psiu0Y6eZkoBJSUebT9KMPG8uIE1Lou8K4/uP7toz7JkK4j/xlEK7wnvkNtDys3EO5+cCgwLhfs
	59dRAXnvnAb6kYOKADlM=
X-Google-Smtp-Source: AGHT+IFhAGFfyv8bohe/pDvVL8xD9tiUQcnS5dS4QxAQwB4x0kumkU1YhBjNi9x7Uz+SvdcDBwQGFA==
X-Received: by 2002:a05:620a:4627:b0:7c5:4a3a:bc12 with SMTP id af79cd13be357-7c927fa8740mr3038817285a.32.1745348962481;
        Tue, 22 Apr 2025 12:09:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b4e01dsm592265185a.75.2025.04.22.12.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 12:09:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7Izh-00000006vaw-26Wh;
	Tue, 22 Apr 2025 16:09:21 -0300
Date: Tue, 22 Apr 2025 16:09:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] fsl_pamu: Use 40-bits for addressing where appropriate
Message-ID: <20250422190921.GB1213339@ziepe.ca>
References: <2025042122-prudent-dogfish-eac6bf@boujee-and-buff>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025042122-prudent-dogfish-eac6bf@boujee-and-buff>

On Mon, Apr 21, 2025 at 10:46:19PM -0400, Ben Collins wrote:
> diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
> index 30be786bff11e..a4bc6482a00f7 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -214,9 +214,10 @@ static struct iommu_domain *fsl_pamu_domain_alloc(unsigned type)
>  	INIT_LIST_HEAD(&dma_domain->devices);
>  	spin_lock_init(&dma_domain->domain_lock);
>  
> -	/* default geometry 64 GB i.e. maximum system address */
> +	/* Set default geometry based on physical address limit. */
>  	dma_domain->iommu_domain. geometry.aperture_start = 0;
> -	dma_domain->iommu_domain.geometry.aperture_end = (1ULL << 36) - 1;
> +	dma_domain->iommu_domain.geometry.aperture_end =
> +		(1ULL << PAMU_MAX_PHYS_BITS) - 1;
>  	dma_domain->iommu_domain.geometry.force_aperture = true;

What on earth does this even do? There is no map_range() callback in
this driver, so nothing should be reading geometry..

Jason
