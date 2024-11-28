Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773431448F2
	for <iommu@lists.linux.dev>; Thu, 28 Nov 2024 23:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732837266; cv=none; b=IuUpMIswT+JfvPDHoqwz243dsu3hJSUeCUU9KtWnCdLm6vpzOm8PQZCU/ph/RNKBhjCWDIYo2u7sDUk7w4qWUMeeHCUleR9AMtUDAojJXImCikqsyUn1D1wQEEiPu7vdfSWXCZI3/vrsaXcmX0vEw6eSl3mC2D08VFfsiH7FcNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732837266; c=relaxed/simple;
	bh=zcUQrItAb89RCHHdgY4YD0kNx1aHNSlSXraQAsIAlcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlVdOWfsnTfXjpi2s0DIAcT4cobtB0EMsc9lm+tNndko+NePBvw3HC6bGMgmlgXr8hCl3YiWN1tzWwIepf8JPHOye6AS136NPKv4FB4X4kVBXABWxiuAt3PIkUidgs0b7SK7OmNqXXwrEuoM6Cxtt+YY/MMzFgCj9EkH/TQKojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Euvpk9p0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Euvpk9p0"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cfb81a0af9so10296a12.0
        for <iommu@lists.linux.dev>; Thu, 28 Nov 2024 15:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732837263; x=1733442063; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Of39UhH2X3l60591N+NdykngT0+/DU+5FhbnZBcpvNQ=;
        b=Euvpk9p0n7Fu35UZ1ZAQy4vgyrYCf5efjTyzxfJt7hhhwOA/GEKGONjvcuE/Ly353S
         XIvfp3spYxyobNR/QKK8l57bLZcWlQRUCfDo1P2a0PLTNYQEEhq7GU0Ue2wpOl90tXLb
         ufiM9Q//Eje62N17V9t/0lmo2gaYzsL9TBlKfUp8w/XX3n104n+ACwemGlLwdkdMBGtV
         /EhREspK/Hcr/MVnR+Jd3xTQzXwSACJCqpaow5xt80+FWxT3QzLNcE5Ce94sI4Hnt4jb
         dCc0gEiypYAEshdtqsJ5xpz5Z4V9nyF9d0UchNOXZbg36k9SuSvS9ij80VvIm44VZkJK
         DMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732837263; x=1733442063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Of39UhH2X3l60591N+NdykngT0+/DU+5FhbnZBcpvNQ=;
        b=XaM0kJw9afFNbVuNXohpaQsPb75x9nnVR97RP3cpoThU21fmOWsTUHqir/dzfRUx6L
         M21UYR3npeaIyNo8jYKnIOjk5zo47yY/XobzWyx8JUJZfc4GifMgm+9JTHF18EPKHfYP
         xHY2uOFScArvkFSC2dhwg2HxBKWOxQP7cIt4zdK86RxnBpMlH0tcxFRB4gKOPRLa6dMb
         qg0EzC60A75lt/BuRraehsOxtsPtoOfg2fpeDj1gq/QpXLzbYFhSnhqfhCrb6Iv4JqEY
         5kX8TIDX8iDG6T8FmghVhRvqEBDz7Vt3Ep419++sHQbGXnOPcGE0hJ/LacbKxooqK4IL
         uZGw==
X-Forwarded-Encrypted: i=1; AJvYcCWp8gIyYBSicBrv7ntSqaLRDugO656/Vzh85p7sQpNea6dgvOnEqIG2UDqUBXCE3NHElJEnfA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZXnpVb6sOVZsX5tvhayNup3KBtPX7Op+cQwW0X42WRXbdTkHd
	n7sqUNsMHPYfQpxjJgY792AVQ3M1vr2l83BtWLTuZFDxH4F0qyZsBC0n8+5l6rWq5Ws0PTy2UbN
	3IP3wGug4R3+fJvysNV8iN/v3KrcsT4CKCUtH
X-Gm-Gg: ASbGncs2ES7Fj2NuKzfKOuXycwglZI5MjhazdfU6yFMQCpkVuvult+xRFdNTVcHPL4Q
	HJEbTY3KV6bM3U/ebEiP2g6BQLYOv8tW/Y1GccJmDsIT+TrcRRm3APUSfs1CqQHPR
