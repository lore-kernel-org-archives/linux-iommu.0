Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFBB4B0CA3
	for <iommu@lists.linux.dev>; Thu,  3 Sep 2026 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443404; cv=none; b=ViM5GJVF9xTKA6T/Xw4KiZLu/uOoT7Y83q9EWwyWqGvNOZA+7Ljt/Cp6YryoF/GKkBp7oRuOmaML/N0cCHB8liuGrTBw6vdFDEx9Rl7jf+JCqswbJymFDCrbAzOaJi2bVg19eontKOlb2QpF1jUemzv4nSOreGLp0FESnJn8B2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443404; c=relaxed/simple;
	bh=tSyD1Hrg7szl6jqzgDqZId8g0ww2LMpu6Dfemvgzz8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/05ZpyD4+GTjA64f5DKRMN0o9AEPoIxg2taVdNOry5VbK8gXoftlDDYEYzx5fUue9viyH9q8KzAiw1klZ8iRMl8eK4gFKkAThPjPtVfTxbGt7wiJOEyIK3HO3j5yyUadQ/SgSlCOI2ndyVQAGq/JXncG6S9kow0jcA1TJ2RQ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DhLqoXck; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DhLqoXck"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93959320373so194469985a.1
        for <iommu@lists.linux.dev>; Thu, 03 Sep 2026 06:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1788443381; x=1789048181; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W0FzzBf86DLShcrb30vlY9xIuH5mW18Cg/ZW31lMTS4=;
        b=DhLqoXck6ZCSfTJD9ErC+GpXbBS5MCxrYtwnYNIeH7ZdaLumgFxZnlIxewSlonBZWC
         9h8H0PwiWHQ59R37f11bIlvowgH9txW2WV7pDWuAdl2vw3OPFPdCw2yerJS1e9zXNpI3
         8SS/f39hMiRFONMoBiMSFrLOUklQUwSzKs3Jh9dmujgAY0sW0oH5SQI2lVc8NIC5IC+Y
         7jj72phrtXcIng3xheDnDxbe/ztyOeECBEbdIZnobdMFsdvoIkzs0wJH659msCJ9G9Dx
         k5WE5F1J25iSGWZf48ywyoWSFMaejNMQnXxGIx8L/p+qIGB+AfRmG+XPYjMUIbKhkttV
         5D2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788443381; x=1789048181;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W0FzzBf86DLShcrb30vlY9xIuH5mW18Cg/ZW31lMTS4=;
        b=gTKsPvurskHybcOePzAy3gtf5Ylftf8MIWOYkGR+Ds7azsGroWGMyNDiXkhASsOZt3
         uPe0sDiKtudWYl0gjHCkhHv4WrwXiKZvCDOeiQo4IfvxIyon4I9njPS1jHV8mNeDzFB6
         Aq4mEuBYEuoJYlFWJWRIxL97rXpiYPFgy7FJ+YQjf9sm6ETnlb+L0mREZsXXrMJuHRCA
         03597NaYXjjnGb524aG2oXcAAB6NKFnUoVqRF3vDeFwWYbU4wuciaOFCwj04ZZwZYNhQ
         Vz+jTmMJ8AFch8Ang4dyQ99ukbaam4YOKF+KCW3GlQKOAbCcYCpojF8RS1Lq0DvYkhzz
         ygDw==
X-Forwarded-Encrypted: i=1; AKwUvBzYjP8CdW8a1GZTXRPr6rEWT5TiA+IrN3oUwyWnF8DlL2HVD4403rstMPRezVqhTUejkdOMnw==@lists.linux.dev
X-Gm-Message-State: AFuF++kMSX+0ec/krE6zru6anHjod/8xNxp9fOvIP/UxNcJfzJ3IfDsJ
	6GD8WTTkJLNvlNKLdNKdLiBNT3Oy+zS1A6FruZDEbddpA6C+UePakHIwoPHUdNnFucQ=
