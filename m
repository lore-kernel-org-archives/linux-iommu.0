Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B637713B58C
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759179623; cv=none; b=fWXycKd+MnxBYe/amjpYv/biTI1P9xr3WvSq904qi+Ek5hs8ceOjt30MDXGLzih9JqmTM7x0J+UL8t7Vq3aUotKfbISgonB7bQSuPFMaiQmx1PWpJRU36viCbJVes88CMOG5HhS1QMEIlRRiOE1cQU3IIUKLVbjbbinyfH/J18o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759179623; c=relaxed/simple;
	bh=B5dT1sx7pyVY13/Ois/NXMr5Sjxx8QH/Pe1nDwr2M2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLvbdUlHz2WIehzGn9hUbW5tH4uzzi137TPhsB/ggy3azX7tSfvgDET5WHZgPb+gMG48kZgKCyQNYVYktS/b3sFSb48/ZOWq2EOX23VTrhBcYIWhCe8q68PvY31ilV567+XPnmJ3Y8ge+rN17CF8PGXpboj8M8tgsVVw51SiLMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ckEcVzbV; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ckEcVzbV"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4de60f19a57so117331cf.0
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 14:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759179620; x=1759784420; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbk1KImMXIp7N8yUUQTD7fFEO8tjb/851I1iafEYnW0=;
        b=ckEcVzbV5a8Y39T1z9E8OD5J8pVYFkRCsmfRHekY8NbHKCeIl0JI6KXtseF2o4cacx
         CLzUGd8w1hoMpzAC1y6wvuWwbfaj/IOB6mw1yFNSTDRbWxkTN7jX69wFC84QThBgWqXX
         e5vC3dx2RS7PoFFWG1VdcIfFW5xXOEtraoQ0uvS05DyYpIU/MCLKMv6T8LIxfJ0wbNo+
         krIpeW6TVSinjFoSjp9B367GLlFykwLgGrxYTeqFrCX1tq8foJAVu+UTe6b9Clg1ZnGU
         KjztV/m0Eoi1Mbvv1d1vaycX4We2Nv1/eUa54/gPWCICfwz6zqN62cTxsAO1VTPZllC8
         x9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759179620; x=1759784420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbk1KImMXIp7N8yUUQTD7fFEO8tjb/851I1iafEYnW0=;
        b=sfXqZeAyl1b7gud2bKf9iyfnz1DFTkrYgAhemC2Y7ykv6FLSBVjx5t0VoVdTZ+xAkL
         0R6czQ4pFT/0d4qAX/IPx3i8CBygvP1iyOfPVVCaj+dN74X5PDcvjFz/ls/Uc7wTqPen
         kkbIfDBTHz6bHSqc3rFfJtJGMI195Ik9bE4njSLCDStMRfeg+kRjdeAgrMHu/X3+zELy
         3mDRxogCdOjkRhJgCjgbmcCpeGStbiu3s31Nhc381FMWGC93oqZ0jiblScTANdACuP0N
         MahPXejJL66g7uL4ia1V9AlGaLpS8sW4P4DtCRjEVppognNbX5cC87Jj2KRXRBNlTeHW
         rf/Q==
X-Gm-Message-State: AOJu0YyRJ0PDLpVSCsM0RIIlO023Pi9kmBXEqj7zvhFzMdg1ucxINUS9
	1M46zuU6ydgbcPW9UPTGLQKQAy4vIMIDXK3+5mAkRs/RZuQMXO7oMWNSqHC2towS45Pa1xQMOGd
	QlMAIrb6R+ToYZdmJePlRRHCiHHaiyo5Qsx1iH9La5PIkeodrKrfUxcDz8Ck=
