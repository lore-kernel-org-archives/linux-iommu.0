Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2463DA7EE
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799147; cv=none; b=LIvB/EqbLXtjBt6WPv7r4tibxDyCFfEEB6TLeL98cOI0qSN8zITcDHPmYQdEleF+NpGjcAu7jbvE+nPFdHlFKBfA1nJhkQwyFDZeS1xw61Nx45k4qZFwC5Jj8Ub/EEiA/QvtVsIoD4dqg7UqCUajoXw8DCySqw1HbcYT7yB8AEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799147; c=relaxed/simple;
	bh=gR461qSVi+sCLs2bLEZQZYpjTssDK+7+J8oi0wKZ0Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ze5q0+AYxuVg2cNaxHBINiu61W9z2PdQOiIadGWZ9llfYn5mJKpN5QFAylHkAnNu8JgqyM8bgZsnS6dKqUqPpzyU+RaRXrwhrUR+SUUo/rLzRi6fsE934iNLTFQwX/UQgqUgzipW/RorCAsfVIajkket7QK7BTrdGyLo7SJT4wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NVFNzf7A; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NVFNzf7A"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8b4000e51fdso119081486d6.1
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 05:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779799145; x=1780403945; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qyrvhlE7ALt0w7ZGlx0St+b9OxdpME7Sw9W+x9BvzqU=;
        b=NVFNzf7ADr5or7CyOux0JFKfrIbVhght0inQzWUPmzfqgcxPXRJe1HDMiWwep1jDgZ
         90kyYXTO/Nryf2H+gVZIPyDBAu+AEtK2kbT8l3DKHHKkA0kf6yF0usCLwz+FtOUevJFV
         nCJBUYqqqK8VM6U1d0g0U7+u87GHUxre0O3jL1MObpd9wZzI9i1X46eWRFid5KvgrJ4W
         ofd44gckMwzf68j3ANXZy6qZcxTRbFk4TSltcgb5WMGBaEQ3mM+PJ3XF7jq7GmPbc+QJ
         krlq9bbeiZ+A3Ktt+SbxRwyPIWS4Vp6onJEPqf+ScX8uoAy71eu/3LJPw9pogIddVAo4
         oCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779799145; x=1780403945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyrvhlE7ALt0w7ZGlx0St+b9OxdpME7Sw9W+x9BvzqU=;
        b=Kuz8eP6igdunap9opx7TamAcrwoBP1CkLyHgA3wLQDrml05iBD7+VT29FAc98V51Xo
         0YC5XgqI/6ReVIT6jX4ASUDLiEGmtJ/PFjBjDeCsCtcwycGWrAjOsE7OX3e4PVKotj9q
         ebCac46n8rBpYWsaSitmrLTxtlJ6KQaCUh7QGYk6UM5X5oJzKx1U/tSmIYGGNztACmCw
         s+r96suXWciP9S99dez2d+L7krbcxRt+Kk+CgDS0fcH/h7rbIsMXmWLREmoyx5Sso4ae
         Jtt3MfuXQoUm196KlZbAM+i+Hte2AHayEuZOldhMV5RX4yraHEKRWDz5bSG30zmjbkrT
         d1HQ==
X-Forwarded-Encrypted: i=1; AFNElJ//sGIS/3lEYcxba3nfFW+Qrzo701Wh26vbGZzOgo0QJXAnQWM7b4vmEkeVxHLLQYkHYoA8OA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4MQtRp2w+qfR00Gqtqq8PNpxAsy0TBp9jwZSREoHpKOC+kkZj
	ueGnYgkKipfzFtu4wEsP2ljga8yJQENwWMRoNWK6Mp5DvK7OkbTOlxVwla4QttnKtrw=
