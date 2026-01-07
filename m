Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3243491F9
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767799705; cv=none; b=B2tvnluxd9Z31Z1zr2/fjaYfPBVsRFhO9iud8eKBPMz0FBx1vz69bHQDHOV8XQWzk1lF2CSKa01SWwhI/nGdFoUpL1ocDXZy28208mm9f4bNHxV/NR4yMh4tAv0yrrIzUMQlsacMOiDgS2oSg+NYKKtkqcTomw5UOdCoPbc4BJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767799705; c=relaxed/simple;
	bh=bEdTzVsCTnds/QEJ72cMK55QulTPOUsoFiergEmO5Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXBizfC4VLRldkTOIL0kie2Lf3Mf6+ZcMkAMpHcIqr7b0oSQ/1EMQuRma7onIsv2rNcMK94pqYRfTqLkwWnwZRyaGRFR/z/9+t5LUFWYce0p3LlykLh//C55hQ1L55M9KWM0nYYm+w3GLjtNlxwZzAu9+4waIhU0A/o9RWBhWMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jK9LUHvI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jK9LUHvI"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a35ae38bdfso72975ad.1
        for <iommu@lists.linux.dev>; Wed, 07 Jan 2026 07:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767799702; x=1768404502; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zr78093NHGdBXXu/mjsoeuNUSxyi1KCAaesy3wXMOKA=;
        b=jK9LUHvI/hAxhFZ0tECBYW4vbJ2FYhNkjunB3JIXGjtKHtdnPQLGA3y/zw36q3BtZp
         uWRAjc8+avzL2s1UrGas4MYdoRFejrXWOBZVHfqQDVis/MzNeQVGa7Hvno5Xo/RCASAf
         fnxcDW2jXqCRUHd8xpKAVOt76aQq3D6wNsZIwqk1aDqr3o8Gw6JeYfbEAU78s9mNUiAk
         dnKFgZ7eWzSDrjXdWJQnRJ4qX+VJvA01+e0uFwuTZA1+hyERN7OKLzXvCG6EeL2+Q6JQ
         BuNuQqd3fNdqNRRCYKW4JXUzrO+JwTVqGbq6LfrpKhQgSq0hcNu87Mh5a7QSn7/wARc4
         w5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767799702; x=1768404502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zr78093NHGdBXXu/mjsoeuNUSxyi1KCAaesy3wXMOKA=;
        b=NqRBKp15vOZbkOYcumP45X5T77GcjRY3imxwlQAfwqbRVh6TPwxik0huqEuQnnUQ8y
         H8mDG+CyWpTSId2v/Zl9/pJpQwubxQRPgiN1ZYH59KgU8bjk1jVZ8Vs+8jQ2dSA5XSr0
         Bjqa1PAEHzNo4WFPUOL8NNAxFuApKtb89h/Bs8tZj9x8kHDgh2ObxhVAStAZmmTSRB0x
         C7nIandrl+qWZq+2YGvZj5XZgMoyCqG+rcbwNc1AkiNCFAGBVd9IrNG0xxEhI9HN7Re9
         XPW1K822jPINj3vBYPo5ZKHIx7ysD+Us+yXyltLP5oEcAOtsu9GE5DFZp7+S+wURfAPp
         zrlA==
X-Forwarded-Encrypted: i=1; AJvYcCXTvFHfIJQEvm+V6/XOxEtfZxYbTOTOK9YAMovVTgCwl1gcTNJRSbHH7SxPpsiP9409ljdpbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhgrYUv682gaHi8/u1hkHOBYXUPTb3MsQ3bz6Cl9OOby8jLILb
	1Li75M2lYwCikh8I2gll1rW5t35xw3ty+WXKee+ouQDNUJTale0sAW5/mTnL7NE06A==
X-Gm-Gg: AY/fxX5ERtewa+rPs9LJJWNCyyEHjFwUrL93UqUNkKQEKpPO07atpn9eK4s+R23X7y2
	lu8l2tM0LDrvJ7r4N0pMXLoXtHtlC6+Nw1Vu7visfGLkyV4tGVNzqAdmPym5jNsLaSUVgwPQi5v
	5l9f754wJWPnxh64XCzrVKnfFJ/gb4B05fX0sC1IXLP8llYGqF+o/rydKtcvSZlKu+9lbiNOdtk
	2N3wcffQoayY2tEEHm1s4xo4QNv6pCyjSbtfx4kyfM6hTZx6hD5bySjAlb9leLLIaAlI6pFIkqN
	d/NQvl0jpoz9GZuaCh3vDOrsKxVUHgBKDwJ0rH8b8INzly5Gsu4PmPEBUGCdDbsMCIZe4+wkr9w
	+hIVqj1lXn3OhyT90FpCx54vIS4ge6wKQjGpnB5hIB7aurVRGSIxmDZpN1ge5UzSZ+DRqrlw6LB
	wLy8jPot9mHMPDXqWTXzYW3AhaIApxcMEi6QrV7ZOLSVah2ZGd
X-Received: by 2002:a17:902:ea01:b0:295:28a4:f0b3 with SMTP id d9443c01a7336-2a3edab5490mr2722885ad.0.1767799701484;
        Wed, 07 Jan 2026 07:28:21 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c5ce06sm53630535ad.44.2026.01.07.07.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 07:28:20 -0800 (PST)
Date: Wed, 7 Jan 2026 15:28:13 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, akpm@linux-foundation.org,
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com,
	baolu.lu@linux.intel.com, rdunlap@infradead.org
Subject: Re: [PATCH v5 2/4] iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
Message-ID: <aV57jZiKBfDHXciP@google.com>
References: <20260106162200.2223655-1-smostafa@google.com>
 <20260106162200.2223655-3-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106162200.2223655-3-smostafa@google.com>

On Tue, Jan 06, 2026 at 04:21:58PM +0000, Mostafa Saleh wrote:
> Add calls for the new iommu debug config IOMMU_DEBUG_PAGEALLOC:
> - iommu_debug_init: Enable the debug mode if configured by the user.
> - iommu_debug_map: Track iommu pages mapped, using physical address.
> - iommu_debug_unmap_begin: Track start of iommu unmap operation, with
>   IOVA and size.
> - iommu_debug_unmap_end: Track the end of unmap operation, passing the
>   actual unmapped size versus the tracked one at unmap_begin.
> 
> We have to do the unmap_begin/end as once pages are unmapped we lose
> the information of the physical address.
> This is racy, but the API is racy by construction as it uses refcounts
> and doesn't attempt to lock/synchronize with the IOMMU API as that will
> be costly, meaning that possibility of false negative exists.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/iommu-debug-pagealloc.c | 28 +++++++++++++
>  drivers/iommu/iommu-priv.h            | 58 +++++++++++++++++++++++++++
>  drivers/iommu/iommu.c                 | 11 ++++-
>  include/linux/iommu-debug-pagealloc.h |  1 +
>  4 files changed, 96 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Thanks
