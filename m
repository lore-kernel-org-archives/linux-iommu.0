Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604A19F135
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 21:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773090815; cv=none; b=jDNSi1+OJvwGcqfOLPDB0G1qZ1wp0m0vR584vjz8CH+7F8m/XTqunegiikMu6tiOaDitScyZ5uDXSP7w7gA3kP3kSC8xjHNU8ir49m32Mhur13uAGUPn4eNqP2q303nSaPFiBBU6TG4EGYFBL2C3/UcixNUTB094q1ILfqz8uks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773090815; c=relaxed/simple;
	bh=IKAKczj63e5T8plZ584BE4vsdPGGqNtRV+I4ItpYqZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oo1GKbdO6JomzMroDR7whKPyCwW8X2aBiq8OpRXDeZILZukxEI6ZkoLULqOwD6hPk4lkbqNLjqYaqJWAi8ymxNuoguLFfKY2tbfo8mErsOvTaPWjKedgXEWs+0F9nygeTodjVBIHRP/aGMqa/CZ6ForzJMDAt4bxdh7AwNBh6zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=afQmC+ES; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="afQmC+ES"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae523d54d2so10785ad.1
        for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 14:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773090813; x=1773695613; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WMZCgTylx/H+zmeDU5PTQEfEZyUolYh7BMpr3mPpNCg=;
        b=afQmC+ESRQnypSkdK4/nhdgDRqni4qetXDgVme9dRV/5k7PMk/AUHz5WNRV7fwXplj
         npfs6Xb+1hhOUG2ZolS3lHZzJzk7gVguA7+mnhZF5ZkqtJwrYPtaHipEWI7mDvBz2Rn7
         0HdgnMaLxBpkIGmnCBYZIEZbPe6QtcEmgXkEFyzlL1tb0Wn4PZSJP/f3UjDKWsqEZQNH
         OD0jQLic5TaJyZkJnYMhV0OlIUFyM7db+m3weMXDPKzDO4x4yMsj3VipOgFQEFCdSx9h
         cGv9mhvIqduCbYVQPYkHRRz4o3QFDtXBcN7p6IJn33vLC4fZbpv66Fiko5z8PgFACL/C
         ryfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773090813; x=1773695613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMZCgTylx/H+zmeDU5PTQEfEZyUolYh7BMpr3mPpNCg=;
        b=kL3kazEyIHbm5Op25YbQWjkpcaHUXQgUh9gXIliOh8iGc/AeWe/jdvzSl7VMYvRXzv
         wZ51Jr4sWt8HFVJ/ucYh6bvcRB2wqh60bDacHuOJgiKHkIcUxVqh1yojONg3jH8J4CpR
         Vzh90vEifHc4i6Ysj1GrZLH13pKEzfvNC9hkeL3z7BoCR0bBiXUc3x9DG2lnaVs4Y4Aa
         Hn0uhB3zov67W7ycXOx22zME4/ZGOxaYKUA+GWgM4BW/qw2awLOopvGePNZh5mZYgH/l
         HjfSwd+HJelgH1KN3+pf5vdC2fnbeKoR4ADH9oZpklcZNfFHBJmaGcocH/OUbB+ypQ5O
         o5fQ==
X-Gm-Message-State: AOJu0Ywzn34PH4CGWncteW8rLcsLIrGK1H4jJb5fLYxQLzuEjWfYkQFN
	Q1c9h7+gCxUnMExnucbvTW6JbGmEPSoklBYgL/1OFK4KrIri7uFj3CuYaCxfesKj3w==
X-Gm-Gg: ATEYQzwf9Tlprwv+vQgB7RwgNEyNuXtYkj5GnjANMnKQ2cAPO534r0QvYumxVOX/Cgx
	xnVvseCY5zdFzNL+LErWGl8bMaI5sJ/fz5RtaKfNbNQbaEvNeeD4dXEMhqWW0bOup7TFsAIKo6R
	f/B5w1/N2AL05Xhb3oQPMutKW6lmbfwJtoHULpEykLO69rsQ7VuHL1S/ba95nhDpDN6TIWNZntF
	MxyorpR6C+MhS8fU9fmaLNjS8Wc0rlPF9kX8j87LeuiNoEJClrVTo0BoPJJRw1K8KBPEgjLvT0x
	3KP58668qWX/8FMoJ2xT9Pb7d32CQV+frkzwlv+y4Fkbu99nO02WMvjnEslLllVR6R1Munja1Om
	iSvZKBtlqM5rHkYjClmcHCZirRySYIT2/KRgiu6W5tpuSezB5S8v0FZzHBzHpVvVCLF2xt1laaJ
	6i2cmIDc01vleIxOMcLV/xAAAQnRZwbKqg/4NWopG6rLhhCRxQDav4McsL6A==
