Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E55A1EB1AF
	for <iommu@lists.linux.dev>; Wed, 12 Mar 2025 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810860; cv=none; b=Dvl6sjerFb65VEHKNTfB3D//QjNa8gfVRT0ZHFN7SFlnMeXGk4tpyLYJvp6nv5q6NSQvd4pPC0kgpNj6CX8JFSQw58Pbb+RoSZcb06XnF+eXSQlu9qBv6uL9qyhzdwJXPWnxAzpcQNnqT9gDr0kN0k6mg1XpuXaMnZ6cgxXuG+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810860; c=relaxed/simple;
	bh=5y+PS9g0veYlrmU3sAeXgsPE1r2J3D9roA4qZSKQFZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2OkC7+khCZmKRvaF78Qv64URt5AoVqzYl1ZY7/8LolwHLuYrRsZy/YPldMJL3/ii0PnME2f9IrNExO+xCes60vK+aabwfJFGX4C6bPC7paYY7FGF1RZ/EMDB3FWrp67agjjY5jsRwPbY5WlxjBnXHq/ddoVQst3aNm7TAxNDzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPwCp7c3; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPwCp7c3"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d450154245so1713435ab.2
        for <iommu@lists.linux.dev>; Wed, 12 Mar 2025 13:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741810858; x=1742415658; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leDzS7eIFvtHXIQQ9eglVb87YCz9EMBQq+7ox6gc9Qk=;
        b=SPwCp7c3Tgw6ukwB3IF9Se4qfap4iogCsNp1t1909CrBo9vvYJ6fg30euMOgye7a3L
         5LFfZ8bZGsAKDdQ6h04+d3ys8M/FD+uCncpKXEsEqAHH3G439M1ZTlZF9RTOgBdP07dZ
         fIARweiipaNss5LOAZ6DPfpRBCsE38wFyFfsoCYS2fLHsgztWXVDaCf8PTdk/jbCOU2X
         VZ/cAyLFZXL1DdiiFe6zoNE30J9CywtvFYhac0pxDUhkdh6swTNLyoeGxEgpXsN+U+LU
         xpmymDKB+3wbWRIDYh9iGIkPLyO5gheOmoWIlKkAPTB2g8kDDiyigGytpbXAAYLMOxrm
         7Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741810858; x=1742415658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leDzS7eIFvtHXIQQ9eglVb87YCz9EMBQq+7ox6gc9Qk=;
        b=YbAlGZpOF3uDaINAUxS0v3PEwUjFsrZkOusrzBEBbYfg+hl0JIZ6fYwvb0FmhSfzSs
         e2smWkDeqGiaE3rczBt0aUHVUf/4pOB931b1EFPDGe1C2mtrjtb0EPc3Ki8BualmX9I5
         XU+EsWzk4SVvVogj1BXHubzuUjiOk3YlAT/UnOcDBsYZ1KBMfdUZ7LBaaMssdBu1mu88
         1hIbNzsDRJz7uJp17iRpF6fzR4Tg33rZ00RubCrPsFVryumPOrvfbrFTHymB0YOlQkNC
         Bc1r+GKGWxr7/FU+a+4W/ry64oaXlt28hZe0R/12ALimKO4Q29xeVBAgMuptZxzE8kyk
         URKw==
X-Forwarded-Encrypted: i=1; AJvYcCUS/ZT9AvKWMdYRDywJgHKaMGHc/EISjYWUsrlW+aVh4xrTY23X20A/mYotyzg1aRj7seu1Sg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9oNyeY8EQEZC952f4gN+sSYLCBG8sg4teFwS8j63+5W1anJdt
	tovvJVJ2cQJW986DNdOK/24NZ3f1FMKeCxoMAzxbQpj+oqE5wcj5CX/ryeXh8r8p+TmxSY/PEPG
	d6mC9k3jCzqhDTh1dJZv+H00jmpc=
X-Gm-Gg: ASbGncvvz7BOoOvmFvpY8cO/LRxcc0tDZUOo9gXQY+eBFDBSPc0mb932IOw0zwrefJO
	ayIrfVTpPKipO4l4CuwM8fri+4VB6Sn7koardeVL3KVtAYbH4k1cW5JExKoudVCAEEetmRO2o8J
	j9UDcwLBTFEqeARiuzBAQGGRIFc2rd53yl5HMnAAEyWxzKLe5GVho1XG0=
X-Google-Smtp-Source: AGHT+IED4T6DLDIo3SmEhvYjhrVEJRweu80/CkvzBfXjIoBQfKIpAoBxfGcLmBmU9mYcxJ7671LtEDQ7s45JySuNKLY=
X-Received: by 2002:a05:6e02:5a1:b0:3d4:700f:67e7 with SMTP id
 e9e14a558f8ab-3d4700f6b02mr43315405ab.17.1741810857983; Wed, 12 Mar 2025
 13:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250304-msm-gpu-fault-fixes-next-v4-0-be14be37f4c3@gmail.com>
 <20250304-msm-gpu-fault-fixes-next-v4-1-be14be37f4c3@gmail.com>
 <20250311180553.GB5216@willie-the-truck> <CACu1E7GzCiO2b7AFJSDC+pN2VD9VaD2aYz_GGymM3-xAUqd__A@mail.gmail.com>
 <20250312130525.GC6181@willie-the-truck> <CAF6AEGvqYithLFAKpfdkw35DEsUZ8rBt25-oWz3r=kaLt+RbQw@mail.gmail.com>
 <20250312164735.GA6561@willie-the-truck> <CAF6AEGskyoemQDrTXh=ewf61e-hVzWMjmqe=nX2J-65W5-M6Zw@mail.gmail.com>
 <2d47815d-6bee-4d1f-8b60-854763794bf6@arm.com>
