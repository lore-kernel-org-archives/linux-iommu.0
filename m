Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3583D811B
	for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 21:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786744668; cv=pass; b=pns1/5lXv8MbXZSqZNu56zPyWhQpou17JeaexDz3la8KZDcvAqA53nxn8ihMvgz1XcNb+RX7lR3pWsv64mYQuc1Buq+jahz64mvypjRhDf9s4HeySrsfs3rvZKmA0pjMpmhglNjf1P32TxWvl9gZwM3ZUL4e1fCsROdCar7uPuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786744668; c=relaxed/simple;
	bh=DQBzlyWe/dY1MnAyhHUw8AfdNURN8gg0HjSS3nmXkuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvfarUMY3q0ieyNKmUQCdLA59ExRwCThFNGiP3XrqEbw0HZk1jZS5NEMeggTQwlKobH1ORtbrru07KupEdUgbHIURliQwSH3/+pPEU75E6u5vZ+yjRT0ksxyh/VSAtlae0mN/2qr2KwK63XZN2hJ5K33LdRi1uEMs5j7kZ3fIGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k1CRoYQM; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1CRoYQM"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c10ed63c0so364091cf.1
        for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 14:57:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786744666; cv=none;
        d=google.com; s=arc-20260327;
        b=NzlEixNPEK7mxx4bj/YsuqwX1mBwkwhV4oTP8kWaDmos/0/0lEbj8IQeto/xnzdVQS
         A6wvUPAOLl4jLBFOU7KF3CWWkvR5GKMEOUT3Owh4HgBARCKKu4nr6MeVAVLunS+KKd8D
         UkCyJvwDyiIM3wQu3dPhIMrd9pNPXbiPAhxkqMqDjRfSDp3RJZWkwFaTBvSzfQ2jBEHY
         Z3kbB5/J889VWqPwIZdifCD+ZQwUXglkluPi/gPWIR7rKzFRoBACe5kynKWaOvYLnhk3
         fmjHRySPcsQZgzhJB00bqRjShisJdttNNgC4rlqkSmtCBfKfFns+FK6bad4zuQ6jvG4c
         XSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q/erZy2n38i8Q19od1dHI45fS0KoMtthuq5RrnDN/Dg=;
        fh=W3aRguYoahijWXCj4vF/7ufrH8jo/M76u3vglKErtzY=;
        b=anll1CBycAXstXCyxQLldZsaUUYlIu9OLzXOCGJU+mzhfXwlpOR/+GNiNXKRzipGcE
         jF9l2MGIu+FYxeWzJBWkDRkuegtkuoFiaielvnfz5NrFdpX+qnsHcbxfChmuMs5RZcLv
         tJEUgXP0iTgE17CUSDSHrEKZXtBJ8OcCbyNy6SzIdkwm+cwyIcCfkcBQoKa5hbHHFsWS
         83/ijkKL8pP3gaILn99ijLejUzCL8doUYCIRk8ONCLC9oJt200v30X5IeUXL01ctf2nk
         +AoTOftJtYSb8wW6dUun3k5+B+rPE2l4yh2zm0h8xKp6G6en290sGFBP5d+DqSlBCD94
         4Ddg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786744666; x=1787349466; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q/erZy2n38i8Q19od1dHI45fS0KoMtthuq5RrnDN/Dg=;
        b=k1CRoYQM+TNjl6GAS/4Y88og/kjYqPWmVrjbBhcGrrX76fVUvQIe5c0OxVV0VQZBPK
         7Ab8+jI58dVBGRrhV0JTWFedBuvFxXxbKfy4BqIKG599cOeGKK6IX3cAFIKavCm/6I3Y
         E6AO+AkLG2iAWlfLFBNG34UBEiG4mN8J6UR0siYhVL7QZHU9rSYamWliIzhYYFtfk0Eo
         k5wJl5xFQd54cnokL/QkLk+EtlJpvExCEuH0XZqoXo+cW5ZXAqV+e8zkZkWEYjL6d41t
         AYTQ6eCRN1tsaQSQBkIPvvI0+/uWRme6ynqMP49/XmKO+F1aNrGOIGoY9wXwVOxVDmoQ
         O/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786744666; x=1787349466;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q/erZy2n38i8Q19od1dHI45fS0KoMtthuq5RrnDN/Dg=;
        b=l59zKhyWJYEzWGgGH6dWiu2Ja/1mgCjRRyLKWL4u8moC45CcViJBI1jHNp9vxB9Rj1
         inBHhfLFPHiWznxGAJJL2VLpj6QuFzSZ3AarNkcrsQRoLY2/q2m0GOAd+s8lCfxFfF0f
         Q1x9+d1nO7vOx3hEW1mDPFpY0PEMeXGFEGyuk5olKw5rpI856AxInxuQ1si3UrKHQQIg
         DvIiSIk2gP0B6bPqAFs6eICuwOp2UvYeCiQvvittwDrxbHwv7M59wxU+Vi3IreXg8cQn
         AaFf7OtqML4WbW9mBXRoGNNZ2RMUW+CRNpkRCeVB8N2vWpJRULRZoR3ciVr5LXUwBGJw
         sWzQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpy8ckQrpTgfoQLwzjRGiNq/RgDsXmLye6LHXWmWFwb6uSWqAANsncTta1zkDIKFgFPUDO6Yg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDQWQ5OqZOe8s/vVkXhHbfESrDwrjHC3p9XoyePhFM1dOI4mRJ
	mLAFxsp0y0DEs3hfhzfs5xMrKui2t0654iFAhGR919ZM0ANnIVYWVZOZnK0/5NFtiyteO/Knoo2
	hO34Nqnb/c0kb8x5zVyiCbSkmGDSrOQE6RxGUJ1uD
