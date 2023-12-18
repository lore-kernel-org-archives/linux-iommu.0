Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C6B199B2
	for <iommu@lists.linux.dev>; Mon, 18 Dec 2023 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fOz4Ue5i"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-425c1d7d72eso500771cf.1
        for <iommu@lists.linux.dev>; Mon, 18 Dec 2023 04:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702902967; x=1703507767; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzidfh5X4YQhVSUt3Nmw/rYhqyXWZAIbpDg3DUZmBSM=;
        b=fOz4Ue5i0dR/8fLCH6MIsKaMNkRAfbrIpXSXVvVewAbCFq/P7bfphEzI6fFaucFeTf
         3CI3njEbR4vKsT4uwj6W0P4ZBYnZrxdvpr3LVUlmyNR3JW9vhI77qbKJm0gy+SxgqSLG
         9TQWqq4n40VpTbHfEx4AxHg27G0my+AiGzv7SroO5GIYY5KGJBbFtDUkApXc3KSzmmwz
         OXMt3++d3SAE1ZuWlKHZHSdrBJH3vn4aDX/niXe4d+CvXNMnKw0MvVP2KcgtnHrZDnwm
         Qf8EvpFJS/zNWGON2QMvSJCJO1NQ56Kj00voM8YNbGyRDpkhAqJ2Rk2dOWcHA+dQ87Uc
         Y1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702902967; x=1703507767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzidfh5X4YQhVSUt3Nmw/rYhqyXWZAIbpDg3DUZmBSM=;
        b=PJ1CeoZvRXr7NeYtmVrLtBg4hyqvt0VIaIXSDFWHMY/Bvg49J+q5zXV6H6S8yVBQAN
         aQ30eegXwpRuXizS7ZegaBoKfJ74R3cDIKFb+XaZ1C856qkDO44DFzDSeDaOPP28qZS1
         90kWgpPhSlO3i7ajfmXR0Y+Oem7GvraQtQ4owSe1ajTbc2XYfZNaP9RCRcFbKP5fF3sp
         /1rCtM+G4waNJjnHJ2GB+NKTIPuUjCCq7s1CeYXSkp0B+bSbIOewR6lHXjRoJlbjTIXd
         52J5iUchfA2JspUviaQ6orsc1C3IFTPHhSz4mby9kQ7WIihMBhJxVVvmydu8F8Sr/S8h
         Ahtg==
X-Gm-Message-State: AOJu0YwUoCvFF1pDXcB+6M93O6aVWPVnHH9QVo2EgwJh7BLjbehorKLS
	ui0Xp/M5GafGCxVbpKtsnhzWeLnYEjs1qgUfORYtfCAZWAgQ
X-Google-Smtp-Source: AGHT+IE9t3O0iFyJfVWYn74B91D3A6U92i6tb3eSK16Cr06kduJakEe5oeZyT0p4DlxGGzGiQtRIb/bulMduFZch1qg=
X-Received: by 2002:ac8:7f82:0:b0:425:75be:ab3a with SMTP id
 z2-20020ac87f82000000b0042575beab3amr385340qtj.0.1702902966473; Mon, 18 Dec
 2023 04:36:06 -0800 (PST)
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
 <CAKHBV24nfdq1q76T+DRQGNYeA-kP7ONnSjDsRFGsQCJVSrSm0w@mail.gmail.com> <ZX7xu8jN/rBZ4A/d@nvidia.com>
In-Reply-To: <ZX7xu8jN/rBZ4A/d@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Mon, 18 Dec 2023 20:35:30 +0800
Message-ID: <CAKHBV26CRC8eWMuOk6EZYMHOZoR2FauP=NBazzOiWCmQYEa1vg@mail.gmail.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming independent
 of the callers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 9:03=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Sat, Dec 16, 2023 at 04:26:48AM +0800, Michael Shavit wrote:
>
> > Ok, I took a proper stab at trying to unroll the loop on the github
> > version of this patch (v3+)
> > As you suspected, it's not easy to re-use the unrolled version for
> > both STE and CD writing as we'd have to pass in callbacks for syncing
> > the STE/CD and recomputing arm_smmu_{get_ste/cd}_used.
>
> Yes, that is why I structured it as an iterator