In-Reply-To: <2d47815d-6bee-4d1f-8b60-854763794bf6@arm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 12 Mar 2025 13:20:45 -0700
X-Gm-Features: AQ5f1Jr0TpL3RJwurfnQxJV3DndqXaN2cYc9nQyOJQLHZCc7asLNsX0jHJOoZ20
Message-ID: <CAF6AEGvhixYvXghvD+itnSDjr7bO4i3Ls0Y-kXC-ohFN=CS0PQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] iommu/arm-smmu: Save additional information on
 context fault
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Connor Abbott <cwabbott0@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 11:01=E2=80=AFAM Robin Murphy <robin.murphy@arm.com=
> wrote:
>
> On 12/03/2025 5:23 pm, Rob Clark wrote:
> > On Wed, Mar 12, 2025 at 9:47=E2=80=AFAM Will Deacon <will@kernel.org> w=
rote:
> >>
> >> On Wed, Mar 12, 2025 at 07:59:52AM -0700, Rob Clark wrote:
> >>> On Wed, Mar 12, 2025 at 6:05=E2=80=AFAM Will Deacon <will@kernel.org>=
 wrote:
> >>>> On Tue, Mar 11, 2025 at 06:36:38PM -0400, Connor Abbott wrote:
> >>>>> On Tue, Mar 11, 2025 at 2:06=E2=80=AFPM Will Deacon <will@kernel.or=
g> wrote:
> >>>>>> On Tue, Mar 04, 2025 at 11:56:47AM -0500, Connor Abbott wrote:
> >>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iomm=
u/arm/arm-smmu/arm-smmu.c
> >>>>>>> index ade4684c14c9b2724a71e2457288dbfaf7562c83..a9213e0f1579d1e3b=
e0bfba75eea1d5de23117de 100644
> >>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >>>>>>> @@ -409,9 +409,12 @@ void arm_smmu_read_context_fault_info(struct=
 arm_smmu_device *smmu, int idx,
> >>>>>>>                                      struct arm_smmu_context_faul=
t_info *cfi)
> >>>>>>>   {
> >>>>>>>        cfi->iova =3D arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR=
);
> >>>>>>> +     cfi->ttbr0 =3D arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_TTB=
R0);
> >>>>>>>        cfi->fsr =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
> >>>>>>> -     cfi->fsynr =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYN=
R0);
> >>>>>>> +     cfi->fsynr0 =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSY=
NR0);
> >>>>>>> +     cfi->fsynr1 =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSY=
NR1);
> >>>>>>
> >>>>>> We already have an implementation hook (->get_fault_info()) which =
the
> >>>>>> qcom SMMU driver can override with qcom_adreno_smmu_get_fault_info=
().
> >>>>>> That thing dumps these registers already so if we're moving that i=
nto
> >>>>>> the core SMMU driver, let's get rid of the hook and move everybody=
 over
> >>>>>> rather than having it done in both places.
> >>>>>
> >>>>> As you probably saw, the next commit moves over
> >>>>> qcom_adreno_smmu_get_fault_info() to use this. The current back doo=
r
> >>>>> used by drm/msm to access these functions is specific to adreno_smm=
u
> >>>>> and there isn't an equivalent interface to allow it to call a gener=
ic
> >>>>> SMMU function so it isn't possible to move it entirely to the core.=
 At
> >>>>> least not without a bigger refactoring that isn't justified for thi=
s
> >>>>> series that is just trying to fix things.
> >>>>
> >>>> Ok :(
> >>>>
> >>>>>>>        cfi->cbfrsynra =3D arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CB=
FRSYNRA(idx));
> >>>>>>> +     cfi->contextidr =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB=
_CONTEXTIDR);
> >>>>>>
> >>>>>> I think the CONTEXTIDR register is stage-1 only, so we shouldn't d=
ump
> >>>>>> it for stage-2 domains.
> >>>>>>
> >>>>> Does it matter if we read the register though, as long as users are
> >>>>> aware of this and don't use its value for anything?
> >>>>
> >>>> I think the contents are "UNKNOWN", so it could be hugely confusing =
even
> >>>> if they just got logged someplace. Why is it difficult to avoid touc=
hing
> >>>> it for stage-2?
> >>>>
> >>> Fwiw, we are only ever using stage-1
> >>
> >> Sure, but this is in arm-smmu.c which is used by other people and supp=
orts
> >> both stages.
> >
> > Sure, but no one else is using this field in the fault-info.  So maybe
> > the addition of a comment in the struct would be enough if it isn't
> > going to cause an SError/etc to read it for S2 cb?
>
> Any worthwhile comment isn't going to be significantly shorter or
> clearer than 1 extra line of "if (smmu_domain->stage =3D=3D
> ARM_SMMU_DOMAIN_S1)"...

Just that smmu_domain isn't passed to
arm_smmu_read_context_fault_info(), so it would add some extra churn
on top of that one extra line

> TBH it's the Qualcomm register-middle-man firmware I'd be more worried
> about than real hardware, given how touchy it can be even with register
> accesses which *should* be well defined. But then I guess it also has
> the habit of killing the system if anything other than the GPU dares
> cause a fault in the first place, so maybe it OK?

If we have qc hyp, then we don't get S2 in the first place ;-)

BR,
-R

> If anyone still uses Arm Fast Models SMMUv1/2 components it'll probably
> squawk an annoying warning there too - ISTR I had at least one patch
> motivated by that in the past.
>
> Thanks,
> Robin.
