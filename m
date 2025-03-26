Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAA6EEBB
	for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 04:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742964772; cv=none; b=jqzCW1vrKVxNK7rx1yYlCeu+yL2p07BW3GYrJqel/OyTotTeI7/9ROJ7qNfiosBNRQt6gHQ6EfnX+LL67oxL8kFftk0sWyx1UpBj49ZlsLe8S0jf7Le9mBBeoI2d7JLsFUiKSXqCVEdbfLN0q/pdAsfalb78YKyxR9OfLW0zBfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742964772; c=relaxed/simple;
	bh=CUpb+x+CawLQjFYGHSYI1b7hNp4srwUJ7q2x9n0J94A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSMVjGkWEbREdSMnOgRNqZ9cujDtRFytuS1xv4hXcFJ3UBAfiQIhpQ9ooiLZbL405q+nbASYdFpjsCQvHBA3QuPC66HwaE1e0shg+lau3xbKXxei87uQCczrH6NqhUP+MYwsX2tIF2WlCWXTZ7j/Yr+VYyPW/x/p3N+LOsWbhAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xf2jm0/F; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xf2jm0/F"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e50bae0f5bso6918a12.0
        for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 21:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742964769; x=1743569569; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jG6uNSAb2anZ5lLsLOMuGJddl6ZjxQqT9p9yoP0OUA=;
        b=xf2jm0/Fg/+XzgSKwl7U0OJ1Y5eMAUeJdqNLxuRogOsaSWsTVgkfoEevlTotxFs+hE
         pKlVQL/huKAOpNqzAoCPm9ceK4Rhc1z7OX9ho7OygMUB/VmrRoIY509R53e/51frVIuT
         D9vB6HD3SArvCm5ykpLEZDLw94jndiF4Cyh3F8a75TJ/P9hr6gwF6lLT44WSCAiztlcP
         ZTgKRshv1eyL/BkxPzGS/f/hP3MvCtZXwwn0k00rqg6zu88VbmcrQChrqbDEm0QqKHVy
         iNJgYKGc8BeAyIdJ6Hb2IOxtTOGxkGdLCYT1cdFM/t8lxsZkXaDkE01xd5k82NR2MzeS
         67IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742964769; x=1743569569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jG6uNSAb2anZ5lLsLOMuGJddl6ZjxQqT9p9yoP0OUA=;
        b=VEAj+sl2QCTd+sjXlthAZUi8uB/PLP9K5XWebpmPuQ6kmRl4wLqNJoJsa6UhJjZAxy
         dN8pNwKSS6yKKo3nPjhIV1rUt1BhFR3gx/P5afB7EINMVXjZvfgBL0xD3WQ7lQx1oZ6V
         3Q4NDqFIgAoKr5R55ziEIj+NQjgMcenr+MOg1V6gbKLgVBDYUOB1IfjJ4X3uC30FPwIL
         6bwSQOrC2/MALBEZEkkmi8iCDgonsxxPiKsEs3fIsl8a47f/rPMA6R5Sj4LijdqEs/4H
         pTCV1OkIPBFWI26MsBA5Q/rdQ0aCtnAWdPJR9UFHaTrLho+YoDLrPciOCSk/1wApBDhQ
         BMRA==
X-Forwarded-Encrypted: i=1; AJvYcCVeweaC8tEnQVjNKlluH/QTiYC7cqwpcD0RpxPEecaAJvZcwMnZbreBxfAB/swNn124uIhbqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKgOWKHMCreEQ5negiZ/uvkGGpVMv1NL60llzQieHhRFnc/bR6
	7kZ2/sLSzxLRMdep8UzyoQs3nlReOqSC8SKA+RGQrf08SBw9B17V94ylVh/hHvjrWmmmiJZhkAb
	RSiILGc/mp4hHZaEHUNDG+RTUxnbliJLtUh/M
X-Gm-Gg: ASbGnculYxCLdhJKSB8zyKOP7IH16D76+LwB9gMSGPwmtBse3ptQCODHywvvFS2CydY
	gdT7y/B/BLWYQ+clVG5YCh9+qH3vYtLovwD64uTG5fSpSYovupzy9bFyKsfUjNrjStuqE+dV+J1
	+jIzxxhUTmuLP4EBSTnaqMd5PtSbCoTuoaauX6FnFjLofh6H8/x40iAAHSuUjB
X-Google-Smtp-Source: AGHT+IGKcqZE00KIvAq5b1tG9KmxXU46x3XH/z7Mo3WfhqgrM6vrsdFmHWmowMZwjgi/N1WefPaAIcjBcVWDn9/MVTo=
X-Received: by 2002:aa7:cd6c:0:b0:5e5:b44c:ec8f with SMTP id
 4fb4d7f45d1cf-5ed56d9a4c6mr34119a12.3.1742964769104; Tue, 25 Mar 2025
 21:52:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250319004254.2547950-1-praan@google.com> <20250319004254.2547950-4-praan@google.com>
In-Reply-To: <20250319004254.2547950-4-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 25 Mar 2025 21:52:37 -0700
X-Gm-Features: AQ5f1Jonfmh1rUkLQeY2RtzD1uNIjmdVjZ-nCWbySVZkoWViBKGjVy0KAVmZ4xQ
Message-ID: <CAE2F3rCdA=45317Z_+J86G2QtLZYZwDT-qPVD7ymmAfToBcwQA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, 
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 5:43=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> +{
> +       struct arm_smmu_device *smmu =3D dev_get_drvdata(dev);
> +
> +       /* We might get the vcmdq */
> +       struct arm_smmu_cmdq_ent cmd =3D {
> +               .opcode =3D smmu->features & ARM_SMMU_FEAT_E2H ?
> +                       CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA,
> +       };
> +
> +       struct arm_smmu_cmdq *cmdq =3D arm_smmu_get_cmdq(smmu, &cmd);
> +       struct arm_smmu_ll_queue *llq =3D &cmdq->q.llq;
> +
> +       /*
> +        * Since suspend is invoked when all clients have been
> +        * we don't expect more commands to be added to the cmdq.
> +        * Thus, wait for all existing commands to complete.
> +        */
> +       arm_smmu_cmdq_shared_lock(cmdq);
> +       arm_smmu_cmdq_poll_until_empty(smmu, cmdq, llq);

llq is pointing to cmdq->q.llq which means that
arm_smmu_cmdq_poll_until_empty will write to cmdq->q.llq.cons which I
understand is not allowed unless you are holding the exclusive lock or
are the only thread holding a shared lock.

How about the following:

1. Call arm_smmu_cmdq_exclusive_trylock_irqsave(). If this fails,
print an error message.
2. Call __arm_smmu_cmdq_poll_until_consumed on the current producer index.
3. Update cmdq->q.llq.cons
4. Call arm_smmu_cmdq_exclusive_unlock_irqrestore()


> +       arm_smmu_cmdq_shared_unlock(cmdq);
> +
> +       /* Disable all queues */
> +       arm_smmu_device_disable(smmu);
> +
> +       /* Abort all transactions to avoid spurious bypass */
> +       arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> +
> +       /* Free all MSIs (re-allocated on resume) */
> +       arm_smmu_free_msis(dev);
> +
> +       dev_dbg(dev, "Suspending smmu\n");
> +       return 0;
> +}
