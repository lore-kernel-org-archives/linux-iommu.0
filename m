Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B73E1DFF7
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 04:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776831927; cv=pass; b=QaqKkSj/tij/U67f4ydnr6fSTljHAtVZH/KE1ZthtKaH33qEC2ryCTRuOL7v9jdP1DKXKNpCeyd6nve8lwsz6UJwi6QZCyj5U+vc/6TQQLZuYiV8D3CZ7fMHQjcLudrKvATHcf1ySA4oPwUvI1HfWMOJdnl5AkWRy11Jy/0cKhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776831927; c=relaxed/simple;
	bh=FOX3+vhREaXYxSPgQKDaEr0VdH3PHTnFxzo3NEXLTsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOJSlbZjdrXTq1vaKOqjkF7JTQkQ6k9l57myrkUqJgpV3ebuILJhma+agVApb6JzW6nLtOd/UbwBxZc7db1VW4/Od1Xk1xZBDUdTSZ/JqxVEMIQg+KPFog/JuRoHkjh8iVqgpbnmp9FFEsDWMBQAl7y4GCf3SnnILawgXkyOC6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mihZspjR; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mihZspjR"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d6b393d60so2743151cf.0
        for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 21:25:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776831925; cv=none;
        d=google.com; s=arc-20240605;
        b=gphMuwXyn2s46li7z99kmdx8SYLPch03xwkqXBPKUS+92/iRNxSzEkPT7hqq6LOFOp
         JRnYKlZ3gP5uwMUxl5/T6AOkiJqNjmgsOfhrGjufdIlUiE3kUEFrZta05xyHBttwTMoO
         tn1nHLyHKeClnxpW90i6s5VsRAjPBtjEOvs/qwYFVrtyyKK1xcCrZKnCa09h+CApI35n
         s33f+pHk1cjR56ObH2euXad5VXUxVD4uqYcrhdxR/SgJl4oyOdqVi75bv2P/OwvqcUak
         q4+5InH9oOnkfsg3YjtdcKP8pKhA8Oh+KzlrKk3WFmJLRLDi8E7jOKMf1SMnHSN37Wc/
         FVwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9D0j/3oQfBs8NXO/slNWNIVqJUE9ti0520rts/XnBIQ=;
        fh=l6d/N6u1hLHPo4TGqiX7B6XhUFrf2YjgyiVnG6QkPqQ=;
        b=VLjbIDuU4nq9PiUr03f8u7wJetpyOiRa09GRaeBlToVP0taHVIdhPS6HnM7TTMwuT/
         yPdb+Ln6mUQv/yLJ/b68T8YizXwWCqEnGeeDTGuByGeHMU8BDZZZtHPZkex1YLA+z3rU
         B09SQerDib5IM66rpssBqPEtdqvbKvZYNrKieysA94+sZCTg80qKfI9+e4uyimBY+yOa
         OeepHGnlLEE21FtKz2w9kV1990lIgRT4h4Q6Nz6dOx4bw5yvSxj38aCTAJGhgW3laWSw
         MEr0uDfHyKtEA7QTE/9NGJknN7lfyTXKT/stUU/KQrK1EZFLJ+MyE4DPj9HFOOLOVO+i
         MnPg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776831925; x=1777436725; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9D0j/3oQfBs8NXO/slNWNIVqJUE9ti0520rts/XnBIQ=;
        b=mihZspjRWaw7edFrm3i8zLPwbr+xX0Evhid4WB4wyx0e+KY24G7B04OqQn2VazJemF
         iOeMTrRNXskLpokLYdMuevqhyKMDHucpYsT2c4oclvj1tgdLNoWswM0lzyQpsA1HJO3h
         B0juktFsSLUVZlNohIEy01ZAuCaAygp9xznLK1GSiJSQ2SKSub+n0hE+O1Mi3xvo5h6V
         ceXg/4+j5yCjw/cXZNwXcczdQdNY0Z0SSVZZ6UWU78TbLK9GwOUJn72PrWKaWnQ0yIx5
         0xAUp4GDN9hBSqcnVNuCMBwD9PAjiZZDdJdITOIO1NX17Sh9KhsZrqPFLQpKCFZLwxVo
         xsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776831925; x=1777436725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9D0j/3oQfBs8NXO/slNWNIVqJUE9ti0520rts/XnBIQ=;
        b=tNfxn6Gy7im8y0ZaivMxc5/DTp64TdLoa9PTNCBm2TQzKglg9NHT5qsgw4eTAJVwpS
         bvqDGMpMfu3F5k6MCNOCBhUP4tk7KOV/L4BEi9SewhB7cTXnJrKw7mveYP2Y0+Jog9oH
         d8AtWaSWEvLa1QjYtJ9qS4ts2c80s77yIp7gnFPr+z0561WRe0yu+ZiTxJyciVHXXLKN
         gD08rIHUsU4+IltDk0ZHmBF5frrK7VObKQKy+tRXT1qooPWfgu6rEz21v230ff+ap67L
         hOxu651G2fcsj2T1onFPHm4Qtflb30S0unIzMHKtNhua5BDkNerulKDrTIWzm8Pyw4sW
         1SrA==
