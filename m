Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE244CA263
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031494; cv=none; b=QtBey1gmsLb/85Pv80g3aBXnbJ49hAlYh8TtFoNPd/w+kyYFZmrwBHr85eQFjbzho6p/5W12YLPxLvz7gR70m66rN9CGf/I+lba2VF6W32bhz5sI2YO4W6qyLflQKUV+bA2nm6Wuct65w3/cM5DfYovRMC2xe7+4pvs8nlmb7G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031494; c=relaxed/simple;
	bh=OlHLdVitXUHWnjwq8h1XPF0epQ1r1l0gCYcq4j15TqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNSpwDOBNRbva4UjLNv1fk5mbadybEbBaP1BTVOuNVOnQuRiaIbxtAR1hmIFQiWDIoCbey5SG+izaKOWhrxhoK/jFr9orgq1fe2HcEOl/OVWS07nLYEZ6/7E74IBgqnYTI3L7FUBvFeaIg9GreSYxCfwChfXicrk5/Hi+ueMZL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=so2WJ+XU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="so2WJ+XU"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf2911f93cso471115ad.1
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781031492; x=1781636292; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0R5kWxn+gUs/vySBKBtt/O5HTdoMcXRICPcxZtyyoZM=;
        b=so2WJ+XUCPOCQTAMhTy8aZZ8oREvkNjW9URpnp9iSz6PPzOwRQRUpOK0NUgcY9fjxv
         I28RKdj8MtN6NO1YxCepsh8HOUM3OctLMMKlg85xGMwWqMfHPqku6AWhVMz73S3sZzzx
         IRO7Ck9b/ujUTOx658ZB5W2aafa2aKhiShKNV8FgpaBIEA2ECMg9PSSvarAxt1s7VVDZ
         xDObLjpLDFkGYzmH60u5LI+68mOgHbMqYCSt6u+G+epmyyPX1JUPzeP2LmipzH0xLoQ8
         mVnUNxs+6VjbyovsVO9oKxYozEJdeO7PJsACRlpAbJwnHEOiponPC3yjkJaraxiCkJ5l
         +tzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781031492; x=1781636292;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0R5kWxn+gUs/vySBKBtt/O5HTdoMcXRICPcxZtyyoZM=;
        b=j1OmnJSM1xx+cd+C2M4q72Gd2SsxrQTotuztde5Rjq7Wj/SpP5/hSisoimb39qtcc6
         ojYSg6rvlY+358dQY4zj8FFN150RAyH0GvqcowPODOQFpDmzVuFaT0cVSua+v/MJiUZw
         WqbkL70J7Yx3TWX7rzmeGGydoGXWxLIZ0659ZXoxlc8jXfeBvZl2eeemj9OnUN0glAz6
         T186h9pHFdGBzEMTGxPJR7OHnJjNTRIq7HY0rtWStaM7sETTgZcpn2Z6dlyhQm69k9aV
         GzwDNGjjMPG0UXz4NQw+yIM0Wks31YSzFANxbUyeRQi0IWwu3ofRzRcgwKzQE5jK2rHC
         S4NA==
X-Gm-Message-State: AOJu0YwcL+QgAljeLcYprqzPF/K3GQNZtEbWQ4DYbkDLJqjnK/sU2l8m
	y6fL1GUrQELcvsNMsxru6P2/zyGBCXc+xCgEzI/CTNsaH37Gl97M2e5jMBK+oySk9A==
X-Gm-Gg: Acq92OHE5h0jPcXoLmpowDsajKZ2NMSZmStUZHWNQKwhrcwHyrufQo7adTt+jng03Fm
	ohIeJPbbjkldk91o+diRXsQnSIYQ959qK5EhS7oLIQwkwkcpGr8N3delwoULwdSBEZqxGIljEcS
	1JcvmJx5JVGgK2cNdw4N43rHg4aM5Jd6UlA4QsVjdpmTPcrUWwsSmRp4DFkAPoRm5Z67TZaftbg
	fdJO2Vdw18vguJvT4cPY5lIQYHgIMh4T7T5szu1LzUHRE3FZ0RZ/R89CNmS+yOzrFKZtWJEX4Oe
	OwuswIuHSW4Oy4irCR9ALC2EkfoMRg7amSlzaT2I2sn4bPmQPNU/A/WjPdyERSCdPuMmvzsqiLT
	LKdE29E60zb7+eXYlxR8dnjFrIamX3nRu969M+60jC/NCaBrJId7hjOj2CvXMlWIAURf11UbGIi
	TknIK9xSejWy8/vqFeLvuQyZqz25YVmdK4KSClWSAxAfkvPMY73VPihtisEVQuWYtRC/gT1/w=
X-Received: by 2002:a17:902:e885:b0:2bd:7e8e:ad56 with SMTP id d9443c01a7336-2c1eafba702mr8158095ad.6.1781031491636;
        Tue, 09 Jun 2026 11:58:11 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428221a7e9sm28612027b3a.11.2026.06.09.11.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 11:58:11 -0700 (PDT)
