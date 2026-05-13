Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0EA4DBD86
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694253; cv=none; b=KALBQd2TiHmU93cqbWl45X2GGnYI50nH9WVPtoZ++A/ZbUex5mMVHbO7H1R0P22dI2/RVIuu8k6QARkWUABzBinYZXcm66JhsGjUsJzNvlG0ixr93Efmtc85K3L7RMUQm6YxGBZp6+/oMtBbf5oyenu9nHD22TCyxaM50POUbog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694253; c=relaxed/simple;
	bh=X+MbUVbMjLu+rlmKpQgI/8QF3Ke6PKRPBaagAPDg3qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Duw1EAZv0/aOwkdFM5rPYLCZVaWUTuNP2bAK9qz9B2nYPuOCxVMusjtAE5haeMh+mxlTwmCm0DJ0X9qNR0GGcfSP+eBbnTtqZIy9fyi9XLQs4hdF2lKXqzUzal9g2rphPWQ/WErY4HK2M9YEmkW02b5uihg6VxghnHavuCZ9Lx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G3QIBYu/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G3QIBYu/"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ba180a022dso3625ad.1
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 10:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778694251; x=1779299051; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4BJ4po9Dvpfk6XI5pkU3ene6W0TLSq/94NAtPnHwHxU=;
        b=G3QIBYu/wauU5QEmtFeh8QA9UfiZuCUsw0DY/lKQg08g0kcSX10JEaxLzFHRT5Y45M
         JQkntIYa+j/Dhc4ncHrLG2XRNk++opyXM/X8brs6l67aMIRDFitjAicJOBnrtQr1QfuO
         UXy+DCSwLx4Wwf6Pq8Qb1NaHcWPdhxqdB7M6icXxKIrZtZZi59RutvPQhYoh9bbF+0+v
         6nNGejr5JVTaGAV6kbhYH4wracxmT6WrtPKldd7G3Sn1yRQ0LRGycAwe4D7+3+enku1b
         IMvZIuYWW0PHkqyjPQ2KrZ4flb9xICYeNTQ8B24vkfiCUg5cMb1mtxhyG2QjEBKvJUqC
         UC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778694251; x=1779299051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BJ4po9Dvpfk6XI5pkU3ene6W0TLSq/94NAtPnHwHxU=;
        b=nKcNyqXbhqsQxMBLhNaxViK7+ABRwJnhVY2tfAdrCEWzDzHOtjYV3+HoRoIIAPWfRL
         zuZCxYABTw5QihPqDZhhL85h4NrAAE51hRQip7HO1hFU4g7cVdNhqJ+wJwQWCGAg1g4f
         0yN8w8aqmd6dGMq1kn6jSaH4e7u5mqjhnIwwNQcMR2o/01MXy0ixUhRno5ugZD62/EPz
         yqvyMlFDggpRPBLWYoebrQFOU9P8dKLO+NLzkobyKi3qrOcH11W5rm3znrYIou/AH20M
         Z7V6kR1U5J7Y9o0ZBQVzDBuSuibWQglbQhqFAG7NSD6i8upzvKpkTGROGvegeP3F9BZv
         QkDw==
X-Gm-Message-State: AOJu0YwywST5EwvreyCcXsm9ThJjmFRSdUnS32g1HcyJKqk6o48qfViR
	lAvE5xshnw7vTTD2Mfi1S3EhA0PpA5b2tCv+Z6RpLQo4zY8p2JuF/3c7G2WB6QIzhw==
X-Gm-Gg: Acq92OE3WD8pseqde3kwvvF9wS46SI3tgqOHA1W+B70ySXUvpOY5Hqykl64+AQbqLZe
	30Aros4gaolESHJItBDhD6ifB/MPKm2aWqDIfiTNO15gITzclexqwBREYJ178lXUds9CtQ0oYOZ
	8A/Pje7/O+H1wkgY66OxP9A7TdZCSw2OGC1RxyAn2PU91k7I4MOAbms9F+Bb+7yYp5+UhfPVph0
	Od6X/Pxr58xD6P+5TG6Eb6wzGX2kUyuyDD43RcNvgpJjLRZApiwD2lPjvzBy7rZUuL/uyJzdH4U
	ls4FaSXQvz5qf/1qEv1jtW1pa4JqjR3IWOg0DStnWD5dg72VK7yA5VF0ojjEXj+RkgfjttuKe3/
	pnVkwAvNiaxbSLj8ezzL5uAMLO2pqAcMIXkVz3Ns3UPGF1yKHQxvEtqmO5etTFUBBnFrYiw0Slw
	AYnV/wEoMvaSsZdyEI3pOBR2jFuNFgvHY3L3a9+/Ol659n0BuYo/PJNDxh0QaOHPeShJB8
X-Received: by 2002:a17:902:d483:b0:2b4:6529:7bae with SMTP id d9443c01a7336-2bd579828c1mr113055ad.17.1778694250324;
        Wed, 13 May 2026 10:44:10 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267688e2esm15538264a12.8.2026.05.13.10.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:44:09 -0700 (PDT)
Date: Wed, 13 May 2026 17:44:03 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Josua Mayer <josua@solid-run.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH rc 2/5] iommu: Fix up map/unmap debugging for iommupt
 domains
Message-ID: <agS4Y7KDBlU3nR_u@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <2-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>

On Tue, May 12, 2026 at 01:46:14PM -0300, Jason Gunthorpe wrote:
> Sashiko noticed a few issues in this path, and a few more were
> found on review. Tidy them up further. These are intertwined
> because the debug code depends on some of the WARN_ONs to function
> right:
> 
> Lift into iommu_map_nosync():
> - The might_sleep_if()
> - 0 pgsize_bitmap WARN_ON
> - Promote the illegal domain->type to a WARN_ON
> - WARN_ON for illegal gfp flags
> 
> Then remove the return 0 since it is now safe to call
> iommu_debug_map().
> 
> Lift into __iommu_unmap():
> - 0 pgsize_bitmap WARN_ON
> - Promote the illegal domain->type to a WARN_ON
> - iommu_debug_unmap_begin()
> 
> This now pairs with the unconditional iommu_debug_map() on the
> mapping side. Thus iommu debugging now works for iommupt along
> with some of the other debugging features.
> 
> Fixes: 99fb8afa16ad ("iommupt: Directly call iommupt's unmap_range()")
> Fixes: d6c65b0fd621 ("iommupt: Avoid rewalking during map")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks
