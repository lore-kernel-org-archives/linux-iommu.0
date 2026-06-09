Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D14F3438A0
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029269; cv=pass; b=l809fDVVK5jjN+/kj37cxOLUY4H0kNr8ywiPCOvxUjLuQo2Clmxr6xQhP55JNQHdmkBigdQ8J7ZHPTXskDEWZYLUPBWZ5qhr247otadZ+onmS6VqR60lsVef9ONUnzwiWReI/9SSjtkkKgwLXwxw0u/IRFu1/U5DLO/PtTmwsfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029269; c=relaxed/simple;
	bh=oNG9QbGEss7pVAzD/HpgDUsZ8QFgqva1cUNpmDvK+I4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFiQVdxf4MZNhh110Bn3Xyyeu0LdBMgxE5F9KbhWZ6Vgu/+YkVB8mIeYCuO/scqKpC9m4DPq1JmVyjFbBnqyJzY3ZTZdUjjgzPOtgDtvofJRWw2gB6962D8TwAm+lFIopwyRqpFroMeNWw4+xvvhuxa97OUS9HYNEQBepokaOic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cqZ2KYou; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cqZ2KYou"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68cb445dd5cso44432a12.1
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 11:21:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781029267; cv=none;
        d=google.com; s=arc-20240605;
        b=dg4Qy6naB9wMOr7bUcxrDIQ8jNoldDpcK4CqsKmgg8pqy7wb2EX2TmXnDoAjzjLWju
         n6dh34N+qD4cduv19kGyKVrErt4s3DelXnRpA6MWtMWEvCj7lcNvmMGQwgvfCrbZY8ol
         TNoxp5m0dD///1qjjOdw/mdE5kmFXGIgQM/aM6+8DdKw0q4Jrcb8UYn0NnQ24asWY18y
         4SdDEfICwA4WCoslmv5o6y+CMLATFY8IPZka66fJmCwRiDfpFIY6R4SRf/uzcKcJSw7b
         tXEByZm0mcVjdGG6/jf/Df88CRMALBazSKJs47Vi/5ekD/eGHQWx7ubkkZRgDNLKePlw
         zj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RxRV+giO3XkJijo1vRcVAE46LXSC1XwSsC6Fxr10BXY=;
        fh=0u6trxL0zZwA0/1Sge/7uQQnOlSSVTu7AIo0GAZRpig=;
        b=X6yTQgY8ILKGRNCohlvR+SSvPMVJir8NA7G4WRTmJWxjvn6doIePi/GJSvcuafigRP
         +WxqqodF/2ZFax/zqs8GD3BQa2C1FLrGM24JFbiNBuvKu3znmORJWcWsYjFWeVi9Pspb
         MKSiyDtOuoTFQY887agJbzGJUzewYiZucu5eJLbHmq9MtCmb2C/+TN5GxdMuC4le9SCV
         uEYLM6jqQfxnK1zF5afzp4y7CzlFkT8uDlZznJalMbyxA675uYU8eEQCnNns8fm24jGx
         4gnaAQa5gCGqNm41G6KkaOV2rJCMXcnIf4oiPpl25Bi+wxICwZILW9dLl8s7q48xBGwd
         IZGg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781029267; x=1781634067; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxRV+giO3XkJijo1vRcVAE46LXSC1XwSsC6Fxr10BXY=;
        b=cqZ2KYouWHLog/kHUF/hdI4CuPy3BvZ5eIK720rSE/FDR7jnZPmVcQ+SEaxNG8TNIn
         0fdSEvcxF2W08jSlSY9MEOgVxtbUhRwNq8gbZMlO0QNUzLiq8QBNGlx55uf2eTrsDaU+
         IKU5G47KTtlQ33v+xNQ6EOjNB+Vk+eXeTMgq+9ik0JWjq1fkjNFyEfoED6A29FXK2c/a
         IQhEZKGDoQRBbt0MAKQd4Ep1CFgXfaPESKqfnUZAMCvHlU/1dcIRGJ7aN9wgvWEuoNvu
         rh7I5Oa8b3/mKr97IyL1tBWRQ0q9dv/D/II/sgVUySX9zPJZ8BJbuky7jhmMw7jM/Ang
         FBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781029267; x=1781634067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RxRV+giO3XkJijo1vRcVAE46LXSC1XwSsC6Fxr10BXY=;
        b=HkrurvsQJooYeRA7ai5f9Nfwq1OiretvSsBX+urqAJOZlBDuVDXpgdQ6+qjdm3pZgz
         MahZNxTNObwA/JCG6IQxuwKdsSRNyWtucI5x4Up8jKmB2OpH4ORm+TEpOx3HxA4wWqov
         Bm4XWHe0kguO6elGczG1WEONFPRlYRhYV/Ryg7YmWYr89H118csgVFovhT65aYUwUqhm
         HRwJ9FH1UlAnHBlujUk8RcrtJ8VJMbabBLpn40byyQAFfJOWMejxjaRKN+Rid9TYN8jz
         aM8USXc9N/iwM+m9VEdDZIIoHhWapupPg7P5grH9XMakXq1hJyJYwyGQVNt1Qt4/Bvqu
         U9Yw==
