Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E133563EB
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999537; cv=none; b=jrtlgYaBxgKfmt8Kz88i/gFccxtBa1PHylf0y2sxrRuZildktLL1MiiV9vdYemcPaHKTi3BrE5A3l23v67xsKq85Z578ZIUhSOpBp5fedO/Key+zzc/mm/ihP0XQB2hqtMD1nW7ZbhFRuy+ZLdBrXVlKzIWPWrw99zsoessWAz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999537; c=relaxed/simple;
	bh=jPFXl/BPHiIt6po282vMaey70eXciNSO44Ks5BlIAds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdmWDhYc6abfwzgySujk655FmLMxhWHFNVqmDpr3kRrFyjFETDr1cifbaJLq46J7NUUZLinkpV4ei+pBYdlQ8EhvPcizgPqg5FU5egI0dAenkJPZfZQIl4og7NpmzYpyBFw20aXJqvZFGFuqcTh0Yo4yogb0q9hvXa2uVsssQJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vyiaGOSC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vyiaGOSC"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf22c18ad3so500715ad.0
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 03:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780999535; x=1781604335; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T7M6CFTszd4UFdvsDWYHwLXdTwnBOiMdbIU49lJ8R5U=;
        b=vyiaGOSCfOviQ4VuQaji5GKfcEOtrWN9Qz4KWEOpEsbt11jW7CYeDetflMGle+udyp
         yo1HjRfdSZrMkDq51CIF0yhnnt2SKxV8NMREQNMQHnQalUGO7QnPfBIxzqkTnPuA4GWB
         WLKLmPhwWB9HdmuEup3ko2s9Kw3jUbaNHPPLRqE0FjIlZ/UCBkAGtPwonP919JTekn0a
         4bjsOQJ1m5hFWyT3rjdYJd+pbuZcbZMObceopzL8t9GyiQIxKyYOCpUGJVSFqA8ab4iY
         CFxv1ProiUkilu/QqhwnLtwRoaManMqB8axSvuNoxBRp9dlA/UBBW8udXOmoKrF0AmQo
         62iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780999535; x=1781604335;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7M6CFTszd4UFdvsDWYHwLXdTwnBOiMdbIU49lJ8R5U=;
        b=AfnSKrmF+Og0xA4EmUpMvjuSMsUDqfGCEeB7AbRoOAqrkm6H7lQinC5AefADU8K8BK
         IU+AAVPGQ9pivjwA319BDa62f5FNWNcmRoXj15jgNob/wN8FUUD1EXd5x9XQ05CTr/U3
         wH1lLa6uhOj3ko6bI+NHsEZvCvhXrpfwNtpMTCtzOZBxJPC083Ar9FbzH5LVmPQavPWd
         OfLkp6nFM0jkaSELyAqoMqb2g6WPLe+WAeT+lKKQ2kIpWSJxNA4KtXIYJQSY+/pRV1pI
         vNuT6az6K/63jA8foG8Tb+gNBGLxmHdLzbwtCNmSb3feX3GV0cw09XIBC/gjSZ+a0yWc
         aYqQ==
X-Gm-Message-State: AOJu0YxWiD1TjPSPDuL7ZOPPhq+beo2O71c4XlLAs/ovc7D+7YAQf/iz
	vnvB75WK8XM49+njcUYPSgYXhs/R8sdLmH1tCFHmq49oCI4o4Pa5Z1tIEhzvh3lPvw==
