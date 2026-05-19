Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EDA369999
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779215533; cv=pass; b=fWowjCnQ1cLqaQzMQzjTAQXEFbqRcd0HfH33nr0tfs+ZnS4t9vNw3Tg0W7Id209VrT2fZmNeQPPHsIMRNAwl1ux7xYb7fdh9s7I/y6AJJV8wh7tXrUqxB6rBUUBOL9mnEjE5pS1IB7kYpRjlXp1hbnRXoCQXKW9PrsG6N27Eosc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779215533; c=relaxed/simple;
	bh=A1+1c5Ic41LV08L6f5M38t1ajO6svyQkVJQNzArOpCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LczfPcZGuTf1KbndvIBC9WDhT4HlNovEBMxihWGvumCGdaitmqN6/1L2e8ZgvI2DebGUpV555Hs01uK0hGMSEiGuoomBFqiNx45qIhmvpIb2M1k8O5wtugg+aHJhB/FwlFdGRQqKCoHbUqioigL7IubCLxqrP1BEsQoPJaomt8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FiXFZ74a; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FiXFZ74a"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d864c23bdso10521cf.1
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 11:32:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779215531; cv=none;
        d=google.com; s=arc-20240605;
        b=ILYc8i5u+229Y8ULwo7T5XxzhkJ/dbi+1wAFQxM0390v23GwYWbiXfHXvIH/YgJOr7
         oAWn99pqqJt8A9q4mxm3D89nHDgmnXporzls5mkkqH+yOWLLyxfXfKii5NcF8Ee0/g2u
         s8IJLlmq2D5BVSxkW5m9+8+/znf0sDGbHPvJYxujxUGhBa0R83sRT8Ny2A31F/aQHFQr
         pHqcTXsq7+DOPgJfOJFEZn0ULkdbbIuaB0SdM3Mh6haK/D7Zhe77ctlRAICScvGzjed+
         3C4emQybViYgj7H49PD4z03hcobpSk+nIhI2yBPhj95sRRmnENM0JwnwVTxAF+DHa+T1
         9Vpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4MF5wvoVAcQcFxy+O5hsaPWyh+ZKFFMnsvw+fQbAPAs=;
        fh=l6d/N6u1hLHPo4TGqiX7B6XhUFrf2YjgyiVnG6QkPqQ=;
        b=IP+jHY+7zt98foNJxSQ1Z0WTRcZN4zXEWMJHXLuOCqQrYlSPTUN5nPeBuZ6mISKI7u
         KYcmL1q3DnrCW6MunXcmXL/tAyNekNnzbiL5hFuBp4C7B7gewwLV1MJQM88Vt3JqRhSX
         Bh93v600x4DXxDhrZk9oYHORgM2ykm+XJZroshlGNrEtxMrEeo1FW6BIIsbN5vSCpSU7
         XhHb31zQ/5Chs5BHihH2zu7BkAcijKlmaRq3+6E934VNLlVnw+Z1MZw0amWRvLwjHBip
         i29Wv6D44RpKzqWeID5/8RwO4hQrKbUoRiNulMdKljOsGCqONbz9SyJUkvd9Z+Ge002z
         l+Wg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779215531; x=1779820331; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MF5wvoVAcQcFxy+O5hsaPWyh+ZKFFMnsvw+fQbAPAs=;
        b=FiXFZ74aWKHzr8BbB+vCUMvzuwTQu0aBjNnAbIwNwliYEOHhsbO8VY5lhRqhijd8Xa
         4umpa32ercpRm2l+XOQEExyPq6jYDncEXgqZNH0m51vRvOs3NvS9MKkM3I7YvzyNdKDO
         Y7fU4If4LikXgAd+dMzVN0XylAzBBqQnYr/e2ABFKUy2fs3ldcMnbadl0cy84f1HCxZb
         fuM5oPmPhts+Hvt75dx2DZ0K3Mlb3iJv4O2HlexrwSpZiNtbFsLaKFA6psPjOPVi0sWc
         vp52kMhXY+6Efs1RzeqEX+INqEPfImdx9NWuEdJ5Bxnw2IyrTZ1sIEasxIzfAflEQTWu
         ULaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779215531; x=1779820331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4MF5wvoVAcQcFxy+O5hsaPWyh+ZKFFMnsvw+fQbAPAs=;
        b=bMb7Yp4h9aG/aUtOOqi/j0u/AxytYk1XPirZjLQEauZ72B65mbQcC7iNE8uSDCmwMr
         koxoIXOz1KVVKx20H7DV59b+YcqNIRNBj1lxdGBMKaiE9rlferL2TbFaSRVreZzysUI9
         iHuaqSDoV7/bvY0jHIPfD+Wjmu1FQAkWRVNglHNO3P8lA4OQflAGQSWmtqyYgAlh8I6w
         wlW24aLZAt6MKjCPn7J3KABKz+TKHBUZo+MYxbsCilIhQrGrEbT9HdRoniNmkn+vYRcT
         w8d/XaLeF8Tksy8gFsLdvlvIn5XWeph35Lrz/12Zrr1DOAUHpW6c9d9UoAC6ox7MKkvx
         SN6A==
