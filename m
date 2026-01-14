Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08DB1E98E6
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389170; cv=none; b=D3ei+2VzZ34pnIx80ihs0Y5N1e1ga56BaHjz9IFgc/8VTqqe1y9k+sS3G9yunfEw1/EU6CHI4Rq1gsrA8B4xMaLfdY/2jh3hbt+HYoaaxM7nWnft3mhoVbMWRWO9ywUpgqhoRgsV+3+76nWW6s5gERLcgVH/XdAOm64Oqia1VNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389170; c=relaxed/simple;
	bh=YiiIXB4m376SMBEYw0oDLToDNFi4w0vs0fNtZFVXXAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvfMrMf7a75FnxW4HcoyuPBhub7L5vr7FG3SjvK0uxPYBNpjTLEJjK+kHDI5br/ovQqouCznTmxyVQ/zce2ltEaSUPdOB/Cc7CQs65j+0EJV+j1CmWNQxaCehB6fbPPMUiR2K1zpygQzAkhAijR0J7CY3+fkgqCU92Lu6jPb8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TUGr4AYO; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TUGr4AYO"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64b791b5584so14178289a12.0
        for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 03:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768389167; x=1768993967; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xuErrEDD6LEKFLnxAkiNejSn6LYGgcXZoCz48zROcO0=;
        b=TUGr4AYOaxrE+z3D4qknaOvVTWA0gSkWb7peMrfyOjpN5d1gDIV0hKpOU+iXvr94zX
         dNVkM3fN/y/cczwfDFDz9q+uQx0PVslma8RYw9L0Q8p/VhMRVmO2/5mzMFVmQSDcXRsb
         AEHcsO1O+TVsGUi3Hzh3+4KulJvGOQVZMfyMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768389167; x=1768993967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xuErrEDD6LEKFLnxAkiNejSn6LYGgcXZoCz48zROcO0=;
        b=YwzVOceU3qd2qjmaQ/cOHPlZZ+DEzMja0b01se4qXnHKVq3TexTUpao7fYCQ6bAZ5y
         2JW7v6Xo4Rn/eWUGMYtdJcQJPRYE8ZzGNHVJ2edJClCETfarQVWSiOin5qhZJfO9mYad
         Y+cSa/2h2ZQIBKfdlWteaw83JsXbD6kAjSeOtI7gaJzINFbIffJZnb/iyHeiDmZD1477
         Z/Zjro6JL5CS7wzasIUQWD4Pa0FDUZRwWAyY+G3TDidrer86+CDyJnlVQcV3o0uD7j90
         sjGm4yJp4WI3z9j5lWckZLQI62Om0fhkhjlrvGqLu6L+FkaQBCuHn3/pMlSq3W/v3OlE
         DyEw==
X-Forwarded-Encrypted: i=1; AJvYcCXE6ANMQFoZrcQC35RDXPReZmV2F/2R45c2PjXaQVMx9xEI6LdmaAw+aKvcxEKZ8HFp3wEAKA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzcdjzn4QfCzuSpE1QFA+7KXtGhnPJ1dpukuVhsDNuTXLFJkw9Z
	/y5T4qyqqVkk40vbtCPWKKDm8D5IL+3K1xhsMKAwR77la9X1Wnu/IXCTDVFf2HPkcw==
X-Gm-Gg: AY/fxX4s+O7u/qbXZPBEP3+7MjH9MrLi+TK3Z1Tn/DXezHnny7otGzmdiGKCL/CB+77
	aALX/P2mozwfyNzCK2RvViFcTgtfx26XVLgGMyHXU+4PeZsHoCKwbi4clYd/OxsD4h8Tjey4CpH
	leJwa0Cp8MMwTgolmCde0heOcJ8am3G+S6ux1cy3XwWUBMQupUPKexkvI8ahJRSwXl6fzp0Tbr8
	LWlv5Qgw5WT3qB+U4gXG5TukKXZQBdakIr1HXhr3E6ZYJnNWjutn5SsLxsRwbGaHIsBGCrIp9Q2
	O0VPiifMjRtP/aWBJJGrLsRjG2IxRzdTR0z+gPR3OvX3qLYXTywyrjrwL8qT+tebi/27+7dc+xF
	Wnh7ql6P0MhBQ5b9MPukjCuA/P1xCKyLSTAfj9bW1GfVoaFEJ92vwKTAwQfjtYj5EpNGP3wA2dI
	25skyiLqT45i4Q2bwMWab3
X-Received: by 2002:a17:907:6d19:b0:b87:892:f43f with SMTP id a640c23a62f3a-b876108019emr184539366b.29.1768389167032;
        Wed, 14 Jan 2026 03:12:47 -0800 (PST)
Received: from mitya-t14-2025 ([2a02:a31b:20c3:6680:8f9d:1786:e151:a9f5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a563f0esm2532511266b.60.2026.01.14.03.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:12:46 -0800 (PST)
Date: Wed, 14 Jan 2026 12:12:40 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>
Subject: Re: [PATCH 2/3] iommu/vt-d: Clear Present bit before tearing down
 PASID entry
Message-ID: <aWd6KIGBiE-nL2IT@mitya-t14-2025>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-3-baolu.lu@linux.intel.com>
 <aWaeUJcAFQ_vbJtd@google.com>
 <8e232d7f-9436-401e-9abc-308492a1fcbf@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e232d7f-9436-401e-9abc-308492a1fcbf@linux.intel.com>

On Wed, Jan 14, 2026 at 01:38:13PM +0800, Baolu Lu wrote:
> On 1/14/26 03:34, Dmytro Maluka wrote:
> > On Tue, Jan 13, 2026 at 11:00:47AM +0800, Lu Baolu wrote:
> > > +	intel_pasid_clear_entry(iommu, dev, pasid, fault_ignore);
> > Is it safe to do this with iommu->lock already unlocked?
> 
> Yes, it is. The PASID entry lifecycle is serialized by the iommu_group-
> >mutex in the iommu core, which ensures that no other thread can attempt
> to allocate or setup this same PASID until intel_pasid_tear_down_entry()
> has returned.
> 
> The iommu->lock is held during the initial transition (P->0) to ensure
> atomicity against other hardware-table walkers, but once the P bit is
> cleared and the caches are flushed, the final zeroing of the 'dead'
> entry does not strictly require the spinlock because the PASID remains
> reserved in software until the function completes.

Ok. Just to understand: "other hardware-table walkers" means some
software walkers, not hardware ones? Which software walkers are those?
(I can't imagine how holding a spinlock could prevent the hardware from
walking those tables. :))
