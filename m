Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807122EEE60
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 06:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780899585; cv=none; b=Cv5ccrzwyhJB4ftNViFDXVVbioI+UD1Ou3juZm6DqbtHCQI57aqL+2RJ3fF5J/qsAUSocHOlF1CSuE/T+urLOcQvBtdKXc5m9XIcAxucvBr6RrNiT2gYwJtUwZNzlLxPawab4kS84RO30nEi1E1gN84j+5TJg0gD8XnSwl2mhJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780899585; c=relaxed/simple;
	bh=TBHZh8wNwOFolGCp7pa1d+H29v6re0bvuz8LIYDaMaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmaK/LwCsEcDOwOE7JOcoEP9FbnuxG9EU1X1PMqhYqJdBvT4jIQBIPCEem9lC2iKncSMiQmEYjM92PiCG/ImTpC30QUA7Cah+VxFE8na5sS9VNSuTlUC8NUxD2v96E3nv/L59Z2l4DnJTIPzZbcT01CqWF8Sj5JwlWY4n7jZeb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FIikNPWl; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FIikNPWl"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-137ff9a7d5eso22841c88.1
        for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 23:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780899583; x=1781504383; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h2DbnJgN+cgPuXB8Z3VAJmWcXw3RxQl5FP2vBSOycvE=;
        b=FIikNPWl3gD8V/aEVEliIB5cLz3zudjg0xKiosKKZBDlCLcwFvLMtzocpsj16U3+fN
         upxLLu/3JJeYb08ywQivaGQpT06+NrXsPEXgL77KcFlqgbYAZQxgYQp8YnGMgmYa8rle
         KTYUbxMmUK+vl1hHyCV70qMn/vd0PQdSPdHxP8msKnwgvV2ciKXgPNKBUXhl8v8Fu5eS
         JC1nD2XdJhb6NQDyTjQz3uzMh4fBzR+1f5hCjU2OKrmYOh14YAEZBBhgSEi8hVB7Rsmh
         9B7qI7YTJfCoNL77KlgHme8ED/77HDAUykVMiNuGrzZpJ2Jytm7Dnf+VdLyJdSZnmdT3
         aXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780899583; x=1781504383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2DbnJgN+cgPuXB8Z3VAJmWcXw3RxQl5FP2vBSOycvE=;
        b=m2AWrDgFNy+m8w4IEkPh794bIcCvytrBDwoesi1y8XR1YxYM1KifrumJ7TYEB0hf5B
         DrBJcJlRCicKeX2BmQ/lyy4gs//g9pRBv0k0JjlVqXvVMaOGIF/PgddOitMjp1PYzbOm
         XJX1MeHtQYd+zYWXs0uybEuNkwlw2WYVV6P1UgxQPRKF3v7ANQHuH3eW1rvN9vq8Wlx/
         ER5K+8uEbjfkZGaKKgoRGXFp6Bnq6eBfwRKG4xMTi3f5fHRSr9PrwvyeJt3R54y3xoKF
         p4O1MWk4xbCKZ7x0ax7dNT9g0mxdsbkezbFBIyyK3OiAbJGz3/I5hCRgHHOVGiCXH13n
         H21A==
X-Gm-Message-State: AOJu0YyN79oGlvlC203k+oU7+xSi/GWZhDU2Sk6xjTcABQaeqBjh5leq
	SitNmWLRgtLA7QY1zh4LoaUZx7ejXSHxTkWhiHPi/Z15Bv3B7mMaSbSONjMGhrarzg==
X-Gm-Gg: Acq92OEzDvnBeJ4YktgFBEG3vEcU1WFqkfzlNapZDmgzz2BnL0vWTmPups4xh+vMEmf
	I2nBzcd1T4bcdTd93+P2cLUFKcflYh7IStUcD6s3sTLZj70JkCm6AU6ISuiKoITbTw3xAojojuC
	msmtBq2jw8Slvg9XolwEoK4/FSKxBNf0IpRFq5ZefjxWpJb78E44P39syjZEDSx4eNRb3p9xwy1
	RLo3qr2sJB8X7As7cDJZcNuIMNKeuFJgKDyl97P24yNqAO2XbwhKUZvtGne2yMl/otdEWPhERZq
	E3TvnOir5Hpg5J5NyiFdFgGMEZ2DblynxZmcyALvM8DxYUDsidj2m306DE30dIxqdpyaPujtIO0
	3crdwnyI7rri1+eKIdGIR9NyYuOklHHSyZ7k7E4Ie7DWtFBDbquNoku8s5dBQWjCaq/nppoRUE5
	RV5vowDMmhxEPKXF26W1giWxdgujPUp1Iu3rz83xQ0dwZDbWpAuLn+wtWMkl838BwEEVuu3SI=
X-Received: by 2002:a05:7022:2585:b0:138:888:e997 with SMTP id a92af1059eb24-1380888eab7mr159227c88.26.1780899581855;
        Sun, 07 Jun 2026 23:19:41 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30777ecf9e9sm10729408eec.28.2026.06.07.23.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:19:41 -0700 (PDT)
