Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A09239DBE9
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673556; cv=none; b=WvpM7lbQytXiRYLMthCDPWSVRjVHVFOGJWIVJcQVmDbiu/aq+uy3YSTwNgCJmngowZ5hUzqbujvDztdat9gNLDKfyld7y1Cf5a4N1zauzBRuwN2+Y4Lq3rWVdN3LFXfg1dO0ye3wtWFaqaaYIBHsQWgTYuv18dqanNutDBSXR4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673556; c=relaxed/simple;
	bh=Z4s5dtEGOoEmpzQeNO1KVvK9TGCd/lAcGk6lh3Du2WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFsmp5ZdsNy7ufUpmjPutx+ndsk9ZCLX5o+wnKJEg6AWaFGlbDmsWCaTRM18CySf6A1fjI9+u78G7Y1jgdmSNivQZKsvK9+r3FOPYoiLANjMtx6a1AhL9RfxwaJrUOBHMiHEoDJFYlu+PLwMeI6Qajy3L+gbxyIQEyGec+eityo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vkNse1QT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vkNse1QT"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b052ec7176so87675ad.1
        for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773673555; x=1774278355; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZZVCuEA5qFAnKH4I9t4bNEz6kw6E/L+PFh/VXdbuE3w=;
        b=vkNse1QTM5nolS8S8vpeS4VHMLHSnh44Z6ej/YIfsTHf8LQtKYB1k7sMwh5noPUqyg
         +Z2f1ThDLZXNWvdnQRrhNSVkFAevn3r7NID+Kaws5s3Rnx/G8XyyDvBe5QqUrDh4+RBl
         lz5OPhvC9Wjuyz2pVvcGnTbrks42z+4yfC1RYPIE0s3Bqfulfs1aEXExExQswvcmJ7aF
         tlaCBuNCG0PQ+ag556UWWtR9wGOiOV/itQSQO5fLUfcA/RU0VX2xZH1gG7vPqL4y/HXk
         pHBwpcFGA8xNK92p5W5roSq14mQZ68je37YB6ETRY+0r6f114JV42GWUIofQZayVhA/w
         xd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773673555; x=1774278355;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZVCuEA5qFAnKH4I9t4bNEz6kw6E/L+PFh/VXdbuE3w=;
        b=BDNd22FEnyVzkSA/Yq0liDPn3mdMmnnEWY2Xv46WI5CHipVhgY6v/vBC2tZRjJNMRA
         jyfcYUdqotW636MFjpeaNjoPG6yPyVJ8CQfqGXz/tWeizjmLCLHBCx2ShbkvgIgb7PbK
         vquFSZyJinsWK+7g1jS8ha2318sGqrNW4+ievyGgfa9esGefZ2BhT8yePD5Lbzz/ifc1
         uWhw1IT7zNIZ9LhFMXgTGNYc9JkpBIn1DEfPdrFlAP/PJzP1pHWhsfDizAnC3yVC9Sgp
         gsN9/Z6sdlbxR3MtpvGbOKOjk6bcb8nT7Rl1lJKs+6Stee31MMKtFXKPUy8IUcqfijz/
         AT9g==
X-Gm-Message-State: AOJu0Yzcdo2hNuRrgrPxwYfWcq3Ke/Ep6lCq2Tg36ZTbgCJ3tmQJ2O7v
	+X4uC/vjrIomZds8d1vgmcHXfjry4NWpfPk+KolOb09Ta1zr/3vm7SJvfXvhCt0wxQ==
X-Gm-Gg: ATEYQzyUFyZhRMCKzho3Sm38K3/ZfiqetqffjeoSML4Nd3MvF+3t0obwlTk9JjpUdIx
	lGHJsGK5Dc8GtqjPieBGJpFR39d38VHYzfrF0dAMsKeXC43g6TC8x8Jji7yMuKBNRJJlvyxYeeI
	SXMpvuvOzpBYjsFDlm193rnV1eaRdqAvOU9RkEhYdvOz5Y9rwI0HAvD5hZXHNmFtaoT/edYIduZ
	Z/HynYtk/LXnxqaAyOHU/pnACTQ0Tv7Bg0YWuLc0U8iNWvFwZYgJjaMTzlpwYsSWQpPDwJthtxq
	NY7zsl7cPIM4cYh6PhLaAnm4vayHBDqmLeUbvHdxuE7rE9ptpoJ25YTBe8cRFc4EerdBfAuXl2S
	RpN478AIuT4eXn5W4PU/gDiOwt9aKRAiciRLG/BL8HmxnFycyU9bWzhyS/dP7CAaohNX8S3xMyX
	kko/fZLz1qpNdgL+rUUjQ4t7y84YgPJgXuP2zVZSzLbO55TaZZ/U62/JHFW9CsbO2f4nu+
