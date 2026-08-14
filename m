Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8060D353A6E
	for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740352; cv=pass; b=MgxZNrAGxOwlVsSw/W+Ket2+iZBoZIl2yoteaI1m+8oQARcEW+3Jzp/qql/kaWgANiiFuT+7F/Ki2jE1KCdETfLmvNwTOiegDQn2FvGf8W62RunBztLhpA32sFtgEkX/rIkIwn94bPnjqXn0cmGFg1OtuvJS3tVxYL41uVGk+us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740352; c=relaxed/simple;
	bh=xWrd8PZWJsixg05es9DAonhAOJCzAB7wZrU+SCC2Vm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFbQywctMVsFFpa8+8HpTrEQJLvSTfn52y8BOON9O5z7b4JRwJZkP1doWOCMEAXmnNzo0zD/AUJnrVmBykZHAQKJeE5IKp8HPa1myNestA5ChbnKVO7uZqp90cpvMyS1lNfMSFp0XEc7ibLlvMo3I4CfGJx35hm4eN0Qjn4ULs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IqE9pqD3; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IqE9pqD3"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c10e86e52so336611cf.1
        for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 13:45:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786740348; cv=none;
        d=google.com; s=arc-20260327;
        b=RPeUk65iSZSVMgSk3yqWFJbwFdkzyrjOrFJAnMl8pQnvOENzBW6FOcXQW4DLKbNrbL
         5i/6M/DYUwbBPoyLslXYlw4NEOCTz9X8BSyy45/sam2zUjFUZ8/yFzkpNkUf07X2sI+c
         SXe2RKX2vnxILX9pTtiMgBBPdDwhJRDrW7y5hJK7pNl9Df3jVAhiGRQTYCItx5c0BxVH
         P7TWv5XaUsCNyaWGwvg3+bryqI3mM/zyMSVXp0VhzEyjFXbGrqlISy97rBDGkdRzKxVm
         0M90IHFUXWWyvCxpvaO6lERaQp2zpBLSRf/at/cNkrv3adH0alR1Z/POc3Jv9Jb6TLHS
         QSVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=at1k/9Z9ZhmcftbemOkXe7Ys6/+ROo6SJwW0LU1Rb54=;
        fh=PiNFGhF0gEx4AS3TxUFEC7KeIjGk7/BNiuCwYivkdww=;
        b=B4ywpjqm/C9TBNnOFWuIC0Oe1JmUXijfzp3Nzp2xCNLIEXqijJdq8YCM7WnU69w9O6
         ZzzWHrfEhm5J4fMpsJmqTGEmDmGC4CxbfixLiyGD3pq7zjddpffbo8vxLPCORGeS/mEi
         TwgfGWpNIgl2+Wbo85KNu5Z0boxUlHKkbEFPpES6SCfXiBhexV6gZgv5T+INefICyI6q
         iNHD6+qKNFlriUq29SE11TrruzO3l0jq/F2YXTpPT9AN0Wb8qwMwKP79tA9jdytejeFI
         /CUYyOfQtkCHMYaK91WYBOqbEGhHArvKdYEKyUDVwHmkn/ycVEbzGgXz/0G/5AT4N+qg
         ubOg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786740348; x=1787345148; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=at1k/9Z9ZhmcftbemOkXe7Ys6/+ROo6SJwW0LU1Rb54=;
        b=IqE9pqD3qAd3uvVATDdPwD2TP8Baw76OtAq29Af572kdf5PpQnteimgwEcPTtHLIIy
         2lIVr5Z40JAZZIniecZaNJT4T3L/XPopsYGtLODcPxL0yCjn5Z+hdZALZY8srArThbUZ
         ZnJArk658CI1OpXB6F5KTkCmEQ1KApIZSJjGVcNCahg9ogZmr+es2rivnE0eJCwa8WQt
         MFVQMlbPeOShoUGEYfo3ZnJBqvinFsVeSPtkNsQVYuGmofb/pudekV6eGfvPncLJJ6xS
         TGswgxAet5vQAkPtJI55x8/YAvZlodZvm9Wfm6Arfbg4VLQ1Xzws6SWxj5e1rrbQxJGn
         RwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786740348; x=1787345148;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=at1k/9Z9ZhmcftbemOkXe7Ys6/+ROo6SJwW0LU1Rb54=;
        b=ZOuGY9T9RcZ2+WF1IT9QGX+rwnUGSqEekRh/ABfi5t7hzvcwTIdX/THy6fOW7bkI1c
         5NYcyKjhugp19Tquft+TAPkHJ4WECvyZ1mMq384Y4iQ+5X1whC95nItjakDp0r27f4wU
         i9wEELbI/Hi4UZJYNdUIdorQTKRRyz14Gjsu7B1VGgtoBBkJ/q93KhIpjTf9A7UaKrBM
         vqKglvQSrD5VYlervFGYtLgk+xbOuOK5ft3aenTsgjmwSr2XCG9W/ZHHEfrbnPAF/wS0
         2MufRwlMszOo4aAqOZUhoMW/An1Ct8F9goYQWlwhamz8sCGU/F7B2bB7pgGkUG5EEhv3
         E9RA==
