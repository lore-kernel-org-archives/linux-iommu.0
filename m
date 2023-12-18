Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239587EFA3
	for <iommu@lists.linux.dev>; Mon, 18 Dec 2023 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q8YofEIS"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4258b6df295so556551cf.0
        for <iommu@lists.linux.dev>; Mon, 18 Dec 2023 04:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702903357; x=1703508157; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0wL9TetfutJNBqgcZ0QaRxtUPMKJQeXJe3rZ9zKgbQ=;
        b=q8YofEISxDXGyJlE/umfbDs3ZpBrIqvNuy2TnNk1UMyzDcP6Wop3PaqciHPMKcA1qL
         eICI8d96Ci3Sx7B/QQESEmIYmmhQqLu7KI//e4igUogizYF8D77hX4UUEwQCSL2aFG8w
         Lr/rYOGHwGKObgy5V7aIL6/10i1de0/TlrjG+KcCRI2NwK1Dq09atHGSd1p++uq5blIc
         xgk+RkWcub+ku7KNWjx6mQ7IqB/vBCQAXZT6+M/UNUqbjd1KweQXZFZ5MzpJRpZWGbbr
         q+fNWbpfkhXVa6I1zyT/uGZit6zo6x07ICkNTYw8UsBm4bmpcCI1a+tcrQt3oKLESAyK
         zPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702903357; x=1703508157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0wL9TetfutJNBqgcZ0QaRxtUPMKJQeXJe3rZ9zKgbQ=;
        b=JCqiqykvuwpSmsbJxxdpDy+5VrudjT36WVxFTyftxMa4ac1YSTWKmxhnwsTrK4YF0h
         y1Prt6eIbjzeL225tme0LBMf6sv3ZKUtsx564zIeVX8CcYp+HCvhcMOrCl+RJdLcfZ36
         EVU6KNQB5vybIrNB0cyV/WT9W7xUgWWR5zKS8xI2zffl/5Ksqq85eftCRFYwKCT1gIoI
         7Eql6wBoG+AYmOvQqwOeeOG2OOnblZdG07nJlgpP78d2M8aZqDoeyypBuQKsVPsVRMdn
         PhHG0SFDNfgarBoNO9d6JS6iRoDTAW90ws/EGnOShhUiNU0xs9v9wtWZP0DVNHn9AICG
         g1jw==
X-Gm-Message-State: AOJu0YyhPEjs84wFRoKEeCCaYKUjGoP/GYMWgYCvyxHeoiNjpynKbENx
	UdTA3K/BO3Q02C/67fay/gX4w5bgzNSG0snunjsH09O37V+7
X-Google-Smtp-Source: AGHT+IH8idw74qecjpmb+s4Hd1MfbmhjY/u8hML/dYgt0Pc7KM54hB7gqWCtTKaWuyciYWDg8mbAMAex/atw5I7i2Xc=
X-Received: by 2002:a05:622a:108:b0:41e:2bad:f3c5 with SMTP id
 u8-20020a05622a010800b0041e2badf3c5mr369297qtw.9.1702903356484; Mon, 18 Dec
 2023 04:42:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: by 2002:a05:6214:1fcd:b0:67f:2bf8:28a6 with HTTP; Mon, 18 Dec 2023
 04:42:35 -0800 (PST)
In-Reply-To: <CAKHBV26CRC8eWMuOk6EZYMHOZoR2FauP=NBazzOiWCmQYEa1vg@mail.gmail.com>
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <4-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com> <CAKHBV24UGZuG6+J4cybadJCTyf9hN+e_VgAC0NVOPotmEur7SQ@mail.gmail.com>
 <20231012121616.GF3952@nvidia.com> <CAKHBV27G1PLZ5gkYkOOCZdD9waZOZypkWqk4_HSR4XXGFT-+LA@mail.gmail.com>
 <20231018130455.GU3952@nvidia.com> <CAKHBV270uJjdj4zeK-NNt+j3TiqoGDdLUQ5uRrLw9PN0ysCDbw@mail.gmail.com>
 <20231020113918.GD3952@nvidia.com> <CAKHBV274M-DDD+vJgO-k9s4MF=FLhKajPdphfBVofjyOS3vHbA@mail.gmail.com>
 <CAKHBV24nfdq1q76T+DRQGNYeA-kP7ONnSjDsRFGsQCJVSrSm0w@mail.gmail.com>
 <ZX7xu8jN/rBZ4A/d@nvidia.com> <CAKHBV26CRC8eWMuOk6EZYMHOZoR2FauP=NBazzOiWCmQYEa1vg@mail.gmail.com>
