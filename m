Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5375248F83D
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398274; cv=none; b=grP8+WW9qUEbtVePep4Mh9ARpojfjnwc27aoGHTkx5YS06F/fynzDd/ARQwGQEv2jcdLMiw+LGuXgTjowmiK5i9C0uu8GlS77hBoc+u1nKAiLsZdfFZy6wbzD7ugkTSdcPqYUf4n3gtKko+aK+c2EKZT0iIOt9J8z2EQ+W37zV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398274; c=relaxed/simple;
	bh=jts7JT7X0Il7llallqDOQsVcgzR2weK2u2dKxkGtG4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onXFAxTH/seP5L03baPuk/5EFSJXtwYYthVtjEnUI2bMCc9chN/54MzEp6MAdKwGMuo7Sdl0YjY74pBOomdcSe+tgw/3yREp1YY72+opo3t4QnP/AHGagyxzJ7ORchjM4u6FD/FKcWL4vrF+LoEEAX4lmLCXe2DgLEtVzp6tnVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tMPBSfUy; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tMPBSfUy"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e9f6a16afcso18155ad.1
        for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 01:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792398272; x=1793003072; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3jzjsLtJTWVbyke5K19uxcbpg8sweyOiagkfvb9qFUQ=;
        b=tMPBSfUyLArBJMVLlxwxvhQxdXsc870fQ0OxnafcE9hbR08cmIdVJTxCv5Gc5nVeyv
         sTyO47Cvdruba09Rwlrj+/j2B3u8tAyQegfuztUtPPK2ncVK92VSOIqBMcyGM3loj9Fw
         azFuoxVYDztvcDYrHW/IkFxmBd6HN/XHniJWqdaLee/aVhtUZchAYxbi2zlhprO1ZDgB
         eiOokWEEyvCnRbNShoyoQa2+1vqZhZXy0sYXd6DMxl1eGwKFDdtP8hp7gQKx+P5BfF0n
         ArmKVTRY2Sdok5D3IEm5PQJwXVZb9VEKKLeopoVRWWe4i/V8yn1vFnY9CCIJDs7Y14cj
         t0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792398272; x=1793003072;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3jzjsLtJTWVbyke5K19uxcbpg8sweyOiagkfvb9qFUQ=;
        b=CXfgkmn4kewEiBuggLzJu2nRDRYfOE00an6y2/WfcJSVzSjp5aRvCdkg80c9ocVRUV
         Tean07G+ErUdCai/ihAW7yUgl3ji891/PeTlCvGAiNvbMNpspG0QBAiySUYbiqR9LgWx
         blUsotRJxfgWUu/Rt82SHCYaODQPduRIxnNCfdqqlivBLGe+Gv7te7sxEe9XZ9QoWetI
         BOoec/c7ELVLLCBwBWavEo4qobtepVS9N2eKSzX+Fitit499riRmvi1SzbdbYPjMHs1D
         YaFXo0/3bf80aZKvND9GynLJWKbcGWzQg1Ll9V5udOV/pxGLrCT4PsoI64MrHC6a0NUv
         Vx3A==
X-Gm-Message-State: AFq9FYIdD1n+D+qRd740A53j6TWSZCOVCcQHWYnSMERV+qU5ozZF1a+Z
	yyDG/vOCCFJMWF2djbkDksQdeCTi791O7bGxwg9ETmbNWDICadiacdasCSMZ+wdFHg==
X-Gm-Gg: AYBFou0GJ8sY1dxxTrxk80n6J9t08gU+Dsav9HgCnqlHcnMhNdJsnJ0+38lvM8tHBnG
	8m9k768ZFRSn/dZL9Psk3Kt+fQ2IyfipaZNcLsUX0qDstJp1zNbNTk2HgT1WopDuyd8b0MvUjR0
	CEb7b2kwz8za2fta7cfPpuHSbblNTfXXzKdHSi9MwnmjCAOLXUWiP68yOni4b8NWvraeTPeu/f2
	cMNdImrm78B50q4T/mV5MhHDuHHwAXhWyjRSqu0yiicigkv71CT4ohzWwtcY+0IulsPW4r4p9Zx
	O6jLBs41JJLOCgwhcNRNFaZNnNUwRFRUWIyN+TqJhIcyIzOAySQLUxSt2AkCUPQhAWp9gpuCZRi
	SaV8LtL9l+qnUG5NPdvwdtjHcS4EBmjy8wwAUlv+CVnldGUhOuq4WJixf0FT/kvyi2w3kWE3fsD
	7QPHRb3fzGtvmhrL7fe3qblENUWgCvPzZhBfMgRf64Qa5emziNGtU+6yI5rE9ix6UzxabjZC2Kw
	XIXdqqHoOAmRqxQcWufmw8QIVUaL7Hy3DmJDcWBsQxx8W/3tvkrFqgyInfwDOiju6XUkuw/9P8f
	GxoOfDsEi3RG9W/mbg==
