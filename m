Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5760025D1E7
	for <iommu@lists.linux.dev>; Wed, 12 Mar 2025 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800234; cv=none; b=jdgsjmDxX4S+sKHlIN7jWNNJ8vs+4PgXBbkC7G8BAupkfl9dzCDb6q08FValEHHBAudDztR+rBHmKLXsi89icOF6YxiwXZ5rBObdzDODheT1ykDDZtObxH01sT6MFHGsUo8iHHX0gic1Eoq8kljTw+G0Gpw/WEcXtzgMFKOgaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800234; c=relaxed/simple;
	bh=NMt8Wtz/HNA8fdw1jMZJDg9OqGd6mKMbCmM27mIFUc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bx9/Slf2w6XoT3oQhS7GH+kwBO2NKShVfXgOxmPKXgh21aW+jenPFZSlgIoMSRK5qFBf45HYzPJLlBtLmHqORB0aSrhF6ri5FgYCHPJY+8IYSoPUlpRmBXgi9CyoOJ9nThrwGR/FqoJr9cPsWECQm4WNu+7bnjzin/I4HUtkjtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8GiIUkZ; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8GiIUkZ"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3cfc8772469so94535ab.3
        for <iommu@lists.linux.dev>; Wed, 12 Mar 2025 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741800231; x=1742405031; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGBwm8qMS+2GJaCafUPU+5noYTI4wXrs3yJkKVtCLXM=;
        b=D8GiIUkZu09zWafqe4IYHO9bHacV4OJwUJQqDZz83a3bylVorbgLE+0cKtMxyRuApg
         91XaI7ai0/FUWYjmPczk02oxLtP1ksewui6NH2z5IqcwRzN1blu+RNetu1DoqURzAExU
         MCL0+FyFtHp+GkBkvuGu97kKGKUoEyfbw9GDWlTNaAaN6BAK3Z1FHM/bz6EBYVLYstyo
         qkKSfBaVUOsZk96XwTun0YF7yIpUIj2SPPw95OMftpm5N7njtzR0jHLRdrN7j8l26XqC
         WVwlndAGlrm/+Y+zNfbGn8u9Ak4qKz7CPF8bjkYNSA58lED0bPRdwgCeu4pV1kbTjZzA
         D+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741800231; x=1742405031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGBwm8qMS+2GJaCafUPU+5noYTI4wXrs3yJkKVtCLXM=;
        b=XAYIgjuBtk+tC7vq4oKCPmHrhX/RAiAKMbbOcfEQgqdd3i7246pAG8hzxLVRK61jzG
         vyg1Skhy18BHqE7z6ou3i7GI2YEcA+G/HODgbfM6gHdgX7EmRn0kj+tJCcFkRXsQ/PFT
         yPB2zxd9GI7oY0rJFdVaa+R6d/cDF36vBD4YwLX5JdcpaPrhkpyJR22gXhlM3lnC1OC4
         ew9lxy4pAAUC1GTVTo1vpxVjB3id71EaXDJEbw+KnX8cjLs96/F4Zko6tKxVsdWZkOsG
         ATHbomahzJSiqXfqd8QHfutRsx4akIB8tzydKEQV+Zex2hoxTwmfdcZBvtZNErlE0odj
         nUgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/IzC73IgP+Hhb2dXGPwe2MlcDKiCog14rz+NML1yOwFLgG6TUyoC1J8OoY+S6SYTQkxCGIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7iusZfrHKlieLJg9dbyTDxtzTGxhZeu4O1GY5Y8mu9ov86Ccr
	7wMk9pUsT523yf0gaZS+HqJ3KV7AMnK7XMinfFI8bVhAWP4ROuJbiLfc1DvOddsXfFzlZWYQceP
	PpWQcmoaUd5eqHtN7S+xpBEdRokc=
X-Gm-Gg: ASbGncvnMfHhTCIBjZKBj9hKbmQRaK06hUgmJ1qu8R7vbcxcgczDhAKQN7mFxT6WJK5
	M8AiJqZdliw19tYDLcIQk0goyw8noLUMhksJDbRlmqbevwjl3+FFrWF5XFTIR0492Mi5PC4xuxL
	kUm05cG2ZyhpsFzCa8s46xuiuosrgtay8VK5XyiEYCdyxrSiYg4JxPMV9/uIM0Bwz5yQQ=
