Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81C9348C77
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781113081; cv=pass; b=gMlopcy1uT9qZLm5ydvEXTPXxXycRi2zcZxIVnLp0gCYcMI9wnKsWwU2tHmD9RXaRdtw4vvgYXEhDnfwfB5N+fuRhEZGD7ygdhgb+3KAv4EbVGOlTTU9XMP9/zvJ77P76ikkLCng9zzoVPbm4x+ZFuufySFY3qnPfAug+T8hC5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781113081; c=relaxed/simple;
	bh=V+jnd7IcuXTRuBqe6v7YfytrCXtBMFcnExNZ4PpmEPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RykqLvz7bd08DJAiZbLNNbAjGth/JpQQrhqPSbvKgp+s+ejn7vZNCnIqwu1L3zjyXfAjS1q+oO1aEqRvXUWPLNoVigfmyjpUY2y8DTLNBXIBEeueSTyEuPWcKxA4AoNOx3XIEhg/Q5TiEJnzE7mJfiK1iH5ouSGYWyJ7cwYoh2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RSLGEAbA; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RSLGEAbA"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5177d1ff061so50681cf.1
        for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 10:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781113079; cv=none;
        d=google.com; s=arc-20240605;
        b=iVuVpy6ovb1e9QfVBf/H8jtjbfNyN4vQO5n1btZYHN19jVMd5gj/l3jWsUm5r4SfCA
         JVivPDL/G3u0rprLPTxewceOqQ213ZEgQEe/UMnZuUO7asa++esn4pm7Zten0ao4eL5W
         ppA7xfSegT5wZDImZI4kSU0EKYxvw82kwwAwuFctQNimnwFcwQdvRosKdb6koLXZ+Xmj
         /p4B/ZJWa8ghILQ8N8WJlEnNuhiGjckdPDKa+E8UCeEG3cnuX55fuA6j9bDwdzZQNx9V
         UFdGekZLUVxZd40X1WkbED3FmwM+k4ghn4zV4QNYkAdUfXFsfyd1BBJHoV28YHMshLz4
         xSUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XyBpgIHJYC6qNDN+qiLyuZatTXuIQOHHRiSfq6TIKQ0=;
        fh=0u6trxL0zZwA0/1Sge/7uQQnOlSSVTu7AIo0GAZRpig=;
        b=g1Bsnj/hw1woC8wd4eqJAvyEee7KCuwkRh8lUt8AjkF4wnJwH/0iUKfl7uhE2oVWLT
         0A2GLG8LeUWmdzD/Fz4KUKwG7ez37KftjfA9/7TiQpDLLdNSXHz8zRE5JQclZT9l1HEw
         uWPd8gEj0TfiPQbnedanMbepHB4P2oPuloNqbu8ftQ+0LROSNtbYwzEGgpWagHUWrad2
         BCc4ZsyJc9a8skblkogSjqqBpD1utGamheqZ7Vu/bT/jX3VZfYeFzbMnzDf3pW0hkm6C
         eALztjtLBU7zRyYQxS6oM3E1MTE1qhL6OtG3T7xYDJWR6EfiKcPNhA15mcQC0EIUvQ8O
         VdMw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781113079; x=1781717879; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyBpgIHJYC6qNDN+qiLyuZatTXuIQOHHRiSfq6TIKQ0=;
        b=RSLGEAbAoVMcNhndbSccgIPnpBj+Cp05vylQibeZSzy5WgH+bEh66OuN1ZuqMPlPF8
         vN9wbFwCxSU4/uqb4lmComMZaay3U2+hr2snIvB9COC2PQSxnN0Qpeax3lwxEmMsGNtY
         vpvt80Wjm3D67pdqdTSU0nQaqdvFLUT/m1Du+2VScKhSnCYa00yjl/x/oA2aWZz4oJEy
         WsvIaABSsxySd8txPnhU+dBtHVjc+NA2E9pwa8hWtSgBICnH63mtTzWPw6SWsUadPrcQ
         g91vwccTW94nYVO8URCBr7nzrEx8pgxXcLBVX8AdQ+TenNgJAhgTKC7w07DDeYPa4kEw
         KF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781113079; x=1781717879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XyBpgIHJYC6qNDN+qiLyuZatTXuIQOHHRiSfq6TIKQ0=;
        b=obCzkJY0o6oRBOTSxwdw1LLkWYJnmCFbp6waBrMF94YY/wL/GN5vFsB6sLkE7ilD3D
         M0+wQAcEDtGCc4CjAleQdcq4wd13+3/TGmssszYqNxh/d+P8rl9ogAwtrFqRovEFoH41
         WRhEra/nEvMMM2F7gVj9ER/9xllu7h5asAioisLsipPl1N66BOm6kTGsRbTcEOmtMBoI
         rjZOfzzhRXwfC+r+eOeQuunSaYSJR7TOZP/OHYrAdMOnFdWUhXBSW6KiPY998Xgk1WWy
         bir2/Q4kQZ1m+l/kAcn0ZO+xdOTGoisFb6iXg6ouemHgpBrFVvy+QpGdQenfpEO48a06
         ymvw==