From: Michael Shavit <mshavit@google.com>
Date: Mon, 18 Dec 2023 20:42:35 +0800
Message-ID: <CAKHBV25b-=ctUz8uSuzMYDXTrn2fDm-FUQUFaFfw-OjgQ6kn9g@mail.gmail.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming independent
 of the callers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 8:35=E2=80=AFPM Michael Shavit <mshavit@google.com>=
 wrote:
> The following should address the bug and optimization you pointed out
> with minimal adjustments:
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 98aa8cc17b58b..1c35599d944d7 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -971,100 +971,6 @@ void arm_smmu_tlb_inv_asid(struct
> arm_smmu_device *smmu, u16 asid)
>         arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
>  }
>
> -/*
> - * This algorithm updates any STE/CD to any value without creating a sit=
uation
> - * where the HW can percieve a corrupted entry. HW is only required
> to have a 64
> - * bit atomicity with stores from the CPU, while entries are many 64 bit=
 values
> - * big.
> - *
> - * The algorithm works by evolving the entry toward the target in a seri=
es of
> - * steps. Each step synchronizes with the HW so that the HW can not
> see an entry
> - * torn across two steps. Upon each call cur/cur_used reflect the curren=
t
> - * synchronized value seen by the HW.
> - *
> - * During each step the HW can observe a torn entry that has any combina=
tion of
> - * the step's old/new 64 bit words. The algorithm objective is for the H=
W
> - * behavior to always be one of current behavior, V=3D0, or new behavior=
, during
> - * each step, and across all steps.
> - *
> - * At each step one of three actions is chosen to evolve cur to target:
> - *  - Update all unused bits with their target values.
> - *    This relies on the IGNORED behavior described in the specification
> - *  - Update a single 64-bit value
> - *  - Update all unused bits and set V=3D0
> - *
> - * The last two actions will cause cur_used to change, which will
> then allow the
> - * first action on the next step.
> - *
> - * In the most general case we can make any update in three steps:
> - *  - Disrupting the entry (V=3D0)
> - *  - Fill now unused bits, all bits except V
> - *  - Make valid (V=3D1), single 64 bit store
> - *
> - * However this disrupts the HW while it is happening. There are several
> - * interesting cases where a STE/CD can be updated without disturbing th=
e HW
> - * because only a small number of bits are changing (S1DSS, CONFIG, etc)=
 or
> - * because the used bits don't intersect. We can detect this by calculat=
ing how
> - * many 64 bit values need update after adjusting the unused bits and sk=
ip the
> - * V=3D0 process.
> - */
> -static bool arm_smmu_write_entry_next(__le64 *cur, const __le64 *cur_use=
d,
> -                                     const __le64 *target,
> -                                     const __le64 *target_used, __le64 *=
step,
> -                                     __le64 v_bit, unsigned int len)
> -{
> -       u8 step_used_diff =3D 0;
> -       u8 step_change =3D 0;
> -       unsigned int i;
> -
> -       /*
> -        * Compute a step that has all the bits currently unused by HW se=
t to
> -        * their target values.
> -        */
> -       for (i =3D 0; i !=3D len; i++) {
> -               step[i] =3D (cur[i] & cur_used[i]) | (target[i] & ~cur_us=
ed[i]);
> -               if (cur[i] !=3D step[i])
> -                       step_change |=3D 1 << i;
> -               /*
> -                * Each bit indicates if the step is incorrect compared t=
o the
> -                * target, considering only the used bits in the target
> -                */
> -               if ((step[i] & target_used[i]) !=3D (target[i] & target_u=
sed[i]))
> -                       step_used_diff |=3D 1 << i;
> -       }
> -
> -       if (hweight8(step_used_diff) > 1) {
> -               /*
> -                * More than 1 qword is mismatched, this cannot be done w=
ithout
> -                * a break. Clear the V bit and go again.
> -                */
> -               step[0] &=3D ~v_bit;
> -       } else if (!step_change && step_used_diff) {
> -               /*
> -                * Have exactly one critical qword, all the other qwords =
are set
> -                * correctly, so we can set this qword now.
> -                */
> -               i =3D ffs(step_used_diff) - 1;
> -               step[i] =3D target[i];
> -       } else if (!step_change) {
> -               /* cur =3D=3D target, so all done */
> -               if (memcmp(cur, target, len * sizeof(*cur)) =3D=3D 0)
> -                       return true;
> -
> -               /*
> -                * All the used HW bits match, but unused bits are differ=
ent.
> -                * Set them as well. Technically this isn't necessary but=
 it
> -                * brings the entry to the full target state, so if there=
 are
> -                * bugs in the mask calculation this will obscure them.
> -                */
> -               memcpy(step, target, len * sizeof(*step));
> -       }
> -
> -       for (i =3D 0; i !=3D len; i++)
> -               WRITE_ONCE(cur[i], step[i]);
> -       return false;
> -}
> -
>  static void arm_smmu_sync_cd(struct arm_smmu_master *master,
>                              int ssid, bool leaf)
>  {
> @@ -1398,39 +1304,135 @@ static void arm_smmu_get_ste_used(const
> struct arm_smmu_ste *ent,
>         }
>  }
>
> -static bool arm_smmu_write_ste_next(struct arm_smmu_ste *cur,
> -                                   const struct arm_smmu_ste *target,
> -                                   const struct arm_smmu_ste *target_use=
d)
> +/*
> + * Make bits of the current ste that aren't in use by the hardware equal=
 to the
> + * target's bits.
> + */
> +static void arm_smmu_ste_set_unused_bits(
> +                                  struct arm_smmu_ste *cur,
> +                                  const struct arm_smmu_ste *target)
>  {
>         struct arm_smmu_ste cur_used;
> -       struct arm_smmu_ste step;
> +       int i =3D0;
>
>         arm_smmu_get_ste_used(cur, &cur_used);
> -       return arm_smmu_write_entry_next(cur->data, cur_used.data, target=
->data,
> -                                        target_used->data, step.data,
> -                                        cpu_to_le64(STRTAB_STE_0_V),
> -                                        ARRAY_SIZE(cur->data));
> +       for (i =3D 0; i < ARRAY_SIZE(cur->data); i++)
> +               cur->data[i] =3D (cur->data[i] & cur_used.data[i]) |
> +                              (target->data[i] & ~cur_used.data[i]);
>  }
>
> +/*
> + * Update the STE to the target configuration. The transition from the c=
urrent
> + * STE to the target STE takes place over multiple steps that attempts t=
o make
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
>  static void arm_smmu_write_ste(struct arm_smmu_device *smmu, u32 sid,
>                                struct arm_smmu_ste *ste,
>                                const struct arm_smmu_ste *target)
>  {
> +       struct arm_smmu_ste staging_ste;
>         struct arm_smmu_ste target_used;
> -       int i;
> +       int writes_required =3D 0;
> +       u8 staging_used_diff =3D 0;
> +       int i =3D 0;
>
> +       /*
> +        * Compute a staging ste that has all the bits currently unused b=
y HW
> +        * set to their target values, such that comitting it to the ste =
table
> +        * woudn't disrupt the hardware.
> +        */
> +       memcpy(&staging_ste, ste, sizeof(staging_ste));
> +       arm_smmu_ste_set_unused_bits(&staging_ste, target);
> +
> +       /*
> +        * Determine if it's possible to reach the target configuration f=
rom the
> +        * staged configured in a single qword write (ignoring bits that =
are
> +        * unused under the target configuration).
> +        */
>         arm_smmu_get_ste_used(target, &target_used);
> -       /* Masks in arm_smmu_get_ste_used() are up to date */
> -       for (i =3D 0; i !=3D ARRAY_SIZE(target->data); i++)
> -               WARN_ON_ONCE(target->data[i] & ~target_used.data[i]);
> +       /*
> +        * But first sanity check that masks in arm_smmu_get_ste_used() a=
re up
> +        * to date.
> +        */
> +       for (i =3D 0; i !=3D ARRAY_SIZE(target->data); i++) {
> +               if (WARN_ON_ONCE(target->data[i] & ~target_used.data[i]))
> +                       target_used.data[i] |=3D target->data[i];
> +       }
>
> -       for (i =3D 0; true; i++) {
> -               if (arm_smmu_write_ste_next(ste, target, &target_used))
> -                       break;
> -               arm_smmu_sync_ste_for_sid(smmu, sid);
> -               if (WARN_ON(i =3D=3D 4))
> -                       break;
> +       for (i =3D 0; i !=3D ARRAY_SIZE(staging_ste.data); i++) {
> +               /*
> +                * Each bit of staging_used_diff indicates the index of a=
 qword
> +                * within the staged ste that is incorrect compared to th=
e
> +                * target, considering only the used bits in the target
> +                */
> +               if ((staging_ste.data[i] &
> +                   target_used.data[i]) !=3D (target->data[i]))
> +                       staging_used_diff |=3D 1 << i;
> +       }
> +       if (hweight8(staging_used_diff) > 1) {
> +               /*
> +                * More than 1 qword is mismatched and a hitless transiti=
on from
> +                * the current ste to the target ste is not possible. Cle=
ar the
> +                * V bit and recompute the staging STE.
> +                * Because the V bit is cleared, the staging STE will be =
equal
> +                * to the target STE except for the first qword.
> +                */
> +               staging_ste.data[0] &=3D ~cpu_to_le64(STRTAB_STE_0_V);
> +               arm_smmu_ste_set_unused_bits(&staging_ste, target);
> +               staging_used_diff =3D 1;
> +       }
> +
> +       /*
> +        * Commit the staging STE.
> +        */
> +       for (i =3D 0; i !=3D ARRAY_SIZE(staging_ste.data); i++)
> +               WRITE_ONCE(ste->data[i], staging_ste.data[i]);
> +       arm_smmu_sync_ste_for_sid(smmu, sid);
> +
> +       /*
> +        * It's now possible to switch to the target configuration with a=
 write
> +        * to a single qword. Make that switch now.
> +        */
> +       i =3D ffs(staging_used_diff) - 1;
> +       WRITE_ONCE(ste->data[i], target->data[i]);
> +       arm_smmu_sync_ste_for_sid(smmu, sid);
> +
> +       /*
> +        * Some of the bits set under the previous configuration but unus=
ed
> +        * under the target configuration might still bit set. Clear them=
 as
> +        * well. Technically this isn't necessary but it brings the entry=
 to
> +        * the full target state, so if there are bugs in the mask calcul=
ation
> +        * this will obscure them.
> +        */
> +       for (i =3D 0; i !=3D ARRAY_SIZE(ste->data); i++) {
> +               if (ste->data[i] !=3D target->data[i]) {
> +                       WRITE_ONCE(ste->data[i], target->data[i]);
> +               }
>         }
> +       arm_smmu_sync_ste_for_sid(smmu, sid);
>
>         /* It's likely that we'll want to use the new STE soon */
>         if (!(smmu->options & ARM_SMMU_OPT_SKIP_PREFETCH)) {

Sorry, that was the old patch. Here's the new one:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 98aa8cc17b58b..de2e7d9e5919c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -971,100 +971,6 @@ void arm_smmu_tlb_inv_asid(struct
arm_smmu_device *smmu, u16 asid)
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 }

