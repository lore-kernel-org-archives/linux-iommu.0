Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E31DFE4
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 04:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731384132; cv=none; b=sJ2VbrwphMMtcQNcGTtmTOQrWwJgR30yLT54leex45onGIZP/pf6K00P0/dNWOBM5tpbtbU3wtGdz6y3aWThHq8bbLMU+i06kjcmEkJEYmeyPHFkgomKI1qexz974VL72vRkj7I0QHmFq+61tQ3p4djPIVtzaL84wPwXX5hshjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731384132; c=relaxed/simple;
	bh=h7CNVC4Hr2h29OebJaUEJ1gFJRuyJn3EaNYcQSx6tBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+Nobd73JC7JBUgj0FgIsOfxESI/v3iGbCIbBcEVYt1sVnucK430gcErmBo5uRRS7w68H/Lw0gKyybE2FM6UotBZIxcAAGtT81zKNgk35n5Fru6hnDqO+c0+F03haxY16TbHEsWLgUO9QZjFZsyeMQhWqxeUivBqM+KGWbfQvhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ysxLrJXI; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ysxLrJXI"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e681ba70so8405e87.1
        for <iommu@lists.linux.dev>; Mon, 11 Nov 2024 20:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731384129; x=1731988929; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZCjCqjU8q27UfRs4zUWMgqZ2NYmCLWuGe5eYpBVEWk=;
        b=ysxLrJXIoELSblSrcewsEOSak5uKzx+g/fcZ8jVdae5TIlEdhdZZMNhdDKHRF/3QKP
         R1rblB4hSMzyg1IuOHuVilJ9+Lb3Cwjr/nZXwZaJyyeAJyNCdiCuTD3s1FO8eIOs5YSn
         0fW3h1sxMpXUgZvLvfkshWuO/NLq/LQSvjlf+SyCayQHn4bE5IJK6mp4u1ZRVALu43/x
         dupOdLRM2PGw23B9tSvdDlmraySSZaTgkqRntXYnNCp3S2Wqb7i6d/XwrE2AL44jIBAx
         EHmcnyZlg74V/IqxXlv396ATQwJOVuQF/9EThAeJPOEDWiA4+hkbfcYDBjPUNmUfe9E+
         xgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731384129; x=1731988929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZCjCqjU8q27UfRs4zUWMgqZ2NYmCLWuGe5eYpBVEWk=;
        b=KWnkTnbVcP1uUs6Tex8DJwkKvprQLVa9D62lbkdtAaAMOWQCUhvzHSBnBKtpRmwZcb
         NIDSZAIlVt2bp9siRS8ims62nNPFmdx46jpbIYA8JnR495f1B+5ZnN+0uq/aULGVGtrh
         cCWVbPNzUXGfm7mJHLJzVWkcvIXDYjRAvF7DpsvmWqZY/X70BziBmqAYCEEQ/I5ucHNn
         4WMWkV4ycpmtgtxAAIoUTcjA06GOyC+puV8ANRhpVvv9A43HnhKBvqULb7RDdkXmy4xi
         bvMKUc5UpmSEGlekmdAIw9sFtJuElPRfY0PXkGUf92yc8rGSdjLPOz+de47x6iHOy+QS
         m92Q==
X-Forwarded-Encrypted: i=1; AJvYcCVf5wNKnh00vnoSdN2z9DnPLcYbD927QMTdmvAZVSmeC/N45dWUOlkIqOQCTwzI6iYLXSU8xA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzq2XIW6Pkf3zpQ3yY+pmw9Oh9rvo3+Gm9mzpbVWEq2pVD6NKhu
	vnuCZfwEAmGkvrzlRkRBaty+N0Jq4cfdEBPgz93dCsFYew1jJ3VAuBRHUL1DCpk22YdHddnzo52
	c9z7b0BEAmbWe0mw/3gt5JiVHPLyeahppa5jS
X-Gm-Gg: ASbGnct3FgILsAxa9v9XEd9d+zKimfGuvnfYT8euJlMw9E5kMPOt+Xi8mTQ2z7KnGuF
	ZT0x3Su/aQxWHm0v8zkwGcIh5XOqtfXK3CP4kI/Kc0epj3MFwCfYmTkISP9Bo71PwPQ==
X-Google-Smtp-Source: AGHT+IFDLNZKgKH7MHOemlXDu1GZ6nrmesYei3eAOIwoeSTvx4Ncbdtq5RGVRNQHlcQPZdmbdz5QNhdeeNsE7HoMU04=
X-Received: by 2002:a05:6512:3c8c:b0:539:e436:f1d1 with SMTP id
 2adb3069b0e04-53d9b8c8e59mr83283e87.1.1731384129159; Mon, 11 Nov 2024
 20:02:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241018180022.807928-1-praan@google.com> <20241018180022.807928-2-praan@google.com>
 <CAE2F3rCZALbQQUNeaAqShgXz6UNnSQAagqE7RA9kAewBFJNenw@mail.gmail.com>
 <ZyzVTG8ffcFD8YFR@google.com> <CAE2F3rAL=a43NNK30omCyfKZR=_Gp2cNxHuUMcDd-xHN-Kvv=A@mail.gmail.com>
 <ZzKmth5__xVUme1P@google.com>
