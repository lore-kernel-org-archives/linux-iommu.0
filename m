Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE2511717
	for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Wl6YHIf"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-419b53acc11so199331cf.0
        for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 03:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697626487; x=1698231287; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Oc0WJGIFXLjq/TjIerQnlY5E8gKdBo8gfj6SU2EkuM=;
        b=0Wl6YHIfn6BNPCSd98hg2CSpamsAvP5Zi/YDjvwWwx+qmdEgOZshi646SaLtuu0SvX
         I5fkq1U1nWlAGNIh+ANT7ZdDzbKCS5KizqXnQwzOsLYKW+R51Ihu/marqk/kfd6fPUSk
         hT2XtQH26mdTxfIVdKRJuHBPKsw9wCvkMAOIfktcGYlZa6700bCsvIFSo4TIDrGzg4dN
         p9B9a/FnTEswJlGRxG58ADamn6MNrKh52n6nQzTcC5A/DPXGv/Te4G5dfKFV6GbGhwMg
         UgNs2XFbeA3e4gupVmBrPk/J/m727hpZx2GMDnaFQmbdWIVfFIF/0baLuV3pUADu5P6O
         nDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697626487; x=1698231287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Oc0WJGIFXLjq/TjIerQnlY5E8gKdBo8gfj6SU2EkuM=;
        b=lMA6dFxFbl9yaIUSjdLZ6jJ5/92+124dy3s6gwVYr22zvgAhrSZC6DGagQ2zSD4bO+
         vrRI3x/Sygvy2OuSaIwKiJDMvniQSGLt47tC0r9AcUWcieQziEw0FF+FDjUAvgoPqMWD
         xgLSjBPFW/zAhq+mA919zM0mFNZRlcWGKKf1cdZfOlX9C+2HHh38k5665TTQu1V2xthE
         BDzQUr/XfjiRzkDotGtnkqqX9adL/zNxMBOX/o4iI15ZwHdpwlXFJgN4riDfjiMnrEBn
         2eFVN4gu+Ilr7cwbcCtKsgZF97yK8tSuLYGgbwZIS8pFgzzFNNAsDOrxolfgzwkY3wMn
         D6ew==
X-Gm-Message-State: AOJu0YzluaoEp6WPBElH3D/Gcxq13VCap3dq/L4QOb8AgL/BwJtbuDVM
	P1J58w/uKKMmmo79YojJTXDhcwAVVf+ivDwif+wQnw==
X-Google-Smtp-Source: AGHT+IGh/rK4RMcT3buHPIBaAJh5QaOK+2oZzZCylEwbFKujsuhY/QAIyXzDloOM/3KeAudcaReYhYGwoAbdQuhWO6k=
X-Received: by 2002:a05:622a:53c6:b0:41c:bd1e:5a4b with SMTP id
 ef6-20020a05622a53c600b0041cbd1e5a4bmr149912qtb.5.1697626487031; Wed, 18 Oct
 2023 03:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com> <4-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <4-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 18 Oct 2023 18:54:10 +0800
Message-ID: <CAKHBV24gTmBTEVGx__mSs9bQ93DLTZ-VDbpE24S87kgXS+nHhw@mail.gmail.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming independent
 of the callers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 8:33=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> As the comment in arm_smmu_write_strtab_ent() explains, this routine has
