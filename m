Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F3D30F547
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771962207; cv=none; b=HSBB+SJJy5fyf10l97zW8xOj0+v6KmfE3kVzvAjSncDxKS626cA0l8BsWtH07ZlxqO5e/3rzRINGdn1fn3/tdgcpl8RuVDrc7gM6uTajq5pXX/24l6o0LDnPuk2jHvtP/pKqWIKtfHD5qFz6B33ynSu8rxSjSF/l37OQrTeuom8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771962207; c=relaxed/simple;
	bh=9NPywY1WqiH72ccbR6wJ+8VRtBE0/jLqQcAKN4+hlD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmyP4vkOTezdkna33hakup/uKGI8I+743uQD2IDj8rRsFSWd4IHj2bjo0/wsv+YCLQTCG5CPGIEStkJXtKUsNgJtTRtS7JygyYM1k49/vr5zpcLSshFbzPNoSkIQDg6D85aL9ov7xLUIDrhyZyiejosNg7Mz1gHHO4SCko00z0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dJDQX/YZ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dJDQX/YZ"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-503347dea84so65270901cf.3
        for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 11:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1771962205; x=1772567005; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T8RdEsygv8bZF4bGPNG6h1aXJPCxbAU5PwKhIaLMAAE=;
        b=dJDQX/YZBPf8giQqTJCqzwuMtyX9X854wuvElBDzB2tsVLKw3ytRUjw8YFSbM1Kc2d
         ygSsI36mNBy/80v55dUx6laCmw0LCuIH136dwxgqSdwVDw2/XeXRDAxziB+9P0is5Alf
         D8gnj3cu5yH9QVnGDzUeKiJ4617d6ZLs69isgdC0Xo6QxlUkw0Xjv9oCd5t52+KgAg+M
         GfN9OWo+9RplnFSWw/re3SdAu8+aENrbUDBJWOoFEXrlx1AZZqZC98W2KblkBk0HVebo
         J1fuIV/wnddPrLXrJJ7MbNH/o1sB+xAu2zbVDJbtlRqX4cmm6VJJRazQjO2rdDezkBB+
         lMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771962205; x=1772567005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8RdEsygv8bZF4bGPNG6h1aXJPCxbAU5PwKhIaLMAAE=;
        b=NFluw9zdKeQIjQu1NiXR/8DjY+AQrJsGB52T4HgUSXBHAPaozwXsF759oHvPUSeapS
         UsbP/p4t/kW1ZMg9HYxmXvEvqm2B+QpU7TVVzmh9DtBTY2wKJjIl2Fkyhmf3/R8uDNRH
         YBmomlP4agEqC0RZuZN1Ntg50dI9dKvc5R0s1lardBuOkh8sCpMubGKaFK6lrUTeNw62
         cBfUzAVeWbaJ9tOqwW/OBTWDxbGf/PKAeTf9pq8jibFsxySsYvSE6NHdWm3A+X0hx8Aw
         Sx4EYqNjhqTOjSHmDl5j/SBOKjLCOccutz6QmrCfwhZeccX3Ic2SY5jwuS0qG1icvR/T
         ZKdQ==
X-Gm-Message-State: AOJu0YyYFeEm3Pwd5I2RhJ9Eglaz3f3HQdRZrJJDnI1GPx+b3MWVv4TR
	BblWr9n1UWMUSgVXCv5XWeqBnq0jGHUqomDzO8d9I2YaDib+oBqhGv19Z9TjCHOh2Ho=
X-Gm-Gg: AZuq6aIRb5Y2RNGkH/DMUzyFdk/6hc+8xIwwsmB5vL8aebllmCNj/fSFwM/24rcLnQo
	TYz4g3q49nPCh3a/lpbiH/p1jDhO5D/Hk1N/CpE2cb/5A/0x3KgBeBC3VP+XNCFbX0f/r8Scn5m
	I1XUjf0fTm0OrNvhjq5tTWtFFkkmUESU/4v07mqAxJhRj/G11yWwagQFO+M9euPbyhQA1Cj3D8t
	dc1PfX/wFiRRls7OjRtzyadp2zlJReyLctheNXZVyvssH50wmhSmCE87rJBLNytr08GxwQJkuPf
	93di5MhlnAQzT5Hz4EG7pROFc8xf2LJV9TpBeQagtLj5pUSPrjYUwPgZvVTkA61CfPqutSwRpml
	o2TWdQgJcHEoBr8ncy5sSKKM1DXoUkGdpDnur7ZKE+13IiF6mTEGv588yH4V/4Z6+N9t5EhaHQ9
	g=
X-Received: by 2002:ac8:7d50:0:b0:4f1:ab79:fb18 with SMTP id d75a77b69052e-5070bbde667mr191957571cf.25.1771962204944;
        Tue, 24 Feb 2026 11:43:24 -0800 (PST)
Received: from ziepe.ca ([173.231.112.170])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d54000fsm104631011cf.10.2026.02.24.11.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:43:24 -0800 (PST)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1vuyJX-0009cT-Vr;
	Tue, 24 Feb 2026 15:43:23 -0400
Date: Tue, 24 Feb 2026 15:43:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	dnaim@cachyos.org, Mario.Limonciello@amd.com
Subject: Re: [PATCH v1] iommu: Skip mapping at address 0x0 if it already
 exists
Message-ID: <aZ3/W8sw+gW5aTA5@ziepe.ca>
References: <20260221235050.2558321-1-lkml@antheas.dev>
 <aZ36tRwNP8cRRX1l@ziepe.ca>
 <CAGwozwFPLLFfKP90fFrt-QC1rKPRCVo_iHuLm4roHX7erQ=Y5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGwozwFPLLFfKP90fFrt-QC1rKPRCVo_iHuLm4roHX7erQ=Y5Q@mail.gmail.com>

On Tue, Feb 24, 2026 at 08:33:50PM +0100, Antheas Kapenekakis wrote:
> On Tue, 24 Feb 2026 at 20:23, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Sun, Feb 22, 2026 at 12:50:50AM +0100, Antheas Kapenekakis wrote:
> > > Commit 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> > > introduces the shared iommu page table for AMD IOMMU. Some bioses
> > > contain an identity mapping for address 0x0, which is not parsed
> > > properly (e.g., certain Strix Halo devices). This causes the DMA
> > > components of the device to fail to initialize (e.g., the NVMe SSD
> > > controller), leading to a failed post.
> >
> > I'm trying to understand the issue here, is it that the old AMD code
> > incorrectly succeeded iommu_map() on top of an existing mapping while
> > the new code returns -EADDRINUSE?
> >
> > Then the existing guard for double mapping doesn't work since 0 is an
> > ambiguous return?
> 
> Hi Jason,
> 
> It seems like the previous code correctly handled the 0 case, and the
> new code does not due to the ambiguous return.

I checked the old AMD driver it is definately returning 0 from
iommu_iova_to_phys(), so that hasn't changed.

> > reasonabe. Just please clean up the commit message to be a bit clearer
> > on what caused this regression and add a short comment above the new if:
> >
> >  0 return from iommu_iova_to_phys() is ambiguous, it could mean a
> >  present mapping. EADDRINUSE is reliable when supported, it means the
> >  IOVA is already mapped, so ignore it to resolve the ambiguity.
> 
> If you think that this patch is a long term solution, I can drop the
> print, the addr == 0 check, add a comment on top, then repost a V2
> with an updated description to be more concrete.

I think it is a good solution as-is, I just want clarity on what
actually regressed here, and I think it is that iommu_map() behavior
changed.

Jason
