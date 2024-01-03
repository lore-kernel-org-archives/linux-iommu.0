Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5031C281
	for <iommu@lists.linux.dev>; Wed,  3 Jan 2024 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QjpPflbN"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-427b515c2bbso331991cf.0
        for <iommu@lists.linux.dev>; Wed, 03 Jan 2024 08:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704300805; x=1704905605; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKDgRepcf6N2tVei+NcNW20UM0OXTbJwf9OyZ0AqW30=;
        b=QjpPflbNZ/zce5e42wWmqHB25W3Hx24TnBj+j+U92lkP/kqK1ChYXtLCtR7G/91K9M
         /HSr8sDWC8KamfuuwhSGexlJWbTxmFQGt+4lzPhBi00st7BJwEqUtGs83K+UGNO6UjSQ
         GZjAMvdQyTmoU0CKnJk4jG5A7Drj0bBtTQAmCArtNtxeoEZ2IpOP4WCBwPcGodME7JSS
         DwKz0LuhNnUKZIn/qbqTtKziGU0G1YnS4BkxaUrL1BN5pLYH3y0aB5pzrVUOT8mkPiVy
         htkHlpH6rqOE1Myc35aij6Fdsk18WCEtODfe0PvJQrAUdcvwxS6AxGhixUmPAtecvRVl
         TdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704300805; x=1704905605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKDgRepcf6N2tVei+NcNW20UM0OXTbJwf9OyZ0AqW30=;
        b=OakCg9risMTxYwu2+/0vrDemZMQdSQa7AK6ODgp0+SlqeQM8FxlYkxYPGSy2YDL0gs
         TAAJcNzgHofuPRxaQ72y8Cva1yb47lpqbOjzkCxt+juK4XFfu0OyJ4xTXjeXj9bh/e5u
         CQh2+/p+BOjfLKECyHgO6L8Qn9Nm4NcFHx/R20eSQ1ajHYCR2VVM8dgX3wtTbTwUJ9sL
         OhB0oVvi9psWvPpSZDRy9nrd6yNyBpCjiYrvL6tsX7IB9pIUpd3BsmocMUHGoEIU4kkT
         mcWT2IEilWKgxE1HRtEEXItjozAsh6UQYNwdfxjBqghn6jxh6zp52cZ0dVnwN8WQg69j
         AGjw==
X-Gm-Message-State: AOJu0YxkBaiskfW2FPaeLt7Ek0M+JddCh/tO00De+OCPQj30RXAiDyQf
	Kh/NY10gapT5uxKdpQBPLbhV1ZpV3MjsCXr/tfHoYmdqRugACAR6BM14k7tRq+eI
X-Google-Smtp-Source: AGHT+IGTqL8K9btZDekg/EWEb9WUdEx4ohLD9cjvj9tPGFfzlmL0v409R8NOWZrdLfsaE/QIl5sWR+rD1dC9St5ucF0=
X-Received: by 2002:ac8:7fd3:0:b0:425:7fb2:aa10 with SMTP id
 b19-20020ac87fd3000000b004257fb2aa10mr224800qtk.5.1704300805114; Wed, 03 Jan
 2024 08:53:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231018130455.GU3952@nvidia.com> <CAKHBV270uJjdj4zeK-NNt+j3TiqoGDdLUQ5uRrLw9PN0ysCDbw@mail.gmail.com>
 <20231020113918.GD3952@nvidia.com> <CAKHBV274M-DDD+vJgO-k9s4MF=FLhKajPdphfBVofjyOS3vHbA@mail.gmail.com>
 <CAKHBV24nfdq1q76T+DRQGNYeA-kP7ONnSjDsRFGsQCJVSrSm0w@mail.gmail.com>
 <ZX7xu8jN/rBZ4A/d@nvidia.com> <CAKHBV26CRC8eWMuOk6EZYMHOZoR2FauP=NBazzOiWCmQYEa1vg@mail.gmail.com>
 <CAKHBV27qsgjgwPfn8OpSq30z1w203NDqBZ0s66bPgjp1XDnLOg@mail.gmail.com>
 <20231227154648.GB50406@nvidia.com> <CAKHBV26yjLu-EUoBJT8EL_EbLE5oqLUL-_hwh2YDp2JH1EyAMw@mail.gmail.com>
 <20240102144814.GC50406@nvidia.com>
In-Reply-To: <20240102144814.GC50406@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 4 Jan 2024 00:52:48 +0800
Message-ID: <CAKHBV26TD-gzv3dB8VkGSJ9T8rrynPa-DL48s_VzfF1xb7xQjA@mail.gmail.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming independent
 of the callers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 10:48=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Jan 02, 2024 at 04:08:41PM +0800, Michael Shavit wrote:
