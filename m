Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC5E399D0B
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589738; cv=none; b=QaeYA6nqDhZjAehLVkgH2MYE+iU09SBm9t8rT+2lEueZtccdu+KPOyAGGDza3fn5eQWGyW7I+eHurRJN5Ro/UvriTmZQCkCoozqSy7KCvFi99MmwrrPdL+8IBCW9a3zlFztSweB7j3wGv1KLJrxd0efRaS58LLfnzi1k01Hw99A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589738; c=relaxed/simple;
	bh=XacGqqjY7f28dJK0VP+hWV0B7qKiIryK0mnYuhxZT/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9cMAXpiBMXJ8POKz5UrWNiU0fhLAcOTD+x5AI3akTse3raJADiuYchqy2GhncCSvuLNywyZF2q9K6s9r79djofbryzDIJCrqXsWOAN1s1mb6W6WRtIsZEIRV1zoKkPDMX6sYQrEcxNR9nHptvpVs0/RIDaPM68f7BfyqgA9BgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JJX8vZIe; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JJX8vZIe"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-899a5db525cso34031116d6.3
        for <iommu@lists.linux.dev>; Tue, 12 May 2026 05:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778589728; x=1779194528; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3BKLJTgpu0lhPLPV6W4sX1a9F3kFqCKUQrD+DI4v8Lc=;
        b=JJX8vZIetcIDn/oiPCrwpcHxQcvz3Ct6nzRbmjlfSSpreTRHBF3fQ3OH+iE9ofo8fE
         9JTwkuhKgMNKiZOF3jdZ19B7ZkHOoEZMgQAEQXA+BwgekYgd9iqP3dnM4J7WEPVpECuw
         SuLLMdxxhFUTvc81SNHjKT6HNhesa3HlWCPBCp11KbfTntsoqRbZp9pAslQGXUdrvtR7
         hsd3mI+LnxmRCbc9ucwFznzJePBvjDO8HNjvb7OGTVqNpFCWhSP93W3hTKCJYtEwLGL5
         oQ9yzVSnmV2ECwvAe7s7C3NGSB6pBjQuBo/f5lqgiRgim4eH8a1L5jNAghfgXVi0PazB
         vJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778589728; x=1779194528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BKLJTgpu0lhPLPV6W4sX1a9F3kFqCKUQrD+DI4v8Lc=;
        b=X4ULDAW2RrRXGz/+UZuFSrk3CbMBM5ZF7ZFnATmaS7okSDvAqE35AM78P1qRLyNKyu
         ScILNF3eq40E8L/4tEWpn/g5xGVOQcZMX3qOwCquR7qYL65Pn5QLJ3S2jUIgV98N9Zsr
         vfsMTPfy3F5PF3QF+rWUoZCym8OJW+00Mu4gztBCHD8mTrUSOlRQ8FGFotDXCx9no2G4
         l/BgR1hBDfKWeYNjw8emGPuByfcshNzNV4iGrx/YgKCkRoNYf4QpgiugS7l01PwHz6Rq
         1DiV0moUNtQ7ShJi9VouCpgmJ6VIDK1dc/dl+VgBr0YuOqq/nj6hyy9gHgVzlJwpQz2p
         rMZA==
X-Forwarded-Encrypted: i=1; AFNElJ/PsVnOBrdvqQNJCzIKgnBpKCqM0m2UuNpOMXEgSriJ17NFKmsQeYbMiPL/QD/E2ya3JihpEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAbjLqlqzGAkVBlm9RlaHype1xAl7BiLXy8QMX13s3hZcFNLu6
	aNJgSD+mhPF0v/D4KXWqGlW9NlHIesb0sGLISeZjNeM1PNYyIw9zj5LDa+6PkGlCux4=
X-Gm-Gg: Acq92OGCt2aYHYh6goR8NyNDQK9bxiVguGLUs+4t8u7gr7ZdgTIQEE77WxbigLMinZg
	ohx8MZmLhMox5k9erRyU2+CumBD9FLY/acEinH2hStYcTXkK0wRfnojcdZ2kE8HhaxCco73nSfy
	+dRfu1sD/h6uShs4zqHOR8BdC61LnOr/uPzdJCVflYeGxC2aF5noj03BYr3ZfNRSfxtkKye7cx2
	uTR5xYOa3uwfzCUNajZqTNq4XiYdb/Hu1KtoxdwS9FINCv8ZpsDP7aYCH/N4BOdH6SjB/G7SufB
	nsQ91yHyhTsajJo/eMryOcWHnJS/U7K3E1zUyq3dwDhV/kz6M/X+OC1uOvEa7VqiAhyVnFc/lcB
	ey7lq06Ru6co4pvCGvsAqXHu1ajmWKpbzRoiXS1bIed4e83uY/O4Amc7BzECbdLSme4SSg52H51
	eMmIV3Hm6sy4KBX20h+QOnh5o59G3q/15akFXO8DjttUyEJAWFDBJuy+EAR8t0SrLDxoC8u2hGu
	6KwEg==
X-Received: by 2002:a05:6214:5b09:b0:8a2:97cc:af82 with SMTP id 6a1803df08f44-8bc449afde3mr448027066d6.27.1778589727408;
        Tue, 12 May 2026 05:42:07 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d6442d0sm338851976d6.46.2026.05.12.05.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 05:42:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wMmR4-00000005AmI-1e6f;
	Tue, 12 May 2026 09:42:06 -0300
Date: Tue, 12 May 2026 09:42:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 0/9] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <20260512124206.GV9285@ziepe.ca>
References: <20260427055509.898190-1-aneesh.kumar@kernel.org>
 <af4dK-0HEsKdPAvM@arm.com>
 <agG557zSEmAqp1mn@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agG557zSEmAqp1mn@google.com>

On Mon, May 11, 2026 at 11:13:43AM +0000, Mostafa Saleh wrote:
> On Fri, May 08, 2026 at 06:28:11PM +0100, Catalin Marinas wrote:
> > On Mon, Apr 27, 2026 at 11:25:00AM +0530, Aneesh Kumar K.V (Arm) wrote:
> > > This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
> > > dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
> > > are handled consistently.
> > 
> > I think this series makes sense, using DMA_ATTR_CC_SHARED throughout the
> > DMA API, either for alloc or for streaming to decide/check what bouncing
> > does. Sashiko has a few interesting reports, it probably breaks s390 as
> > well (it might be similar to the pKVM case).
> 
> I have this series on my review list, I believe there is an overlap with
> my series, I can rebase mine on top of this if that makes sense, I will
> probably wait for a new version to address the current comments and
> Sashiko notes.

I've been wondering about the two series as well.. I think this is a
big help to your project, but it would be nice to know??

Jason
