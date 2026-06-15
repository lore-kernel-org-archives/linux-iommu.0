Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE5C3AFAF1
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552673; cv=none; b=UIeE3GqId9s1KIlg5iuWQvIUOwMBkN3N6hZKGTWAJqVm2jaVj+DcO57XU7qBBaLxu6rt7GLIbl6SStapHXk06e+hSBstzcUwgchu2vozBjWsgafMskef3xwA4F6T4ksbz0KTXt+rSD6VUx2jX4NW7tOmmhECLOGP0WeV58FDydo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552673; c=relaxed/simple;
	bh=mU9TGcrXhjJvD3EjK2cvkRzwSTPFizwPXPaySuv2AXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOEF0IzhGESCTOdqTPdYnJvzwPO3nOMYBntSXFKFzRku22gWZXJ28srm4lr/+lvZoxGQSpOy+XbwKBBcX15Ek0MSjAWl6k5LyIg1vYUH/mj7lYFBexqa48+YeTkz+2izyjK3V/til54Crhw00c3TKGHflCfEccU49REfwVZp4lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DqheGZay; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DqheGZay"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c67ea316caso2025ad.1
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 12:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781552672; x=1782157472; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+BTW9/C923Dre8fNOzQLPuL2WsbnK1fVP5EdiSCsyk=;
        b=DqheGZay17zkfUvGKEtFAs50Izp8W8HnA7r/+96oFUH5vzMWe3kcrWI5WQsf40BHuY
         IVgrSylfVM8U5X3ABNiegPKu+XI67GtbI6Toz008QeNuRatIdQS1u4xAwXbeVTLDVKzZ
         eMotJj8ljtY8YAsMtIPRtC3nA48aYD5KnkXis6olNG4+Bmryld+goTI6xkMfn8AeUslZ
         sZNxjR8mS1Z/gC+wJB08Yu+OCyRNJs2SOnjsHIxy4frqTxT6bPAyAXeXkSXuX1Yivv8j
         RzqgcleH62v2o995hYutU2CQ8xdpnH7Ml/zHyRuqd+fZzQeGfpwmm4yje2QFgT8A2tvk
         kV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781552672; x=1782157472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+BTW9/C923Dre8fNOzQLPuL2WsbnK1fVP5EdiSCsyk=;
        b=HBMeLY8Ggi7hm0CWZj3HnO6Wq5qNyXRqwhkS9MMxn2eWStLBPMQ6vLCosgxgS7PzlJ
         qm8Ak4WTen6hZmoUYXNNMjmcjMLbTQxArnw8RKg27kCj80R2BDZ7WiYjE+uDipJtA7Fi
         AZP8RNLDhr+gI+99DYLpdownjgNT3y27eyGkyWgwCGYjHqjiqLc2raxw4r05+mc24VfV
         EeqNuuHV5Bnl2we5bGzBlfxWpE31jXHyCrM7w5kaQPZkmoLyFn0cwXH1azXHbrtQxaf4
         0vz54VrR0gWhbTy5/BCCsiOclgjufVN390C5Z2ZkpfDXLkYpSYpClawFQqDvI2wICAne
         HDBA==
X-Gm-Message-State: AOJu0Yy1Mauk2AqhBLpWivYPI1WjGOFtExfC2v/nEvyLjRdnB2MGxLwR
	023+o/xwSoXjwuSrBfLrMzMbe87YfpxOR9mXnI63iZ5dmHEFdw7anxc/41scvtyWmg==
X-Gm-Gg: Acq92OH2wsLT58NLUUfEXx072Se+W0VUHbVnW5Z0gzkxyhuDm3DAzSMTxGy8jcSkxAs
	2YPvDhc2/3Yae/RiITSDp2t9rUqDcQZWV7/sxpTqYn5odO7W9IOEJd63l7OyUhQ5HCWQTp+g2um
	lkUuKNtMlk3MM7ibovyr47ku/xL6Blt6VdUDAmJprepphaQcy3Jw0M+ddhhI/NcscO81cI3e3qn
	hGAOKD6N/oMBH7N6AeHhxrvQQouIwqcCd3a5HHH3Dh8onAavV1TbuUFor0OHvC6mVgGDLtsWzGk
	ZHOyjHZ8loLlLxNpLIf/2t1EbixgoNNQe8UKNrEaM4RsA+LwJQnFTbyLWWvECmYPyUSNjJBQX0g
	aezwzejaSyZjDNGLcTi5H4wOS8fwrC5/K/y1szgajwTlaboG79vKkpIAXmxRWB4nAwwWf1APXkl
	G/QEIfFf/F5umP4kzFl4LRs7njW/xcryEypsKNsv5PCFJCdRkvI6W3DXBU7+rC
X-Received: by 2002:a17:902:e54a:b0:2c1:4a67:5f31 with SMTP id d9443c01a7336-2c69c1d5825mr21705ad.9.1781552671287;
        Mon, 15 Jun 2026 12:44:31 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433558365sm108450835ad.77.2026.06.15.12.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 12:44:30 -0700 (PDT)
Date: Mon, 15 Jun 2026 19:44:25 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 09/12] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <ajBWGSs6RrkRTcSY@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-10-praan@google.com>
 <ajBCazla1VoJX9Ms@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajBCazla1VoJX9Ms@google.com>