> > On Wed, Dec 27, 2023 at 11:46=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.co=
m> wrote:
> > >
> > > On Tue, Dec 19, 2023 at 09:42:27PM +0800, Michael Shavit wrote:
> > >
> > > > +static void arm_smmu_write_entry(struct arm_smmu_entry_writer *wri=
ter,
> > > > +                                __le64 *cur, const __le64 *target,
> > > > +                                __le64 *staging_entry)
> > > > +{
> > > > +       bool cleanup_sync_required =3D false;
> > > > +       u8 entry_qwords_used_diff =3D 0;
> > > > +       int i =3D 0;
> > > > +
> > > > +       entry_qwords_used_diff =3D
> > > > +               writer->ops.get_used_qword_diff_indexes(cur, target=
);
> > > > +       if (WARN_ON_ONCE(entry_qwords_used_diff =3D=3D 0))
> > > > +               return;
> > >
> > > A no change update is actually API legal, eg we can set the same
> > > domain twice in a row. It should just do nothing.
> > >
> > > If the goal is to improve readability I'd split this into smaller
> > > functions and have the main function look like this:
> > >
> > >        compute_used(..)
> > >        if (hweight8(entry_qwords_used_diff) > 1) {
> > >              set_v_0(..);
> > >              set(qword_start=3D1,qword_end=3DN);
> > >              set(qword_start=3D0,qword_end=3D1); // V=3D1
> >
> > This branch is probably a bit more complicated than that. It's a bit mo=
re like:
> >        if (hweight8(entry_qwords_used_diff) > 1) {
> >              compute_staging_entry(...);
> >              compute_used_diffs(...staging_entry...)
> >              if (hweight(entry_qwords_used_diff) > 1) {
> >                  set_v_0();
> >                  set(qword_start=3D1,qword_end=3DN);
> >                  set(qword_start=3D0,qword_end=3D1); // V=3D1
> >              } else {
> >                  set(qword_start=3D0, qword_end=3DN, staging_entry, ent=
ry)
> >                  critical =3D ffs(..);
> >                  set(qword_start=3Dcritical,qword_end=3Dcritical+1);
> >                  set(qword_start=3D0,qword_end=3DN);
> >              }
> >       }
> >
> > >        } else if (hweight8(entry_qwords_used_diff) =3D=3D 1) {
> > >              set_unused(..);
> > >              critical =3D ffs(..);
> > >              set(qword_start=3Dcritical,qword_end=3Dcritical+1);
> > >              set(qword_start=3D0,qword_end=3DN);
> >
> > And then this branch is the case where you can directly switch to the
> > entry without first setting unused bits.
>
> Don't make that a special case, just always set the unused bits. All
> the setting functions should skip the sync if they didn't change the
> entry, so we don't need to care if we call them needlessly.
>
> There are only three programming sequences.

The different cases (ignoring clean-up) from simplest to least are:
1. No change because the STE is already equal to the target.
2. Directly writing critical word because that's the only difference.
3. Setting unused bits then writing critical word.
4. Installing breaking STE, write other words, write critical word.

Case 2. could potentially be collapsed into 3. if the routine that
sets unused bits skips over the critical word, so that it's a nop when
the only change is on that critical word.

> entry_qwords_used_diff should reflect required changes after setting
> the unused bits.

Ohhhhhhh, I see. Your suggestion is essentially to move this block
into the first call to get_used_qword_diff_indexes:
> > > > +               /*
> > > > +                * Compute a staging entry that has all the bits cu=
rrently
> > > > +                * unused by HW set to their target values, such th=
at comitting
> > > > +                * it to the entry table woudn't disrupt the hardwa=
re.
> > > > +                */
> > > > +               memcpy(staging_entry, cur, writer->entry_length);
> > > > +               writer->ops.set_unused_bits(staging_entry, target);
> > > > +
> > > > +               entry_qwords_used_diff =3D
> > > > +                       writer->ops.get_used_qword_diff_indexes(sta=
ging_entry,
> > > > +                                                               tar=
get);

Such that:
if (hweight8(entry_qwords_used_diff) > 1) =3D> non hitless
if (hweight8(entry_qwords_used_diff) > 0) =3D> hitless, potentially by
first setting some unused bits in non-critical qwords.

>
> > > > +       if (hweight8(entry_qwords_used_diff) > 1) {
> > > > +               /*
> > > > +                * If transitioning to the target entry with a sing=
le qword
> > > > +                * write isn't possible, then we must first transit=
ion to an
> > > > +                * intermediate entry. The intermediate entry may e=
ither be an
> > > > +                * entry that melds bits of the target entry into t=
he current
> > > > +                * entry without disrupting the hardware, or a brea=
king entry if
> > > > +                * a hitless transition to the target is impossible=
.
> > > > +                */
> > > > +
> > > > +               /*
> > > > +                * Compute a staging entry that has all the bits cu=
rrently
> > > > +                * unused by HW set to their target values, such th=
at comitting
> > > > +                * it to the entry table woudn't disrupt the hardwa=
re.
> > > > +                */
> > > > +               memcpy(staging_entry, cur, writer->entry_length);
> > > > +               writer->ops.set_unused_bits(staging_entry, target);
> > > > +
> > > > +               entry_qwords_used_diff =3D
> > > > +                       writer->ops.get_used_qword_diff_indexes(sta=
ging_entry,
> > > > +                                                               tar=
get);
> > >
> > > Put the number qwords directly in the ops struct and don't make this
> > > an op.  Above will need N=3Dnumber of qwords as well.
> >
> > The reason I made get_used_qword_diff_indexes an op is because the
> > algorithm needs to compute the used_bits for entries (for the current
> > entry, the target entry as well as the melded-staging entry).
>
> Make getting the used bits the op..

Right, I initially tried making get_used_bits the op but the problem
is where to store the output used_bits without dynamic allocation.
Introducing .get_used_qword_diff_indexes and .set_unused_bits bypasses
the issue. I agree it's a bit weird though.
Are you suggesting that get_used_bits()'s output would use storage
from its ops struct? With the requirement that calls to
get_used_bits() invalidates previous calls?
