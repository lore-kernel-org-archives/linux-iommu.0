Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DC75372F3
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179119; cv=none; b=KNX9XTtHisc1EJzOaeuY26DC2euFhW+vlz5fkgCkMGSCK7/yx7dP7b2GWVt37ZofAaxL/7YugupsAtF6g9C2sfGgzT1y+A+CS7j3t9LgYJY/HzE7rq+51VaPQhZd1xFN4FVLLDqeoHteKQ3v38pydxmTD397x+T/sJFgcsL1mwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179119; c=relaxed/simple;
	bh=0PfK8JMSkVzFLf8e2q/WRG4SF7QVJLAT8oXdBZ/vtT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhnUm6ILKbvD2Vb2yVg3vSkPd6pdHIBpTOLv/73wWHummXJ8VLJl9cfIbT+Z5VwXmQ2HB7PP/dYb55/rqt6SnNxB6kmkA4i6NUTLtDaXUSBJhZkdJ6dgaMHWnro0jpDN0MgdTR/8OzWMwQd9zCflNf1cct33O2dO2arJJs7zH0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dND7mHFd; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dND7mHFd"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43f9b120so16008057b3.3
        for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790179116; x=1790783916; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W3dgsIcDJ8p5ZJDPUatobQL/ESNNZ/DHoKBc/ZFp4ms=;
        b=dND7mHFdq3D8KiP1XoD3DSdH7auqS79uZwBJU2+IqkXbBFPwJ/vLx/9wrMH/RKBh99
         wF1P8wefXqH8hH9FL/FnCHd1T4X4ZaL6lSHzRpHiS3oc1qm2vwLZrA2rytLeGMg1syzR
         kUOkj2gJ+Qte+IQiRYObkPtKK+OHQ7EwQUzOX95J7476Mu10Luunu01cUE8Z2sCpuynm
         nzMOPmhURk95Tj21RnY34ggy1FtpEHnW4+EpEj/IjXttrqHbqK6nwZ8UXqv5AFeZutF8
         1QxjsljcPgyIkZkY5Z1HQapvO0oAaiMWokOtyJ40MvtIDixiLbJiVsUb+058lRAc528k
         b2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790179116; x=1790783916;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3dgsIcDJ8p5ZJDPUatobQL/ESNNZ/DHoKBc/ZFp4ms=;
        b=aBwduoUC/3JjVlNafeOOzQEI6hRNLniDbaiEkXhuVMijA6qsHhhSmdXWLZb18zjoRy
         TSsHYYSmpCUbl/CAmgkTjQp6rfTX0Wi/z0x5AXMjn8Q3RYPjSPI79IVWB33CvoUs1xG0
         jEXJb/NJ5KBbXeOURj3XDe8BhPLklRgddYW+SBX3OtjywuxRwWqDHvkybSQWE7V2VElw
         jCTyKHoj3CeI8gpDhAFJ320uS09MmdvvqTNpkO/JzxNQHqbgF8F6vWp5r1coHaPQcZ/Y
         rvzJn2VM5B8g8GxWNUdEYOPpv+nxNxIjxVfwYLeykE/yZT7foyJf7Sf/OKcGpc3C+cqn
         QTRw==
X-Forwarded-Encrypted: i=1; AKwUvBwRCIPjv7DJsDjF47FsGzRPLw50wNeKwulOGbEEjXe9a0Ke57nDPZZBB2D7xBYn1iMxpeGYCw==@lists.linux.dev
X-Gm-Message-State: AFuF++kNz8VZ+chXMV2cuW2d7SzyaZMmqS7J+5JUG+jjhnhIFF9JAeOp
	nWE/+S9d2Taxtm/vbiOmxhNiOPEffZFuaDIHtL22y6CAA2Yo8oJguk9Qjk/ZiWcKRFE=
X-Gm-Gg: AYBFou1w2trM1h5yLh/ESQunRvTiqWy9eTaVM9XcW7vlVWOPFWIfB+dgeGhHy28pmKV
	24JlgO3BBPrx6xSgxuNwf+hVGMrE7pbpAHZIII93ugH2lxMsv4cACwSb28NbU7Zv02G3LuUoI+2
	DcLEXdalS9a6lFN7acwQfqJ3G4wwQJed2efBo0rbJksqH3qxrX2GvgiBgDJ9d3f5Mz7aCqaCXbG
	7byeXEQqQmMbyRg5A/nlm3zmy9dcq9f8gE28jDF6L4o1+XfyQaEzEbmY1xIZNXPAjFHwhFwLKzz
	yH2taZLGIUgeqjHt0qLwK9xu+DRIg1sVkG7zjWCFlHQ3kN55cctCq7bIln3SElT9QLBIWmcHkL+
	afV+tPz09BiE83Tl/Obnc3FsHwCzlZbj33q2ZpVd8ukcOuuxayGZL35XzUG7lkRvBeoSwJ7Y1GN
	FdN9WwiZhFINGt5JOJ937eSEQykCspJulL+SwN9Ql5rXe9
X-Received: by 2002:a05:690c:f07:b0:89a:63da:fa90 with SMTP id 00721157ae682-8a45bb7ceb7mr18084857b3.75.1790179116666;
        Wed, 23 Sep 2026 08:58:36 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a4658c72f3sm11900977b3.17.2026.09.23.08.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 08:58:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x9PMg-0000000DwaY-36Ny;
	Wed, 23 Sep 2026 12:58:34 -0300
Date: Wed, 23 Sep 2026 12:58:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v6 0/9] coco: guest: Enforce host page-size alignment for
 shared buffers
Message-ID: <20260923155834.GK1540250@ziepe.ca>
References: <20260904103452.1197239-1-aneesh.kumar@kernel.org>
 <aq1sT2EDsGaomqST@arm.com>
 <20260918165754.GG11599@ziepe.ca>
 <yq5ao6do36jk.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5ao6do36jk.fsf@kernel.org>

On Wed, Sep 23, 2026 at 10:31:19AM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Fri, Sep 18, 2026 at 05:52:31PM +0100, Catalin Marinas wrote:
> >
> >> TBH, I'm tempted not to support this configuration at all, just fail
> >> gracefully if the realm page size doesn't match the host's. However, if
> >> that's a real world configuration, 
> >
> > realm != host is going to be fairly common.
> >
> > host > realm is probably not that common, I would guess.
> 
> Wouldn't it be more common to run a distro with a 4K page size as the
> guest on a custom hypervisor with a 4K or larger page size?

Maybe someday, but right now I think the 4k hyp is going to be common
and people who really reach for 16/64k are going to need to run !4k
guests too.

Jason