On second thought, perhaps defining a helper class implementing
entry_sync() and entry_get_used_bits() might not be so bad?
It's a little bit more verbose, but avoids deduplication of the
complicated parts.

> > I personally find this quite a bit more readable as a sequential
> > series of steps instead of a loop. It also only requires 3 STE/CD
> > syncs in the worst case compared to 4 in the loop version since we
>
> The existing version is max 3 as well, it works the same by
> checking the number of critical qwords after computing the first step
> in the hitless flow.

Gotcha. I was being lazy and assuming it was 4 based on the warning
added to the github version :).

>
> However, what you have below has the same problem as the first sketch,
> it always does 3 syncs. The existing version fully minimizes the
> syncs. It is why it is so complex to unroll it as you have to check
> before every sync if the sync is needed at all.

Hmmmm, AFAICT there are two optimizations I was missing:
1. The final clean-up loop may be a nop, in which case a sync isn't require=
d.
2. We may be able to directly transition to the target state with a
single qword write from the very beginning, without going through any
intermediate STEs.

Both of these seem pretty easy to address in this version as well
however; or am I still overlooking a scenario?

>
> This could probably be organized like this so one shared function
> computes the "plan" and then a cd/ste copy executes the plan. It
> avoids the loop but all the code is still basically the same, there is
> just more of it.
>
> I'm fine with any of these ways
>
> Jason
>
> >  static void arm_smmu_write_ste(struct arm_smmu_device *smmu, u32 sid,
> >                                struct arm_smmu_ste *ste,
> >                                const struct arm_smmu_ste *target)
> >  {
> > +       struct arm_smmu_ste staging_ste;
> >         struct arm_smmu_ste target_used;
> > +       int writes_required =3D 0;
> > +       u8 staging_used_diff =3D 0;
> > +       int i =3D 0;
> >
> > +       /*
> > +        * Compute a staging ste that has all the bits currently unused=
 by HW
> > +        * set to their target values, such that comitting it to the st=
e table
> > +        * woudn't disrupt the hardware.
> > +        */
> > +       memcpy(&staging_ste, ste, sizeof(staging_ste));
> > +       arm_smmu_ste_set_unused_bits(&staging_ste, target);
> > +
> > +       /*
> > +        * Determine if it's possible to reach the target configuration=
 from the
> > +        * staged configured in a single qword write (ignoring bits tha=
t are
> > +        * unused under the target configuration).
> > +        */
> >         arm_smmu_get_ste_used(target, &target_used);
> > -               WARN_ON_ONCE(target->data[i] & ~target_used.data[i]);
> > +       /*
> > +        * But first sanity check that masks in arm_smmu_get_ste_used()=
 are up
> > +        * to date.
> > +        */
> > +       for (i =3D 0; i !=3D ARRAY_SIZE(target->data); i++) {
> > +               if (WARN_ON_ONCE(target->data[i] & ~target_used.data[i]=
))
> > +                       target_used.data[i] |=3D target->data[i];
> > +       }
> >
> > +       for (i =3D 0; i !=3D ARRAY_SIZE(staging_ste.data); i++) {
> > +               /*
> > +                * Each bit of staging_used_diff indicates the index of=
 a qword
> > +                * within the staged ste that is incorrect compared to =
the
> > +                * target, considering only the used bits in the target
> > +                */
> > +               if ((staging_ste.data[i] &
> > +                   target_used.data[i]) !=3D (target->data[i]))
> > +                       staging_used_diff |=3D 1 << i;
> > +       }
> > +       if (hweight8(staging_used_diff) > 1) {
> > +               /*
> > +                * More than 1 qword is mismatched and a hitless transi=
tion from
> > +                * the current ste to the target ste is not possible. C=
lear the
> > +                * V bit and recompute the staging STE.
> > +                * Because the V bit is cleared, the staging STE will b=
e equal
> > +                * to the target STE except for the first qword.
> > +                */
> > +               staging_ste.data[0] &=3D ~cpu_to_le64(STRTAB_STE_0_V);
> > +               arm_smmu_ste_set_unused_bits(&staging_ste, target);
> > +               staging_used_diff =3D 1;
> > +       }
> > +
> > +       /*
> > +        * Commit the staging STE.
> > +        */
> > +       for (i =3D 0; i !=3D ARRAY_SIZE(staging_ste.data); i++)
> > +               WRITE_ONCE(ste->data[i], staging_ste.data[i]);
> > +       arm_smmu_sync_ste_for_sid(smmu, sid);
> > +
> > +       /*
> > +        * It's now possible to switch to the target configuration with=
 a write
> > +        * to a single qword. Make that switch now.
> > +        */
> > +       i =3D ffs(staging_used_diff) - 1;
> > +       WRITE_ONCE(ste->data[i], target->data[i]);
> > +       arm_smmu_sync_ste_for_sid(smmu, sid);
>
> The non hitless flow doesn't look right to me, it should set v=3D0 then
> load all qwords but 0 then load 0, in exactly that sequence. If the
> goal is clarity then the two programming flows should be explicitly
> spelled out.

Ah yeah you're right. I forgot to set the other qwords in the staging
STE to have their final values in the non-hitless case.

The following should address the bug and optimization you pointed out
with minimal adjustments:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 98aa8cc17b58b..1c35599d944d7 100644
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
-                                     const __le64 *target,
-                                     const __le64 *target_used, __le64 *st=
ep,
-                                     __le64 v_bit, unsigned int len)
-{
-       u8 step_used_diff =3D 0;
-       u8 step_change =3D 0;
-       unsigned int i;
-
-       /*
-        * Compute a step that has all the bits currently unused by HW set =
to
-        * their target values.
-        */
-       for (i =3D 0; i !=3D len; i++) {
-               step[i] =3D (cur[i] & cur_used[i]) | (target[i] & ~cur_used=
[i]);
-               if (cur[i] !=3D step[i])
-                       step_change |=3D 1 << i;
-               /*
-                * Each bit indicates if the step is incorrect compared to =
the
-                * target, considering only the used bits in the target
-                */
-               if ((step[i] & target_used[i]) !=3D (target[i] & target_use=
d[i]))
-                       step_used_diff |=3D 1 << i;
-       }
-
-       if (hweight8(step_used_diff) > 1) {
-               /*
-                * More than 1 qword is mismatched, this cannot be done wit=
hout
-                * a break. Clear the V bit and go again.
-                */
-               step[0] &=3D ~v_bit;
-       } else if (!step_change && step_used_diff) {
-               /*
-                * Have exactly one critical qword, all the other qwords ar=
e set
-                * correctly, so we can set this qword now.
-                */
-               i =3D ffs(step_used_diff) - 1;
-               step[i] =3D target[i];
-       } else if (!step_change) {
-               /* cur =3D=3D target, so all done */
-               if (memcmp(cur, target, len * sizeof(*cur)) =3D=3D 0)
-                       return true;
-
-               /*
-                * All the used HW bits match, but unused bits are differen=
t.
-                * Set them as well. Technically this isn't necessary but i=
t
-                * brings the entry to the full target state, so if there a=
re
-                * bugs in the mask calculation this will obscure them.
-                */
-               memcpy(step, target, len * sizeof(*step));
-       }
-
-       for (i =3D 0; i !=3D len; i++)
-               WRITE_ONCE(cur[i], step[i]);
-       return false;
-}
-
 static void arm_smmu_sync_cd(struct arm_smmu_master *master,
                             int ssid, bool leaf)
 {
@@ -1398,39 +1304,135 @@ static void arm_smmu_get_ste_used(const
struct arm_smmu_ste *ent,
        }
 }

