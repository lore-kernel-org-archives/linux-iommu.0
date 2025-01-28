Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D661B21BF
	for <iommu@lists.linux.dev>; Tue, 28 Jan 2025 22:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738102204; cv=none; b=G4+dmCSYHeFJnHtqCn5NulPyYtDzXXqnrN9/9whGfTZRD74KZGSyOP0ag1lr/Lz3WICY6uQH/umSkkpYtIidsJSjM4XtKQj4In6GQpU4GOzPXDTUOjtqzI03ffI8b9LGp8CgC9PwK6z9fRfclQSTTrTzaCnCL7iSoUJBvb+gTm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738102204; c=relaxed/simple;
	bh=ZtXE3F6IUApmC5kFsApxHwE2KPP49jtFp/ilonMYeJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmoIFKQmkUFLhFa0emWdA3iwVq4ZK0kIGtqqdeMRjgioYZZjJ8MsBeGJPz9yqDCRgmhzK3zchCU8aE7+GiawvnwSsCVn4/4RZntMvrNdK+Lx1CES/DJlDKfvFw17IHTDQoFjPHLFZsEpgOsyl4YzBQniXUWE1a7HTMG81jxYUus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNt0JHFv; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNt0JHFv"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3cfe17f75dfso21510935ab.2
        for <iommu@lists.linux.dev>; Tue, 28 Jan 2025 14:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738102201; x=1738707001; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyJffkBFdN8fIysYz8PGYmBGwUKqJch+7WjonIterd4=;
        b=DNt0JHFvifqaPUrbxXWxhKzSigq7yOV7G/TFL88PPBusKhal2QsCL5nSudRvGqbqjh
         cOBR9rGsvm2kiTo2vVvxIWxqoMPUbf1xsGtmp4tNG/fvoDRe8k8yLFS5+Jd3n5QTYC1o
         LYxVn/cnXatGyXlZUzchwjzlXRLuyBACb+4kcQ9YGqJ1vKS0ELMUKyzfm2xOmPp4RXk/
         aqEvuWfvgK+fzaiNEvWTE55/XLKUldY+DmoFR/gDGmyKDzWr0X3CBQNMFPF6rGd4eKnH
         Bh4OfHDZuY0yGsu+Usx7LDxW8HnK90TckH1u3EjSFo78qsyh3SdC64Bai0EyC0ZABYe6
         A4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738102201; x=1738707001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyJffkBFdN8fIysYz8PGYmBGwUKqJch+7WjonIterd4=;
        b=T05Gt2BsZ3ASiCcvBq+C7WrDqPk0Lofe1FeVHNri6NNka88UA1uep/cHwoZz47qqdt
         iRJHCbAKABGJ6L8QqWWXwvrbbDezQF+NpD43BuZwfGsVth/KsIXxz6LORjdrMf9leMst
         ctpTdwLu/5a50qgRzcsc2mrEnhklZT1NspnM3cMuyBlZ+rD3GsIkxiEfV6nlgtyd/TVB
         BK0opqbxa1+a6xxIaLO+MIyK6CE1BSvcrHNgp+l7yPMB5bxoEvrVDEZ4BEpBrSav8W2o
         1/MVqiPVJKSzDZmJN+E2ZxsxAnmz7dEZdp82/C8GQu47tnoe0QIyCa1A26/dMELfwhHm
         32lw==
X-Forwarded-Encrypted: i=1; AJvYcCVv9Bx4PbMl6zpLhz88ARGMqpScZW1Cf+kzsiE7lXvBNED58MVY5pqucfyOUC4TyZNJ9c6lIg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzs+H8DdcJHcx4K1UxjcsvheihAjoOXga/paW/p+3tI95q8MvAc
	unpulZg04Ga9n3WDD7I+3FRUO/na/AtP+h57bOfMQpJ48JczFSK6YMQ1SB9AtXwMOfIn4CkD5e7
	z+JVKduWjDAeJdp/xsPG/utjNKRo=
X-Gm-Gg: ASbGncuPMZxe/zHKKTspEQ1rgEVENNQb1b+I46ClpEcKiNv8synqjP9WfofL/mhZaAf
	Y5CooEDx1bb7tSrRaawdGPtW7mn4cSiIhjspZIjausHrNDCxp7TR3VjHzfOO7DjTg43RrWNbpPq
	VnxjVf6FThWYZVzad2+fGh5rCqNQ==
X-Google-Smtp-Source: AGHT+IHgfYpA0VMAacYmWKH7JphTu43Ivw7JChSTcf6n7PHDLpUdxL7L5C0eaN2l2Zyi0/kWh6WQspB+VO1SCyrGhQU=
X-Received: by 2002:a92:cda9:0:b0:3cf:bb3e:884c with SMTP id
 e9e14a558f8ab-3cffe44793amr7793705ab.16.1738102201257; Tue, 28 Jan 2025
 14:10:01 -0800 (PST)
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
 <Z5i6GQDd5apN+a10@hu-guptap-hyd.qualcomm.com>
