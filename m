Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5F3B19D1
	for <iommu@lists.linux.dev>; Fri, 19 Jun 2026 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781898058; cv=pass; b=ssj1mPmq7NVwW9BemaR4kv3ih1N/oa5HDK6vwOVsJwYqD1XvgaJMcrM4kHDQERyzuj+kIaA/XjEJVvBZ72f3RwyN3++fJp8mZHBID49QQMwj4qFp8lZbNlpOlioAiFm03tUehY+EulXVKbvnUHR0Q7Fk2/A8STt3640oDuZYsSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781898058; c=relaxed/simple;
	bh=urugoTsq/yWR4pligPKsz1qk3EaXU6x5HOdKG2W4ADM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvuWM/hrdsY/YMHF7Xor4aHREARPJJCVV3H8W0AHlMC45YP9sJa5Pzcz4zlHEGKe3/87I44/7tXsD3p6aEeyauxU74g9WOnaAxRs0n1+MM5W/utRSYelMub/WCy3wyoJHYp6hdDqOea+HQ1SzeBNI5bgCFnHDbqicAsG9tsn+YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PmSBcO1W; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PmSBcO1W"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51765331535so279251cf.1
        for <iommu@lists.linux.dev>; Fri, 19 Jun 2026 12:40:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781898055; cv=none;
        d=google.com; s=arc-20260327;
        b=FxNrwa/LMokKnjESvQrPB8ELXavJVdSfDa7sUVbwOQmDLUE1LOnc2TWwnEc04U0mze
         GfluWLnOlzliD1FiouXsVmq+n7JD7o+ksjUi47UhwMbWBxYuxWiAdDUqHrB6hUwjFQyM
         qFBAJrg1L7s+vagKSJWHD8XHnLRWu5xukE6zGkEfd0T+eJUdtVSETPmRLzu1DbwoXpWG
         bh66IIQO+aKj9/XQTWhj36zQId3ET1Xmm3Y6Yqua8Byd1pOfrHQtZOYVPjPvvP7g3ACD
         74HEAScT/ydvX2+hqTIGqB9h5T0kFM9fd6/Hu9YQW4ZdUwRSGAyzB+uGQuAf5mTOR1bT
         ELTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dJE6cIYV1OOaFfhZSUjqsaXExfjdxdplzfZm/ifnrlk=;
        fh=r19eagKGdesd/4F6vRrMYcAcAj5GmZpkn2mHM+Ovkz4=;
        b=RipL2MLZMwk7VWaTaYZVN3O/VKquYYjGhHAoN+lGyIkoobedlWgNRpMQkJxpJuiK8h
         CVGPBu7ENes0J1mYhg96zYZOISdmZyzJJ4Pi/N4rlM6PXRcO5dJazArS8k6yxHHkT8j+
         15LDA3lumfFU/ODRr7qMhdQJeVhWQmssw5JAgoiXnpzhrGsdMPj/0LVuBhlWZa1N3cRV
         svKH06Wukt1CBQWFQ4t6XkpkpaAtT6p0OOQytvqBNwr1EnKDbt8ThTETPi2KvUMnO9aV
         TkIxuc0sPslVDMIu5jwlPUboIE/HSezL+M5yNO6fXk1rFlTjODKGzZtAXbi+JEYQKfTA
         Swww==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781898055; x=1782502855; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dJE6cIYV1OOaFfhZSUjqsaXExfjdxdplzfZm/ifnrlk=;
        b=PmSBcO1WmLzh17SN2zuExVbaJX8updoSzuAGP7E9zFa9Bl/BRLmsyxEUl9zixNXZQx
         ROSRngfzJ9toHbhJX0HmgERhOkr6wgSOq5Jkd51mm017OsB35MPisSSXP3RHkq9DPnIk
         BiYLkFryB/4oCHwf+1wkKs128A45QJwx8fow7FLZVKSCDPcc/tpag9Osrt9/NU9NdPbC
         +VO4xKzGwTKthn4D1S5RPb4kyPyLJl0sfN9qIO1S2MrFJVIlCUPzVs+i7PjVFMcAugfz
         CSkDK39hS1Uyb8Lqg/BJ3brgFAM7E9dm+WHf6xXCOm81l3/oxhflfWHUxy5hY96FmhfB
         y0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781898055; x=1782502855;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dJE6cIYV1OOaFfhZSUjqsaXExfjdxdplzfZm/ifnrlk=;
        b=R022hqFkKu+jeIo1nHUpq1VRr8k6rFdQ2lNCC46SC0iEG9rdA/mUlODqCOGcREvuY6
         9Lixx8yu4VrhIEJyH+YJn06m8DoEzB05w0lLd937TpeHrBl92qKPKK2J++1O05Qsmtlh
         If4eMyLOOH98lh5du/VZb/8Un6Y8LfA66wtoIE7QcdopMY1b5KMLcc4pOtIRa3/YJEwu
         cUEqnpKggk9YTse3hATIPs9dE4GBhVO7nBJ915Dbr6noQdz6a/KIcQoxhxkDRVfYd2Y7
         fhj8UUyi2m7WEaECDQzp9glkEOMkDJAArOqjYyBnwn5U0QTJwu7w8o67hltoYxtS/fAP
         GuZA==
