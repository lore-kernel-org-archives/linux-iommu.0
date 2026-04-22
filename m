Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E29025A2C9
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776865262; cv=none; b=K7GBjV2HJZFZqecIa7bPbmXV2wiuaVuj7mF83NNn31pgXczaa16UjCcr4a2sgILpbsxf5ja0Ex2gTWtEk32fZ+filf5TZfzRBVZqudDWJLBfrlH9p5eA/zk51GvuY3He4/Cc32daQQ5oaDMHJHoPmHgAvcoJr0nUlEviRIETP84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776865262; c=relaxed/simple;
	bh=gw5v3+crEmfzQnSNuUqqCn/Sxpu02qUaTHvp8hMRf5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxPu44bJ9ZZlAyMsd5StF/p0aCCCcNFp556INHZwoWiPwganbBUBdln43J+tyRev93pzrvSApbxtu7ZveitH3uFBm9oj446IUxWk4L3rzWg2sK9f8hhZVemCFFHLbZ2aDqm81s0yboUFzfMI0Ugntk35R4DtvG9b8TOhThQcldE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ofDbWSZM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofDbWSZM"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2591757fbso402445ad.0
        for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 06:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776865260; x=1777470060; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VzKXwVfUSfykpKMrHTFpIqQQhsh/iJBi+8cyETJcLNA=;
        b=ofDbWSZMmIPXB5D9mWrf7e1tV0TqLFI87gi5Z87D5SJbahwvsinWbeZljRYKIinc38
         Iw/o3HlUHqDeuokD1AZhiuc8DMFuoUptqMhRzqMcpIVq85J93WKuFZWk1h7LxLJdgLSn
         RiHDQfyBLlOLMo6bN5dbHrlFWeW9cje5fS4lRNLdB/Vy2FzsuYFNLx7i+Jksyf7MVY+X
         +3Xl7lRbTtU0l09PUFPLpEP/y7Soaogholnhs6GwlyvhhoQj1pwLAVPSNHCZztM+6niD
         FONfm9TRYbBnfqlB6UqwVHXC2WBTf7cllHlzyGpemHTyixEmh1aJktQiQLDlZwNgvdbv
         lcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776865260; x=1777470060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VzKXwVfUSfykpKMrHTFpIqQQhsh/iJBi+8cyETJcLNA=;
        b=MKmeTYxqyL4ElVpbBgKH2CO3+Fbarbe3F+Zk4N9TJEQk/yEjqjp3t22SGb7C0Wz+PR
         NkWzv9n45Idn/SvKrB5Vvna8FUQcsjtrSHOGJAuywrg44I9tQW7jwXA5m0/xox95z9ve
         UO6fuoXFByV9xEGL0kMIwXTaVKxtKHZF1Wps36TQg3QWpmSZpVGOwbwEXMhU00OsIBOh
         8C0sRWf5lmPLnL0Dz2hc6+XgALlyu+AKeyZVoYprXuwzAdJlNTs2Mpu/klHE2ATeth97
         W0wSvpdrkRsTo5M9kkkAEpfGPyRDHebvvmywLI51xDxYB96sb0COQ6HfVmQ6Jv343Skg
         YJBA==
X-Gm-Message-State: AOJu0YxjUpc51zfFwiO17xswKyFiDHpLXy93/UO6TEygg+KUum9XpulX
	hEpJVGwR6LvEoazL3Rj6OfGGvhOuQSGld4Aep8j1R4DfBKw079aSr1HEqIBMLdRXWw==
X-Gm-Gg: AeBDieuisqPpUAgzCT2bPk6B3s36RQM4ivWW1unjB3ANwUy6a1rD3F7P9fRHOVHWI23
	0Jz/gg9BkSnolbgGqgdqUQWwqnQGoMuJ81ja3c9uj1SkApHvHRCtC2pCz5YZ/zauYjSyfUT5n0F
	+pXpjNQiyTc+Brt9zKo4/XnrPvISbpasVbpmLCODvLEogG9CbFBk0w+QMbAXi9UaAqw/Nvx3YBC
	f2HQ0jt+hf0nDCq+G26KU8JQqr512Ri5iMktLqvqmtRZEDljXnsX0CczClgnnAoNr2+KSt/abVj
	s4JQsB3ng81gqz13h05GdBkTpmrzwp+0WS+zcUuc2A8/5BTHvKvpLBAg1eD/6d1v/lVYrW1+v0S
	qiI4hmvPGvLGW/hgW96+O9ifpeUVklT33oj+K7FLm2l3ytYgEpVbvDn1qe0hQ5BCVPTbb25x47X
	GI27UAnGt07R/3bsnLY13HsofzoLCGFn4egGuZIeNfrew2eIzS5QQHDqnz/GU6S+/MDTN6yRh8C
	roFX1k=
