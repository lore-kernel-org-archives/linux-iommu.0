Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA16126C18
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493603; cv=none; b=fSaAyZsWMyV19H9L2kbGesAy1u9M6KvRo7hsjRkuKVAav+BOpcFxcAqGbyIWsDCsjes54fXB6UJcKYbQuoInWT86mFNDQ8o5EluEg60QHCGWXpe8Ld5urAZeYuxQAfGPeE/9Afw6B/Ip1PW2GhPqa0JCioaJBb3svlHRtZKQAE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493603; c=relaxed/simple;
	bh=n9Y1zWdlW7XdvxCgigcZQ294bMPYRptmF9djWDGanjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+yMovEkqzR6jVES3WOELRZ2nRT74XnaihO+zFPZM0UivvuYM2txVPkN7Af5L0g4G57IEazZUyTl4VWi72rrOW6s7b8idRGlelOjAl+/VlARY6EhAjCltPhLHTVOy0/OSTfiEAQv3cTIROrWAcgP/K7Sa5OjehImNI+ueI+HsHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Tkn9mUlJ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Tkn9mUlJ"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e65be7d86fso62695116d6.1
        for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 06:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740493601; x=1741098401; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vwKokAatgiCcL0k0jHomkX9bY7N8OAn5bboh4atLxe0=;
        b=Tkn9mUlJoP77+OuLrZ2Q414QnuK7BkrY/bou+0/YH0ROsLLtGVr8XGd+pFvbcM3ylh
         Vs5Gib8M08VX1hyxJQXaseYJyZ+59Eo7xgICWd7kjWIrz9VA8H2IahUXj+KLzFwjnEsC
         9s+VG3SzC3t4gU1hJjhWdC9O0+ZuRZ2CQqi4wcfdsSh1isgA8Ts4w+jEwyHMWI5sJwgE
         Bolh/PWt1iABJeSo4XOztRFuyz5Z7NtYMnP8USr7myAYDAOHftAtmzucwK+fnkcnlE2Y
         pPH4wkFs5lvG0SitEahlhrAzTrfdYQJnTYDGHxwpu+4v0cCC/QajB9r3ihDbpPSlB0fM
         2OsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493601; x=1741098401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwKokAatgiCcL0k0jHomkX9bY7N8OAn5bboh4atLxe0=;
        b=lQHgB03ZCgZLC7Re82N8l5d4QyWM9CqQO2tBl3tNsfm2eNy2PC6KiTFt3NLKMCzhdF
         1z+G4vEVRrYTK7t/PKYLvxvre8+NkROfvsmEdQkbXhftLZt1wfEAj6VggHHSujbvo6E3
         tx1WwMbLGhHuOPCE0fzgndVyXmIvg3htR6ESoKexV/eLB9HPglVWErkVUiidMFtdYEl+
         cFUeslLrD0/6A3JVl60TekpZq6I4jtejoyfDHSioOvE0a2H+gCihby2h426XNkEUv3Gq
         t/TnNLfcC6bOLjZJ1r/TLkgnFpqcDMMPtoeE4Iuso18IZbsiiaSdNqhKjurLndrV3gXB
         Husg==
X-Gm-Message-State: AOJu0Ywl5IJpMT5evLchatD9roZZqSWKMAGNUAWcCiLKbi+I1lTb0U2h
	NsPZ7QRIblAVVhatsCT0IGRFmNdheqMa/1sW35WCaR41yN+foV6W7JRo2DiJmT8=
X-Gm-Gg: ASbGncstNb7VdGAuN+jeBxIJUDaBeWstsTFOxfOW0jjWpBSF6BrMwl6daGqOA7iK+No
	bAK2uymOLWioWC3j5PW6pQzvDKOel6TVQ+sVOok5lAtWDaqlhfCzxHaTykl1JGmVvNBwACP+/iN
	6ZYjckFMondpO0S8tGQwKMPz4EVvZNc5tUUycxGZhE3H2BIGyAMxRRClmumgpAsf3hyMGfi6Eh1
	PL+qJ1GxfeTxyRmjo6wGX1YMfnGCc6kZTIG21CjpG+KhF2puoRVi5vS0ZIdSRxQTlDBrT3IuCCY
X-Google-Smtp-Source: AGHT+IFErax5GNv5M4UF+gT12hN4C5+dx2u+kXojxB9jftz3EhxTDpFoJXcfESNXE0159ZMg0RYvCw==
X-Received: by 2002:a05:6214:224a:b0:6e2:383f:4acd with SMTP id 6a1803df08f44-6e6ae77a99bmr250310566d6.7.1740493600832;
        Tue, 25 Feb 2025 06:26:40 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b17103bsm9810036d6.94.2025.02.25.06.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:26:40 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tmvtP-00000002T2f-39V1;
	Tue, 25 Feb 2025 10:26:39 -0400
Date: Tue, 25 Feb 2025 10:26:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 1/7] iommu/amd: Log IOMMU control register in event log
 path
Message-ID: <20250225142639.GC545008@ziepe.ca>
References: <20250225105345.52143-1-vasant.hegde@amd.com>
 <20250225105345.52143-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225105345.52143-2-vasant.hegde@amd.com>

On Tue, Feb 25, 2025 at 10:53:39AM +0000, Vasant Hegde wrote:
> Useful for debugging ILLEGAL_DEV_TABLE_ENTRY events as some of the
> DTE settings depends on Control register settings.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