X-Gm-Gg: Acq92OGKYoFaCOqTVn7KSe803nxxh6TXev7UWkxD6xMCfqmxVsy5w1rH2loHBOSipZR
	pYU/U6gcwbprslS0lxFVBg4+WmgG4t/YQ2+XOvU/cmhm7QEad6T27uhKh4x2lLZ5seeDPO+jHOh
	k9S1gS9nrxOO6/DPhYJcCbwPAWRBpTOZk14r+qbbPxsTWt6xQHLtmvXur5Blrl7lrUmGVSKIsUj
	+Wlnk84c8WTYFMS+b4Kq25BIJdS0p3zShmxG2mz2ZsI3Pcw6p9ohLnXd3BjOVG5bknlyRbbQkDi
	80VLNAhPmnDEa8J0Vo6P2rvgYFVzpz0kX+sj61nAU/tSkJxf+Isb8YbkfhUHgBZobIXMotWpgE+
	SHbVZLfgeyk7C3AfejRkLPn9CRZjTdSoltyxOv6OiuPcwCyM43TLhPcJn4AGnjoENWl9DWOn/fA
	GaJJDdiJkYWH5dRTjLskxg8nigG/njZENi2sf6IpCvsQPTtU5OrUsjtlXxvC+A2GGXNiu9E10=
X-Received: by 2002:a17:903:b50:b0:2c1:ee6e:4e4b with SMTP id d9443c01a7336-2c1ee6e51f3mr7229985ad.28.1780999534736;
        Tue, 09 Jun 2026 03:05:34 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828821d0sm20603602b3a.28.2026.06.09.03.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:05:34 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:05:28 +0000
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
Message-ID: <aiflaI4svEJvZbsC@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-8-praan@google.com>
 <CAE2F3rDF5dVJip2gc+vaxtM-FRttnUEnAetUYz6qDCXRM=fNYg@mail.gmail.com>
 <aiZe97OkmvcUwCzS@google.com>
 <CAE2F3rDZupDgq5tQrvpuixGi-kVs+oi-Tacqa=Rxtri03LBPHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rDZupDgq5tQrvpuixGi-kVs+oi-Tacqa=Rxtri03LBPHQ@mail.gmail.com>

