Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2331D5ADE
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 05:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773207090; cv=none; b=PjdUcZohhxv2/TKwWs8VKRcKAlCv1xrfGcSgHBK8k4sNRwv7bfU/Nd4obWelzk7C9SeWpgJagc6pcp8iMaiU3Pz9w+6Xnnz3GyMwghy2KarJkdXyRV7N2goDv6DI5dcDSyfKtLQ68A6g5CyMn8vvP70Tk6PJIxov1+QkOfo3AnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773207090; c=relaxed/simple;
	bh=XgX8ZcjTx4d9mtBLFspWqHlo/T7RAINlNWf0ArWsx10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1t/f8UT74czVTUDKFdc06SZ/J8+05EN/l40+ci4TuCkknNefmJiAq+f91VpXaNMpA9RTnv2KIWRnjk1BLPLhL5AIE8oF6++ByNHfYiRwVsA2eeq8/kp2rNDk1Bk4r3rIqe6M1GV7JSnoipzbMAjwMf9HTEdOcxxED/gnOCmiBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SOqk+JES; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SOqk+JES"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aea4ebb048so46755ad.1
        for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 22:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773207088; x=1773811888; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XI+HtRCMeA226W57ZWJYypbmUYZyQmM/JIZM7X4yxIw=;
        b=SOqk+JESQSeLAAQAwWBUYK9JnsiCDOYhFIsyRoEJtuIEGGoWYy6czV/q1Yq5bNNlSW
         3r2OzfP2ndOUDwdAcrzrdX5ksV5yVkLSjYHCNAnMYJRk/NI4kWf9O0fNMkGuIcTJn9ey
         XKRt7hGifloqOyTMOBF8Oci+wvDjF+XEdqFc45Oko+t6gmonf5FxSO5+k7EMjUpNE02d
         tKEg29PvO6qjIJ633E0iX/TmdPoFdgS4Jn6b3o0yzE49PuNZYHy8eYWIyJ4YYP58NxkH
         WSwyV6rWAsw/c2tcI1486UNm6lc6Zya6Gl/yLyVWYUIEOWpRc4lujUAlb9haEAHD6sPq
         Ysew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773207088; x=1773811888;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XI+HtRCMeA226W57ZWJYypbmUYZyQmM/JIZM7X4yxIw=;
        b=dx1Zuh+5eJEH40QPnt3Vk9ZMeNjmGinpZ1G4Wy+KDVaye+ms44dbiGDcxyxq0XH00W
         yqmxZdX6zxMBZmB3WvD/vmV94UlpDCTGBOD+da2w6GndtRj7voCoowISTUCoTzNmmGVV
         h9/RouqSDE8wIu0QVueXJAsFNYivMMcBIw7paYj0bRXPfxO9cPFk5A7BrcPziKwroobE
         iSDmihGJWFI75J7RC6CarwLwSyloY4FXta/GpgsiEXmv4KfK82WhlIbjeXdXbZP2uEkQ
         dIQywsnZtALxo6JFRluPmfEENOwp+Y7YHFjOdKyFphqYvgx1flI/xi0wSFcNcdcm9ciT
         O3tQ==
X-Gm-Message-State: AOJu0YyAjefMRNFCTrQeC4sKljZPt3Vinaw3pUHydYWRlFhjKx1B88MQ
	5DVmeZBOgtb9JB0Qn3YWHDWoXxg0e/qIzOuUVXmhEMNb9iaM7YL+GY5LaqC3rk6y9g==
X-Gm-Gg: ATEYQzwmI3RDi2BWHHPjJjXMaVW6yfuvFEJ8t2DHigmu1WyfACoqA2ulxAKjRkK0fpJ
	NWGIJP7TXhvNwvgf3702Uxo1JsUlofHy0/iO4niUDLpUaR89+j82KL1DCZ99mqgWPZSXF8FRIVQ
	rlkONYxTn6S46GD7ree2SpdjqoMKDLgGszSfM9Jl8C8FtcZAVXjEfcAk3GdoLG14icO9Aw75u/8
	xzVXYC6ECpF5sxNsuv5sNAWLp4LZuUMSNZd8vd3LFTseDq0qY3DcLf+SnDkQSZ0JqfphRyrgwNy
	HmhGQewaV35FxghCEM7zmcShu5JGqpn5YYfTD+W/zR2pDFXKm1XkCXOCK9GALMxQS+5MoxLvi5W
	HG8zcVMsPWUYwzx4wI32Gl0tFPDmYZXdf5VbORJHxO/FUuPSmKjin+gfd//UzgIG0GYxlCnwh/N
	7FZmyPYApEML1gj7pFzDHliAlxHmUvEfs6ukF2JQTuIECL5BH3BFKqFcplkg==