X-Received: by 2002:a17:903:1967:b0:2d5:db38:8010 with SMTP id d9443c01a7336-2e9b332b4d8mr6656035ad.15.1792398269918;
        Mon, 19 Oct 2026 01:24:29 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc963f36asm8219762a91.0.2026.10.19.01.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:24:29 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:24:21 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Message-ID: <atXTtaxz0z-U-XSJ@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <asZSQRSYBjbUaaH0@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asZSQRSYBjbUaaH0@willie-the-truck>

On Wed, Oct 07, 2026 at 03:08:01PM +0100, Will Deacon wrote:
> On Tue, Sep 29, 2026 at 03:45:05AM +0000, Pranjal Shrivastava wrote:
> > Introduce a new bit flag, CMDQ_PROD_STOP_FLAG (bit 30), in the command
> > queue's producer index to safely gate command submissions during device
> > suspension.
> > 
> > The flag embeds the suspend state directly into the existing global state
> > The flag is checked in the cmpxchg loop in arm_smmu_cmdq_issue_cmdlist(),
> > which acts as a Point of Commitment, ensuring that no indices are
> > reserved or committed once the SMMU begins suspending.
> 
> I'm not familiar with the term "Point of Commitment". Is that something
> you came up with? Without a general definition, I think I'd prefer to
> avoid using it, especially as it sounds like something to do with the
> Arm memory system (where we already have architectural terms such as
> "Point of Coherency".
>  
> > This prevents a situation of "abandoned batches" where indices are
> > incremented but commands are never written, which would otherwise
> > lead to timeout during the drain poll.
> > 
> > Update queue_inc_prod_n() to preserve this flag during index
> > calculations, ensuring that any in-flight commands that successfully
> > passed the point of commitment can proceed to completion while the
> > flag remains set.
> > 
> > Suggested-by: Daniel Mentz <danielmentz@google.com>
> > Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 35 +++++++++++++++++++--
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  5 +++
> >  2 files changed, 38 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index a123810fac57..7f89e2306942 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -218,7 +218,8 @@ static int queue_sync_prod_in(struct arm_smmu_queue *q)
> >  static u32 queue_inc_prod_n(struct arm_smmu_ll_queue *q, int n)
> >  {
> >  	u32 prod = Q_POS(q, q->prod) + n;
> > -	return Q_OVF(q->prod) | Q_POS(q, prod);
> > +
> > +	return Q_OVF(q->prod) | Q_STOP(q->prod) | Q_POS(q, prod);
> >  }
> >  
> >  static void queue_poll_init(struct arm_smmu_device *smmu,
> > @@ -726,13 +727,42 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> >  	do {
> >  		u64 old;
> >  
> > +		/*
> > +		 * If the SMMU is suspended/suspending, any new CMDs are elided.
> > +		 * This loop is the Point of Commitment. If we haven't cmpxchg'd
> > +		 * our new indices yet, we can safely bail. Once the indices are
> > +		 * committed, we MUST write valid commands to those slots to
> > +		 * avoid indefinite polling in the drain function.
> > +		 */
> > +		if (Q_STOP(llq.prod)) {
> > +			local_irq_restore(flags);
> > +			return 0;
> > +		}
> > +
> >  		while (!queue_has_space(&llq, n + sync)) {
> >  			local_irq_restore(flags);
> > +
> > +			/* Avoid waiting for space if the SMMU is suspending */
> > +			if (Q_STOP(READ_ONCE(cmdq->q.llq.prod)))
> > +				return 0;
> > +
> >  			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
> >  				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
> 
> It's a bit grotty to have the extra READ_ONCE() here. Why not make
> arm_smmu_cmdq_poll_until_not_full() return if the stop bit is set?
> 

Sure, it already refreshes llq on every iteration, so I'll make it bail
out on Q_STOP(llq->prod) and have the caller loop on !Q_STOP(llq.prod) &&
!queue_has_space(), leaving a single STOP check right before the cmpxchg.

> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > index deefb17e31eb..794b258550dd 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > @@ -394,6 +394,11 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
> >  #define CMDQ_ERR_CERROR_ATC_INV_IDX	3
> >  
> >  #define CMDQ_PROD_OWNED_FLAG		Q_OVERFLOW_FLAG
> > +#define CMDQ_PROD_STOP_FLAG		(1U << 30)
> 
> I'm unsure about this. Bit 30 of the cmdq prod register is RES0, so it's
> plausible that the architecture allocates that bit for something in future.
> For example, if the index field was extended, then I think that would
> cause problems for the driver.
> 
> Do we have to put the stop flag in the producer value, or can it just be
> a flag elsewhere in memory?
> 

Fair point, but the flag is SW-only, i.e. it's always stripped via
CMDQ_PROD_IDX_MASK before anything reaches the HW and only ever tested
via Q_STOP(). It's the same deal as CMDQ_PROD_OWNED_FLAG, which already
uses bit 31 (also RES0 in SMMU_CMDQ_PROD, IHI0070 section 6.3.27) as a
SW-only marker in llq.prod.

Keeping it in prod is what makes the check + slot reservation atomic in
the cmpxchg.. with a separate flag, a CPU could check it, then suspend 
sets it and samples the target, and the CPU would still reserve slots 
beyond that target.

Thanks,
Praan