X-Gm-Message-State: AOJu0Yx7odZrHQLhHxci3sMxsE+bjvcflX4GNwvBX1bu3ji/tWWQiV9k
	elM4w79MTWtOxpGnZkOENRsAXsOWVAh10c0Z3OrjfABFIs+a50ub8FDO/m4+lDJjwVSKSwXEK5a
	WYmBSObqE6okDzOcO29Nncp1ofsRvUh4Mf0vJSuvF
X-Gm-Gg: Acq92OEpsYRg2CV42LXx4jEf/61aYslNbsVyWu01S+SyGk5QSTFTOnn9R1k+2DXdKZr
	HVk4s4WQxkaolnRFQrf28Un/3+GlCFgtC0rQiFN2zcXSruBLtnPE8+KxLozw4gaZ9l9kDjwknZm
	c2FrFQH7eOcUHZ+Ts3nj6SL4a9/gETFIgnpuqmVqwfJ2SblYoj3E1b44W7LY4sKfBBHDFXlxu8B
	jVyYgQFT1DNZp5WBJd1NsAXfsmLHk+zdW0VOeRwOR21Ygyjv6R3tYJInBfqYq4KaIDLg0r96Hhl
	5RISUNk7pytIgXU=
X-Received: by 2002:ac8:5a42:0:b0:517:6dc0:698d with SMTP id
 d75a77b69052e-517e94e8f60mr1704361cf.0.1781113077976; Wed, 10 Jun 2026
 10:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com> <20260601215909.3958732-8-praan@google.com>
 <CAE2F3rDF5dVJip2gc+vaxtM-FRttnUEnAetUYz6qDCXRM=fNYg@mail.gmail.com>
 <aiZe97OkmvcUwCzS@google.com> <CAE2F3rDZupDgq5tQrvpuixGi-kVs+oi-Tacqa=Rxtri03LBPHQ@mail.gmail.com>
 <aiflaI4svEJvZbsC@google.com> <CAE2F3rDgXxAhJFUX6=xars9H92t8NBDqcFRxU7d5wJQ7buUbNA@mail.gmail.com>
 <aihiPQ2mdqMm13Cd@google.com>
In-Reply-To: <aihiPQ2mdqMm13Cd@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Wed, 10 Jun 2026 10:37:46 -0700
X-Gm-Features: AVVi8CcAGj-U1U1VJtTLOSHtsGjVCqeBFBsJkoKPWbr0SCZSqb6AOoPaOEeCfko
Message-ID: <CAE2F3rCdzBwcLtVWPLnx-==QodXWJv_OYi9meRp9M=+8PPqrDA@mail.gmail.com>
Subject: Re: [PATCH v8 07/12] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 11:58=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Tue, Jun 09, 2026 at 11:20:52AM -0700, Daniel Mentz wrote:
> > On Tue, Jun 9, 2026 at 3:05=E2=80=AFAM Pranjal Shrivastava <praan@googl=
e.com> wrote:
> > > >
> > > > > Even if the worker CPU reorders the PTE write after the STOP_FLAG=
 check,
> > > > > it is benign because the SMMU is incapable of fetching that (or a=
ny) PTE
> > > > > while the gate is closed. Because GATE_CLOSED =3D=3D SMMUEN =3D 0=
, implying no
> > > > > access to any HW structures whatsoever.
> > > > >
> > > > > The real synchronization happens in the Resume Path:
> > > > >
> > > > > 1. arm_smmu_device_reset() clears all caches / TLBs.
> > > > >    (None of these can have entries before SMMUEN=3D1)
> > > > >
> > > > > 2. We execute a full smp_mb() before setting SMMUEN=3D1. (that's =
why we
> > > > >    need smp_mb before SMMUEN=3D1). This barrier ensures that any =
PTE
> > > > >    writes made by any thread=E2=80=94including those that were el=
ided while the
> > > > >    gate was closed, are globally visible before the SMMU hardware=
 starts
> > > > >    fetching into TLBs again. (This is why Jason suggested this in=
 v6 [1])