X-Received: by 2002:a17:903:18e:b0:2b0:5b4c:a439 with SMTP id d9443c01a7336-2b05b4ca5a0mr2019665ad.2.1773673554117;
        Mon, 16 Mar 2026 08:05:54 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0736590fsm14141191b3a.43.2026.03.16.08.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:05:52 -0700 (PDT)
Date: Mon, 16 Mar 2026 15:05:48 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	Sairaj Kodilkar <sarunkod@amd.com>
Subject: Re: [PATCH v5 07/10] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <abgcTNwfv45A0BSW@google.com>
References: <20260126151157.3418145-1-praan@google.com>
 <20260126151157.3418145-8-praan@google.com>
 <CAE2F3rD-rEpizTpc1fo7Y8fXZfZCF2TGUz8H86rUY6RzTWQDQA@mail.gmail.com>
 <abBNwXk2a8v6Zgbw@google.com>
 <CAE2F3rAqyX_CQaN2Wt2=uTYJqYUV3nbrfmog0YyvPr4pgYU5xQ@mail.gmail.com>
 <abCP0wLkVvUSUeYI@google.com>
 <CAE2F3rDbB4RgZLfqKu=AeGdJU6TLdmO=XTCzCb1-yq7VKH0zdw@mail.gmail.com>
 <abD-Kl0xkfg4tsh4@google.com>
 <CAE2F3rAUfU0+y2C3ro=ApShugU9ujDxnWx3bigZ2wo89xnzvbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rAUfU0+y2C3ro=ApShugU9ujDxnWx3bigZ2wo89xnzvbw@mail.gmail.com>