X-Forwarded-Encrypted: i=1; AFNElJ83s8FssycmTafm4/3h41cOZk8NWVFAveeY2wsxgkQ4HHKz0rB/R2Wb1dJmCxpJ4Ws1oTEiVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDAUHs+3HDFq+ktOf/MVsLaI3tdeFGWr6n2B0VwOoM2NrQUPIk
	ICECR9CYxMxmC5pmayjOBdhxEYVVdS3lUelcDuV2KwH3Ug1uonHUU7CREXnpAIXxPpbRs8EYgKS
	P/wGKtIuMYwggyZKyCrJ/IVJK0iACzo6hcpoYsGTa
X-Gm-Gg: AfdE7cnIZSWyQYnhKEHnQa16m7FH0O/7Ln/MdR5VXBlFJHsELp0UdctIojKCU8oYKFj
	BPwHYMLVk/FU3Iv+XmIPtWwglN/ArZKZPtpTcfVmtbN0D4jJhkAtIkaLlKBKCL4odyCZCkC6h98
	hIqkwS/un/br7U3sqDqwztiZ3ME4CNvzXZDWxz7kKpxJNxCny0Diojcft364zt3fyMTdetLAx93
	ZUt8RaU+cdDLqyJqHtnMBDM012F/GH6VbuNoa4fchyeztuFzJ4qNhkawxunlqMjBYOnJA==
X-Received: by 2002:a05:622a:11c5:b0:516:ccc0:ee38 with SMTP id
 d75a77b69052e-519e891bc2bmr8238871cf.9.1781898053871; Fri, 19 Jun 2026
 12:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260618-iommu_contig_hint-v1-1-4502a59e6388@oss.qualcomm.com>
In-Reply-To: <20260618-iommu_contig_hint-v1-1-4502a59e6388@oss.qualcomm.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Fri, 19 Jun 2026 12:40:41 -0700
X-Gm-Features: AVVi8CfGMSn6U3ZYxuzVWyR1AQuFNJS8d4-0Q4Dfsm2iT6SBHKVnQMNx3er3cMg
Message-ID: <CAE2F3rABU2_d+e+NuFJ3ngDCEnGuVCsmE612V9RAKmyAX-R9Mw@mail.gmail.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Add support for contiguous hint bit
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 2:06=E2=80=AFAM Vijayanand Jitta
<vijayanand.jitta@oss.qualcomm.com> wrote:
> Support is gated behind CONFIG_IOMMU_IO_PGTABLE_CONTIG_HINT, which
> provides a compile-time opt-out for hardware affected by SMMU errata
> related to the contiguous bit.

Have you considered making this a runtime option? Compare this with
arm_smmu_device_iidr_probe() where the smmuv3 driver disables certain
features based on the identified implementation and the errata
affecting that implementation.

> On the mapping side, __arm_lpae_map() detects when the requested size
> matches a contiguous range at the next level, sets the CONT bit on all
> PTEs in the group, then recurses with the base block size and an
> adjusted pgcount.

I would perform this check at the current level not the previous
level. See comments below.

>
> On the unmapping side, the CONT bit is cleared from all PTEs in the
> affected contiguous group before any individual entry is invalidated,
> following the Break-Before-Make requirement of the architecture.

My understanding is that for unmap operations, the following rule applies:

The IOVA range targeted by an unmap operation must exactly match the
IOVA range of a previous map operation. Partial unmap operations are
not allowed.