Date: Mon, 8 Jun 2026 06:19:35 +0000
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
Message-ID: <aiZe97OkmvcUwCzS@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-8-praan@google.com>
 <CAE2F3rDF5dVJip2gc+vaxtM-FRttnUEnAetUYz6qDCXRM=fNYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rDF5dVJip2gc+vaxtM-FRttnUEnAetUYz6qDCXRM=fNYg@mail.gmail.com>

On Sun, Jun 07, 2026 at 02:42:37PM -0700, Daniel Mentz wrote:
> On Mon, Jun 1, 2026 at 2:59 PM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > Introduce a new bit flag, CMDQ_PROD_STOP_FLAG (bit 30), in the command
> > queue's producer index to safely gate command submissions during device
> > suspension.
> >
> > The flag embeds the suspend state directly into the existing global state
> > The flag checked in the cmpxchg loop in arm_smmu_cmdq_issue_cmdlist(),
> > which acts as a Point of Commitment, ensuring that no indices are
> > reserved or committed once the SMMU begins suspending.
> >
> > This prevents a situation of "abandoned batches" where indices are
> > incremented but commands are never written, which would otherwise
> > lead to timeout during the drain poll.
> >
> > Update queue_inc_prod_n() to preserve this flag during index
> > calculations, ensuring that any in-flight commands that successfully
> > passed the point of commitment can proceed to completion while the
> > flag remains set.

[...]

> >
> >  static void queue_poll_init(struct arm_smmu_device *smmu,
> > @@ -718,8 +719,25 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> >         do {
> >                 u64 old;
> >
> > +               /*
> > +                * If the SMMU is suspended/suspending, any new CMDs are elided.
> > +                * This loop is the Point of Commitment. If we haven't cmpxchg'd
> > +                * our new indices yet, we can safely bail. Once the indices are
> > +                * committed, we MUST write valid commands to those slots to
> > +                * avoid indefinite polling in the drain function.
> > +                */
> > +               if (Q_STOP(llq.prod)) {
> > +                       local_irq_restore(flags);
> > +                       return 0;
> 
> On second thought, I no longer believe that this is safe. I understand
> that READ_ONCE(cmdq->q.llq.val) implies no ordering guarantees with
> respect to any writes to translation tables. In the non-stopped case,
> we can rely on the call to dma_wmb() further down in this function.
> However, for the stopped case, I can't identify any barriers that
> would ensure that the STOP flag is checked only after the writes are
> visible to SMMU. Here is an example: Let's assume the following
> program order:
> 
>  * Write to invalidate PTE
>  * Read from cmdq->q.llq.val, determine STOP flag is set, elide TLBI
> 
> What prevents the CPU from reordering these operations as follows?
> 
>  * Read from cmdq->q.llq.val, determine STOP flag is set, elide TLBI
>  * Write to invalidate PTE
> 
> Can the following situation occur?

Not really because:

> 
>  * Read from cmdq->q.llq.val, determine STOP flag is set, elide TLBI
>  * (Different CPU resumes SMMU)

We do a full smp_mb() here to ensure all writes are seen before SMMUEN=1
(note that the STOP_FLAG is already unset at that point, so we stop
eliding commands much before the SMMU is physically able to access any
config/xlation structures, I've explained everything below).

>  * SMMU loads old PTE value into TLB
>  * Write to invalidate PTE
>  * (stale PTE remains in TLB)
> 
> I propose the following: If you find the STOP flag set, run dma_mb()
> and check again. I'm afraid that running dma_mb() unconditionally
> might incur too much of a performance penalty.

IMHO, I think this might be overcomplicating things here.. 
Here's why the current version works according to me:

Till SMMUEN=0, the SMMU is spec-guaranteed to never access translation
or configuration structures (Section 6.3.9.6). 

Our runtime_suspend callback sets SMMUEN=0 before setting the STOP_FLAG.

Even if the worker CPU reorders the PTE write after the STOP_FLAG check,
it is benign because the SMMU is incapable of fetching that (or any) PTE
while the gate is closed. Because GATE_CLOSED == SMMUEN = 0, implying no
access to any HW structures whatsoever.

The real synchronization happens in the Resume Path:

1. arm_smmu_device_reset() clears all caches / TLBs.
   (None of these can have entries before SMMUEN=1)

2. We execute a full smp_mb() before setting SMMUEN=1. (that's why we
   need smp_mb before SMMUEN=1). This barrier ensures that any PTE 
   writes made by any thread—including those that were elided while the
   gate was closed, are globally visible before the SMMU hardware starts 
   fetching into TLBs again. (This is why Jason suggested this in v6 [1])

Adding a dma_mb() to the elision path would be redundant given the
SMMU can't access any structures and the resume barrier. We'd be
needlessly injecting dma_mbs when no entity is actually accessing those
structures while the STOP_FLAG is set. 
> 
> I have the same concerns with arm_smmu_cmdq_can_elide(): That
> READ_ONCE in arm_smmu_cmdq_can_elide() provides no guarantees in
> regards to ordering relative to PTE writes.
> 

The same as above, No structures are accessed during SMMUEN=0 (spec) and
during resume before setting SMMUEN=1, we do a full smp_mb() to ensure
all concurrent PTE writes are acquired in our resume thread before we
enable SMMUEN=1

Thanks,
Praan

[1] https://lore.kernel.org/all/20260424151639.GE3611611@ziepe.ca/
