Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5439F3D093C
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178842; cv=none; b=k4Ph6O+rTKXNp+xXBglx3th2iNRRBA5ii9t76GGDCMW1saU8nDS/hylASyeThNoigbas1LUz7KFmjVCuKseiPAfsLxM7RWKYvCYw1eiF3xBtQKj2nYLgAEdi4JlrY+7eso6gROHedF0MhonEKh9UgZTcKJoPmVP7KsJG275Sk7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178842; c=relaxed/simple;
	bh=48QOB9sofWYvCflZkZ5vBGmZ/c4UHyXben4ZxHevJug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7BStSfcpOKE9KiGxqC7XgkQUkC9YWp3Bul9hAF1OwTKvC2IAaJNVkmfWEqDUSZa54cZkAsL3JqyBVNyxFx3Kx6PUcDfAkM3/6VvZTVLmFmqR6N9Kwi55rE/cLIikwG9XRRgJ87vsANa1LgPeOenqTvhAqCWdEo8ai/8WIlxY8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fga1U+jf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fga1U+jf"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aea4ebb048so15935ad.1
        for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 14:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773178841; x=1773783641; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WxlF6Qln8uIlY9vgFKxKEV9IkQpFN3vdg3zec7HbEUE=;
        b=Fga1U+jfcb7n/Qkx0sqT1TW7EHTW0nAIzzgK2r9RlMG8NXhRI8Z3UJxDgzuMruBmGc
         u/EHJDM1X3g5V84mgzpCGXnTRx0RGO37OhWX4ZszXaWQ+U6W5noN4R/MTvyoafSBpu4u
         oMYBf9jDBEJYzHGT4gBvGQLCIeyv5g3KTImWA1eg0EyyGgV9BHYGO0kuINyZ7wRADS1v
         Ds83XO42R/TbKgTQW2HN77KM1ApzQemlkiAgWONMWDUmj7BQDe1gjjdbKx0LYi2/iHlD
         P9kfarR3nm/uM2A7cp4VDiimNK9XsEl3eoDSGShk0THG1/C9y4JqCkC78Yrib04CqUG4
         UAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773178841; x=1773783641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WxlF6Qln8uIlY9vgFKxKEV9IkQpFN3vdg3zec7HbEUE=;
        b=U7ybM9ANzFhI5/RnuHLD+ScHc3mf3Ysg7rJyBllbFyo3uAeAPte2ByfQcq1SyDe4CC
         cm/9SAjuAcWADoFXMJI8ejpMs/aDyxrSTChKd2Mdynxr0zRYM0Q0ez8lldneb4wOViJO
         ocm1hXhF2CZQbf1xVsmMa1UEisc3RoP1I0xNzzm1GGc29zOljLQn3WYgnVefErFzq8Oa
         i3ZFPImS8TfNukbak8UMd8bxLfhCFShG3TTYGgzBEXjGPwXWnhPB84ZQ0lCPb2lq64DW
         ONSckjzseige/i2wmCKFxUZaeJv097dhgkL0L0LpjClPsk/lOlrYSkCojKD3d3/7WLUH
         o/VA==
X-Gm-Message-State: AOJu0Yy11t9YNIzk4oNmAB4syTBHq1muPVgjFEZLjyEu+HmUSlTaM8ND
	KMbRLvJgeyvI8OLVdvmugRr23Mvt2Gt7n8rL/7xqGQMhGw2Xtl8uYNVH0cNsk0aQuA==