X-Gm-Message-State: AOJu0Yw7atWfpqoiXeAlaYoTO+T4MNcrPdZPe0s5CiwXje1LebmIfNda
	2M+o6Qj9utxbjiDW5ZT2WZnSP650YKsf2SShyWonAxMoupJQtC2a0dXOPcntarmFgLrbP5Ld/J3
	ENf6sC7b5zUOIrMDUxr+27Q19e7sp9ya9L5oa6UWA
X-Gm-Gg: Acq92OHPY2v9VNNSPdWcfll4Z8HOdKm3fHbLmlCaYc+70FdFnk32dMnZq6n1yLwhTR6
	CbEZTd0M91Jl/Hk84fxt8n617rKM04G4HDhT90plJ5VMd7DOgkdS3BfaaZybcFaJwcY+mk2/Wie
	ma1tnpEe1EA193FE0IsGyJ8OrUb9TU72rywc2Zb0n1pwrgkUdCgtvpHOc8+SbZh5AaXfnEzfFYr
	6dHOIMfjSfIqd7v/ZRZsksxuueb/aet+DQHklYBQuBF1zgOvCkl/Iha9Pa/9l6jZsHwDAMex1wr
	w/3f0SL5CmX5p+PhLEz5kKcvdLx6mXXWgz6/N2rnm02n7bZm
X-Received: by 2002:a05:6402:31ec:b0:68f:d45f:e495 with SMTP id
 4fb4d7f45d1cf-68fe9382c98mr232792a12.12.1781029265990; Tue, 09 Jun 2026
 11:21:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com> <20260601215909.3958732-8-praan@google.com>
 <CAE2F3rDF5dVJip2gc+vaxtM-FRttnUEnAetUYz6qDCXRM=fNYg@mail.gmail.com>
 <aiZe97OkmvcUwCzS@google.com> <CAE2F3rDZupDgq5tQrvpuixGi-kVs+oi-Tacqa=Rxtri03LBPHQ@mail.gmail.com>
 <aiflaI4svEJvZbsC@google.com>
In-Reply-To: <aiflaI4svEJvZbsC@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 9 Jun 2026 11:20:52 -0700
X-Gm-Features: AVVi8CeTKRxbhFjrttlZsJY9AQdiqj4OtT4AHceLLJ3_VrIG10WtubU1Iu-Bo5A
Message-ID: <CAE2F3rDgXxAhJFUX6=xars9H92t8NBDqcFRxU7d5wJQ7buUbNA@mail.gmail.com>
Subject: Re: [PATCH v8 07/12] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 3:05=E2=80=AFAM Pranjal Shrivastava <praan@google.co=
m> wrote:
> >
> > > Even if the worker CPU reorders the PTE write after the STOP_FLAG che=
ck,
> > > it is benign because the SMMU is incapable of fetching that (or any) =
PTE
> > > while the gate is closed. Because GATE_CLOSED =3D=3D SMMUEN =3D 0, im=
plying no
> > > access to any HW structures whatsoever.
> > >
> > > The real synchronization happens in the Resume Path:
> > >
> > > 1. arm_smmu_device_reset() clears all caches / TLBs.
> > >    (None of these can have entries before SMMUEN=3D1)
> > >
> > > 2. We execute a full smp_mb() before setting SMMUEN=3D1. (that's why =
we
> > >    need smp_mb before SMMUEN=3D1). This barrier ensures that any PTE
> > >    writes made by any thread=E2=80=94including those that were elided=
 while the
> > >    gate was closed, are globally visible before the SMMU hardware sta=
rts
> > >    fetching into TLBs again. (This is why Jason suggested this in v6 =
[1])
> >
> > A barrier on one CPU has no bearing on whether writes by any other CPU
> > can be observed by any particular agent in the system.
> >
> > Let's compare this with the long comment in
> > arm_smmu_domain_inv_range() which is what I believe Jason was
> > referring to. In that example, you see smp_mb() in the code path on
> > CPU0 and dma_wmb() in the code path on CPU1. Hence, barriers exist on
> > both sides. If you compare the runtime PM design with
> > arm_smmu_domain_inv_range(), then smp_mb() belongs in the CPU thread
> > that performs the translation table updates not the one that performs
> > the suspend/resume operation.
> >
>
> I might be missing something here, so please bear with me. My
> understanding it that's needed because the IOMMU is live & actively
> caching, which is not true for our case.

I think the "invs" design (Per-domain invalidation array) is more
similar than you think! An SMMU being absent from invs is equivalent
to the STOP flag, and the STE pointing to TTB0 is roughly the
equivalent of SMMEN=3D1 i.e. the IOMMU is not actively caching a
particular translation domain until an STE (or CD) points to it.

> [Assuming we use non-relaxed semantics & ordering for the STOP flag,
> i.e. set STOP_FLAG + barrier & clear STOP_FLAG (implicit dma_wmb())]
>
> In our case, during the resume op, we first clear the STOP_FLAG before
> setting SMMUEN=3D1 in program order. Thus, any PTE invalidations occurrin=
g
> before SMMUEN=3D1 are executed, i.e. EVEN when the SMMU is guaranteed not
> to access any structures, we've resumed invalidations.

