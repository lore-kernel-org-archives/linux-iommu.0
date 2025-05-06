Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5DE2820CB
	for <iommu@lists.linux.dev>; Tue,  6 May 2025 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746552585; cv=none; b=k+xh1YMhD2fvPKm+Rw/nWtnHOd2m+AjsrtiuYRLrq7FV6tIqyLi6p3vGg5qhPIm05X4OPSSlZS2qgnPhpjdJfu2vWlD2ViChheb+mmBOWV9lXEpmigxG/B3PEu3WYgRl4LFeRE2PGd2dycS309NHReo48W3OdGnHKb4nTBKFAhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746552585; c=relaxed/simple;
	bh=P5P11usWkDjq0CdPX0+FsxN/e9x+8gnH+2D4IK1ObN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKcijxKGhgs1H+hl3of3dcX3HDnJHMNPXaS7EGOWA+Ki1IY65F9HveQ0EcVqanVwFiOppJcT5xKlc2MHjcuVVq+BAIi1KhHG5EXdirmR86h2ri1Ns3FDR4LPFw9+wpw0NUASLde9MLKRPDyErchpPy9f0TlkOP+g+xWj+8Jb+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q/7WWk6G; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q/7WWk6G"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5a88b34a6so630862285a.3
        for <iommu@lists.linux.dev>; Tue, 06 May 2025 10:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1746552582; x=1747157382; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OaMyDCrAoG//6LMBGGysI9lA09I32hvxiR+VhJh6OEo=;
        b=Q/7WWk6G9yzGhTczRcB6ZQ3mi3YLsZB8so1wu6o8tfJs1UZOvEUySdn2X9O8ES5kUy
         eCR6ExEBNhrLsRL2cVbDfNBVgVq1lqwe/EZ9egAg7WAz3+mxh01zvL1W7pKTAphis+17
         Jt3hK2iymwks2WQn9WhsRre59JQI+slIbw6Vnf2pNz0S5kjEy3TGaYwdgIxUwUpdlL+h
         LatyRR9OXwHl7p+ZCRrpkX49W+No2oXmu6QXe3YO5RCB8qJobAlMrJ576mZBBOHt6wzf
         xRnia39m+kc8eZRjwEX/E8f7sIwOsoMIYAGcbedh4mmqW+pI9b6IDUx7Tn9BuevOqa25
         OQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746552582; x=1747157382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaMyDCrAoG//6LMBGGysI9lA09I32hvxiR+VhJh6OEo=;
        b=jQxk5kHuRN/bHfyc5y7be5oLkXUC1mhrtYYLpxJVu6laQVr/2PFZ8fabviSa31LF1d
         6LuvxV7DJQxJHBtxPpL0RSqLCaArxVF9/Jfhd7gbJEDoIwxWijzOk/w1a2tv34PC59OS
         /nx/KDCbYMGspgTPCGAsAu68QJiB+VtachzG+YJ7+x6wHPndsvbIqFHd9vjwf4i55XN3
         swsZXg91ejtLzMpypIHxUIFegVDXsQsQdoAya8H8VPecDbP8BrWkwtBYcOvAcNlbEXCK
         XPh5DOAud7g+qsf2R3EaMDfaiPLOfy11CyzmdICJVYN92eNIXPhue51bFS7kKvolDQid
         4OFw==
X-Forwarded-Encrypted: i=1; AJvYcCWdSHEIh4llArEdQgMNC/heXkkZ1PdrW8EQBoUqRBAPiYuEjB9bX96aLfwujaaa/6ffHqt58Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsgLw7dTW9dT5WyUwBcgraGlBIMixhapbLDDz7aw+EuXfd2UoF
	aHzwb7aTvVIJlz3iIPs9Tuieh+pdAtneE5ybgRxlI7PM1Yinn3ayX9vZaJYAYa0VMIfvmFQr8sq
	p
X-Gm-Gg: ASbGncsBQu58ybsxReSv+1kujgtIjzmkco8DsEMprufQ9lCo8VmL1chGxckHipTxQo3
	Rw2OxXhJ603k1UwgQ+1b2McB1UHmdfIVkjXpwOStUOTWyTnhWIu7sRelp7RUJD8cZP8fG4KbZ/1
	2MU67E9+tzzbVc6+fP+sflRhbQE561bh4HL7/HBZhnyQGNS5z97sdrITvWuISsWlXHBUoqGnWiX
	dYJXOXbBJ+6I6YgGco+g0aoKZP3yt9hsIB7peNt6mY6nd66N3n93lBb22iLlBkvbbfIOtuSBJpE
	4+h2d/Q/Ilp43iLXD42h4WuAL5YaB2odwI6YgpI1GlrojXT6uarxR3KYIFjcCYHWe+Q4by6HisZ
	wzPW/cEJc1JAxGKUru7o=
X-Google-Smtp-Source: AGHT+IFMZ5fIINTPeKhkWdgeEHlC4vrkCQlZ8NYfWErLZxx+U/X8plflWy2yROICiyb87lWzQQaofQ==
X-Received: by 2002:a05:620a:46aa:b0:7ca:e989:23fd with SMTP id af79cd13be357-7caf73a1866mr28024085a.24.1746552582447;
        Tue, 06 May 2025 10:29:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7caf75b5334sm3266885a.80.2025.05.06.10.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 10:29:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uCM6v-00000000LGb-2K8I;
	Tue, 06 May 2025 14:29:41 -0300
Date: Tue, 6 May 2025 14:29:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iommu/vt-d: Replace spin_lock with mutex to
 protect domain ida
Message-ID: <20250506172941.GB33739@ziepe.ca>
References: <20250430021135.2370244-1-baolu.lu@linux.intel.com>
 <20250430021135.2370244-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430021135.2370244-3-baolu.lu@linux.intel.com>

On Wed, Apr 30, 2025 at 10:11:35AM +0800, Lu Baolu wrote:
> The domain ID allocator is currently protected by a spin_lock. However,
> ida_alloc_range can potentially block if it needs to allocate memory to
> grow its internal structures.
> 
> Replace the spin_lock with a mutex which allows sleep on block. Thus,
> the memory allocation flags can be updated from GFP_ATOMIC to GFP_KERNEL
> to allow blocking memory allocations if necessary.
> 
> Introduce a new mutex, did_lock, specifically for protecting the domain
> ida. The existing spinlock will remain for protecting other intel_iommu
> fields.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>  drivers/iommu/intel/dmar.c  |  1 +
>  drivers/iommu/intel/iommu.c | 12 ++++--------
>  drivers/iommu/intel/iommu.h |  2 ++
>  3 files changed, 7 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
