Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E33345C03
	for <iommu@lists.linux.dev>; Fri, 15 Dec 2023 20:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMskus2A"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-425928c24easo57531cf.0
        for <iommu@lists.linux.dev>; Fri, 15 Dec 2023 12:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702672044; x=1703276844; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5dXl2aH7CgtNYAHc6h4fnNKqCnbDhA8JWJqpGaYVWE=;
        b=YMskus2A8pQA1EwaeQ8jQ3CstVm63lKL9R1cy3VvVRnZ+YUn9Z8o4wxmyh7wJsmIHE
         PyYouyOUS8ckiMKSWsyfRmV+SlO+i4XvCdEn4VJFcc6uZyZPnrO5ZzODv7hlN1iUojNI
         01ua2DMk7tni7U9692npTXZKo1rJlfx3Ng8fTAYAkoinOvUR+e1PE0P4jewxN0FwUroR
         mmNlvjf3IJrqZvKxezysNoOfuoTKOersWP/tXk/WD6GLD9RyZicK4N789I9gJSAtgAcW
         u48BekuKYJdduGR7bJXS7OoB4p+puXowJqpScDHzvhY3lvqsbV12smDx0BcJwqJZraLq
         5h1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702672044; x=1703276844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5dXl2aH7CgtNYAHc6h4fnNKqCnbDhA8JWJqpGaYVWE=;
        b=fM+xVgy5nZ2MQGsMRtCazZxI/X5zgDUQgHCYC6maXl20frrIo99CDPKn3SjgXkkn0F
         NdPVHVTCcscORgbah/zd1R7Bb05d5muqUy1PD2EDWjQ4LotojblSUJXCGizJsGm5w1Ez
         X/PxXlkL2klbjhrvFqaqbyDItTGoZvodtknyxQoOjxutS9Sx8ZYWBFuGMs4jM9j7vBLj
         aLlIBDr83hiKiLYsu2gx1IMzX9/qlBeJxGg1pn+5T4Le8yOQwZDr2p5Hfah1r9DWkq3Z
         IeDiarIAeLvR3+YafszojtEsRLR7LkWHuXkL8sjbgxSVNZgW0C6X8LPADmLxutgnD/9k
         2EEg==
X-Gm-Message-State: AOJu0Ywm5Vhj+ny8WWzg2qVMNh66smLmIBmta8ssuUHrkeKIUuVcHbXt
	pVN3CVGS8bS+fQKEYMM6MqorAAHN3/gLhP1D/tQd5kNdKzxG
X-Google-Smtp-Source: AGHT+IFAVK06CgMchoR1OXmCz79Y5XS/lVFa8bk6By02juP7t5gAOQ3YGiqxHpRWqzmYVHvBXz7Q2ISkQEZW9DyhghE=
X-Received: by 2002:ac8:5cc5:0:b0:425:9771:a5f3 with SMTP id
 s5-20020ac85cc5000000b004259771a5f3mr57735qta.10.1702672044110; Fri, 15 Dec
 2023 12:27:24 -0800 (PST)
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
In-Reply-To: <CAKHBV274M-DDD+vJgO-k9s4MF=FLhKajPdphfBVofjyOS3vHbA@mail.gmail.com>
From: Michael Shavit <mshavit@google.com>
Date: Sat, 16 Dec 2023 04:26:48 +0800
Message-ID: <CAKHBV24nfdq1q76T+DRQGNYeA-kP7ONnSjDsRFGsQCJVSrSm0w@mail.gmail.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming independent
 of the callers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 4:36=E2=80=AFPM Michael Shavit <mshavit@google.com>=
 wrote:
