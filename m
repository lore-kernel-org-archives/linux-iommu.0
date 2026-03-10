Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69B13D0924
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773161685; cv=none; b=AOBy5WFRC/KjUW3fgY9/Librd2DoT25WSp3XA2dtDeSBXgdsX2jlKPTEn+JPMQP9U5HfbxEwq9wNFyx+rfm6nyW0ihD46+FqaTjozDscZHVRnAV1PS53So03eCUAjcbA0xn7xeq/W0zufshVdrI8V6kTpDcYx/Zq6HcrPbAqJVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773161685; c=relaxed/simple;
	bh=exZhEjuRnHATZjxHEG4pWWAE1MrhvPVoLBuaCgB3HQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7ya/l0mMsP2jAYm8OUoWmJENjCu/mCaF2cgovkqtKwJvpmo+hL/yUyPiz5Mn7xPs1HI3cx3opZJqstZoPUiGYZ5R6YFSN5rn8aOoK/UzVt2jyY9aHYJxK89NWv4sj+d69/+BbodA7xOCaKXj54q0YEP1Zd/BXpA/iw9PJAjRM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TU5Vy5Cr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TU5Vy5Cr"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ae3f822163so3945ad.0
        for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 09:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773161682; x=1773766482; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3ucN3w/t9QaSUxf6QwnAs0zLML6RQAVhylwUN1uyHyg=;
        b=TU5Vy5CrrEIh7K29vS6VXRu9oO+mRBDqhm8ESfQgKvJBzSFNbOSUYUi0FgEEoa1c8l
         +Xf1ou/GBHvjw85x+Cbwo/0V2z7qZ6Bff6rNC/n6DSCnci4taNcP4EX95oUIxS0BnA+F
         oD8hsOu06N8nOIgF+BHnY5QyWCPRDU/tE26C8x6F0uBhGuQB0u3wJFF6i/C8XC1e8gXH
         zS20Q6qGeke9BE4euYNMeOIcd9spLjWyek/eeNkRCBqOIxpsuDorkP3a2IB3PQSLiBs3
         MmDpNrk+1hbwyQ8LPwO/9V1bXIGbmIhN6iFBzLbD9uemmDmVy2WLhZGB7nS98iYNsjQp
         XsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773161682; x=1773766482;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ucN3w/t9QaSUxf6QwnAs0zLML6RQAVhylwUN1uyHyg=;
        b=S0YWh5vynuPSjViTciRk3jO7vWq6OR3Zxdu6/aJRV9TE0JyQXH56xyVYQMtpXncduv
         3yZGWb6VY6Iqv62OqjXY5uHRNRCySe1XrPFr0hd7PNqSIZm68hQCmAC5VxIfn44ZL1sX
         cVT+Dk9kU54D9aWW5kMf0DjfsKo8cgI87s4blv6vUqfpftPieWLK4ZVVCXkPibzQrYXu
         nGdVt+sqoXrCHU92tV+y963NHwgSqi+9kn8uBb4ciEH3f+corpOVOMTjGcmEOLLvOOUQ
         3iEj53xSSSpE1HM2LRLU9W45wqKB7Hvo26gOvAkzJNBHfEINQE1LDLPc62bd1IS9HI1E
         wx4w==
X-Gm-Message-State: AOJu0YzuKFqUjEVbSYG7Gr+Otf0yxNX3FoHgWn6xGLZxNfFzrKANIWaP
	RPvKHh5AjQoij0dSgrTKfgPCVflbMqgdICEvGsIiVZHYPeltq39vaWhCANTxfTW6WT6HSJvH8ya
	OB48BBFN0
X-Gm-Gg: ATEYQzyIigzZLuC7YymMA0Emmw0Jb9v5a94oJKJHGKVrBdClBb2eZ6dnutsZAqkv0gh
	lICGPkN+L7tPTey2lotS6mN5C4pykyMCZC4YI0mLKfax7hITDxCmoxNt/6L9megOcrK3EeoDEMx
	rqLnWEmMsCS2gvhG5GtteCJK/7fN4hqXStlQxCXSQYQq+dtJav+rhHgKO9dNOIg3g1xGxQtoyyM
	K1n23lLeh/UkfCa2yk29L8iRQ8JGwt5rNmgJqx74y8L5aWh7c+rB6hRLZUxVtrjGH1JETaPAG5O
	MX77etiz8jdO71XLgegsvfaS37IEaI5dD9lryclHcOD7kwEMhtxR42LcEYdZkHAV+Y1jNxHXM8Y
	4HpS06vOq50o9Qh0oNazJoWQXqEzka+eagOcFLfP6+U3YLNNZX9PLMcpXfOgJIO9RzrSmSZNJDE
	iUJZWotnhXTZ/ex3Fz+pF28qjADygDedwEgspAoswxZ0rYcB9iWK8dhpdWAMyjnvSK6vus
