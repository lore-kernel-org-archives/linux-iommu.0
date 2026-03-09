Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B00D238C1B
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085593; cv=none; b=ZdEUM5RMxT2Y84XBUZOZgsc2Ie5XiWO+nHEJgvbCZb5JX6DsCq1wQPX5AHkXR+kJTLfRJh7Sob+qcVge2EPHF42zYhNotd7vfuLi1/PmszWWXf+IMByXgAPpmJS//M9QuUzYHJiO2PqOs880J63wfXuCfNAD/R19D69il9iRK68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085593; c=relaxed/simple;
	bh=UD3A6lAas5vIRGWKWKe/qKfDmofMyamsc6XjsUDjK04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q11W/H4YWBHdsjafmVZJpVk0bmMAwQfywsUUvLS02oTbYb7mP5feC4UwZ+GNWgvB5lSF6pr2D0y5e5o/NC/a1xQI+0RicG9Kx73YEYdQvTsr3t68tT1n0bKCsWrjtl8ZOx3htEthIxeO29Vn9JDsIW4sBBE5tcNv+hWszaLNmGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqhDtS4x; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqhDtS4x"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae49120e97so28085ad.0
        for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 12:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773085591; x=1773690391; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XKoz8ym4BVb4IKhg/BYJLcGgQKiJVp7fRx1WC1sp+yQ=;
        b=bqhDtS4xOSgJAiBxOVvfcyaRzoJNSvhpqLp7XhyYhLoJCRrNCzpQxtNlXBbbx31lWA
         Fst5U2w1yts0Kwertw2Fdczhqm6IiZRlE2ScJ+JsBwtbRU0IGnyP7pZTfuD/VXc4AbT5
         ySqOLwJb3Mm0Ooobaus2Df1cUtzlNn6UB8Dkcl2qXSkq0TLn/0KexcZJ3m7RQ4BXydKM
         b/ql4B6Pt1BK413G5BdJAKhGAvAm7H3elY0ItA12z6RMlfs6QGpxSJxk2FwZN/a/KskD
         myYHPP6nArm8nuvvJpx9eywAehdb6QRmnDEkg3BDscNSOSyHeboDWhri17wdoVpRo77h
         tuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773085591; x=1773690391;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKoz8ym4BVb4IKhg/BYJLcGgQKiJVp7fRx1WC1sp+yQ=;
        b=mPuO2J2kK1fLLGZfmMKbl6jHuLlwZ7jVfmQ7ohJ/WJJi3FlrRNeD/IX7zGQZlo7HYL
         1RihCVO4m1xMObOryTknixHzHtJfFHrMAAMaLxIOFCiI4/qFqrAjGkh7gSxGIvLFaeeK
         FHkSz9bnJfzBBVZytGUZmtmRYRszxjeiS0ADKfeuGi4mi6+jQwayl8rnlBxrpxZZbeE4
         QpUSqCEkgPVqI6fm+C1lpdmhQQ32Fvyynq1ilcJGetU8em+rV5y5ngj/PyTABd1iG10a
         q8qjifwMJmOSjzJzA5JVKodkjLwai7tWfkB2dSweM1q2/kqGuQtLsjvOwkTtewvI5GId
         1Cgg==
X-Gm-Message-State: AOJu0YwLAFOpFvfxYXKMzMklQwzCE17ilJoJjgGwXhn7ewtv9nDf9n6P
	VLyXcEKvlzELjJc+Vb5U8IVowFaVMl3GzhhZPRgKQu4r48jdKHx98dRu8N9+5JmgXQ==
