Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9082B441F
	for <iommu@lists.linux.dev>; Tue,  2 Jan 2024 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cgcn5vov"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-425928c24easo2379381cf.0
        for <iommu@lists.linux.dev>; Tue, 02 Jan 2024 00:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704182957; x=1704787757; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXqDN1glbddsJ7H96hx+dpFOqwsQROnv6wlA/VYO3D0=;
        b=Cgcn5vovZX6XnCyfNX5oZi88A1BNVwf2CIJBYFpI+rKM4MQV8gcvqMkv29F/M14n3h
         I3RTjAwaNPfey/SOnwTcNdWfNGBL8U20zmQmKnmhsCUaNe9oShX9aCGc1D/ssFITpnG4
         C3l8MnoBg/f0L0/TSg+ip/gQMZ1fNWdLjpV8FErPrJu6699bnlT9dCjl64gNlMTe99Wn
         lgjsc7d49DdHoA/p3uwAv0D621/0uMRpC49pSG8MO6qReCxGveBkw/k7n0gYkDQeqImL
         c9Wbso1ykg7dW2FI+hgS4bE5DhXUzu41844mjr+e7EHYyV0NrYgAwLTDTfZ4GlDSclBW
         tf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704182957; x=1704787757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXqDN1glbddsJ7H96hx+dpFOqwsQROnv6wlA/VYO3D0=;
        b=nHl51msCaoFlXQfkIe6kqhgjNwXs2zmJCn6KK+wG8HFOSDbzgEnfxmDBo8FpL35cn5
         9y2r/pn4swlBPuGl20L+jpysSK+WwENTNN1WmWQWAlqZVyed1iH3svCyC3WMYooQjIMH
         JlpQkLiSRVfHI+9HhcxHcOX5z8oU0GhFVCPNYbFovZc2yimDV3ud5TdQPlhlUZ6g9rdg
         bUU1KO0uLojo/A4BlDvxbQUUF4wEck4BTk9EAQXL/kHn5Ltg0drCpQSuvt12YyElsh+A
         n0t0v2uViZEiMSoIaOLPejiLGvHh3obBRsjhrJH+NyScAfZSHrubf3B43rQLK77BblJt
         edrQ==
X-Gm-Message-State: AOJu0Yx8wKRzSDDIr9xaKlsEGyhB6l4TAxHnCU1g5HxOEeW7rPq8r3Fu
	tS5pRtAuu7VBRDkrdrFk+K25SutJe9tZPRbTvrD7RgI4uq0y
X-Google-Smtp-Source: AGHT+IGvbNHzTJ5agMGiSnZqJ3O+MKd0jx9Cf5kf4dkeKDtz6kHD9C7l48/e3rZFw6tymH+c1HrQ1KEYyNV+t/hOFuw=
X-Received: by 2002:ac8:5894:0:b0:427:e98d:9928 with SMTP id
 t20-20020ac85894000000b00427e98d9928mr872470qta.14.1704182957285; Tue, 02 Jan
 2024 00:09:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231012121616.GF3952@nvidia.com> <CAKHBV27G1PLZ5gkYkOOCZdD9waZOZypkWqk4_HSR4XXGFT-+LA@mail.gmail.com>
 <20231018130455.GU3952@nvidia.com> <CAKHBV270uJjdj4zeK-NNt+j3TiqoGDdLUQ5uRrLw9PN0ysCDbw@mail.gmail.com>
 <20231020113918.GD3952@nvidia.com> <CAKHBV274M-DDD+vJgO-k9s4MF=FLhKajPdphfBVofjyOS3vHbA@mail.gmail.com>
 <CAKHBV24nfdq1q76T+DRQGNYeA-kP7ONnSjDsRFGsQCJVSrSm0w@mail.gmail.com>
 <ZX7xu8jN/rBZ4A/d@nvidia.com> <CAKHBV26CRC8eWMuOk6EZYMHOZoR2FauP=NBazzOiWCmQYEa1vg@mail.gmail.com>
 <CAKHBV27qsgjgwPfn8OpSq30z1w203NDqBZ0s66bPgjp1XDnLOg@mail.gmail.com> <20231227154648.GB50406@nvidia.com>