X-Received: by 2002:a17:902:ea04:b0:2a0:7fac:c031 with SMTP id d9443c01a7336-2aea30cfb43mr902745ad.14.1773090812404;
        Mon, 09 Mar 2026 14:13:32 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f8a629sm151715235ad.62.2026.03.09.14.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:13:31 -0700 (PDT)
Date: Mon, 9 Mar 2026 21:13:26 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	Sairaj Kodilkar <sarunkod@amd.com>
Subject: Re: [PATCH v5 06/10] iommu/arm-smmu-v3: Add a usage counter for cmdq
Message-ID: <aa839kz29GIgg_W3@google.com>
References: <20260126151157.3418145-1-praan@google.com>
 <20260126151157.3418145-7-praan@google.com>
 <CAE2F3rD0aoTXJBnS4SPHLEEst6cTvoUxNywRZ1RhdgwNA_0JTA@mail.gmail.com>
 <aa8jkLD0l2WqMnyG@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa8jkLD0l2WqMnyG@google.com>

On Mon, Mar 09, 2026 at 07:46:24PM +0000, Pranjal Shrivastava wrote:
> On Sun, Mar 08, 2026 at 02:23:03PM -0700, Daniel Mentz wrote:
> > On Mon, Jan 26, 2026 at 7:12 AM Pranjal Shrivastava <praan@google.com> wrote:
> > >
> > > Introduce a biased counter to track the number of active cmdq owners as
> > > a preparatory step for the runtime PM implementation.
> > 
> > Non-owners waiting for their CMD_SYNC to be consumed also appear to
> > increase this counter.
> > 
> 
> Ack, I'll clarify that in the commit message too, any owners or
> non-owners waiting on sync would increment this counter.
> 
> > >
> > > The counter will be used to gate command submission, preventing the
> > > submission of new commands while the device is suspended and deferring
> > > suspend while the command submissions are in-flight.
> > 
> > What does command submission mean in this context? I understand that
> > commands are still added to the queue (until the queue is full). It's
> > only the producer index that is not advanced.
> > 
> 
> Exactly, incrementing the "producer index" is how the command is
> actually submitted to the HW. In case the SMMU is suspended, we'd simply
> add it to the queue but not touch the PROD register in the HW. I can
> clarify this further by saying "preventing the flushing of new commands"
> 
> > >
> > > The counter is biased to a value of 1 during device reset. A cmdq owner
> > > or a thread issuing cmds with sync, increment it before accessing HW
> > > registers and decrements it with release semantics afterwards.
> > >
> > > A value of 1 represents an idle (but active) state. A suspend operation
> > > will set it to from 1 -> 0 representing the suspended state.
> > >
> > > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > > ---
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 65 +++++++++++++++++----
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +
> > >  2 files changed, 57 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index 91edcd8922a7..3a8d3c2a8d69 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -805,7 +805,7 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> > >         u64 cmd_sync[CMDQ_ENT_DWORDS];
> > >         u32 prod;
> > >         unsigned long flags;
> > > -       bool owner;
> > > +       bool owner, has_ref = false;
> > >         struct arm_smmu_ll_queue llq, head;
> > >         int ret = 0;
> > >
> > > @@ -819,8 +819,15 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> > >
> > >                 while (!queue_has_space(&llq, n + sync)) {
> > >                         local_irq_restore(flags);
> > > +
> > > +                       if (!atomic_inc_not_zero(&smmu->nr_cmdq_users))
> > > +                               /* Device is suspended, don't wait for space */
> > > +                               return 0;
> > > +
> > 
> > Does this mean that we still accumulate commands until the queue is
> > full while in the suspended state and then have SMMU excecute all of
> > these (now irrelevant) commands when the command queue is re-enabled?
> > One might argue that this is wasteful, but I guess it might be
> > technically correct, because it doesn't hurt either.
> > 
> 
> No, we drop any commands that are issued if the command queue doesn't
> have space while it is suspended. There are two reasons for this:
> 
> 1. The arm_smmu_cmdq_poll_until_not_full below would try to perform an
> MMIO access (read_relaxed(cmdq->q.cons_reg) which shouldn't be allowed
> when the SMMU is suspended.
> 
> 2. We usually have 3 types of commands in the SMMUv3:
> 
>  a) Invalidation commands: We clear the entire TLB during resume, so we
>  don't really need to batch these.
> 
>  b) Prefetch commands: Any prefetches are effectively no-ops as when the
>  SMMU is suspended, the resume would effectively read the latest config
> 
>  c) Page responses: These are NOT expected to occur while the SMMU is
>  suspended and we shouldn't be batching them anyway. (The page resp
>  handlers handle such situations and avoid queueing-in commands anyway
>  with this series)
> 
> Thus, any dropped invalidation / prefetch commands don't harm us if the
> SMMU was suspended.
>  
> 
> > >                         if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
> > >                                 dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
> > > +
> > > +                       atomic_dec_return_release(&smmu->nr_cmdq_users);
> > >                         local_irq_save(flags);
> > >                 }
> > >
> > > @@ -879,10 +886,35 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> > >                 arm_smmu_cmdq_poll_valid_map(cmdq, llq.prod, prod);
> > >
> > >                 /*
> > > -                * d. Advance the hardware prod pointer
> > > +                * d. Advance the hardware prod pointer (if smmu is still active)
> > 
> > Consider "(if command queue is still enabled)". Otherwise, what does
> > "active" mean? SMMU and/or command queue enabled?
> > 
> 
> The suspend callback is implemented in a way where we can't have a
> "partial" suspend, i.e. there is no code path where the CMDQ is disabled
> but the SMMU is not. Thus, "active" was supposed to mean The SMMU is
> enabled entirely since there isn't a partial suspend/resume implemented.
> 
> Although, I can update the comment to say (if smmu is still enabled) OR
> (if smmu is NOT suspended).
> 
> > >                  * Control dependency ordering from the entries becoming valid.
> > >                  */
> > > -               writel_relaxed(prod, cmdq->q.prod_reg);
> > > +               if (atomic_inc_not_zero(&smmu->nr_cmdq_users)) {
> > > +                       writel_relaxed(prod, cmdq->q.prod_reg);
> > > +
> > > +                       if (sync) {
> > > +                               has_ref = true;
> > > +                       } else {
> > > +                               /*
> > > +                                * Use release semantics to enforce ordering without a full barrier.
> > > +                                * This ensures the prior writel_relaxed() is ordered/visible
> > > +                                * before the refcount decrement, avoiding the heavy pipeline
> > > +                                * stall of a full wmb().
> > > +                                *
> > > +                                * We need the atomic_dec_return_release() below and the
> > > +                                * atomic_set_release() in step (e) below doesn't suffice.
> > > +                                *
> > > +                                * Specifically, without release semantics on the decrement,
> > > +                                * the CPU is free to reorder the independent atomic_dec_relaxed()
> > > +                                * before the writel_relaxed().
> > > +                                *
> > > +                                * If this happens, the refcount could drop to zero, allowing the PM
> > > +                                * suspend path (running on another CPU) to disable the SMMU before
> > > +                                * the register write completes, resulting in a bus fault.
> > > +                                */
> > > +                               atomic_dec_return_release(&smmu->nr_cmdq_users);
> > > +                       }
> > > +               }
> > >
> > >                 /*
> > >                  * e. Tell the next owner we're done
> > > @@ -894,14 +926,19 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> > >
> > >         /* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
> > >         if (sync) {
> > > -               llq.prod = queue_inc_prod_n(&llq, n);
> > > -               ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
> > > -               if (ret) {
> > > -                       dev_err_ratelimited(smmu->dev,
> > > -                                           "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
> > > -                                           llq.prod,
> > > -                                           readl_relaxed(cmdq->q.prod_reg),
> > > -                                           readl_relaxed(cmdq->q.cons_reg));
> > > +
> > > +               /* If we are not the owner, check if we're suspended */
> > > +               if (has_ref || atomic_inc_not_zero(&smmu->nr_cmdq_users)) {
> > 
> > Can there be a situation, where we execute this branch and the
> > hardware prod pointer has not been updated, in which case
> > arm_smmu_cmdq_poll_until_sync will wait forever (well, actually, until
> > it times out). Imagine the following series of events:
> >  * nr_cmdq_users==0
> >  * hardware prod pointer update is skipped
> >  * nr_cmdq_users becomes 1
> >  * arm_smmu_cmdq_poll_until_sync waits but commands are not executed
> > by SMMU because hardware prod pointer update wasn't updated
> >  * arm_smmu_device_reset() tries to submit CMDQ_OP_CFGI_ALL, but gets
> > stuck because the queue is full.
> >  * cmdq->q.llq.cons is never updated because the shared lock is held.
> > queue_has_space() returns false, and
> > arm_smmu_cmdq_poll_until_not_full() can't get the exclusive lock
> > 
> 
> Thanks for catching this! IIUC, you mean a race between the resume and
> this code block can cause a deadlock? Something like the following:
> 
> CPU 0					CPU 1
> nr_cmdq_users == 0
> skip hw_prod++
> 					->resume cb
> 					nr_cmdq_user == 1
> nr_cmdq_users == 1
> in the if (sync) part
> arm_smmu_cmdq_poll_until_sync()
> 					CMDQ_OP_CFGI_ALL stuck for space
> 
> I guess we could add a check here if (has_ref == false) but
> nr_cmdq_users > 0, then we could write the prod_reg again.. maybe we'd
> need to factor out a helper function here.. I'll think more about this..
> 
> I guess the simplest thing would be to bail out much before, something
> like if (nr_cmdq_users == 0 && sync) return;
> 
> > > +                       has_ref = true;
> > > +                       llq.prod = queue_inc_prod_n(&llq, n);
> > > +                       ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
> > 
> > If you skip arm_smmu_cmdq_poll_until_sync() in the nr_cmdq_users==0
> > case, I'm thinking that llq.cons is not updated. If this is the case,
> > is the subsequent WRITE_ONCE(cmdq->q.llq.cons, llq.cons); potentially
> > incorrect?
> > 
> 
> The goal here was to "simulate" a successful command submission while 
> the smmu is suspended (as mentioned by Will earlier), we do everything
> except for touching MMIO here. 
> 
> Since the commands can be one of the three types mentioned above, we
> don't really miss out on anything with the faux-cmd submission here.
> 
> Thus, what if we update llq.prod always and set llq.cons == llq.prod
> condtionally if nr_cmdq_users == 0. 
> 
> Ideally, this should also prevent the `queue_full` scenario as all
> commands are faux-issued instantly. Maybe something like:
> 
> if (sync) {                                                               
>       llq.prod = queue_inc_prod_n(&llq, n);                               
>                                                                           
>       if (has_ref || atomic_inc_not_zero(&smmu->nr_cmdq_users)) {
>           if (!has_ref) {  
>               /* Repair: We were suspended earlier but now we're active.
>                * Kick the hardware to publish our commands. */
>               has_ref = true;
> 	      ... owner logic again ...
> 	          ...
>               writel_relaxed(llq.prod, cmdq->q.prod_reg);                 
>           }
>           ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
> 
>            if (ret) {
>                // ...                                      
>            }                                                                   
>        } else {
>            /*
>             * Device is suspended. Fast-forward the consumer pointer in memory 
>             * to "drop" these commands and avoid a full queue deadlock.
> 	    * (n + 1 to include the SYNC command)
>             */        
>            llq.cons = queue_inc_prod_n(&llq, n + 1);
>        }                                               
>                                                                        
>        if (!arm_smmu_cmdq_shared_tryunlock(cmdq)) {
>            WRITE_ONCE(cmdq->q.llq.cons, llq.cons);
>            arm_smmu_cmdq_shared_unlock(cmdq);
>        }
>    }
> 
> This could still be racy.. I'll give it another thought..
> 

Still thinking out loud, but maybe we can have something like:

if (owner) {
	....

	if (atomic_inc_not_zero(&smmu->nr_cmdq_users)) {
		writel_relaxes(llq.prod, cmdq->q.prod_reg);
		has_ref = true;
	} else {

		/* SMMU is suspended, fake a consumption */
		WRITE_ONCE(cmdq->q.llq.cons, prod);

		/* Avoid racing with resume */
		sync = false;
	}

	atomic_set_release(&cmdq->owner_prod, prod);
}

if (sync) {

  ... same stuff ..

}

LMK, what you think?

[ snip ]

Thanks,
Praan