> > > >
> > > > A barrier on one CPU has no bearing on whether writes by any other =
CPU
> > > > can be observed by any particular agent in the system.
> > > >
> > > > Let's compare this with the long comment in
> > > > arm_smmu_domain_inv_range() which is what I believe Jason was
> > > > referring to. In that example, you see smp_mb() in the code path on
> > > > CPU0 and dma_wmb() in the code path on CPU1. Hence, barriers exist =
on
> > > > both sides. If you compare the runtime PM design with
> > > > arm_smmu_domain_inv_range(), then smp_mb() belongs in the CPU threa=
d
> > > > that performs the translation table updates not the one that perfor=
ms
> > > > the suspend/resume operation.
> > > >
> > >
> > > I might be missing something here, so please bear with me. My
> > > understanding it that's needed because the IOMMU is live & actively
> > > caching, which is not true for our case.
> >
> > I think the "invs" design (Per-domain invalidation array) is more
> > similar than you think! An SMMU being absent from invs is equivalent
> > to the STOP flag, and the STE pointing to TTB0 is roughly the
> > equivalent of SMMEN=3D1 i.e. the IOMMU is not actively caching a
> > particular translation domain until an STE (or CD) points to it.
> >
> > > [Assuming we use non-relaxed semantics & ordering for the STOP flag,
> > > i.e. set STOP_FLAG + barrier & clear STOP_FLAG (implicit dma_wmb())]
> > >
> > > In our case, during the resume op, we first clear the STOP_FLAG befor=
e
> > > setting SMMUEN=3D1 in program order. Thus, any PTE invalidations occu=
rring
> > > before SMMUEN=3D1 are executed, i.e. EVEN when the SMMU is guaranteed=
 not
> > > to access any structures, we've resumed invalidations.
> >
> > "[...] we first clear the STOP_FLAG before setting SMMUEN=3D1 in progra=
m
> > order." I think this should be modified to "we first clear the
> > STOP_FLAG and ensure that the cleared STOP_FLAG is observable by all
> > other CPUs before setting SMMUEN=3D1"
> >
>
> Ack. The goal was to explain the algorithm for this thread, I won't be
> commenting it in code. Are you suggesting I should convert my
> explaination of the algorithm above into in-line comments and make sure
> to include the STOP_FLAG observability part?

I believe there would be a benefit to having a comment in the code
that states the requirements for the STOP_FLAG observability.
Something along the lines of either of the following:

* SMMU must be disabled any time another CPU can observe the STOP_FLAG
* Other CPUs must (a) observe the STOP flag only after the SMMU is
disabled, and (b) observe the cleared STOP flag before the SMMU is
re-enabled.

> >
> > I would define a set of invariants:
> >
> >  * If an agent observes the STOP flag, it is guaranteed that SMMUEN=3D0
> > (with ABORT set) at the time of observation.
> >  * Any transition from a set STOP flag to SMMUEN=3D1 involves an
> > invalidate-all operation prior to setting SMMUEN=3D1
> >
> > Hence, if a CPU observes the STOP flag, it is assured that (a)
> > transactions are blocked and (b) if the SMMU is ever re-enabled, an
> > invalidate-all is performed prior to it being enabled.
> >
> > I would then argue that all operations support these invariants. For
> > example, we need proper barriers in the iommu_unmap path to ensure
> > that the STOP flag is only checked *after* the translation table
> > update is made. Hence, we need a memory barrier.
> >
> > I look at it this way: Every elided invalidation creates an
> > "invalidation deficit", and this deficit is tolerable for two reasons:
> > (a) SMMU blocks all transactions while there is a deficit. (b) An
> > invalidate-all eliminates any deficit accrued while the STOP flag was
> > set.
>
> Ack, which means you agree with the design proposed in my last reply.
> I'll document these invariants in line if that's what you're suggesting
> here?

Yes, I believe we are in agreement, and yes, I think documenting these
invariants would be beneficial.

[...]
> >
> >
> > >                       HW structures not accessed means no TLB / CFG
> > >                       cache accesses as well according to the spec.
> > >
> > > [CPU1] =3D=3D> PTE update =3D> Invalidate =3D> Succeeds (although SMM=
UEN =3D 0)
> > >
> > > [CPU0] GBPA.Abort set =3D=3D> Txns are blocked
> > >
> > > [CPU2] =3D> PTE update =3D> Invalidate =3D> Succeeds [Txns blocked + =
SMMUEN=3D0]
> > >
> > > [CPU0] =3D=3D> SET STOP_FLAG =3D=3D> Elision begins
> > >
> > > [CPU3] =3D=3D> PTE update =3D=3D> Invalidation =3D=3D> Elided [Txns b=
locked + SMMUEN=3D0]
> > >
> > > Hence, the races in the suspend sequence are handled correctly.
> >
> > I'm not sure if this description demonstrates that every possible race
> > is handled correctly. If I compare this with Nicolin's presentation in
> > arm_smmu_domain_inv_range, I like that presentation, as it explicitly
> > mentions loads and barriers. For example, it has an smp_mb() followed
> > by "// load the updated invs". I think you should make have something
> > like "smp_mb() ; CHECK STOP_FLAG" in your presentation. Currently, the
> > STOP_FLAG checking is somehow implicit in "Invalidation".
>
> Ack. The goal of this diagram was to explain the working of the design,
> this is NOT the comment/document I plan to include in code.
>
> I'll add this as an in-line comment if that's what you're suggesting? OR
> are you also suggesting I should have this in my cover letter?

In arm_smmu_domain_inv_range(), there's Nicolin's sequence diagram
that describes how installing a new domain is synchronized with PTE
updates and subsequent TLBIs. I would recommend adding a similar
diagram that shows how suspend and resume are synchronized with PTE
updates and TLBIs.

Thanks
 Daniel