-static bool arm_smmu_write_ste_next(struct arm_smmu_ste *cur,
-                                   const struct arm_smmu_ste *target,
-                                   const struct arm_smmu_ste *target_used)
+/*
+ * Make bits of the current ste that aren't in use by the hardware equal t=
o the
+ * target's bits.
+ */
+static void arm_smmu_ste_set_unused_bits(
+                                  struct arm_smmu_ste *cur,
+                                  const struct arm_smmu_ste *target)
 {
        struct arm_smmu_ste cur_used;
-       struct arm_smmu_ste step;
+       int i =3D0;

        arm_smmu_get_ste_used(cur, &cur_used);
-       return arm_smmu_write_entry_next(cur->data, cur_used.data, target->=
data,
-                                        target_used->data, step.data,
-                                        cpu_to_le64(STRTAB_STE_0_V),
-                                        ARRAY_SIZE(cur->data));
+       for (i =3D 0; i < ARRAY_SIZE(cur->data); i++)
+               cur->data[i] =3D (cur->data[i] & cur_used.data[i]) |
+                              (target->data[i] & ~cur_used.data[i]);
 }

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
+       struct arm_smmu_ste staging_ste;
        struct arm_smmu_ste target_used;
-       int i;
+       int writes_required =3D 0;
+       u8 staging_used_diff =3D 0;
+       int i =3D 0;