X-Gm-Message-State: AOJu0YyQxvEk/T2jLokyb8bWrkxvYXA1pDrkYAFKDqfPdN3Yw4kRWcBL
	JC7cDKsaJXb7Jh5c613uZfn51p2LyHBznRpetoc9YfWRE6kJOO0mdmu1nLGSQBla3suXRfF+nd6
	a/rImAP01BF18JJIhG5/AGNyUqYPqRnnP0pUqR6BV
X-Gm-Gg: AeBDiesBVNt6kKR8j0z5ZvQHYEOm13mSixdKJn/5G8gUYZKyCCCVD4U4W9H00LXC/fc
	FWaN5KJRtOQiR7ojvERDbgrIJXZ2SKJYP7vjnxloCpRszZxW5X4znR00mqah+xMmpq21vFpiFVZ
	LKJhLoubE9LRcL8UdRDhEtN+AtbiNw92XptDIrySQ2Qytj3XXupxlYpClR4vcuXI4qvkf5dNv4+
	CGPtY7X1FDeJsM+1hx3yBIn4PIl6ptKYbigwWxhYkE3PtC98zawrSnLR+VRfXyL32sB5rGr5i4d
	SqElKoRQ7+3+yhian6iimDEXew==
X-Received: by 2002:a05:622a:2599:b0:50e:41f3:6467 with SMTP id
 d75a77b69052e-50e42a9a87cmr8019281cf.12.1776831924678; Tue, 21 Apr 2026
 21:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260414194702.1229094-1-praan@google.com> <20260414194702.1229094-8-praan@google.com>
In-Reply-To: <20260414194702.1229094-8-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 21 Apr 2026 21:25:12 -0700
X-Gm-Features: AQROBzBw370H8TmqDtiFYY97jNBenunPvyuPnGhu90DR59I-norDaQbDrfaVf-o
Message-ID: <CAE2F3rCaBWtRruBbZcedrsLnkkETSniTWoxxYn+Lkac9ttsshQ@mail.gmail.com>
Subject: Re: [PATCH v6 07/10] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 12:47=E2=80=AFPM Pranjal Shrivastava <praan@google.=
com> wrote:
> +/* Runtime PM helpers */
> +__maybe_unused static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)

Please be consistent about placing the __maybe_unused attribute. I
believe that in the other functions, the placement is between the
return type and the function name.

> +
> +/*
> + * This should always return true if devlinks are setup correctly
> + * and the client using the SMMU is active.
> + */
> +__maybe_unused bool arm_smmu_rpm_get_if_active(struct arm_smmu_device *s=
mmu)
> +{
> +       if (!arm_smmu_is_active(smmu))
> +               return false;

I'm wondering if this check is redundant. What would happen if we removed i=
t?

> +
> +       if (pm_runtime_enabled(smmu->dev))
> +               return pm_runtime_get_if_active(smmu->dev) > 0;
> +
> +       return true;
> +}

> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> +{
> +       struct arm_smmu_device *smmu =3D dev_get_drvdata(dev);
> +       struct arm_smmu_cmdq *cmdq =3D &smmu->cmdq;
> +       struct arm_smmu_ll_queue llq, head;
> +       int timeout =3D ARM_SMMU_SUSPEND_TIMEOUT_US;
> +       u32 enables, target;
> +       u64 old;
> +       int ret;
> +
> +       /* Abort all transactions before disable to avoid spurious bypass=
 */
> +       arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> +
> +       /* Disable the SMMU via CR0.EN and all queues except CMDQ */
> +       enables =3D CR0_CMDQEN;
> +       ret =3D arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0, ARM_=
SMMU_CR0ACK);
> +       if (ret) {
> +               dev_err(smmu->dev, "failed to disable SMMUEN\n");

"failed to disable SMMU". "EN" is redundant.

> +               return ret;
> +       }
> +
> +       /*
> +        * At this point the SMMU is completely disabled and won't access
> +        * any translation/config structures, even speculative accesses
> +        * aren't performed as per the IHI0070 spec (section 6.3.9.6).
> +        */
> +
> +       /* Mark the CMDQ to stop */
> +       llq.val =3D READ_ONCE(cmdq->q.llq.val);
> +       do {
> +               head =3D llq;
> +               head.prod |=3D CMDQ_PROD_STOP_FLAG;
> +
> +               old =3D cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.v=
al);
> +               if (old =3D=3D llq.val)
> +                       break;
> +
> +               llq.val =3D old;
> +       } while (1);
> +
> +       /* Wait for the last committed owner to reach the hardware */
> +       target =3D head.prod & ~CMDQ_PROD_STOP_FLAG;
> +       while (atomic_read(&cmdq->owner_prod) !=3D target && --timeout)
> +               udelay(1);