Date: Tue, 9 Jun 2026 18:58:05 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 07/12] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Message-ID: <aihiPQ2mdqMm13Cd@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-8-praan@google.com>
 <CAE2F3rDF5dVJip2gc+vaxtM-FRttnUEnAetUYz6qDCXRM=fNYg@mail.gmail.com>
 <aiZe97OkmvcUwCzS@google.com>
 <CAE2F3rDZupDgq5tQrvpuixGi-kVs+oi-Tacqa=Rxtri03LBPHQ@mail.gmail.com>
 <aiflaI4svEJvZbsC@google.com>
 <CAE2F3rDgXxAhJFUX6=xars9H92t8NBDqcFRxU7d5wJQ7buUbNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rDgXxAhJFUX6=xars9H92t8NBDqcFRxU7d5wJQ7buUbNA@mail.gmail.com>

On Tue, Jun 09, 2026 at 11:20:52AM -0700, Daniel Mentz wrote:
> On Tue, Jun 9, 2026 at 3:05 AM Pranjal Shrivastava <praan@google.com> wrote:
> > >
> > > > Even if the worker CPU reorders the PTE write after the STOP_FLAG check,
> > > > it is benign because the SMMU is incapable of fetching that (or any) PTE
> > > > while the gate is closed. Because GATE_CLOSED == SMMUEN = 0, implying no
> > > > access to any HW structures whatsoever.
> > > >
> > > > The real synchronization happens in the Resume Path:
> > > >
> > > > 1. arm_smmu_device_reset() clears all caches / TLBs.
> > > >    (None of these can have entries before SMMUEN=1)
> > > >
> > > > 2. We execute a full smp_mb() before setting SMMUEN=1. (that's why we
> > > >    need smp_mb before SMMUEN=1). This barrier ensures that any PTE
> > > >    writes made by any thread—including those that were elided while the
> > > >    gate was closed, are globally visible before the SMMU hardware starts
> > > >    fetching into TLBs again. (This is why Jason suggested this in v6 [1])
> > >
> > > A barrier on one CPU has no bearing on whether writes by any other CPU
> > > can be observed by any particular agent in the system.
> > >
> > > Let's compare this with the long comment in
> > > arm_smmu_domain_inv_range() which is what I believe Jason was
> > > referring to. In that example, you see smp_mb() in the code path on
> > > CPU0 and dma_wmb() in the code path on CPU1. Hence, barriers exist on
> > > both sides. If you compare the runtime PM design with
> > > arm_smmu_domain_inv_range(), then smp_mb() belongs in the CPU thread
> > > that performs the translation table updates not the one that performs
> > > the suspend/resume operation.
> > >
> >
> > I might be missing something here, so please bear with me. My
> > understanding it that's needed because the IOMMU is live & actively
> > caching, which is not true for our case.
> 
> I think the "invs" design (Per-domain invalidation array) is more
> similar than you think! An SMMU being absent from invs is equivalent
> to the STOP flag, and the STE pointing to TTB0 is roughly the
> equivalent of SMMEN=1 i.e. the IOMMU is not actively caching a
> particular translation domain until an STE (or CD) points to it.
> 
> > [Assuming we use non-relaxed semantics & ordering for the STOP flag,
> > i.e. set STOP_FLAG + barrier & clear STOP_FLAG (implicit dma_wmb())]
> >
> > In our case, during the resume op, we first clear the STOP_FLAG before
> > setting SMMUEN=1 in program order. Thus, any PTE invalidations occurring
> > before SMMUEN=1 are executed, i.e. EVEN when the SMMU is guaranteed not
> > to access any structures, we've resumed invalidations.
> 
> "[...] we first clear the STOP_FLAG before setting SMMUEN=1 in program
> order." I think this should be modified to "we first clear the
> STOP_FLAG and ensure that the cleared STOP_FLAG is observable by all
> other CPUs before setting SMMUEN=1"
> 

Ack. The goal was to explain the algorithm for this thread, I won't be
commenting it in code. Are you suggesting I should convert my 
explaination of the algorithm above into in-line comments and make sure
to include the STOP_FLAG observability part?

> Re "Thus, any PTE invalidations occurring before SMMUEN=1 are
> executed,": I think that "a PTE invalidation occurring" is not clearly
> defined. Also, it's not clear to me what this statement implies. It's
> paramount that invalidations are performed when SMMUEN=1. The fact
> that we perform invalidations before SMMUEN=1 is more of a side effect
> of our methodology.

By "invalidations occurring before SMMUEN=1", I mean that once the STOP_FLAG
is cleared, any concurrent unmaps (PTE updates) will successfully submit 
invalidation cmds to the cmdq. Since SMMU translation (SMMUEN) is still 
disabled at this point, these invalidations execute safely without racing
against SMMU caching (which was the concern in the previous email).