In-Reply-To: <Z5i6GQDd5apN+a10@hu-guptap-hyd.qualcomm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 28 Jan 2025 14:09:48 -0800
X-Gm-Features: AWEUYZl2-uHarNn2psbsrw1v352rDEu3UlOhpWnD80DHoE6YTIxA3r72Hj27dzk
Message-ID: <CAF6AEGstcrAJDBpPm-uQ+zSDVEhDJ4AQhCTDT-z9_8Nq0e35WQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iommu/arm-smmu: Fix spurious interrupts with stall-on-fault
To: Prakash Gupta <quic_guptap@quicinc.com>
Cc: Connor Abbott <cwabbott0@gmail.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	freedreno@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 3:08=E2=80=AFAM Prakash Gupta <quic_guptap@quicinc.=
com> wrote:
>
> On Thu, Jan 23, 2025 at 03:14:16PM -0500, Connor Abbott wrote:
> > On Thu, Jan 23, 2025 at 2:26=E2=80=AFPM Prakash Gupta <quic_guptap@quic=
inc.com> wrote:
> > >
> > > On Thu, Jan 23, 2025 at 09:00:17AM -0500, Connor Abbott wrote:
> > > > On Thu, Jan 23, 2025 at 6:10=E2=80=AFAM Prakash Gupta <quic_guptap@=
quicinc.com> wrote:
> > > > >
> > > > > On Wed, Jan 22, 2025 at 03:00:58PM -0500, Connor Abbott wrote:
> > > > > The context would remain stalled till we write to CBn_RESUME. Whi=
ch is done
> > > > > in qcom_adreno_smmu_resume_translation(). For a stalled context f=
urther
> > > > > transactions are not processed and we shouldn't see further fault=
s and
> > > > > or fault inerrupts. Do you observe faults with stalled context?
> > > >
> > > > Yes. I've observed that on MMU-500 writing RESUME before the interr=
upt
> > > > has been cleared doesn't clear SS. This happened with v2 in the cas=
e
> > > > where there was already a devcoredump and drm/msm called
> > > > qcom_adreno_smmu_resume_translation() immediately from its fault
> > > > handler, and we'd get a storm of unhandled interrupts until it was
> > > > disabled. Given that the architecture spec says we're supposed to
> > > > clear the interrupt first this may have been an attempt to "help"
> > > > developers.
> > > >
> > >
> > > Just to clarify, present sequence is:
> > > 1. context fault with stall enable. FSR.SS set.
> > > 2. Report fault to client
> > > 3. resume/terminate stalled transaction
> > > 4. clear FSR
> > >
> > > At what point when you try #2->#3->#4 or #4->#2->#3 sequence, is FSR.=
SS
> > > cleared and interrupt storm is observed.
> >
> > With #2->#3->#4 FSR.SS is *not* cleared and there is a subsequent
> > interrupt storm with only FSR.SS asserted. With #4->#2->#3 there is no
> > interrupt storm. From this we conclude that MMU-500 does not clear
> > FSR.SS unless #4 happens before #3.
> >
> Thanks Connor for clarification. I get your point now. I think it's
> expected interrupt storm with #2->#3->#4 sequence is expected.  With
> CONFIG_ARM_SMMU_QCOM_DEBUG enabled, context fault follows the sequence of
> #1->#2->#4->#3, which is spec recommended.
>
> so, common fault handler can be modified to follow the same sequence, but=
 I
> have concern regarding clearing FSR before reporting fault to client.
> qcom_adreno_smmu_get_fault_info() is an example I gave but other client
> handler may have similar expecation of fault register not changed before
> client fault handler is called.

Simple solution would be to move the clearing of FSR to after the
fault is reported.  It doesn't really matter if it is before or after,
as long as it happens before the irq handler returns, AFAIU.  And
drm/msm will collect the fault info from the irq handler.

BR,
-R

> > > The way CFIE disable is helping
> > > with current patch indicates write FSR is unstalling context and subs=
equent
> > > transactions are faulted.
> >
> > No, it does not indicate that. The interrupt storm happens even when
> > there is exactly one context fault, and when the interrupt storm
> > happens *only* FSR.SS is asserted. I've verified this with debug
> > prints. Once more, MMU-500 will assert an interrupt when only FSR.SS
> > is asserted. This has nothing to do with subsequent transactions.
> >
> > > Do you stop getting interrupt storm after write
> > > RESUME.
> >
> > Yes, as long as the write to RESUME happens after all other bits in
> > FSR are cleared.
> >
> > > If you can mention your SCTLR configuration and FSR state in test
> > > sequence, it would be clearer.
> >
> > SCTLR has both HUPCF and CFCFG enabled.
> >
> > >
> > > An aside, If reducing delay between FSR and RESUME write helps then b=
oth
> > > can be done as part of qcom_adreno_smmu_resume_translation(). This wi=
ll
> > > follow spec recommendation and also make sure fault registers are not
> > > cleared before reporting fault to client.
> I think this sequence should address the issue you are observing.
>
> > >
> > > Thanks,
> > > Prakash