+       /*
+        * Compute a staging ste that has all the bits currently unused by =
HW
+        * set to their target values, such that comitting it to the ste ta=
ble
+        * woudn't disrupt the hardware.
+        */
+       memcpy(&staging_ste, ste, sizeof(staging_ste));
+       arm_smmu_ste_set_unused_bits(&staging_ste, target);
+
+       /*
+        * Determine if it's possible to reach the target configuration fro=
m the
+        * staged configured in a single qword write (ignoring bits that ar=
e
+        * unused under the target configuration).
+        */
        arm_smmu_get_ste_used(target, &target_used);
-       /* Masks in arm_smmu_get_ste_used() are up to date */
-       for (i =3D 0; i !=3D ARRAY_SIZE(target->data); i++)
-               WARN_ON_ONCE(target->data[i] & ~target_used.data[i]);
+       /*
+        * But first sanity check that masks in arm_smmu_get_ste_used() are=
 up
+        * to date.
+        */
+       for (i =3D 0; i !=3D ARRAY_SIZE(target->data); i++) {
+               if (WARN_ON_ONCE(target->data[i] & ~target_used.data[i]))
+                       target_used.data[i] |=3D target->data[i];
+       }

-       for (i =3D 0; true; i++) {
-               if (arm_smmu_write_ste_next(ste, target, &target_used))
-                       break;
-               arm_smmu_sync_ste_for_sid(smmu, sid);
-               if (WARN_ON(i =3D=3D 4))
-                       break;
+       for (i =3D 0; i !=3D ARRAY_SIZE(staging_ste.data); i++) {
+               /*
+                * Each bit of staging_used_diff indicates the index of a q=
word
+                * within the staged ste that is incorrect compared to the
+                * target, considering only the used bits in the target
+                */
+               if ((staging_ste.data[i] &
+                   target_used.data[i]) !=3D (target->data[i]))
+                       staging_used_diff |=3D 1 << i;
+       }
+       if (hweight8(staging_used_diff) > 1) {
+               /*
+                * More than 1 qword is mismatched and a hitless transition=
 from
+                * the current ste to the target ste is not possible. Clear=
 the
+                * V bit and recompute the staging STE.
+                * Because the V bit is cleared, the staging STE will be eq=
ual
+                * to the target STE except for the first qword.
+                */
+               staging_ste.data[0] &=3D ~cpu_to_le64(STRTAB_STE_0_V);
+               arm_smmu_ste_set_unused_bits(&staging_ste, target);
+               staging_used_diff =3D 1;
+       }
+
+       /*
+        * Commit the staging STE.
+        */
+       for (i =3D 0; i !=3D ARRAY_SIZE(staging_ste.data); i++)
+               WRITE_ONCE(ste->data[i], staging_ste.data[i]);
+       arm_smmu_sync_ste_for_sid(smmu, sid);
+
+       /*
+        * It's now possible to switch to the target configuration with a w=
rite
+        * to a single qword. Make that switch now.
+        */
+       i =3D ffs(staging_used_diff) - 1;
+       WRITE_ONCE(ste->data[i], target->data[i]);
+       arm_smmu_sync_ste_for_sid(smmu, sid);
+
+       /*
+        * Some of the bits set under the previous configuration but unused
+        * under the target configuration might still bit set. Clear them a=
s
+        * well. Technically this isn't necessary but it brings the entry t=
o
+        * the full target state, so if there are bugs in the mask calculat=
ion
+        * this will obscure them.
+        */
+       for (i =3D 0; i !=3D ARRAY_SIZE(ste->data); i++) {
+               if (ste->data[i] !=3D target->data[i]) {
+                       WRITE_ONCE(ste->data[i], target->data[i]);
+               }
        }
+       arm_smmu_sync_ste_for_sid(smmu, sid);

        /* It's likely that we'll want to use the new STE soon */
        if (!(smmu->options & ARM_SMMU_OPT_SKIP_PREFETCH)) {