> 
> I would define a set of invariants:
> 
>  * If an agent observes the STOP flag, it is guaranteed that SMMUEN=0
> (with ABORT set) at the time of observation.
>  * Any transition from a set STOP flag to SMMUEN=1 involves an
> invalidate-all operation prior to setting SMMUEN=1
> 
> Hence, if a CPU observes the STOP flag, it is assured that (a)
> transactions are blocked and (b) if the SMMU is ever re-enabled, an
> invalidate-all is performed prior to it being enabled.
> 
> I would then argue that all operations support these invariants. For
> example, we need proper barriers in the iommu_unmap path to ensure
> that the STOP flag is only checked *after* the translation table
> update is made. Hence, we need a memory barrier.
> 
> I look at it this way: Every elided invalidation creates an
> "invalidation deficit", and this deficit is tolerable for two reasons:
> (a) SMMU blocks all transactions while there is a deficit. (b) An
> invalidate-all eliminates any deficit accrued while the STOP flag was
> set.

Ack, which means you agree with the design proposed in my last reply.
I'll document these invariants in line if that's what you're suggesting
here?

> 
> > Let's consider a few examples:
> >
> > 1. SUSPEND (say CPU0 is suspending)
> >
> > [CPU0] SMMUEN = 0 ==> SMMU stops accessing HW structures (ABORT NOT set)
> 
> I thought we never disable the SMMU unless ABORT is set.

Yes, that is evident from the code [1]. I made a mistake in ordering
while trying to explain why & how this works.

> 
> 
> >                       HW structures not accessed means no TLB / CFG
> >                       cache accesses as well according to the spec.
> >
> > [CPU1] ==> PTE update => Invalidate => Succeeds (although SMMUEN = 0)
> >
> > [CPU0] GBPA.Abort set ==> Txns are blocked
> >
> > [CPU2] => PTE update => Invalidate => Succeeds [Txns blocked + SMMUEN=0]
> >
> > [CPU0] ==> SET STOP_FLAG ==> Elision begins
> >
> > [CPU3] ==> PTE update ==> Invalidation ==> Elided [Txns blocked + SMMUEN=0]
> >
> > Hence, the races in the suspend sequence are handled correctly.
> 
> I'm not sure if this description demonstrates that every possible race
> is handled correctly. If I compare this with Nicolin's presentation in
> arm_smmu_domain_inv_range, I like that presentation, as it explicitly
> mentions loads and barriers. For example, it has an smp_mb() followed
> by "// load the updated invs". I think you should make have something
> like "smp_mb() ; CHECK STOP_FLAG" in your presentation. Currently, the
> STOP_FLAG checking is somehow implicit in "Invalidation".

Ack. The goal of this diagram was to explain the working of the design,
this is NOT the comment/document I plan to include in code. 

I'll add this as an in-line comment if that's what you're suggesting? OR
are you also suggesting I should have this in my cover letter?

> 
> >
> > 2. RESUME (say CPU0 is resuming)
> >
> > [CPU1] ==> Update PTE ==> Invalidate ==> Elided [Txns blocked + SMMUEN=0]
> >
> > [CPU0] ==> Clear STOP_FLAGs [Txns still blocked + SMMUEN=0]
> >
> > [CPU2] ==> Update PTE ==> Invalidate ==> Succeeds [Txns blocked + SMMUEN=0]
> >
> > [CPU0] ==> Invalidate all TLB ==> Succeeds [Txns still blocked + SMMUEN=0]
> > [CPU0] ==> Invalidate all CFG ==> Succeeds [Txns still blocked + SMMUEN=0]
> >
> > [CPU2] ==> Update PTE ==> Invalidate ==> Succeeds [Txns still blocked + SMMUEN=0]
> >
> > [CPU0] ==> Set SMMUEN = 1 [SMMU can now access in memory structures]
> >            However, the TLBs and CFG caches are clean because everything
> >            until this point couldn't have cached anything anyway.
> 
> My concern with this diagram is that it appears sequential, suggesting
> operations happen in a specific order across CPUs when they, in fact,
> occur in parallel. I find these diagrams more useful for describing
> failure cases than for proving that every race is handled correctly.
> 

Ack. Again, the goal was to explain it to you and not propose how the
comments are gonna look like. I'll use your preferred way to explain in
the future.

> >
> > Hence, right after clearing the STOP_FLAG, we're taking in invalidations
> > as normal in the resume, much before the real caching can begin.
> >
> > Thus, by resuming invalidations before SMMUEN=1, we guarantee a
> > consistent state before the very first translation is performed.
> >
> > Apart from this, I guess I'll drop the can_elide check from all
> > invalidation paths.
> >
> > Does that sound fine?
> 
> Dropping can_elide sounds fine. However, if you still use this
> function, for example in the gerror handler, then you might consider
> renaming it.

Ack, I'll name it back to arm_smmu_is_suspended().

Thanks,
Praan
