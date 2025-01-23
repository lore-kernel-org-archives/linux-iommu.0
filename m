Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B01170A1A
	for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663270; cv=none; b=Y/zBPwXqAlDS5BNI8WkEnfRAqSpK6R+9/18NFeQXrGn35gzEChwJMqzl27SCb34UzD8lPybUHSeIgA3ib0OTPE2owvHX7VYXtzTsIim4376x5OILGkwWGiWjKUzE7E7DcpQCjDlVpqbTFihg9Hzl5DLeAZ+q0POFluU2yTIKjPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663270; c=relaxed/simple;
	bh=rnkBDxgN27V5XHsTTpwcFrxjosDqs8mDy4czBasu/Wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XslmaHhJKMXTzd7YQECIVOsk6YVhIDmOce8X9R2Q131Awwd+INaHzYr+ELToAh7fLQoq+QlEZ5G57gpl3/svm2VLa/OJ++87v2FVa0fzXN3JUJ/upvX76rzTpkLbIMvaO3ZCIBIvqg/vnG3fB9ZXdFIbASZDuhcD/3jNlKJfH+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxbHvawY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxbHvawY"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-216406238f9so2806575ad.2
        for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 12:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737663268; x=1738268068; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2QDlQ7ciLXyACEdbXlxDxDDAFIjM/sxdbl1ogTU8Rc=;
        b=cxbHvawY2zTW5OqOQhY5CfuVluXbT1QQT3MSfZBSiGDYtGsDX+i/QC4oJ+UFx8iAwG
         cxBEzk31AXzrCKdQZrItyRJIpXItMVVDtdEFiLSXuGgOKDtesER3LziixnWLpjjAR4X6
         A8E4pBkivK8DiDXOOJVDg+SQCX1BZ5SHsdyXyB18pcAu1Cr915cLK261S5t4MFY3SOB5
         SLxxs66/pGOd4oUuGVmVp4VNCtXa7RKUIntrD0vw+ygN+bBOlru/eALDcQk5KtQk9DYe
         T22Ppvb8drxaEJqqmmcqVA6OJTpJK5Fe4n14eixGw/7RPf1Ehox8y+tFvpQL9cOHM8wM
         kF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737663268; x=1738268068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2QDlQ7ciLXyACEdbXlxDxDDAFIjM/sxdbl1ogTU8Rc=;
        b=r439Td0Su1gfJDImDJCSQv4bXsqdO+mrv1h66RsGbOfjUJp1WJ0LhbvDAoezJxm/yy
         OdEryFOn5cxL/CD5+aU6DYl6RgiqCMk+/wYIeYFMO/R7Emd0qFl9/L5vOMs4yi9v0RxN
         52P3m1c6F8VMR4L57Z5Rn1rSf3I2fjlxTiJogTJ1GxnI5aXdCt5QK/ay9UQk7xj8cq2V
         smYdEf4TsWIIAwytoiw24d7kYsAuzhB6/YGm+QwHVLU5mmwSGNLFpH94J6buRLfQNYHJ
         E48Ocsabb0LUWdb4IvT4l2SZpelZNZ3nrp95qLoaOqiq3c6GVfGyzDScd0Yvqg0xw964
         XXTw==
X-Forwarded-Encrypted: i=1; AJvYcCWwsc49VoD4+Zu31IP3meuMIqykFHi1zPchYGB+n5q8gPyfTpmuzY20OVw7v8D4ok5F6cf9YA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzL6jdYwgERU45yJLeKN9DEx+7DZpsm+NEhZxtGE12rZS0N3KkP
	s5+kuyzjMXywr1mVSeb1z8g/fWFyDXy8NP4SZOQB8oQeQStKm5EWx+BjRas3Auh3Zi9A8sODLWc
	SPvTfla8PN9tHCEhWtnWqI9yz6po=
X-Gm-Gg: ASbGnctrozYIPxhY9TU2NPe/EoQQ/o7MuqTJxjoJQ7Fs/3t4U+ZX2ns3ruS8DVdzpbQ
	3P+rPBylckDEkAmkXkFqpgaUbNORbckyYaWXy7NdNvGlazcptVbHk6J8Uwbq6rHUwTlIQES2+
X-Google-Smtp-Source: AGHT+IF9WRUJHlC8pSwIAj8cVYowT1BAbQRT46w/zBvudQ5hCUtVjX57p1AYxilwi3P5ZVSk1dKDYES+SrAcrckfCwM=
X-Received: by 2002:a05:6a21:9215:b0:1e1:c26d:d81a with SMTP id
 adf61e73a8af0-1eb5d21c42cmr6183007637.8.1737663267550; Thu, 23 Jan 2025
 12:14:27 -0800 (PST)
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
Date: Thu, 23 Jan 2025 15:14:16 -0500
X-Gm-Features: AWEUYZm4s0a1_xJx4E19lGpX9b_gFH6RT3FcZVLxCaBZ0uPB-4Bak4CDyfFUWL4
Message-ID: <CACu1E7GOS+_biN=AuQwYK47ApRPFGygyD+U5X9d_4ReXKrzbfw@mail.gmail.com>
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

Let's say CB1 enables stall-on-fault. The sequence is something like this:

- CB0 faults, context fault handler for CB0 runs first
- resume handler writes RESUME for CB1
- CB1 faults on some other pending transaction
- context fault handler for CB1 runs due to the fault from CB0 on
shared interrupt line, discovers there is an additional fault because
we just wrote RESUME
- context fault handler for CB1 writes SCTLR disabling CFIE
- resume handler writes SCTLR enabling CFIE

At the end CFIE is incorrectly enabled while the second CB1 fault is
pending and we get an interrupt storm.

Realistically this is only going to happen if the resume handler gets
interrupted in between the two register writes, otherwise it will
probably win the race and write SCTLR before CB1 can run its context
fault handler. But technically we need the spinlock.

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
> cleared and interrupt storm is observed.

With #2->#3->#4 FSR.SS is *not* cleared and there is a subsequent
interrupt storm with only FSR.SS asserted. With #4->#2->#3 there is no
interrupt storm. From this we conclude that MMU-500 does not clear
FSR.SS unless #4 happens before #3.

> The way CFIE disable is helping
> with current patch indicates write FSR is unstalling context and subseque=
nt
> transactions are faulted.

No, it does not indicate that. The interrupt storm happens even when
there is exactly one context fault, and when the interrupt storm
happens *only* FSR.SS is asserted. I've verified this with debug
prints. Once more, MMU-500 will assert an interrupt when only FSR.SS
is asserted. This has nothing to do with subsequent transactions.

> Do you stop getting interrupt storm after write
> RESUME.

Yes, as long as the write to RESUME happens after all other bits in
FSR are cleared.

> If you can mention your SCTLR configuration and FSR state in test
> sequence, it would be clearer.

SCTLR has both HUPCF and CFCFG enabled.

>
> An aside, If reducing delay between FSR and RESUME write helps then both
> can be done as part of qcom_adreno_smmu_resume_translation(). This will
> follow spec recommendation and also make sure fault registers are not
> cleared before reporting fault to client.
>
> Thanks,
> Prakash