> been limited to only work correctly in certain scenarios that the caller
> must ensure. Generally the caller must put the STE into ABORT or BYPASS
> before attempting to program it to something else.
>
> The next patches/series are going to start removing some of this logic
> from the callers, and add more complex state combinations than currently.
>
> Thus, consolidate all the complexity here. Callers do not have to care
> about what STE transition they are doing, this function will handle
> everything optimally.
>
> Revise arm_smmu_write_strtab_ent() so it algorithmically computes the
> required programming sequence to avoid creating an incoherent 'torn' STE
> in the HW caches. The update algorithm follows the same design that the
> driver already uses: it is safe to change bits that HW doesn't currently
> use and then do a single 64 bit update, with sync's in between.
>
> The basic idea is to express in a bitmask what bits the HW is actually
> using based on the V and CFG bits. Based on that mask we know what STE
> changes are safe and which are disruptive. We can count how many 64 bit
> QWORDS need a disruptive update and know if a step with V=3D0 is required=
.
>
> This gives two basic flows through the algorithm.
>
> If only a single 64 bit quantity needs disruptive replacement:
>  - Write the target value into all currently unused bits
>  - Write the single 64 bit quantity
>  - Zero the remaining different bits
>
> If multiple 64 bit quantities need disruptive replacement then do:
>  - Write V=3D0 to QWORD 0
>  - Write the entire STE except QWORD 0
>  - Write QWORD 0
>
> With HW flushes at each step, that can be skipped if the STE didn't chang=
e
> in that step.
>
> At this point it generates the same sequence of updates as the current
> code, except that zeroing the VMID on entry to BYPASS/ABORT will do an
> extra sync (this seems to be an existing bug).
>
> Going forward this will use a V=3D0 transition instead of cycling through
> ABORT if a hitfull change is required. This seems more appropriate as ABO=
RT
> will fail DMAs without any logging, but dropping a DMA due to transient
> V=3D0 is probably signaling a bug, so the C_BAD_STE is valuable.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 247 +++++++++++++++-----
>  1 file changed, 183 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index bf7218adbc2822..6e6b1ebb5ac0ef 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -971,6 +971,69 @@ void arm_smmu_tlb_inv_asid(struct arm_smmu_device *s=
mmu, u16 asid)
>         arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
>  }
>
> +/*
> + * Do one step along the coherent update algorithm. Each step either cha=
nges
> + * only bits that the HW isn't using or entirely changes 1 qword. It may=
 take
> + * several iterations of this routine to make the full change.
> + */
> +static bool arm_smmu_write_entry_step(__le64 *cur, const __le64 *cur_use=
d,
> +                                     const __le64 *target,
> +                                     const __le64 *target_used, __le64 *=
step,
> +                                     __le64 v_bit,
> +                                     unsigned int len)
> +{
> +       u8 step_used_diff =3D 0;
> +       u8 step_change =3D 0;
> +       unsigned int i;
> +
> +       /*
> +        * Compute a step that has all the bits currently unused by HW se=
t to
> +        * their target values.
> +        */
> +       for (i =3D 0; i !=3D len; i++) {
> +               step[i] =3D (cur[i] & cur_used[i]) | (target[i] & ~cur_us=
ed[i]);
> +               if (cur[i] !=3D step[i])
> +                       step_change |=3D 1 << i;
> +               /*
> +                * Each bit indicates if the step is incorrect compared t=
o the
> +                * target, considering only the used bits in the target
> +                */
> +               if ((step[i] & target_used[i]) !=3D (target[i] & target_u=
sed[i]))
> +                       step_used_diff |=3D 1 << i;
> +       }
> +
> +       if (hweight8(step_used_diff) > 1) {
> +               /*
> +                * More than 1 qword is mismatched, this cannot be done w=
ithout
> +                * a break. Clear the V bit and go again.
> +                */
> +               step[0] &=3D ~v_bit;
> +       } else if (!step_change && step_used_diff) {
> +               /*
> +                * Have exactly one critical qword, all the other qwords =
are set
> +                * correctly, so we can set this qword now.
> +                */
> +               i =3D ffs(step_used_diff) - 1;
> +               step[i] =3D target[i];
> +       } else if (!step_change) {
> +               /* cur =3D=3D target, so all done */
> +               if (memcmp(cur, target, sizeof(*cur)) =3D=3D 0)
> +                       return true;
Shouldn't this be len * sizeof(*cur)?

> +
> +               /*
> +                * All the used HW bits match, but unused bits are differ=
ent.
> +                * Set them as well. Technically this isn't necessary but=
 it
> +                * brings the entry to the full target state, so if there=
 are
> +                * bugs in the mask calculation this will obscure them.
> +                */
> +               memcpy(step, target, len * sizeof(*step));
> +       }
> +
> +       for (i =3D 0; i !=3D len; i++)
> +               WRITE_ONCE(cur[i], step[i]);
> +       return false;
> +}
> +
>  static void arm_smmu_sync_cd(struct arm_smmu_master *master,
>                              int ssid, bool leaf)
>  {
> @@ -1248,37 +1311,122 @@ static void arm_smmu_sync_ste_for_sid(struct arm=
_smmu_device *smmu, u32 sid)
>         arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
>  }
>
> +/*
> + * Based on the value of ent report which bits of the STE the HW will ac=
cess. It
> + * would be nice if this was complete according to the spec, but minimal=
ly it
> + * has to capture the bits this driver uses.
> + */
> +static void arm_smmu_get_ste_used(const struct arm_smmu_ste *ent,
> +                                 struct arm_smmu_ste *used_bits)
> +{
> +       memset(used_bits, 0, sizeof(*used_bits));
> +
> +       used_bits->data[0] =3D cpu_to_le64(STRTAB_STE_0_V);
> +       if (!(ent->data[0] & cpu_to_le64(STRTAB_STE_0_V)))
> +               return;
> +
> +       used_bits->data[0] |=3D cpu_to_le64(STRTAB_STE_0_CFG);
> +       switch (FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(ent->data[0]))) {
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
> +
> +               if (FIELD_GET(STRTAB_STE_1_S1DSS, le64_to_cpu(ent->data[1=
])) =3D=3D
> +                   STRTAB_STE_1_S1DSS_BYPASS)
> +                       used_bits->data[1] |=3D cpu_to_le64(STRTAB_STE_1_=
SHCFG);

Although the driver only explicitly sets SHCFG for bypass streams, my
reading of the spec is it is also accessed for S1 and S2 STEs:
"The SMMU might convey attributes input from a device through this
process, so that the device might influence the final transaction
access, and input attributes might be overridden on a per-device basis
using the MTCFG/MemAttr, SHCFG, ALLOCCFG STE fields. The input
attribute, modified by these fields, is primarily useful for setting
the resulting output access attribute when both stage 1 and stage 2
translation is bypassed (no translation table descriptors to determine
attribute) but can also be useful for stage 2-only configurations in
which a device stream might have finer knowledge about the required
access behavior than the general virtual machine-global stage 2
translation tables."

> +               break;
> +       case STRTAB_STE_0_CFG_S2_TRANS:
> +               used_bits->data[1] |=3D cpu_to_le64(STRTAB_STE_1_EATS);
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

Can we consider a WARN here since this driver only ever uses one of
the above 4 values and we probably have a programming error if we see
something else.

> +       }
> +}
> +
> +static bool arm_smmu_write_ste_step(struct arm_smmu_ste *cur,
> +                                   const struct arm_smmu_ste *target,
> +                                   const struct arm_smmu_ste *target_use=
d)
> +{
> +       struct arm_smmu_ste cur_used;
> +       struct arm_smmu_ste step;
> +
> +       arm_smmu_get_ste_used(cur, &cur_used);
> +       return arm_smmu_write_entry_step(cur->data, cur_used.data, target=
->data,
> +                                        target_used->data, step.data,

What's up with requiring callers to allocate and provide step.data if
it's not used by any of the arm_smmu_write_entry_step callers?

> +                                        cpu_to_le64(STRTAB_STE_0_V),
This also looks a bit strange at this stage since CD entries aren't
yet supported..... but sure.

> +                                        ARRAY_SIZE(cur->data));
> +}
> +
> +/*
> + * This algorithm updates any STE to any value without creating a situat=
ion
> + * where the HW can percieve a corrupted STE. HW is only required to hav=
e a 64
> + * bit atomicity with stores.
> + *
> + * In the most general case we can make any update by disrupting the STE=
 (making
> + * it abort, or clearing the V bit) using a single qword store. Then all=
 the
> + * other qwords can be written safely, and finally the full STE written.
> + *
> + * However this disrupts the HW while it is happening. There are several
> + * interesting cases where a STE can be updated without disturbing the H=
W
> + * because only a small number of bits are changing (S1DSS, CONFIG, etc)=
 or
> + * because the used bits don't intersect.
> + */
> +static void arm_smmu_write_ste(struct arm_smmu_device *smmu, u32 sid,
> +                              struct arm_smmu_ste *ste,
> +                              const struct arm_smmu_ste *target)
> +{
> +       struct arm_smmu_ste target_used;
> +       int i;
> +
> +       arm_smmu_get_ste_used(target, &target_used);
> +       /* Masks in arm_smmu_get_ste_used() are up to date */
> +       for (i =3D 0; i !=3D ARRAY_SIZE(target->data); i++)
> +               WARN_ON_ONCE(target->data[i] & ~target_used.data[i]);
> +
> +       while (true) {
> +               if (arm_smmu_write_ste_step(ste, target, &target_used))
> +                       break;
> +               arm_smmu_sync_ste_for_sid(smmu, sid);
> +       }
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
> @@ -1293,22 +1441,6 @@ static void arm_smmu_write_strtab_ent(struct arm_s=
mmu_master *master, u32 sid,
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
> @@ -1319,16 +1451,11 @@ static void arm_smmu_write_strtab_ent(struct arm_=
smmu_master *master, u32 sid,
>                 else
>                         val |=3D FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_=
0_CFG_BYPASS);
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
> @@ -1336,8 +1463,7 @@ static void arm_smmu_write_strtab_ent(struct arm_sm=
mu_master *master, u32 sid,
>                 u64 strw =3D smmu->features & ARM_SMMU_FEAT_E2H ?
>                         STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1;
>
> -               BUG_ON(ste_live);
> -               dst->data[1] =3D cpu_to_le64(
> +               target.data[1] =3D cpu_to_le64(
>                          FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DS=
S_SSID0) |
>                          FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_=
CACHE_WBRA) |
>                          FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_=
CACHE_WBRA) |
> @@ -1346,7 +1472,7 @@ static void arm_smmu_write_strtab_ent(struct arm_sm=
mu_master *master, u32 sid,
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
>                         FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_=
TRANS) |
> @@ -1355,8 +1481,7 @@ static void arm_smmu_write_strtab_ent(struct arm_sm=
mu_master *master, u32 sid,
>         }
>
>         if (s2_cfg) {
> -               BUG_ON(ste_live);
> -               dst->data[2] =3D cpu_to_le64(
> +               target.data[2] =3D cpu_to_le64(
>                          FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
>                          FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
>  #ifdef __BIG_ENDIAN
> @@ -1365,23 +1490,17 @@ static void arm_smmu_write_strtab_ent(struct arm_=
smmu_master *master, u32 sid,
>                          STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2AA64 |
>                          STRTAB_STE_2_S2R);
>
> -               dst->data[3] =3D cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3=
_S2TTB_MASK);
> +               target.data[3] =3D cpu_to_le64(s2_cfg->vttbr & STRTAB_STE=
_3_S2TTB_MASK);
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
> --
> 2.42.0
>
