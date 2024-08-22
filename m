Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2511D130F
	for <iommu@lists.linux.dev>; Thu, 22 Aug 2024 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343869; cv=none; b=eQdIiGycLTRfi2VRTJ6nT3j13TkLzpznO4rcYN0t4v37psEXtf7KnjPGu8Tr3iquTlwRO+6HVezECe/lWOPp7z30xlfEqEBvqvzRO+mN+Rv3oSXKWYgVzVTeJu9R7vjtEGglyEYLbRxkSeeHVOR8TMQ9fl2d45Pwb/1Zr/+VXb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343869; c=relaxed/simple;
	bh=ATxYdoET9i0tpoYEYnSCwulRxYkpITICJ0RdslxkZwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rrg+YTm78BmEHsFBFDkLWhMfngBlj3i9kmQdJlF+ARTwoRZoiWxCVzyRzBp7809apvl+87Xn8pcrJMUzzkqrYFqWLD/Q1D3/QPMF07P6CNZKTQ5lB1lK5QQn0OKfYaw63+EwhD+rZNexrfMrPuseOhape2WsZnmCigm05pb9qDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YaKIhLUC; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YaKIhLUC"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6bf7ad1ec3aso5485216d6.0
        for <iommu@lists.linux.dev>; Thu, 22 Aug 2024 09:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724343866; x=1724948666; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+OUWg8fYZllfQV1XDu+F1uxRA+l5JfuQjDnhYEx0Lg=;
        b=YaKIhLUCgNdzD/LRFvjkC9JlxrbHeTUoCgG69aeVEnfMmmrti5Vrk5NARBKAQDBatR
         HmV9ghsO+uJ6wKiuR90xgRrH65Whpq26bznP3pCAwG7wbEYsqgToiOnGfbn6nu1QjV//
         uCjHpcA86PZlvDsfH6jU9Qco/xOvd/SFg2KUsegr72mQPb4/RQAIreH3/WlLDW4dVQsP
         H1O/QC1bCd1kv/no4A+r0/iOkN4zAut2eHTN5XPO+vffalwMMT0QlEFzqLt/CvpzBT0A
         PzrZUCvQhkDA6PS5xWBgWzUjkUl6O4hA0/LWaraKo/XVNQ/84TnZw9gOV9WTiF1j1dcg
         3LbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724343866; x=1724948666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+OUWg8fYZllfQV1XDu+F1uxRA+l5JfuQjDnhYEx0Lg=;
        b=YDPqcIOYZwdz+2KQrS89SGs4lzbPYmRmLYfOANMy3ZAIDdOyW7id8u4RmTxU6TWEBe
         LexVne21jj35uFVmG4gqomrAVJ32FHP6y6+XoO5QepTSxyPpkv8smWTnxhJ0OfAQDYCs
         9xmOKigpLCo703nSCcGvxWmcRP1EpeK7O7G59V4jfxnZz2vGC4tsxyMH9yug+wlifOd0
         7Uoh1lbqkljrKQCMj5zhv9sCcXxQP+w6LCCj4BSILuQ1i+OCFmzVg+ZfmYJRDGYb25s+
         66pJArp8T3V618TjMqegGgLiQLpANIqFXXWvD+6cb+L/2v/tNuyS/0iJwoUICGtwiIpx
         58AA==
X-Forwarded-Encrypted: i=1; AJvYcCVIofCquX58xP1dVNJYk9b3NRiFOdtsvEnSViJ3hgdN30+imWPNwEKH+Wobo6wWExTHbQRx2A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3LNl8uGJbiyzZtVMxJgUEDwkL6gCTSKRFGOe/yJ52E2EQb4yQ
	QfNI88ZMwm1D+6K/pe3itXOR2S5bWtCHp1CkFrj+tICvVjIFGQSPBYDu6kPyXmE=
X-Google-Smtp-Source: AGHT+IHQUMAushC/6F0n743es9SOL7bUKFJqvbyWITaa2Kk/SJ8KSGOK7+3gzFI4+gQRrz7/1kMK7A==
X-Received: by 2002:a05:6214:2f05:b0:6bb:a16d:279f with SMTP id 6a1803df08f44-6c156843ef9mr73410596d6.38.1724343866522;
        Thu, 22 Aug 2024 09:24:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d7711asm9043146d6.73.2024.08.22.09.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 09:24:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1shAbp-001IVy-9Y;
	Thu, 22 Aug 2024 13:24:25 -0300
Date: Thu, 22 Aug 2024 13:24:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, andersson@kernel.org, afd@ti.com,
	nm@ti.com, hnagalla@ti.com, b-padhi@ti.com,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-remoteproc@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] remoteproc: Use iommu_paging_domain_alloc()
Message-ID: <20240822162425.GE3468552@ziepe.ca>
References: <20240812072811.9737-1-baolu.lu@linux.intel.com>
 <ZsdktJEqR9BOgivK@p14s>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsdktJEqR9BOgivK@p14s>

On Thu, Aug 22, 2024 at 10:17:56AM -0600, Mathieu Poirier wrote:

> > -	domain = iommu_domain_alloc(dev->bus);
> > -	if (!domain) {
> > +	domain = iommu_paging_domain_alloc(dev);
> 
> I'm a little hesitant here.  Function iommu_domain_alloc() passes NULL two the
> second argument of __iommu_domain_alloc() while iommu_paging_domain_alloc()
> provides a 'dev'.  I don't have any HW to test on and I am not familiar enough
> with the IOMMU subsystem to confidently more forward.

So long as dev is the device that will be initiating DMA this is a
correct change from the iommu subsystem perspective.

Jason