X-Gm-Gg: ATEYQzyU+tDYSamWI3YwqWHjMPlbaWAN/2omWyLjFKpA3/2HCz/6lLc1l8lmR9he4Yt
	oSO3Fl90whe+g+sXDDA0DJmwchKrz9fSxHf+YIdSy32U8z3G6ktiep398/WyQ0N2JIYlDqThSjk
	fuhrkkjb6kbYwBpsIhuWmLARofA5oUSof+qKX/F66b8glKOxcydwT78u+TafYkMgZaCXlGVkQr5
	0EulRDp06zj7nyqqDTAv4yFfGIl3IWEXo6t0k8DsCq0H3oxA2MAuuJQdwn2251/6bkuthPfzSwO
	vtmbgi7gb2YBy89zDgaKU1QS+8q1TiV6fVW4+ZAI8+2wxNwmQibjugdx8Zpa8MDuyQYw2vnsXyC
	Irzf3wwdwN2bETeE9wGmv26eB/BdKl+ig6L0J1lEC9EWv4u0s62ru4fJ7YEO5XFpEn19qay+KD9
	Ax47BQ5JpmJ5Aj260QnGNTMsnuUaxZM7gaI2n3+TWAyazP/iHlZlCWSfcGHQ==
X-Received: by 2002:a17:903:1cd:b0:2a9:5bfa:54ef with SMTP id d9443c01a7336-2aea30349femr723355ad.10.1773085590624;
        Mon, 09 Mar 2026 12:46:30 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4635d62sm11505177b3a.5.2026.03.09.12.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 12:46:30 -0700 (PDT)
Date: Mon, 9 Mar 2026 19:46:24 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	Sairaj Kodilkar <sarunkod@amd.com>
Subject: Re: [PATCH v5 06/10] iommu/arm-smmu-v3: Add a usage counter for cmdq
Message-ID: <aa8jkLD0l2WqMnyG@google.com>
References: <20260126151157.3418145-1-praan@google.com>
 <20260126151157.3418145-7-praan@google.com>
 <CAE2F3rD0aoTXJBnS4SPHLEEst6cTvoUxNywRZ1RhdgwNA_0JTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rD0aoTXJBnS4SPHLEEst6cTvoUxNywRZ1RhdgwNA_0JTA@mail.gmail.com>

On Sun, Mar 08, 2026 at 02:23:03PM -0700, Daniel Mentz wrote:
> On Mon, Jan 26, 2026 at 7:12 AM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > Introduce a biased counter to track the number of active cmdq owners as
> > a preparatory step for the runtime PM implementation.
> 
> Non-owners waiting for their CMD_SYNC to be consumed also appear to
> increase this counter.
> 

Ack, I'll clarify that in the commit message too, any owners or
non-owners waiting on sync would increment this counter.

> >
> > The counter will be used to gate command submission, preventing the
> > submission of new commands while the device is suspended and deferring
> > suspend while the command submissions are in-flight.
> 
> What does command submission mean in this context? I understand that
> commands are still added to the queue (until the queue is full). It's
> only the producer index that is not advanced.
> 

Exactly, incrementing the "producer index" is how the command is
actually submitted to the HW. In case the SMMU is suspended, we'd simply
add it to the queue but not touch the PROD register in the HW. I can
clarify this further by saying "preventing the flushing of new commands"

> >
> > The counter is biased to a value of 1 during device reset. A cmdq owner
> > or a thread issuing cmds with sync, increment it before accessing HW
> > registers and decrements it with release semantics afterwards.
> >
> > A value of 1 represents an idle (but active) state. A suspend operation
> > will set it to from 1 -> 0 representing the suspended state.
> >
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 65 +++++++++++++++++----
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +
> >  2 files changed, 57 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 91edcd8922a7..3a8d3c2a8d69 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -805,7 +805,7 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> >         u64 cmd_sync[CMDQ_ENT_DWORDS];
> >         u32 prod;
> >         unsigned long flags;
> > -       bool owner;
> > +       bool owner, has_ref = false;
> >         struct arm_smmu_ll_queue llq, head;
> >         int ret = 0;
> >
> > @@ -819,8 +819,15 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> >
> >                 while (!queue_has_space(&llq, n + sync)) {
> >                         local_irq_restore(flags);
> > +
> > +                       if (!atomic_inc_not_zero(&smmu->nr_cmdq_users))
> > +                               /* Device is suspended, don't wait for space */
> > +                               return 0;
> > +
> 
> Does this mean that we still accumulate commands until the queue is
> full while in the suspended state and then have SMMU excecute all of
> these (now irrelevant) commands when the command queue is re-enabled?
> One might argue that this is wasteful, but I guess it might be
> technically correct, because it doesn't hurt either.
> 

No, we drop any commands that are issued if the command queue doesn't
have space while it is suspended. There are two reasons for this:

1. The arm_smmu_cmdq_poll_until_not_full below would try to perform an
MMIO access (read_relaxed(cmdq->q.cons_reg) which shouldn't be allowed
when the SMMU is suspended.

2. We usually have 3 types of commands in the SMMUv3:

 a) Invalidation commands: We clear the entire TLB during resume, so we
 don't really need to batch these.

 b) Prefetch commands: Any prefetches are effectively no-ops as when the
 SMMU is suspended, the resume would effectively read the latest config

 c) Page responses: These are NOT expected to occur while the SMMU is
 suspended and we shouldn't be batching them anyway. (The page resp
 handlers handle such situations and avoid queueing-in commands anyway
 with this series)