X-Received: by 2002:a17:902:e803:b0:2a7:6c4e:5914 with SMTP id d9443c01a7336-2aead2c49b2mr3555ad.6.1773161681161;
        Tue, 10 Mar 2026 09:54:41 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840b2e9dsm207385315ad.85.2026.03.10.09.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 09:54:40 -0700 (PDT)
Date: Tue, 10 Mar 2026 16:54:35 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	Sairaj Kodilkar <sarunkod@amd.com>
Subject: Re: [PATCH v5 06/10] iommu/arm-smmu-v3: Add a usage counter for cmdq
Message-ID: <abBMy5MgrrOlofDF@google.com>
References: <20260126151157.3418145-1-praan@google.com>
 <20260126151157.3418145-7-praan@google.com>
 <CAE2F3rD0aoTXJBnS4SPHLEEst6cTvoUxNywRZ1RhdgwNA_0JTA@mail.gmail.com>
 <aa8jkLD0l2WqMnyG@google.com>
 <CAE2F3rBFRSTC7bFCYTCit1-OKrT3jB-fwYGu_UJbwX+7aE65eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rBFRSTC7bFCYTCit1-OKrT3jB-fwYGu_UJbwX+7aE65eA@mail.gmail.com>

On Mon, Mar 09, 2026 at 03:41:16PM -0700, Daniel Mentz wrote:
> On Mon, Mar 9, 2026 at 12:46 PM Pranjal Shrivastava <praan@google.com> wrote:
> > > > @@ -819,8 +819,15 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> > > >
> > > >                 while (!queue_has_space(&llq, n + sync)) {
> > > >                         local_irq_restore(flags);
> > > > +
> > > > +                       if (!atomic_inc_not_zero(&smmu->nr_cmdq_users))
> > > > +                               /* Device is suspended, don't wait for space */
> > > > +                               return 0;
> > > > +
> > >
> > > Does this mean that we still accumulate commands until the queue is
> > > full while in the suspended state and then have SMMU excecute all of
> > > these (now irrelevant) commands when the command queue is re-enabled?
> > > One might argue that this is wasteful, but I guess it might be
> > > technically correct, because it doesn't hurt either.
> > >
> >
> > No, we drop any commands that are issued if the command queue doesn't
> > have space while it is suspended. There are two reasons for this:
> >
> > 1. The arm_smmu_cmdq_poll_until_not_full below would try to perform an
> > MMIO access (read_relaxed(cmdq->q.cons_reg) which shouldn't be allowed
> > when the SMMU is suspended.
> >
> > 2. We usually have 3 types of commands in the SMMUv3:
> >
> >  a) Invalidation commands: We clear the entire TLB during resume, so we
> >  don't really need to batch these.
> >
> >  b) Prefetch commands: Any prefetches are effectively no-ops as when the
> >  SMMU is suspended, the resume would effectively read the latest config
> >
> >  c) Page responses: These are NOT expected to occur while the SMMU is
> >  suspended and we shouldn't be batching them anyway. (The page resp
> >  handlers handle such situations and avoid queueing-in commands anyway
> >  with this series)
> >
> > Thus, any dropped invalidation / prefetch commands don't harm us if the
> > SMMU was suspended.
> 
> Understood. My point is that we start dropping commands only when the
> command queue fills up, even though we could potentially drop commands
> even earlier.
> 

Hmm.. but how early? Since we also need the bit where we let the next
owner know that the current owner was done..