On Mon, Jun 15, 2026 at 06:20:27PM +0000, Mostafa Saleh wrote:
> On Mon, Jun 01, 2026 at 09:59:06PM +0000, Pranjal Shrivastava wrote:
> > Implement pm_runtime and system sleep ops for arm-smmu-v3.
> > 
> > The suspend callback configures the SMMU to abort new transactions,
> > disables the main translation unit and then drains the command queue
> > to ensure completion of any in-flight commands. A software gate
> > (STOP_FLAG) and synchronization barriers are used to quiesce the command
> > submission pipeline and ensure state consistency before power-off.
> > 
> > To prevent software metadata flags from leaking into physical registers
> > or polluting the tracking pointer, a newly introduced bitmask
> > (CMDQ_PROD_IDX_MASK) is applied to all register writes and tracking
> > updates.
> > 
> > The resume callback restores the MSI configuration and performs a full
> > device reset via `arm_smmu_device_reset` to bring the SMMU back to an
> > operational state. The MSIs are cached during the msi_write and are
> > restored during the resume operation by using the helper. The STOP_FLAG
> > is cleared only after the CMDQ is enabled in hardware.
> > 
> > Suggested-by: Daniel Mentz <danielmentz@google.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  

[...]

> > +	/* Clear any flags from the previous life */
> > +	atomic_andnot(CMDQ_PROD_STOP_FLAG, &smmu->cmdq.owner_prod);
> > +	atomic_andnot(CMDQ_PROD_STOP_FLAG, &smmu->cmdq.q.llq.atomic.prod);
> 
> Should not that be done from the suspend call?

I'm not sure if I understand? We're just clearing the flag here?
We set the flag in suspend to close the gate and clear it in resume 
to re-open it. Clearing it at the end of suspend would be wrong as it
would allow new submissions while the SMMU is off..

Additionally, I'll remove the redundant operation on owner_prod (since
it's never set in owner_prod) if that's what you're saying?

> 
> > +
> >  	/* Invalidate any cached configuration */
> >  	arm_smmu_cmdq_issue_cmd_with_sync(smmu, arm_smmu_make_cmd_cfgi_all());
> >  
> > @@ -4898,6 +4939,21 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
> >  	if (is_kdump_kernel())
> >  		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
> >  
> > +	/*
> > +	 * While the SMMU was suspended, concurrent CPU threads may have
> > +	 * updated in-memory structures (such as STEs, CDs, and PTEs).
> > +	 * Any invalidations corresponding to those updates were safely
> > +	 * elided because the command queue was stopped (STOP_FLAG == 1).
> > +	 *
> > +	 * Since the reset invalidate-all commands above have fully cleared
> > +	 * the HW TLBs and config caches, the SMMU will fetch these descriptors
> > +	 * directly from RAM as soon as translation is enabled.
> > +	 *
> > +	 * Add a memory barrier to collect all prior RAM writes to ensure the
> > +	 * SMMU sees a consistent view of memory before translation is enabled.
> > +	 */
> > +	smp_mb();
> 
> Should not that be dma_wmb() as this is syncing with the HW?
> 

Right..  as discussed with Daniel on the other thread, the dma_wmb()
inside the issue_cmdlist() already ensures that PTE writes have reached
RAM. I'll update the comments to clarify the barrier design here.

The first CFGI_ALL invalidation we issue on resume uses the CMDQ's 
standard submission path already includes the necessary dma_wmb().
This ensures that the hardware sees the correct state before we set
SMMUEN=1. I'll update the comment to clarify that we are relying on
this existing synchronization rather than adding a redundant barrier.

> > +
> >  	/* Enable the SMMU interface */
> >  	enables |= CR0_SMMUEN;
> >  	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> > @@ -5580,6 +5636,117 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
> >  	arm_smmu_device_disable(smmu);
> >  }
> >  
> > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> > +{
> > +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
> > +	int timeout = ARM_SMMU_SUSPEND_TIMEOUT_US;
> > +	u32 enables, target;
> > +	int ret;
> > +
> > +	/* Abort all transactions before disable to avoid spurious bypass */
> > +	arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> > +
> > +	/* Disable the SMMU via CR0.EN and all queues except CMDQ */
> > +	enables = CR0_CMDQEN;
> > +	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
> > +	if (ret) {
> > +		dev_err(smmu->dev, "failed to disable SMMU\n");
> > +		return ret;
> > +	}
> > +
> > +	/*
> > +	 * At this point the SMMU is completely disabled and won't access
> > +	 * any translation/config structures, even speculative accesses
> > +	 * aren't performed as per the IHI0070 spec (section 6.3.9.6).
> > +	 */
> > +
> > +	/* Mark the CMDQ to stop and get the target index before the stop */
> > +	target = atomic_fetch_or_relaxed(CMDQ_PROD_STOP_FLAG, &cmdq->q.llq.atomic.prod);
> 
> As Daniel mentioned, I think this shouldn't be relaxed.
> 

Ack. I agree, I mis-read the kdoc about this, I'll fix it.

> > +	target &= CMDQ_PROD_IDX_MASK;
> > +
> > +
> > +	/* Wait for the last committed owner to reach the hardware */
> > +	while ((arm_smmu_cmdq_owner_prod_idx(cmdq) != target) && --timeout)
> > +		udelay(1);
> 
> I think --timeout has an off-by-one.
> 

Good catch, I'll fix this!

Thanks,
Praan