X-Forwarded-Encrypted: i=1; AHgh+RodUxqVr9IwIyYDajMUOygaSBVvcuwaP3x4XhElXW1bjVw5sCZLUGvgxfDDnn8eVeBaAMOlfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMOIZHZGUiNZ0/tQxR5fclkoM6DzOX2JdaHYhTjQ1YKlW+fkwY
	WrhzOt/6S3K56olbzdz7zbcFTvdCHGKKRL7tU2pQSvH8RRBINsYngn18kBH5IyAuJT8fgU+az7M
	w0nek01S9uPj9kkvr5jE9TL14t/7y5UIH2/cBwfyW
X-Gm-Gg: AR+sD11xSEYiIVwjDdserjFG2jIhZOWFnBJfO4Kq3P5b2LtBgI7qqWzF46f6hBxUl25
	62ajC2tw0rowNRmcPd2iVbPw9tWO2gHkVP8Tl2XWNftXSa6dHlRLgTudxwxYozNgCdj5tJyxdoy
	KJ1sDUfS2izFthiT51oKOPbMoaPIGS5F2y9hmAKJdQkucn116u+UQR31XHUk3H4sO8wmWL0uLW1
	56Zl+f1MNWaoYcRDkh9+FPMVJSZwJZhswcpkP51L3Gh8ylk2m6VDrpUXByRn97TYESIYMPU+ry2
	dGESyG1L8NKCo09s6+JsGXTZxM4zMSfJmRNBy9M8jQ==
X-Received: by 2002:a05:622a:620b:b0:527:f08f:56a2 with SMTP id
 d75a77b69052e-52d845c09f5mr27121721cf.8.1786740347730; Fri, 14 Aug 2026
 13:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260804-iommu_contig_hint-v4-1-d7a47ed5db98@oss.qualcomm.com>
 <CAE2F3rBQQEHsksOyE2ojQPbMd_vvFqaFMC2RzT0B6KkxMB5YgQ@mail.gmail.com> <c84e61b1-785e-4a47-9082-c5111bf35fd4@oss.qualcomm.com>
In-Reply-To: <c84e61b1-785e-4a47-9082-c5111bf35fd4@oss.qualcomm.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Fri, 14 Aug 2026 13:45:36 -0700
X-Gm-Features: AUfX_mw7BuTuxcGh8LnvM7gYfz3LaE3KvKBdBRwSQq9-7IAPRVvGMYyqokzfJAo
Message-ID: <CAE2F3rC80=ZpiHVtmRDU6f8g4AwV_RrJ-Zqr0Xi7zbUc0fsQog@mail.gmail.com>
Subject: Re: [PATCH v4] iommu/io-pgtable-arm: Add support for contiguous hint bit
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: Prakash Gupta <prakash.gupta@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 11:13=E2=80=AFPM Vijayanand Jitta
<vijayanand.jitta@oss.qualcomm.com> wrote:
>
>
>
> On 8/11/2026 10:34 AM, Daniel Mentz wrote:
> > On Mon, Aug 3, 2026 at 11:19=E2=80=AFPM Vijayanand Jitta
> > <vijayanand.jitta@oss.qualcomm.com> wrote:
> >> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable=
-arm.c
> >> index 476c0e25631af..23a238de53ed5 100644
> >> --- a/drivers/iommu/io-pgtable-arm.c
> >> +++ b/drivers/iommu/io-pgtable-arm.c
> >> [...]
> >> +static unsigned long arm_lpae_get_cont_sizes(struct io_pgtable_cfg *c=
fg)

