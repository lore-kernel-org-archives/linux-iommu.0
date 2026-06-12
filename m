Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E993396590
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267279; cv=none; b=m1XtTATHjZssGARg6V0wd+1LTP+ZMgZBTfNlFDR6soOydIHhz1tVyektLtxTtdRs9HqEGuxdDMxhpUyXtSIIzKriSEOeO89PBUWU2JqyNaOnic8EBiD3YYdexi5lyv8JPUyjbbS8xZkngLfQl/QsEvKy0bCB7Pi1stSmzC6P1+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267279; c=relaxed/simple;
	bh=IS8DAlOEJFv4Hc73lac8CfR9FTMg/4GqAwhA51yn8io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXVANCPO3xj+YhzzdFGNYY/foTUamv63nXQCdLYWqznbREJVX7a0+wVuQ9pAWU9GAMdmuC8sJfSnRUR5pkji3HXhAOyLfV3OOKYtDTuQuutpYf2JnP2j13Ns4WwinifHVBxnHhpptFCi2qtAvL6I1XQYK/QL3FLODxoi6GtqY30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AGj9DA8L; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AGj9DA8L"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-516d0db9372so7172121cf.2
        for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 05:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781267277; x=1781872077; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VdranlMERpVyxL3pgmyUxuYmzkqsJ8Ni+fhxhylfka0=;
        b=AGj9DA8Lg/Z3rYzf4Jy+6CQGvjfeNv0erwazMIdxKViJU7BqiDa35+y+sh8LgI7DSm
         HoOoifd355YFoazuP1pmAjgntYWxaBjqdUrGIERkrLDkofZ1kd0Np9g83fAmgATahr5B
         1D0ktTaKbJ4hvCwSWXbQzV1a6Vv6y4BqrUGoh1xwIkhuXE2kSd3LGdlcZwrwxD+lXU35
         dQ1OQr5IUKQCrEcbB8iPbivA/fcs0RH6KqeBspgrlSL00vxzYlVLLKPltj1r0tMhccj+
         n/mIdYbfzESUfI+LblhiMj6vYkR+tFioAhtS93B6J7tD4cjksAHN8yj/2oqmHJF3p7mF
         cI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781267277; x=1781872077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdranlMERpVyxL3pgmyUxuYmzkqsJ8Ni+fhxhylfka0=;
        b=ANUFYXYCWiTmKbic5UE2nA7FohRBG5ZSMnIQ/rIR96iSEdtMOBK9PWX3HpELVDsftQ
         RomoJXS6sLF4SCKpAHAH4nbRdHwqAXmQKmJeUkT72fiqCyZoxcEFozKjuudvNDAng1KY
         LksjUftTqvZZQNmWiVRclWKWoXG6JseRWGP05D8DN0glPbEV3K2CilzCvWETJ/MeaRkJ
         oiBZ/7eEDbw4uGimeoJNtemFvqhugNbrkl5SbgtYuz3jAiilBHN0h+W5vCU8qvWIibes
         ervpvrnK9XCcU1GiyB2Ti92owVJjuEVaOHAMkTJPky1W3UpagpoFYkOWVnUO1QWN1IB9
         tNrw==
X-Forwarded-Encrypted: i=1; AFNElJ86ii6WXW/N1jFwNcnPcaOFfKp440u5Zs9MVuMgH98vfivdQoSMq8PfVMGSma7cyPMgQErHww==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeWlC2Lhwxzs8O1f4cWAuexyfjF3vJAkS4ZnllkjgO1ForteWT
	SbqZdOoPpJvNDsxc8t9lj91iOAj6QIQHtQULFBGu8VJ1jWtThfzS/tB/ZTAW4O4SgPYDe4tbrUs
	PpS6T
X-Gm-Gg: Acq92OEPP8MNjCoE//jQQ1ttstagpuxNpf7R7t2P7Aab+ekLuHFwqnK466KVVkKpy4L
	/jQbj7qQvp4xpE+OfpZholycnyV6jPrxWIIi502fAsHWIlbJUvhDDdNwcA+5QfxWWy3VrelIw4l
	2mrETzfTDJFa9OJ850sYbqGTYgvvWIBov3QZSABOscOHDZzh7Q5NkywDA/gT9blwk49oBwod6LW
	SF6CXJvhdQ1dzhiVTr8M81ywb57AmAJEdIahJSsMvQuezrjGRFz4FxCTmxG1d0wOEotzwNnXL9h
	Cpuuu/O48m5E8WG/52VL8UsRK3ne2tXQC59OrbQffU4LhEPLEGQIwWfXBAvTwKPMEv9ROA3dZTq
	jOgPr8rf0uXRy/y4yRg5R68BNiFbexlgynXEsvdH2oDJvh91RQ0Y5KW6RSyPOGm5SDMerC5Orjj
	lnJdszhnhfwHnrxs2pmD4KOWHiujcjZL6p74uztv0c+D7ACMHGH13fTimBoVD4Xg1ola2Nt+H3r
	eSfqQ==
X-Received: by 2002:a05:622a:a593:b0:517:8446:3afc with SMTP id d75a77b69052e-517fe51981dmr31628091cf.14.1781267277432;
        Fri, 12 Jun 2026 05:27:57 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb815976sm19531891cf.25.2026.06.12.05.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 05:27:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wY0zL-00000007hcq-3XHz;
	Fri, 12 Jun 2026 09:27:55 -0300
Date: Fri, 12 Jun 2026 09:27:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Cc: "Srivastava, Dheeraj Kumar" <dhsrivas@amd.com>, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, patches@lists.linux.dev
Subject: Re: [PATCH 0/5] Improve the invalidation path in AMD
Message-ID: <20260612122755.GI1066031@ziepe.ca>
References: <0-v1-a7b77c25974e+115bf-iommupt_inv_amd_jgg@nvidia.com>
 <83b8a0f3-2409-464d-a9e4-59b9eea926cd@amd.com>
 <20260611115611.GE1066031@ziepe.ca>
 <airU7xpucwkZMAo7@8bytes.org>
 <20260611163317.GA1453429@ziepe.ca>
 <aiu0kMeaSNIUKwJH@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiu0kMeaSNIUKwJH@8bytes.org>

On Fri, Jun 12, 2026 at 09:48:38AM +0200, Joerg Roedel wrote:
> On Thu, Jun 11, 2026 at 01:33:17PM -0300, Jason Gunthorpe wrote:
> > I understood he delegated this to Dheerja and this email from him is
> > confirming the regression tests?
> > 
> > https://lore.kernel.org/all/83b8a0f3-2409-464d-a9e4-59b9eea926cd@amd.com/
> > 
> > Vasant reviewed it here:
> > 
> > https://lore.kernel.org/all/4cc8368d-3972-47c6-bd60-7fc8b9c7be3e@amd.com/
> 
> Alright, I applied it, but there were some conflicts due to
> 
> 	69fe699afe1a iommu/amd: Don't split flush for amd_iommu_domain_flush_all()
> 
> in the amd/amd-vi branch. I think I resolved them, but can you please
> double-check once the tree is pushed?

It looks right to me thanks

Jason