X-Gm-Gg: Acq92OGmpbJK5r82LG+xhIoCqoXCoTCheDk/evHj89ZoTJ15GbT3h4Zvx3yZfOhbeLU
	uX/+QyA5JtxJks3geaolDdv45msRZIIqD5VfANUFT37WSmsIwflMhSQ/HJmEDoV+rSVbi1iwH6q
	e+PTOGZtbDcgudNoxS4jkard/8hK1CFst/VtQFCGnbt3jAAAjoUf/khtT8xilENrD7mopJyh6oR
	i0gNa7NY98IjwOE1xrI59ieAH3OE1DCZGwt11UuOTo1XrJj1j7ZoRzyYy68lMemk3xg85TUJ+3p
	leZBXul02NmmNalhJXjWZmIux/5VXfWk3udepl3lYixAMVHtkB9/33WRtlIV6A+eBBH5siFeoD8
	2pLZUcdkMJF0GQogVR6GI93DXrcsrmgBPNXWs7eoYyX836F9wX8LmnSlMoCPf9TE++ztZ1PcZEz
	bzIPnDBVkR0cCTAwrbR4TVQWjfoRCYuqbjs+/AzOy5JTlIniyKhcOmfv6Ubs2ZPU/LgWSXhz0mO
	wb/8w==
X-Received: by 2002:a05:6214:262e:b0:8ca:ee3:6e99 with SMTP id 6a1803df08f44-8cc7b6a504amr305513016d6.44.1779799144630;
        Tue, 26 May 2026 05:39:04 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8130a1a3sm139020606d6.37.2026.05.26.05.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 05:39:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wRr3n-0000000DPQA-2CBd;
	Tue, 26 May 2026 09:39:03 -0300
Date: Tue, 26 May 2026 09:39:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joonwon Kang <joonwonkang@google.com>
Cc: kevin.tian@intel.com, Alexander.Grest@microsoft.com,
	alexander.shishkin@linux.intel.com, amhetre@nvidia.com,
	baolu.lu@linux.intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
	easwar.hariharan@linux.microsoft.com, hpa@zytor.com,
	iommu@lists.linux.dev, jacob.jun.pan@linux.intel.com,
	joro@8bytes.org, jpb@kernel.org, kas@kernel.org, kees@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	mingo@redhat.com, nicolinc@nvidia.com, peterz@infradead.org,
	praan@google.com, robin.murphy@arm.com, ryasuoka@redhat.com,
	smostafa@google.com, sohil.mehta@intel.com, tglx@kernel.org,
	will@kernel.org, x86@kernel.org, xin@zytor.com
Subject: Re: [PATCH v2] iommu: Allow device driver to use its own PASID space
 for SVA
Message-ID: <20260526123903.GF2487554@ziepe.ca>
References: <DM6PR11MB3690699A3178F1559D4BE1CA8C0B2@DM6PR11MB3690.namprd11.prod.outlook.com>
 <20260526123606.2488278-1-joonwonkang@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526123606.2488278-1-joonwonkang@google.com>

On Tue, May 26, 2026 at 12:36:06PM +0000, Joonwon Kang wrote:
> > > From: Joonwon Kang <joonwonkang@google.com>
> > > Sent: Tuesday, May 26, 2026 2:58 PM
> > > 
> > > > On Mon, May 25, 2026 at 03:29:24PM +0000, Joonwon Kang wrote:
> > > >
> > > > > Currently, the only known expected user of the new kAPI is our team.
> > > Since
> > > > > I test if the patch resolves our problem before sending it, I believe it
> > > > > should be good enough. Do you mean more than our team by
> > > "accompanied
> > > > > users"?
> > > >
> > > > He means you cannot send patches like this that only serve OOT drivers
> > > > to the mainline kernel.
> > > 
> > > Hmm, it gets back to the chicken-and-egg problem. So, do you recommend
> > > deferring the patch submission until we find a new in-tree user of the
> > > new kAPI? I believe we will not make our module in-tree anytime soon.
> > > Or, is it like I still can send the patch and get it reviewed although we
> > > cannot merge it to the mainline?
> > > 
> > 
> > It's not chicken-and-egg problem. Just always send them together.
> > 
> > so let's wait until your module is ready for in-tree review...
> 
> Since adding a new kAPI has this limitation, what do you think about the
> idea of adding a new boot parameter to enforce disabling ENQCMD at EL0 and
> using the non-global PASID space in that case? This way, I guess we could
> resolve our issue without having to wait until we have new in-tree users.
> Do you think it should have the same limitation?

No, you can't hack up the kernel for OOT drivers.

Jason