>
> On Fri, Oct 20, 2023 at 7:39=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> =
wrote:
> >
> > On Fri, Oct 20, 2023 at 04:23:44PM +0800, Michael Shavit wrote:
> > > The comment helps a lot thank you.
> > >
> > > I do still have some final reservations: wouldn't it be clearer with
> > > the loop un-rolled? After all it's only 3 steps in the worst case....
> > > Something like:
> >
> > I thought about that, but a big point for me was to consolidate the
> > algorithm between CD/STE. Inlining everything makes it much more
> > difficult to achieve this. Actually my first sketches were trying to
> > write it unrolled.
> >
> > > +       arm_smmu_get_ste_used(target, &target_used);
> > > +       arm_smmu_get_ste_used(cur, &cur_used);
> > > +       if (!hitless_possible(target, target_used, cur_used, cur_used=
)) {
> >
> > hitless possible requires the loop of the step function to calcuate
> > it.
>
> Possibly yes. Another option would be to have a list of transitions
> (e.g. IDENTITY -> S1) we expect and want to be hitless and check
> against that list. It defeats some of the purpose of your design, but
> it's also not obvious to me that we really need such flexibility in
> the first place.
>
> >
> > > +               target->data[0] =3D STRTAB_STE_0_V;
> > > +               arm_smmu_sync_ste_for_sid(smmu, sid);
> >
> > I still like V=3D0 as I think we do want the event for this case.
>
> Oh yeah sure, I did not think too carefully about this.
>
> >
> > > +               /*
> > > +                * The STE is now in abort where none of the bits exc=
ept
> > > +                * STRTAB_STE_0_V and STRTAB_STE_0_CFG are accessed. =
This allows
> > > +                * all other words of the STE to be written without f=
urther
> > > +                * disruption.
> > > +                */
> > > +               arm_smmu_get_ste_used(cur, &cur_used);
> > > +       }
> > > +       /* write bits in all positions unused by the STE */
> > > +       for (i =3D 0; i !=3D ARRAY_SIZE(cur->data); i++) {
> > > +               /* (should probably optimize this away if no write ne=
eded) */
> > > +               WRITE_ONCE(cur->data[i], (cur->data[i] & cur_used[i])
> > > | (target->data[i] & ~cur_used[i]));
> > > +       }
> > > +       arm_smmu_sync_ste_for_sid(smmu, sid);
> >
> > Yes, I wanted to avoid all the syncs if they are not required.
>
> Should be easy enough to optimize away in this alternate version as well.
>
> >
> > > +       /*
> > > +        * It should now be possible to make a single qword write to =
make the
> > > +        * the new configuration take effect.
> > > +        */
> > > +       for (i =3D 0; i !=3D ARRAY_SIZE(cur->data); i++) {
> > > +               if ((cur->data[i] & target_used[i]) !=3D
> > > (target->data[i] & target_used[i]))
> > > +                       /*
> > > +                        * TODO:
> > > +                        * WARN_ONCE if this condition hits more than=
 once in
> > > +                        * the loop
> > > +                        */
> > > +                       WRITE_ONCE(cur->data[i], (cur->data[i] &
> > > cur_used[i]) | (target->data[i] & ~cur_used[i]));
> > > +       }
> >
> > > +       arm_smmu_sync_ste_for_sid(smmu, sid);
> >
> > This needs to be optional too
> >
> > And there is another optional 4th pass to set the unused target values
> > to 0.
> >
> > Basically you have captured the core algorithm, but I think if you
> > fill in all the missing bits to get up to the same functionality it
> > will be longer and unsharable with the CD side.
> >
> > You could perhaps take this approach and split it into 4 sharable step
> > functions:
> >
> >  if (step1(target, target_used, cur_used, cur_used, len)) {
> >   arm_smmu_sync_ste_for_sid(smmu, sid);
> >   arm_smmu_get_ste_used(cur, &cur_used);
> >  }
> >
> >  if (step2(target, target_used, cur_used, cur_used, len))
> >   arm_smmu_sync_ste_for_sid(smmu, sid);
> >
> >  if (step3(target, target_used, cur_used, cur_used, len)) {
> >    arm_smmu_sync_ste_for_sid(smmu, sid);
> >    arm_smmu_get_ste_used(cur, &cur_used);
> >   }
> >
> >  if (step4(target, target_used, cur_used, cur_used, len))
> >    arm_smmu_sync_ste_for_sid(smmu, sid);
> >
> > To me this is inelegant as if we only need to do step 3 we have to
> > redundantly scan the array 2 times. The rolled up version just
> > directly goes to step 3.
> >
> > However this does convince me you've thought very carefully about this
> > and have not found a flaw in the design!
>
> Right, it's more of a style/readability question so I'll leave it to
> others to chime in further if needed :) .

Ok, I took a proper stab at trying to unroll the loop on the github
version of this patch (v3+)
As you suspected, it's not easy to re-use the unrolled version for
both STE and CD writing as we'd have to pass in callbacks for syncing
the STE/CD and recomputing arm_smmu_{get_ste/cd}_used. The flow is
still exactly the same in both cases however, and there is room to
extract some of the steps between sync operations into shareable
helpers for re-use between the two (I haven't bothered to do that so
that we can evaluate first before putting in more effort).

I personally find this quite a bit more readable as a sequential
series of steps instead of a loop. It also only requires 3 STE/CD
syncs in the worst case compared to 4 in the loop version since we
determine whether a hitless transition is possible before making any
writes to the STE (where-as the current patch optimistically starts
trying to transition to the target before discovering that it must
nuke the V bit first).
Are those both not worth a bit of code duplication between STE and CD writi=
ng?

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
