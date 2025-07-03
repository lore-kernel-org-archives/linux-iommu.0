Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5372EE29D
	for <iommu@lists.linux.dev>; Thu,  3 Jul 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553976; cv=none; b=hVTwtTFmHqppDdeykNnnyuKTzDSq8HTIE1y0qUH3Zx7neR1GJ8bViCJPQF7IWTJOia0QXyS33eVjQWipGuINdxIWSXDt2XpvqWc0EXo71tYHmOSdK2qNnad1/QN5P0JNAWF4pJmxcd0m1CBUIxiRfhKHp6rOyHTnvU5B6W+l5cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553976; c=relaxed/simple;
	bh=072pcCvBMR7vtDKQsCrYBJuqlkcEW2Q3tlczFa12bes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGAEteBrenqCnBkcIzP37rF5odnMvUW4Pik64ZENs/H8piLHDv9wBq+6LI7vMVGq2Pw62ypouocbKUlNVE63of3+c6+t1FSD3ajQ8Rz6oMMHy26Go5Op4cS0+ieSVHac02gV3g0osN1HGtfxdWztuSABcoqsKMxwpMc4P4FGcCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CwCggacK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CwCggacK"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-237f18108d2so205945ad.0
        for <iommu@lists.linux.dev>; Thu, 03 Jul 2025 07:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751553973; x=1752158773; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyBqVSoupq82KbFVVt6LJyI9rbtpg1wvjlbr52oP/Zs=;
        b=CwCggacK6rzpjDgBYhKGKfNfm//jMc5nOB3lTIEQXHIitPVR0fxrxRgRXFowwtBCHc
         FeGH50LDz9rYc8eZKXXdmnvINuPiY4JVXjVdW8buZlJ2R127Wm3BtwoeHMsMeBjxdTBw
         dFkJ9LO4XuexPYqbcBRIIVV0dqNIhwf3/FGSp+kLEOatsDLMBYrHrUaYUPnN/Sxao5XS
         QiD8t+RWeLKd6wXEpLfNZihM4cBPJ8Xe5wFLzuOoVV6OqRJfirOTX59tWEJ8tTj8TZQ7
         g282WJvdcKnCnc71nUHmpsfPXxgwiXeJs37hbljKBATMn4wCWMQahfkZBoMmLPJ2fhWd
         tzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751553973; x=1752158773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyBqVSoupq82KbFVVt6LJyI9rbtpg1wvjlbr52oP/Zs=;
        b=W31ElD0qvEZq5X/J6Lz4NMg/WrFGiKmxE1VGXuLAtcC9D8is8cn7UjYHs8aAdNdk0t
         za2C2Wv0jPlHyUx2QcKkBRrptvGN8BtTIxYnc3qtCghvh3UN78fg94LCLSd9jVzS0Mly
         M5uZbEMkK7E/E3WZQC8QDq/rUAXl6HBfEszfDgSOYAAjCrPF4Azm6zZ8glCKqOKe6doX
         Yv6Qrss/p+HbqSe/HTwvj5NTdJlnegT5hPVIE0o9PoJ5Uhgp6rXsTbZgzm5zl8uui1M6
         Uus0Hn8pcnCvkaazqBejd7y8OD82S45Dtli6P/TodAkiJKrH2oLIMEG1/DjrB6meG627
         Ex6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMkaieCG8gbgAZH46kVlQzLAnnv/EhCv30gnYd4wqKxbd4uI7LJGcHLzVquylzrxCIfMNyCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYuXvlWs/AXGAMyJaR5Ru9XCusWBAwlQb4i+82sQW0wo9MsFPl
	aIsUwW872YtTItunp9nHUasaBjrbyadA45lLOveGE/ZBWmCa6SaBjpXrvC+6bM/A9w==
X-Gm-Gg: ASbGncvIpOhRk3QEF1fjn+9Jin8++tXGEoq+rbrcpop0b2s4Wk/hj3LM5VqsGuhGrEZ
	+AVaNj/5xYjHTMn7yKYAvxUGnc+sVCgASrit0SjNWEQ8BY2ysyKba42uXy3A9odB7eEImv1bbz/
	NXCx5YhDvBFFML+7lMV8vrqDsumatI7eesQ3zRX0iNLRKpkrR5bPT5b5CDHmocB0ke/Fuk67TjU
	N9je5BLdre6AbTeuXYsxuSLSWkYhqp6THDDNJ/Dtr2bw2UYrKD/aI5rGBK7fG1uvpCFp08RVN2J
	SMgd11NUeaZX/guHWd2o1y/RCY5Ey5MPPkalEE/hG00Dnm+dae2YYJTEHFRkO735ZEX9vXnMErs
	1Y6g8/yXoWOIDxhJJO9RdXO69dzVrnn4=
