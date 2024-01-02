Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C8C2101
	for <iommu@lists.linux.dev>; Tue,  2 Jan 2024 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Un0hiYiU"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4279c2ada00so2300441cf.1
        for <iommu@lists.linux.dev>; Tue, 02 Jan 2024 00:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704183245; x=1704788045; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJY1pMpIA6osHg97pt/HR7yHcVNBlxgoz8MlIWBIuik=;
        b=Un0hiYiUpTZzzC6/jgy1SXh16HO1yOmy+kmicDbyyFvqugyA+nkWauJuZLNnSs8+ta
         ZS7GDNkyhOS/iiAxaF+l/j+fJWMNPv7EG7JtdiJY1SSV1OBUt5UMyvMdtQ3L0Y3l08ES
         S7idatV+RRX/fLznhsDzambeBy9tkc5+qctIjiAB17YVQHLOtHU34bGq1F+Tnp1o6Ktp
         L/ovVSkYVITY9uGZgqQq3dj9u5QxluUpjuS+BfrbX0eWEosQ8dfHV32cTK3rA2dykbSA
         cY0uOtBbyVyeEol1YAauuaAIwCOr2HDo/yDLX5CEYdcJhZ06w8j6IFL6a6GoKLBwGSOI
         syuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704183245; x=1704788045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJY1pMpIA6osHg97pt/HR7yHcVNBlxgoz8MlIWBIuik=;
        b=b1Y/GRgXEWc1jEYQdP4S8qM9HGjaxZ03IcajhfXRoxdc0TqnzUGQMGZdP/CNKEaTy/
         7hOEJxXELvzD2bc+8Pn+bJplLxGpPo/HU7v3lpO1k2pQ8OqO0MZGybEDabYZHzDhJUPR
         6p9p7TgK7W0Dsv6MuU579dQ5bPDJzEjJ0Yjq0b2KTd3XusUXEYnW/WpjwmOXi+eMn0Rp
         f+rzw19uB6VF8bz+NndtYFUDDt1Yk4L/zXh0XBLESLottMAwIkveiw5DWkWrZVylMSEC
         oX/4lAMl+JvYqFmBvVWAAd+gDchhZWKpKWPIcqMjMgW2SK0qMSP+1ZTqvsmiOi2PVvOb
         JL9A==
X-Gm-Message-State: AOJu0YyRG0zqDmttqhc6llPTZtVLlLUZeKXQO0XKIOOKJHPalrkMjGe9
	V1+2bOgQV8EjGzuFW+dHvjHhvPQIaqKFR1OxFvGoTVMw+dfV
X-Google-Smtp-Source: AGHT+IFPq+1qnLaN2bHDSJTZWHZiNFtCTiqfw+TlI0f5Nfz8rM+lhqnX/gEiTGymCCUc7a0dv1FyZXoxlJxnBJJE0Cs=
X-Received: by 2002:ac8:58c4:0:b0:427:e905:3b50 with SMTP id
 u4-20020ac858c4000000b00427e9053b50mr977234qta.6.1704183244983; Tue, 02 Jan
 2024 00:14:04 -0800 (PST)
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
 <20231020113918.GD3952@nvidia.com> <CAKHBV274M-DDD+vJgO-k9s4MF=FLhKajPdphfBVofjyOS3vHbA@mail.gmail.com>
 <CAKHBV24nfdq1q76T+DRQGNYeA-kP7ONnSjDsRFGsQCJVSrSm0w@mail.gmail.com>
 <ZX7xu8jN/rBZ4A/d@nvidia.com> <CAKHBV26CRC8eWMuOk6EZYMHOZoR2FauP=NBazzOiWCmQYEa1vg@mail.gmail.com>
 <CAKHBV27qsgjgwPfn8OpSq30z1w203NDqBZ0s66bPgjp1XDnLOg@mail.gmail.com>
In-Reply-To: <CAKHBV27qsgjgwPfn8OpSq30z1w203NDqBZ0s66bPgjp1XDnLOg@mail.gmail.com>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 2 Jan 2024 16:13:28 +0800
Message-ID: <CAKHBV275ELiNtZqdmqzWTJ7AHOuCigzPFAXAcG5xPwonhgYXvA@mail.gmail.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming independent
 of the callers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 9:42=E2=80=AFPM Michael Shavit <mshavit@google.com>=
 wrote:
