Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B80396D06
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 22:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773269831; cv=pass; b=p2muRO6RZxJHb6LHU0nZqoGf+soXL4PJ2mHKE/ZZLixZ1KU0LQOMc8RaR9lcA7j+zRyCEdXlHVC6XtKGY+4eXYtPi7410uTrcmegA3io9Gp7bXWvALsjI2FAly76M0H9qekn7W9eZxgTPywo1D5Scr5mIQhlS10ehUIf5uaqSUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773269831; c=relaxed/simple;
	bh=oxdaN2xUwgHTeldZQaqH2ya+/6kHi+K/w4bfyHKdsns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=us0NT/ng7XmDnikIyRdnvj4cQOWpcBERKPCNSGGWqZQDd10T4HGeof3XH4oe3VsulX3xnBhSjoHjDYCD9RNiNjKcElH8Nl1x2OhEgwS1ZXYD2my9sbs+u65/grDlnLneNb+6ahXalfbW0ZYla9ZEOVhlwFUKb9kL7YwJb8BhF90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TEQ+7VoK; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TEQ+7VoK"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-660a4aa2aa9so5149a12.0
        for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 15:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773269828; cv=none;
        d=google.com; s=arc-20240605;
        b=fktQftta5cF+4dpCCT1MaMkHhxZmutO4dca3V7lzZD63czMDwJXcAhRGh5p50jcL79
         8OyR5kUTdJWfdt+icYumYD97giRVuI5mgvd7KAHXsNhLRe+GxFXlfuK+RJvxWV+VWK9z
         FQs0wTS6mLNatCUGYyPlffG5mWl8h75J+doxgR9mDGGF2Hs4fMiq70Dpo30QvhPhu0Ec
         WhPOf/L+q67mK7khU33zR0U4xvxWb2UB5CUSUiZdaQtXLXXLRHG7fxlP+hi+I9PYU3VK
         pDBtCpJmci/2g36HInjf8nAJH+0Ns6YrGgSG8FtA50PkZDjqVUy372s9WThq/Mn6i07c
         QtUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TKsR3z8HhPE1ZCao2kO53rFjH4B6LwgCnRhvwTAWu8k=;
        fh=Cr9Gz+4KxVp4Ci1moPY7g4WpWFGCr0a9bcVWr63STi0=;
        b=Nep8KMrDeO230gPIGgU1v06pfgGjOQ+uN0wP+OeDUX0XVC57J0eKDuIAUmOTfyKyY8
         DvZo9omWy74cjRXffpFm29vP35bpAhkdkyEi7LipTFM9nzjZS40kLKOxlU0TILNLWPwK
         idAJ7dAH1pGoIjou5LFEBB+ExdE822SOLM/ilADqBS9FxRuaUkXuP3Kbh6Iscru4Xvel
         vOAy8yxwre4t7pdLHn4D8oS8vmXFXRlRmKiY8rAOQwhPwZIACSSCHRW1wjkAzDEiKL89
         zvJsVIupzFrPJY7MaYTB8+2JyE865vO79UBtsRO3/GEcHzOuLgevUOEZkBKAbD6BVvnQ
         0RHQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773269828; x=1773874628; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKsR3z8HhPE1ZCao2kO53rFjH4B6LwgCnRhvwTAWu8k=;
        b=TEQ+7VoKYDePp6rAz0a7IuKWl9OiPCwheAFdx2JiaFzWVofe48QyqRynl1zppqpTJX
         H8vgk87Az4IY/EtEOycmETihU4tIjQPWcicfZ5WDTLp9oSJJPfKbU0tHKDqgoDz5AaWW
         VLiWvLFwwcQU12m6Tp/x71z1DUiED1EjE1DgqSDoYSdHApVHoC1nUJjLyqMmV5UuEhGt
         W/SXmlRON29K1ywI8RN10Ef2uvQNUwVM9OoRt/up/Ei8t6WReTydX6wMPFaIwn2wpQsa
         5f0QOwWkUchwjpZqXuCvMYx7eIbReKIGgQJ9awxCV4YrXiMcjE8fUtdRauPJ8uMzl7tI
         yG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773269828; x=1773874628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TKsR3z8HhPE1ZCao2kO53rFjH4B6LwgCnRhvwTAWu8k=;
        b=BNrnNS3iGke9snNi0BbrW6eV9OvtfBiENzv/Z9DzX6LwTt6SWGMKvaWnCKQ7+3o2I6
         /sv2Z12YNefFzMbfrhjmxyWf8hp1KMH1h8qOC7F9ELDdactBzaqMpcIZUcYxzu0m99mR
         hGG1iPThqkUkLLMfkg0u8y1UapBm80VP+q1CEDugb636r1TERWPGkG+FwGg0IsLyrcvQ
         7ppSEBkDWGXmHbvs/ritrn3Rsised16kI+G3DjZoOexBGcwM4uFegCcRwbxyEbcXTdHv
         tQ2FOivYo666aMeChrGlAO9xQCFOSL2IYAsM24DiHP+FKpHBwIW8XHUBkQngVNbtxaPN
         BDvg==
