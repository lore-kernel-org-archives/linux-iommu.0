Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AE648CFC
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777924989; cv=none; b=BGEFasRUJFic/cg6e3x/h+6sv2h4wYKnkn7D7mzoVNDwAPsXiSMD81fSYEGBFz2373uB8o3UgAup8cb930ek6Ex5fII5/s5QNS4RmW7eqiYLmOu6dqqwF+pUg/XX9bK4Qfr4C8e8PGgLDlUoAcuAwrTcDBxlFKmOu5lJmOeASg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777924989; c=relaxed/simple;
	bh=pXPIjGNYpi69Bon2DqAWNLhLPY4hPv8dSPKeqJsW874=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYCgw5LkyVDGq4umKeuEGIc4ScfdU0kLHByXEDNXusNVzoSZR0ck88wetYTD3iMQIo4yRxG6YmBJybXVpeL/JapeOngMPuGxdeRvyYdrwXj9S89FkPYh3a6xYHX7G1+UNNLC1dlKmaSEtdo0m+M+CbEX8hiUQzAH9wwjK5Xi6HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WNyddPG/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNyddPG/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b46da8c48eso5635ad.1
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 13:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777924988; x=1778529788; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=emjSjV3utqNv2F2i02Z6rteNG4fAx/eGyIMCJhbYmJY=;
        b=WNyddPG/2rxPQfoSHJlqSE7J0+D+7GggwOp2muP27+X0J2Y9d7VfXmyzJZgniAGlBq
         GjG0FPUBQNoiFfYfaEZMFlson6QQE2sZ8qUjjskopETKS+QhIclwYaNYvPfXqHJwljwf
         ZXrpMYdLTY5wv8jkwMLHyh+2w1g3s407sHntQUwq7HCu5f7HSWPodwKWlG4T9AbSxSFG
         2qJ9PGiEEfo983MLCKcHExu41Pe83OiEGZBU/W1FDw2oTnx9IM7MHHAOZR8T6TFX77vp
         NtetSHHStCSp3w9bm1hbCCTtjiAznyZT3RI13GS3nDyLiMiaHLEXVdgfnocnLJFAgKzY
         3Zow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777924988; x=1778529788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emjSjV3utqNv2F2i02Z6rteNG4fAx/eGyIMCJhbYmJY=;
        b=bTH+a0u5zr6ehb9yBROc16d3A5gvvjA+WV9U6KAcnWYmEbk6B9yeOjOHu9xrr5FTQe
         f45IaKR2vSElz8tygS88uXt0pgTYZwy9QzrNgkZUfkemSxjZJMdGvryffrGz3mlrlj2R
         b6F7RS+71WuB3ER/ftEyYEQ3PvuaOlOcyHGeaQqjPnWdxjyQarzwgvntTq1gNgNohdLe
         DaMUZxzYOzZPquaKh1x2K1fhPIChZgXm9Lr56eM7I1n6p+q5zRceHVcRNAVpUjQ944S6
         JXvmC2QOQoKVi51KdOMP5ba6MSAoKKAWQFZyxJRJtWqr2G0Y23ox2b8rMUeKG6gJla+H
         hntg==
X-Gm-Message-State: AOJu0YyNtt2TOi80lSgJy+f+j5pJw6wtW1aPg0bbjOTyyo9YPsxu38c7
	7FALim71DW1RUNuteIKuz05CimrncDzSjGirwY0TxPXBbgJARMfBSZ3FrEaT/CnKwA==
X-Gm-Gg: AeBDievv2vnRf/QQGoluu1FwAwMJ7GJKrvj5WelB6OfsCKtevLRZi2JKo7XuFltZsLn
	OQaHKItZ00wNkR7oUbxYxecqL+FiD/GTlPK4ebRtYzFXd9KdHuMwyhESzZ9oz2aVK60zJ18SKuw
	c5SZe9AQdYxIOCPJtNV8C5HtfWLba6ArEyn/7K2OPJqd/n07JH+w1w5lfSlyzHM+hGcK2gpQRDg
	e+iFaXPVa2npauXEbooJDuFqwjuyiW2b71lfXr8OFNM4a2xl2+gXqteG0Wp0qmC/1Jotj2Vtl3n
	M5Ii+VBeR9BCJumGViSSd51c331/8RshjTn3WRemYJ1vo+espwMuvrMet/9mY3+IqVdR1BE15mG
	pxRx0zjxbXxSY3s+cWzkVFsPJCpr6bExqUbZz0JssEJpLLy5uTf7YQO5cL2jrQDCrrRTPltn/R6
	XbA+QiLfmbKCO+tyxbDmz81Y168kOVUkdR6x/dOPgK1hO0+ClCi4pbf1fGtQmrlhyCinG4MYlPF
	jZlnTU=
X-Received: by 2002:a17:902:f645:b0:2b0:b458:2dc3 with SMTP id d9443c01a7336-2ba532b2e90mr103955ad.21.1777924987069;
        Mon, 04 May 2026 13:03:07 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae0f0acsm109898665ad.38.2026.05.04.13.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:03:06 -0700 (PDT)
Date: Mon, 4 May 2026 20:03:01 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <afj7dfKdGJk_gJzK@google.com>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afj0cyBZwkVLyIwK@google.com>

On Mon, May 04, 2026 at 07:33:07PM +0000, Pranjal Shrivastava wrote:
> On Mon, May 04, 2026 at 11:01:42AM -0700, Nicolin Chen wrote:
> > On Mon, May 04, 2026 at 04:38:42PM +0000, Pranjal Shrivastava wrote:
[...]

Accidentally deleted the minus ( - ) below:

> 
> and then in attach_prepare we can add the ats check for safety:
> 
>         if (!state->ats_enabled && master->ats_enabled) {
> -               pci_disable_ats(to_pci_dev(master->dev)); <--- this
> 
> +               if (pdev->ats_enabled)
> +                       pci_disable_ats(to_pci_dev(master->dev));
> 
> 	/* Rest of the condition */
> 
> 	}
> 
> WDYT?
> 

Thanks,
Praan