I'm wondering if we need this function at all. I'm trying to
understand that would happen if we advertise page sizes that cannot
possibly be used given the constraints imposed by cfg->ias and
cfg->oas.
arm_lpae_read_and_clear_dirty() appears to check if the end of the
iova range is out-of-bounds (WARN_ON((iova + size - 1) &
~(BIT(cfg->ias) - 1))), but function arm_lpae_map_pages() appears to
not have such a check.

If we need to restrict the "cont sizes", we could consider Will's
suggestion: Add all the sizes to cfg->pgsize_bitmap in
arm_lpae_restrict_pgsizes, and then subsequently clamp it like so

cfg->pgsize_bitmap &=3D (BIT(cfg->ias) - 1))
cfg->pgsize_bitmap &=3D (BIT(cfg->oas) - 1))

That would be shorter than the 39-line arm_lpae_get_cont_sizes function.

> >> +/*
> >> + * Install num_entries leaf entries starting at ptep (index map_idx_s=
tart
> >> + * within the current table), tagging arm_lpae_num_cont()-sized group=
s with
> >> + * the contiguous hint where both idx and paddr are aligned to the gr=
oup
> >> + * size. Entries in a misaligned group are installed without the hint=
.
> >> + *
> >> + * idx and paddr both advance by block_size per entry, so their align=
ment
> >> + * relative to the group size is invariant across a run of entries wi=
thin
> >> + * this call: once a group qualifies (or fails to), every later whole=
 group
> >> + * does too, up to num_entries. This merges each such run into a sing=
le
> >> + * arm_lpae_init_pte() call instead of one call per group.
> >> + */
> >
> > Can you provide an example for when this function installs descriptors
> > where the contiguous bit is only set on a subset of them. I would
> > assume that the contiguous bit is either set for all descriptors or
> > none of them.
> >
>
> That assumption doesn't hold in general -- it's only true when the
> map request happens to start and end on a cont_size boundary. For an
> arbitrary map_pages() call it usually doesn't.

I believe you won't see arbitrary map_pages() calls. I understand that
these calls are exclusively coming from __iommu_map_domain_pgtbl()
which uses iommu_pgsize() to determine optimal page sizes.

> Example, 4K granule (num_cont =3D 16, cont_size =3D 64K),
> iova =3D paddr =3D 0x1000, pgcount =3D 34:
>
>    - idx 1..15  (off !=3D 0, misaligned prefix):        installed plain
>    - idx 16..31 (off =3D=3D 0, paddr now 64K-aligned):     installed w/ C=
ONT
>    - idx 32..34 (off =3D=3D 0, remaining < num_cont):      installed plai=
n

In the example you provided, I expect that you'll receive three
separate calls from __iommu_map_domain_pgtbl:
 * idx 1..15 with pgsize 4KB
 * one call with pgsize 64KB
 * idx 32..34 with pgsize 4KB

If I took your argument further, I could argue that we'd also have to
check if we can put down a block mapping if iova =3D paddr =3D 0x0 and
pgcount =3D 512, but we're not doing that either.

Could you provide the input parameters to the iommu_map() call that
resulted in the parameters you provided i.e. iova =3D paddr =3D 0x1000,
pgcount =3D 34:

