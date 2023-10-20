Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDBA10955
	for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EaNmsO2r"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-41cd566d8dfso173331cf.0
        for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 01:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697790261; x=1698395061; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrnjWJdFH9tMi6CLmNp2DtRsM8DKDAxkzU6AgZfWzck=;
        b=EaNmsO2rCXpV1gSB3of2pE/KIc91IEUgxp/024K0mJVbkjaN2rGeRjve+632J7N4CO
         1hX/4Yyc6xihZtas3LUwEGBA+gRNN3jTSmqH0cjWiFKzYh6BQdIiqVyTp9oWqv3kf6W3
         VMUdfCd03wSDYCcuaVJfgtYN5PnXz+mouVTcs1NzMwRKHKtnsSFQzRvc7FJdhK42Fi2A
         Rsoq4KEx1WYgbNlQSBh6DQJjqfO617NCfPqWg1cVYNQ6hL98LbT1sXDGYhYxJd7tN5Il
         CAiHcQBsJNk/V9ttzET5oTp2OtMH6UNYVsAdpOpHbvWouzNK6k3EH/DHvypKz5M/BdSO
         O79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697790261; x=1698395061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrnjWJdFH9tMi6CLmNp2DtRsM8DKDAxkzU6AgZfWzck=;
        b=pvK98+xVTPvqw7j//HPtfj2SpQPQdwTbG2p9CMXBTPO1diqftHs5AcORm53bGqUsya
         tX0EMdZzOXzC76pmrCWaXMzpUf2oatFLp5UiKimc+mJMcURG7pGBA62r7brWORQlWohT
         3YCIvLrNC4AFizlOUVhxa2JMD1Xe83kwhcNxvmFD36+BXM/G39iUR26Pofi3Jr8qnBjf
         O+Tbdc6Q2WSO2nTCKz2J9J8hp7vAGKRx/cvyik6675gu88l/urpHZ1QtG65U/d2Qqvbj
         V0GFQlgxnppfTNpy5Yie6AjW+GFQsLifajEIn/Nvq/nfnn3mrgRrrnL2PXk3mscaRpQg
         1IOw==
X-Gm-Message-State: AOJu0YzeywZNmzw51GnBJY2z1ZrB0+E9P/rpnnA+FcbKGIsls0lqHEIB
	1chgmaZm4lXLXbLkBx6TjpGroymOqB61rk/NJaWwvg==
X-Google-Smtp-Source: AGHT+IEEOQ0Ak6KP5WsaSFDtM/Zg1nQqA2NhfK+U6iQfKM6I3PKoSXoXdXamZGw84sfmNOXtY8qEal9Hu2QhMaFqYqw=
X-Received: by 2002:ac8:4e0a:0:b0:41b:834e:1b24 with SMTP id
 c10-20020ac84e0a000000b0041b834e1b24mr197139qtw.6.1697790261074; Fri, 20 Oct
 2023 01:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <4-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com> <CAKHBV24UGZuG6+J4cybadJCTyf9hN+e_VgAC0NVOPotmEur7SQ@mail.gmail.com>
 <20231012121616.GF3952@nvidia.com> <CAKHBV27G1PLZ5gkYkOOCZdD9waZOZypkWqk4_HSR4XXGFT-+LA@mail.gmail.com>
 <20231018130455.GU3952@nvidia.com>
In-Reply-To: <20231018130455.GU3952@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 20 Oct 2023 16:23:44 +0800
Message-ID: <CAKHBV270uJjdj4zeK-NNt+j3TiqoGDdLUQ5uRrLw9PN0ysCDbw@mail.gmail.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming independent
 of the callers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 9:05=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Oct 18, 2023 at 07:05:49PM +0800, Michael Shavit wrote:
