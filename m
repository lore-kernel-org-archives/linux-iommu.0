Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463CB183098
	for <iommu@lists.linux.dev>; Wed, 29 Jan 2025 03:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738121695; cv=none; b=Zq1s3QAufgN6TIcqBWoldA2w0aRAiibLS6IFG/RZmw6sHrlJHgrCRZ7sltEHpPl9gSu0o//kqnNcDv2hc+Q9MiWbPlXBxKv+l/bKq46ep7OB9/jm+WZvMivCLbSE4xsyWc1iVKBACyQeqFAuYUGNl2LLJCZ0i9vhFGPmpSO39dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738121695; c=relaxed/simple;
	bh=v1L3PsKkt4rhGqLinyD6qhl7MiZRF1IP+NBCLPEbCkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbG5zRDH4nFJds9aps2QPc32z1B7wY6eD/hP0bqq0U7cM6KyxQKOdJJ8/6g6IXUxx+3YwIgR0IGzkm4DvJS45exIBLzZtwo3s9X3DA/TXIB7OldLlCJ0jezr5J807MDxfuOCXMSvtvGCrvdc6UQRUr6pPhq+uuz1EoDPh5v+Y/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kD8pZPBd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD8pZPBd"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2161a4f86a3so12591015ad.1
        for <iommu@lists.linux.dev>; Tue, 28 Jan 2025 19:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738121692; x=1738726492; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSEMixmPIS7Z8ruVPkos6z93kW0au3BNEj38QU0bOXo=;
        b=kD8pZPBd8/OKB7YRpr8Cr3zKgRQQw/enlOKQfmw7NDHGBfT4uRkpv7zkklk+S8tvg+
         PF5EMkK1WVSwSPznYZd8bUkvxjyZgyDv84ddgz1qIUcJX/lNnsUJnW74gQ2MctPzX2CX
         wO9Z3Gyk+Ipxt8Vv3d7VERoy898FkTISB4HxWEEjCPzyoMu5iO3SbHGjQr9a06FPmKLG
         CGkatpR0teDpfaTRdM83CHpYqnkgsk+Fg2KFDgTYh5bdq27X7l2oDWLpcZ5u4P6t+C2I
         rnbXlBv3nhXmv5Jkb7ybymXWsBARczqpXrmqh/rHyd2aCHbnUakzAVo9+x2kTnjFRdLu
         el7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738121692; x=1738726492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSEMixmPIS7Z8ruVPkos6z93kW0au3BNEj38QU0bOXo=;
        b=chgCAUAZIUhssiBW6+8rZkhweT/3Te0qqGrr3sg9qQTIcxBIsvFnrwv/1/ReJfTaV5
         pXNkgq3gSH8XkobnxmGU2tV/NYO7R411pf2nUNJIQgL9P6m1f0WWQslwDGTx5PsU4jM4
         D1WWmLc9ortsZsZZXMFnTO30mQ5Oq5DDMvMNW0reXLelMZrmCOJAhz4uUFB1yYxkY9ao
         4pVDfEp4fRkFtoJ+98RfE2vJ/uqb6ILE3gGLOMHYEkleL67mVc0FJ1O5FBJRb0l3BhQ5
         tQk9c4+ALRqOtssG9FmlztdzxbK9cF3qut3a5OW/qZpcK7/C6xBaNQDrFH5rcyMR1iCG
         s2UQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3+UmKWRfRAD35qUe0BBpVR1clvUoTcxSi4h5p3if/vSTXEu7OyL/+gwm9JXt3or9ADeRkHw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdG2lPLydWZLw1HCIrufWvEH5DQgj9Dpsn10UpG/h8qP7d4E9b
	xH/n4LQvK2+5ddUmkkZT3fL3PEKb33Ra9pLlsXzgV8LU5VMnSLcbsG7EOV8YNYp2PGwEIDsfqM0
	r/JHUjA2aFDOpoGDXtzkI78S7Ybg=
X-Gm-Gg: ASbGncuiEiS1+mSgcF0QXpy1iYAfwH/VlgXLuRnsY3VlyKx7MrRtI3xi54/yX5O4sYn
	vWmBL6LLEwB8JzEAUmfOQSvdP4GofWMT54eBUWxhmxecXmF2wr6Z5fqT9yAc0Wf9qlLermcL8