> > > >                  * Control dependency ordering from the entries becoming valid.
> > > >                  */
> > > > -               writel_relaxed(prod, cmdq->q.prod_reg);
> > > > +               if (atomic_inc_not_zero(&smmu->nr_cmdq_users)) {
> > > > +                       writel_relaxed(prod, cmdq->q.prod_reg);
> > > > +
> > > > +                       if (sync) {
> > > > +                               has_ref = true;
> > > > +                       } else {
> > > > +                               /*
> > > > +                                * Use release semantics to enforce ordering without a full barrier.
> > > > +                                * This ensures the prior writel_relaxed() is ordered/visible
> > > > +                                * before the refcount decrement, avoiding the heavy pipeline
> > > > +                                * stall of a full wmb().
> > > > +                                *
> > > > +                                * We need the atomic_dec_return_release() below and the
> > > > +                                * atomic_set_release() in step (e) below doesn't suffice.
> > > > +                                *
> > > > +                                * Specifically, without release semantics on the decrement,
> > > > +                                * the CPU is free to reorder the independent atomic_dec_relaxed()
> > > > +                                * before the writel_relaxed().
> > > > +                                *
> > > > +                                * If this happens, the refcount could drop to zero, allowing the PM
> > > > +                                * suspend path (running on another CPU) to disable the SMMU before
> > > > +                                * the register write completes, resulting in a bus fault.
> > > > +                                */
> > > > +                               atomic_dec_return_release(&smmu->nr_cmdq_users);
> > > > +                       }
> > > > +               }
> > > >
> > > >                 /*
> > > >                  * e. Tell the next owner we're done
> > > > @@ -894,14 +926,19 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> > > >
> > > >         /* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
> > > >         if (sync) {
> > > > -               llq.prod = queue_inc_prod_n(&llq, n);
> > > > -               ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
> > > > -               if (ret) {
> > > > -                       dev_err_ratelimited(smmu->dev,
> > > > -                                           "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
> > > > -                                           llq.prod,
> > > > -                                           readl_relaxed(cmdq->q.prod_reg),
> > > > -                                           readl_relaxed(cmdq->q.cons_reg));
> > > > +
> > > > +               /* If we are not the owner, check if we're suspended */
> > > > +               if (has_ref || atomic_inc_not_zero(&smmu->nr_cmdq_users)) {
> > >
> > > Can there be a situation, where we execute this branch and the
> > > hardware prod pointer has not been updated, in which case
> > > arm_smmu_cmdq_poll_until_sync will wait forever (well, actually, until
> > > it times out). Imagine the following series of events:
> > >  * nr_cmdq_users==0
> > >  * hardware prod pointer update is skipped
> > >  * nr_cmdq_users becomes 1
> > >  * arm_smmu_cmdq_poll_until_sync waits but commands are not executed
> > > by SMMU because hardware prod pointer update wasn't updated
> > >  * arm_smmu_device_reset() tries to submit CMDQ_OP_CFGI_ALL, but gets
> > > stuck because the queue is full.
> > >  * cmdq->q.llq.cons is never updated because the shared lock is held.
> > > queue_has_space() returns false, and
> > > arm_smmu_cmdq_poll_until_not_full() can't get the exclusive lock
> > >
> >
> > Thanks for catching this! IIUC, you mean a race between the resume and
> > this code block can cause a deadlock? Something like the following:
> >
> > CPU 0                                   CPU 1
> > nr_cmdq_users == 0
> > skip hw_prod++
> >                                         ->resume cb
> >                                         nr_cmdq_user == 1
> > nr_cmdq_users == 1
> > in the if (sync) part
> > arm_smmu_cmdq_poll_until_sync()
> >                                         CMDQ_OP_CFGI_ALL stuck for space
> >
> > I guess we could add a check here if (has_ref == false) but
> > nr_cmdq_users > 0, then we could write the prod_reg again.. maybe we'd
> > need to factor out a helper function here.. I'll think more about this..
> >
> > I guess the simplest thing would be to bail out much before, something
> > like if (nr_cmdq_users == 0 && sync) return;
> 
> On a related note: Can you guarantee that with your current approach,
> nr_cmdq_users drops to 1 even with a high rate of calls to
> arm_smmu_cmdq_issue_cmdlist() from multiple CPUs or will your "/* Try
> to suspend the device, wait for in-flight submissions */" eventually
> time out?
> 
> Have you considered an alternative approach where you put
> 
> if (!atomic_inc_not_zero(&smmu->nr_cmdq_users))
> return 0;
> 
> at the beginning of arm_smmu_cmdq_issue_cmdlist() and an unconditional
> atomic_dec_return_release(&smmu->nr_cmdq_users); at the end? I think
> that would avoid this potential deadlock situation.
> 

Right that's what I meant with "bail out much before", I'll try to think
if that would work always and if there's a situation where it may fail?

> >
> > > I'm still trying to get my head around this algorithm, but accorrding
> > > to my current understanding, the following rule applies:
> > >
> > > Only the cmdq owner may update the hardware prod pointer, and only
> > > after arm_smmu_cmdq_poll_valid_map() returned for the relevant range.
> > > Does the following instruction in arm_smmu_device_reset() violate this
> > > rule?
> > >
> > > writel_relaxed(smmu->cmdq.q.llq.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
> > >
> >
> > Not really as we don't enable the command queue by that point.
> > (but it's still racy as you've mentioned in the queue_full scenario
> > above)
> 
> You're enabling the command queue right after writing to ARM_SMMU_CMDQ_PROD
> 
> /* Command queue */
> writeq_relaxed(smmu->cmdq.q.q_base, smmu->base + ARM_SMMU_CMDQ_BASE);
> writel_relaxed(smmu->cmdq.q.llq.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
> writel_relaxed(smmu->cmdq.q.llq.cons, smmu->base + ARM_SMMU_CMDQ_CONS);
> 
> enables = CR0_CMDQEN;
> ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
>       ARM_SMMU_CR0ACK);
> 
> My point is that writing smmu->cmdq.q.llq.prod to ARM_SMMU_CMDQ_PROD
> is premature. This might lead to the SMMU reading from command slots
> that haven't been fully populated.
> 

Well.. if the smmu->cmdq.q.llq.cons was also updated with the "fake"
consumption logic, then it wouldn't right? 

I agree that the current implementation might have missed a case but
otherwise, this should be fine if both llq.prod & llq.cons are updated
in a balanced manner during the suspend.

> Daniel

Thanks,
Praan
