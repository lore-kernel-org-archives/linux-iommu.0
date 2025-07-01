Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6488E271456
	for <iommu@lists.linux.dev>; Tue,  1 Jul 2025 22:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751410291; cv=none; b=ldaUv8cKOmDpauUr2aFVyOFI+hPtLiKNBxUGFnLin2zYMghbK0MhtGZL2Cdv1tCwPGzjPydVNYUUIul1fKMlRi4qYG1YqefsgifHl8uxHiq7QfPpqSzrIgFBnNeZeDAUBnnQmOHZZiKuxiYq9jN36JK+hBs3vw0OxMi4xs9q6GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751410291; c=relaxed/simple;
	bh=THyaiSK3XZpGPf2jkEiRMRg3uUKNoJcmWhjWuRS1+Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ih4vNyDa9zHm3Cw9vi6SVA+wLggI20QaVz+QkA2mVuvemzpMQC9oMYhO5tIYqgmoYcBN/jqI6JD6iqyW8mVhtVEG6PZPjm7UD7KavGYAbx2DQjj1mtd0UHkM0TwQSMq1WGfBEGCkDxdnBosMlmAgW4lza70huE6G0Jgi9d1arTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0YbvBXSy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0YbvBXSy"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235e389599fso350275ad.0
        for <iommu@lists.linux.dev>; Tue, 01 Jul 2025 15:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751410290; x=1752015090; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=31m5VALjhSZCUtaamU81Tt7LVwzdmFjl/OH4isUf0T4=;
        b=0YbvBXSy0OIyFLDn3mjLvtRG7fKPMXOoJ46L4yIDIQjF/DrviZjGZkwKFmoMn+Bhb/
         naVwGvh1BCQaaU2Cabs6AVkzBxVLyoA+ehNqvpIhTT87pbfFFi14SRFGj0vurRqRzvbt
         ERsciy621MOba+NwnGJYHNaSzr9LuNF6p6B87531YAKH+FL45HdwJlMJSmW4e1rYISo/
         ILgTRSsoKiq9VK9KfAWU3uyUO7wTS8UIALP369urXuS2mx8EQ9Lns9G0vpzteWvAFwjG
         lFMvBcocIMV8v+nVXs8kpuH4wgR2Tgcr9CEZhrSwxNrJonfGI5AJ9jo/QX6IVQYsQlUz
         +uEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751410290; x=1752015090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31m5VALjhSZCUtaamU81Tt7LVwzdmFjl/OH4isUf0T4=;
        b=oNz+N0Bn+h2MHvHYXezGFivuPTCe3PtjwBiMSJZUuJYgFWf5lsWT/sc8emV4Rx/eWf
         IxdXl4+dhbqz2+Eke1cKSuI56tweJLMG4hX9ikQ2EWKoyUIIh7YJCje8QNv8t8w7WSgG
         J2qULeMIqWaDtojQaCZ4eg9rE/gHmrPx5EF8xJCPYgGm/AXqyFJYNd49ARYn/UOsn7U3
         Zf8ttOiijseV676uIV4khFpXJ1+cdz+tBtU9v2BJYadsRrpwZhGIiSSz4tHEnVvPfXAg
         N8Wik/Ulnfp/O0JeEkZ6O9L0SbroghiCvHRXhumnjjX8B7NyVYx0Lj/BofNWkGgyJnwk
         ylkg==
X-Forwarded-Encrypted: i=1; AJvYcCWpN1VSc3TG0ZYlEJxPAIRbTVTdZdqxwKHUukm4iz5k5gwkrpgJCnLo9zB7eOmV/Y//u6ibsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YycnFWb4OBbZ9UnSKPKGKHZpItxSJVndmawzUn9wrcLy+f7Sqgg
	YGMPh0GC49PztuiTuBiLkP/2no34rNrtVZsfDZyIKIFlht7Ps3LMoHJAtYGNWFoPbw==
X-Gm-Gg: ASbGnct687rRxDbt22FtH4yNIGuoNTfoUuQ2kn0G8Q5ikK788535lrGHJ94SM+BzeuW
	pd7nANle++osttjvnPTWK2wXBxXrjAvhNLpmTPL9YbEoS/3rEiJTFU2ZRG7glEpb6we+c5bJDNJ
	BajQwZQOKGS40F54Z6FfSCym6XCcrSbCKGt/mXMQHZS57ID8vTwpNbJNfQ0wQKdyD7Lq34s1ney
	XRd2h1ye7mLuThVsAmbBWA2uRASgCYEZq3tJTFPrAfmnTSCTkd4RmXFYVZSwJPe/cCGnqLuLljb
	uwJFZp0Wixtf1hUzIyiZ3aWBFePHj3wyOb8fWfk69D1nUSBQe046OOO4ouAO6XCvgLYcQR5IYqR
	PsqjPRg6dOqYJ+9KkhA2/
X-Google-Smtp-Source: AGHT+IE2A3LONQdf5/UDXdamM9j2FEbJtnYf58bee8GseWxQ7r/tyyPKLeWd6GVOe4rd8pReDprYsg==
X-Received: by 2002:a17:903:40c6:b0:235:e1d6:5339 with SMTP id d9443c01a7336-23c601c954dmr3764925ad.26.1751410289353;
        Tue, 01 Jul 2025 15:51:29 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5384107sm17193429a91.5.2025.07.01.15.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 15:51:28 -0700 (PDT)
Date: Tue, 1 Jul 2025 22:51:20 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v7 27/28] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aGRmaOORg-YDfncY@google.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <539ee2ec112162abdba511574e2205a77b425059.1750966133.git.nicolinc@nvidia.com>
 <aGQGm1-i4M75b9Qp@google.com>
 <aGQ6KCI9OZEwHdxS@Asurada-Nvidia>
 <aGQ_F7Qx3scbbA-J@google.com>
 <aGRDtYRXFLoT+PrI@Asurada-Nvidia>
 <aGRIctg4T6cQECx4@google.com>
 <aGRcPSwaJkTeUrMx@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGRcPSwaJkTeUrMx@Asurada-Nvidia>

On Tue, Jul 01, 2025 at 03:07:57PM -0700, Nicolin Chen wrote:
> On Tue, Jul 01, 2025 at 08:43:30PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Jul 01, 2025 at 01:23:17PM -0700, Nicolin Chen wrote:
> > > Or perhaps calling them "non-accelerated commands" would be nicer.
> > 
> > Uhh okay, so there'll be a separate driver in the VM issuing invalidation
> > commands directly to the CMDQV thus we don't see any of it's part here?
> 
> That's how it works. VM must run a guest-level VCMDQ driver that
> separates accelerated and non-accelerated commands as it already
> does:
> 
>     accelerated commands => VCMDQ (HW)
> non-accelerated commands => SMMU CMDQ (SW) =iommufd=> SMMU CMDQ (HW)
> 

Right exactly what got me confused. I was assuming the same CMDQV driver
would run in the Guest kernel but seems like there's another driver for
the Guest that's not in tree yet or maybe is a purely user-space thing?

And the weird part was that "invalidation" commands are accelerated but
we use the .cache_invalidate viommu op for `non-invalidation` commands.
But I guess what you meant there could be non-accelerated invalidation 
commands (maybe something stage 2 TLBIs?) which would go through the 
.cache_invalidate op, right?

> Nicolin

Praan