-/*
- * This algorithm updates any STE/CD to any value without creating a situa=
tion
- * where the HW can percieve a corrupted entry. HW is only required
to have a 64
- * bit atomicity with stores from the CPU, while entries are many 64 bit v=
alues
- * big.
- *
- * The algorithm works by evolving the entry toward the target in a series=
 of
- * steps. Each step synchronizes with the HW so that the HW can not
see an entry
- * torn across two steps. Upon each call cur/cur_used reflect the current
- * synchronized value seen by the HW.
- *
- * During each step the HW can observe a torn entry that has any combinati=
on of
- * the step's old/new 64 bit words. The algorithm objective is for the HW
- * behavior to always be one of current behavior, V=3D0, or new behavior, =
during
- * each step, and across all steps.
- *
- * At each step one of three actions is chosen to evolve cur to target:
- *  - Update all unused bits with their target values.
- *    This relies on the IGNORED behavior described in the specification
- *  - Update a single 64-bit value
- *  - Update all unused bits and set V=3D0
- *
- * The last two actions will cause cur_used to change, which will
then allow the
- * first action on the next step.
- *
- * In the most general case we can make any update in three steps:
- *  - Disrupting the entry (V=3D0)
- *  - Fill now unused bits, all bits except V
- *  - Make valid (V=3D1), single 64 bit store
- *
- * However this disrupts the HW while it is happening. There are several
- * interesting cases where a STE/CD can be updated without disturbing the =
HW
- * because only a small number of bits are changing (S1DSS, CONFIG, etc) o=
r
- * because the used bits don't intersect. We can detect this by calculatin=
g how
- * many 64 bit values need update after adjusting the unused bits and skip=
 the
- * V=3D0 process.
- */
-static bool arm_smmu_write_entry_next(__le64 *cur, const __le64 *cur_used,
-				      const __le64 *target,
-				      const __le64 *target_used, __le64 *step,
-				      __le64 v_bit, unsigned int len)
-{
-	u8 step_used_diff =3D 0;
-	u8 step_change =3D 0;
-	unsigned int i;
-
-	/*
-	 * Compute a step that has all the bits currently unused by HW set to
-	 * their target values.
-	 */
-	for (i =3D 0; i !=3D len; i++) {
-		step[i] =3D (cur[i] & cur_used[i]) | (target[i] & ~cur_used[i]);
-		if (cur[i] !=3D step[i])
-			step_change |=3D 1 << i;
-		/*
-		 * Each bit indicates if the step is incorrect compared to the
-		 * target, considering only the used bits in the target
-		 */
-		if ((step[i] & target_used[i]) !=3D (target[i] & target_used[i]))
-			step_used_diff |=3D 1 << i;
-	}
-
-	if (hweight8(step_used_diff) > 1) {
-		/*
-		 * More than 1 qword is mismatched, this cannot be done without
-		 * a break. Clear the V bit and go again.
-		 */
-		step[0] &=3D ~v_bit;
-	} else if (!step_change && step_used_diff) {
-		/*
-		 * Have exactly one critical qword, all the other qwords are set
-		 * correctly, so we can set this qword now.
-		 */
-		i =3D ffs(step_used_diff) - 1;
-		step[i] =3D target[i];
-	} else if (!step_change) {
-		/* cur =3D=3D target, so all done */
-		if (memcmp(cur, target, len * sizeof(*cur)) =3D=3D 0)
-			return true;
-
-		/*
-		 * All the used HW bits match, but unused bits are different.
-		 * Set them as well. Technically this isn't necessary but it
-		 * brings the entry to the full target state, so if there are
-		 * bugs in the mask calculation this will obscure them.
-		 */
-		memcpy(step, target, len * sizeof(*step));
-	}
-
-	for (i =3D 0; i !=3D len; i++)
-		WRITE_ONCE(cur[i], step[i]);
-	return false;
-}
-
 static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 			     int ssid, bool leaf)
 {
@@ -1398,40 +1304,160 @@ static void arm_smmu_get_ste_used(const
struct arm_smmu_ste *ent,
 	}
 }