On Mon, Jun 08, 2026 at 09:20:42PM -0700, Daniel Mentz wrote:
> On Sun, Jun 7, 2026 at 11:19 PM Pranjal Shrivastava <praan@google.com> wrote:
> > > >
> > > >  static void queue_poll_init(struct arm_smmu_device *smmu,
> > > > @@ -718,8 +719,25 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> > > >         do {
> > > >                 u64 old;
> > > >
> > > > +               /*
> > > > +                * If the SMMU is suspended/suspending, any new CMDs are elided.
> > > > +                * This loop is the Point of Commitment. If we haven't cmpxchg'd
> > > > +                * our new indices yet, we can safely bail. Once the indices are
> > > > +                * committed, we MUST write valid commands to those slots to
> > > > +                * avoid indefinite polling in the drain function.
> > > > +                */
> > > > +               if (Q_STOP(llq.prod)) {
> > > > +                       local_irq_restore(flags);
> > > > +                       return 0;
> > >
> > > On second thought, I no longer believe that this is safe. I understand
> > > that READ_ONCE(cmdq->q.llq.val) implies no ordering guarantees with
> > > respect to any writes to translation tables. In the non-stopped case,
> > > we can rely on the call to dma_wmb() further down in this function.
> > > However, for the stopped case, I can't identify any barriers that
> > > would ensure that the STOP flag is checked only after the writes are
> > > visible to SMMU. Here is an example: Let's assume the following
> > > program order:
> > >
> > >  * Write to invalidate PTE
> > >  * Read from cmdq->q.llq.val, determine STOP flag is set, elide TLBI
> > >
> > > What prevents the CPU from reordering these operations as follows?
> > >
> > >  * Read from cmdq->q.llq.val, determine STOP flag is set, elide TLBI
> > >  * Write to invalidate PTE
> 
> Now, I believe that the smp_mb() call in arm_smmu_domain_inv_range()
> actually prevents this (if we remove arm_smmu_cmdq_can_elide or move
> it to after the smp_mb() call)
> 
> > >
> > > Can the following situation occur?
> >
> > Not really because:
> >
> > >
> > >  * Read from cmdq->q.llq.val, determine STOP flag is set, elide TLBI
> > >  * (Different CPU resumes SMMU)
> >
> > We do a full smp_mb() here to ensure all writes are seen before SMMUEN=1
> > (note that the STOP_FLAG is already unset at that point, so we stop
> > eliding commands much before the SMMU is physically able to access any
> > config/xlation structures, I've explained everything below).
> >
> > >  * SMMU loads old PTE value into TLB
> > >  * Write to invalidate PTE
> > >  * (stale PTE remains in TLB)
> > >
> > > I propose the following: If you find the STOP flag set, run dma_mb()
> > > and check again. I'm afraid that running dma_mb() unconditionally
> > > might incur too much of a performance penalty.
> >
> > IMHO, I think this might be overcomplicating things here..
> > Here's why the current version works according to me:
> >
> > Till SMMUEN=0, the SMMU is spec-guaranteed to never access translation
> > or configuration structures (Section 6.3.9.6).
> >
> > Our runtime_suspend callback sets SMMUEN=0 before setting the STOP_FLAG.
> 
> Does "before" refer to program order or the order in which other
> agents can observe the STOP_FLAG relative to when SMMUEN=0 is set?
> Your program might read "Set SMMUEN=0 then set STOP_FLAG". However, my
> question is whether other observers might see the STOP_FLAG before
> SMMUEN is cleared. I couldn't identify any barriers in
> arm_smmu_runtime_suspend() that would prevent this type of
> re-ordering.

Hmm.. that's right. I guess I was wrongly relying on the fact that 
_relaxed() variants are guaranteed to be ordered amongst themselves on
the same CPU but reading the barriers documentation [1] I see:

These are similar to readX() and writeX(), 
[...] but they are still guaranteed to be ordered with respect to other
accesses from the same CPU thread to the same peripheral when operating
on __iomem pointers mapped with the default I/O attributes.

Hence, it seems it is possible for RAM writes to be re-ordered 
before the writeX_relaxed(MMIO).

In that case, I guess we could just use the non-relaxed version to set
the STOP_FLAG...

> 
> > Even if the worker CPU reorders the PTE write after the STOP_FLAG check,
> > it is benign because the SMMU is incapable of fetching that (or any) PTE
> > while the gate is closed. Because GATE_CLOSED == SMMUEN = 0, implying no
> > access to any HW structures whatsoever.
> >
> > The real synchronization happens in the Resume Path:
> >
> > 1. arm_smmu_device_reset() clears all caches / TLBs.
> >    (None of these can have entries before SMMUEN=1)
> >
> > 2. We execute a full smp_mb() before setting SMMUEN=1. (that's why we
> >    need smp_mb before SMMUEN=1). This barrier ensures that any PTE
> >    writes made by any thread—including those that were elided while the
> >    gate was closed, are globally visible before the SMMU hardware starts
> >    fetching into TLBs again. (This is why Jason suggested this in v6 [1])
> 
> A barrier on one CPU has no bearing on whether writes by any other CPU
> can be observed by any particular agent in the system.
> 
> Let's compare this with the long comment in
> arm_smmu_domain_inv_range() which is what I believe Jason was
> referring to. In that example, you see smp_mb() in the code path on
> CPU0 and dma_wmb() in the code path on CPU1. Hence, barriers exist on
> both sides. If you compare the runtime PM design with
> arm_smmu_domain_inv_range(), then smp_mb() belongs in the CPU thread
> that performs the translation table updates not the one that performs
> the suspend/resume operation.
> 

I might be missing something here, so please bear with me. My 
understanding it that's needed because the IOMMU is live & actively
caching, which is not true for our case.

[Assuming we use non-relaxed semantics & ordering for the STOP flag,
i.e. set STOP_FLAG + barrier & clear STOP_FLAG (implicit dma_wmb())]

In our case, during the resume op, we first clear the STOP_FLAG before
setting SMMUEN=1 in program order. Thus, any PTE invalidations occurring
before SMMUEN=1 are executed, i.e. EVEN when the SMMU is guaranteed not 
to access any structures, we've resumed invalidations. 

Let's consider a few examples:

1. SUSPEND (say CPU0 is suspending)

[CPU0] SMMUEN = 0 ==> SMMU stops accessing HW structures (ABORT NOT set)
		      HW structures not accessed means no TLB / CFG
		      cache accesses as well according to the spec.

[CPU1] ==> PTE update => Invalidate => Succeeds (although SMMUEN = 0)

[CPU0] GBPA.Abort set ==> Txns are blocked

[CPU2] => PTE update => Invalidate => Succeeds [Txns blocked + SMMUEN=0]

[CPU0] ==> SET STOP_FLAG ==> Elision begins

[CPU3] ==> PTE update ==> Invalidation ==> Elided [Txns blocked + SMMUEN=0]

Hence, the races in the suspend sequence are handled correctly.

2. RESUME (say CPU0 is resuming)

[CPU1] ==> Update PTE ==> Invalidate ==> Elided [Txns blocked + SMMUEN=0]

[CPU0] ==> Clear STOP_FLAGs [Txns still blocked + SMMUEN=0]

[CPU2] ==> Update PTE ==> Invalidate ==> Succeeds [Txns blocked + SMMUEN=0]

[CPU0] ==> Invalidate all TLB ==> Succeeds [Txns still blocked + SMMUEN=0]
[CPU0] ==> Invalidate all CFG ==> Succeeds [Txns still blocked + SMMUEN=0]

[CPU2] ==> Update PTE ==> Invalidate ==> Succeeds [Txns still blocked + SMMUEN=0]

[CPU0] ==> Set SMMUEN = 1 [SMMU can now access in memory structures]
	   However, the TLBs and CFG caches are clean because everything
	   until this point couldn't have cached anything anyway.

Hence, right after clearing the STOP_FLAG, we're taking in invalidations
as normal in the resume, much before the real caching can begin.

Thus, by resuming invalidations before SMMUEN=1, we guarantee a 
consistent state before the very first translation is performed.

Apart from this, I guess I'll drop the can_elide check from all 
invalidation paths.

Does that sound fine?

> Actually, now that I think of it: We could just piggy pack on the
> existing smp_mb() in arm_smmu_domain_inv_range(). For your
> arm_smmu_cmdq_can_elide() to work correctly, though, you would need to
> move it to *after* the smp_mb() call. This being said, I would prefer
> to remove arm_smmu_cmdq_can_elide() as I wrote on the other thread.
> If we do take advantage of the existing smp_mb() in
> arm_smmu_domain_inv_range(), then we should probably update that
> comment to state that the runtime PM implementation now also depends
> on it.
> 
> >
> > Adding a dma_mb() to the elision path would be redundant given the
> > SMMU can't access any structures and the resume barrier. We'd be
> > needlessly injecting dma_mbs when no entity is actually accessing those
> > structures while the STOP_FLAG is set.
> > >
> > > I have the same concerns with arm_smmu_cmdq_can_elide(): That
> > > READ_ONCE in arm_smmu_cmdq_can_elide() provides no guarantees in
> > > regards to ordering relative to PTE writes.
> > >
> >
> > The same as above, No structures are accessed during SMMUEN=0 (spec) and
> > during resume before setting SMMUEN=1, we do a full smp_mb() to ensure
> > all concurrent PTE writes are acquired in our resume thread before we
> > enable SMMUEN=1
> 
> I think the definition of "all concurrent PTE writes" is a bit vague.
> I don't think the architecture allows you to wait for writes performed
> by other CPUs to be observable by all other agents. The only thing you
> can do is to ensure that other agents can observe that the STOP_FLAG
> has been cleared *before* SMMUEN is set. However, this is already
> achieved by the existing dma_wmb() in arm_smmu_cmdq_issue_cmdlist().
> Hence, the extra smp_mb() is not required.
> 

Right, I meant that the smp_mb was needed for the STOP_FLAG is visible to
other CPUs performing PTE writes.. but I agree that the first CFGI
invalidation's dma_wmb() would ensure the STOP_FLAG is visible to all 
other CPUs, I'll drop this and add a comment explaining this.

Thanks,
Praan