X-Received: by 2002:a17:902:fc4b:b0:2ae:aa7e:855b with SMTP id d9443c01a7336-2aead2c4953mr2178035ad.2.1773207087426;
        Tue, 10 Mar 2026 22:31:27 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae260ea3sm10667375ad.39.2026.03.10.22.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 22:31:26 -0700 (PDT)
Date: Wed, 11 Mar 2026 05:31:22 +0000
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
Message-ID: <abD-Kl0xkfg4tsh4@google.com>
References: <20260126151157.3418145-1-praan@google.com>
 <20260126151157.3418145-8-praan@google.com>
 <CAE2F3rD-rEpizTpc1fo7Y8fXZfZCF2TGUz8H86rUY6RzTWQDQA@mail.gmail.com>
 <abBNwXk2a8v6Zgbw@google.com>
 <CAE2F3rAqyX_CQaN2Wt2=uTYJqYUV3nbrfmog0YyvPr4pgYU5xQ@mail.gmail.com>
 <abCP0wLkVvUSUeYI@google.com>
 <CAE2F3rDbB4RgZLfqKu=AeGdJU6TLdmO=XTCzCb1-yq7VKH0zdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rDbB4RgZLfqKu=AeGdJU6TLdmO=XTCzCb1-yq7VKH0zdw@mail.gmail.com>