-static bool arm_smmu_write_ste_next(struct arm_smmu_ste *cur,
-				    const struct arm_smmu_ste *target,
-				    const struct arm_smmu_ste *target_used)
+/*
+ * Make bits of the current ste that aren't in use by the hardware equal t=
o the
+ * target's bits.
+ */
+static void arm_smmu_ste_set_unused_bits(
+			           struct arm_smmu_ste *cur,
+			           const struct arm_smmu_ste *target)
 {
 	struct arm_smmu_ste cur_used;
-	struct arm_smmu_ste step;
+	int i =3D0;

 	arm_smmu_get_ste_used(cur, &cur_used);
-	return arm_smmu_write_entry_next(cur->data, cur_used.data, target->data,
-					 target_used->data, step.data,
-					 cpu_to_le64(STRTAB_STE_0_V),
-					 ARRAY_SIZE(cur->data));
+	for (i =3D 0; i < ARRAY_SIZE(cur->data); i++)
+		cur->data[i] =3D (cur->data[i] & cur_used.data[i]) |
+			       (target->data[i] & ~cur_used.data[i]);
 }

+/*
+ * Each bit of the return value indicates the index of a qword within the =
ste
+ * that is incorrect compared to the target, considering only the used bit=
s in
+ * the target
+ */
+static u8 arm_smmu_ste_used_qword_diff_indexes(const struct arm_smmu_ste *=
ste,
+					       const struct arm_smmu_ste *target)
+{
+	struct arm_smmu_ste target_used;
+	u8 qword_diff_indexes =3D 0;
+	int i =3D 0;
+
+	arm_smmu_get_ste_used(target, &target_used);
+	for (i =3D 0; i < ARRAY_SIZE(ste->data); i++) {
+		if ((ste->data[i] & target_used.data[i]) !=3D
+		    (target->data[i] & target_used.data[i]))
+			qword_diff_indexes |=3D 1 << i;
+	}
+	return qword_diff_indexes;
+}
+
+/*
+ * Update the STE to the target configuration. The transition from the cur=
rent
+ * STE to the target STE takes place over multiple steps that attempts to =
make
+ * the transition hitless if possible. This function takes care not to cre=
ate a
+ * situation where the HW can perceive a corrupted entry. HW is only
required to
+ * have a 64 bit atomicity with stores from the CPU, while entries are man=
y 64
+ * bit values big.
+ *
+ * The algorithm works by evolving the entry toward the target in a series=
 of
+ * steps. Each step synchronizes with the HW so that the HW can not
see an entry
+ * torn across two steps. During each step the HW can observe a torn entry=
 that
+ * has any combination of the step's old/new 64 bit words. The algorithm
+ * objective is for the HW behavior to always be one of current behavior, =
V=3D0,
+ * or new behavior.
+ *
+ * In the most general case we can make any update in three steps:
+ *  - Disrupting the entry (V=3D0)
+ *  - Fill now unused bits, all bits except V
+ *  - Make valid (V=3D1), single 64 bit store
+ *
+ * However this disrupts the HW while it is happening. There are several
+ * interesting cases where a STE/CD can be updated without disturbing the =
HW
+ * because only a small number of bits are changing (S1DSS, CONFIG, etc) o=
r
+ * because the used bits don't intersect. We can detect this by calculatin=
g how
+ * many 64 bit values need update after adjusting the unused bits and skip=
 the
+ * V=3D0 process. This relies on the IGNORED behavior described in the
+ * specification
+ */
 static void arm_smmu_write_ste(struct arm_smmu_device *smmu, u32 sid,
 			       struct arm_smmu_ste *ste,
 			       const struct arm_smmu_ste *target)
 {
-	struct arm_smmu_ste target_used;
-	int i;
+	bool cleanup_sync_required =3D false;
+	struct arm_smmu_ste staging_ste;
+	u8 ste_qwords_used_diff =3D 0;
+	int i =3D 0;

-	arm_smmu_get_ste_used(target, &target_used);
-	/* Masks in arm_smmu_get_ste_used() are up to date */
-	for (i =3D 0; i !=3D ARRAY_SIZE(target->data); i++)
-		WARN_ON_ONCE(target->data[i] & ~target_used.data[i]);
+	ste_qwords_used_diff =3D arm_smmu_ste_used_qword_diff_indexes(ste, target=
);
+	if (WARN_ON_ONCE(ste_qwords_used_diff =3D=3D 0))
+		return;

-	for (i =3D 0; true; i++) {
-		if (arm_smmu_write_ste_next(ste, target, &target_used))
-			break;
+	if (hweight8(ste_qwords_used_diff) > 1) {
+		/*
+		 * If transitioning to the target STE with a single qword write
+		 * isn't possible, then we must first transition to an
+		 * intermediate STE. The intermediate STE may either be an STE
+		 * that melds bits of the target STE into the current STE
+		 * without affecting bits used by the hardware under the current
+		 * configuration; or a breaking STE if a hitless transition to
+		 * the target isn't possible.
+		 */
+
+		/*
+		 * Compute a staging ste that has all the bits currently unused
+		 * by HW set to their target values, such that comitting it to
+		 * the ste table woudn't disrupt the hardware.
+		 */
+		memcpy(&staging_ste, ste, sizeof(staging_ste));
+		arm_smmu_ste_set_unused_bits(&staging_ste, target);
+
+		ste_qwords_used_diff =3D arm_smmu_ste_used_qword_diff_indexes(ste,
+									    target);
+		if (hweight8(ste_qwords_used_diff) > 1) {
+			/*
+			 * More than 1 qword is mismatched between the staging
+			 * and target STE. A hitless transition to the target
+			 * ste is not possible. Set the staging STE to be equal
+			 * to the target STE, apart from the V bit's qword. As
+			 * long as the V bit is cleared first then writes to the
+			 * subsequent qwords will not further disrupt the
+			 * hardware.
+			 */
+			memcpy(&staging_ste, ste, sizeof(staging_ste));
+			staging_ste.data[0] &=3D ~cpu_to_le64(STRTAB_STE_0_V);
+			arm_smmu_ste_set_unused_bits(&staging_ste, target);
+			/*
+			 * After comitting the staging STE, only the 0th qword
+			 * will differ from the target.
+			 */
+			ste_qwords_used_diff =3D 1;
+		}
+
+		/*
+		 * Commit the staging STE. Note that the iteration order
+		 * matters, as we may be comitting a breaking STE in the
+		 * non-hitless case.
+		 */
+		for (i =3D 0; i !=3D ARRAY_SIZE(staging_ste.data); i++)
+			WRITE_ONCE(ste->data[i], staging_ste.data[i]);
 		arm_smmu_sync_ste_for_sid(smmu, sid);
-		if (WARN_ON(i =3D=3D 4))
-			break;
 	}

+	/*
+	 * It's now possible to switch to the target configuration with a write
+	 * to a single qword. Make that switch now.
+	 */
+	i =3D ffs(ste_qwords_used_diff) - 1;
+	WRITE_ONCE(ste->data[i], target->data[i]);
+	arm_smmu_sync_ste_for_sid(smmu, sid);
+
+	/*
+	 * Some of the bits set under the previous configuration but unused
+	 * under the target configuration might still bit set. Clear them as
+	 * well. Technically this isn't necessary but it brings the entry to
+	 * the full target state, so if there are bugs in the mask calculation
+	 * this will obscure them.
+	 */
+	for (i =3D 0; i !=3D ARRAY_SIZE(ste->data); i++) {
+		if (ste->data[i] !=3D target->data[i]) {
+			WRITE_ONCE(ste->data[i], target->data[i]);
+			cleanup_sync_required =3D true;
+		}
+	}
+	if (cleanup_sync_required)
+		arm_smmu_sync_ste_for_sid(smmu, sid);
+
 	/* It's likely that we'll want to use the new STE soon */
 	if (!(smmu->options & ARM_SMMU_OPT_SKIP_PREFETCH)) {
 		struct arm_smmu_cmdq_ent