X-Gm-Gg: ATEYQzyIG2OlKiuRd+V1D3znXUlvLaLx0cuocIDMDpatSoF/H1gqxhV9yPMUPXNDV1O
	5yHL1vJ3vwXKjmD5wjuM0twlqpKhj96wq/FSqwkdUQlJXEfa9n24wmHVAqlvh72boPHOukH0X7h
	TdpLuAZC229XfF/72YHLulkYghjBGy82mfdjFBjAadJlZQJj8jrknCwFgnCX9NfKU+Sc6vONzZi
	3pzZ7DIfOUp8SdiCmPev1+EMfIDv0hwPpstXKyAiGpGQeqaTB4+EEHqlNwWDLf4ImjDlPpvNsPS
	bvT4IwRTWMo4l0FOcvSenFYGFukeSgura7sdsmyU3HdpEbJOyRAcLRAf3LgOwI6FGwYQ9kEE4TK
	D07aCtmYYgNjrwwkCLAltujkgHeE1EIzbl97G1hJ1oMZh6ip87+EWw2JB58FtyTiaUQtsm70Ner
	H52OJKDZSPFsTs+dHwFSH4MMAD4VSll9mhBbvxyngR0WivEHrDaJOcBxaK0wyfEhj97bfz
X-Received: by 2002:a17:903:2a83:b0:2a0:867c:60e2 with SMTP id d9443c01a7336-2aeae7fc4a2mr367905ad.19.1773178840067;
        Tue, 10 Mar 2026 14:40:40 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02fca40bsm35147a91.10.2026.03.10.14.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:40:39 -0700 (PDT)
Date: Tue, 10 Mar 2026 21:40:35 +0000
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
Message-ID: <abCP0wLkVvUSUeYI@google.com>
References: <20260126151157.3418145-1-praan@google.com>
 <20260126151157.3418145-8-praan@google.com>
 <CAE2F3rD-rEpizTpc1fo7Y8fXZfZCF2TGUz8H86rUY6RzTWQDQA@mail.gmail.com>
 <abBNwXk2a8v6Zgbw@google.com>
 <CAE2F3rAqyX_CQaN2Wt2=uTYJqYUV3nbrfmog0YyvPr4pgYU5xQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rAqyX_CQaN2Wt2=uTYJqYUV3nbrfmog0YyvPr4pgYU5xQ@mail.gmail.com>