On Tue, Mar 10, 2026 at 05:12:15PM -0700, Daniel Mentz wrote:
> On Tue, Mar 10, 2026 at 2:40 PM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Tue, Mar 10, 2026 at 02:16:31PM -0700, Daniel Mentz wrote:
> > > On Tue, Mar 10, 2026 at 9:58 AM Pranjal Shrivastava <praan@google.com> wrote:
> > > >
> > > > On Mon, Mar 09, 2026 at 06:45:09PM -0700, Daniel Mentz wrote:
> > > > > On Mon, Jan 26, 2026 at 7:12 AM Pranjal Shrivastava <praan@google.com> wrote:
> > > > > >
> > > > > > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> > > > > > +{
> > > > > > +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > > > > > +       int timeout = ARM_SMMU_SUSPEND_TIMEOUT_US;
> > > > > > +       u32 enables;
> > > > > > +       int ret;
> > > > > > +
> > > > > > +       /* Try to suspend the device, wait for in-flight submissions */
> > > > > > +       do {
> > > > > > +               if (atomic_cmpxchg(&smmu->nr_cmdq_users, 1, 0) == 1)
> > > > >
> > > > >
> > > > > I understand we must follow the rule: do not elide any invalidations
> > > > > while SMMU is still enabled. Otherwise, the following sequence of
> > > > > events might occur:
> > > > >  * The driver clears a table descriptor
> > > > >  * The TLBI command is skipped
> > > > >  * The driver frees the page that backed the translation table
> > > > >  * The page is re-allocated for some unrelated purpose
> > > > >  * SMMU performs a table walk and then descends into the page that has
> > > > > been reallocated, misinterpreting its contents.
> > > > >
> > > > > Can you disable SMMU before setting nr_cmdq_users to 0?
> > > > >
> > > >
> > > > No, that'd be racy, if I disable the smmu but nr_cmdq_users != 0 an
> > > > "owner" thread might believe that the SMMU is still functional and poll
> > > > for consumption.
> > >
> > > I assume that SMMU still processes commands if SMMU_CR0.SMMUEN is
> > > cleared but SMMU_CR0.CMDQEN is set. The arch spec reads: "When
> > > translation is not enabled for a Security state, an SMMU: [...] Can
> > > process commands after the relevant queue pointers are initialized and
> > > SMMU_(*_)CR0.CMDQEN is enabled." Also, the sequence described under
> > > "Arm recommends that software initializing the SMMU performs the
> > > following steps:" suggests this behavior. The existing driver code
> > > also relies on this when it runs CMDQ_OP_CFGI_ALL before setting
> > > SMMU_CR0.SMMUEN.
> > >
> > > >
> > > > I don't think that the SMMU would perform a walk as we first set the
> > > > nr_cmdq_users == 0 to stop command submissions and then immediately set
> > > > GBPA to abort. IF a command submission raced with this, we wait for the
> > >
> > > To ensure we're on the same page: Setting SMMU_GBPA.ABORT doesn't do
> > > anything while SMMU_CR0.SMMUEN is set. SMMU_GBPA only plays a role if
> > > SMMU_CR0.SMMUEN is cleared.
> > >
> >
> > I think you're missing that we *DO* actually set SMMUEN = 0 *with* the
> > GBPA abort, please look at this part of the patch:
> >
> > +       /* Abort all transactions before disable to avoid spurious bypass */
> > +       arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> > +
> > +       /* Disable the SMMU via CR0.EN and all queues except CMDQ */
> > +       enables = CR0_CMDQEN;
> > +       ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
> > +       if (ret) {
> > +               dev_err(smmu->dev, "Timed-out while disabling smmu\n");
> > +               atomic_set(&smmu->nr_cmdq_users, 1);
> > +               return ret;
> > +       }
> >
> > We disable everything except for the CMDQ. Since, everything is disabled
> > at this point, any new commands can safely be elided as the SMMU won't
> > access any config structures as mentioned by the spec.
> >
> > > The moment you set nr_cmdq_users == 0, you potentially start eliding
> > > TBLIs which means that the TLB entries are at risk of becoming stale.
> >
> > Not really, the SMMU isn't accessing anything since SMMUEN=0 and GBPA is
> > set by this point.
> 
> I believe you are assuming that all these things happen atomically
> when they, in fact, happen sequentially. Imagine the CPU takes an
> interrupt after setting nr_cmdq_users==0 but before clearing
> SMMU_CR0.SMMUEN, then we are in a state where nr_cmdq_users==0 but
> SMMUEN is still set.
> 
> >
> > > How about the following sequenc of events:
> > >
> > > * suspend handler sets nr_cmdq_users == 0
> > > * arm_smmu_cmdq_issue_cmdlist() stops updating the producer index
> > > which means that TLBIs are not executed
> > > * (sequence described above)
> > >
> > > Now that I think more about it: I'm concerned that if we set
> > > nr_cmdq_users == 0, the hw prod index will no longer be updated and
> > > the arm_smmu_drain_queues() function will wait for ever, because the
> > > cons index is not catching up.
> > >
> >
> > If we go ahead with the suggestion to completely elide a command
> > submission, if (nr_users_cmdq == 0) return 0; (as discussed in the other
> > thread), then we don't update llq.cons / prod. Then this shouldn't be an
> > issue right?
> 
> I still think we have to clear SMMUEN before setting nr_users_cmdq=0
> 
> >
> > The problem I see in swapping the sequence is::
> >
> > +       /* Abort all transactions before disable to avoid spurious bypass */
> > +       arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> > +
> > +       /* Disable the SMMU via CR0.EN and all queues except CMDQ */
> > +       enables = CR0_CMDQEN; <-- Tear down everything except CMDQ
> > +       ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
> > +       if (ret) {
> > +               dev_err(smmu->dev, "Timed-out while disabling smmu\n");
> > +               atomic_set(&smmu->nr_cmdq_users, 1);
> > +               return ret;
> > +       }
> > +       /* Try to suspend the device, wait for in-flight submissions */
> > +       do {
> > +               if (atomic_cmpxchg(&smmu->nr_cmdq_users, 1, 0) == 1)
> > +                       break;
> > +
> > +               udelay(1);
> > +       } while (--timeout);
> > +
> > +       if (!timeout) {
> > +               dev_warn(smmu->dev, "SMMU in use, aborting suspend\n");
> > +               return -EAGAIN; <--- suspend failed, but we already tore down the smmu
> > +       }
> > +
> > +
> > +       /*
> > +        * At this point the SMMU is completely disabled and won't access
> > +        * any translation/config structures, even speculative accesses
> > +        * aren't performed as per the IHI0070 spec (section 6.3.9.6).
> > +        */
> > +
> > +       /* Wait for the CMDQs to be drained to flush any pending commands */
> > +       ret = arm_smmu_drain_queues(smmu);
> > +       if (ret)
> > +               dev_err(smmu->dev, "Draining queues timed-out..forcing suspend\n");
> > +
> > +       /* Disable everything */
> > +       arm_smmu_device_disable(smmu); <---- Note that this still just disables the CMDQ
> > +       dev_dbg(dev, "Suspended smmu\n");
> > +
> > +       return 0;
> > +}
> > +
> >
> > In the current implementation we first see if we can suspend only then
> > tear down the SMMU (Except for the CMDQ),
> 
> What do you mean by "if we can suspend"? I think we can clear SMMUEN
> even while commands are in-flight.
> 

I mean a race where we set SMMUEN = 0 but we get another CMDQ user, 
since the nr_cmdq_users != 0, we can have multiple users flushing their
commands unless it's back to 1. The problem is how long do we wait for
nr_users = 0 ? If we timeout, we'll have to reset the SMMU as we can't
simply re-enable SMMUEN. 

We can't forcibly set nr_cmdq_user = 0 as we don't know where in the
issue_cmdlist a thread is, forcibly setting it 0 would cause trouble if
a thread is polling on a sync or about to increment the prod_index..

Thanks
Praan