>
> One arm_lpae_install_leaf() call, three chunks, CONT set on only the
> middle one.
>
> >> +static int arm_lpae_install_leaf(struct arm_lpae_io_pgtable *data,
> >> +                                unsigned long iova, phys_addr_t paddr=
,
> >> +                                arm_lpae_iopte prot, int lvl,
> >> +                                int map_idx_start, int num_entries, i=
nt num_cont,
> >> +                                arm_lpae_iopte *ptep, size_t *mapped)
> >> +{
> >> +       size_t block_size =3D ARM_LPAE_BLOCK_SIZE(lvl, data);
> >> +       size_t cont_size =3D num_cont * block_size;
> >> +       int done =3D 0;
> >> +
> >> +       while (done < num_entries) {
> >> +               int idx =3D map_idx_start + done;
> >> +               int remaining =3D num_entries - done;
> >> +               int off =3D idx % num_cont;
> >> +               arm_lpae_iopte pte =3D prot;
> >> +               int chunk, ret;
> >> +
> >> +               if (off) {
> >> +                       /* Misaligned prefix: advance to the next boun=
dary */
> >> +                       chunk =3D min_t(int, num_cont - off, remaining=
);
> >> +               } else if (remaining >=3D num_cont && IS_ALIGNED(paddr=
, cont_size)) {
> >> +                       /* Aligned: merge every full group in this run=
 */
> >> +                       chunk =3D remaining - remaining % num_cont;
> >> +                       pte |=3D ARM_LPAE_PTE_CONT;
> >> +               } else {
> >> +                       /*
> >> +                        * Aligned idx but paddr doesn't line up with =
cont_size,
> >> +                        * or too short for a full group. That holds f=
or the
> >> +                        * rest of this call too, so install the remai=
nder
> >> +                        * plain in one go.
> >> +                        */
> >> +                       chunk =3D remaining;
> >> +               }
> >> +
> >> +               ret =3D arm_lpae_init_pte(data, iova, paddr, pte, lvl,=
 chunk, ptep);
> >> +               if (ret)
> >> +                       return ret;
> >> +
> >> +               *mapped +=3D chunk * block_size;
> >> +               ptep +=3D chunk;
> >> +               iova +=3D chunk * block_size;
> >> +               paddr +=3D chunk * block_size;
> >> +               done +=3D chunk;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>  static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned =
long iova,
> >>                           phys_addr_t paddr, size_t size, size_t pgcou=
nt,
> >>                           arm_lpae_iopte prot, int lvl, arm_lpae_iopte=
 *ptep,
> >> @@ -462,21 +608,44 @@ static int __arm_lpae_map(struct arm_lpae_io_pgt=
able *data, unsigned long iova,
> >>         size_t block_size =3D ARM_LPAE_BLOCK_SIZE(lvl, data);
> >>         size_t tblsz =3D ARM_LPAE_GRANULE(data);
> >>         struct io_pgtable_cfg *cfg =3D &data->iop.cfg;
> >> -       int ret =3D 0, num_entries, max_entries, map_idx_start;
> >> +       bool cont_hint_enabled =3D !(cfg->quirks & IO_PGTABLE_QUIRK_AR=
M_NO_CONT_HINT);
> >> +       int num_entries, max_entries, map_idx_start;
> >> +       int num_cont =3D cont_hint_enabled ? arm_lpae_num_cont(block_s=
ize) : 1;
> >> +       bool use_cont =3D cont_hint_enabled && num_cont > 1;
> >>
> >>         /* Find our entry at the current level */
> >>         map_idx_start =3D ARM_LPAE_LVL_IDX(iova, lvl, data);
> >>         ptep +=3D map_idx_start;
> >>
> >> +       /*
> >> +        * Normalize an exact whole-CONT-group request down to the
> >> +        * equivalent block_size/pgcount so it funnels through the sam=
e
> >> +        * leaf path below. arm_lpae_install_leaf() independently deci=
des,
> >> +        * per sub-chunk, whether the CONT hint actually applies.
> >> +        */
> >> +       if (use_cont && size =3D=3D block_size * num_cont) {
> >> +               pgcount *=3D num_cont;
> >> +               size =3D block_size;
> >
> > This appears to me as if you're throwing away information about
> > whether this mapping request is suitable for the contiguous bit, and
> > then in arm_lpae_install_leaf(), you're trying to recover that
> > information. Can't you just do "prot |=3DARM_LPAE_PTE_CONT" here and
> > then completely avoid the logic in arm_lpae_install_leaf?
> >
>
> That optimization only applies to the exact-whole-group case already
> handled above (size =3D=3D block_size * num_cont). A single map_pages()
> call can also cover the general case shown above, where a misaligned
> prefix/suffix surrounds one or more aligned groups within the same
> call. Setting prot |=3D ARM_LPAE_PTE_CONT unconditionally here would
> incorrectly tag those misaligned entries with the hint.

Due to how __iommu_map_domain_pgtbl and iommu_pgsize operate, I don't
expect to see the prefixes and suffixes that you are describing.
Instead, I expect we'll see separate calls to __arm_lpae_map(): One
for the prefix, one for the set of aligned groups and another one for
the suffix.

>
> arm_lpae_install_leaf()'s off/remaining logic is what detects those
> group boundaries per chunk, so I don't think we can drop it in favor
> of always setting prot |=3D CONT at this call site. The size =3D=3D
> block_size * num_cont check here is just a fast path for the common
> whole-group case, avoiding a walk through install_leaf() for something
> the caller has already told us.
>