X-Google-Smtp-Source: AGHT+IFbFQSYTvKU6Tn/jYbbxgPrehvkrB0XAVXsOwTCtBnwvAVfgVvZVo8IQ1hdLTPS9gNaQI/uOQ9lmAgGhGlB37U=
X-Received: by 2002:a05:6a21:329c:b0:1e5:d3cc:4632 with SMTP id
 adf61e73a8af0-1ed7a5c5535mr1035370637.1.1738121692412; Tue, 28 Jan 2025
 19:34:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250122-msm-gpu-fault-fixes-next-v3-0-0afa00158521@gmail.com>
 <20250122-msm-gpu-fault-fixes-next-v3-1-0afa00158521@gmail.com>
 <Z5IjsqQ6vTdUXiGt@hu-guptap-hyd.qualcomm.com> <CACu1E7H5X2EfY9AG=xceaoZJkbumwnrsU4QvNbxd_A2wgVVOaQ@mail.gmail.com>
 <Z5KXwNPrdirVUn8Z@hu-guptap-hyd.qualcomm.com> <CACu1E7GOS+_biN=AuQwYK47ApRPFGygyD+U5X9d_4ReXKrzbfw@mail.gmail.com>
 <Z5i6GQDd5apN+a10@hu-guptap-hyd.qualcomm.com> <CAF6AEGstcrAJDBpPm-uQ+zSDVEhDJ4AQhCTDT-z9_8Nq0e35WQ@mail.gmail.com>
 <CACu1E7HErZAL=-GVQfKUAUK5bgK-X0qejt5os3f2UhkeZ1ptMQ@mail.gmail.com>
 <CAF6AEGsUjp+fp1_cN7SGYTh5WSQrU2mm92QsqA5rcSY1OtA8VQ@mail.gmail.com>
 <CACu1E7FyHwJ2mp5u3rDganYj80eDq3QJzLRFzxD9E9O7hEDiag@mail.gmail.com> <CAF6AEGugDxYjH63+Up_T_pt+jQ2D0m=x1tSg3fGPteu3XgR2qA@mail.gmail.com>
In-Reply-To: <CAF6AEGugDxYjH63+Up_T_pt+jQ2D0m=x1tSg3fGPteu3XgR2qA@mail.gmail.com>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 28 Jan 2025 22:34:41 -0500
X-Gm-Features: AWEUYZnSb6QYpR0Fp9PLawYr9P-QPjVvmIEP1Nm8egoDpm1trM7-ebAtlM8-HK8
Message-ID: <CACu1E7F0UTTapsLEUuKVFN0MF=kwhbSJqN2MU305Ab3cg+u_Lg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iommu/arm-smmu: Fix spurious interrupts with stall-on-fault
To: Rob Clark <robdclark@gmail.com>
Cc: Prakash Gupta <quic_guptap@quicinc.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	freedreno@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 10:25=E2=80=AFPM Rob Clark <robdclark@gmail.com> wr=
ote:
>
> On Tue, Jan 28, 2025 at 6:31=E2=80=AFPM Connor Abbott <cwabbott0@gmail.co=
m> wrote:
> >
> > On Tue, Jan 28, 2025 at 9:21=E2=80=AFPM Rob Clark <robdclark@gmail.com>=
 wrote:
> > >
> > > On Tue, Jan 28, 2025 at 2:15=E2=80=AFPM Connor Abbott <cwabbott0@gmai=
l.com> wrote:
> > > >
> > > > On Tue, Jan 28, 2025 at 5:10=E2=80=AFPM Rob Clark <robdclark@gmail.=
com> wrote:
> > > > >
> > > > > On Tue, Jan 28, 2025 at 3:08=E2=80=AFAM Prakash Gupta <quic_gupta=
p@quicinc.com> wrote:
> > > > > >
> > > > > > On Thu, Jan 23, 2025 at 03:14:16PM -0500, Connor Abbott wrote:
> > > > > > > On Thu, Jan 23, 2025 at 2:26=E2=80=AFPM Prakash Gupta <quic_g=
uptap@quicinc.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Jan 23, 2025 at 09:00:17AM -0500, Connor Abbott wro=
te:
> > > > > > > > > On Thu, Jan 23, 2025 at 6:10=E2=80=AFAM Prakash Gupta <qu=
ic_guptap@quicinc.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Jan 22, 2025 at 03:00:58PM -0500, Connor Abbott=
 wrote:
> > > > > > > > > > The context would remain stalled till we write to CBn_R=
ESUME. Which is done
> > > > > > > > > > in qcom_adreno_smmu_resume_translation(). For a stalled=
 context further