X-Gm-Gg: ASbGncu2nB3WleiMsT6OrURsOcnxccCHAIhg+7VJR7dDgyrTDG59EtfoLlBg16z9nUQ
	+oK5SxThrs2pIYtLL4riafrix58Qatei61i7mx0oy2917+iQ/VAo8kZgDUcyOxApGBYDl46Bb+U
	pla5i0RaEIgfWR3xPG9EoWmSD5CvVXaAWuWGcvaB9efL2tGlLk3g5rb++YyvK8cJF7VhFbL0oyc
	+dNwXkDL/ys/yahU6k6fQ==
X-Google-Smtp-Source: AGHT+IHokwX5fRmkNeCL/hET5rdxYyVxkqfPVrcHDkBJjFzCza8A7qlg3rTXeCBFEaZR2+o+4pyi42QPfP6XgCVj74k=
X-Received: by 2002:a05:622a:1989:b0:4b3:8ee:521b with SMTP id
 d75a77b69052e-4e2cc20909dmr2170951cf.0.1759179619909; Mon, 29 Sep 2025
 14:00:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250927223953.936562-1-danielmentz@google.com> <aNp5sS7VpPirrRGE@google.com>
In-Reply-To: <aNp5sS7VpPirrRGE@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Mon, 29 Sep 2025 14:00:09 -0700
X-Gm-Features: AS18NWA78WxKA80awrDCIvHNQD34tuBXU3MG7OYkegRYB2xHdzZKH5hZKOFioAU
Message-ID: <CAE2F3rB6TYjy0a9yecW4zwBLraaj75YBafEz3DUh8zrLChnuCg@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/io-pgtable-arm: Implement .iotlb_sync_map callback
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Pranjal Shrivastava <praan@google.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Rob Clark <robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 5:21=E2=80=AFAM Mostafa Saleh <smostafa@google.com>=
 wrote:
