Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520091A9FA7
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675377; cv=none; b=VuXGyVp9zFni4gCTofHCf50KhQOhZK1OEuvlFLP8UpUDK9Vt2v7XIqdukqeS3ULV45yph1oXIFK6ehwVVnKGdrAWFbBROoA8PpXietKui6r3yZqNCQ2PeFhBDINLUww/K3oLU8ZaYu/8XndOOBXx4AnVMzjGWnjPjKg3cHC5Cks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675377; c=relaxed/simple;
	bh=qGbM3PV0qRLSpKHoLMTse/Jca7QQOcdFkDZ/qYdLofc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZ8cmyhaWfJ+kHRY8hxjsoJah+DOjSFIET4GwLVQnqxqYCHoNFAvNcn/0MZepHmvBLD3dH9GcQSWX0BtLtq7nK40X5pII7E7bUKLSbScOhi2AQHx25r0jPJKBtQQb3u5C4dAPLmmA3pgIwSe5Z8OSPfxUyBh4nH3lmj4FGSzYtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PrkX0/mq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PrkX0/mq"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2aeab6ff148so156665ad.1
        for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773675376; x=1774280176; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4e+cBWUiI1u+atb2Wg8Yi2UQPkixRo/hHQFk2zmpkOY=;
        b=PrkX0/mqHmRHd2RdlJb+JO6RqUPehpKefaJqt5ufG5H8UatlaMKgKmgcYsg2hMNYw/
         AJ9gz4Ydq3fG00mJ9RE0fKBm3gkw7qPGGtFgqnu+dQurrLB1SHQyBEbs6CM1pGw0pK8i
         3h0AbEg7iWaGVh4QNReL3lhfssCsS+vAOPxpNsWhj/FNL7Ei4pNgS+465ngrwcqiKi0r
         YJ35xnlOB6daIFUDFh5o6Bn3VPBIj8S4rguZ51uMyBpQ1M/IPBqjOoiHIxtnieTP3MQp
         5n/j2uIcitv1IvrXkkr2SbyA1IhCdIArlkzvdJHxuUO404NsIK3e38GUkcv2JNt2KhXN
         CfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773675376; x=1774280176;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4e+cBWUiI1u+atb2Wg8Yi2UQPkixRo/hHQFk2zmpkOY=;
        b=lav0LbgLiX8D2jlW9NUan//TW4YoR9C3HH4gkMMPciROnApNRvpjbFymWz4/NF0LcK
         +Nd7Jc8kMU+ExQ7VTBzw+7duUrwgEDaqS+Oc0RtVj4HN2YvhJPPJiB0hqiVDfU/uH4y6
         s0nn3TD676xhaugYC74a0iVePaqkhZgehCpfbfbNjBG9d7rBgEWqgcpsNRlsRYXm6kxk
         Jebpk81zfPsYMt19AvSZCY1tpYk3P1S4nSVhhH2Hbb7yoxNXwBH0MEtzSEv5KMsjSVvn
         m+tQid0CmRcnAPY6jxjEUTGOQRBRW2lOyixPhzIwhI+igJBeOpO+rnMHIBni/jWLo+TW
         Pi+g==
X-Gm-Message-State: AOJu0YwGltEsb6Oaghe6g5eJ+K64Dc+cmGsgPPwfpDm1c5xJrd5jtToj
	3UEhYDwr7GkEKaom6iymgsCqsF8YBWR76PTpI62El+JsUgy8JoexGuRCILo6A8eMig==
X-Gm-Gg: ATEYQzy7Ou8Y6Ep9CT5AHUmeyLZylc2KTOD2pSpcq8J1BM/mGI7fVKYCaACmVuP4L48
	8CIM/VvSfCQtnVJQOLp8rOWX9vz3eEn4nMBPrm40Pz25T60DDMAFCEQcxyhL6jC8lEgrM2uTnkj
	2HwtcwnFYBQVkJLNihmwFUvWZcJArp/H4GPJX94oLrWvv4BQWRpota9o32kkSYeTIWREvH7PHMD
	wZUOWyBum/w1HbPunkK1T8UoF6RId6F0TqnAAIurbvVz9g9UqGqYgY8fOud4fv7RSRPYBhHO6lv
	lQ5MbKkG8fDZR1xf5raDXwg02/DIEbCtSwArenKZSuBYKfMqT4imr7jmBUxfVQIkj02OKsJBgJp
	ivzxjpxXE1NsiCIqU0Exya2aFY8EgQt39Wsgb9O4YpoFN/fe7efjQb9Egr8cOnBKP/iziO2709d
	QCxssd/5doV2h5wW8qW+j0v+vKSALbC5PbpJzDiILSlUO2W3WPvaAgs+glkA==
