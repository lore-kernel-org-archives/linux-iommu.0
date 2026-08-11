Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18841313277
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 05:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786424675; cv=pass; b=f0vPbjuI1Z48Z9UCLMPiBzm48KBOyToaBRGv+xgAP2uqDx+82FsAm40FRMNq4PIBtJPdn2ETqombM/4lBGT21Lfgy3jrOd/+HE0iIoHGde4w7vSgOAsy+i/udcRDgHW5OC8ypyHK12ITD7gwoarvU6dOhIhy5lv3KArEUSdW+b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786424675; c=relaxed/simple;
	bh=PpQISvKwrciqTF1aWbKrFW+wu2fSy/bok9YASZzXAhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAjXJpm6YtH68KVuNglhIm9/AqjlkeUoOIz/DZjrHKh+ZxRXtp5/85yt4i7nLx6Oq5DkkP8lEnRRe5VYavFxnHb/ZSkURGmbQF0X43J6EVuZKz2aOqDFDr5pq4ruN4hrKH90oNWNl4IXMufUGN47+TOZkdG3il0mQCzJFyNr+PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uNIC13cE; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uNIC13cE"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c10ed63c0so103011cf.1
        for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 22:04:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786424673; cv=none;
        d=google.com; s=arc-20260327;
        b=hKZ7rRS75oFoZNL5+Btwz+ymoNUp+uOe8jNlGT3zcI+qQTnpB5lEdIKi4cFpjll0YO
         0Mbvp/lEXhYmnsvduimX9sr2TGiVsifvI2Ro28FDVEUojdPv4hgO2hMorxfMDfayjNiD
         4GwIhF/wPWR/3g90oh1wP8WpdUKRtwl06a4yXIdoSa8dq1lGFvBpGq2BM73pw8TdUKCA
         axPKELsV6cRxZ6cXEZw6WwT+ZEDHaXwyf+1G17FWxscjtNVuQ0AuvchqrWeBWwVvElX9
         79pPXc7vFisb1aLAR+I82oimxosrdkKvy9RqT8WdRiBflrwjjY+OfAcxP8Pt0MoKzrBJ
         Tb9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l0Kj0yc9XxyPL81uujyygKc80rtEnUflq8odLifFS04=;
        fh=+wUQp4AxJq/irU8rZi1jDEHbV/HPxNC2Da4a84pvs9s=;
        b=De/4oAw1yB5+cneltYucj/wUxTVFJLfT3czR5unTjyIwLlnZS0bfPUPBaRKm1hOU3K
         42ER8FjIZGpHAKJ6iBubesyeY0pz30lzJerl7/lD5JCSHLfFSYgLSQ6GwA4JT/o1uvOK
         fZo4xXOwL+DCrttKmzrCcY363pcWUF5863iREQYO4Ql7Fx7dXLEc29PZ50qBf4RvIzjQ
         xc/plKa/KC0TYh2omIz1g/IinLVfddoGKp20JV7o0ffGY4xzKGWkdQq4MD7JfqdHe/5W
         OE+BCUJsATdyxD/77WCJ2pPGRVPMR1562XPdP3Lj41zR20AZlxCGFMFlkeHUBt5wB2Yd
         CF7A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786424673; x=1787029473; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l0Kj0yc9XxyPL81uujyygKc80rtEnUflq8odLifFS04=;
        b=uNIC13cEht87Q4yECso7xopmRuuYuctV2IRAvWTdTom6TT6yDWFDZ2Cq32TVQcooCx
         S/vCufLOyOymzwqptu/ZcnxUubUpRjOHjeMBDVfgZFBqFDOYhePbAc/8QPjF5h691Uk6
         1twg5C3SjafqFbnFkTMcuwuvWzFo2KqtGC/nMdbAO5cTw23KRCIu5EkgTbIwQrWPgmYS
         JkmZoOOHNNrWUMAwHO7UrnOROgNPgHNUSQ9L9RW442b5yriPe+AYVhkEgXwQQqFjliD3
         xMvdmqhtzuTqadsBs5zjP/GFpx04Ww4F16RTZDMsH8RF0k3Nug1Dz3tnfuQ5edEj9kx+
         oifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786424673; x=1787029473;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l0Kj0yc9XxyPL81uujyygKc80rtEnUflq8odLifFS04=;
        b=sdHJWHHBFGyvBrSO/VxNUv8uJHkA2Qw2fdUUA6v11/Ayh2wMMSCyng5PZ1orES85hI
         wJfDf/fr8fm1lGtKBdwH5JWt4cnBSRGDGvczVrPy3qBsGJHR8l59lFVi/hdPATyQqgCf
         ENWsMzyKjHXSnA7AtMBBbsBpQH/pqAyRMcMqR8vNV37Qc2uuVuM1ZM9FCyu3VS8iwL3x
         N3xl/7vWT5Dlw2oGdQ2Y8+7b257pjR/pqGFCnEXrsuhLYLAEneVv9i+YeapK+vtyf2PE
         Vnd5RVgGhSQt3Z9oMRr5vZaelBjrLNU6g+qiZRGMMV9Xsqr+N5zVHnjGKt81uIaM5rVy
         uNrQ==