The iopgtable code previously had a function named
arm_lpae_split_blk_unmap() which allowed a block mapping to be split
up. However, that function has since been removed, which aligns with
prohibiting partial unmaps.
The other concern I have is a potential race condition: While one
thread clears the contiguous bit, another thread could try to unmap
the same descriptor.

Consider dropping support for partial unmap and just triggering a
WARN_ON() if you detect that a contiguous group is partially unmapped.

> +static inline int arm_lpae_cont_pmds(unsigned long size)

PMD is not a term that is used in this file. I advise against
introducing this term.

> +static u32 arm_lpae_find_num_cont(struct arm_lpae_io_pgtable *data, int =
lvl)
> +{
> +       if (lvl =3D=3D ARM_LPAE_MAX_LEVELS - 2)
> +               return arm_lpae_cont_pmds(ARM_LPAE_BLOCK_SIZE(lvl, data))=
;
> +       else if (lvl =3D=3D ARM_LPAE_MAX_LEVELS - 1)
> +               return arm_lpae_cont_ptes(ARM_LPAE_BLOCK_SIZE(lvl, data))=
;

Consider supporting the contiguous bit at lookup level 1.

>  static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned lon=
g iova,
>                           phys_addr_t paddr, size_t size, size_t pgcount,
>                           arm_lpae_iopte prot, int lvl, arm_lpae_iopte *p=
tep,
> @@ -463,6 +583,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable =
*data, unsigned long iova,
>         size_t tblsz =3D ARM_LPAE_GRANULE(data);
>         struct io_pgtable_cfg *cfg =3D &data->iop.cfg;
>         int ret =3D 0, num_entries, max_entries, map_idx_start;
> +       u32 num_cont =3D 1;
>
>         /* Find our entry at the current level */
>         map_idx_start =3D ARM_LPAE_LVL_IDX(iova, lvl, data);
> @@ -505,6 +626,24 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable=
 *data, unsigned long iova,
>                 return -EEXIST;
>         }
>
> +       if (arm_lpae_pte_is_contiguous_range(data, size, lvl + 1, &num_co=
nt)) {

I would recommend performing this check at the actual level not at the
previous lookup level i.e. not at the (lvl - 1) level. Imagine the
following situation: The granule size is 4KB, the initial lookup level
is 2, and size is 32MB. I'm wondering if in that case, it'll just keep
recursing until it hits (WARN_ON(lvl >=3D ARM_LPAE_MAX_LEVELS - 1)).

> +#ifdef CONFIG_IOMMU_IO_PGTABLE_CONTIG_HINT
> +static void arm_lpae_cont_clear(struct arm_lpae_io_pgtable *data,
> +                               unsigned long iova, int lvl,
> +                               arm_lpae_iopte *ptep, size_t num_entries)
> +{
> +       struct io_pgtable_cfg *cfg =3D &data->iop.cfg;
> +       u32 num_cont =3D arm_lpae_find_num_cont(data, lvl);
> +       arm_lpae_iopte *cont_ptep;
> +       arm_lpae_iopte *cont_ptep_start;
> +       unsigned long cont_iova;
> +       int offset, itr;
> +
> +       cont_ptep =3D ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
> +       cont_iova =3D round_down(iova,
> +                              ARM_LPAE_BLOCK_SIZE(lvl, data) * num_cont)=
;

As a result of this round_down() function, you are accessing a
descriptor that describes an IOVA outside the range targeted by the
iommu_unmap call. Consequently, you might race against another thread
accessing the same descriptor.

> +       cont_ptep +=3D ARM_LPAE_LVL_IDX(cont_iova, lvl, data);
> +       cont_ptep_start =3D cont_ptep;
> +
> +       /*
> +        * iova may not be aligned to the contiguous group boundary; incl=
ude
> +        * any leading entries so round_up() covers all overlapping group=
s.
> +        */
> +       offset =3D ARM_LPAE_LVL_IDX(iova, lvl, data) -
> +                ARM_LPAE_LVL_IDX(cont_iova, lvl, data);
> +       num_entries =3D round_up(offset + num_entries, num_cont);
> +
> +       for (itr =3D 0; itr < num_entries; itr++) {
> +               WRITE_ONCE(*cont_ptep, READ_ONCE(*cont_ptep) & ~ARM_LPAE_=
PTE_CONT);

This read-modify-write operation is not safe due to the potential race
described above.

> +               cont_ptep++;
> +       }
> +
> +       if (!cfg->coherent_walk)
> +               __arm_lpae_sync_pte(cont_ptep_start, num_entries, cfg);
> +}
> +#else
> +static void arm_lpae_cont_clear(struct arm_lpae_io_pgtable *data,
> +                               unsigned long iova, int lvl,
> +                               arm_lpae_iopte *ptep, size_t num_entries)
> +{
> +}
> +#endif
> +
>  static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>                                struct iommu_iotlb_gather *gather,
>                                unsigned long iova, size_t size, size_t pg=
count,
> @@ -660,7 +841,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgt=
able *data,
>  {
>         arm_lpae_iopte pte;
>         struct io_pgtable *iop =3D &data->iop;
> -       int i =3D 0, num_entries, max_entries, unmap_idx_start;
> +       int i =3D 0, num_cont =3D 1, num_entries, max_entries, unmap_idx_=
start;
>
>         /* Something went horribly wrong and we ran out of page table */
>         if (WARN_ON(lvl =3D=3D ARM_LPAE_MAX_LEVELS))
> @@ -675,9 +856,15 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pg=
table *data,
>         }
>
>         /* If the size matches this level, we're in the right place */
> -       if (size =3D=3D ARM_LPAE_BLOCK_SIZE(lvl, data)) {
> +       if (size =3D=3D ARM_LPAE_BLOCK_SIZE(lvl, data) ||
> +           (size =3D=3D arm_lpae_find_num_cont(data, lvl) *
> +                    ARM_LPAE_BLOCK_SIZE(lvl, data))) {
> +               size_t pte_size;
> +
>                 max_entries =3D arm_lpae_max_entries(unmap_idx_start, dat=
a);
> -               num_entries =3D min_t(int, pgcount, max_entries);
> +               num_cont =3D arm_lpae_check_num_cont(data, size, lvl);
> +               num_entries =3D min_t(int, num_cont * pgcount, max_entrie=
s);
> +               pte_size =3D size / num_cont;
>
>                 /* Find and handle non-leaf entries */
>                 for (i =3D 0; i < num_entries; i++) {
> @@ -687,11 +874,27 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_p=
gtable *data,
>                                 break;
>                         }
>
> +                       /*
> +                        * Break-Before-Make: before invalidating any lea=
f
> +                        * entry, clear the CONT bit from every entry in =
the
> +                        * contiguous group(s) and flush the TLB, as requ=
ired
> +                        * by the architecture.  arm_lpae_cont_clear() co=
vers
> +                        * the full [iova, iova + num_entries * pte_size)=
 range
> +                        * via round_up(), so subsequent entries read bac=
k
> +                        * CONT=3D0 and skip this block.
> +                        */
> +                       if (pte & ARM_LPAE_PTE_CONT) {
> +                               arm_lpae_cont_clear(data, iova, lvl, ptep=
, num_entries);
> +                               io_pgtable_tlb_flush_walk(iop, iova,
> +                                                         num_entries * p=
te_size,
> +                                                         ARM_LPAE_GRANUL=
E(data));

I believe this is inefficient. Consider the case where we unmap 2MB
worth of IOVA space mapped by 512 4KB page descriptors with the
contiguous bit set. If I'm not mistaken, you're running CMOs
(__arm_lpae_sync_pte) twice for every page descriptor. In addition,
io_pgtable_tlb_flush_walk() will submit an extra CMD_SYNC and wait for
it's completion.

Additionally, you perform rounding in arm_lpae_cont_clear(). However,
io_pgtable_tlb_flush_walk() is called on the original, potentially
unaligned range. Can this lead to under invalidation? Again, my
preference would be to drop support for partial unmaps which would
also remove the requirement for calling io_pgtable_tlb_flush_walk()
here.

> +                       }
> +
>                         if (!iopte_leaf(pte, lvl, iop->fmt)) {
>                                 __arm_lpae_clear_pte(&ptep[i], &iop->cfg,=
 1);
>
>                                 /* Also flush any partial walks */
> -                               io_pgtable_tlb_flush_walk(iop, iova + i *=
 size, size,
> +                               io_pgtable_tlb_flush_walk(iop, iova + i *=
 pte_size, pte_size,
>                                                           ARM_LPAE_GRANUL=
E(data));
>                                 __arm_lpae_free_pgtable(data, lvl + 1, io=
pte_deref(pte, data));
>                         }