On Wed, Mar 11, 2026 at 10:26:49AM -0700, Daniel Mentz wrote:
> On Tue, Mar 10, 2026 at 10:31 PM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Tue, Mar 10, 2026 at 05:12:15PM -0700, Daniel Mentz wrote:
> > > On Tue, Mar 10, 2026 at 2:40 PM Pranjal Shrivastava <praan@google.com> wrote:
> > > >
> > > > On Tue, Mar 10, 2026 at 02:16:31PM -0700, Daniel Mentz wrote:
> > > > > On Tue, Mar 10, 2026 at 9:58 AM Pranjal Shrivastava <praan@google.com> wrote:
> > > > > >
> > > > > > On Mon, Mar 09, 2026 at 06:45:09PM -0700, Daniel Mentz wrote:
> > > > > > > On Mon, Jan 26, 2026 at 7:12 AM Pranjal Shrivastava <praan@google.com> wrote:
> > > > > > > >
> > > > > > > > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> > > > > > > > +{
> > > > > > > > +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > > > > > > > +       int timeout = ARM_SMMU_SUSPEND_TIMEOUT_US;
> > > > > > > > +       u32 enables;
> > > > > > > > +       int ret;
> > > > > > > > +
> > > > > > > > +       /* Try to suspend the device, wait for in-flight submissions */
> > > > > > > > +       do {
> > > > > > > > +               if (atomic_cmpxchg(&smmu->nr_cmdq_users, 1, 0) == 1)
> > > > > > >
> > > > > > >
> > > > > > > I understand we must follow the rule: do not elide any invalidations
> > > > > > > while SMMU is still enabled. Otherwise, the following sequence of
> > > > > > > events might occur:
> > > > > > >  * The driver clears a table descriptor
> > > > > > >  * The TLBI command is skipped
> > > > > > >  * The driver frees the page that backed the translation table
> > > > > > >  * The page is re-allocated for some unrelated purpose
> > > > > > >  * SMMU performs a table walk and then descends into the page that has
> > > > > > > been reallocated, misinterpreting its contents.
> > > > > > >
> > > > > > > Can you disable SMMU before setting nr_cmdq_users to 0?
> > > > > > >
> > > > > >
> > > > > > No, that'd be racy, if I disable the smmu but nr_cmdq_users != 0 an
> > > > > > "owner" thread might believe that the SMMU is still functional and poll
> > > > > > for consumption.
> > > > >
> > > > > I assume that SMMU still processes commands if SMMU_CR0.SMMUEN is
> > > > > cleared but SMMU_CR0.CMDQEN is set. The arch spec reads: "When
> > > > > translation is not enabled for a Security state, an SMMU: [...] Can
> > > > > process commands after the relevant queue pointers are initialized and
> > > > > SMMU_(*_)CR0.CMDQEN is enabled." Also, the sequence described under
> > > > > "Arm recommends that software initializing the SMMU performs the
> > > > > following steps:" suggests this behavior. The existing driver code
> > > > > also relies on this when it runs CMDQ_OP_CFGI_ALL before setting
> > > > > SMMU_CR0.SMMUEN.
> > > > >
> > > > > >
> > > > > > I don't think that the SMMU would perform a walk as we first set the
> > > > > > nr_cmdq_users == 0 to stop command submissions and then immediately set
> > > > > > GBPA to abort. IF a command submission raced with this, we wait for the
> > > > >
> > > > > To ensure we're on the same page: Setting SMMU_GBPA.ABORT doesn't do
> > > > > anything while SMMU_CR0.SMMUEN is set. SMMU_GBPA only plays a role if
> > > > > SMMU_CR0.SMMUEN is cleared.
> > > > >
> > > >
> > > > I think you're missing that we *DO* actually set SMMUEN = 0 *with* the
> > > > GBPA abort, please look at this part of the patch:
> > > >
> > > > +       /* Abort all transactions before disable to avoid spurious bypass */
> > > > +       arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> > > > +
> > > > +       /* Disable the SMMU via CR0.EN and all queues except CMDQ */
> > > > +       enables = CR0_CMDQEN;
> > > > +       ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
> > > > +       if (ret) {
> > > > +               dev_err(smmu->dev, "Timed-out while disabling smmu\n");
> > > > +               atomic_set(&smmu->nr_cmdq_users, 1);
> > > > +               return ret;
> > > > +       }
> > > >
> > > > We disable everything except for the CMDQ. Since, everything is disabled
> > > > at this point, any new commands can safely be elided as the SMMU won't
> > > > access any config structures as mentioned by the spec.
> > > >
> > > > > The moment you set nr_cmdq_users == 0, you potentially start eliding
> > > > > TBLIs which means that the TLB entries are at risk of becoming stale.
> > > >
> > > > Not really, the SMMU isn't accessing anything since SMMUEN=0 and GBPA is
> > > > set by this point.
> > >
> > > I believe you are assuming that all these things happen atomically
> > > when they, in fact, happen sequentially. Imagine the CPU takes an
> > > interrupt after setting nr_cmdq_users==0 but before clearing
> > > SMMU_CR0.SMMUEN, then we are in a state where nr_cmdq_users==0 but
> > > SMMUEN is still set.
> > >
> > > >
> > > > > How about the following sequenc of events:
> > > > >
> > > > > * suspend handler sets nr_cmdq_users == 0
> > > > > * arm_smmu_cmdq_issue_cmdlist() stops updating the producer index
> > > > > which means that TLBIs are not executed
> > > > > * (sequence described above)
> > > > >
> > > > > Now that I think more about it: I'm concerned that if we set
> > > > > nr_cmdq_users == 0, the hw prod index will no longer be updated and
> > > > > the arm_smmu_drain_queues() function will wait for ever, because the
> > > > > cons index is not catching up.
> > > > >
> > > >
> > > > If we go ahead with the suggestion to completely elide a command
> > > > submission, if (nr_users_cmdq == 0) return 0; (as discussed in the other
> > > > thread), then we don't update llq.cons / prod. Then this shouldn't be an
> > > > issue right?
> > >
> > > I still think we have to clear SMMUEN before setting nr_users_cmdq=0
> > >
> > > >
> > > > The problem I see in swapping the sequence is::
> > > >
> > > > +       /* Abort all transactions before disable to avoid spurious bypass */
> > > > +       arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> > > > +
> > > > +       /* Disable the SMMU via CR0.EN and all queues except CMDQ */
> > > > +       enables = CR0_CMDQEN; <-- Tear down everything except CMDQ
> > > > +       ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
> > > > +       if (ret) {
> > > > +               dev_err(smmu->dev, "Timed-out while disabling smmu\n");
> > > > +               atomic_set(&smmu->nr_cmdq_users, 1);
> > > > +               return ret;
> > > > +       }
> > > > +       /* Try to suspend the device, wait for in-flight submissions */
> > > > +       do {
> > > > +               if (atomic_cmpxchg(&smmu->nr_cmdq_users, 1, 0) == 1)
> > > > +                       break;
> > > > +
> > > > +               udelay(1);
> > > > +       } while (--timeout);
> > > > +
> > > > +       if (!timeout) {
> > > > +               dev_warn(smmu->dev, "SMMU in use, aborting suspend\n");
> > > > +               return -EAGAIN; <--- suspend failed, but we already tore down the smmu
> > > > +       }
> > > > +
> > > > +
> > > > +       /*
> > > > +        * At this point the SMMU is completely disabled and won't access
> > > > +        * any translation/config structures, even speculative accesses
> > > > +        * aren't performed as per the IHI0070 spec (section 6.3.9.6).
> > > > +        */
> > > > +
> > > > +       /* Wait for the CMDQs to be drained to flush any pending commands */
> > > > +       ret = arm_smmu_drain_queues(smmu);
> > > > +       if (ret)
> > > > +               dev_err(smmu->dev, "Draining queues timed-out..forcing suspend\n");
> > > > +
> > > > +       /* Disable everything */
> > > > +       arm_smmu_device_disable(smmu); <---- Note that this still just disables the CMDQ
> > > > +       dev_dbg(dev, "Suspended smmu\n");
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > >
> > > > In the current implementation we first see if we can suspend only then
> > > > tear down the SMMU (Except for the CMDQ),
> > >
> > > What do you mean by "if we can suspend"? I think we can clear SMMUEN
> > > even while commands are in-flight.
> > >
> >
> > I mean a race where we set SMMUEN = 0 but we get another CMDQ user,
> > since the nr_cmdq_users != 0, we can have multiple users flushing their
> > commands unless it's back to 1. The problem is how long do we wait for
> > nr_users = 0 ? If we timeout, we'll have to reset the SMMU as we can't
> > simply re-enable SMMUEN.
> 
> Why can't we just re-enable SMMUEN? If we never set nr_cmdq_users to
> 0, we never elided any invalidation commands.
> 

Hmm.. this question makes me agree that moving the nr_cmdq_users gating
loop to the top is the better approach.

We can't simply re-enable SMMUEN to recover from a failed suspend. Per
spec section 6.3.9.6, transitioning SMMUEN to 0 is a slightly 
destructive operation that forces the termination of stalled
transactions.. but I think we already have a problem in the current path
where we disable SMMUEN first and a timeout causes us to return early.

Thus, I agree with the suggestion of moving the nr_users cmpxchg loop.
It creates a clear 'Point of No Return' in software before we modify
the hardware state.

If we cannot transition nr_cmdq_users from 1 to 0, we can abort the
suspend safely because the SMMU is still fully enabled. Once we 
successfully gate submissions, we can proceed with SMMUEN = 0 and 
draining the queue, knowing that no new commands will race with the 
teardown. Thanks for being persistent!

> >
> > We can't forcibly set nr_cmdq_user = 0 as we don't know where in the
> > issue_cmdlist a thread is, forcibly setting it 0 would cause trouble if
> > a thread is polling on a sync or about to increment the prod_index..
> 
> I agree that we can't forcibly set nr_cmdq_user = 0. When I wrote set
> nr_cmdq_user to 0, I meant using your atomic_cmpxchg loop.

Ack.

Thanks,
Praan
