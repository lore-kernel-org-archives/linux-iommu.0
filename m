Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EED7194A53
	for <iommu@lists.linux.dev>; Tue, 28 Jan 2025 22:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738102555; cv=none; b=tbZ5ArLfANTpCGZN8tLHnGRZLt8C1yOMzHJJYaFBIY4YWSt2WLveK84EzxW2Nf4HiaViL1ULn2jzCuxeQvJhA69IsNZCN7cCZEyORHwS/JfgVUJfnlW4qNPSsSo8Dg0WmE/lm6iYXxB3COyLhuQIf/39Lg4obIomHgHdGR0z0d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738102555; c=relaxed/simple;
	bh=3VAnZ89saz7CB6pbJjcSjU9U6f1eSUHTOJ8AIdT9Ccw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utF0nLNrahBWdgssEiD9OXTYiHKCVO131vWw/Xqv4wFV9plLnQFHWEyUkhvN7oCLCWewe5P56IcM2mIKrAPKvF0LX4MfCLWZSWYc6wIcoTyYVSKilT1pu5tIvsNGdPN0QgD//WaT/ZbOd+qK4m9WrCFu5wu5+VZuDQaVoYNsGHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnZEwhoi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnZEwhoi"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2161a4f86a3so12265315ad.1
        for <iommu@lists.linux.dev>; Tue, 28 Jan 2025 14:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738102553; x=1738707353; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCB4v+WXq4lF4QrBSoQLeECXyKf0oYWAfbCsOcRv7h8=;
        b=SnZEwhoin43zgduSN+dxIdoKvnfsfvcsm3HaRM5WUb4hAwbKmPJrrZB9iNf27dFvV4
         M4X5LDNyvIUB4RkKWPELLkiA8o+1sqNCpRFh1C/RBqKUbp5F9CCuXj/tU2Rf4PYNmUlU
         3xZ+9D7pMQ9lrtYEA/eBX3rqZiEnRIlNVVP4WO4egyOifhcVoc22OILpWwmpwBaoXyrP
         3vmU7bKpeLrysTPfOHJHTY3omMkFgjI+ZdwVWceD81FbPsWiLW7NcAYzYmw3ync1h5Ln
         FU21AMkCe/Yb2lg3yHTCweXetu0CGpdZr4t++Ft7c4SYMdBJchuDunE4pVRRRQZsZKl2
         ERYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738102553; x=1738707353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCB4v+WXq4lF4QrBSoQLeECXyKf0oYWAfbCsOcRv7h8=;
        b=OJp3RquABjBx2Ppx57fi6wPJH8VC2YukrgxZaUbRhY20kB0FwyIHJiwmCbPkZDrHnT
         oAOL2ou4dmW3tc1inl+kEFz+H6u1+1QCdzm+kmXWCAiJ/r4hlFR6KOKbvOwi3qzAkNA+
         C3mQJzC0km3Z+soxtf+kBVAVFiq4chOM4TuVbE9ars1fFwAtbCD37cv6Jhrvwm7K4vlQ
         k0T7djJzq8+ZOcHwXeFogmI4W+v0iWyxo/7p0aCPWlapcUaap/A+S7Cyf4nmMA39cJzs
         qQFKQ2Pjy5tTCuFAlviv4nrODWJaDR/ej6xVNO15Ys7o2JuqGMRN544d3zGnEyG7lvpT
         qKjg==
X-Forwarded-Encrypted: i=1; AJvYcCUDJ/HUC+tRLFNWeJaOfMe80H3Oj4QFcAXAnjdJVkdPkmzc453LwMQGBRlNhRG6O6j/Sn+PpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzeJtrU58RviUEbw+Gaz/Fd4yGxgmH5MRJGOCqhvgkToTKAU37M
	UgqoZJH1MjrdCdK8Y4V1gFwCWMZzYWXpvO5r6zZelhu7fgXwIvNucHA9r3ANQAiMmGH8sQiLwc7
	2t5qKKXW/9vQ6goOHSbLK+IgsyqI=
X-Gm-Gg: ASbGncucjcjgbEbcYC5wIEc9EQ+AuL/P7F8zLMON28/ssIFoHz17SFJHQjRl421Xrhj
	3iFwf5rrMqgCc4Bb1fCB1TH+R/+cFwEvvI+2kzgq3kleE4RIeDw/s9StxF+AufxGDy/t4cqiI
X-Google-Smtp-Source: AGHT+IG/JmcUEYW3G4Bmqx5GSmXS6y3U6GnDUzXK7OMM0PqZHUQojy9s8Ihml9PYOSpGiLYloAZZ2FBD4HwsETOp5ok=
X-Received: by 2002:a05:6a21:1013:b0:1cf:2be2:5e5a with SMTP id
 adf61e73a8af0-1ed7a7105ddmr592759637.10.1738102553534; Tue, 28 Jan 2025
 14:15:53 -0800 (PST)
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
In-Reply-To: <CAF6AEGstcrAJDBpPm-uQ+zSDVEhDJ4AQhCTDT-z9_8Nq0e35WQ@mail.gmail.com>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 28 Jan 2025 17:15:42 -0500
X-Gm-Features: AWEUYZnR6X8QNZSt4NrL1WtbRcFAaPRCRbEEvulRWjwJr5nBO0UJqRrYtEh2Opo
Message-ID: <CACu1E7HErZAL=-GVQfKUAUK5bgK-X0qejt5os3f2UhkeZ1ptMQ@mail.gmail.com>
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

