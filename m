Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3164D33B6C8
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668658; cv=none; b=m7RaHnHN0OGBZeyyyCC1Jd0ooDD8zE9hSX7HOPgMs8AYxr+2Uv/JpFzJWuEewiikA/LWPCaAD0DuQ6cmvJV+qjcQKeL8wAUxwa9jQ7pZUZVQv6775olzO3XE2aBLJEiQ+6YZVQr4WwUpGx5tvyDh0t1gr6RGlnlkQXBrTu4K7X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668658; c=relaxed/simple;
	bh=W02qjvHYgDMmbpjNbp+lJoOTYJg9xT1q7z0bTk3ZHys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpTfJXJ0Sd5iUQkI0s6EDQKQCIGd36RctiDdyCdol5wxmjonlyp6XIbfiaO5qW3TQddjm+Xhr3PjddYG5/wcsBu8c7IdXwfnfGBtEYFsRs1b8Wj0cG4hbvybdf4tpo3ib4w/Wg62C3EVIhB4yKkiC/oGJMAfrCVycH0RhbGsvT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nnDXrgyW; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nnDXrgyW"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5176ca6bab1so20531411cf.0
        for <iommu@lists.linux.dev>; Fri, 05 Jun 2026 07:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780668656; x=1781273456; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UR0H1P2VS3kaB3iZ1809TswMb1cbtGLR3JmcUIz3mWM=;
        b=nnDXrgyWLHGtrlkEVeufqTmYWb6N7uBdJ1jKj+YK78xHP/Sks0PM1XH+4K90Spn4PP
         71LtDwMJVhfRifOyzD//xMXf67l7Kke0gg5du9MIhMp7ZzNVByxzSx8yqCwEAB6nb37U
         og7/hSUflrR7995DtR55N7ZloM06cHING8HDYczw0OSzK/QurDOkvnD+OAEzPaBc8HUN
         O6zABy5tWrlCBYg9RfXaLcUVEjp4mnlnrL9nUSLTe1rde2w7q0HV1h6I8pOKUYcjl+Nx
         1b+YQ2UUZ0Q+k+414J+7Gny+WpXNx38YfBDJJQmiSLp2Lb+oBmctNcDuyXue6OnlogrB
         OcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780668656; x=1781273456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UR0H1P2VS3kaB3iZ1809TswMb1cbtGLR3JmcUIz3mWM=;
        b=OG386hiTbM0hELEeBYdZvTLuLs8KzdsvKQBwq+wBDoH9Z2UhoqehvrtV9hnr2iUKXl
         JMfvzDoi4TgIklov51nbeyVvXSx3FzhQGbba0gHw/4o2OSZD/hvrW8d55xlw94SnRg/1
         SoG34t8QP7SaBND6M7SOGNsNWepBcmbFLxXVmmhtfw29ZBOBjDwUnNorCkAdcxW+SQdk
         Lo7w+nRBq1ghZwU7p1dE3FBXWSiKXtO7fuGQ2JSb77Nn9JKj/ZBry23V8chs2nYVhqxP
         P/LDbkrFp46RjyCr7nEd27CdJtyzYGaqJgjMkR4z3TTxdutW8e6ujNxvpWla7boaLrNA
         oWTg==
X-Forwarded-Encrypted: i=1; AFNElJ8Xt7kxqdCmTyFW96ounOf+yIJvuYGsHS64Sf/J/sc2F5RWIlBlHCTmH5TMNpDRQPh8eWS7NQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yym9uhwzI672W+t7yL+eMBL2p2627NqQVlCSeDmOwJyC4axxWEC
	IGmrcdj3/f4J5bODSKO7VHiTMI72KozGU4Qt7T1UjZk9qaGSBkXu7e15Q7fOf4LWDJc=
X-Gm-Gg: Acq92OEU3xq+9KNdBow/PJmX9+WlAwMKvDtwDlki797odfizA1trj+4yb00EDApJ5+n
	Ep73NW+EYelC2vgqRT8vERU4IWoug7FHcW4tktksR7KJHClkpuXUt4BE4bcAE9OfHJdPCWrxwsz
	JPTIN25jPp9wN2gKo7zqJZxRdn98279k99gyBRjyt8HPq5gojQTCyOrvkAvYditTc9i2u1rdtFo
	A4wxzWwzyqOxutsY83qiazE7jl3RJpHwOpeO7w7B11ojEuUrvvJgKNFMIp42jjzdwrqINEWYmB/
	fkOQg4P9GzvSSMoskRA7SDitYnq2hoUkziUnYFF5pBVFR/VJD1lXRelNbsbo9Nboe5uTZUToya0
	wwcXT8OjUOGaqW94xCL63fhIJQOUAzu6S0ELBSXaZkAnJcvW5s0s3o/aSCbMBhiTBnORm+GyXCd
	1Bd9BUZSvHK7t5/dWjWXuRJitRdjkCgAeovbFcoo6Y9JURDYUsINJfIzsLtdNV9m5FJTm3vKrBT
	Rkfdp7UejAi5qw/
X-Received: by 2002:a05:622a:244:b0:517:5f11:b353 with SMTP id d75a77b69052e-5179888c297mr31853621cf.41.1780668655956;
        Fri, 05 Jun 2026 07:10:55 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775e2e16dsm80797461cf.31.2026.06.05.07.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 07:10:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wVVG9-0000000BEgc-3cQ9;
	Fri, 05 Jun 2026 11:10:53 -0300
Date: Fri, 5 Jun 2026 11:10:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: Will Deacon <will@kernel.org>, robin.murphy@arm.com, joro@8bytes.org,
	nicolinc@nvidia.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iommu/arm-smmu-v3: Detect Tegra264 erratum
Message-ID: <20260605141053.GF2487554@ziepe.ca>
References: <20260601104845.995005-1-amhetre@nvidia.com>
 <20260601104845.995005-3-amhetre@nvidia.com>
 <ah85c4u011WNJQgE@willie-the-truck>
 <09a501ff-d1e8-4035-95c1-a6df9f0cb9d0@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09a501ff-d1e8-4035-95c1-a6df9f0cb9d0@nvidia.com>

On Fri, Jun 05, 2026 at 07:35:35PM +0530, Ashish Mhetre wrote:
> > > +{
> > > +     if (!(smmu->options & ARM_SMMU_OPT_TLBI_TWICE))
> > > +             return false;
> > Maybe we should make this a static key?
> 
> Okay. Shall I add just static key and remove option bit, or
> have static key alongside existing option bit such that
> static_branch_unlikely will precede the option bit check?

You'd have the static key and the options. Keep it simple, enable the
static key once if any driver probes to set TWICE. Check the key
before options to get the best code gen

But IDK if it is really worth it, there are already lots of branches
on the performance tlbi flow, and we didn't do this for other tlbi
affecting errata..

IDK if we really care about branches we should also be doing things
like disabling the range/non-range paths and ATC based on what is
actually in use..

Jason