X-Gm-Message-State: AOJu0Yy8x0M6CQsiifxlrLDazakpOVDP6k/wyRnnynxuXlE5fqkKoK+N
	4as7QWiG3s2wxO7+Y5cvyYm/dm/TxcfCFFrUQ/ZebEHX9mCbzo37aXiGveFv1cJlmU2jwhO+q5c
	lndNlt5idg1TGzRtdT5ox2ErO+3+CEXe5dddRIIIp
X-Gm-Gg: ATEYQzxJJ3bq8nb2EsyR0tMbMx6GUIfj+qbOwES8xm2DL/gKDPZbMuRd6s5DU2dYYLX
	xy62ONAkkuARXdyA1X6ozTbS4fWw89d8iGVTYpQrL5le8SWKA9x45/mcuWlPwH0/B98bqOhCLYU
	YNqZVyGsm9TtyZ6+sK/ua0zzNAFeKepyYcAagG8BmPU/wWNPBv0w/U0QyILPvsApjK1vXS1D4uv
	jiiaFbqTnXzaPFYQ8W+FkhbfYC0UtTO+R3JX3g7zb0dWOC871rGClJzj/hMg5Bte6Hp+uNj2etb
	w5719qQkL8U8eJ5dgyacGolcNUZmBudeZqX0VA==
X-Received: by 2002:aa7:cb94:0:b0:660:aa4b:c9c6 with SMTP id
 4fb4d7f45d1cf-663580ef358mr15786a12.12.1773269827842; Wed, 11 Mar 2026
 15:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260126151157.3418145-1-praan@google.com> <20260126151157.3418145-7-praan@google.com>
 <CAE2F3rD0aoTXJBnS4SPHLEEst6cTvoUxNywRZ1RhdgwNA_0JTA@mail.gmail.com>
 <aa8jkLD0l2WqMnyG@google.com> <CAE2F3rBFRSTC7bFCYTCit1-OKrT3jB-fwYGu_UJbwX+7aE65eA@mail.gmail.com>
 <abBMy5MgrrOlofDF@google.com> <CAE2F3rA_uyYGx2PCHMpFPWD6B4_2WxK-ahpoRHioXfuNf5Mpxw@mail.gmail.com>
 <abFzyWG-ASb1Nv4J@google.com>
In-Reply-To: <abFzyWG-ASb1Nv4J@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Wed, 11 Mar 2026 15:56:55 -0700
X-Gm-Features: AaiRm52dj2Yu0SIcPC999cSYjdiaGUjqY0_6MVTe4UX2TbSyfQOW2OGY0S2EGeg
Message-ID: <CAE2F3rDh4c4KzEqapu-qQw9MWZ3gqPkpawpnToEmnwMXZn1Qpw@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] iommu/arm-smmu-v3: Add a usage counter for cmdq
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	Sairaj Kodilkar <sarunkod@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 6:53=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Tue, Mar 10, 2026 at 09:43:05PM -0700, Daniel Mentz wrote:
> > Hi Pranjal,
> >
> > I have thought about this further and would like to propose an
> > alternative design.
> >
> > A key difference in this design is that no commands are written to the
> > command queue, and the producer index is not updated while the SMMU is
> > suspended.
> >
> > Similar to the existing CMDQ_PROD_OWNED_FLAG, we could define a new
> > flag, CMDQ_PROD_STOP_FLAG, stored in cmdq->q.llq.prod.
> >
> > In arm_smmu_cmdq_issue_cmdlist():
> > Perform "old =3D cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);"=
.
> > If CMDQ_PROD_STOP_FLAG is set in the variable named old, return from
> > arm_smmu_cmdq_issue_cmdlist() immediately.
> >
> > In the Suspend handler:
> >
> > 1. Clear SMMU_CR0.SMMUEN.
> > 2. Set CMDQ_PROD_STOP_FLAG in cmdq->q.llq.prod.
> > 3. Wait until CMDQ_PROD_OWNED_FLAG is cleared from cmdq->q.llq.prod.
> > 4. Wait until cmdq->owner_prod matches cmdq->q.llq.prod (excluding the
> > CMDQ_PROD_STOP_FLAG).
> > 5. Wait until cmdq->lock is 0.
> > 6. Clear SMMU_CR0.
> >
> > In the Resume handler:
> > Follow the same logic as your patch, but clear CMDQ_PROD_STOP_FLAG in
> > cmdq->q.llq.prod instead of setting nr_cmdq_users to 1.
> >
> > One benefit of this proposal is that it avoids adding a new atomic
> > variable that multiple CPU threads might compete for. Instead, we
> > reuse existing atomic operations, which should reduce the performance
> > impact for server use cases where many CPU threads compete for command
> > queue access.
> >
>
> I like the idea/direction! Although, there could be a few (solvable)
> challenges, for example:
>
> 1. Abandoned Command Batch
>   In the SMMUv3 driver, cmdq->q.llq.val is the shared global state in
>   RAM. The cmpxchg is the "Point of Commitment." Consider the following
>   sequence of events:
>
>    a. Assume STOP_FLAG is already set. Global prod is 10 | STOP_FLAG.
>    b. CPU-A calls issue_cmdlist. It reads the global state:
>       llq.val =3D 10 | STOP_FLAG.
>    c. CPU-A calculates its new target:
>         head.prod =3D 14 | STOP_FLAG | OWNED_FLAG.