X-Gm-Message-State: AOJu0Yy9f+kNT4aNnjNqlLJ5I7//slnV9wVRnLbej79YO3P0H7KnS+Oq
	8yl5XVr0xEQr5epTgaoxFCM7G2vaBu1Pk72+bWNdBsXCNsOI/7cPssY4YhfroTOn51U0Q5FoUza
	Hql/PiIVant22gvXLChgp/CIiILZjHfQpdchfA0Tw
X-Gm-Gg: Acq92OH/s3eS3D/TEwxKCGHC4kgS9AWUEQ7jlx3RJHJaQApLIYblSENWfYgiG2KErzg
	iU32pNRZQYvy05CaTICU3EHpz5pGmiE75dQDoVBZL6zjiJqYKQLVB8z317XNUnJxVmEfHxZftg+
	Mo8+0kZzIhDc1klME4Lgsc7MpnbyF4yH1uF5SqEYOd25wGj/5zE4nAamduHqKKUU4nSF9XfYYB9
	UMot+GVEt/M62c7py9LIVWIxrRL2jyzO06T+rTz2yUGJeLm3wckIPNl1BDEfbJ1PS7KorgIUoyG
	4NHMeXNEarvQf38=
X-Received: by 2002:a05:622a:8414:20b0:516:8fad:8fd3 with SMTP id
 d75a77b69052e-516a76459bbmr7630921cf.11.1779215530592; Tue, 19 May 2026
 11:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260414194702.1229094-1-praan@google.com> <20260414194702.1229094-11-praan@google.com>
In-Reply-To: <20260414194702.1229094-11-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 19 May 2026 11:31:58 -0700
X-Gm-Features: AVHnY4KcOCpdfcysMixtioBSxJqtfSI9Z5GDLtYVyAguN65-6KZF5L0OLHqWAG0
Message-ID: <CAE2F3rApNZbpxhRSKircaERMDUUtBOhjTjUSahcpV7Z6Cy8oEQ@mail.gmail.com>
Subject: Re: [PATCH v6 10/10] iommu/arm-smmu-v3: Invoke pm_runtime before hw access
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 12:47=E2=80=AFPM Pranjal Shrivastava <praan@google.=
com> wrote:
>  /* IO_PGTABLE API */
> @@ -2823,7 +2883,16 @@ static void __arm_smmu_domain_inv_range(struct arm=
_smmu_invs *invs,
>
>                 if (cmds.num &&
>                     (next =3D=3D end || arm_smmu_invs_end_batch(cur, next=
))) {
> -                       arm_smmu_cmdq_batch_submit(smmu, &cmds);
> +                       bool active =3D arm_smmu_rpm_get_if_active(smmu);
> +
> +                       if (arm_smmu_inv_is_ats(cur))
> +                               WARN_ON_ONCE(!active);
> +
> +                       if (active) {
> +                               arm_smmu_cmdq_batch_submit(smmu, &cmds);
> +                               arm_smmu_rpm_put(smmu);
> +                       }
> +                       /* Drop this batch to ensure the next one's fresh=
 */
>                         cmds.num =3D 0;
>                 }
>                 cur =3D next;

Correct me if I'm wrong, but I don't think this is safe.

Let's say arm_smmu_is_active() returns true and
pm_runtime_get_if_active() returns 0 because dev->power.runtime_status
!=3D RPM_ACTIVE. In this situation, is it safe to skip
arm_smmu_cmdq_batch_submit()? I think the answer is no.

My understanding is that it is only safe to elide invalidations when
SMMUEN in SMMU_CR0 is cleared. Imagine runtime_status is
RPM_SUSPENDING. pm_runtime_get_if_active() returns 0, we elide
invalidations despite SMMU still being enabled.

I think that to decide whether to elide invalidations, we should
exclusively rely on the Q_STOP test in arm_smmu_cmdq_issue_cmdlist(),
not on the RPM framework.