>
> > > FWIW, I found the most difficult part the used bit calculation, not
> > > the update algorithm. Difficult because it is hard to read and find i=
n
> > > the spec when things are INGORED, but it is a "straightforward" job o=
f
> > > finding INGORED cases and making the used bits 0.
> >
> > The update algorithm is the part I'm finding much harder to read and
> > review :) . arm_smmu_write_entry_step in particular is hard to read
> > through; on top of which there's some subtle dependencies between loop
> > iterations that weren't obvious to grok:
>
> Yes, you have it right, it is basically a classic greedy
> algorithm. Let's improve the comment.
>
> > * Relying on the used_bits to be recomputed after the first iteration
> > where V=3D0 was set to 0 so that more bits can now be set.
> > * The STE having to be synced between iterations to prevent broken STE
> > reads by the SMMU (there's a comment somewhere else in arm-smmu-v3.c
> > that would fit nicely here instead). But the caller is responsible for
> > calling this between iterations for some reason (supposedly to support
> > CD entries as well in the next series)
>
> Yes, for CD entry support.
>
> How about:
>
> /*
>  * This algorithm updates any STE/CD to any value without creating a situ=
ation
>  * where the HW can percieve a corrupted entry. HW is only required to ha=
ve a 64
>  * bit atomicity with stores from the CPU, while entires are many 64 bit =
values
>  * big.
>  *
>  * The algorithm works by evolving the entry toward the target in a serie=
s of
>  * steps. Each step synchronizes with the HW so that the HW can not see a=
n entry
>  * torn across two steps. Upon each call cur/cur_used reflect the current
>  * synchronized value seen by the HW.
>  *
>  * During each step the HW can observe a torn entry that has any combinat=
ion of
>  * the step's old/new 64 bit words. The algorithm objective is for the HW
>  * behavior to always be one of current behavior, V=3D0, or new behavior,=
 during
>  * each step, and across all steps.
>  *
>  * At each step one of three actions is choosen to evolve cur to target:
>  *  - Update all unused bits with their target values.
>  *    This relies on the IGNORED behavior described in the specification
>  *  - Update a single 64-bit value
>  *  - Update all unused bits and set V=3D0
>  *
>  * The last two actions will cause cur_used to change, which will then al=
low the
>  * first action on the next step.
>  *
>  * In the most general case we can make any update in three steps:
>  *  - Disrupting the entry (V=3D0)
>  *  - Fill now unused bits, all bits except V
>  *  - Make valid (V=3D1), single 64 bit store
>  *
>  * However this disrupts the HW while it is happening. There are several
>  * interesting cases where a STE/CD can be updated without disturbing the=
 HW
>  * because only a small number of bits are changing (S1DSS, CONFIG, etc) =
or
>  * because the used bits don't intersect. We can detect this by calculati=
ng how
>  * many 64 bit values need update after adjusting the unused bits and ski=
p the
>  * V=3D0 process.
>  */
> static bool arm_smmu_write_entry_step(__le64 *cur, const __le64 *cur_used=
,
>
> Jason

The comment helps a lot thank you.

I do still have some final reservations: wouldn't it be clearer with
the loop un-rolled? After all it's only 3 steps in the worst case....
Something like:

+       arm_smmu_get_ste_used(target, &target_used);
+       arm_smmu_get_ste_used(cur, &cur_used);
+       if (!hitless_possible(target, target_used, cur_used, cur_used)) {
+               target->data[0] =3D STRTAB_STE_0_V;
+               arm_smmu_sync_ste_for_sid(smmu, sid);
+               /*
+                * The STE is now in abort where none of the bits except
+                * STRTAB_STE_0_V and STRTAB_STE_0_CFG are accessed. This a=
llows
+                * all other words of the STE to be written without further
+                * disruption.
+                */
+               arm_smmu_get_ste_used(cur, &cur_used);
+       }
+       /* write bits in all positions unused by the STE */
+       for (i =3D 0; i !=3D ARRAY_SIZE(cur->data); i++) {
+               /* (should probably optimize this away if no write needed) =
*/
+               WRITE_ONCE(cur->data[i], (cur->data[i] & cur_used[i])
| (target->data[i] & ~cur_used[i]));
+       }
+       arm_smmu_sync_ste_for_sid(smmu, sid);
+       /*
+        * It should now be possible to make a single qword write to make t=
he
+        * the new configuration take effect.
+        */
+       for (i =3D 0; i !=3D ARRAY_SIZE(cur->data); i++) {
+               if ((cur->data[i] & target_used[i]) !=3D
(target->data[i] & target_used[i]))
+                       /*
+                        * TODO:
+                        * WARN_ONCE if this condition hits more than once =
in
+                        * the loop
+                        */
+                       WRITE_ONCE(cur->data[i], (cur->data[i] &
cur_used[i]) | (target->data[i] & ~cur_used[i]));
+       }
+       arm_smmu_sync_ste_for_sid(smmu, sid);