...
> +       if (hweight8(entry_qwords_used_diff) > 1) {
> +               /*
> +                * If transitioning to the target entry with a single qwo=
rd
> +                * write isn't possible, then we must first transition to=
 an
> +                * intermediate entry. The intermediate entry may either =
be an
> +                * entry that melds bits of the target entry into the cur=
rent
> +                * entry without disrupting the hardware, or a breaking e=
ntry if
> +                * a hitless transition to the target is impossible.
> +                */
> +
> +               /*
> +                * Compute a staging entry that has all the bits currentl=
y
> +                * unused by HW set to their target values, such that com=
itting
> +                * it to the entry table woudn't disrupt the hardware.
> +                */
> +               memcpy(staging_entry, cur, writer->entry_length);
> +               writer->ops.set_unused_bits(staging_entry, target);
> +
> +               entry_qwords_used_diff =3D
> +                       writer->ops.get_used_qword_diff_indexes(staging_e=
ntry,
> +                                                               target);
> +               if (hweight8(entry_qwords_used_diff) > 1) {
> +                       /*
> +                        * More than 1 qword is mismatched between the st=
aging
> +                        * and target entry. A hitless transition to the =
target
> +                        * entry is not possible. Set the staging entry t=
o be
> +                        * equal to the target entry, apart from the V bi=
t's
> +                        * qword. As long as the V bit is cleared first t=
hen
> +                        * writes to the subsequent qwords will not furth=
er
> +                        * disrupt the hardware.
> +                        */
> +                       memcpy(staging_entry, target, writer->entry_lengt=
h);
> +                       staging_entry[0] &=3D ~writer->v_bit;
> +                       /*
> +                        * After comitting the staging entry, only the 0t=
h qword
> +                        * will differ from the target.
> +                        */
> +                       entry_qwords_used_diff =3D 1;
> +               }
> +
> +               /*
> +                * Commit the staging entry. Note that the iteration orde=
r
> +                * matters, as we may be comitting a breaking entry in th=
e
> +                * non-hitless case. The 0th qword which holds the valid =
bit
> +                * must be written first in that case.
> +                */
> +               for (i =3D 0; i !=3D writer->entry_length; i++)
> +                       WRITE_ONCE(cur[i], staging_entry[i]);
> +               writer->ops.sync_entry(writer);

Realized while replying to your latest email that this is wrong (and
the unit-test as well!). It's not enough to just write the 0th qword
first if it's a breaking entry, it must also sync after that 0th qword
write.

On Tue, Dec 19, 2023 at 9:42=E2=80=AFPM Michael Shavit <mshavit@google.com>=
 wrote:
>
> On Mon, Dec 18, 2023 at 8:35=E2=80=AFPM Michael Shavit <mshavit@google.co=
m> wrote:
> >
> > On Sun, Dec 17, 2023 at 9:03=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com=
> wrote:
> > >
> > > On Sat, Dec 16, 2023 at 04:26:48AM +0800, Michael Shavit wrote:
> > >
> > > > Ok, I took a proper stab at trying to unroll the loop on the github
> > > > version of this patch (v3+)
> > > > As you suspected, it's not easy to re-use the unrolled version for
> > > > both STE and CD writing as we'd have to pass in callbacks for synci=
ng
> > > > the STE/CD and recomputing arm_smmu_{get_ste/cd}_used.
> > >
> > > Yes, that is why I structured it as an iterator
> >
> > On second thought, perhaps defining a helper class implementing
> > entry_sync() and entry_get_used_bits() might not be so bad?
> > It's a little bit more verbose, but avoids deduplication of the
> > complicated parts.
>
> Gave this a try so that we have something more concrete to compare.
> Consider the following two patches as alternatives to this patch and
> patch "Make CD programming use arm_smmu_write_entry_step" from the
> next part of the patch series.
>
> STE programming patch
> ---
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index b120d83668...1e17bff37f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -971,6 +971,174 @@
>         arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
>  }
>
> +struct arm_smmu_entry_writer;
> +
> +/**
> + * struct arm_smmu_entry_writer_ops - Helper class for writing a CD/STE =
entry.
> + * @sync_entry: sync entry to the hardware after writing to it.
> + * @set_unused_bits: Make bits of the entry that aren't in use by the ha=
rdware
> + *                   equal to the target's bits.
> + * @get_used_qword_diff_indexes: Compute the list of qwords in the entry=
 that
> + *                               are incorrect compared to the target,
> + *                               considering only the used bits in the t=
arget.
> + *                               The set bits in the return value
> represents the
> + *                               indexes of those qwords.
> + */
> +struct arm_smmu_entry_writer_ops {
> +       void (*sync_entry)(struct arm_smmu_entry_writer *);
> +       void (*set_unused_bits)(__le64 *entry, const __le64 *target);
> +       u8 (*get_used_qword_diff_indexes)(__le64 *entry, const __le64 *ta=
rget);
> +};
> +
> +struct arm_smmu_entry_writer {
> +       struct arm_smmu_entry_writer_ops ops;
> +       __le64 v_bit;
> +       unsigned int entry_length;
> +};
> +
> +static void arm_smmu_entry_set_unused_bits(__le64 *entry, const __le64 *=
target,
> +                                          const __le64 *entry_used,
> +                                          unsigned int length)
> +{
> +       int i =3D 0;
> +
> +       for (i =3D 0; i < length; i++)
> +               entry[i] =3D (entry[i] & entry_used[i]) |
> +                          (target[i] & ~entry_used[i]);
> +}
> +
> +static u8 arm_smmu_entry_used_qword_diff_indexes(__le64 *entry,
> +                                                const __le64 *target,
> +                                                const __le64 *target_use=
d,
> +                                                unsigned int length)
> +{
> +       u8 qword_diff_indexes =3D 0;
> +       int i =3D 0;
> +
> +       for (i =3D 0; i < length; i++) {
> +               if ((entry[i] & target_used[i]) !=3D (target[i] & target_=
used[i]))
> +                       qword_diff_indexes |=3D 1 << i;
> +       }
> +       return qword_diff_indexes;
> +}
> +
> +/*
> + * Update the STE/CD to the target configuration. The transition from
> the current
> + * entry to the target entry takes place over multiple steps that
> attempts to make
> + * the transition hitless if possible. This function takes care not to c=
reate a
> + * situation where the HW can perceive a corrupted entry. HW is only
> required to
> + * have a 64 bit atomicity with stores from the CPU, while entries are m=
any 64
> + * bit values big.
> + *
> + * The algorithm works by evolving the entry toward the target in a seri=
es of
> + * steps. Each step synchronizes with the HW so that the HW can not
> see an entry
> + * torn across two steps. During each step the HW can observe a torn ent=
ry that
> + * has any combination of the step's old/new 64 bit words. The algorithm
> + * objective is for the HW behavior to always be one of current behavior=
, V=3D0,
> + * or new behavior.
> + *
> + * In the most general case we can make any update in three steps:
> + *  - Disrupting the entry (V=3D0)
> + *  - Fill now unused bits, all bits except V
> + *  - Make valid (V=3D1), single 64 bit store
> + *
> + * However this disrupts the HW while it is happening. There are several
> + * interesting cases where a STE/CD can be updated without disturbing th=
e HW
> + * because only a small number of bits are changing (S1DSS, CONFIG, etc)=
 or
> + * because the used bits don't intersect. We can detect this by calculat=
ing how
> + * many 64 bit values need update after adjusting the unused bits and sk=
ip the
> + * V=3D0 process. This relies on the IGNORED behavior described in the
> + * specification
> + */
> +static void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer,
> +                                __le64 *cur, const __le64 *target,
> +                                __le64 *staging_entry)
> +{
> +       bool cleanup_sync_required =3D false;
> +       u8 entry_qwords_used_diff =3D 0;
> +       int i =3D 0;
> +
> +       entry_qwords_used_diff =3D
> +               writer->ops.get_used_qword_diff_indexes(cur, target);
> +       if (WARN_ON_ONCE(entry_qwords_used_diff =3D=3D 0))
> +               return;
> +
> +       if (hweight8(entry_qwords_used_diff) > 1) {
> +               /*
> +                * If transitioning to the target entry with a single qwo=
rd
> +                * write isn't possible, then we must first transition to=
 an
> +                * intermediate entry. The intermediate entry may either =
be an
> +                * entry that melds bits of the target entry into the cur=
rent
> +                * entry without disrupting the hardware, or a breaking e=
ntry if
> +                * a hitless transition to the target is impossible.
> +                */
> +
> +               /*
> +                * Compute a staging entry that has all the bits currentl=
y
> +                * unused by HW set to their target values, such that com=
itting
> +                * it to the entry table woudn't disrupt the hardware.
> +                */
> +               memcpy(staging_entry, cur, writer->entry_length);
> +               writer->ops.set_unused_bits(staging_entry, target);
> +
> +               entry_qwords_used_diff =3D
> +                       writer->ops.get_used_qword_diff_indexes(staging_e=
ntry,
> +                                                               target);
> +               if (hweight8(entry_qwords_used_diff) > 1) {
> +                       /*
> +                        * More than 1 qword is mismatched between the st=
aging
> +                        * and target entry. A hitless transition to the =
target
> +                        * entry is not possible. Set the staging entry t=
o be
> +                        * equal to the target entry, apart from the V bi=
t's
> +                        * qword. As long as the V bit is cleared first t=
hen
> +                        * writes to the subsequent qwords will not furth=
er
> +                        * disrupt the hardware.
> +                        */
> +                       memcpy(staging_entry, target, writer->entry_lengt=
h);
> +                       staging_entry[0] &=3D ~writer->v_bit;
> +                       /*
> +                        * After comitting the staging entry, only the 0t=
h qword
> +                        * will differ from the target.
> +                        */
> +                       entry_qwords_used_diff =3D 1;
> +               }
> +
> +               /*
> +                * Commit the staging entry. Note that the iteration orde=
r
> +                * matters, as we may be comitting a breaking entry in th=
e
> +                * non-hitless case. The 0th qword which holds the valid =
bit
> +                * must be written first in that case.
> +                */
> +               for (i =3D 0; i !=3D writer->entry_length; i++)
> +                       WRITE_ONCE(cur[i], staging_entry[i]);
> +               writer->ops.sync_entry(writer);
> +       }
> +
> +       /*
> +        * It's now possible to switch to the target configuration with a=
 write
> +        * to a single qword. Make that switch now.
> +        */
> +       i =3D ffs(entry_qwords_used_diff) - 1;
> +       WRITE_ONCE(cur[i], target[i]);
> +       writer->ops.sync_entry(writer);
> +
> +       /*
> +        * Some of the bits set under the previous configuration but unus=
ed
> +        * under the target configuration might still be set. Clear them =
as
> +        * well. Technically this isn't necessary but it brings the entry=
 to
> +        * the full target state, so if there are bugs in the mask calcul=
ation
> +        * this will obscure them.
> +        */
> +       for (i =3D 0; i !=3D writer->entry_length; i++) {
> +               if (cur[i] !=3D target[i]) {
> +                       WRITE_ONCE(cur[i], target[i]);
> +                       cleanup_sync_required =3D true;
> +               }
> +       }
> +       if (cleanup_sync_required)
> +               writer->ops.sync_entry(writer);
> +}
> +
>  static void arm_smmu_sync_cd(struct arm_smmu_master *master,
>                              int ssid, bool leaf)
>  {
> @@ -1248,37 +1416,142 @@
>         arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
>  }
>
> +/*
> + * Based on the value of ent report which bits of the STE the HW will
> access. It
> + * would be nice if this was complete according to the spec, but minimal=
ly it
> + * has to capture the bits this driver uses.
> + */
> +static void arm_smmu_get_ste_used(const __le64 *ent,
> +                                 struct arm_smmu_ste *used_bits)
> +{
> +       memset(used_bits, 0, sizeof(*used_bits));
> +
> +       used_bits->data[0] =3D cpu_to_le64(STRTAB_STE_0_V);
> +       if (!(ent[0] & cpu_to_le64(STRTAB_STE_0_V)))
> +               return;
> +
> +       /*
> +        * If S1 is enabled S1DSS is valid, see 13.5 Summary of
> +        * attribute/permission configuration fields for the SHCFG behavi=
or.
> +        */
> +       if (FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(ent[0])) & 1 &&
> +           FIELD_GET(STRTAB_STE_1_S1DSS, le64_to_cpu(ent[1])) =3D=3D
> +                   STRTAB_STE_1_S1DSS_BYPASS)
> +               used_bits->data[1] |=3D cpu_to_le64(STRTAB_STE_1_SHCFG);
> +
> +       used_bits->data[0] |=3D cpu_to_le64(STRTAB_STE_0_CFG);
> +       switch (FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(ent[0]))) {
> +       case STRTAB_STE_0_CFG_ABORT:
> +               break;
> +       case STRTAB_STE_0_CFG_BYPASS:
> +               used_bits->data[1] |=3D cpu_to_le64(STRTAB_STE_1_SHCFG);
> +               break;
> +       case STRTAB_STE_0_CFG_S1_TRANS:
> +               used_bits->data[0] |=3D cpu_to_le64(STRTAB_STE_0_S1FMT |
> +                                                 STRTAB_STE_0_S1CTXPTR_M=
ASK |
> +                                                 STRTAB_STE_0_S1CDMAX);
> +               used_bits->data[1] |=3D
> +                       cpu_to_le64(STRTAB_STE_1_S1DSS | STRTAB_STE_1_S1C=
IR |
> +                                   STRTAB_STE_1_S1COR | STRTAB_STE_1_S1C=
SH |
> +                                   STRTAB_STE_1_S1STALLD | STRTAB_STE_1_=
STRW);
> +               used_bits->data[1] |=3D cpu_to_le64(STRTAB_STE_1_EATS);
> +               break;
> +       case STRTAB_STE_0_CFG_S2_TRANS:
> +               used_bits->data[1] |=3D
> +                       cpu_to_le64(STRTAB_STE_1_EATS | STRTAB_STE_1_SHCF=
G);
> +               used_bits->data[2] |=3D
> +                       cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VT=
CR |
> +                                   STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2=
ENDI |
> +                                   STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2R=
);
> +               used_bits->data[3] |=3D cpu_to_le64(STRTAB_STE_3_S2TTB_MA=
SK);
> +               break;
> +
> +       default:
> +               memset(used_bits, 0xFF, sizeof(*used_bits));
> +               WARN_ON(true);
> +       }
> +}
> +
> +struct arm_smmu_ste_writer {
> +       struct arm_smmu_entry_writer writer;
> +       struct arm_smmu_device *smmu;
> +       u32 sid;
> +};
> +
> +static void arm_smmu_ste_set_unused_bits(__le64 *entry, const __le64 *ta=
rget)
> +{
> +       struct arm_smmu_ste entry_used;
> +       arm_smmu_get_ste_used(entry, &entry_used);
> +
> +       arm_smmu_entry_set_unused_bits(entry, target, entry_used.data,
> +                                      ARRAY_SIZE(entry_used.data));
> +}
> +
> +static u8 arm_smmu_ste_used_qword_diff_indexes(__le64 *cur,
> +                                              const __le64 *target)
> +{
> +       struct arm_smmu_ste target_used;
> +
> +       arm_smmu_get_ste_used(target, &target_used);
> +       return arm_smmu_entry_used_qword_diff_indexes(
> +               cur, target, target_used.data, ARRAY_SIZE(target_used.dat=
a));
> +}
> +
> +static void arm_smmu_ste_writer_sync_entry(struct
> arm_smmu_entry_writer *writer)
> +{
> +       struct arm_smmu_ste_writer *ste_writer =3D
> +               container_of(writer, struct arm_smmu_ste_writer, writer);
> +
> +       arm_smmu_sync_ste_for_sid(ste_writer->smmu, ste_writer->sid);
> +}
> +
> +static const struct arm_smmu_entry_writer_ops arm_smmu_ste_writer_ops =
=3D {
> +       .sync_entry =3D arm_smmu_ste_writer_sync_entry,
> +       .set_unused_bits =3D arm_smmu_ste_set_unused_bits,
> +       .get_used_qword_diff_indexes =3D arm_smmu_ste_used_qword_diff_ind=
exes,
> +};
> +
> +static void arm_smmu_write_ste(struct arm_smmu_device *smmu, u32 sid,
> +                              struct arm_smmu_ste *ste,
> +                              const struct arm_smmu_ste *target)
> +{
> +       struct arm_smmu_ste preallocated_staging_ste =3D {0};
> +       struct arm_smmu_ste_writer ste_writer =3D {
> +               .writer =3D {
> +                       .ops =3D arm_smmu_ste_writer_ops,
> +                       .v_bit =3D cpu_to_le64(STRTAB_STE_0_V),
> +                       .entry_length =3D ARRAY_SIZE(ste->data),
> +               },
> +               .smmu =3D smmu,
> +               .sid =3D sid,
> +       };
> +
> +       arm_smmu_write_entry(&ste_writer.writer,
> +                              ste->data,
> +                              target->data,
> +                              preallocated_staging_ste.data);
> +
> +       /* It's likely that we'll want to use the new STE soon */
> +       if (!(smmu->options & ARM_SMMU_OPT_SKIP_PREFETCH)) {
> +               struct arm_smmu_cmdq_ent
> +                       prefetch_cmd =3D { .opcode =3D CMDQ_OP_PREFETCH_C=
FG,
> +                                        .prefetch =3D {
> +                                                .sid =3D sid,
> +                                        } };
> +
> +               arm_smmu_cmdq_issue_cmd(smmu, &prefetch_cmd);
> +       }
> +}
> +
>  static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u3=
2 sid,
>                                       struct arm_smmu_ste *dst)
>  {
> -       /*
> -        * This is hideously complicated, but we only really care about
> -        * three cases at the moment:
> -        *
> -        * 1. Invalid (all zero) -> bypass/fault (init)
> -        * 2. Bypass/fault -> translation/bypass (attach)
> -        * 3. Translation/bypass -> bypass/fault (detach)
> -        *
> -        * Given that we can't update the STE atomically and the SMMU
> -        * doesn't read the thing in a defined order, that leaves us
> -        * with the following maintenance requirements:
> -        *
> -        * 1. Update Config, return (init time STEs aren't live)
> -        * 2. Write everything apart from dword 0, sync, write dword 0, s=
ync
> -        * 3. Update Config, sync
> -        */
> -       u64 val =3D le64_to_cpu(dst->data[0]);
> -       bool ste_live =3D false;
> +       u64 val;
>         struct arm_smmu_device *smmu =3D master->smmu;
>         struct arm_smmu_ctx_desc_cfg *cd_table =3D NULL;
>         struct arm_smmu_s2_cfg *s2_cfg =3D NULL;
>         struct arm_smmu_domain *smmu_domain =3D master->domain;
> -       struct arm_smmu_cmdq_ent prefetch_cmd =3D {
> -               .opcode         =3D CMDQ_OP_PREFETCH_CFG,
> -               .prefetch       =3D {
> -                       .sid    =3D sid,
> -               },
> -       };
> +       struct arm_smmu_ste target =3D {};
>
>         if (smmu_domain) {
>                 switch (smmu_domain->stage) {
> @@ -1293,22 +1566,6 @@
>                 }
>         }
>
> -       if (val & STRTAB_STE_0_V) {
> -               switch (FIELD_GET(STRTAB_STE_0_CFG, val)) {
> -               case STRTAB_STE_0_CFG_BYPASS:
> -                       break;
> -               case STRTAB_STE_0_CFG_S1_TRANS:
> -               case STRTAB_STE_0_CFG_S2_TRANS:
> -                       ste_live =3D true;
> -                       break;
> -               case STRTAB_STE_0_CFG_ABORT:
> -                       BUG_ON(!disable_bypass);
> -                       break;
> -               default:
> -                       BUG(); /* STE corruption */
> -               }
> -       }
> -
>         /* Nuke the existing STE_0 value, as we're going to rewrite it */
>         val =3D STRTAB_STE_0_V;
>
> @@ -1319,16 +1576,11 @@
>                 else
>                         val |=3D FIELD_PREP(STRTAB_STE_0_CFG,
> STRTAB_STE_0_CFG_BYPASS);
>
> -               dst->data[0] =3D cpu_to_le64(val);
> -               dst->data[1] =3D cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCF=
G,
> +               target.data[0] =3D cpu_to_le64(val);
> +               target.data[1] =3D cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SH=
CFG,
>                                                 STRTAB_STE_1_SHCFG_INCOMI=
NG));
> -               dst->data[2] =3D 0; /* Nuke the VMID */
> -               /*
> -                * The SMMU can perform negative caching, so we must sync
> -                * the STE regardless of whether the old value was live.
> -                */
> -               if (smmu)
> -                       arm_smmu_sync_ste_for_sid(smmu, sid);
> +               target.data[2] =3D 0; /* Nuke the VMID */
> +               arm_smmu_write_ste(smmu, sid, dst, &target);
>                 return;
>         }
>
> @@ -1336,8 +1588,7 @@
>                 u64 strw =3D smmu->features & ARM_SMMU_FEAT_E2H ?
>                         STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1;
>
> -               BUG_ON(ste_live);
> -               dst->data[1] =3D cpu_to_le64(
> +               target.data[1] =3D cpu_to_le64(
>                          FIELD_PREP(STRTAB_STE_1_S1DSS,
> STRTAB_STE_1_S1DSS_SSID0) |
>                          FIELD_PREP(STRTAB_STE_1_S1CIR,
> STRTAB_STE_1_S1C_CACHE_WBRA) |
>                          FIELD_PREP(STRTAB_STE_1_S1COR,
> STRTAB_STE_1_S1C_CACHE_WBRA) |
> @@ -1346,7 +1597,7 @@
>
>                 if (smmu->features & ARM_SMMU_FEAT_STALLS &&
>                     !master->stall_enabled)
> -                       dst->data[1] |=3D cpu_to_le64(STRTAB_STE_1_S1STAL=
LD);
> +                       target.data[1] |=3D cpu_to_le64(STRTAB_STE_1_S1ST=
ALLD);
>
>                 val |=3D (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MAS=
K) |
>                         FIELD_PREP(STRTAB_STE_0_CFG,
> STRTAB_STE_0_CFG_S1_TRANS) |
> @@ -1355,8 +1606,7 @@
>         }
>
>         if (s2_cfg) {
> -               BUG_ON(ste_live);
> -               dst->data[2] =3D cpu_to_le64(
> +               target.data[2] =3D cpu_to_le64(
>                          FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
>                          FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
>  #ifdef __BIG_ENDIAN
> @@ -1365,23 +1615,17 @@
>                          STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2AA64 |
>                          STRTAB_STE_2_S2R);
>
> -               dst->data[3] =3D cpu_to_le64(s2_cfg->vttbr &
> STRTAB_STE_3_S2TTB_MASK);
> +               target.data[3] =3D cpu_to_le64(s2_cfg->vttbr &
> STRTAB_STE_3_S2TTB_MASK);
>
>                 val |=3D FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2=
_TRANS);
>         }
>
>         if (master->ats_enabled)
> -               dst->data[1] |=3D cpu_to_le64(FIELD_PREP(STRTAB_STE_1_EAT=
S,
> +               target.data[1] |=3D cpu_to_le64(FIELD_PREP(STRTAB_STE_1_E=
ATS,
>                                                  STRTAB_STE_1_EATS_TRANS)=
);
>
> -       arm_smmu_sync_ste_for_sid(smmu, sid);
> -       /* See comment in arm_smmu_write_ctx_desc() */
> -       WRITE_ONCE(dst->data[0], cpu_to_le64(val));
> -       arm_smmu_sync_ste_for_sid(smmu, sid);
> -
> -       /* It's likely that we'll want to use the new STE soon */
> -       if (!(smmu->options & ARM_SMMU_OPT_SKIP_PREFETCH))
> -               arm_smmu_cmdq_issue_cmd(smmu, &prefetch_cmd);
> +       target.data[0] =3D cpu_to_le64(val);
> +       arm_smmu_write_ste(smmu, sid, dst, &target);
>  }
>
>  static void arm_smmu_init_bypass_stes(struct arm_smmu_ste *strtab,
>
>
>
>
>
> ---
> CD programming
> ---
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 55703a5d62...c849b26c43 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1219,6 +1219,86 @@
>         return &l1_desc->l2ptr[idx];
>  }
>
> +static void arm_smmu_get_cd_used(const __le64 *ent,
> +                                struct arm_smmu_cd *used_bits)
> +{
> +       memset(used_bits, 0, sizeof(*used_bits));
> +
> +       used_bits->data[0] =3D cpu_to_le64(CTXDESC_CD_0_V);
> +       if (!(ent[0] & cpu_to_le64(CTXDESC_CD_0_V)))
> +               return;
> +       memset(used_bits, 0xFF, sizeof(*used_bits));
> +
> +       /* EPD0 means T0SZ/TG0/IR0/OR0/SH0/TTB0 are IGNORED */
> +       if (ent[0] & cpu_to_le64(CTXDESC_CD_0_TCR_EPD0)) {
> +               used_bits->data[0] &=3D ~cpu_to_le64(
> +                       CTXDESC_CD_0_TCR_T0SZ | CTXDESC_CD_0_TCR_TG0 |
> +                       CTXDESC_CD_0_TCR_IRGN0 | CTXDESC_CD_0_TCR_ORGN0 |
> +                       CTXDESC_CD_0_TCR_SH0);
> +               used_bits->data[1] &=3D ~cpu_to_le64(CTXDESC_CD_1_TTB0_MA=
SK);
> +       }
> +}
> +
> +struct arm_smmu_cd_writer {
> +       struct arm_smmu_entry_writer writer;
> +       struct arm_smmu_master *master;
> +       int ssid;
> +};
> +
> +static void arm_smmu_cd_set_unused_bits(__le64 *entry, const __le64 *tar=
get)
> +{
> +       struct arm_smmu_cd entry_used;
> +       arm_smmu_get_cd_used(entry, &entry_used);
> +
> +       arm_smmu_entry_set_unused_bits(entry, target, entry_used.data,
> +                                      ARRAY_SIZE(entry_used.data));
> +}
> +
> +static u8 arm_smmu_cd_used_qword_diff_indexes(__le64 *cur,
> +                                              const __le64 *target)
> +{
> +       struct arm_smmu_cd target_used;
> +
> +       arm_smmu_get_cd_used(target, &target_used);
> +       return arm_smmu_entry_used_qword_diff_indexes(
> +               cur, target, target_used.data, ARRAY_SIZE(target_used.dat=
a));
> +}
> +
> +static void arm_smmu_cd_writer_sync_entry(struct arm_smmu_entry_writer *=
writer)
> +{
> +       struct arm_smmu_cd_writer *cd_writer =3D
> +               container_of(writer, struct arm_smmu_cd_writer, writer);
> +
> +       arm_smmu_sync_cd(cd_writer->master, cd_writer->ssid, true);
> +}
> +
> +static const struct arm_smmu_entry_writer_ops arm_smmu_cd_writer_ops =3D=
 {
> +       .sync_entry =3D arm_smmu_cd_writer_sync_entry,
> +       .set_unused_bits =3D arm_smmu_cd_set_unused_bits,
> +       .get_used_qword_diff_indexes =3D arm_smmu_cd_used_qword_diff_inde=
xes,
> +};
> +
> +static void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int =
ssid,
> +                                   struct arm_smmu_cd *cdptr,
> +                                   const struct arm_smmu_cd *target)
> +{
> +       struct arm_smmu_cd preallocated_staging_cd =3D {0};
> +       struct arm_smmu_cd_writer cd_writer =3D {
> +               .writer =3D {
> +                       .ops =3D arm_smmu_cd_writer_ops,
> +                       .v_bit =3D cpu_to_le64(CTXDESC_CD_0_V),
> +                       .entry_length =3D ARRAY_SIZE(cdptr->data),
> +               },
> +               .master =3D master,
> +               .ssid =3D ssid,
> +       };
> +
> +       arm_smmu_write_entry(&cd_writer.writer,
> +                              cdptr->data,
> +                              target->data,
> +                              preallocated_staging_cd.data);
> +}
> +
>  int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
>                             struct arm_smmu_ctx_desc *cd)
>  {
> @@ -1235,16 +1315,19 @@
>          */
>         u64 val;
>         bool cd_live;
> -       struct arm_smmu_cd *cdptr;
> +       struct arm_smmu_cd target;
> +       struct arm_smmu_cd *cdptr =3D &target;
> +       struct arm_smmu_cd *cd_table_entry;
>         struct arm_smmu_ctx_desc_cfg *cd_table =3D &master->cd_table;
>
>         if (WARN_ON(ssid >=3D (1 << cd_table->s1cdmax)))
>                 return -E2BIG;
>
> -       cdptr =3D arm_smmu_get_cd_ptr(master, ssid);
> -       if (!cdptr)
> +       cd_table_entry =3D arm_smmu_get_cd_ptr(master, ssid);
> +       if (!cd_table_entry)
>                 return -ENOMEM;
>
> +       target =3D *cd_table_entry;
>         val =3D le64_to_cpu(cdptr->data[0]);
>         cd_live =3D !!(val & CTXDESC_CD_0_V);
>
> @@ -1264,13 +1347,6 @@
>                 cdptr->data[2] =3D 0;
>                 cdptr->data[3] =3D cpu_to_le64(cd->mair);
>
> -               /*
> -                * STE may be live, and the SMMU might read dwords of
> this CD in any
> -                * order. Ensure that it observes valid values before rea=
ding
> -                * V=3D1.
> -                */
> -               arm_smmu_sync_cd(master, ssid, true);
> -
>                 val =3D cd->tcr |
>  #ifdef __BIG_ENDIAN
>                         CTXDESC_CD_0_ENDI |
> @@ -1284,18 +1360,8 @@
>                 if (cd_table->stall_enabled)
>                         val |=3D CTXDESC_CD_0_S;
>         }
> -
> -       /*
> -        * The SMMU accesses 64-bit values atomically. See IHI0070Ca 3.21=
.3
> -        * "Configuration structures and configuration invalidation compl=
etion"
> -        *
> -        *   The size of single-copy atomic reads made by the SMMU is
> -        *   IMPLEMENTATION DEFINED but must be at least 64 bits. Any sin=
gle
> -        *   field within an aligned 64-bit span of a structure can be al=
tered
> -        *   without first making the structure invalid.
> -        */
> -       WRITE_ONCE(cdptr->data[0], cpu_to_le64(val));
> -       arm_smmu_sync_cd(master, ssid, true);
> +       cdptr->data[0] =3D cpu_to_le64(val);
> +       arm_smmu_write_cd_entry(master, ssid, cd_table_entry, &target);
>         return 0;
>  }
