Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227BF30F95F
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778240809; cv=none; b=a4CMipUAIDWQc5UUVmZyEczfiHqViRImWkxw8ZPmGYuIuAYqtoq/2eBL+5SwoUp8G/gy0bZdrLulLtwV2Bz75Xc4e8WEudGqL6wM0bI3RfVEdWHk8qc0b7Yidx4CIWrCO332VhGK+4tzCHpLBNTdrApZWwcECJkdhJtPrlEW5W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778240809; c=relaxed/simple;
	bh=DYoySGWvwhGOll9MsWpRxB+eEde5kCmNkA4iyDMusGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofFxsmvTSesovPGIuYF70autVchJ3RDGnjxMKsLGgtNmOhoxMf6JeFcV9yqo4aUAkUEllw6FEZ5u1240vSR6yA/5A7ZeBAWHbtlO15a1oHmw/I+xPXmKV6wPTRcNVfsrPiiySQXRX6gnfmz+Mlk0GvP02dkv0lM5OYQRrXyfBkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UrkIKMvt; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UrkIKMvt"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso75075ad.0
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 04:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778240807; x=1778845607; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yk+VF2UUzCSCg/RvIE6fW76wSTl5BC3qMVjRSFknw3M=;
        b=UrkIKMvtR0Pv7xK0dvGl6W8XywaqdCz9QaEvjUo9rRtsAYYpDJu1tH5xw+zTNdxk7c
         ktMcokK1PLSslQZIrlF6N+PeKIc50Bu71Pc71yYJr+RPKTu/e6MD1ifDdxgAC13+d3X2
         xNH0ZGM5ZxGSml7Nzy6SRjAc90ewdVF4FF6wxrjnUrxpCUm9gZRNQ8EnY3XCKnSZ3E9n
         8UpqIoWi4oybgqII+yGGYy7IDpL54V9B7bu72ozlwFqWiVfv8Ol6j4K163UhccvaV2dt
         wGLFXK5s4nEMcU10eiCuIDchra5tKdN6vT7mV5x74FxN4YoZ3bGfvE7fLlLtTKpLdSVX
         OX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778240807; x=1778845607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yk+VF2UUzCSCg/RvIE6fW76wSTl5BC3qMVjRSFknw3M=;
        b=iBZBkt+OUKf00mzPAFeNYdeuCmJoV7sr9UIQwS09Diz6T0jNuUrGgyQIppz8LcF9br
         fCYuPz6iHvuEgzC7gsdamDHGlFtBLvSxRoUb2+xrwhVrJ5Ndc4xTZWlbVNSQpGcCvCPu
         6y4g+wgO4SYGGty2Rk+nha8aX3dlj33+PdQ++pPfRzKz2tACwItbSB/BuxewMajH3CwS
         k52RV/yJ4fZfhy4JVPIHUQMEbghxxHEdAgsTgp5OQSVG73NhWZ1poZPuUEk9boGhn/PV
         XOBrJuewSjBycvuH84MWby5U6P5goGPbza+2kIpLPjuz0Ih0v69kg02HGMq8CNw1118y
         11yg==
X-Gm-Message-State: AOJu0YxMFJb2EoZkYVaX5yatwPfL2yZM0SzHJXNBBVjs6TOzyFy9xLjm
	eKwklZ/lGKl4Q/tOn+ggO7fzkbY3Z0AyPjZ9+BHAMVEAC6SBretSSyHsOIpSKTD+/g==
X-Gm-Gg: Acq92OFRov9LM0PdwVBXAmoxfHByLPj+W1cWPEZc4glqiPcDpQRuPjBGFVO3Bpf2a9Q
	dYhK80VNa634YI5tHpPNQaAofb/TZsscYHwMhfR/sGk0Tnz56Exys+xXyRSsPScMkpiciWWZWIY
	NdFqTNnHHLn6iajIVTfXAK/4rneQm/BdzJi8is0/pT1r2beDzjG9+r9RE2vBCcqH+xcWCDSchTJ
	EonGKGJ/svKqIyshDFrW06Sk0KDcgRAY0sTBXqIC/+NOsHk8Mjc2Kxyy+tbv6tNWdth1ul3Uzqc
	9acLEYVfPOWdRNOCip+pBV2Ntobidf84LPMXpv6ilfl1GzMuJ918IP0M+u7/YyoVVh7S5C1eDE3
	KjkzI8wFUiFt3qxKi7N5wxcjT7M/xM7sawZt3RDSqFc0cyOIcou+w0CkHOCK4miV0woHFUZn966
	JsEPZWcgBTmFXMRoKZj0GTThEpGy/HSdUJhbuwe7BqNSKKmazWezsdxdV1aQpB3Dqh47AX
X-Received: by 2002:a17:903:1210:b0:2a7:87c2:fcde with SMTP id d9443c01a7336-2baee8320bbmr2253775ad.15.1778240806820;
        Fri, 08 May 2026 04:46:46 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d36c10sm15031850b3a.25.2026.05.08.04.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 04:46:46 -0700 (PDT)
Date: Fri, 8 May 2026 11:46:39 +0000
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
Subject: Re: [PATCH 7/9] iommu/arm-smmu-v3: Directly encode CMDQ_OP_ATC_INV
Message-ID: <af3NH0cihPUQ8PST@google.com>
References: <0-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
 <7-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>

On Fri, May 01, 2026 at 11:29:16AM -0300, Jason Gunthorpe wrote:
> Add a new command make function and convert all the places using
> ATC_INV.
> 
> Split out full invalidation to directly make the cmd instead of
> overloading size=0 to mean full invalidation.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---

Nit: I guess it's worth mentioning that we remove CMDQ_ATC_0_GLOBAL as
we don't set ent->atc.global = true anywhere in the driver anymore.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
