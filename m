Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0113F7888
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779798420; cv=none; b=PKtNkU64mPXItidLNie7rcxWpwvevKwHU6jEvXYtjoFbWwWHbTOfOO4inltf24b4scCGpss7MVivI5OuslPfQsRjgy2ynLF83HEWOg22T9AtyTdlsykmR2hRkGx1c73ZZJGIB1uAoqVopCZJecwZ2+nW/Pmg/Ja7spkeAFrH9rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779798420; c=relaxed/simple;
	bh=ehL5g3u352wzk/u26D6x4hHM2Xz657v/SQyqW4yRuEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVXKMSN/d8Hh72bkzKqDv6Buh3LwCT2jToMacwtGfAOLNUfqkFKw56k1OMzRChofnVfZLX7Nep81aa93uUbMHEmIr9+FG3w4qzxIOYnvurPbrHl1jciGLlXjSdq2nha1WoKBKOhlzYEHEIUjt4+6BE9V1tw1303nTLJPp74bznc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mM5L6bjf; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mM5L6bjf"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51306c36c3eso116649111cf.0
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 05:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779798418; x=1780403218; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QQVPF5z8tEWy9hSyAGSwHCVBtb21IOuG2HFA7xrSBPI=;
        b=mM5L6bjfGAk2VBpSJirPauCqGGDOXjImSoOyMtDM25ZNT3wNvhspcOUHe6lBVVwCi4
         cacKEMN+FYrgAUgoCWpHamXxTA9ByoYNJ2UN0ebsyvu8sqC7Z7FfFFnQXDKhg33EDO/e
         4ahrpSHO8G/U4Y77L0xrN6y00Xt1ixc2R4Dw0lTP4+XlxwevHUptrUPBEwMFYQshNT8w
         Sm8/Tk0Q+D6QEMwzRO2HUlv6iE60bwjPlQZcWQg1O8J/el8GP9nAst95ew4aDhd+Gceb
         j0gZgAy9TsW1D2KEb9b03/u0FIzdyTANmIUg0KBi7dkI8qdf7Zt/JXebekGFElxR/+TP
         fLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779798418; x=1780403218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQVPF5z8tEWy9hSyAGSwHCVBtb21IOuG2HFA7xrSBPI=;
        b=bxRIU7r0TwsZgUl+1tsqP80fX7HUnDDI2fVckKmjrd1F/z61J3CEfVBdzOidGhrYv+
         WtNLoNe4VLhdlXYIdRh7oRg/C+/Yhq0RVbNvxnqbyENgVdBa8MRGrI+xfDbXjEr3oQ/H
         fgfGQI0W1oc7pAfi2H2qYe2rsJuoz9KGbYk0uq8Izg2DcBxzJtk2z1c570tOhcXFJ5KR
         7gwRbKl5+i8vb1/tUdz/vlQP+BhTLsxjvB85Ytwh3UCdvT3ZIG4Sv44kvmid1vXGA5ay
         EYfbzFsocDwYWcp3nGSoUlnU8E01b8QA2Go+h8iJd2QPsAE4iBzSKCgRIIUVS3Pmnm1l
         PHnw==
X-Forwarded-Encrypted: i=1; AFNElJ/TKN0fLEwfOjg+d8IfXpuHNvLhfFOhi02D6wto1KqjuwxNxYzVZFDeOI3OZi2HTXnE2ljWWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTBxS7ntQYSJPzBY0tRA+YsGCFFDfGJw5rfwr/AMVvUKzweYdy
	aa9CSKs6Bq+VGRUDxHi8xvySokGi+jiGyUVz1OVzHYMqdUK3drp5pkn7QYsOxT70nvQ=
X-Gm-Gg: Acq92OEYl/25+Y2l278kWDv2Ia++wXHPcQ3ITGptELildiIQEHvLqbXCZ2yxzgF2lRO
	CAbvE0oSL/N6hekbIKNyQfVqJuHQ+4Vwr3tTlCFNPIIzEvruP60iMlRTQcpnqeJZgrttJ43OqKX
	q+im6byNQhPPHqB18lni6n3vez+073eArJnCL2vWHu0jUfJ1XKPz7ZI7wYyFLQRCbaueGbbC2Tz
	QxczLyepdC4MndTI0qT3A1A30LRRB8oUh+wrAP+3Xa3a+oUFTput/NtbtLltB3XZab0UNA/oy6t
	Z/7jKAoY/4iy5qcS8yakQ23VlXuzpPxBYp0Up6BiLA8lZov7mk5Kyrtmfyk/MS0Lr8T9eLEZLSl
	y1kcx+i34EJ2s/VWLr1kPQkOpkN1pi1M5CPzA/FGGTh4mNxxC9eCzYDV47u+zudtc6rhbjQQk5+
	8Jd0bx2K90CtgczFrSORMwOHotIb6CPQig5aJ5CTr85Uh9bJhq002mw/OCDcBHgm13+/TO1gUsS
	xPVBJb8BH0BjCkR
X-Received: by 2002:a05:620a:29d5:b0:914:c7b6:e29c with SMTP id af79cd13be357-914c7b6e6a4mr1836526485a.56.1779798418003;
        Tue, 26 May 2026 05:26:58 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f8801390sm215458285a.36.2026.05.26.05.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 05:26:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wRqs4-0000000DONN-3pnp;
	Tue, 26 May 2026 09:26:56 -0300
Date: Tue, 26 May 2026 09:26:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Leon Romanovsky <leon@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd: take dma_resv lock before dma_buf_unpin() in
 release path
Message-ID: <20260526122656.GE2487554@ziepe.ca>
References: <20260526111034.4079-1-Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526111034.4079-1-Ankit.Soni@amd.com>

On Tue, May 26, 2026 at 11:10:34AM +0000, Ankit Soni wrote:
> dma_buf_unpin() requires the caller to hold the exporter's dma_resv
> lock:
> 
>   void dma_buf_unpin(struct dma_buf_attachment *attach)
>   {
>           ...
>           dma_resv_assert_held(dmabuf->resv);
>           ...
>   }
> 
> iopt_release_pages() calls dma_buf_unpin() without taking that lock,
> so every iommufd_ioas_destroy()/iommufd_ioas_unmap() that releases
> the last reference on a DMABUF-backed iopt_pages triggers a WARN.
> This was hit while running tools/testing/selftests/iommu/iommufd:

Any idea why this is comming up now? Did I run the tests without some
kind of debug option to turn on that assertion maybe?

Jason