X-Google-Smtp-Source: AGHT+IHzXKwXfnfwtZmtoW1s4dYHFmBapNpLwQaVsX3+3z+TsBAEkFeHhf+M7MdtlE0yq4VaTHv+dMvGOaEtYdGgYCA=
X-Received: by 2002:a50:ed8f:0:b0:5d0:acf3:e3a6 with SMTP id
 4fb4d7f45d1cf-5d0acf3e47amr8087a12.1.1732837262663; Thu, 28 Nov 2024 15:41:02
 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241112083018.1662104-1-praan@google.com> <20241112083018.1662104-2-praan@google.com>
 <CAE2F3rCO1PbzMEdJB1zRFK+FsbYa0w2TWrGL-XV6y9A9vrqytA@mail.gmail.com>
 <Z0blg7wbWr05qp3w@google.com> <CAE2F3rA1g7+KoOAjr5CUnD14zsnmnDxmW2KSpVZmdtzoA8ggrg@mail.gmail.com>
 <Z0eGtoLovKLBml6R@google.com>
In-Reply-To: <Z0eGtoLovKLBml6R@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Thu, 28 Nov 2024 15:40:51 -0800
Message-ID: <CAE2F3rBgxk_Ma_xOJcaqJ2XiPiQbJhGe+jHZNT2USqaTX7DGng@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 12:53=E2=80=AFPM Pranjal Shrivastava <praan@google.=
com> wrote:
>
> On Wed, Nov 27, 2024 at 11:42:11AM -0800, Daniel Mentz wrote:
> > On Wed, Nov 27, 2024 at 1:25=E2=80=AFAM Pranjal Shrivastava <praan@goog=
le.com> wrote:
> > > > > +       event->class =3D FIELD_GET(EVTQ_1_CLASS, raw[1]);
> > > > > +       event->iova =3D FIELD_GET(EVTQ_2_ADDR, raw[2]);
> > > > > +       event->ipa =3D raw[3];
> > > >
> > > > Shouldn't this be
> > > >
> > > > event->ipa =3DFIELD_GET(EVTQ_3_IPA, raw[3]);
> > >
> > > No. For this, there's a reason for not using the
> > > `FIELD_GET(EVTQ_3_IPA, raw[3]);`. As mentioned in the cover letter, t=
his
> > > was the root cause of the IPA truncation bug, i.e. FIELD_GET only
> > > fetches the IPA field without trailing zeroes, truncating the address=
.
> > > For e.g. IPA =3D 0xfffff instead of 0xfffff000 which is faulting addr=
ess.
> >
> > I disagree with the term truncation bug, because the information was
> > never there in the first place. Truncating the IPA was presumably a
> > conscious decision made by the architect. It is not a bug.
> >
>
> I'm NOT claiming that the HW or architecture has a bug.
> I meant that SW can't ONLY look at (and log) bits 51:12 only which the
> `FIELD_GET(EVTQ_3_IPA, raw[3]);` does (the values I've shared in the
> cover letter are actual values printed on QEMU). If we'd wanna use the
> `FIELD_GET(EVTQ_3_IPA, raw[3]);` then we'd also have to shift it by 12.

I believe that using FIELD_GET(EVTQ_3_IPA, raw[3]) and then left
shifting by 12 is the correct approach. As per the Arm ARM, software
shouldn't rely on RES0 bits being 0.

> > >
> > > Since the SMMUv3 spec ensures that the bitfields NOT representing an
> > > address, i.e. fields other than GENMASK_ULL(51,12) or GENMASK_ULL(51,=
3),
> > > are zeros. It's safe to read the raw[3] dword directly.
> >
> > Somewhere in the Arm ARM, I found the following language:
> >
> > "The RES0 description can apply to bits or fields that are read-only,
> > or are write-only: For a read-only bit, RES0 indicates that the bit
> > reads as 0, but software must treat the bit as UNKNOWN."
> > "A bit that is RES0 in a context is reserved for possible future use
> > in that context. To preserve forward compatibility, software: Must not
> > rely on the bit reading as 0."
> >
> > As it stands, I believe the code relies on RES0 fields reading 0 which
> > would violate this rule.
>
> The fields I'm talking about aren't marked as `RES0` in the spec. For
> example, if we look at Section 7.3.4 in the spec, F_STE_FETCH
> *explicitly* marks non-address fields as 0 not RES0. The same can be
> noticed in sections 7.3.10, 7.3.12 - 7.3.17 & 7.3.20. Unless I missed
> something that mentions that the "0" fields in event records are RES0?

It's RES0 in version G.a of the spec. It appears as if Arm changed
that between versions D.a and D.b.