X-Forwarded-Encrypted: i=1; AHgh+RoaeRzqnNDsc9rbuUm/wZk2C/sNfZiucB5hIlsyHT+Hfs3vmDWvbvqI9ygxjUVQStgyvGpX7w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCDFTMpnBsH5+K8GnbakYFp72LJGvR8KhF1ETAscvOIyH+oSb4
	UPVCvgiiM9X2mQC3d9einazD68Jc71i04yPTFbY8saPklZekmw6uqXlozdNRQdBqWXER3X6DAf2
	/WgahSc6O+YXywR/Jr8sKmp7mK6o3h3n0ds46seYY
X-Gm-Gg: AR+sD13nXgglbrkqyTtaxw3JnivxmZAox/k+mMSmywZHl0l58WBKPYjdHNsW+yqJdyp
	UPXZGAUQfBXYHh4Q/AgONI8d5qdEYcMH2nkjt44BxXPK6tMqhUIBKEL5pQ/AYmrhcYsOSgQFIJh
	1ZoPWfglqUFrTeP9YK5s1xtiD3Kpohi49dC7Zz9fJvzx70ZQRSuBtaf7UQqN55mGaboqp9qmOiv
	bBgi6KllG4hhLPFTwD+Myd+jD4LO6VPNXy2CIiwBy0RjjMhxGr2u3qdl+LnRHpip50rh7rqCt5T
	sG5Dpzf7XKDaKAYUXqFzipWbH8ns8WSpn4WxMfxY2Q==
X-Received: by 2002:ac8:7fc9:0:b0:51c:ca9:3d15 with SMTP id
 d75a77b69052e-52d58236f99mr2540931cf.12.1786424672376; Mon, 10 Aug 2026
 22:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260804-iommu_contig_hint-v4-1-d7a47ed5db98@oss.qualcomm.com>
In-Reply-To: <20260804-iommu_contig_hint-v4-1-d7a47ed5db98@oss.qualcomm.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Mon, 10 Aug 2026 22:04:20 -0700
X-Gm-Features: AUfX_mz1Q0EQxjJGjo9fyY36FF5Mbr8Jb4EcjiIK9bRp6c3Ih6EjCsTWhRnEfds
Message-ID: <CAE2F3rBQQEHsksOyE2ojQPbMd_vvFqaFMC2RzT0B6KkxMB5YgQ@mail.gmail.com>
Subject: Re: [PATCH v4] iommu/io-pgtable-arm: Add support for contiguous hint bit
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>, 
	Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 11:19=E2=80=AFPM Vijayanand Jitta
<vijayanand.jitta@oss.qualcomm.com> wrote:
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-ar=
m.c
> index 476c0e25631af..23a238de53ed5 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> [...]
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

bits_per_level is also calculated in arm_lpae_alloc_pgtable(). I'm
wondering if we can somehow re-use that value, although, I do
understand that data->bits_per_level is only populated later.

> +       pg_size =3D 1UL << pg_shift;

In arm_lpae_restrict_pgsizes(), they call the same value "granule".
Can we align with that and call it granule instead of pg_size?

> +       blk_size =3D pg_size << bits_per_level;

I'm wondering if we can re-use the macro ARM_LPAE_BLOCK_SIZE. I do
acknowledge, though, that this macro doesn't work in this context,
because (d)->bits_per_level is still not populated.
Also, for consistency, you might want to call this l2_blk_size.