"[...] we first clear the STOP_FLAG before setting SMMUEN=3D1 in program
order." I think this should be modified to "we first clear the
STOP_FLAG and ensure that the cleared STOP_FLAG is observable by all
other CPUs before setting SMMUEN=3D1"

Re "Thus, any PTE invalidations occurring before SMMUEN=3D1 are
executed,": I think that "a PTE invalidation occurring" is not clearly
defined. Also, it's not clear to me what this statement implies. It's
paramount that invalidations are performed when SMMUEN=3D1. The fact
that we perform invalidations before SMMUEN=3D1 is more of a side effect
of our methodology.

I would define a set of invariants:

 * If an agent observes the STOP flag, it is guaranteed that SMMUEN=3D0
(with ABORT set) at the time of observation.
 * Any transition from a set STOP flag to SMMUEN=3D1 involves an
invalidate-all operation prior to setting SMMUEN=3D1

Hence, if a CPU observes the STOP flag, it is assured that (a)
transactions are blocked and (b) if the SMMU is ever re-enabled, an
invalidate-all is performed prior to it being enabled.

I would then argue that all operations support these invariants. For
example, we need proper barriers in the iommu_unmap path to ensure
that the STOP flag is only checked *after* the translation table
update is made. Hence, we need a memory barrier.

I look at it this way: Every elided invalidation creates an
"invalidation deficit", and this deficit is tolerable for two reasons:
(a) SMMU blocks all transactions while there is a deficit. (b) An
invalidate-all eliminates any deficit accrued while the STOP flag was
set.

> Let's consider a few examples:
>
> 1. SUSPEND (say CPU0 is suspending)
>
> [CPU0] SMMUEN =3D 0 =3D=3D> SMMU stops accessing HW structures (ABORT NOT=
 set)

I thought we never disable the SMMU unless ABORT is set.


>                       HW structures not accessed means no TLB / CFG
>                       cache accesses as well according to the spec.
>
> [CPU1] =3D=3D> PTE update =3D> Invalidate =3D> Succeeds (although SMMUEN =
=3D 0)
>
> [CPU0] GBPA.Abort set =3D=3D> Txns are blocked
>
> [CPU2] =3D> PTE update =3D> Invalidate =3D> Succeeds [Txns blocked + SMMU=
EN=3D0]
>
> [CPU0] =3D=3D> SET STOP_FLAG =3D=3D> Elision begins
>
> [CPU3] =3D=3D> PTE update =3D=3D> Invalidation =3D=3D> Elided [Txns block=
ed + SMMUEN=3D0]
>
> Hence, the races in the suspend sequence are handled correctly.

I'm not sure if this description demonstrates that every possible race
is handled correctly. If I compare this with Nicolin's presentation in
arm_smmu_domain_inv_range, I like that presentation, as it explicitly
mentions loads and barriers. For example, it has an smp_mb() followed
by "// load the updated invs". I think you should make have something
like "smp_mb() ; CHECK STOP_FLAG" in your presentation. Currently, the
STOP_FLAG checking is somehow implicit in "Invalidation".

>
> 2. RESUME (say CPU0 is resuming)
>
> [CPU1] =3D=3D> Update PTE =3D=3D> Invalidate =3D=3D> Elided [Txns blocked=
 + SMMUEN=3D0]
>
> [CPU0] =3D=3D> Clear STOP_FLAGs [Txns still blocked + SMMUEN=3D0]
>
> [CPU2] =3D=3D> Update PTE =3D=3D> Invalidate =3D=3D> Succeeds [Txns block=
ed + SMMUEN=3D0]
>
> [CPU0] =3D=3D> Invalidate all TLB =3D=3D> Succeeds [Txns still blocked + =
SMMUEN=3D0]
> [CPU0] =3D=3D> Invalidate all CFG =3D=3D> Succeeds [Txns still blocked + =
SMMUEN=3D0]
>
> [CPU2] =3D=3D> Update PTE =3D=3D> Invalidate =3D=3D> Succeeds [Txns still=
 blocked + SMMUEN=3D0]
>
> [CPU0] =3D=3D> Set SMMUEN =3D 1 [SMMU can now access in memory structures=
]
>            However, the TLBs and CFG caches are clean because everything
>            until this point couldn't have cached anything anyway.

My concern with this diagram is that it appears sequential, suggesting
operations happen in a specific order across CPUs when they, in fact,
occur in parallel. I find these diagrams more useful for describing
failure cases than for proving that every race is handled correctly.

>
> Hence, right after clearing the STOP_FLAG, we're taking in invalidations
> as normal in the resume, much before the real caching can begin.
>
> Thus, by resuming invalidations before SMMUEN=3D1, we guarantee a
> consistent state before the very first translation is performed.
>
> Apart from this, I guess I'll drop the can_elide check from all
> invalidation paths.
>
> Does that sound fine?

Dropping can_elide sounds fine. However, if you still use this
function, for example in the gerror handler, then you might consider
renaming it.
