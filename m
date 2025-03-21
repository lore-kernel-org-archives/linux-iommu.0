Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B03379EA
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742544609; cv=none; b=qfIHE4/DIoklWfc2LmyRmXttYDRqWFUkePs78LnEvZFNbT4XL/RKdoW8SmTzzDTL/9lla4+9sqYPUJcYKF3/Dt5oxhb6ek16XoqFlI+KVv4wIhP1CFkQBA500398MveNzPCZy1EY9m5CHELOcEiWv69QkJ5iPIaNrTmS5VSsdhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742544609; c=relaxed/simple;
	bh=dHOREEj/lyvGZ0W6QAHM/STxY4PkdofdHPCX+gDj4M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssT6QD7AvR/BuuRtWL+SI4PcqS7NUAagvyOet9NrrxpsOXNv6POdy9dx7bQ9qKVJlTc2FqByMUFMfwKnldM6RgpdL+hsjHQo0UPWDbzTd+i2YCD3eInCR4o+DBGXZtb7OVMaGwMJKNRTVmqmmxU4meYG7dafnFKTZr3EE4SSUFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YhF3O4fR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YhF3O4fR"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2264c9d0295so138955ad.0
        for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 01:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742544607; x=1743149407; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q58xXdANiSPvvBbbZmp/OpDzEZGK7GVo5hWg7hWWReo=;
        b=YhF3O4fRTA02T27a4zeabhDocz9NXuZjV8bDMXQ4k01LS6vVM2FGj7zwStOlPFuINb
         ZbpCjU3+5bav/ARLFLhxnZQdtZVFCtWxOZ+gLUAofkNtsiPiubkh+jgNgCXviADGt9VP
         KRereD07hj9waRMqmRkmC3as43H3Me9sKnSv80P28qZbYtp76a6PHyB8I6T+xaslrua0
         3Ess2XdnwnRhjBAMEc5gdMOyRaLyTrFtDsVKELFyCKl2ibPEMdn3D2I66zc4Pav8Msgy
         NZyBdD+H7AgY2gHfrYygku39FF8d3atESBfuOue7uXHE51EaqQP+bdXebFd6FVRwkER6
         lzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742544607; x=1743149407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q58xXdANiSPvvBbbZmp/OpDzEZGK7GVo5hWg7hWWReo=;
        b=GSe0zi3LxXIWKI1FexMCL/Z1NJfl6Su/XeSwse2Ubychx7+PU9pcUFYz+KShZTLprY
         54lpKfwWT6e36nqPdrUzkqRiccg2s4c2JRFIvOJ+OCk/5fnUpCT4TNfN04UNE94D/7kd
         MWDCgGmLNyGiRB4RsXz+sM032Dp1vENwTk7vbIzq21l/fV94E+xLDBGY4AdqW77uuCmG
         g6IElNoJiUnntVP28KB/Tkpkb+VWTeyaSzL4Jh8WWVZV1k9Yq3MU/YDGLjX5oZGiuy2O
         2Fq2tmHHgY5p4zFayIqDSYcYsg6AVEbzUdXP8v0xz+isZHhpXmvPuDZBR7GsbGZKZVm5
         mCwA==
X-Forwarded-Encrypted: i=1; AJvYcCU7T5ML2rdmBIFeinmjy6ocijpim0jpab9+776GvDp5RJkFIoFQIJiYZig/c1AhwE5fytyFaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdkNPxwKutV/VrcFDS3tCc/u6yJbQ6KJZV+X83/2v7hepNTAN5
	bFZLDOdFYYV61Gvqkub1Dv7zkRLrbWsfYYD2psaU87aC212jKT85AQET5cbXWw==
X-Gm-Gg: ASbGnctDW/dL75Lcl5HttJfUalntQYFLJT/NWJp5xrgMdKRwJ+b5IzxXRYI+grDuW4j
	7s225N8WHKQToYq7HsiJIOAb2HD+SwLYsq0dUG3b5Bo5Ap0qvMFAKfuxMc3bFbmIV0fLi5+8P7S
	MQCA3wBN38CmARqGhbr/kVPQ6kfpMDDcD029G+LgahiK6vrC6H+LNbUbUcIXFVMi14YnAdudFkj
	F0ICA4HlbXxI8FqwScjzNdb3xDbxUgZ2uefehrS/mM+ZMBrx30PtgOmwsKD0lYn9zHm/MAXeyXf
	OuVfnG7/kHqgnu5RELYtrO+21oeWKycAAUz/0tO7DOjMq8o7xACRGgQL9g9k7vaQ8/U1BiK6i4W
	D0h4=
X-Google-Smtp-Source: AGHT+IGyXl4zI8pczA2ycR3ot2WO0YQz4FqKQzWyUL3u7alcilfIrQBxcWIn2TRUmgSIxxXiWWCpng==
X-Received: by 2002:a17:903:8c8:b0:224:1fb:7b65 with SMTP id d9443c01a7336-22781da2413mr2561275ad.22.1742544607278;
        Fri, 21 Mar 2025 01:10:07 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fa402csm1211049b3a.28.2025.03.21.01.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 01:10:06 -0700 (PDT)
Date: Fri, 21 Mar 2025 08:09:59 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 2/5] iommu/arm-smmu-v3: Add a helper to wait till
 cmdq drains
Message-ID: <Z90e10prq5NQvxet@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-3-praan@google.com>
 <Z9yW_4i7mCOVgjsY@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9yW_4i7mCOVgjsY@google.com>

On Thu, Mar 20, 2025 at 10:30:23PM +0000, Mostafa Saleh wrote:
> On Wed, Mar 19, 2025 at 12:42:51AM +0000, Pranjal Shrivastava wrote:
> > Before we suspend SMMU, we want to ensure that all commands have been
> > consumed by the SMMU's command queue, i.e. the cmdq is empty. Add a
> > helper function that waits till the cmdq is empty using `queue_empty`.
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 +++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 80362d9f293b..f65d9bca0392 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -754,6 +754,30 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
> >  	return __arm_smmu_cmdq_poll_until_consumed(smmu, cmdq, llq);
> >  }
> >  
> > +/*
> > + * Wait until the SMMU cmdq is empty
> > + * Must be called with the cmdq lock held in some capacity.
> > + */
> > +static int arm_smmu_cmdq_poll_until_empty(struct arm_smmu_device *smmu,
> > +					  struct arm_smmu_cmdq *cmdq,
> > +					  struct arm_smmu_ll_queue *llq)
> > +{
> > +	struct arm_smmu_queue_poll qp;
> > +	int ret = 0;
> > +
> > +	queue_poll_init(smmu, &qp);
> > +	llq->val = READ_ONCE(cmdq->q.llq.val);
> > +	do {
> > +		if (queue_empty(llq))
> > +			break;
> > +
> > +		ret = queue_poll(&qp);
> > +		llq->cons = readl(cmdq->q.cons_reg);
> 
> If the command queue is not empty, that means some other thread is already
> polling it, so I guess there is no need to do any MMIO here, just poll
> the SW view of prod/cons, something similar to arm_smmu_cmdq_poll_until_not_full()
> 

That's a good insight. But, I don't understand how we can avoid MMIO
here? The commands that are inserted without (sync == true) won't update
the llq.cons... in which case if we keep polling on the SW copies of
prod and cons we'd never know if the queue was drained? I believe we
will have to poll on the cons register.

> Thanks,
> Mostafa

Thanks,
Praan