On Tue, Jan 28, 2025 at 5:10=E2=80=AFPM Rob Clark <robdclark@gmail.com> wro=
te:
>
> On Tue, Jan 28, 2025 at 3:08=E2=80=AFAM Prakash Gupta <quic_guptap@quicin=
c.com> wrote:
> >
> > On Thu, Jan 23, 2025 at 03:14:16PM -0500, Connor Abbott wrote:
> > > On Thu, Jan 23, 2025 at 2:26=E2=80=AFPM Prakash Gupta <quic_guptap@qu=
icinc.com> wrote:
> > > >
> > > > On Thu, Jan 23, 2025 at 09:00:17AM -0500, Connor Abbott wrote:
> > > > > On Thu, Jan 23, 2025 at 6:10=E2=80=AFAM Prakash Gupta <quic_gupta=
p@quicinc.com> wrote:
> > > > > >
> > > > > > On Wed, Jan 22, 2025 at 03:00:58PM -0500, Connor Abbott wrote:
> > > > > > The context would remain stalled till we write to CBn_RESUME. W=
hich is done
> > > > > > in qcom_adreno_smmu_resume_translation(). For a stalled context=
 further
> > > > > > transactions are not processed and we shouldn't see further fau=
lts and
> > > > > > or fault inerrupts. Do you observe faults with stalled context?
> > > > >
> > > > > Yes. I've observed that on MMU-500 writing RESUME before the inte=
rrupt
> > > > > has been cleared doesn't clear SS. This happened with v2 in the c=
ase
> > > > > where there was already a devcoredump and drm/msm called
> > > > > qcom_adreno_smmu_resume_translation() immediately from its fault
> > > > > handler, and we'd get a storm of unhandled interrupts until it wa=
s
> > > > > disabled. Given that the architecture spec says we're supposed to
> > > > > clear the interrupt first this may have been an attempt to "help"
> > > > > developers.
> > > > >
> > > >
> > > > Just to clarify, present sequence is:
> > > > 1. context fault with stall enable. FSR.SS set.
> > > > 2. Report fault to client
> > > > 3. resume/terminate stalled transaction
> > > > 4. clear FSR
> > > >
> > > > At what point when you try #2->#3->#4 or #4->#2->#3 sequence, is FS=
R.SS
> > > > cleared and interrupt storm is observed.
> > >
> > > With #2->#3->#4 FSR.SS is *not* cleared and there is a subsequent
> > > interrupt storm with only FSR.SS asserted. With #4->#2->#3 there is n=
o
> > > interrupt storm. From this we conclude that MMU-500 does not clear
> > > FSR.SS unless #4 happens before #3.
> > >
> > Thanks Connor for clarification. I get your point now. I think it's
> > expected interrupt storm with #2->#3->#4 sequence is expected.  With
> > CONFIG_ARM_SMMU_QCOM_DEBUG enabled, context fault follows the sequence =
of
> > #1->#2->#4->#3, which is spec recommended.
> >
> > so, common fault handler can be modified to follow the same sequence, b=
ut I
> > have concern regarding clearing FSR before reporting fault to client.
> > qcom_adreno_smmu_get_fault_info() is an example I gave but other client
> > handler may have similar expecation of fault register not changed befor=
e
> > client fault handler is called.
>
> Simple solution would be to move the clearing of FSR to after the
> fault is reported.  It doesn't really matter if it is before or after,
> as long as it happens before the irq handler returns, AFAIU.  And
> drm/msm will collect the fault info from the irq handler.

As I said in the earlier mail: "From this we conclude that MMU-500
does not clear FSR.SS unless #4 happens before #3." #4 is clearing FSR
and #3 is writing RESUME. So no, unfortunately it does actually matter
and we get a storm of unhandled IRQs if we don't clear FSR first. Your
solution is what v2 did and it didn't work.

Connor

>
> BR,
> -R
>
> > > > The way CFIE disable is helping
> > > > with current patch indicates write FSR is unstalling context and su=
bsequent
> > > > transactions are faulted.
> > >
> > > No, it does not indicate that. The interrupt storm happens even when
> > > there is exactly one context fault, and when the interrupt storm
> > > happens *only* FSR.SS is asserted. I've verified this with debug
> > > prints. Once more, MMU-500 will assert an interrupt when only FSR.SS
> > > is asserted. This has nothing to do with subsequent transactions.
> > >
> > > > Do you stop getting interrupt storm after write
> > > > RESUME.
> > >
> > > Yes, as long as the write to RESUME happens after all other bits in
> > > FSR are cleared.
> > >
> > > > If you can mention your SCTLR configuration and FSR state in test
> > > > sequence, it would be clearer.
> > >
> > > SCTLR has both HUPCF and CFCFG enabled.
> > >
> > > >
> > > > An aside, If reducing delay between FSR and RESUME write helps then=
 both
> > > > can be done as part of qcom_adreno_smmu_resume_translation(). This =
will
> > > > follow spec recommendation and also make sure fault registers are n=
ot
> > > > cleared before reporting fault to client.
> > I think this sequence should address the issue you are observing.
> >
> > > >
> > > > Thanks,
> > > > Prakash