Thus, any dropped invalidation / prefetch commands don't harm us if the
SMMU was suspended.
 

> >                         if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
> >                                 dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
> > +
> > +                       atomic_dec_return_release(&smmu->nr_cmdq_users);
> >                         local_irq_save(flags);
> >                 }
> >
> > @@ -879,10 +886,35 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> >                 arm_smmu_cmdq_poll_valid_map(cmdq, llq.prod, prod);
> >
> >                 /*
> > -                * d. Advance the hardware prod pointer
> > +                * d. Advance the hardware prod pointer (if smmu is still active)
> 
> Consider "(if command queue is still enabled)". Otherwise, what does
> "active" mean? SMMU and/or command queue enabled?
> 

The suspend callback is implemented in a way where we can't have a
"partial" suspend, i.e. there is no code path where the CMDQ is disabled
but the SMMU is not. Thus, "active" was supposed to mean The SMMU is
enabled entirely since there isn't a partial suspend/resume implemented.

Although, I can update the comment to say (if smmu is still enabled) OR
(if smmu is NOT suspended).

> >                  * Control dependency ordering from the entries becoming valid.
> >                  */
> > -               writel_relaxed(prod, cmdq->q.prod_reg);
> > +               if (atomic_inc_not_zero(&smmu->nr_cmdq_users)) {
> > +                       writel_relaxed(prod, cmdq->q.prod_reg);
> > +
> > +                       if (sync) {
> > +                               has_ref = true;
> > +                       } else {
> > +                               /*
> > +                                * Use release semantics to enforce ordering without a full barrier.
> > +                                * This ensures the prior writel_relaxed() is ordered/visible
> > +                                * before the refcount decrement, avoiding the heavy pipeline
> > +                                * stall of a full wmb().
> > +                                *
> > +                                * We need the atomic_dec_return_release() below and the
> > +                                * atomic_set_release() in step (e) below doesn't suffice.
> > +                                *
> > +                                * Specifically, without release semantics on the decrement,
> > +                                * the CPU is free to reorder the independent atomic_dec_relaxed()
> > +                                * before the writel_relaxed().
> > +                                *
> > +                                * If this happens, the refcount could drop to zero, allowing the PM
> > +                                * suspend path (running on another CPU) to disable the SMMU before
> > +                                * the register write completes, resulting in a bus fault.
> > +                                */
> > +                               atomic_dec_return_release(&smmu->nr_cmdq_users);
> > +                       }
> > +               }
> >
> >                 /*
> >                  * e. Tell the next owner we're done
> > @@ -894,14 +926,19 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> >
> >         /* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
> >         if (sync) {
> > -               llq.prod = queue_inc_prod_n(&llq, n);
> > -               ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
> > -               if (ret) {
> > -                       dev_err_ratelimited(smmu->dev,
> > -                                           "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
> > -                                           llq.prod,
> > -                                           readl_relaxed(cmdq->q.prod_reg),
> > -                                           readl_relaxed(cmdq->q.cons_reg));
> > +
> > +               /* If we are not the owner, check if we're suspended */
> > +               if (has_ref || atomic_inc_not_zero(&smmu->nr_cmdq_users)) {
> 
> Can there be a situation, where we execute this branch and the
> hardware prod pointer has not been updated, in which case
> arm_smmu_cmdq_poll_until_sync will wait forever (well, actually, until
> it times out). Imagine the following series of events:
>  * nr_cmdq_users==0
>  * hardware prod pointer update is skipped
>  * nr_cmdq_users becomes 1
>  * arm_smmu_cmdq_poll_until_sync waits but commands are not executed
> by SMMU because hardware prod pointer update wasn't updated
>  * arm_smmu_device_reset() tries to submit CMDQ_OP_CFGI_ALL, but gets
> stuck because the queue is full.
>  * cmdq->q.llq.cons is never updated because the shared lock is held.
> queue_has_space() returns false, and
> arm_smmu_cmdq_poll_until_not_full() can't get the exclusive lock
> 

Thanks for catching this! IIUC, you mean a race between the resume and
this code block can cause a deadlock? Something like the following:

CPU 0					CPU 1
nr_cmdq_users == 0
skip hw_prod++
					->resume cb
					nr_cmdq_user == 1
nr_cmdq_users == 1
in the if (sync) part
arm_smmu_cmdq_poll_until_sync()
					CMDQ_OP_CFGI_ALL stuck for space

I guess we could add a check here if (has_ref == false) but
nr_cmdq_users > 0, then we could write the prod_reg again.. maybe we'd
need to factor out a helper function here.. I'll think more about this..

I guess the simplest thing would be to bail out much before, something
like if (nr_cmdq_users == 0 && sync) return;

> > +                       has_ref = true;
> > +                       llq.prod = queue_inc_prod_n(&llq, n);
> > +                       ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
> 
> If you skip arm_smmu_cmdq_poll_until_sync() in the nr_cmdq_users==0
> case, I'm thinking that llq.cons is not updated. If this is the case,
> is the subsequent WRITE_ONCE(cmdq->q.llq.cons, llq.cons); potentially
> incorrect?
> 

The goal here was to "simulate" a successful command submission while 
the smmu is suspended (as mentioned by Will earlier), we do everything
except for touching MMIO here. 

Since the commands can be one of the three types mentioned above, we
don't really miss out on anything with the faux-cmd submission here.

Thus, what if we update llq.prod always and set llq.cons == llq.prod
condtionally if nr_cmdq_users == 0. 

Ideally, this should also prevent the `queue_full` scenario as all
commands are faux-issued instantly. Maybe something like:

if (sync) {                                                               
      llq.prod = queue_inc_prod_n(&llq, n);                               
                                                                          
      if (has_ref || atomic_inc_not_zero(&smmu->nr_cmdq_users)) {
          if (!has_ref) {  
              /* Repair: We were suspended earlier but now we're active.
               * Kick the hardware to publish our commands. */
              has_ref = true;
	      ... owner logic again ...
	          ...
              writel_relaxed(llq.prod, cmdq->q.prod_reg);                 
          }
          ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);

           if (ret) {
               // ...                                      
           }                                                                   
       } else {
           /*
            * Device is suspended. Fast-forward the consumer pointer in memory 
            * to "drop" these commands and avoid a full queue deadlock.
	    * (n + 1 to include the SYNC command)
            */        
           llq.cons = queue_inc_prod_n(&llq, n + 1);
       }                                               
                                                                       
       if (!arm_smmu_cmdq_shared_tryunlock(cmdq)) {
           WRITE_ONCE(cmdq->q.llq.cons, llq.cons);
           arm_smmu_cmdq_shared_unlock(cmdq);
       }
   }

This could still be racy.. I'll give it another thought..

> I'm still trying to get my head around this algorithm, but accorrding
> to my current understanding, the following rule applies:
> 
> Only the cmdq owner may update the hardware prod pointer, and only
> after arm_smmu_cmdq_poll_valid_map() returned for the relevant range.
> Does the following instruction in arm_smmu_device_reset() violate this
> rule?
> 
> writel_relaxed(smmu->cmdq.q.llq.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
> 

Not really as we don't enable the command queue by that point.
(but it's still racy as you've mentioned in the queue_full scenario
above)

> I'm wondering if we should just set ARM_SMMU_CMDQ_PROD to
> smmu->cmdq.q.llq.cons and then have the next owner update the hardware
> prod pointer.

Hmm.. what if we ensure that the cmdq.q.llq.prod == cons instead? I
guess that would be racy though?

Thanks,
Praan