> +       l1_blk_size =3D blk_size << bits_per_level;
> +
> +       cont_leaf_size =3D arm_lpae_num_cont(pg_size) * pg_size;
> +       if ((cfg->pgsize_bitmap & pg_size) &&

Is (cfg->pgsize_bitmap & pg_size) ever false?

[...]

> +/*
> + * Install num_entries leaf entries starting at ptep (index map_idx_star=
t
> + * within the current table), tagging arm_lpae_num_cont()-sized groups w=
ith
> + * the contiguous hint where both idx and paddr are aligned to the group
> + * size. Entries in a misaligned group are installed without the hint.
> + *
> + * idx and paddr both advance by block_size per entry, so their alignmen=
t
> + * relative to the group size is invariant across a run of entries withi=
n
> + * this call: once a group qualifies (or fails to), every later whole gr=
oup
> + * does too, up to num_entries. This merges each such run into a single
> + * arm_lpae_init_pte() call instead of one call per group.
> + */

Can you provide an example for when this function installs descriptors
where the contiguous bit is only set on a subset of them. I would
assume that the contiguous bit is either set for all descriptors or
none of them.

> +static int arm_lpae_install_leaf(struct arm_lpae_io_pgtable *data,
> +                                unsigned long iova, phys_addr_t paddr,
> +                                arm_lpae_iopte prot, int lvl,
> +                                int map_idx_start, int num_entries, int =
num_cont,
> +                                arm_lpae_iopte *ptep, size_t *mapped)
> +{
> +       size_t block_size =3D ARM_LPAE_BLOCK_SIZE(lvl, data);
> +       size_t cont_size =3D num_cont * block_size;
> +       int done =3D 0;
> +
> +       while (done < num_entries) {
> +               int idx =3D map_idx_start + done;
> +               int remaining =3D num_entries - done;
> +               int off =3D idx % num_cont;
> +               arm_lpae_iopte pte =3D prot;
> +               int chunk, ret;
> +
> +               if (off) {
> +                       /* Misaligned prefix: advance to the next boundar=
y */
> +                       chunk =3D min_t(int, num_cont - off, remaining);
> +               } else if (remaining >=3D num_cont && IS_ALIGNED(paddr, c=
ont_size)) {
> +                       /* Aligned: merge every full group in this run */
> +                       chunk =3D remaining - remaining % num_cont;
> +                       pte |=3D ARM_LPAE_PTE_CONT;
> +               } else {
> +                       /*
> +                        * Aligned idx but paddr doesn't line up with con=
t_size,
> +                        * or too short for a full group. That holds for =
the
> +                        * rest of this call too, so install the remainde=
r
> +                        * plain in one go.
> +                        */
> +                       chunk =3D remaining;
> +               }
> +
> +               ret =3D arm_lpae_init_pte(data, iova, paddr, pte, lvl, ch=
unk, ptep);
> +               if (ret)
> +                       return ret;
> +
> +               *mapped +=3D chunk * block_size;
> +               ptep +=3D chunk;
> +               iova +=3D chunk * block_size;
> +               paddr +=3D chunk * block_size;
> +               done +=3D chunk;
> +       }
> +
> +       return 0;
> +}
> +
>  static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned lon=
g iova,
>                           phys_addr_t paddr, size_t size, size_t pgcount,
>                           arm_lpae_iopte prot, int lvl, arm_lpae_iopte *p=
tep,
> @@ -462,21 +608,44 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtabl=
e *data, unsigned long iova,
>         size_t block_size =3D ARM_LPAE_BLOCK_SIZE(lvl, data);
>         size_t tblsz =3D ARM_LPAE_GRANULE(data);
>         struct io_pgtable_cfg *cfg =3D &data->iop.cfg;
> -       int ret =3D 0, num_entries, max_entries, map_idx_start;
> +       bool cont_hint_enabled =3D !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_N=
O_CONT_HINT);
> +       int num_entries, max_entries, map_idx_start;
> +       int num_cont =3D cont_hint_enabled ? arm_lpae_num_cont(block_size=
) : 1;
> +       bool use_cont =3D cont_hint_enabled && num_cont > 1;
>
>         /* Find our entry at the current level */
>         map_idx_start =3D ARM_LPAE_LVL_IDX(iova, lvl, data);
>         ptep +=3D map_idx_start;
>
> +       /*
> +        * Normalize an exact whole-CONT-group request down to the
> +        * equivalent block_size/pgcount so it funnels through the same
> +        * leaf path below. arm_lpae_install_leaf() independently decides=
,
> +        * per sub-chunk, whether the CONT hint actually applies.
> +        */
> +       if (use_cont && size =3D=3D block_size * num_cont) {
> +               pgcount *=3D num_cont;
> +               size =3D block_size;

This appears to me as if you're throwing away information about
whether this mapping request is suitable for the contiguous bit, and
then in arm_lpae_install_leaf(), you're trying to recover that
information. Can't you just do "prot |=3DARM_LPAE_PTE_CONT" here and
then completely avoid the logic in arm_lpae_install_leaf?

> +       }
> +
>         /* If we can install a leaf entry at this level, then do so */
>         if (size =3D=3D block_size) {
> +               int ret;
> +
>                 max_entries =3D arm_lpae_max_entries(map_idx_start, data)=
;
> -               num_entries =3D min_t(int, pgcount, max_entries);
> -               ret =3D arm_lpae_init_pte(data, iova, paddr, prot, lvl, n=
um_entries, ptep);
> -               if (!ret)
> -                       *mapped +=3D num_entries * size;
> +               num_entries =3D min_t(size_t, pgcount, max_entries);
>
> -               return ret;
> +               if (!use_cont) {
> +                       ret =3D arm_lpae_init_pte(data, iova, paddr, prot=
, lvl,
> +                                               num_entries, ptep);
> +                       if (!ret)
> +                               *mapped +=3D num_entries * size;
> +                       return ret;
> +               }
> +
> +               return arm_lpae_install_leaf(data, iova, paddr, prot, lvl=
,
> +                                            map_idx_start, num_entries,
> +                                            num_cont, ptep, mapped);