In-Reply-To: <ZzKmth5__xVUme1P@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Mon, 11 Nov 2024 20:01:58 -0800
Message-ID: <CAE2F3rDrdPz1daR-QQYQ7WmeXo9NSvkfHPKwyJ=Ln=yRJd4sEw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 4:52=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Mon, Nov 11, 2024 at 02:20:46PM -0800, Daniel Mentz wrote:
> > On Thu, Nov 7, 2024 at 6:57=E2=80=AFAM Pranjal Shrivastava <praan@googl=
e.com> wrote:
> > >
> > > On Wed, Nov 06, 2024 at 04:16:19PM -0800, Daniel Mentz wrote:
> > > > On Fri, Oct 18, 2024 at 11:00=E2=80=AFAM Pranjal Shrivastava <praan=
@google.com> wrote:
> > > > >
> > > > > Introduce `struct arm_smmu_event` to represent event records.
> > > > > Parse out relevant fields from raw event records for ease and
> > > > > use the new `struct arm_smmu_event` instead.
> > > > >
> > > > > Signed-off-by: Daniel Mentz <danielmentz@google.com>
> > > > > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > > > > ---
> > > >
> > > > > +struct arm_smmu_event {
> > > > > +       struct arm_smmu_device          *smmu;
> > > > > +       u8                              id;
> > > > > +       u8                              class;
> > > > > +       u16                             stag;
> > > > > +       u32                             sid;
> > > > > +       u32                             ssid;
> > > > > +       u64                             iova;
> > > > > +       u64                             ipa;
> > > > > +       u64                             raw[EVTQ_ENT_DWORDS];
> > > >
> > > > Consider removing the member named raw from struct arm_smmu_event.
> > > > Compare this with struct arm_smmu_cmdq_ent and
> > > > arm_smmu_cmdq_build_cmd() which keep the encoded and decoded versio=
ns
> > > > separate.
> > >
> > > I had a similar implemntation in v3 [1] but it was decided [2]
> > > to keep the "raw" event array within arm_smmu_event itself. Since
> > > otherwise we'd have two variables, one pointing to the other when the=
y
> > > have the exact same scope and lifetime anyway.
> >
> > I understand that the concern in [2] was that "one [is] pointing to
> > the other". At the time, I think you had a pointer in struct
> > arm_smmu_event named raw, and the feedback was to embed the raw event
> > data in the structure instead of having a pointer. What I'm proposing
> > is to neither have a pointer nor embed it in the struct.
> >
> > >
> > > Do we have a strong preference here?
> >
> > Not a strong preference, but I'd prefer to have the raw event and the
> > decoded event separate.
> >
>
> I see. So, do you suggest that we should have the raw print as it is and
> then the pretty print separately like the following:
> ---------------------------------------->8-------------------------------=
-----
>
>         while (!queue_remove_raw(q, raw_evt)) {
>
>                 arm_smmu_decode_event(raw_evt, &evt);
>
>                 if (arm_smmu_handle_evt(smmu, &evt)) {
>                         dev_err(smmu->dev, "event 0x%02x received:\n", ev=
ent->id);
>                         for (i =3D 0; i < EVTQ_ENT_DWORDS; ++i)
>                                 dev_err(smmu->dev, "\t0x%016llx\n", raw_e=
vt[i]);
>                         arm_smmu_dump_event(smmu, &evt, &rs);
>                 }
>
>                 put_device(evt.dev);
>                 cond_resched();
>         }
>
> ---------------------------------------->8-------------------------------=
-----
>
> OR should we pass the raw event to the dump_event function which, I
> believe, is a little duplicative:
>
> ---------------------------------->8-----------------------------
>
>         while (!queue_remove_raw(q, raw_evt)) {
>                 arm_smmu_decode_event(raw_evt, &evt);
>                 if (arm_smmu_handle_evt(smmu, &evt))
>                         arm_smmu_dump_event(smmu, &evt, raw_evt, &rs);
>                 put_device(evt.dev);
>                 cond_resched();
>         }
>
> ---------------------------------->8-----------------------------

Your second option would be my preference despite the fact that you
have to pass in an extra parameter. It makes it clear that
arm_smmu_dump_event prints both. I would make sure that the order of
&evt and raw_evt in the argument list matches the order in which
arm_smmu_dump_event is printing them.

>
> > >
> > > >
> > > > > +       bool                            stall;
> > > > > +       bool                            ssid_valid;
> > > > > +       bool                            privileged;
> > > > > +       bool                            instruction;
> > > > > +       bool                            s2;
> > > > > +       bool                            read;
> > > > > +};
> > >
> > > Thanks,
> > > Praan
> > >
> > > [1] https://lore.kernel.org/all/20240928005143.2378938-2-praan@google=
.com/
> > > [2] https://lore.kernel.org/all/5eda3ba6-c35a-432b-be87-48bd8a0a3bf1@=
arm.com/
