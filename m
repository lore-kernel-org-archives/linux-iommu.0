Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6041D88A6
	for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737664192; cv=none; b=OnO13nlC0wu7Qn82JkyrQH12nJbh8MybwyefA4Wq1MRKvtSBDVywTnb4x38yWx32BfLtW2oZKRmcGAu+yOYzz9DsBr7NuLUC8+0LXOPUeLcy/ynRN5APykuIMRb4Bh8+2qLIR4y2du6f3KQsfgKa7QvGQg8jlcw+bVr6ZgBQ5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737664192; c=relaxed/simple;
	bh=WEUi/YG2MoWUOF6uCxNlvX3lwljvYvy8G2P6b5wr7cE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVsSFxt7NcL+DV5lMSwbQsrRlRWVhmP6XoFcrQ+w1dEtsjWEPosu1uadjRHWQrlEM4foMJZ/+wx3dQfT75jA8p2wOeAIHtbmGZeR9nf3TDClmu8nTDRrhn90+kJXJuiXetXSa37enL7Izl8sRZ0z2ZtwdrIdwPDrugcAZNaVuuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjAwqFrH; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjAwqFrH"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f45244a81fso309961a91.1
        for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 12:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737664190; x=1738268990; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhXUcAh2hlUnon67PlT/agcOsGJGx82H3mKA5T5zmFk=;
        b=bjAwqFrHgPl9QgssfYsEeRzaKGJ0TKoTSlpMnIYmRWWlXYalR4GZflchdUaDyKqmdK
         6LlHKE6dWdJHo5N2yMWm+XPLGg9osnEmEPIgNDY9f85yajo//hvNxq18pm4ugN6oYE5Z
         giT6vh+Cbu8HLZyrnDCXuf8Zc82jTuGZS7ywJw5it1UCcuWTvpQUygsr1SWeLPe+CXCs
         GDSTqyTw9HKrtyhLLLrQP8XT9fqlvw/k7QVNd4huT8JpSN3PsuJEgEHDOAqDlzC86btF
         ETfKxYYQPmsrULOYMSa+mAC1v5jwOTXyeVoDm3vLHSvcBf3k2kAge8WZr4+t2LjBCfam
         hgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737664190; x=1738268990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhXUcAh2hlUnon67PlT/agcOsGJGx82H3mKA5T5zmFk=;
        b=DTGlwTifq7dvB4OSFfBm4lD61SebUFtPbNjpAynP7R6GuVLYos+Sz9/pZR523JctPg
         aiIwUtVgz19bLo2VWIby97SkhhQYFmFvyJRK1MZl1RGK+0K0IeCMZrpcikbaWbbuFRq2
         A5WVS9Jttj9mlt6kfvL8jhersSSXQgOuMmm7lvHn4D276Xb3g0iVqZ1EhtOpOYerB9GB
         lAFMisQfXlaAokdlBRtj0NvvZI+tgOthWCwqQFks2uZD4HmL7AF1jeu2OjDIp4ZasZWK
         bhMt/nTqe1bUhXeJgek22IcQ4A4MSyDHwO3uMNK62JLiOSmGhWSCI0+I8iDMu+mOvx9a
         Q5nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcC6mcfDlUZNUo1uVZhj0zICs1end5bwFApDjzFJJHe52nqPTYHfR22xEBI1b5zseCvlkLFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrLXiQOzluijJfZLgU1FHpqEWiQsTuGZkBACq14xjXeeSWotm9
	Xmgdf5PPYOxozK8vMumOqK/RvHcQjtInTvp2wrGTqs1UNaBZn2uf8lMyic5lccXXwTybqO+GkXs
	ACQBWeSRZOqkuDlVhOODY8HQZMv8=
X-Gm-Gg: ASbGncsxzJkhs6urloi8TABGzlWvXWvfu/uvO0E8DFP66IVH7c63PbkIq/seQt1bbu7
	RXpooZy2FBXaCQGD7q8Y8nGGfWgMahNLnFRYOgTOQroITu3Zv7/pn/4iFygbgDg==
X-Google-Smtp-Source: AGHT+IEl/Vyc8QmUbX/0GWfiscTSIPf6SvYZLBKkQKTl7lLUFAx/A3wbK7xRIXAG5nlkFHCAISdwVSqrdyt6dZww7dM=
X-Received: by 2002:a05:6a00:3a1d:b0:72d:8a01:bb6c with SMTP id
 d2e1a72fcca58-72daf7a1db7mr13737192b3a.0.1737664189916; Thu, 23 Jan 2025
 12:29:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250122-msm-gpu-fault-fixes-next-v3-0-0afa00158521@gmail.com>
 <20250122-msm-gpu-fault-fixes-next-v3-1-0afa00158521@gmail.com>
 <Z5IjsqQ6vTdUXiGt@hu-guptap-hyd.qualcomm.com> <CACu1E7H5X2EfY9AG=xceaoZJkbumwnrsU4QvNbxd_A2wgVVOaQ@mail.gmail.com>
 <Z5KXwNPrdirVUn8Z@hu-guptap-hyd.qualcomm.com>
