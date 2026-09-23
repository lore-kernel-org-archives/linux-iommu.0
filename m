Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8A4481224
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158439; cv=none; b=k91JiknH+ZzQA3QYZvtYJ4wC3d+Nu9CVMVoB2Dr+b7XVlmUrYyhAeGc4LTs83K7iSm/Rv0dJ77N9avNpOumCXzVy9eW8/rJG9J2ZWCju94GJOpDacIJB8yDjXfY64+Oh0AL2lPazOw6xLKpK2XcV+yB2oveUQ9XFt1W5Sxlt07U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158439; c=relaxed/simple;
	bh=86tGOrPEB/iivl/l0MEf2yHA5M2eh28fX8Zw5dM3jqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNs32kk9sGNsGsFLWwFPLl70+THUkorTe/EeizoTf143uj/QNJkywn+6GE4Z/tSMqJFYLOeCzmduTO1CQsq36FXSjzpKpEJdI9E6qzUubngtM9195DARH/ns5SVtHtMmKhKaM8wKoeS2FwBGcue+vPFLjEv/+kFq60rjWVfJLS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ln02HIXw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ln02HIXw"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49e6425f96eso35765e9.1
        for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 03:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790158416; x=1790763216; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vdEIBnHA/8T+E7XayOUCjgaZYlTP8ZfuwSF0Dftqz2M=;
        b=Ln02HIXwsbl8xs9zc124170piWgfJpsk5IRhLVrSa4G82/QME7/uTQTHqHDWZpOs0q
         gaH5eltfXC4S3wJIR/p+a1WcZNpHkSurpfvZmAPTPLqkHhAZ1mW6W0Bf5YRNTgLKItBF
         pqDOpGTEioBYD6T+pqd8/QFPg0Bz8/IgUAU3eTjQIQUiUCEOuNsEomMdUTHTbQwHy4gS
         inHctEnc1aNHb+KozRNZ02PF4VJI619t/NaLhhWcDxIJk2tb8gMQtX+rFHfVu7o+Xj73
         QmbsfHsPTwWrX0VSzcNFKK8cGmFiAAr+nQn0cEE8C/6/2ycHUobsrQF03LhhLj4Qh+NO
         bMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790158416; x=1790763216;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vdEIBnHA/8T+E7XayOUCjgaZYlTP8ZfuwSF0Dftqz2M=;
        b=0fnYQoruEdjLkU1rVBN4hWZ5RlmZi2mS0TXJwIJAScr2lG+aRxm57SksR9xBBYo3/M
         y3YP24+d2DE6flwNiaqkkBwqJpmGdsFxn7SSxHXm1+upCrKXo9jOJmuv9HJme3o4KT4e
         sP22ddSrkBgDGCzDWxE6a2Seo7JBlzfgzd3/oOTYEHmNpeMNqzjFs1D280bOmcaMf3pQ
         hcaplw/Q4CWTDC4vOkzHzqxTfshFxa9N7wgnPnzOA4cXkqnqCxbd8m+QM47ewM/RtZWo
         pb5idYMcKaFmGGrz15z4E8aEv2EoJ1hY4X1EuYYdCUdEFszFGs2djeiZkkeAfu+bAvYf
         i/cA==
X-Forwarded-Encrypted: i=1; AKwUvBzEPK2GMxVL3qXM2PDvxhQqmcFxv+LHiS/de2wTy+LsLEG7EurYzQw/OESO91NwysL5Y4aInw==@lists.linux.dev
X-Gm-Message-State: AFuF++nvs0n16cerooy5qMDOCJ+EvfHqvposy+KoLyBFZDF2zCt5Ulew
	M8F4eVfxY+lg2xjqWfWY7CPuKHINKWcZl+GiGZCxQIGSSId28oLyuGEPXAjhdBzhrw==