On Tue, Mar 10, 2026 at 02:16:31PM -0700, Daniel Mentz wrote:
> On Tue, Mar 10, 2026 at 9:58 AM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Mon, Mar 09, 2026 at 06:45:09PM -0700, Daniel Mentz wrote:
> > > On Mon, Jan 26, 2026 at 7:12 AM Pranjal Shrivastava <praan@google.com> wrote:
> > > >
> > > > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> > > > +{
> > > > +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > > > +       int timeout = ARM_SMMU_SUSPEND_TIMEOUT_US;
> > > > +       u32 enables;
> > > > +       int ret;
> > > > +
> > > > +       /* Try to suspend the device, wait for in-flight submissions */
> > > > +       do {
> > > > +               if (atomic_cmpxchg(&smmu->nr_cmdq_users, 1, 0) == 1)
> > >
> > >
> > > I understand we must follow the rule: do not elide any invalidations
> > > while SMMU is still enabled. Otherwise, the following sequence of
> > > events might occur:
> > >  * The driver clears a table descriptor
> > >  * The TLBI command is skipped
> > >  * The driver frees the page that backed the translation table
> > >  * The page is re-allocated for some unrelated purpose
> > >  * SMMU performs a table walk and then descends into the page that has
> > > been reallocated, misinterpreting its contents.
> > >
> > > Can you disable SMMU before setting nr_cmdq_users to 0?
> > >
> >
> > No, that'd be racy, if I disable the smmu but nr_cmdq_users != 0 an
> > "owner" thread might believe that the SMMU is still functional and poll
> > for consumption.
> 
> I assume that SMMU still processes commands if SMMU_CR0.SMMUEN is
> cleared but SMMU_CR0.CMDQEN is set. The arch spec reads: "When
> translation is not enabled for a Security state, an SMMU: [...] Can
> process commands after the relevant queue pointers are initialized and
> SMMU_(*_)CR0.CMDQEN is enabled." Also, the sequence described under
> "Arm recommends that software initializing the SMMU performs the
> following steps:" suggests this behavior. The existing driver code
> also relies on this when it runs CMDQ_OP_CFGI_ALL before setting
> SMMU_CR0.SMMUEN.
> 
> >
> > I don't think that the SMMU would perform a walk as we first set the
> > nr_cmdq_users == 0 to stop command submissions and then immediately set
> > GBPA to abort. IF a command submission raced with this, we wait for the
> 
> To ensure we're on the same page: Setting SMMU_GBPA.ABORT doesn't do
> anything while SMMU_CR0.SMMUEN is set. SMMU_GBPA only plays a role if
> SMMU_CR0.SMMUEN is cleared.
> 

I think you're missing that we *DO* actually set SMMUEN = 0 *with* the
GBPA abort, please look at this part of the patch:

+	/* Abort all transactions before disable to avoid spurious bypass */
+	arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
+
+	/* Disable the SMMU via CR0.EN and all queues except CMDQ */
+	enables = CR0_CMDQEN;
+	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
+	if (ret) {
+		dev_err(smmu->dev, "Timed-out while disabling smmu\n");
+		atomic_set(&smmu->nr_cmdq_users, 1);
+		return ret;
+	}

We disable everything except for the CMDQ. Since, everything is disabled
at this point, any new commands can safely be elided as the SMMU won't
access any config structures as mentioned by the spec.

> The moment you set nr_cmdq_users == 0, you potentially start eliding
> TBLIs which means that the TLB entries are at risk of becoming stale.

Not really, the SMMU isn't accessing anything since SMMUEN=0 and GBPA is
set by this point.

> How about the following sequenc of events:
> 
> * suspend handler sets nr_cmdq_users == 0
> * arm_smmu_cmdq_issue_cmdlist() stops updating the producer index
> which means that TLBIs are not executed
> * (sequence described above)
> 
> Now that I think more about it: I'm concerned that if we set
> nr_cmdq_users == 0, the hw prod index will no longer be updated and
> the arm_smmu_drain_queues() function will wait for ever, because the
> cons index is not catching up.
> 

If we go ahead with the suggestion to completely elide a command
submission, if (nr_users_cmdq == 0) return 0; (as discussed in the other
thread), then we don't update llq.cons / prod. Then this shouldn't be an
issue right?

The problem I see in swapping the sequence is::

+	/* Abort all transactions before disable to avoid spurious bypass */
+	arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
+
+	/* Disable the SMMU via CR0.EN and all queues except CMDQ */
+	enables = CR0_CMDQEN; <-- Tear down everything except CMDQ
+	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
+	if (ret) {
+		dev_err(smmu->dev, "Timed-out while disabling smmu\n");
+		atomic_set(&smmu->nr_cmdq_users, 1);
+		return ret;
+	}
+	/* Try to suspend the device, wait for in-flight submissions */
+	do {
+		if (atomic_cmpxchg(&smmu->nr_cmdq_users, 1, 0) == 1)
+			break;
+
+		udelay(1);
+	} while (--timeout);
+
+	if (!timeout) {
+		dev_warn(smmu->dev, "SMMU in use, aborting suspend\n"); 
+		return -EAGAIN; <--- suspend failed, but we already tore down the smmu
+	}
+
+
+	/*
+	 * At this point the SMMU is completely disabled and won't access
+	 * any translation/config structures, even speculative accesses
+	 * aren't performed as per the IHI0070 spec (section 6.3.9.6).
+	 */
+
+	/* Wait for the CMDQs to be drained to flush any pending commands */
+	ret = arm_smmu_drain_queues(smmu);
+	if (ret)
+		dev_err(smmu->dev, "Draining queues timed-out..forcing suspend\n");
+
+	/* Disable everything */
+	arm_smmu_device_disable(smmu); <---- Note that this still just disables the CMDQ
+	dev_dbg(dev, "Suspended smmu\n");
+
+	return 0;
+}
+

In the current implementation we first see if we can suspend only then
tear down the SMMU (Except for the CMDQ),

I think this would NOT be a problem if we just bail out of issue_cmdlist
early as discussed on the other thread if (nr_cmdq_users == 0) return 0;
that way, we don't end up in a "fake command" consumption situation
which could lead to the cons never catching up while draining the queue.

Thanks
Praan
