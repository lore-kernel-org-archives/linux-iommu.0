Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A94121C16A
	for <iommu@lists.linux.dev>; Thu, 15 May 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329236; cv=none; b=GepHSApDQ5T9hWszcJMiuLZai3Lk6KePdITd6VcxGgilIHkThR+QwRwGaCHTMA0rlVSUvoBRsYDsmh3/xTbQlEXvHsj7XrnrwUHXsRZqmSPYLydYn7FcBsF87gr/g5F9NFrB/1ALBMPaCyRt4VyDioI5B4DAVVkSp7MuBp2Po+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329236; c=relaxed/simple;
	bh=EX7I37qXZLhdAQB+hDCZ4A6h8bFJ8pxTzuokyaHi29A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2hawsWDoiTiq/+mRT6X9S4+tVoIY7HyrrovJsIQGKp0y9mvpNPvj3WpK6T8owxH8g/g9oFFIEd9dAg++CLgyYjb9zqqORB0bpsi5TvqHLkxfKtgiZra88m8YGy/bFKrb/JYBwK35oXWLxPRzxEByoHmPwa3ViX9Ytj9ADRaIY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nz1dJy7E; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nz1dJy7E"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3087a70557bso215718a91.2
        for <iommu@lists.linux.dev>; Thu, 15 May 2025 10:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747329233; x=1747934033; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsfBOdqnpEgpdpgAJrzH2XaH6ygppwa1vT1EnnHCi70=;
        b=Nz1dJy7E8Z23kDL/TRdgms8ibVzI9t2q91fbqOaD7tF5bHlTLeyOlkTXu4aoHenZoe
         RuWjIwHZe1rd8qUr1bzzvHUicpBHaCjKDSQj9pdUKvjPmcca3v1bi3p0udiUzgohODTe
         7tzmUBZ/oLcx7aO+grCiCpJfGC6IJePbnhpEJLOFJ0e1Pz+P05M7TO+1IL6KEShsIJOE
         y6Ob9OOCaU//dPVSZTy4e7pufWjiBfR2akPd45JYgsIa9+jVsfIz81hhuO2iJqa8xNJS
         j66HqhrWbaxo9W7bpkeK7S1ON1xXInFCTvjKla0T4Dhdj/QQKofJoFC84xXXTIaQPqtI
         5/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747329233; x=1747934033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsfBOdqnpEgpdpgAJrzH2XaH6ygppwa1vT1EnnHCi70=;
        b=pr4B9eqjuXUKI3RxJzIQ/qB6TlkTxnqqTcycpa9ODHImfHSO7JUiUeuZX/Sv70ltL9
         LAOFPQpoFp3SELEQ3bZcjWc0FpcoWlCxMbo4b85+H6FSCP4FiJ6SDal5wvMmQu+8ejbE
         rhus9N9JvNtQaQln2kEBUWjkSzFU1mAzi/tGt9hh/MdW3wQkfE5LG3jtAEE1UmxIV8T2
         hUDJLObroab9cwDqS0m8A3F6OLbRu693VxzD/1cAQ4zcxdlt22JcAMxZPg7DfMOT03NP
         Z0WadMeizoXi7esqk9um4/jKb7lSooAC7l5Hl3Zpw0M9egxrhNgGj7XysFF3tuEFlAca
         UHLw==
X-Forwarded-Encrypted: i=1; AJvYcCXnHT7ImLmlKIM1q2dwnCWdkMz0H+vnu5nDmMbIv2GHTjAHFhQ91VcCaX+zahRQ7EPYIt5e9A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3ztASDEeG1RT+h3aBtarco6W57kSEIQ6Tx7Vj/BQ0JN5IHEaI
	l+294pLTTO2HSbUw1CohfcoGqHkzexYeyhMQqk6MwK08E22xQOBT8KQAbOdl4YnZGdKa8eJt581
	+VGDNNNGId3SJoFti0ffkzVfTw+TkHgQ=
X-Gm-Gg: ASbGncur491QXqPPFPoK74HPNyQsHURJL0UvuBR+93IoJvxRNQPFhnmc6BYiK8tFERi
	XSiVhwteKDf+24Ya0canrIZsqhYZ2O5wCdZ08yTrc/a7zco2TxzIN0dxhyhH2EmFOr5x3Spyi7x
	6GF5Dmh1ckIjJ83JXvnkZhngOr6x4aTp1J
