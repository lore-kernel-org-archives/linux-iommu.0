Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8B43E0C68
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247696; cv=none; b=NQzUtGoEVZ9FPwJKuMc+Ys+yNS5PFUjo++gsEem7HeW7HRrnd2FAWywD1+uMgd7U5WlGQqapPfNDStmSH9Qa86YEOhb5RzmZeUcKhujAmWvxcG/YhOhjPL1+T+m4L6p38aoOlC82jr+65752MXC7Qi16vsH5uj6/UNB4tqAXKlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247696; c=relaxed/simple;
	bh=znsTVaBtPyzPupvWVrvhRnQZJGVi5v1mDow9DWL5Osc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5E4k99YfGHmtnvYCekWh4jyMdoSbE1y48RNH8Z4+WZ6+1gamI4Qb2ThkEmva9/uiaHyCk8RzAr2OG+CCr1MkG4Y23Dkyv7plPF+Y1zqoCzWlxId57ECrQbsc/RUHqq2TXosbN+TtRu2H8Wvooq4VEJ6ywftjzA8IFYuJ13KcZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=knerfWdF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="knerfWdF"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso85645ad.0
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 06:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778247695; x=1778852495; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kn3HnEGpfsinsQczYQb+6skEifl1bNdoE4T6rMB6rKk=;
        b=knerfWdFEhJbMuV0qSxS82RRawCW/zse1ajNQL4bIAxU+pZITXenf3gHfCDHUa5WGA
         vSx8n6F9L3HFWRLsr+MpyIpnZmpV2MZfB0HoH7XCSiAML+FavLhyiSITXKqfdvvvut9a
         NFYEbYe/tHjf8mvX+A+6aeKRvJoGt3arRf/A564UOAv0N+VyGZJc2NEY2lDaoEiFC1l+
         YIm7ZB4b43nAv0/DSpvg2QxX+VAbEGWzDHXO21juAgRdm6FNON+co58DLLVGknoI+Gbg
         2vOraOw4QJgraxM2bFQspd79CV63qFCNImlcx6msj8w9uGksObo3JthifIskyC6f1woj
         4OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778247695; x=1778852495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kn3HnEGpfsinsQczYQb+6skEifl1bNdoE4T6rMB6rKk=;
        b=Z5HUnuLULsnQNPrlJ98JKX0P3QnJPr7/QI0+aQW1xfSqdeNGTBeWmb70YMKmHC+7hU
         xqmKEw+QF+407bc4RPeEg3J1lqdOQgniGVLgaYwiEcOnD+JyUxdVao51Woi2TEUC6vpJ
         LRnzKeG9iezvxq3oae9zFaQOdlXJ3VvopL9v+5SDBA+eiLNehdo5gKqkxdb9azQVx1Ff
         HudTUQ2EMId2KWpXZUvzaQG7F7hXH2hpN9sbTaeHiHzZIMjxd7cjWCpgbaIMbh+XhlN+
         AG5En+UDr5lampPd6Lt23Vv70GmfPEam/V16R7bDIM/ewTrqGoYfe0+icvfUP6IS3aWt
         lSrA==
X-Gm-Message-State: AOJu0Yz2ixCjHPUdZgC9GsMnibt4wKzZ+PJ9qunPFPYzk3EZ/lMZpI7y
	jkuju+HhraXGWL+iEg13/tskGUyU8/Pm5c/b+3N74En1ezVrCnIolsmInDaLL85irQ==
X-Gm-Gg: Acq92OHpGTkUvP/cGyZYpjujVwMCaaXNibK7qKmbGByIImdx29PGsYJkBFYA5mO69CA
	82UCmOvwDcuyN7j+/X1JGjwfy/cY9fA1jL7KQfkzw/CtQsvXErUR4sdP7r/3AzRSlQD2BgV9jPA
	J/bJnDt2dSDNfxyMO6euEVhqVhKMKVVOHoIIrFzviqNJ3emAvj9ec/HBN4+ztxbyXAzSK1v0x9G
	bxbYcQgQ7SGymn5OaYwPvLl6mEtq5gqLlSEj9fGBO/n1cc6KUD3mqGY3vPFXs1nECuyWIwDqr3g
	bln6ldJh9PO4uaAYl+25rItXBhQtc4r/3uysakfgjAUosQMyjFxj67tLv//K+1yHJJUlErMRgBl
	iLXfs+jjgmHqf3Z5hhLXS4duNmHnt6Nm/ep5BAfhKSJCCGgT0saOG3V24UtHhs0geKhIaCknWiw
	L4B3zbUjxjMqy0Yf7mlnr4bKbQfTM1NS+RLiQcmpiq+hbHzhNCSkMtVg8N14nlUoL2hSiw
X-Received: by 2002:a17:903:198b:b0:2b4:6529:7bae with SMTP id d9443c01a7336-2baee842030mr2436805ad.17.1778247694198;
        Fri, 08 May 2026 06:41:34 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3664da1f5d6sm2479705a91.3.2026.05.08.06.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 06:41:33 -0700 (PDT)
Date: Fri, 8 May 2026 13:41:27 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH 8/9] iommu/arm-smmu-v3: Directly encode CMDQ_OP_SYNC
Message-ID: <af3oB0efZjr7HZi9@google.com>
References: <0-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
 <8-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>

On Fri, May 01, 2026 at 11:29:17AM -0300, Jason Gunthorpe wrote:
> Change the flow so the caller controls the CS field and remove the
> weird u64p_replace_bits() thing to override it.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