head.prod is calculated like so, and queue_inc_prod_n() will clear the
CMDQ_PROD_STOP_FLAG.

head.prod =3D queue_inc_prod_n(&llq, n + sync) |
     CMDQ_PROD_OWNED_FLAG;

You're bringing up a good point, though. This would clear the
CMDQ_PROD_STOP_FLAG which we don't want.

>    d. CPU-A executes: old =3D cmpxchg(&cmdq->q.llq.val, llq.val, head.val=
)
>       The swap succeeds because the global state was exactly llq.val.
>       Global prod is now 14. We have just told the entire system that
>       there are 14 commands.
>    e. CPU-A now checks the old variable. It sees STOP_FLAG is set and
>       returns immediately.
>
> CPU-A has "reserved" the indices 10, 11, 12, and 13 in the global
> producer pointer, but it never wrote the commands to those memory slots.
> Indices 10=E2=80=9313 now contain garbage/stale data. When the SMMU resum=
es and
> processes up to index 14, it will execute that garbage cmd leading to a
> fault (CERROR_ILL).
>
> 2. The OWNED_FLAG Deadlock
>
>    a. The CPU who finds OWNED_FLAG is 0 in the cmpxchg becomes the owner
>       Its job is to gather all concurrent work and update the hardware.
>    b. Any subsequent CPUs that find OWNED_FLAG is 1 in the cmpxchg. They
>       write their commands to RAM and then just wait. They rely on the
>       Owner to "kick" the HW for them & to clear the flag for the next
>       batch.
>
>   The Deadlock Scenario:
>    a. Suspend Handler: Sets the STOP_FLAG in the global cmdq->q.llq.val.
>    b. CPU-A (The Owner): Executes cmpxchg. It moves the global prod from
>       10 to 14. Because it was the first in this batch, it does not set
>       the OWNED_FLAG.

Everybody sets the OWNED_FLAG in

head.prod =3D queue_inc_prod_n(&llq, n + sync) |
     CMDQ_PROD_OWNED_FLAG;

The OWNED_FLAG is always set when any CPU breaks out of that first
do/while loop in arm_smmu_cmdq_issue_cmdlist.

>    c. CPU-B (The Follower): Executes cmpxchg. It moves the global prod
>       from 14 to 18. Because it is joining CPU-A's batch, its cmpxchg
>       sets the OWNED_FLAG in the global state.
>    d. Now, CPU-A checks the old value, sees STOP_FLAG, and returns.
>       CPU-B checks the old value, sees STOP_FLAG, and returns.
>    e. The Consequence: The global state cmdq->q.llq.prod now has the
>       OWNED_FLAG set.
>    f. Suspend Handler: Calls Wait until CMDQ_PROD_OWNED_FLAG is cleared
>    g. Since the Owner (CPU-A) should clear that flag (it does so at the
>       very end of the function). The Suspend Handler will spin on this
>       flag forever.
>
> This can be solved by checking the flag before setting the OWNED_FLAG.

Good point. We should check llq.prod for CMDQ_PROD_STOP_FLAG at the
beginning of the do/while loop in arm_smmu_cmdq_issue_cmdlist and
return early if it's set. The function arm_smmu_cmdq_issue_cmdlist
should never clear CMDQ_PROD_STOP_FLAG.

> While the atomic counter (nr_cmdq_users) used in v5 adds an tomic, I
> believe that it provides a cleaner "gate" that prevents CPUs from ever
> entering the "Commitment" phase once a suspend is imminent (with fixes).
>
> However, I agree that the atomic cntr can cause pref drops on servers.

I think another benefit of my approach is that it avoids the problem
where a high rate of calls to arm_smmu_cmdq_issue_cmdlist can starve
the suspend handler. I'm afraid that with the nr_cmdq_users approach,
we might end up in situations where the suspend handler times out
because nr_cmdq_users never drops to 1.

> I'm okay to adopt Daniel's direction (it only impacts 2 patches) & post
> a v6. However, given we've been working through this for a year now, I'd
> want to make sure we have a solid consensus on the design from everyone.
> I felt with v4 that we have consensus on the design but it still seems
> to be evolving. I=E2=80=99m ready to post v6 once we settle on the path f=
orward.

I think the fastest way forward is to post an updated patch right
away. We can then use that as a baseline for discussions.