X-Gm-Gg: AYBFou2UcMEatxYvUFcgW0Q8xb4XYMwx2PI8rvOyOqGaIpujyFFBNwMmPOTrAk8qiV4
	nSzNMxT8624OFm49xDGyvioD/5EsKgUgcLrNtSA0SJfo6YaZHB+6X9DNlstwOqS9ZMH0apiCsIN
	gndoI3h9eQlgkK5u4ddRMtTK4L5l5fgmfLCk3xzGWvpIrUhuYAwWLf7RwhETzjD3e/YG4fTomeb
	EZOIyYqTR3bWckVDYi1h3RPnU5AHjL++XtuTc2euOHlfqLy2bGgL9fIazWcUAqms1JJYWJfLGDG
	1P3+DI8yAHYJ0zeuGI0K/ZssJ9l7COA84RdAR/ozUXUM+PO1RXKAjZH1X51/gm682brtusHIkWQ
	rvQmITFVsxaMt/fiHOTsCeyDjEFc5qpvqMh68dOvpdWEyTqB2qDpbV8AOxpef5pLshzDNMJI91N
	cj0BizIXbagb/CQy2DxlwOyUmNZRqSWlbbj07rnmLLYjPPftfKS9WBf43++0QHHt9Tq7LdExv+a
	gkax9oVq9kT/h1svn00OI3JXkB4n5f7ncth0JIhUdEA4A==
X-Received: by 2002:a05:620a:47b6:b0:936:576e:227b with SMTP id af79cd13be357-93960f3c98amr1203618685a.24.1788443380734;
        Thu, 03 Sep 2026 06:49:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f398a18sm497088985a.37.2026.09.03.06.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:49:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x27ow-0000000H8XN-3MX1;
	Thu, 03 Sep 2026 10:49:38 -0300
Date: Thu, 3 Sep 2026 10:49:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Hu <dhu@x6u.co>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, alex@shazbot.org,
	ankita@nvidia.com, chriscli@google.com,
	david.laight.linux@gmail.com, dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev, jmoroni@google.com, kevin.tian@intel.com,
	kpberry@google.com, leon@kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	nicolinc@nvidia.com, praan@google.com, sashiko-bot@kernel.org,
	stable@vger.kernel.org, viursachi@google.com, xuehaohu@google.com,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v8 2/2] dma-buf: Split sgl by largest page-aligned chunk
Message-ID: <20260903134938.GI2890729@ziepe.ca>
References: <20260901170849.4052816-1-dhu@x6u.co>
 <20260901170849.4052816-3-dhu@x6u.co>
 <20260902120832.GB2890729@ziepe.ca>
 <CABdL-LTO5OKkDmtXpiLury=2n6q6Rcm42_qqz8U+JkEu=v886Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdL-LTO5OKkDmtXpiLury=2n6q6Rcm42_qqz8U+JkEu=v886Q@mail.gmail.com>

On Wed, Sep 02, 2026 at 07:07:50PM -0400, David Hu wrote:
> On Wed, Sep 2, 2026 at 8:08 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Sep 01, 2026 at 05:08:49PM +0000, David Hu wrote:
> > > From: David Hu <xuehaohu@google.com>
> > >
> > > Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> > > This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> > > first entry, resulting in non-page-aligned DMA addresses for all
> > > subsequent entries.
> >
> > This patch is fine, but pedenatically a scatterlist's entry limit
> > should be bounded to dma_get_max_seg_size(), though I don't think it
> > helps this. Operating scatterlists at the size limits has proven
> > problematic in a number of places already...
> >
> > > In addition, a non-page-aligned sgl length will trigger an edge case
> > > in `ib_umem_find_best_pgsz()`. In case of a discontinuity in later
> > > buffers, we will have a `va` with lowest bit set to 1. That will lead
> > > to `ib_umem_find_best_pgsz()` always return 0, and break the promise
> > > to find best page size for the mapping on the NIC side.
> >
> > That's an IB side bug, the newer logic that joins adjacent SGLs should
> > have avoided it?
> 
> Hi Jason,
> 
> Thank you for the review. I think you are right on both counts.
> Regarding the IB side, the new SGL joining logic in
> `ib_umem_find_best_pgsz()` indeed avoids the issue. `mask |= va` is
> skipped for artifically split, contiguous SGLs. Since Christian has
> already pulled v8 into drm-misc-next, I won't spin a v9 to avoid
> creating unnecessary noise on the list. If you prefer a followup,
> please let me know.

Nope, I'm fine, it just explains why it wasn't seen in other
tested. You were backporting and mix&matched things. It confirms the
upstream kernel was fine from the start.

There are other importers besides RDMA, so I still think that this is
a good change regardless. Having each segment remain page aligned, and
staying away from ULONG_MAX that might trigger overflows is a friendly
and robust thing to do for less sophisticated importers.

Jason