Should we just use the following line from arm_smmu_cmdq_issue_cmdlist()?

atomic_cond_read_relaxed(&cmdq->owner_prod, VAL =3D=3D target);

> +
> +       /*
> +        * Entering suspend implies no active clients. A race or timeout =
here
> +        * indicates a broken RPM or devlink dependency. We proceed anywa=
y to
> +        * prioritize memory safety (avoiding stale TLBs) over bus faults=
.

Can you elaborate on how broken dependencies will result in a stuck
cmdq->owner_prod?

> +        */
> +       if (!timeout)
> +               dev_err(smmu->dev, "cmdq owner wait timeout, (check runti=
me PM + devlinks)\n");
> +
> +       /* Drain the CMDQs */
> +       ret =3D arm_smmu_drain_queues(smmu);
> +       if (ret)
> +               dev_warn(smmu->dev, "failed to drain queues, forcing susp=
end\n");
> +
> +       /* Wait for cmdq->lock =3D=3D 0 to ensure last CMDQ_CONS_REG is w=
ritten */
> +       timeout =3D ARM_SMMU_SUSPEND_TIMEOUT_US;
> +       while (atomic_read(&cmdq->lock) !=3D 0 && --timeout)

Can we use

atomic_cond_read_relaxed(&cmdq->lock, VAL =3D=3D 0);

> +               udelay(1);
> +
> +       /* Timing out here implies misconfigured Runtime PM or broken dev=
links */
> +       if (!timeout)
> +               dev_err(smmu->dev, "cmdq lock !=3D 0, forcing suspend. Po=
lling CPUs may fault.\n");
> +
> +       /* Disable everything */
> +       arm_smmu_device_disable(smmu);
> +
> +       /* Handle any pending gerrors before powering down */
> +       arm_smmu_handle_gerror(smmu);
> +
> +       dev_dbg(dev, "suspended smmu\n");
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
> +{
> +       int ret;
> +       struct arm_smmu_device *smmu =3D dev_get_drvdata(dev);
> +       struct arm_smmu_cmdq *cmdq =3D &smmu->cmdq;
> +       struct arm_smmu_ll_queue llq;
> +
> +       /* Clear the STOP FLAG to allow CMDQ Submissions */

Clearing the STOP flag here seems premature. I propose the following sequen=
ce:

* Set up command queue (SMMU_CR1, SMMU_CMDQ_BASE etc.)
* Enable command queue
* Clear STOP flag
* Enable SMMU

By clearing the STOP flag, you allow arm_smmu_cmdq_issue_cmdlist() to
write to SMMU_CMDQ_PROD which then races against
arm_smmu_device_reset() which also writes to SMMU_CMDQ_PROD.

> +       llq.val =3D READ_ONCE(cmdq->q.llq.val);
> +       while (1) {
> +               u64 old_val;
> +               struct arm_smmu_ll_queue head =3D llq;
> +
> +               if (!(head.prod & CMDQ_PROD_STOP_FLAG))
> +                       break;
> +
> +               head.prod &=3D ~CMDQ_PROD_STOP_FLAG;
> +               old_val =3D cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, he=
ad.val);
> +               if (old_val =3D=3D llq.val)
> +                       break;
> +               llq.val =3D old_val;
> +       }
> +
> +       /* Re-configure MSIs */
> +       arm_smmu_resume_msis(smmu);
> +
> +       ret =3D arm_smmu_device_reset(smmu);
> +       if (ret)
> +               dev_err(dev, "failed to reset during resume operation: %d=
\n", ret);
> +
> +       dev_dbg(dev, "resumed device\n");

arm_smmu_runtime_suspend() prints "resumed smmu" (not "device"). Try
to be consistent with the language used in messages.

> +
> +       return ret;
> +}