In-Reply-To: <Z5KXwNPrdirVUn8Z@hu-guptap-hyd.qualcomm.com>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Thu, 23 Jan 2025 15:29:38 -0500
X-Gm-Features: AWEUYZlzwCzK_Ns_Li_73IXsL90hsOwVuugbU7LWSAnvDp0ILCSA2EsoYowsZGM
Message-ID: <CACu1E7Hw3WxNzwdA2A8hG2yWNVMLy=r=68_X0C3tkVttgRzXVQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iommu/arm-smmu: Fix spurious interrupts with stall-on-fault
To: Prakash Gupta <quic_guptap@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 2:26=E2=80=AFPM Prakash Gupta <quic_guptap@quicinc.=
com> wrote:
>
> On Thu, Jan 23, 2025 at 09:00:17AM -0500, Connor Abbott wrote:
> > On Thu, Jan 23, 2025 at 6:10=E2=80=AFAM Prakash Gupta <quic_guptap@quic=
inc.com> wrote:
> > >
> > > On Wed, Jan 22, 2025 at 03:00:58PM -0500, Connor Abbott wrote:
> > >
> > > > +     /*
> > > > +      * On some implementations FSR.SS asserts a context fault
> > > > +      * interrupt. We do not want this behavior, because resolving=
 the
> > > > +      * original context fault typically requires operations that =
cannot be
> > > > +      * performed in IRQ context but leaving the stall unacknowled=
ged will
> > > > +      * immediately lead to another spurious interrupt as FSR.SS i=
s still
> > > > +      * set. Work around this by disabling interrupts for this con=
text bank.
> > > > +      * It's expected that interrupts are re-enabled after resumin=
g the
> > > > +      * translation.
> > > > +      *
> > > > +      * We have to do this before report_iommu_fault() so that we =
don't
> > > > +      * leave interrupts disabled in case the downstream user deci=
des the
> > > > +      * fault can be resolved inside its fault handler.
> > > > +      *
> > > > +      * There is a possible race if there are multiple context ban=
ks sharing
> > > > +      * the same interrupt and both signal an interrupt in between=
 writing
> > > > +      * RESUME and SCTLR. We could disable interrupts here before =
we
> Not sure if multiple context bank with shared interrupt supported for
> arm-smmu driver, but even if does than context fault handler they would
> operate on their respective context register space, so I don't see the ra=
ce
> at context register update.
>
> > > > +      * re-enable them in the resume handler, leaving interrupts e=
nabled.
> > > > +      * Lock the write to serialize it with the resume handler.
> > > > +      */
> > > > +     if (cfi.fsr & ARM_SMMU_CB_FSR_SS) {
> > > > +             u32 val;
> > > > +
> > > > +             spin_lock(&smmu_domain->cb_lock);
> > > > +             val =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_SCTLR=
);
> > > > +             val &=3D ~ARM_SMMU_SCTLR_CFIE;
> > > > +             arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, val);
> > > > +             spin_unlock(&smmu_domain->cb_lock);
> > > > +     }
> > > > +
> > > > +     /*
> > > > +      * The SMMUv2 architecture specification says that if stall-o=
n-fault is
> > > > +      * enabled the correct sequence is to write to SMMU_CBn_FSR t=
o clear
> > > > +      * the fault and then write to SMMU_CBn_RESUME. Clear the int=
errupt
> > > > +      * first before running the user's fault handler to make sure=
 we follow
> > > > +      * this sequence. It should be ok if there is another fault i=
n the
> > > > +      * meantime because we have already read the fault info.
> > > > +      */
> qcom_adreno_smmu_get_fault_info() reads the fault info as part of client
> fault hanlder. So it would not be ok to clear FSR before reporting the
> fault to client.

That's a good point, but as long as stall-on-fault is enabled it
doesn't matter because subsequent transactions that fault will be
stalled. Patch 3 of this series disables stall-on-fault after the
first fault in drm/msm, but we don't care as much about the accuracy
of those subsequent faults.

>
> > > The context would remain stalled till we write to CBn_RESUME. Which i=
s done
> > > in qcom_adreno_smmu_resume_translation(). For a stalled context furth=
er
> > > transactions are not processed and we shouldn't see further faults an=
d
> > > or fault inerrupts. Do you observe faults with stalled context?
> >
> > Yes. I've observed that on MMU-500 writing RESUME before the interrupt
> > has been cleared doesn't clear SS. This happened with v2 in the case
> > where there was already a devcoredump and drm/msm called
> > qcom_adreno_smmu_resume_translation() immediately from its fault
> > handler, and we'd get a storm of unhandled interrupts until it was
> > disabled. Given that the architecture spec says we're supposed to
> > clear the interrupt first this may have been an attempt to "help"
> > developers.
> >
>
> Just to clarify, present sequence is:
> 1. context fault with stall enable. FSR.SS set.
> 2. Report fault to client
> 3. resume/terminate stalled transaction
> 4. clear FSR
>
> At what point when you try #2->#3->#4 or #4->#2->#3 sequence, is FSR.SS
> cleared and interrupt storm is observed.  The way CFIE disable is helping
> with current patch indicates write FSR is unstalling context and subseque=
nt
> transactions are faulted.  Do you stop getting interrupt storm after writ=
e
> RESUME. If you can mention your SCTLR configuration and FSR state in test
> sequence, it would be clearer.
>
> An aside, If reducing delay between FSR and RESUME write helps then both
> can be done as part of qcom_adreno_smmu_resume_translation(). This will
> follow spec recommendation and also make sure fault registers are not
> cleared before reporting fault to client.
>
> Thanks,
> Prakash