X-Google-Smtp-Source: AGHT+IGCIUW0dsKa/ihtbOAHQVJV2lxTI8vBLZn5qcHLkXGbGsiY14r4IvJ+r7XjrnLMar2wvcpVQz33dDkzERkk2C4=
X-Received: by 2002:a17:90b:3142:b0:30e:6ac1:372a with SMTP id
 98e67ed59e1d1-30e7d691099mr71651a91.7.1747329233394; Thu, 15 May 2025
 10:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250319-msm-gpu-fault-fixes-next-v5-0-97561209dd8c@gmail.com>
 <20250319-msm-gpu-fault-fixes-next-v5-3-97561209dd8c@gmail.com>
 <20250506122449.GB723@willie-the-truck> <CACu1E7FA0M_0Un3qPRNtqy4R_NbaMks6FSkpQZBuyqJpuT-p7w@mail.gmail.com>
 <20250506145324.GA1246@willie-the-truck> <CACu1E7FcQU3NXro8uYxzEJ1pvfYG5WLvY8BscbF9Sj+P3Wh_2A@mail.gmail.com>
 <20250515144653.GC12165@willie-the-truck>
In-Reply-To: <20250515144653.GC12165@willie-the-truck>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Thu, 15 May 2025 13:13:42 -0400
X-Gm-Features: AX0GCFvD2R3Bj1I8omfFJkgKEUlYMIBkFZDKNasEPm1_T3W9qymeV4VLYjJsORg
Message-ID: <CACu1E7Ha5=q4mnnr5wZLk4407LJ6TBnjpxtAm4ve9i-ARgQqJA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] iommu/arm-smmu: Fix spurious interrupts with stall-on-fault
To: Will Deacon <will@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	freedreno@lists.freedesktop.org, quic_c_gdjako@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 10:47=E2=80=AFAM Will Deacon <will@kernel.org> wrot=
e:
>
> On Tue, May 06, 2025 at 11:18:44AM -0400, Connor Abbott wrote:
> > On Tue, May 6, 2025 at 10:53=E2=80=AFAM Will Deacon <will@kernel.org> w=
rote:
> > >
> > > On Tue, May 06, 2025 at 10:08:05AM -0400, Connor Abbott wrote:
> > > > On Tue, May 6, 2025 at 8:24=E2=80=AFAM Will Deacon <will@kernel.org=
> wrote:
> > > > > On Wed, Mar 19, 2025 at 10:44:02AM -0400, Connor Abbott wrote:
> > > > > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/io=
mmu/arm/arm-smmu/arm-smmu.c
> > > > > > index c7b5d7c093e71050d29a834c8d33125e96b04d81..9927f3431a2eab9=
13750e6079edc6393d1938c98 100644
> > > > > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > > > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > > > > @@ -470,13 +470,52 @@ static irqreturn_t arm_smmu_context_fault=
(int irq, void *dev)
> > > > > >       if (!(cfi->fsr & ARM_SMMU_CB_FSR_FAULT))
> > > > > >               return IRQ_NONE;
> > > > > >
> > > > > > +     /*
> > > > > > +      * On some implementations FSR.SS asserts a context fault
> > > > > > +      * interrupt. We do not want this behavior, because resol=
ving the
> > > > > > +      * original context fault typically requires operations t=
hat cannot be
> > > > > > +      * performed in IRQ context but leaving the stall unackno=
wledged will
> > > > > > +      * immediately lead to another spurious interrupt as FSR.=
SS is still
> > > > > > +      * set. Work around this by disabling interrupts for this=
 context bank.
> > > > > > +      * It's expected that interrupts are re-enabled after res=
uming the
> > > > > > +      * translation.
> > > > >
> > > > > s/translation/transaction/
> > > > >
> > > > > > +      *
> > > > > > +      * We have to do this before report_iommu_fault() so that=
 we don't
> > > > > > +      * leave interrupts disabled in case the downstream user =
decides the
> > > > > > +      * fault can be resolved inside its fault handler.
> > > > > > +      *
> > > > > > +      * There is a possible race if there are multiple context=
 banks sharing
> > > > > > +      * the same interrupt and both signal an interrupt in bet=
ween writing
> > > > > > +      * RESUME and SCTLR. We could disable interrupts here bef=
ore we
> > > > > > +      * re-enable them in the resume handler, leaving interrup=
ts enabled.
> > > > > > +      * Lock the write to serialize it with the resume handler=
.
> > > > > > +      */
> > > > >
> > > > > I'm struggling to understand this last part. If the resume handle=
r runs
> > > > > synchronously from report_iommu_fault(), then there's no need for
> > > > > locking because we're in interrupt context. If the resume handler=
 can