X-Google-Smtp-Source: AGHT+IE+IjimVm/cNBTQKKRIynsqnkmviMOQfy4mliRYK2mww3VHnjujL8mKkHcoqxy9cwNV6ZMlng==
X-Received: by 2002:a17:902:c941:b0:22c:3cda:df11 with SMTP id d9443c01a7336-23c79b3ab97mr3276285ad.10.1751553972827;
        Thu, 03 Jul 2025 07:46:12 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e39d4sm158508935ad.18.2025.07.03.07.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 07:46:12 -0700 (PDT)
Date: Thu, 3 Jul 2025 14:46:03 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, zhangzekun11@huawei.com,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
	vasant.hegde@amd.com, dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v7 27/28] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aGaXqwzfLwsgCH6n@google.com>
References: <aGQ_F7Qx3scbbA-J@google.com>
 <aGRDtYRXFLoT+PrI@Asurada-Nvidia>
 <aGRIctg4T6cQECx4@google.com>
 <aGRcPSwaJkTeUrMx@Asurada-Nvidia>
 <aGRmaOORg-YDfncY@google.com>
 <aGRozoIDIlgl9H9x@Asurada-Nvidia>
 <aGR55PUBnwb8qT8U@google.com>
 <aGSBTpY0nkdp2TTL@Asurada-Nvidia>
 <aGSNmf5Q82xEbDpX@google.com>
 <20250702180541.GD1139770@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702180541.GD1139770@nvidia.com>

On Wed, Jul 02, 2025 at 03:05:41PM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 02, 2025 at 01:38:33AM +0000, Pranjal Shrivastava wrote:
> > On Tue, Jul 01, 2025 at 05:46:06PM -0700, Nicolin Chen wrote:
> > > On Wed, Jul 02, 2025 at 12:14:28AM +0000, Pranjal Shrivastava wrote:
> > > > Thus, coming back to the two initial points:
> > > > 
> > > > 1) Issuing "non-invalidation" commands through .cache_invalidate could
> > > >    be confusing, I'm not asking to change the op name here, but if we
> > > >    plan to label it, let's label them as "Trapped commands" OR
> > > >    "non-accelerated" commands as you suggested.
> > > 
> > > VCMDQ only accelerates limited invalidation commands, not all of
> > > them: STE cache invalidation and CD cache invalidation commands
> > > still go down to that op.
> > > 
> > 
> > Right, I'm just saying the "other" non-accelerated commands that are
> > NOT invalidations also go down that op. So, if we add a comment, let's 
> > not call them "non-invalidation" commands.
> 
> There are no non-invalidation commands:
> 
> static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
> 				      struct arm_vsmmu_invalidation_cmd *cmd)
> {
> 	switch (cmd->cmd[0] & CMDQ_0_OP) {
> 	case CMDQ_OP_TLBI_NSNH_ALL:
> 	case CMDQ_OP_TLBI_NH_VA:
> 	case CMDQ_OP_TLBI_NH_VAA:
> 	case CMDQ_OP_TLBI_NH_ALL:
> 	case CMDQ_OP_TLBI_NH_ASID:
> 	case CMDQ_OP_ATC_INV:
> 	case CMDQ_OP_CFGI_CD:
> 	case CMDQ_OP_CFGI_CD_ALL:
> 
> Those are only invalidations.
> 
> CD invalidation can't go through the vCMDQ path.
> 

Right.. I was however hoping we'd also trap commands like CMD_PRI_RESP
and CMD_RESUME...I'm not sure if they should be accelerated via CMDQV..
I guess I'll need to look and understand a little more if they are..

> > > > 2) The "FIXME" confusion: The comment in arm_vsmmu_cache_invalidate
> > > >    mentions we'd like to "fix" the issuing of commands through the main
> > > >    cmdq and instead like to group by "type", if that "type" is the queue
> > > >    type (which I assume it is because IOMMU_TYPE has to be arm-smmu-v3),
> > > 
> > > I recall that FIXME is noted by Jason at that time. And it should
> > > be interpreted as "group by opcode", IIUIC.
> > 
> > I see.. I misunderstood that..
> 
> Yes, we could use the vCMDQ in the SMMU driver for invalidations which
> would give some minor locking advantage. But it is not really
> important to anyone.
> 

Alright, I see. Makes sense. Thanks for the clarification.

> > > The thing is that for a host kernel that enabled in-kernel VCMDQs,
> > > those trapped user commands can be just issued to the smmu->cmdq
> > > or a vcmdq (picked via the get_secondary_cmdq impl_op).
> > 
> > Ohh.. so maybe some sort of a load balancing thing?
> 
> The goal of the SMMU driver when it detects CMDQV support is to route
> all supported invalidations to CMDQV queues and then balance those
> queues across CPUs to reduce lock contention.
> 

I see.. that makes sense.. so it's a relatively small gain (but a nice
one). Thanks for clarifying!

> Jason

Praan