X-Google-Smtp-Source: AGHT+IGcOjBT5pnQnFzsB43flH0b/lHGboYrzDRZ8j3X26uAhwiB1vx8sBVrCRaRim73zA8BO7Uy4425SARrON6xCxo=
X-Received: by 2002:a05:6e02:1a84:b0:3d4:2362:98d8 with SMTP id
 e9e14a558f8ab-3d4419576dbmr239903965ab.2.1741800231340; Wed, 12 Mar 2025
 10:23:51 -0700 (PDT)
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
 <20250312164735.GA6561@willie-the-truck>
In-Reply-To: <20250312164735.GA6561@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 12 Mar 2025 10:23:36 -0700
X-Gm-Features: AQ5f1JpoGELyygSS0E-6GUOCTc5ufPPqVKk2sRxHePqLfAbRabP5NvXjW3XjOTE
Message-ID: <CAF6AEGskyoemQDrTXh=ewf61e-hVzWMjmqe=nX2J-65W5-M6Zw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] iommu/arm-smmu: Save additional information on
 context fault
To: Will Deacon <will@kernel.org>
Cc: Connor Abbott <cwabbott0@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 9:47=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Wed, Mar 12, 2025 at 07:59:52AM -0700, Rob Clark wrote:
> > On Wed, Mar 12, 2025 at 6:05=E2=80=AFAM Will Deacon <will@kernel.org> w=
rote:
> > > On Tue, Mar 11, 2025 at 06:36:38PM -0400, Connor Abbott wrote:
> > > > On Tue, Mar 11, 2025 at 2:06=E2=80=AFPM Will Deacon <will@kernel.or=
g> wrote:
> > > > > On Tue, Mar 04, 2025 at 11:56:47AM -0500, Connor Abbott wrote:
> > > > > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/io=
mmu/arm/arm-smmu/arm-smmu.c
> > > > > > index ade4684c14c9b2724a71e2457288dbfaf7562c83..a9213e0f1579d1e=
3be0bfba75eea1d5de23117de 100644
> > > > > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > > > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > > > > @@ -409,9 +409,12 @@ void arm_smmu_read_context_fault_info(stru=
ct arm_smmu_device *smmu, int idx,
> > > > > >                                     struct arm_smmu_context_fau=
lt_info *cfi)
> > > > > >  {
> > > > > >       cfi->iova =3D arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FA=
R);
> > > > > > +     cfi->ttbr0 =3D arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_T=
TBR0);
> > > > > >       cfi->fsr =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR)=
;
> > > > > > -     cfi->fsynr =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FS=
YNR0);
> > > > > > +     cfi->fsynr0 =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_F=
SYNR0);
> > > > > > +     cfi->fsynr1 =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_F=
SYNR1);
> > > > >
> > > > > We already have an implementation hook (->get_fault_info()) which=
 the
> > > > > qcom SMMU driver can override with qcom_adreno_smmu_get_fault_inf=
o().
> > > > > That thing dumps these registers already so if we're moving that =
into
> > > > > the core SMMU driver, let's get rid of the hook and move everybod=
y over
> > > > > rather than having it done in both places.
> > > >
> > > > As you probably saw, the next commit moves over
> > > > qcom_adreno_smmu_get_fault_info() to use this. The current back doo=
r
> > > > used by drm/msm to access these functions is specific to adreno_smm=
u
> > > > and there isn't an equivalent interface to allow it to call a gener=
ic
> > > > SMMU function so it isn't possible to move it entirely to the core.=
 At
> > > > least not without a bigger refactoring that isn't justified for thi=
s
> > > > series that is just trying to fix things.
> > >
> > > Ok :(
> > >
> > > > > >       cfi->cbfrsynra =3D arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_C=
BFRSYNRA(idx));
> > > > > > +     cfi->contextidr =3D arm_smmu_cb_read(smmu, idx, ARM_SMMU_=
CB_CONTEXTIDR);
> > > > >
> > > > > I think the CONTEXTIDR register is stage-1 only, so we shouldn't =
dump
> > > > > it for stage-2 domains.
> > > > >
> > > > Does it matter if we read the register though, as long as users are
> > > > aware of this and don't use its value for anything?
> > >
> > > I think the contents are "UNKNOWN", so it could be hugely confusing e=
ven
> > > if they just got logged someplace. Why is it difficult to avoid touch=
ing
> > > it for stage-2?
> > >
> > Fwiw, we are only ever using stage-1
>
> Sure, but this is in arm-smmu.c which is used by other people and support=
s
> both stages.

Sure, but no one else is using this field in the fault-info.  So maybe
the addition of a comment in the struct would be enough if it isn't
going to cause an SError/etc to read it for S2 cb?

BR,
-R