>
> On Sat, Sep 27, 2025 at 10:39:52PM +0000, Daniel Mentz wrote:
> > On systems with a non-coherent SMMU, the CPU must perform cache
> > maintenance operations (CMOs) after updating page table entries (PTEs).
> > This ensures that the SMMU reads the latest version of the descriptors
> > and not stale data from memory.
> >
> > This requirement can lead to significant performance overhead,
> > especially when mapping long scatter-gather lists where each sg entry
> > maps into an iommu_map() call that only covers 4KB of address space.
> >
> > In such scenarios, each small mapping operation modifies a single 8-byt=
e
> > PTE but triggers a cache clean for the entire cache line (e.g., 64
> > bytes). This results in the same cache line being cleaned repeatedly,
> > once for each PTE it contains.
> >
> > A more efficient implementation performs the cache clean operation only
> > after updating all descriptors that are co-located in the same cache
> > line. This patch introduces a mechanism to defer and batch the cache
> > maintenance:
> >
> > A new boolean flag, defer_sync_pte, is added to struct io_pgtable_cfg.
> > When this flag is set, the arm-lpae backend will skip the cache sync
> > operation for leaf entries within its .map_pages implementation.
> >
> > A new callback, .iotlb_sync_map, is added to struct io_pgtable_ops.
> > After performing a series of mapping operations, the caller is
> > responsible for invoking this callback for the entire IOVA range. This
> > function then walks the page tables for the specified range and perform=
s
> > the necessary cache clean operations for all the modified PTEs.
> >
> > This allows for a single, efficient cache maintenance operation to cove=
r
> > multiple PTE updates, significantly reducing overhead for workloads tha=
t
> > perform many small, contiguous mappings.
> >
> > Signed-off-by: Daniel Mentz <danielmentz@google.com>
> > ---
> >  drivers/iommu/io-pgtable-arm.c | 66 +++++++++++++++++++++++++++++++++-
> >  include/linux/io-pgtable.h     |  7 ++++
> >  2 files changed, 72 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-=
arm.c
> > index 7e8e2216c294..a970eefb07fb 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -353,7 +353,7 @@ static void __arm_lpae_init_pte(struct arm_lpae_io_=
pgtable *data,
> >       for (i =3D 0; i < num_entries; i++)
> >               ptep[i] =3D pte | paddr_to_iopte(paddr + i * sz, data);
> >
> > -     if (!cfg->coherent_walk)
> > +     if (!cfg->coherent_walk && !cfg->defer_sync_pte)
> >               __arm_lpae_sync_pte(ptep, num_entries, cfg);
> >  }
> >
> > @@ -582,6 +582,69 @@ static int arm_lpae_map_pages(struct io_pgtable_op=
s *ops, unsigned long iova,
> >       return ret;
> >  }
> >
> > +static int __arm_lpae_iotlb_sync_map(struct arm_lpae_io_pgtable *data,=
 unsigned long iova,
> > +                           size_t size, int lvl, arm_lpae_iopte *ptep)
> > +{
> > +     struct io_pgtable *iop =3D &data->iop;
> > +     size_t block_size =3D ARM_LPAE_BLOCK_SIZE(lvl, data);
> > +     int ret =3D 0, num_entries, max_entries;
> > +     unsigned long iova_offset, sync_idx_start, sync_idx_end;
> > +     int i, shift, synced_entries =3D 0;
> > +
> > +     shift =3D (ARM_LPAE_LVL_SHIFT(lvl - 1, data) + ARM_LPAE_PGD_IDX(l=
vl - 1, data));
> > +     iova_offset =3D iova & ((1ULL << shift) - 1);
> > +     sync_idx_start =3D ARM_LPAE_LVL_IDX(iova, lvl, data);
> > +     sync_idx_end =3D (iova_offset + size + block_size - ARM_LPAE_GRAN=
ULE(data)) >>
> > +             ARM_LPAE_LVL_SHIFT(lvl, data);
> > +     max_entries =3D arm_lpae_max_entries(sync_idx_start, data);
> > +     num_entries =3D min_t(unsigned long, sync_idx_end - sync_idx_star=
t, max_entries);
> > +     ptep +=3D sync_idx_start;
> > +
> > +     if (lvl < (ARM_LPAE_MAX_LEVELS - 1)) {
> > +             for (i =3D 0; i < num_entries; i++) {
> > +                     arm_lpae_iopte pte =3D READ_ONCE(ptep[i]);
> > +                     unsigned long synced;
> > +
> > +                     WARN_ON(!pte);
> > +
> > +                     if (iopte_type(pte) =3D=3D ARM_LPAE_PTE_TYPE_TABL=
E) {
> > +                             int n =3D i - synced_entries;
> > +
> > +                             if (n) {
> > +                                     __arm_lpae_sync_pte(&ptep[synced_=
entries], n, &iop->cfg);
> > +                                     synced_entries +=3D n;
> > +                             }
> > +                             ret =3D __arm_lpae_iotlb_sync_map(data, i=
ova, size, lvl + 1,
> > +                                                             iopte_der=
ef(pte, data));
> > +                             synced_entries++;
> > +                     }
> > +                     synced =3D block_size - (iova & (block_size - 1))=
;
> > +                     size -=3D synced;
> > +                     iova +=3D synced;
> > +             }
> > +     }
> > +
> > +     if (synced_entries !=3D num_entries)
> > +             __arm_lpae_sync_pte(&ptep[synced_entries], num_entries - =
synced_entries, &iop->cfg);
> > +
> > +     return ret;
> > +}
>
> Can't we rely on the exisiting generic table walker "__arm_lpae_iopte_wal=
k",
> instead writing a new one, that is already used for iova_to_phys and dirt=
y bit.

The performance gains of .iotlb_sync_map are achieved by performing
CMOs on a range of descriptors as opposed to individually on each
descriptor in isolation. The function __arm_lpae_iopte_walk is
inherently incompatible with this, because it calls the .visit
callback once for each descriptor it finds in the specified range. I
guess I could work around this limitation by saving some state in
io_pgtable_walk_data and developing a .visit function that tries to
coalesce individual descriptors into contiguous ranges and delays CMOs
until it finds a break in continuity. I'm afraid, though, that that
might hurt performance significantly.
