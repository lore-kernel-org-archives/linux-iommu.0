Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC4B3FC5BF
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066124; cv=none; b=ZANLowJorZZ68/+OdUK4w46+IGpZ7XERjVPbnktZkSXX6kAkZpLABUSCIXVNwfdBKfrcm9z8F+CO6oVj0Tz3iWzlu/qqOe0iDAD1kCS8fxwxIif8afPdLBX2kiJ0K+fgDPGAnJ4xka6AfniquH1U/CIiUm6PMJYz3FUazzULedI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066124; c=relaxed/simple;
	bh=7GC6ZK+/IW1XiXsDatZ81r0bEX4yT0zf28CIFwYZuRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/qrdyumOAlHm61CNItiL2Av5V2kCZApG5o+qG1l5pwow/WlmbGQI29j9nOIbleQ23b8+5nqbYaiCWasDEp5VH/Zbqt1HJxAvKIrt4T5CHw/YJ+mEvfW5wrkpDAOPBBr1g/+0Ay9XDVzuNoWCraNWRMxhwkYK4UvBvZtCwezhhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JqrP5a2w; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JqrP5a2w"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf2d865383so1945ad.1
        for <iommu@lists.linux.dev>; Fri, 29 May 2026 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066119; x=1780670919; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQnvUAMDcWre1zb+1ZQyKPWolVXCfJctmWLTOardQGc=;
        b=JqrP5a2wQsGSy2t2lJ8MP+AJn0XwjgbAeDMb5dvtk6OoiP5mqNpjrC7dwY1beCMtr0
         y/h8wwoxWnu1bIa8/87kTQLgmMDeSrmR2HrSoom0aJr3SRlAFwa8dqWO0EP3M9Z17ANH
         t7z9ncjKTAV/tI/PskbtfK/vi85UvaR7ZpaJOr69tc1pPeJ4GqSfqCcceJDDHNOCn54X
         uStm9ep6ywF5Fimp6xKuxyOMoMqERu8nqBS+1NneLYUK8KfLj/95cR2R2bUhB0VUzlRX
         LVI4wS9D66QgMigF0Gh5drr6nncvHv5KUR7EfY3vnDSvg1cwwnpXyknLTiJwFYxgyn4n
         qgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066119; x=1780670919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQnvUAMDcWre1zb+1ZQyKPWolVXCfJctmWLTOardQGc=;
        b=aZQEaMmjF9+y2Rw1EKbkzgQPaFLpqvIGJ3tv/pOooVZF4IrmAxR0JEpq6lKIuEIpM7
         hTQVuR4VEK0UqEvo+WqX6/cmELUfdIHRvpzdp14wRNkS8Ximvbapkkc9m6ez0TQeznlc
         D4sKwF8YND/SLGuixth1yVEnyBcOqZE/ehKgpoiTYMMbRNoccArqx3SrfHHoQLofYFE1
         QdvLhXUEXKTNlV/7pa6XaJtQ9jTXW3+uthf66X1tBN9yQ1k/wPrAT/QXFwescpAe4NWA
         mptVAoN2flkC+WGKD3RN7eB1qa3MMAg/r2C3PAKWwvYW8Z7gL6MCb7LO3EGdHOQKLPzh
         aAKA==
X-Gm-Message-State: AOJu0YyjhRifFBFplGnUAvfCMwal/JMGsL9T80/WXkO0aiuimu8FO64T
	Po8F9tbOD+KpU+5WbUvzkLeLdt5j4cDwAIFu8ke+oTUvzvlDRgYWear75QdX6oJWWQ==
X-Gm-Gg: Acq92OGnIpFkOAZb7eaInd5rc41egf5dJdr7x2A/BYZKTUb+IljAZzPslInPeylpjkT
	924XbSG0AVwnyhuMhNCGN2ta3Y3eCp+XbCGlADXRqgzq8Otuau9Gwj2rNOcgIG4oYejM2BSlWqr
	vkIpJNxtro2uuMQjegTNefbm9NglQw6hlZJFRFXYm6HGBnRg3ZVEEQ9WuvRRhucT5XrUxuy8Dp6
	LxDY76E3+5hwSt9DC1B3yCKgg1bbTEoHA32uaffTxVUWPWEsqHLd3j/Xa8IJZCp1fsolAXr2AVh
	j1cgJ7avqoFDaNuZfe/f3FsDiCP6NKh9EPwXC6iN0dUFuB9UmJ37goaza/QK2SrAw3JmGsUoW2E
	fTeInwsVVe+Ch+YfXdh+kRtzXMqkjLf/r3nz1mmxkttne+5gsPY4uAxi1C+oDvLWp74pku3/7jW
	tsvRqMXJ6hV1AYNaNBv1QZO2oi9ZcWem6ZlTiEF065CNN456fB6oiOOBE4T3voOrk8uRMC
