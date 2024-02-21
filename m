Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C7E8060A
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530015; cv=none; b=LFEvRL6UF0WWePOZQxBJ93ILA8L/UWrjIy4oUy6VhHVjo7/el2rIuDlaEODnDJmb7h/YWQIVwHNChvRR2g8MgAI84i20L0qf5ywVjdj2c6C2H8Xjq1NlarrL9VvfdlB0ZNpsVWKBaO7VicxE93qaGugPtzp90gIDTWzTQPG0kGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530015; c=relaxed/simple;
	bh=96xfu/ouzriUH60bX/QlTKilA8Z4OsLCUCAiI5+vuOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ci/qBJBoaA5dV/z8mNBlncODpvaxHlnNKsRhT32WXgQVYWytEyCCERIt9fj73yNy/5ZuPGTCkX/Wxs38wN8MH12/3+eFdPTvVlwB8TlI86qKF1Luuf1tTktFOGCBZr9K3DsVevxCKPrSuWbOrw95gPKA/8C+/en739ABKsAovas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Y6woR6vo; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Y6woR6vo"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bb9d54575cso478553b6e.2
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 07:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1708530013; x=1709134813; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c/EcdnXy5zHBejejLatJVqAEruFgiaEfzzpOoPh/aDs=;
        b=Y6woR6voCaZtaaPCuzWDzuwgJnuKD9UoSCJ00CaAbQnn8qh9dRW9oOeF1/9TZw/M8a
         SF/4NpYPY3SirrAq8gp6y5+6rVXyV8BPXf91OQwbkABmVdZnuU06Kj7CwAip7UTZ0kMJ
         KX77Uzr2S6QBJ3Tkb61Yqui9CDmzRLG+YGxhhI7y+qQRfkyzlX5UoNVn7FlfGQZrDLSy
         fOUExbjJkoQFpHr+DmvpmRWMFa0EvPN+nWX29wRm9FB22TQOorx6LTED27PvvFChpfRn
         4NE3oiZEygxQqcGMbIAsLxxFoc6WQHMDNtONzKjvawT8kWEUtOw+WbKYW2aXQpDzSn1p
         wsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530013; x=1709134813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/EcdnXy5zHBejejLatJVqAEruFgiaEfzzpOoPh/aDs=;
        b=SJo4DHNOhS6PhTEU7c8ATbII0Ae6Y3hGG3/0zXqlNA4Xssj0DBfAIMbP03l7bpPLom
         A31MD4aWCcXJf6Nvaa+dYvl7fX8Fi+Z43SvlYXV5Td2xiMkOwukwTKTPQjoBzsf4u03o
         ElDuLA2AsRfKWMjTn/mFham435F/ufuRL9elf0X78Y6XbIFQ1kPewFYdparLHiB+m2Hk
         k33FjlJYsPlgwrZcj4lEDE2vREk2Kpk73gnkjXy8j/5R7zOWayO0jTpWqXtNq/xMu7Kn
         NxrWkf0ohZdX5mYjcZDoQHq0ywndKGFx0CiOMpxRiPNyHlEYqvesiahbfUJfsWmnhoIG
         HXwA==
X-Forwarded-Encrypted: i=1; AJvYcCUIB6UPCmdyIeqf1exli2DemO9iscjBW+AANxFglXKBtIn3jWgpNbrzjCXoGqctL0OrUIczYCIZjoWHN0DqqDVgIPxQL5g=
X-Gm-Message-State: AOJu0YzBMXPcRmQZBMG4MRllq9Wx54bAhfrDEC6SYZcnChYDTtZjY6ak
	jGa4cPTqZVJQTmJvjiKZlz6jtP1bFQV39W0ancPUW4+XUHdcui1d03g3/Slka2Y=
X-Google-Smtp-Source: AGHT+IG+kmpMRxxp0YFDSSIfQrxkjBFHwU6q1DujwecqtkB+lPQDTRXsUaS3XIU79BX+gWBVZ/rNog==
X-Received: by 2002:a05:6808:13cd:b0:3c1:7019:ae9b with SMTP id d13-20020a05680813cd00b003c17019ae9bmr2199970oiw.43.1708530013104;
        Wed, 21 Feb 2024 07:40:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id e5-20020a056214162500b0068f0923ff12sm5578477qvw.30.2024.02.21.07.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:40:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rcohg-00BQrQ-0b;
	Wed, 21 Feb 2024 11:40:12 -0400
Date: Wed, 21 Feb 2024 11:40:12 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Eric Badger <ebadger@purestorage.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/vt-d: Check for non-NULL domain on device release
Message-ID: <20240221154012.GC13491@ziepe.ca>
References: <20240113181713.1817855-1-ebadger@purestorage.com>
 <20240116152215.GE50608@ziepe.ca>
 <7455b538-e934-4377-9ab5-004ee991b3d2@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7455b538-e934-4377-9ab5-004ee991b3d2@linux.intel.com>

On Wed, Jan 31, 2024 at 03:10:53PM +0800, Baolu Lu wrote:
> I like this suggestion.
> 
> Currently, the device_release callback for an iommu driver does the
> following:
> 
> a) Silent IOMMU DMA translation. This is done by detaching the existing
>    domain from the IOMMU and bringing the IOMMU into a blocking state
>    (some drivers might be in identity state);
> b) Releases the resources allocated in the probe callback and restores
>    the device to its previous state before the probe.
> 
> From my understanding of your suggestion, we should move a) out of the
> release callback and make it a special domain, which could be a blocking
> domain or identity domain, depending on the iommu hardware.
> 
> In the end, the release_device callback of an iommu driver should focus
> on the opposite operation of device_probe. This makes the concept
> clearer.

Right

Can someone make some patches to fix Eric's bug? We don't really need
to do the release_domain stuff if the driver just self-attaches one of
its known static domain types (blocking/identity)

Jason