X-Gm-Gg: AR+sD128ISdbAAsSwlB9lup5Azkk8QvuWRSqHT6fPfJ1eufdefFCCqfbdtopXOijwjT
	FOF0iXEc/K3i3sAnZszaFNFaeDUIaDybfVceFdz0E4xQ01zPERW9kbFpfRiYtjWsR++p12SAMYs
	B2vFmHZIldplMwSm7uO744QiVAfdKB4ZzFKhOYKplJLbqAj9UQ7/JcWCAudS+hDmb76pvJoK235
	RVso83XP43ug8gFbTMtZ2SXgj7rixUqIJ5LgXbZUXs+X+8rEnG2gbkgQNn8yCdrm8jeBNbEcgHW
	3/1AhOO0XLWx+8uk6tZetFaywZBkYcFjUzMBpwr3TB2TwDbUUqyE
X-Received: by 2002:ac8:5e4e:0:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-52d84770c21mr23823461cf.10.1786744665581; Fri, 14 Aug 2026
 14:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260804-iommu_contig_hint-v4-1-d7a47ed5db98@oss.qualcomm.com>
In-Reply-To: <20260804-iommu_contig_hint-v4-1-d7a47ed5db98@oss.qualcomm.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Fri, 14 Aug 2026 14:57:34 -0700
X-Gm-Features: AUfX_mw13XLnJC6leTXSRX-bWXhXBbTh-sh7eRo2QsAUaW0Ge3uaaXn1mQEwLlI
Message-ID: <CAE2F3rB7zpPFfC376mP=god9HWRmKOaQUEgPVzKScxS12pZrvQ@mail.gmail.com>
Subject: Re: [PATCH v4] iommu/io-pgtable-arm: Add support for contiguous hint bit
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 11:19=E2=80=AFPM Vijayanand Jitta
<vijayanand.jitta@oss.qualcomm.com> wrote:
> +static unsigned long arm_lpae_get_cont_sizes(struct io_pgtable_cfg *cfg)
> +{
> +       unsigned long pg_size, blk_size, l1_blk_size, cont_sizes =3D 0;
> +       unsigned long cont_leaf_size, cont_blk_size, cont_l1_blk_size;
> +       int pg_shift, bits_per_level;
> +
> +       if (!cfg->pgsize_bitmap || (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NO=
_CONT_HINT))
> +               return 0;
> +
> +       pg_shift =3D __ffs(cfg->pgsize_bitmap);
> +       bits_per_level =3D pg_shift - ilog2(sizeof(arm_lpae_iopte));
> +       pg_size =3D 1UL << pg_shift;
> +       blk_size =3D pg_size << bits_per_level;
> +       l1_blk_size =3D blk_size << bits_per_level;
> +
> +       cont_leaf_size =3D arm_lpae_num_cont(pg_size) * pg_size;
> +       if ((cfg->pgsize_bitmap & pg_size) &&
> +           arm_lpae_cont_size_fits(cfg, cont_leaf_size))
> +               cont_sizes |=3D cont_leaf_size;
> +
> +       if (cfg->pgsize_bitmap & blk_size) {
> +               cont_blk_size =3D arm_lpae_num_cont(blk_size) * blk_size;
> +               if (arm_lpae_cont_size_fits(cfg, cont_blk_size))
> +                       cont_sizes |=3D cont_blk_size;
> +       }
> +
> +       /*
> +        * l1_blk_size is only set in pgsize_bitmap if level-1 blocks are
> +        * supported for this granule (not 16K/64K, per
> +        * arm_lpae_restrict_pgsizes()), so no extra gating is needed her=
e.
> +        */
> +       if (cfg->pgsize_bitmap & l1_blk_size) {
> +               cont_l1_blk_size =3D arm_lpae_num_cont(l1_blk_size) * l1_=
blk_size;

Our AI model is saying that this might overflow cont_l1_blk_size on 32
bit platforms i.e. 16 * 1G doesn't fit into a 32 bit type. It says
that cont_l1_blk_size will be truncated to 0, and
arm_lpae_cont_size_fits() then calls ilog2(0) which is undefined.

> +               if (arm_lpae_cont_size_fits(cfg, cont_l1_blk_size))
> +                       cont_sizes |=3D cont_l1_blk_size;
> +       }
> +
> +       return cont_sizes;
> +}
[...]
> @@ -660,6 +829,8 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgt=
able *data,
>  {
>         arm_lpae_iopte pte;
>         struct io_pgtable *iop =3D &data->iop;
> +       size_t block_size =3D ARM_LPAE_BLOCK_SIZE(lvl, data);
> +       int num_cont =3D arm_lpae_num_cont(block_size);
>         int i =3D 0, num_entries, max_entries, unmap_idx_start;
>
>         /* Something went horribly wrong and we ran out of page table */
> @@ -674,10 +845,22 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_p=
gtable *data,
>                 return 0;
>         }
>
> +       /*
> +        * Normalize an exact whole-CONT-group request down to the
> +        * equivalent block_size/pgcount, mirroring __arm_lpae_map().
> +        */
> +       if (!(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT) &=
&
> +           num_cont > 1 && size =3D=3D block_size * num_cont) {
> +               pgcount *=3D num_cont;
> +               size =3D block_size;
> +       }
> +
>         /* If the size matches this level, we're in the right place */
> -       if (size =3D=3D ARM_LPAE_BLOCK_SIZE(lvl, data)) {
> +       if (size =3D=3D block_size) {
> +               size_t cont_size =3D num_cont * block_size;
> +
>                 max_entries =3D arm_lpae_max_entries(unmap_idx_start, dat=
a);
> -               num_entries =3D min_t(int, pgcount, max_entries);
> +               num_entries =3D min_t(size_t, pgcount, max_entries);
>
>                 /* Find and handle non-leaf entries */

This comment is no longer accurate. The handling now extends beyond
non-leaf entries.

>                 for (i =3D 0; i < num_entries; i++) {
> @@ -687,6 +870,40 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pg=
table *data,
>                                 break;
>                         }
>
> +                       /*
> +                        * A real CONT group must always be invalidated a=
s a
> +                        * unit, so reject an unmap that splits one. Chec=
k the
> +                        * PTE's own CONT bit rather than the caller's si=
ze,
> +                        * since a legitimate unmap can span multiple pri=
or
> +                        * iommu_map() calls and its size alone doesn't s=
ay how
> +                        * the underlying PTEs were grouped. Only the fir=
st and
> +                        * last entries can straddle a group boundary; an
> +                        * interior CONT-tagged entry's group is necessar=
ily
> +                        * fully covered by this unmap, since groups can'=
t
> +                        * overlap without also covering everything betwe=
en
> +                        * them.
> +                        */
> +                       if (pte & ARM_LPAE_PTE_CONT) {
> +                               bool ok =3D true;
> +
> +                               if (i =3D=3D 0)
> +                                       ok =3D ok && IS_ALIGNED(iova, con=
t_size);
> +                               if (i =3D=3D num_entries - 1)
> +                                       ok =3D ok && IS_ALIGNED(iova + (i=
 + 1) * block_size,
> +                                                             cont_size);
> +
> +                               /*
> +                                * Stop short of this entry instead of re=
turning
> +                                * 0: entries before i may already have h=
ad
> +                                * non-leaf sub-tables torn down above, s=
o the
> +                                * caller needs the real unmapped count, =
and the
> +                                * loop exit below still clears/gathers e=
ntries
> +                                * [0, i) correctly.
> +                                */
> +                               if (WARN_ON_ONCE(!ok))

Consider aligning with the following WARN_ONCE in the same function:

WARN_ONCE(true, "Unmap of a partial large IOPTE is not allowed");

> +                                       break;

I think this behavior is inconsistent: when a problem is detected at
the beginning of the unmap range, you return without modifying the
table, whereas if it's detected at the end, the code proceeds with
unmapping and leaves the table misconfigured. Could these checks be
performed before entering the loop?

> +                       }
> +
>                         if (!iopte_leaf(pte, lvl, iop->fmt)) {
>                                 __arm_lpae_clear_pte(&ptep[i], &iop->cfg,=
 1);
>