X-Received: by 2002:a17:902:f70b:b0:2bd:5fc9:27b9 with SMTP id d9443c01a7336-2bf22e48888mr1870215ad.3.1780066118300;
        Fri, 29 May 2026 07:48:38 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c57283sm22636595ad.81.2026.05.29.07.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 07:48:37 -0700 (PDT)
Date: Fri, 29 May 2026 14:48:32 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 10/11] iommu/arm-smmu-v3: Invoke pm_runtime before hw
 access
Message-ID: <ahmnQN5xatcaF5hT@google.com>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-11-praan@google.com>
 <ahilX8Za1NRCH3ik@Asurada-Nvidia>
 <ahi3uY9YZZtR1Lq5@google.com>
 <ahi7KWov1+GC3xVx@Asurada-Nvidia>
 <ahjAxx-cyww2va__@google.com>
 <ahjNYqe8hjPUQIQD@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahjNYqe8hjPUQIQD@Asurada-Nvidia>

On Thu, May 28, 2026 at 04:18:58PM -0700, Nicolin Chen wrote:
> On Thu, May 28, 2026 at 10:25:11PM +0000, Pranjal Shrivastava wrote:
> > On Thu, May 28, 2026 at 03:01:13PM -0700, Nicolin Chen wrote:
> > > On Thu, May 28, 2026 at 09:46:33PM +0000, Pranjal Shrivastava wrote:
> > > > On Thu, May 28, 2026 at 01:28:15PM -0700, Nicolin Chen wrote:
> > > > > On Wed, May 27, 2026 at 10:14:06PM +0000, Pranjal Shrivastava wrote:
> > > > > > TLB and CFG invalidations are
> > > > > > elided if the SMMU is suspended by observing the CMDQ_PROD_STOP_FLAG via
> > > > > > the arm_smmu_can_elide() helper.
> > > > > 
> > > > > All the arm_smmu_can_elide() call sites here would eventually elide
> > > > > the commands in arm_smmu_cmdq_issue_cmdlist() that is already gated
> > > > > by CMDQ_PROD_STOP_FLAG? It doesn't seem necessary to gate again?
> > > > 
> > > > While issue_cmdlist() would eventually elide these commands, the 
> > > > can_elide() check is necessary to return early during suspension. 
> > > > 
> > > > This avoids unnecessary stack allocation, cmd building, and spinlock
> > > > contention on the cmdq->lock for threads that are anyway about to be 
> > > > elided. 
> > > 
> > > We aren't in the perf sensitive path.. most of those aren't going
> > > to be that bad.
> > > 
> > > arm_smmu_cmdq_shared_lock() on the other hand is taken at step 2,
> > > and the STOP flag in the same function is gated at step 1?
> > 
> > DMA unmaps frequently occur from atomic contexts, interrupt handlers etc
> > Thee Step 1 check in issue_cmdlist() happens under local_irq_save().
> > We may argue that it doesn't happen for long though..
> 
> It shouldn't IMHO. At least most of the call sites in this patch
> are right before calling issue() functions, so they are merely a
> few cycles away from the STOP gate in issue_cmdlist()?
>

I agree that eliding right before calling issue_cmdlist() might seem
like an over-optimization. I guess we had this earlier because we didn't
have ellision in the CMDQ. I'll think more about it (just in case we're
missing some scenario) and try to perf it to confirm there's no big diff

Otherwise, I guess I'll drop the "early-exit" in v8..

> The only place that might be slightly longer is the inv_range(),
> if the domain->invs is really long (e.g. nesting parent for VM),
> in which case, it might be plausible to add a gate. And even with
> that being said, it should be add to the top of the iteration (on
> invs->has_ats) rather than before submit()?
> 

I agree.. but I'm thinking if we plan to remove the early exits, does it
make sense to keep this one? Ideally, we shouldn't be dealing with a
long domain->invs if we are in VMs (IOMMUFD & VFIO both get a pm_ref).
So, I guess if we're dropping elisions from everywhere it would be fine

> > > > By dropping these requests immediately, we significantly reduce cacheline
> > > > bouncing and contention during unmap storms.
> > > 
> > > How significantly, so as to justify invading every command issue()
> > > call site, which would be difficult to maintain? If we really need
> > > an early return, it would be nicer to have a common place at least.
> > 
> > Eliding early is more of an early-exit from the DMA unmap paths really..
> > If maintaining these high-level elision checks at 4 or 5 call sites is
> > a maintenance burden, maybe we could move the logic into the issue_cmd
> > macros? 
> 
> What kinda of macro? Again, if it is added to just a few cycles
> right before issue_cmdlist(), it still wouldn't seem necessary.

I was referring to the arm_smmu_cmdq_issue_cmd* macros here.
But I suppose you're right..

Thanks,
Praan
