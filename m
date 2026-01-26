Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB07A2571A0
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769461273; cv=none; b=qWUPSlNi+nH1tpIQ4KhfTbtzwlbjLk3IVZnBvyC+F4RepTdNRmtgbnWDM3x2j1NGuKGh4+kzCOxTSEqaxeJ5oeCbJ5ammNpKmnpCrvQb0fq0+269u7VNumIaxx78HfFqotBbMxEbl6IOEaVKrkD2H+90qWx+YeOrLy9xYurxvlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769461273; c=relaxed/simple;
	bh=/uBBJ41PsJ+poHfkbr45RI19WGdtV1Pwu8dAjRjrE+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPn2q2yFXD2urHYCmKUOaQFrf1Wzuz8RGUhoSGA5hqXk7lOvFFaWnJlN2pxOV3L9rEDJqeoTYt4LZDvj2q1A3N41/tvKkrMFH1bd2zoneiGkbGHecnpSEqMCUMv7xGHfDccNow/TGHZNToA71B9f9vIk6C91v9r7Jfb4WZeHLxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=koC1Q+iD; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="koC1Q+iD"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89461ccc46eso89763036d6.2
        for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 13:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769461270; x=1770066070; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tu3uAyHuSXXXZq6VSWtVG72sHh/RWKg7/MHSYDvcONg=;
        b=koC1Q+iDSahvWalXWFQLqhD1axRaLPr54xKPCYIW6In+rWyfE+fmE4zDEmWU6SLpGB
         BTQgqfTAQqhqqsG3RP/V9Bky9yMXYew8pqyPUEGwVdGAj9r6BJr3v0t3J7j9UOc2+gP6
         hU88ZX+aWt4ixBDx283qV0ApdkCzihfQasRec2v1GuLcA7pb/aeCrmyIK4ax9NGgw3eG
         2wa1rB9NjS15udWFWQXwfGWfpr7q1a3vOHHUQdfoDZdJ/s1haOFXuejy3FL3NWr56x3r
         NOo4Yyg1TvgKwdrWN2YFU95Aw11BOR4DPkuMODJHsvAVhforRRtVgwEZvpXhtX69Whbf
         waOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769461270; x=1770066070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tu3uAyHuSXXXZq6VSWtVG72sHh/RWKg7/MHSYDvcONg=;
        b=kwNkZa+I63Iaa7ZRuaWgxrGyGWqOyBYTbm1OpMbenYIJD+kPocsfogmA6WLZSO13+W
         cX7b1aEUjo7lCrLjh5NUpl9sdku8f8HwUGC7IrUNN7/nX0h4xybYjLb7Gd4rfY8h/0RE
         aqhhrSQmturdEz5A+xF5lw+HhqT8P9it142CgEVcsa1mWL9EQ4kn9GLg1hv35munlbFR
         hNhlqcXH/OydKCdTDb+R1MoeGDV5kdLp+zb+LFdLchDaz6KEgJcbUtEOIh+7W7ARSWkF
         vp25gS2miIRtmZ5TKG/OGdMgXxQeFP/11R7fwoHOTSgajrm6Ytk0n68ugTi83Xyub9aq
         /MmA==
X-Forwarded-Encrypted: i=1; AJvYcCU1XQdTJ8dqlvrkswRkTouuDJYfKIgVtteucizGyaVXC/6/ZoMU3gumv0RvuGFd0E5dssIIQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwR0199Tf1IoGtbDkAeYWPjLMLXyGjTPWP/G6belnAPd0gdVl1m
	puBoodeW3AdkDW6SkFYUlacFjdOT7X7zhdqaAM/R4p9Xw2KFlsDFbrW6GlDfzUqb5L0=
X-Gm-Gg: AZuq6aIXLjz4kg8aXcHoRadeu1ZgWjiJ4G4zOnuO2fuRZTMB4tyF6OmqMwwXNg1HluH
	SsBm4QQAsFIfVOXimwTFHMK0OsGEkVwmEPeJgBUy0Dff2cMeXSaKYs7Va/Stjg03Hgz3zqECW7S
	f8NXmHKBFOa+Ugsnr3KXnT5E1D5aE5E+yiWAgsLIsfGmeeulhx/D3XJTDINTLGSzMWroM5EbEyr
	aGizULN0wvXAhUTq3BbEeQ/m4hlvsGGBp1u29mYqFCeYA6rUhg+BdACiASyENOg0hs3lUBvVBWE
	2Jh/HVqa3WrqiRsV6gKe8cV/28bhiB/mHgNfPq4X5fYzojuEqLCw0YsNHC7Mr8kVqITXg8jB5sv
	UQ8eOMZ1wLe/q95hwiFAalGo7lfHyglvFMPz5UGLfd5Mb8yflAqIbyZwGeDefWkG6ah1B0BFk2Y
	QU7z2Vwk3hOMOBVy6V1MOtRW8Cfoiw+yzNsHCRQpcZgclQYTEMN/b1nk40eGBnk8wvvpA=
X-Received: by 2002:a05:6214:1cc9:b0:894:7b34:dacd with SMTP id 6a1803df08f44-894b06f336dmr73487126d6.31.1769461270245;
        Mon, 26 Jan 2026 13:01:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894918b1436sm104983856d6.35.2026.01.26.13.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 13:01:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vkThs-00000008z30-31vX;
	Mon, 26 Jan 2026 17:01:08 -0400
Date: Mon, 26 Jan 2026 17:01:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v5 6/8] dma-buf: Add dma_buf_attach_revocable()
Message-ID: <20260126210108.GD1641016@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-6-f98fca917e96@nvidia.com>
 <aXfQ1LFNDUrfeuHf@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXfQ1LFNDUrfeuHf@google.com>

On Mon, Jan 26, 2026 at 08:38:44PM +0000, Pranjal Shrivastava wrote:
> I noticed that Patch 5 removes the invalidate_mappings stub from 
> umem_dmabuf.c, effectively making the callback NULL for an RDMA 
> importer. Consequently, dma_buf_attach_revocable() (introduced here)
> will return false for these importers.

Yes, that is the intention.

> Since the cover letter mentions that VFIO will use
> dma_buf_attach_revocable() to prevent unbounded waits, this appears to
> effectively block paths like the VFIO-export -> RDMA-import path..

It remains usable with the ODP path and people are using that right
now.

> Given that RDMA is a significant consumer of dma-bufs, are there plans
> to implement proper revocation support in the IB/RDMA core (umem_dmabuf)? 

This depends on each HW, they need a way to implement the revoke
semantic. I can't guess what is possible, but I would hope that most
HW could at least do a revoke on a real MR.

Eg a MR rereg operation to a kernel owned empty PD is an effective
"revoke", and MR rereg is at least defined by standards so HW should
implement it.
 
> It would be good to know if there's a plan for bringing such importers
> into compliance with the new revocation semantics so they can interop
> with VFIO OR are we completely ruling out users like RDMA / IB importing
> any DMABUFs exported by VFIO?

It will be driver dependent, there is no one shot update here.

Jason