X-Received: by 2002:a17:903:1acd:b0:2ad:6f9b:7818 with SMTP id d9443c01a7336-2b042d8f2f4mr4941305ad.23.1773675375125;
        Mon, 16 Mar 2026 08:36:15 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56c7b5sm123061125ad.9.2026.03.16.08.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:36:14 -0700 (PDT)
Date: Mon, 16 Mar 2026 15:36:10 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	Sairaj Kodilkar <sarunkod@amd.com>
Subject: Re: [PATCH v5 06/10] iommu/arm-smmu-v3: Add a usage counter for cmdq
Message-ID: <abgjagJWs19zqL3J@google.com>
References: <20260126151157.3418145-1-praan@google.com>
 <20260126151157.3418145-7-praan@google.com>
 <CAE2F3rD0aoTXJBnS4SPHLEEst6cTvoUxNywRZ1RhdgwNA_0JTA@mail.gmail.com>
 <aa8jkLD0l2WqMnyG@google.com>
 <CAE2F3rBFRSTC7bFCYTCit1-OKrT3jB-fwYGu_UJbwX+7aE65eA@mail.gmail.com>
 <abBMy5MgrrOlofDF@google.com>
 <CAE2F3rA_uyYGx2PCHMpFPWD6B4_2WxK-ahpoRHioXfuNf5Mpxw@mail.gmail.com>
 <abFzyWG-ASb1Nv4J@google.com>
 <CAE2F3rDh4c4KzEqapu-qQw9MWZ3gqPkpawpnToEmnwMXZn1Qpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rDh4c4KzEqapu-qQw9MWZ3gqPkpawpnToEmnwMXZn1Qpw@mail.gmail.com>