X-Received: by 2002:a17:903:28f:b0:2b0:be7d:a25e with SMTP id d9443c01a7336-2b603072ea9mr13147645ad.18.1776865259645;
        Wed, 22 Apr 2026 06:40:59 -0700 (PDT)
Received: from google.com (174.188.87.34.bc.googleusercontent.com. [34.87.188.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140fc5d94sm22025583a91.2.2026.04.22.06.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:40:59 -0700 (PDT)
Date: Wed, 22 Apr 2026 13:40:53 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>
Subject: Re: [PATCH v6 07/10] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <aejP5Yk72_FtZnIo@google.com>
References: <20260414194702.1229094-1-praan@google.com>
 <20260414194702.1229094-8-praan@google.com>
 <CAE2F3rCaBWtRruBbZcedrsLnkkETSniTWoxxYn+Lkac9ttsshQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rCaBWtRruBbZcedrsLnkkETSniTWoxxYn+Lkac9ttsshQ@mail.gmail.com>

On Tue, Apr 21, 2026 at 09:25:12PM -0700, Daniel Mentz wrote:
> On Tue, Apr 14, 2026 at 12:47 PM Pranjal Shrivastava <praan@google.com> wrote:
> > +/* Runtime PM helpers */
> > +__maybe_unused static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
> 
> Please be consistent about placing the __maybe_unused attribute. I
> believe that in the other functions, the placement is between the
> return type and the function name.
> 

Ack.

> > +
> > +/*
> > + * This should always return true if devlinks are setup correctly
> > + * and the client using the SMMU is active.
> > + */
> > +__maybe_unused bool arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu)
> > +{
> > +       if (!arm_smmu_is_active(smmu))
> > +               return false;
> 
> I'm wondering if this check is redundant. What would happen if we removed it?
> 

You're right that pm_runtime_get_if_active() shall suffice. However, I
added the arm_smmu_is_active() check as a lockless fast path for unmaps

Consider a scneario where there're high-frequency unmaps (unmap-storm)
while the SMMU is suspended. Without this check, every thread would 
contend for the dev->power.lock spinlock inside the RPM core 
(pm_runtime_get_if_active) just to discover the device is not active.

This check allows CPUs to elide the command immediately without
contending for the dev->power.lock spinlock inside the RPM core
(get_if_active call) and avoids unnecessary cacheline bouncing when the
SMMU is suspended.

> > +
> > +       if (pm_runtime_enabled(smmu->dev))
> > +               return pm_runtime_get_if_active(smmu->dev) > 0;
> > +
> > +       return true;
> > +}
> 
> > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> > +{
> > +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +       struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
> > +       struct arm_smmu_ll_queue llq, head;
> > +       int timeout = ARM_SMMU_SUSPEND_TIMEOUT_US;
> > +       u32 enables, target;
> > +       u64 old;
> > +       int ret;
> > +
> > +       /* Abort all transactions before disable to avoid spurious bypass */
> > +       arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> > +
> > +       /* Disable the SMMU via CR0.EN and all queues except CMDQ */
> > +       enables = CR0_CMDQEN;
> > +       ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
> > +       if (ret) {
> > +               dev_err(smmu->dev, "failed to disable SMMUEN\n");
> 
> "failed to disable SMMU". "EN" is redundant.
> 

Ack. I attempted to be verbose highlighting that the attempt was to
disable non-CMDQ stuff but I don't think that's needed. I'll update this

> > +               return ret;
> > +       }
> > +
> > +       /*
> > +        * At this point the SMMU is completely disabled and won't access
> > +        * any translation/config structures, even speculative accesses
> > +        * aren't performed as per the IHI0070 spec (section 6.3.9.6).
> > +        */
> > +
> > +       /* Mark the CMDQ to stop */
> > +       llq.val = READ_ONCE(cmdq->q.llq.val);
> > +       do {
> > +               head = llq;
> > +               head.prod |= CMDQ_PROD_STOP_FLAG;
> > +
> > +               old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
> > +               if (old == llq.val)
> > +                       break;
> > +
> > +               llq.val = old;
> > +       } while (1);
> > +
> > +       /* Wait for the last committed owner to reach the hardware */
> > +       target = head.prod & ~CMDQ_PROD_STOP_FLAG;
> > +       while (atomic_read(&cmdq->owner_prod) != target && --timeout)
> > +               udelay(1);
> 
> Should we just use the following line from arm_smmu_cmdq_issue_cmdlist()?
> 
> atomic_cond_read_relaxed(&cmdq->owner_prod, VAL == target);
> 

I did consider atomic_cond_read_relaxed() but didn't go for it as it
doesn't have a timeout, we could wait here indefinitely.. (it's a
while(1) loop)

> > +
> > +       /*
> > +        * Entering suspend implies no active clients. A race or timeout here
> > +        * indicates a broken RPM or devlink dependency. We proceed anyway to
> > +        * prioritize memory safety (avoiding stale TLBs) over bus faults.
> 
> Can you elaborate on how broken dependencies will result in a stuck
> cmdq->owner_prod?
> 

I believe you are right, this comment needs to be updated.
With the CMDQ_PROD_STOP_FLAG gating mechanism, concurrent submissions are
handled safely even if device links are broken (they either complete if
committed before the flag, or bail out if they arrive after). A timeout
here would actually indicate something like a CMDQ stall rather than just
a missing device link. I will update the comment to reflect this.

> > +        */
> > +       if (!timeout)
> > +               dev_err(smmu->dev, "cmdq owner wait timeout, (check runtime PM + devlinks)\n");
> > +
> > +       /* Drain the CMDQs */
> > +       ret = arm_smmu_drain_queues(smmu);
> > +       if (ret)
> > +               dev_warn(smmu->dev, "failed to drain queues, forcing suspend\n");
> > +
> > +       /* Wait for cmdq->lock == 0 to ensure last CMDQ_CONS_REG is written */
> > +       timeout = ARM_SMMU_SUSPEND_TIMEOUT_US;
> > +       while (atomic_read(&cmdq->lock) != 0 && --timeout)
> 
> Can we use
> 
> atomic_cond_read_relaxed(&cmdq->lock, VAL == 0);
> 

Same as above, worried about a lockup due to CMDQ Stalls.

> > +               udelay(1);
> > +
> > +       /* Timing out here implies misconfigured Runtime PM or broken devlinks */
> > +       if (!timeout)
> > +               dev_err(smmu->dev, "cmdq lock != 0, forcing suspend. Polling CPUs may fault.\n");
> > +
> > +       /* Disable everything */
> > +       arm_smmu_device_disable(smmu);
> > +
> > +       /* Handle any pending gerrors before powering down */
> > +       arm_smmu_handle_gerror(smmu);
> > +
> > +       dev_dbg(dev, "suspended smmu\n");
> > +
> > +       return 0;
> > +}
> > +
> > +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
> > +{
> > +       int ret;
> > +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +       struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
> > +       struct arm_smmu_ll_queue llq;
> > +
> > +       /* Clear the STOP FLAG to allow CMDQ Submissions */
> 
> Clearing the STOP flag here seems premature. I propose the following sequence:
> 
> * Set up command queue (SMMU_CR1, SMMU_CMDQ_BASE etc.)
> * Enable command queue
> * Clear STOP flag
> * Enable SMMU
> 
> By clearing the STOP flag, you allow arm_smmu_cmdq_issue_cmdlist() to
> write to SMMU_CMDQ_PROD which then races against
> arm_smmu_device_reset() which also writes to SMMU_CMDQ_PROD.
> 

I agree, IIUC you're suggesting to clear the stop flag before the
TLBI_ALL and CFGI_ALL commands are issued by device_reset? We'll need
to clear the flag before device_reset issues the  TLBI_ALL AND CFGI_ALL.
Thus the sequence should be:

* Set up CMDQ
* Enable CMDQ
* Clear STOP flag
* Issue TLBI_ALL + CFGI_ALL
* Enable SMMU

Right?

> > +       llq.val = READ_ONCE(cmdq->q.llq.val);
> > +       while (1) {
> > +               u64 old_val;
> > +               struct arm_smmu_ll_queue head = llq;
> > +
> > +               if (!(head.prod & CMDQ_PROD_STOP_FLAG))
> > +                       break;
> > +
> > +               head.prod &= ~CMDQ_PROD_STOP_FLAG;
> > +               old_val = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
> > +               if (old_val == llq.val)
> > +                       break;
> > +               llq.val = old_val;
> > +       }
> > +
> > +       /* Re-configure MSIs */
> > +       arm_smmu_resume_msis(smmu);
> > +
> > +       ret = arm_smmu_device_reset(smmu);
> > +       if (ret)
> > +               dev_err(dev, "failed to reset during resume operation: %d\n", ret);
> > +
> > +       dev_dbg(dev, "resumed device\n");
> 
> arm_smmu_runtime_suspend() prints "resumed smmu" (not "device"). Try
> to be consistent with the language used in messages.
> 

Ack. I'll update it to dev_dbg(dev, "resumed smmu\n");

> > +
> > +       return ret;
> > +}

Thanks,
Praan
