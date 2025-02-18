Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A177269B08
	for <iommu@lists.linux.dev>; Tue, 18 Feb 2025 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883973; cv=none; b=YHDOBG5RstKaKqELuNJz7bcOx8bXJ1W7iAAj4Ia77fYXk60IGMTbE7i2voamz8P2e5wEWZZCI2J0Sd8fj+kprJsCoe90SIfT5ll2UKa1aIv7UxNgoPVd++0YZrUEM/bCNdc9ZIGuO914gfPNbSYKjMcunyMy/rImEGV1Xeg4K7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883973; c=relaxed/simple;
	bh=q+HbC06i8CG8XrIehHvRej0xtlb/tpGGxGM1a3va+bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCofK/b6yS6lTjQNgGnLmYStMeTH0AEHKHwc9k3WhWUsSR7TbwY5vN4QsXEabglYDbiZLFT1bXjhJFAgmopz+qaBehyvIRy9S7dzXy23Fy/zu+jkHMGTeAaQ+glKD+lMEvOZnbFPBKUPF+dHsWbZbP21d+epgsLWCOczGq38OwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QQKaDr+E; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QQKaDr+E"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7be6fdeee35so1008900785a.1
        for <iommu@lists.linux.dev>; Tue, 18 Feb 2025 05:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739883970; x=1740488770; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7lyvU9JNedDqTCpzlpsd+T8LpPH2Gmgp9plDnXA9nVc=;
        b=QQKaDr+EFfaYk8i84KscjX9ME72TRqHL98Q27gnF4NabQSvoJsEL4rv5CABNvYR51p
         gLZshSzqOuZ6EZGFIAXDAdraxHTT6PhhAknAzFziVn48nlM3akXvUZJhH8oscpgSY0lj
         tEQZjjShq7TWeF5BjMl4QN5d3oqA69NKZpI3MVkHIHhCxmHqcfY7xA2sOoO0Bi4t0Cmk
         Yx2uNx3p6fYRw7fhGF7OcRxbzABJLgQOZZDPShxQz9iqPN83uhA1tCykRFKZPfvUL7Em
         kZ3tl3MHHd6dFI/TBDedMWQeei/fX02lKzO/g6yMjU0QLcj/VCB4blmj4KdShXHYWGTq
         P3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739883970; x=1740488770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lyvU9JNedDqTCpzlpsd+T8LpPH2Gmgp9plDnXA9nVc=;
        b=j6YC5MNKTJJCH5vTy/xFpju15PpFIp4H8vWR2OrMYP1MxK3+2IFOFAGfJL9AABQkfx
         /37lOYXPHmfIEAijYrS0e8qu/1XJhqbmdaPg/blk+OiG+B7J9tmlnQVXZ4gnZO/VRJZK
         tKNRwYJVsYYVClhlF5ws2JRX8uLLsSDwEnCH6+ucv0WVN0wZr0lu6NcsHUnlyWPOGWny
         /W3NVu7LTuHnDC603cXhN3a2C2tcv8M8+a31PY+s7shn6aY6gt6cXAbITPLRmFOsx+Go
         3IWTRnSeNqLePefLRt1wiZF0DvpRhCJzTH14IiH5ParJLoGhyTPvP3VSOqtvHYWIVgza
         V0KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOw9tShM3vtWsMeyWjxcNOL9ClIxPy1eb6aJYIKMnp5YvMRpkevlfIfvRKbSPVC/CMP/Y4LQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyU3+M5aybIpJF9LUMe7UJCJGILQgvBs5P+vTeh9dsUtjmkKjzF
	Jm2hnMWWI4ifKpKMTEGhgteX5I0W6W5yax31SY2Mno28lL0ET3LlUl4WzHHI6k8=
X-Gm-Gg: ASbGncvB4Wv1q3bgXJ71/SRqYlqjFMnZ30G5WEYPTAgzDMjWK89fxaQh7XGaKztusBg
	qTEnl9NtP6mCUGQ6kTwwP6kp9XiAAHUPcthylxYRGxXBcYoz9TLVANBxtWogeP8ffXeGyMrLCG3
	ZippKMKsNE1AoOlMUxdamPbmZnBcWt8arlugYHTeaPTZ46ylJl6XxXTgFQixq2vosLjSVtUBFns
	pPuWZKhxJCKWwZC6uRHBiRjvur8IzmD1a56+soIjUaawLOlnrvcQm62xJ6aOQQ8mwtF35eSzwby
	50lnlg2hl4WI5PD8XcY8QXmhtby9akX0IAlibXHR/XbgIYsXGV0rGFaTBAuNyMMs
X-Google-Smtp-Source: AGHT+IE/gXCIwybwMK6bxAKgrlyI/gpY6nFvi94kQ78DP/ey/y9SZvjySbiVrf9fmXSNn/2xdNnHow==
X-Received: by 2002:a05:620a:480b:b0:7c0:ab46:396c with SMTP id af79cd13be357-7c0ab463ca4mr528395185a.21.1739883970143;
        Tue, 18 Feb 2025 05:06:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09f33bc60sm235631685a.108.2025.02.18.05.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 05:06:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkNId-0000000HRM6-2S1o;
	Tue, 18 Feb 2025 09:06:07 -0400
Date: Tue, 18 Feb 2025 09:06:07 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] iommufd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
Message-ID: <20250218130607.GG3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-12-baolu.lu@linux.intel.com>
 <Z67rghQyQrjb5sT1@Asurada-Nvidia>
 <4ee09fd2-92c6-4295-88ca-1cc061135417@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ee09fd2-92c6-4295-88ca-1cc061135417@linux.intel.com>

On Sat, Feb 15, 2025 at 02:32:32PM +0800, Baolu Lu wrote:
> On 2/14/25 15:06, Nicolin Chen wrote:
> > On Fri, Feb 14, 2025 at 02:11:03PM +0800, Lu Baolu wrote:
> > > The iopf enablement has been moved to the iommu drivers. It is unnecessary
> > > for iommufd to handle iopf enablement. Remove the iopf enablement logic to
> > > avoid duplication.
> > > 
> > > Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> > > ---
> > >   drivers/iommu/iommufd/device.c          |   1 -
> > >   drivers/iommu/iommufd/fault.c           | 111 ++++++------------------
> > >   drivers/iommu/iommufd/iommufd_private.h |   3 -
> > >   3 files changed, 28 insertions(+), 87 deletions(-)
> > This is in conflict with my fault patches that Jason just took
> > a couple days ago:
> > https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/log/?
> > h=for-next
> > 
> > I think it needs a rebase, perhaps on the branch mentioned here:
> > https://lore.kernel.org/linux-iommu/20250213150836.GC3754072@nvidia.com/
> 
> Yes, sure. I will rebase it in the next version to avoid the conflict.

That's troublesome, I think just leave it so Joerg can pick it up. We
can figure out what to do with the conflict later.

Jason
