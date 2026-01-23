Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A7A372B37
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 09:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769161849; cv=none; b=sDcRhfkQn9J1DgkoHCjpKLay7vJ9sVe9pEAlXMTdCNzSQIYPvP5l7M/Qk3GV6scFJyRLT4fvv9H40oUwVgAEkxAV1mj96bFq0LuYdQD6WCUD5J0Pv5xAH1Z7uiNpzDB3hRfD8c09zJPG2pKkfgLJxyfwl/thJ9XK8NCIaDKNYkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769161849; c=relaxed/simple;
	bh=oLK6+2HG6JkYV7t9214eb0Q9utnLbtMWSKH+oP61+2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ne5sbjdK5TvtMI9IBK/YymTsMnai8zjEB10oR94fgGCPlIChFivhAnebtZGbY9KDcsPSj6KYyDe+LriRmysHAJnjS1nK7PCqcNoeRYxRrhjPuRptcNRmZ5CSQE6QINUh9Mur+FVSmA3uPPHjSMeHOdZP82ecJWsKflSaCr/8bQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tXtq+bvS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXtq+bvS"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a1462573caso101855ad.0
        for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 01:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769161838; x=1769766638; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ezm4JjycmUxCtpfU+iSfc3PFKPDnM6onFM81HUDKjpI=;
        b=tXtq+bvSLum18wFbEwzB4sw55oR2RKKRB6uFcx9sBJ/DwzGy0+OaF30Gx2y2fbujeS
         h1ljtK+G4qKIM4sqQjJ9kKbnJaKxYK2GS1BSm6oF5h+QslxC3pTF64TpyGwbHfV2r8Im
         OfNYbKH5V+Iu0tXrZpgI1JZysBp1vTmF57F5/poy5IuDSI4WfEnEJCQZ4XQAuoWesjph
         yITTsm+KLs0o21CxrvPKolEh64kWfcUiNX+53dGIhbGp07SHhVnstymAZ2D7XN1rWY7H
         7ApuM7aYX0c3bJBmmLQeEY67ecAIKs1l2AEEVGeZyDW0TCkB1hOU7jDP2tvVAU36wozw
         gFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769161838; x=1769766638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ezm4JjycmUxCtpfU+iSfc3PFKPDnM6onFM81HUDKjpI=;
        b=BI8Br5GMWGLlicozUP9OAGW/Mfqi/zCGO0wdDru8m3W4uwevlns16+oUBo/7LHoMxv
         5Qy7twKM0Rdf6WIeHdXqbih360k5aZuwXuT6Q6s4BXbYUJA6Hjdg7X5FdGMz8U4bhwcx
         bFSiEQXyv1ciAlGEZm4vLDSpqwUsbSP3xmInT6gPR0M7xp92AYxcurbsjEzX/QS9tHKY
         trQDYpza3Ak/5OG7bSdUhckluMFV6Xtj6MTXXEWq3/5ZSK5GH3jBjOl53H/6bIZWhNkF
         6j/lrZfYPPO4l5dYByl6RFZUTVN2AdVmupPdmmfO1w3GFybN3h+K6pBuqLZLIB3WFrWr
         WekA==
X-Forwarded-Encrypted: i=1; AJvYcCXx4U/+1Gc/T4K6XEofS/M9S0X0GYKqaF+3WN6AmHhgqyfjQViOUm3am9eM8Vj65vLGq06nyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFZbO701DsS6XWRGN+83X8GaQC1/ICRsEkY9r47plqSeMN04i+
	tbYAOftxos4nVzIIYmu2KjznY1JpP3wk6/mGoSWyLPSjVpDIfK/fNoZ70wcBeo6pRg==
X-Gm-Gg: AZuq6aJbLAlof/FuapyPJz6yuHxBlTJhUyJvmZ6eZN2bMnjZXCja/04blIVw5bPX6aZ
	jwRxqGRQ+Pe+wOlqmbTXhYbQdTXlJcu4hXXZomN2t/A41nsb+HAcrY68GdacHeKtKKwcGvUFZKb
	2XU0385LQDamdWhESCnpAmyX5CLoSYxiuivXprifcEV3LjXcIfkTH3eu3qpaNAG4BhoAGLsWACJ
	8t3OWR9tQEceOdVjw/0gnE57dSJHSCzdvZlFxbNZruuWuDE519/73DHiOwtz7Z+0uM99eWPuDfH
	9tyVohxRA4jJnSQwu8/PSoZzi5wY6Q1a6lOE1RZU8V64FiYXP21CeSlUqzh1qyb1Siwkhzy85h/
	JErqu60t1CvVha+WoPtc8lELIT2IKYEKqKNwDP/C+0diaoTVl8rWQAfJDoaL9cQ/NldotdOcD1+
	QpBxYwdf3VcsEYUSvrSXpAOg4lCnrVrcBUIDG02FLNRYGilrGA
X-Received: by 2002:a17:902:d50a:b0:29f:f71:a3b9 with SMTP id d9443c01a7336-2a805d137b4mr1553765ad.5.1769161837239;
        Fri, 23 Jan 2026 01:50:37 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802fdd70asm15746635ad.92.2026.01.23.01.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 01:50:36 -0800 (PST)
Date: Fri, 23 Jan 2026 09:50:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
	joro@8bytes.org, jgg@nvidia.com, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/7] iommu/arm-smmu-v3: Add an inline
 arm_smmu_domain_free()
Message-ID: <aXNEZ6ZV2i6IMpNW@google.com>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <b516338bdde0bc6f06e2719b9292ffa260085a67.1766174731.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b516338bdde0bc6f06e2719b9292ffa260085a67.1766174731.git.nicolinc@nvidia.com>

On Fri, Dec 19, 2025 at 12:11:24PM -0800, Nicolin Chen wrote:
> There will be a bit more things to free than smmu_domain itself. So keep a
> simple inline function in the header to share aross files.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: Balbir Singh <balbirs@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 5 +++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 5 +++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 4 ++--
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks
Praan