On Wed, Mar 11, 2026 at 03:56:55PM -0700, Daniel Mentz wrote:
> On Wed, Mar 11, 2026 at 6:53 AM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Tue, Mar 10, 2026 at 09:43:05PM -0700, Daniel Mentz wrote:
> > > Hi Pranjal,
> > >
> > > I have thought about this further and would like to propose an
> > > alternative design.
> > >
> > > A key difference in this design is that no commands are written to the
> > > command queue, and the producer index is not updated while the SMMU is
> > > suspended.
> > >
> > > Similar to the existing CMDQ_PROD_OWNED_FLAG, we could define a new
> > > flag, CMDQ_PROD_STOP_FLAG, stored in cmdq->q.llq.prod.
> > >
> > > In arm_smmu_cmdq_issue_cmdlist():
> > > Perform "old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);".
> > > If CMDQ_PROD_STOP_FLAG is set in the variable named old, return from
> > > arm_smmu_cmdq_issue_cmdlist() immediately.
> > >
> > > In the Suspend handler:
> > >
> > > 1. Clear SMMU_CR0.SMMUEN.
> > > 2. Set CMDQ_PROD_STOP_FLAG in cmdq->q.llq.prod.
> > > 3. Wait until CMDQ_PROD_OWNED_FLAG is cleared from cmdq->q.llq.prod.
> > > 4. Wait until cmdq->owner_prod matches cmdq->q.llq.prod (excluding the
> > > CMDQ_PROD_STOP_FLAG).
> > > 5. Wait until cmdq->lock is 0.
> > > 6. Clear SMMU_CR0.
> > >
> > > In the Resume handler:
> > > Follow the same logic as your patch, but clear CMDQ_PROD_STOP_FLAG in
> > > cmdq->q.llq.prod instead of setting nr_cmdq_users to 1.
> > >
> > > One benefit of this proposal is that it avoids adding a new atomic
> > > variable that multiple CPU threads might compete for. Instead, we
> > > reuse existing atomic operations, which should reduce the performance
> > > impact for server use cases where many CPU threads compete for command
> > > queue access.
> > >
> >
> > I like the idea/direction! Although, there could be a few (solvable)
> > challenges, for example:
> >
> > 1. Abandoned Command Batch
> >   In the SMMUv3 driver, cmdq->q.llq.val is the shared global state in
> >   RAM. The cmpxchg is the "Point of Commitment." Consider the following
> >   sequence of events:
> >
> >    a. Assume STOP_FLAG is already set. Global prod is 10 | STOP_FLAG.
> >    b. CPU-A calls issue_cmdlist. It reads the global state:
> >       llq.val = 10 | STOP_FLAG.
> >    c. CPU-A calculates its new target:
> >         head.prod = 14 | STOP_FLAG | OWNED_FLAG.
> 
> head.prod is calculated like so, and queue_inc_prod_n() will clear the
> CMDQ_PROD_STOP_FLAG.
> 
> head.prod = queue_inc_prod_n(&llq, n + sync) |
>      CMDQ_PROD_OWNED_FLAG;
> 
> You're bringing up a good point, though. This would clear the
> CMDQ_PROD_STOP_FLAG which we don't want.
> 
> >    d. CPU-A executes: old = cmpxchg(&cmdq->q.llq.val, llq.val, head.val)
> >       The swap succeeds because the global state was exactly llq.val.
> >       Global prod is now 14. We have just told the entire system that
> >       there are 14 commands.
> >    e. CPU-A now checks the old variable. It sees STOP_FLAG is set and
> >       returns immediately.
> >
> > CPU-A has "reserved" the indices 10, 11, 12, and 13 in the global
> > producer pointer, but it never wrote the commands to those memory slots.
> > Indices 10–13 now contain garbage/stale data. When the SMMU resumes and
> > processes up to index 14, it will execute that garbage cmd leading to a
> > fault (CERROR_ILL).
> >
> > 2. The OWNED_FLAG Deadlock
> >
> >    a. The CPU who finds OWNED_FLAG is 0 in the cmpxchg becomes the owner
> >       Its job is to gather all concurrent work and update the hardware.
> >    b. Any subsequent CPUs that find OWNED_FLAG is 1 in the cmpxchg. They
> >       write their commands to RAM and then just wait. They rely on the
> >       Owner to "kick" the HW for them & to clear the flag for the next
> >       batch.
> >
> >   The Deadlock Scenario:
> >    a. Suspend Handler: Sets the STOP_FLAG in the global cmdq->q.llq.val.
> >    b. CPU-A (The Owner): Executes cmpxchg. It moves the global prod from
> >       10 to 14. Because it was the first in this batch, it does not set
> >       the OWNED_FLAG.
> 
> Everybody sets the OWNED_FLAG in
> 
> head.prod = queue_inc_prod_n(&llq, n + sync) |
>      CMDQ_PROD_OWNED_FLAG;
> 
> The OWNED_FLAG is always set when any CPU breaks out of that first
> do/while loop in arm_smmu_cmdq_issue_cmdlist.
> 
> >    c. CPU-B (The Follower): Executes cmpxchg. It moves the global prod
> >       from 14 to 18. Because it is joining CPU-A's batch, its cmpxchg
> >       sets the OWNED_FLAG in the global state.
> >    d. Now, CPU-A checks the old value, sees STOP_FLAG, and returns.
> >       CPU-B checks the old value, sees STOP_FLAG, and returns.
> >    e. The Consequence: The global state cmdq->q.llq.prod now has the
> >       OWNED_FLAG set.
> >    f. Suspend Handler: Calls Wait until CMDQ_PROD_OWNED_FLAG is cleared
> >    g. Since the Owner (CPU-A) should clear that flag (it does so at the
> >       very end of the function). The Suspend Handler will spin on this
> >       flag forever.
> >
> > This can be solved by checking the flag before setting the OWNED_FLAG.
> 
> Good point. We should check llq.prod for CMDQ_PROD_STOP_FLAG at the
> beginning of the do/while loop in arm_smmu_cmdq_issue_cmdlist and
> return early if it's set. The function arm_smmu_cmdq_issue_cmdlist
> should never clear CMDQ_PROD_STOP_FLAG.
> 
> > While the atomic counter (nr_cmdq_users) used in v5 adds an tomic, I
> > believe that it provides a cleaner "gate" that prevents CPUs from ever
> > entering the "Commitment" phase once a suspend is imminent (with fixes).
> >
> > However, I agree that the atomic cntr can cause pref drops on servers.
> 
> I think another benefit of my approach is that it avoids the problem
> where a high rate of calls to arm_smmu_cmdq_issue_cmdlist can starve
> the suspend handler. I'm afraid that with the nr_cmdq_users approach,
> we might end up in situations where the suspend handler times out
> because nr_cmdq_users never drops to 1.
>

I agree.

> > I'm okay to adopt Daniel's direction (it only impacts 2 patches) & post
> > a v6. However, given we've been working through this for a year now, I'd
> > want to make sure we have a solid consensus on the design from everyone.
> > I felt with v4 that we have consensus on the design but it still seems
> > to be evolving. I’m ready to post v6 once we settle on the path forward.
> 
> I think the fastest way forward is to post an updated patch right
> away. We can then use that as a baseline for discussions.

Agreed. I'll think through this CMDQ_STOP_FLAG approach (addressing the
issues I've discussed above) and post a new version soon.

Thanks
Praan