In-Reply-To: <20231227154648.GB50406@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 2 Jan 2024 16:08:41 +0800
Message-ID: <CAKHBV26yjLu-EUoBJT8EL_EbLE5oqLUL-_hwh2YDp2JH1EyAMw@mail.gmail.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming independent
 of the callers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 11:46=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Tue, Dec 19, 2023 at 09:42:27PM +0800, Michael Shavit wrote:
>
> > +static void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer,
> > +                                __le64 *cur, const __le64 *target,
> > +                                __le64 *staging_entry)
> > +{
> > +       bool cleanup_sync_required =3D false;
> > +       u8 entry_qwords_used_diff =3D 0;
> > +       int i =3D 0;
> > +
> > +       entry_qwords_used_diff =3D
> > +               writer->ops.get_used_qword_diff_indexes(cur, target);
> > +       if (WARN_ON_ONCE(entry_qwords_used_diff =3D=3D 0))
> > +               return;
>
> A no change update is actually API legal, eg we can set the same
> domain twice in a row. It should just do nothing.
>
> If the goal is to improve readability I'd split this into smaller
> functions and have the main function look like this:
>
>        compute_used(..)
>        if (hweight8(entry_qwords_used_diff) > 1) {
>              set_v_0(..);
>              set(qword_start=3D1,qword_end=3DN);
>              set(qword_start=3D0,qword_end=3D1); // V=3D1

This branch is probably a bit more complicated than that. It's a bit more l=
ike:
       if (hweight8(entry_qwords_used_diff) > 1) {
             compute_staging_entry(...);
             compute_used_diffs(...staging_entry...)
             if (hweight(entry_qwords_used_diff) > 1) {
                 set_v_0();
                 set(qword_start=3D1,qword_end=3DN);
                 set(qword_start=3D0,qword_end=3D1); // V=3D1
             } else {
                 set(qword_start=3D0, qword_end=3DN, staging_entry, entry)
                 critical =3D ffs(..);
                 set(qword_start=3Dcritical,qword_end=3Dcritical+1);
                 set(qword_start=3D0,qword_end=3DN);
             }
      }

>        } else if (hweight8(entry_qwords_used_diff) =3D=3D 1) {
>              set_unused(..);
>              critical =3D ffs(..);
>              set(qword_start=3Dcritical,qword_end=3Dcritical+1);
>              set(qword_start=3D0,qword_end=3DN);

And then this branch is the case where you can directly switch to the
entry without first setting unused bits.

>        } else { // hweight8 =3D=3D 0
>              set(qword_start=3D0,qword_end=3DN);
>        }
>
> Then the three different programming algorithms are entirely clear in
> code. Make the generic set() function skip the sync if nothing
> changed.
>
> > +       if (hweight8(entry_qwords_used_diff) > 1) {
> > +               /*
> > +                * If transitioning to the target entry with a single q=
word
> > +                * write isn't possible, then we must first transition =
to an
> > +                * intermediate entry. The intermediate entry may eithe=
r be an
> > +                * entry that melds bits of the target entry into the c=
urrent
> > +                * entry without disrupting the hardware, or a breaking=
 entry if
> > +                * a hitless transition to the target is impossible.
> > +                */
> > +
> > +               /*
> > +                * Compute a staging entry that has all the bits curren=
tly
> > +                * unused by HW set to their target values, such that c=
omitting
> > +                * it to the entry table woudn't disrupt the hardware.
> > +                */
> > +               memcpy(staging_entry, cur, writer->entry_length);
> > +               writer->ops.set_unused_bits(staging_entry, target);
> > +
> > +               entry_qwords_used_diff =3D
> > +                       writer->ops.get_used_qword_diff_indexes(staging=
_entry,
> > +                                                               target)=
;
>
> Put the number qwords directly in the ops struct and don't make this
> an op.  Above will need N=3Dnumber of qwords as well.

The reason I made get_used_qword_diff_indexes an op is because the
algorithm needs to compute the used_bits for entries (for the current
entry, the target entry as well as the melded-staging entry). This
requires a buffer to hold the output of the used_bits op however.
We're already passing such a buffer to arm_smmu_write_entry for the
staging_entry, and I wasn't a fan of adding a second one.