> > > > > > > > > > transactions are not processed and we shouldn't see fur=
ther faults and
> > > > > > > > > > or fault inerrupts. Do you observe faults with stalled =
context?
> > > > > > > > >
> > > > > > > > > Yes. I've observed that on MMU-500 writing RESUME before =
the interrupt
> > > > > > > > > has been cleared doesn't clear SS. This happened with v2 =
in the case
> > > > > > > > > where there was already a devcoredump and drm/msm called
> > > > > > > > > qcom_adreno_smmu_resume_translation() immediately from it=
s fault
> > > > > > > > > handler, and we'd get a storm of unhandled interrupts unt=
il it was
> > > > > > > > > disabled. Given that the architecture spec says we're sup=
posed to
> > > > > > > > > clear the interrupt first this may have been an attempt t=
o "help"
> > > > > > > > > developers.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Just to clarify, present sequence is:
> > > > > > > > 1. context fault with stall enable. FSR.SS set.
> > > > > > > > 2. Report fault to client
> > > > > > > > 3. resume/terminate stalled transaction
> > > > > > > > 4. clear FSR
> > > > > > > >
> > > > > > > > At what point when you try #2->#3->#4 or #4->#2->#3 sequenc=
e, is FSR.SS
> > > > > > > > cleared and interrupt storm is observed.
> > > > > > >
> > > > > > > With #2->#3->#4 FSR.SS is *not* cleared and there is a subseq=
uent
> > > > > > > interrupt storm with only FSR.SS asserted. With #4->#2->#3 th=
ere is no
> > > > > > > interrupt storm. From this we conclude that MMU-500 does not =
clear
> > > > > > > FSR.SS unless #4 happens before #3.
> > > > > > >
> > > > > > Thanks Connor for clarification. I get your point now. I think =
it's
> > > > > > expected interrupt storm with #2->#3->#4 sequence is expected. =
 With
> > > > > > CONFIG_ARM_SMMU_QCOM_DEBUG enabled, context fault follows the s=
equence of
> > > > > > #1->#2->#4->#3, which is spec recommended.
> > > > > >
> > > > > > so, common fault handler can be modified to follow the same seq=
uence, but I
> > > > > > have concern regarding clearing FSR before reporting fault to c=
lient.
> > > > > > qcom_adreno_smmu_get_fault_info() is an example I gave but othe=
r client
> > > > > > handler may have similar expecation of fault register not chang=
ed before
> > > > > > client fault handler is called.
> > > > >
> > > > > Simple solution would be to move the clearing of FSR to after the
> > > > > fault is reported.  It doesn't really matter if it is before or a=
fter,
> > > > > as long as it happens before the irq handler returns, AFAIU.  And
> > > > > drm/msm will collect the fault info from the irq handler.
> > > >
> > > > As I said in the earlier mail: "From this we conclude that MMU-500
> > > > does not clear FSR.SS unless #4 happens before #3." #4 is clearing =
FSR
> > > > and #3 is writing RESUME. So no, unfortunately it does actually mat=
ter
> > > > and we get a storm of unhandled IRQs if we don't clear FSR first. Y=
our
> > > > solution is what v2 did and it didn't work.
> > >
> > > So, just clear FSR also in the resume path
> >
> > Then we'd run the risk of incorrectly accepting a second fault if it
> > happens immediately after we resume. Not terrible for our use-case
> > where we only really need the first fault to be accurate and we
> > disable stall-on-fault afterwards, but if you ever leave it on then it
> > would result in another interrupt storm.
> >
>
> Howso? We'd still be ensuring that #4 happens before #3?  If needed we
> can add a param to resume_translation() so drm can tell it to only
> clear FSR if it calls resume_translation from the interrupt handler,
> or something like that.  But I don't want to lose capturing the FSR,
> and I don't think we need to.
>
> BR,
> -R

Because we could clear FSR in the resume handler (ok), then resume,
then fault again, then clear FSR again in arm_smmu_context_fault() and
unintentionally acknowledge the fault without a corresponding resume.
Again, it's not possible with drm/msm after this series since we
disable stall-on-fault before resuming but still this means it's very
fragile.

To be clear, FSR should already be frozen until we resume, if the
SMMUv2 architecture pseudocode is to be believed. So any fault that's
recorded in the devcoredump will still be accurate with this patch,
just subsequent faults might not be accurate.

Connor