> > > > > run asynchronously from report_iommu_fault(), then the locking do=
esn't
> > > > > help because the code below could clear CFIE right after the resu=
me
> > > > > handler has set it.
> > > >
> > > > The problem is indeed when the resume handler runs asynchronously.
> > > > Clearing CFIE right after the resume handler has set it is normal a=
nd
> > > > expected. The issue is the opposite, i.e. something like:
> > > >
> > > > - Resume handler writes RESUME and stalls for some reason
> > > > - The interrupt handler runs through and clears CFIE while it's alr=
eady cleared
> > > > - Resume handler sets CFIE, assuming that the handler hasn't run ye=
t
> > > > but it actually has
> > > >
> > > > This wouldn't happen with only one context bank, because we wouldn'=
t
> > > > get an interrupt until the resume handler sets CFIE, but with multi=
ple
> > > > context banks and a shared interrupt line we could get a "spurious"
> > > > interrupt due to a fault in an earlier context bank that becomes no=
t
> > > > spurious if the resume handler writes RESUME before the context fau=
lt
> > > > handler for this bank reads FSR above.
> > >
> > > Ah, gotcha. Thanks for the explanation.
> > >
> > > If we moved the RESUME+CFIE into the interrupt handler after the call
> > > to report_iommu_fault(), would it be possible to run the handler as a
> > > threaded irq (see 'context_fault_needs_threaded_irq') and handle the
> > > callback synchronously? In that case, I think we could avoid taking t=
he
> > > lock if we wrote CFIE _before_ RESUME.
> > >
> >
> > We need the lock anyway due to the parallel manipulation of CFCFG in
> > the same register introduced in the next patch. Expanding it to also
> > cover the write to RESUME is not a huge deal. Also, doing it
> > synchronously would require rewriting the fault handling in drm/msm
> > and again I'm trying to fix this serious stability problem now as soon
> > as possible without getting dragged into rewriting the whole thing.
>
> This has never worked though, right? In which case, we should fix it
> properly rather than papering over the mess.

It has never worked upstream. Which means that everyone is either
carrying this series downstream, or blowing up sometimes. The number
of places carrying this series is quickly multiplying, so it's
becoming more and more painful that this isn't upstream. Not to
mention the downstreams that still aren't aware of this and hang the
whole system sometimes.

>
> Georgi (CC'd) added support for threaded interrupts specifically to
> permit sleeping operations in the fault handler. You should be able to
> use that and I don't understand why that would require "rewriting the
> whole thing". You can kick the async work and then wait for it to
> complete, no?

It would certainly require rewriting the iommu side of it, although it
does get simpler.

Properly handling the drm/msm side of it would also require getting
rid of the fault worker, although I suppose we could just wait on it
as a hack.

I've started trying to see how it would look, but the biggest problem
is that it's going to introduce a lot of complicated cross-tree
dependencies. To fully follow the recommended sequence, we'd have to
do something like:

1. Enable threaded IRQ on Adreno SMMU.
2. Make drm/msm do its devcoredump business immediately.
3. Make iommu in charge of writing RESUME and do it after writing FSR.

The problem is that if we only do 1 and 2, things will be way worse
than before. Instead of some duplicate faults while the devcoredump is
pending (that sometimes, but not always, results in a full system hang
if devcoredump is scheduled on the same core) the interrupt will never
be cleared, due to the MMU-500 behavior of ignoring writes to RESUME
if FSR isn't cleared, and the entire system will hang every time
there's a context fault.

I suppose I could put 3 before 2, and temporarily break devcoredumps?

>
> That would then open the door to handling the RESUME in the core driver
> in future based on the return value from report_iommu_fault().
>
> You also need to fix qcom_tbu_halt() as I mentioned before.
>
> Will