X-Gm-Gg: AYBFou1SZEDxap21KJFoamiFZh3xXu/lSpycXnHteuNmMSoVIZvHHnlntqjyQ51HXgM
	ogfXu8ifPhG+8bLBdqNScDWL3j4Pqv4YkBHWE1afgszc8zVGvHhQgoJRfq0zbLztP4PuPPP8xrI
	i9WaBzbw05TvYhuHGtZktORPYIJec4GMZ142tt5QHzJzX7I3lBZUncJXvJw8dl7ZUHuy/+Dguea
	uTk17NlZPwqGbV341ChNW4saAyxDAcZ6sxrsleyhMQwTED8fyk6tfnfH8FQvAogdRYLhpIEILuQ
	aksLaGuow+Q7qTODx3qVEti4VhfBsi/PbKZ+Oowh+ilhfdAy2eRF3D9IQH6h6U2ahQ78tXxAYuz
	kR/WawBV++IgeFnY2Zkc0lAOXhLJ+f1gMUjRWUGK+ZWdMDgMmiV/8flji5+FThyRDOGplP4NUCP
	KrY6Olr28nSXLKrG9Z2/Wqg0aZ1Uw6KaHIPnxxLoezobe9f1EKM+hpxSB3ZAVAsyQIePoz9JGo/
	/RXGaMimM+pOvFQAUbJ8zGjES0gfLZwG9xLpiwVOQ==
X-Received: by 2002:a05:600d:8653:20b0:49f:e0f7:257e with SMTP id 5b1f17b1804b1-49fe0f725e4mr416395e9.6.1790158415606;
        Wed, 23 Sep 2026 03:13:35 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868486408sm5194076f8f.9.2026.09.23.03.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:13:34 -0700 (PDT)
Date: Wed, 23 Sep 2026 10:13:31 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, mark.rutland@arm.com,
	qperret@google.com, tabba@google.com, vdonnefort@google.com,
	sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v8 04/25] iommu/arm-smmu-v3: Move IDR parsing to common
 functions
Message-ID: <arOmSxqRxhd717Xy@google.com>
References: <20260922131259.2975334-1-smostafa@google.com>
 <20260922131259.2975334-5-smostafa@google.com>
 <arLa0E3xq5dGuPpd@nvidia.com>
 <20260922214818.GA2545495@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922214818.GA2545495@nvidia.com>

On Tue, Sep 22, 2026 at 06:48:18PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 22, 2026 at 12:45:20PM -0700, Nicolin Chen wrote:
> 
> > Also, Jason's suggestion in v7 was hyp_arm_smmu_v3_device, which
> > looks nicer than ARM_SMMU_OBJ...
> 
> I guess the point is to emphasis the substition technique, I don't
> mind.
> 
> > > +	if (coherent && !disable_msipolling &&
> > > +	    smmu->features & ARM_SMMU_FEAT_MSI)
> > > +		smmu->options |= ARM_SMMU_OPT_MSIPOLL;
> > 
> > Will pKVM ever use MSIPOLL?
> 
> Not sure I understood the approach in this patch, why was anything
> left behind? I imagined everything would be moved?
> 
> Maybe a few more remarks in the commit message?

As replied to Nicolin, because it is a module param, I am ok with
adding this in the commit message, or passing disable_msipolling
as a function arg and moving the logic.

> 
> > > +	if (smmu->features & ARM_SMMU_FEAT_HYP &&
> > > +	    cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN))
> > > +		smmu->features |= ARM_SMMU_FEAT_E2H;
> > 
> > Why is ARM64_HAS_VIRT_HOST_EXTN left behind?
> 
> +1
> 
> And the TT_LE/BE and S1/S2 checks, and ...
> 
> If kvm doesn't want to dev_err log that's fine, we should able to
> #define that away too shouldn't we? And maybe it does want to log?

The hypervisor can not print to the kernel console, so dev_err()
will not compile, I'd rather keep that outside and let the caller
decide what is a probe failure and print it's own message that keeping
the code and stubbing dev_err().

Thanks,
Mostafa

> 
> This seems pretty close otherwise
> 
> Jason
