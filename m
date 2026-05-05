Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710B2481FB8
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997491; cv=none; b=TlpiEAZhyQeMQ342Fbdo5UdsDbsIkw7xU2mhv17fIK6P3298fv+s/urm72QMbdz39l+ICsYYEo7z7Qfn5JbfR0nrfSoXO6osqOaBCepgjNs5BhjSFFVCg3zGV+hQsq4fbAF4pMsLr6pTuBhjcAsdATq4xA//RvH3S2XT4vZef2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997491; c=relaxed/simple;
	bh=RB63+vKaagSktShm0zw04FwFu2zaUl3ea85kl4rSlm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKbNGxySsyf3SYFeYl3Z6fyO/0d5Xr1zX4oznEIhhTsMnDQlb8n5OZvlzTPuPMEzJp4Gur3VdRA4zi2FiUx5dGIPjEirPTffzsT2GjQlEKb6h+uIiCAl1hWQG9ui9MG7opNXaVGt8h8r3kgudCdbKW6fxJBwXFy5uYC8HI+ELu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=o5TuyOtp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="o5TuyOtp"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48d146705b4so13782925e9.3
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 09:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777997488; x=1778602288; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3mLXC04zFhT/Lrh722HvmOadS9CRUyg7tuq/peX8SkA=;
        b=o5TuyOtp7bLVFoiyBNlIKMSK+WSENoOXrsdT7wS1d8nXklLUIwMiNBUGYMSrZeOONX
         7s0qZ1/9YGpzMRaXGn3CKwa5BSGqOOzwr5gejwuoYYS1dUiBAuU5LdxZiDS/1/7uPVld
         oQh3Ok/zhvsMqKCV11wU8gtoHBS/oQN3SAZ/AmT/UvCHSJo877c+Ln8Pjt+0rraqO6Sw
         Zvw/M1x/r4xqzl1EysMjcMrEGlhrwMu0ZkJD/ixcBXVN3M3+jpAY1chIZwhGpYlL8rXJ
         5ed/dH+fYfDsiCyF259wc8ARTcKZmxoO6I0MlAfbaQLavTEOaOAwV5RQUWDeRY6Pg9Vz
         qtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777997488; x=1778602288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mLXC04zFhT/Lrh722HvmOadS9CRUyg7tuq/peX8SkA=;
        b=oK932LDw79BWVSy4v2SkZ0HuTPhJ6riag1u0H8Rzapz/RHl6lrRKuJHSjxqWelSQjk
         SgQY5DtUxwG1IxUjHJauQJtnETdi2wlQbtgoOwDe+790M1KPa+L7qRcTNikcyGkJK0Df
         TLES/BdAYXCtrG6bBymI/a+fsJaubUM5mRMUuUetq6XdiK/QwhsCSedQ7CdBwnGBtrg9
         Jr8bXt9R9QFnET0+CmEZ6zt2JKPqPWVAM3W5HgDUpsNOmSqq8r5UdksCC7LRq3w/FjY1
         JIP19ciBpv2nnXsa+PdjlZHSkQxJL859DtFyXp16iTZK6tiUkws4fdMmwPEkP653oMj7
         C+hw==
X-Forwarded-Encrypted: i=1; AFNElJ8/dqqskiPbK6UpELBHp2TNDPkEMW3NLjmnp9O0I4QzVBte2jYnxOYsYKpPnLdZwJmsTAvjyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbZD/nnQeT+nY/lN2aBzBVJPUcV5IXuG30SPu49gTplKeJnn8w
	fEk51OmhAyZM1YCL1fOoyhbbIhUE8cokmQJaBlor7pI/EA13kP6SS7mgZQuvbtdCykNAwh9Eb+v
	orokFRcbTkQ==
X-Gm-Gg: AeBDietc7T7tNBhyDsW4lZMJdHGeFAg/zXXAS1y1ALicPgEOTaEtgleZtiHIz8hFegN
	lzaFmDgp7S0itYBMjkHPSIpexSIN89Hiyq99Va48lA3zcbZEVbSrTcJ8LkduBJ0fgxAv/+rcP6a
	TqQ9Vp8qjpVl7O50oQBQkA9jvKtWu4p7IXJ6vPiYH6P0c45gFpdvmfpq0h0Eu79x/gTMnjBVDWJ
	4w74tJAVPFCJDxH4Q0untB7YabhEHGzi+gcg5Dn+VAwcLqPeX32v1YulDqNCEqT2Cwr7wI9UaDh
	vv/BJBAf6dGW6YUTqPmlUaHXG65vzxsTdq2UBQluc0sZ1LIF4en8LQ5cwxHemPEIe1x1Pr/aDfY
	PQ02iW9iQAZBF6d8QSPW7vr2SO7rEsBR4ron23fpI8VllcCqnjlBmhC+0817aFqTgK4Htgrchp+
	OkUdaUcBE=
X-Received: by 2002:a05:600c:45d5:b0:488:d6eb:e63c with SMTP id 5b1f17b1804b1-48d18be7d40mr57839665e9.15.1777997487815;
        Tue, 05 May 2026 09:11:27 -0700 (PDT)
Received: from ziepe.ca ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a824f9f0dsm393238945e9.15.2026.05.05.09.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:11:27 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1wKIMo-000ALn-3b;
	Tue, 05 May 2026 13:11:26 -0300
Date: Tue, 5 May 2026 13:11:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <afoWrn/RXxDmcHsS@ziepe.ca>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afj0cyBZwkVLyIwK@google.com>

On Mon, May 04, 2026 at 07:33:07PM +0000, Pranjal Shrivastava wrote:

> > > The issue was exposed under heavy load when running a VFIO-based DMA map
> > > stress test: iova_stress [1]
> > 
> > I wonder what's the real reason for pci_enable_ats() to fail:
> > 
> 
> Yes, It's the dev->is_virtfn case (the one you suspect below)

Oh.... This is a much larger problem then

The VF should not fail to enable ATS, that is a meaningful bug, I'm
not sure why are are just discovering this?

It looks like the PF unconditionally calls pci_prepare_ats() during
arm_smmu_probe_device(), so how does this happen:

> >         if (dev->is_virtfn) {
> >                 pdev = pci_physfn(dev);
> >                 if (pdev->ats_stu != ps)
> >                         return -EINVAL;		// maybe this one?

??

So, I think the right error handling for a case that shouldn't happen is
to fail the attachment not to try to continue it broken?

Jason
