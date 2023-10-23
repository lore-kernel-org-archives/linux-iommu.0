Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC86DDCC
	for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BeXX2P4J"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-41cd566d8dfso371601cf.0
        for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 01:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698050232; x=1698655032; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TQJc0M4+SeyKd+ttaAkOrknn5tDZ8dUFGrr8JGI45I=;
        b=BeXX2P4J+QoIVW2dgXATaLiw6IzwAnI2iiji5i+s7UVc+0Ua6Bvor3PsDf4OiEc23E
         bV2O0eZRE6Y8kEkxEs6e7idUO66JhWFvycGC+F3OHSk0p9wvPkJxB1uQoCPKZqyvh9YL
         P2CTPJn7UkThJTWerJZ0/wmBaaHUpHQfF4Fk0Lj3HWMpSXGJon/Iqpj7c5D9o6oLrLyU
         g1A60Fb/CYfy5SqoKd7qQYJfpC8xVzKO0qG5hk+o40a9ynQJusFAvZlyNRYc7OU5Hxl+
         ZKDFZn+BOvS+etUJ52Z3yX6x3I+yVeZfTOgwjjKhvYFPWCPZxXtR1r3x3+saeIC78EI8
         VMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698050232; x=1698655032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TQJc0M4+SeyKd+ttaAkOrknn5tDZ8dUFGrr8JGI45I=;
        b=oOb1eD0JzAMT2ib+GLvj07MDodAorW3aM2W2n+AKb6l1MPCek/zyUduMljyjYzjgjY
         UDnZuuP0Q0eDXDNFQGHvOSIsRAY4EcIy/5e5lCz/8Ypcz0P3vhxe1BQedwiBAZSuLNMA
         5+dSjBLaMhw+Rr/OWyprnkQFf8vOgantWOHkIeZx4qHhPEppVXTj3LRL+1WGdJMAnWEF
         BIbb3bKFTDgwpMej15BDnVn9MIhRDYlZHoAcWk50mjBtnPYEHEGrQ4KGceIKzMeLSD9A
         8YO38s5NHcRNh8shobISIyPZvSL/j6mAS0Fs/ksk+DHXq44xOCyDZ+xXP7KICMLgJlGg
         eYPg==
X-Gm-Message-State: AOJu0Yz2gWefaHOC603aluYPedQApAPF5DuNG+mYxOevBdva3pghgusy
	FpIDwlD/2Q57h+7+qyVsKGqEFf0yoEZEL4FjqQ/3ew==
X-Google-Smtp-Source: AGHT+IFnBiaDknRW08/YzSobBkhpDyeBNJoPWEqg6yQoVDxwt2VAkA8WoPCHMuNpEIB13oSbBAbTPzNzp8I7DM8Gt1Y=
X-Received: by 2002:ac8:4d0e:0:b0:410:9af1:f9b4 with SMTP id
 w14-20020ac84d0e000000b004109af1f9b4mr711201qtv.10.1698050232388; Mon, 23 Oct
 2023 01:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <4-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com> <CAKHBV24UGZuG6+J4cybadJCTyf9hN+e_VgAC0NVOPotmEur7SQ@mail.gmail.com>
 <20231012121616.GF3952@nvidia.com> <CAKHBV27G1PLZ5gkYkOOCZdD9waZOZypkWqk4_HSR4XXGFT-+LA@mail.gmail.com>
 <20231018130455.GU3952@nvidia.com> <CAKHBV270uJjdj4zeK-NNt+j3TiqoGDdLUQ5uRrLw9PN0ysCDbw@mail.gmail.com>
 <20231020113918.GD3952@nvidia.com>
In-Reply-To: <20231020113918.GD3952@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Mon, 23 Oct 2023 16:36:36 +0800
Message-ID: <CAKHBV274M-DDD+vJgO-k9s4MF=FLhKajPdphfBVofjyOS3vHbA@mail.gmail.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming independent
 of the callers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 7:39=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Fri, Oct 20, 2023 at 04:23:44PM +0800, Michael Shavit wrote:
> > The comment helps a lot thank you.
> >
> > I do still have some final reservations: wouldn't it be clearer with
> > the loop un-rolled? After all it's only 3 steps in the worst case....
> > Something like:
>
> I thought about that, but a big point for me was to consolidate the
> algorithm between CD/STE. Inlining everything makes it much more
> difficult to achieve this. Actually my first sketches were trying to
> write it unrolled.
>
> > +       arm_smmu_get_ste_used(target, &target_used);
> > +       arm_smmu_get_ste_used(cur, &cur_used);
> > +       if (!hitless_possible(target, target_used, cur_used, cur_used))=
 {
>
> hitless possible requires the loop of the step function to calcuate
> it.

Possibly yes. Another option would be to have a list of transitions
(e.g. IDENTITY -> S1) we expect and want to be hitless and check
against that list. It defeats some of the purpose of your design, but
it's also not obvious to me that we really need such flexibility in
the first place.

>
> > +               target->data[0] =3D STRTAB_STE_0_V;
> > +               arm_smmu_sync_ste_for_sid(smmu, sid);
>
> I still like V=3D0 as I think we do want the event for this case.

Oh yeah sure, I did not think too carefully about this.

>
> > +               /*
> > +                * The STE is now in abort where none of the bits excep=
t
> > +                * STRTAB_STE_0_V and STRTAB_STE_0_CFG are accessed. Th=
is allows
> > +                * all other words of the STE to be written without fur=
ther
> > +                * disruption.
> > +                */
> > +               arm_smmu_get_ste_used(cur, &cur_used);
> > +       }
> > +       /* write bits in all positions unused by the STE */
> > +       for (i =3D 0; i !=3D ARRAY_SIZE(cur->data); i++) {
> > +               /* (should probably optimize this away if no write need=
ed) */
> > +               WRITE_ONCE(cur->data[i], (cur->data[i] & cur_used[i])
> > | (target->data[i] & ~cur_used[i]));
> > +       }
> > +       arm_smmu_sync_ste_for_sid(smmu, sid);
>
> Yes, I wanted to avoid all the syncs if they are not required.

Should be easy enough to optimize away in this alternate version as well.

>
> > +       /*
> > +        * It should now be possible to make a single qword write to ma=
ke the
> > +        * the new configuration take effect.
> > +        */
> > +       for (i =3D 0; i !=3D ARRAY_SIZE(cur->data); i++) {
> > +               if ((cur->data[i] & target_used[i]) !=3D
> > (target->data[i] & target_used[i]))
> > +                       /*
> > +                        * TODO:
> > +                        * WARN_ONCE if this condition hits more than o=
nce in
> > +                        * the loop
> > +                        */
> > +                       WRITE_ONCE(cur->data[i], (cur->data[i] &
> > cur_used[i]) | (target->data[i] & ~cur_used[i]));
> > +       }
>
> > +       arm_smmu_sync_ste_for_sid(smmu, sid);
>
> This needs to be optional too
>
> And there is another optional 4th pass to set the unused target values
> to 0.
>
> Basically you have captured the core algorithm, but I think if you
> fill in all the missing bits to get up to the same functionality it
> will be longer and unsharable with the CD side.
>
> You could perhaps take this approach and split it into 4 sharable step
> functions:
>
>  if (step1(target, target_used, cur_used, cur_used, len)) {
>   arm_smmu_sync_ste_for_sid(smmu, sid);
>   arm_smmu_get_ste_used(cur, &cur_used);
>  }
>
>  if (step2(target, target_used, cur_used, cur_used, len))
>   arm_smmu_sync_ste_for_sid(smmu, sid);
>
>  if (step3(target, target_used, cur_used, cur_used, len)) {
>    arm_smmu_sync_ste_for_sid(smmu, sid);
>    arm_smmu_get_ste_used(cur, &cur_used);
>   }
>
>  if (step4(target, target_used, cur_used, cur_used, len))
>    arm_smmu_sync_ste_for_sid(smmu, sid);
>
> To me this is inelegant as if we only need to do step 3 we have to
> redundantly scan the array 2 times. The rolled up version just
> directly goes to step 3.
>
> However this does convince me you've thought very carefully about this
> and have not found a flaw in the design!

Right, it's more of a style/readability question so I'll leave it to
others to chime in further if needed :) .
