Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545FC27FB1C
	for <iommu@lists.linux.dev>; Sun, 12 Apr 2026 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775999048; cv=none; b=HPlHuH9566stlt+bwE8VFNfZCe2wtbltZnZYkKTkuNyxEHIKt6EaNwog6L8YubpV5zUG0XJXdxSmgIVjItDduLxZ6o4txvNFJw39Nk3wndxVSUN2OSvs5PyBWkZ3BexdasIaVLyY+JC3osF8N887zbwL2x/1uZ50sKuYU9h/RvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775999048; c=relaxed/simple;
	bh=5Bqrbn2k9TOdsiAH38KQq4JwdpFH359AVe8NrWa9IHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TT1Ubrdx/Cge2IGc6+frokM6mBsp3mJypOPJ2nIDN2u+MPip41SjNlqF6KYrYR08Y0s366fRnOala8JKki1gcNI35dbUjzwadQD5mLfa7Io9SgzelM2//hQZxYWC53OLGccd2nVK+w++DDpAaHBCAKL9twKdJtgthSqPLSJ8Hqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acUj9fiO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acUj9fiO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DB4C2BCC7
	for <iommu@lists.linux.dev>; Sun, 12 Apr 2026 13:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775999047;
	bh=5Bqrbn2k9TOdsiAH38KQq4JwdpFH359AVe8NrWa9IHY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=acUj9fiOeaIPYUxTvtPLJcosDRTm64YAp4LKVYnU4ri5zy7WTcjd2zHdmtfSeqz6G
	 B/6KLCdyGRhgHC0C7ICkJK2fEBM1vUdyVXT5DDDgng6T0/vVKvMueSnux7qIaVV/4B
	 jXGmaIKJprr7yrzN+81/1mRNTsuJt5xtdfyqcZp99kTEpEA0NAvmlVPPFSzGQRdt+2
	 /XhB4xA5ZMZBshCh55mJ9on1Ni1ADrnXhstPusW/FVNiYAaDa+m3JZQKF0SdQtHskK
	 lk7bm9vTbHq55ODDzZTisrnaunnZTs8K+do0It33t/wk21RWGK4QN1b6mc+sPJ96Iw
	 07DJoT/hP6qBg==
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d03db7f87so2250184f8f.3
        for <iommu@lists.linux.dev>; Sun, 12 Apr 2026 06:04:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+SyhJrOj50s67Q5tfGIsKkl6A1Iv3Kb3JiNdb7HW/GRgWK0eqIyrXzgBKEG4cK8jOO5v0AJw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4wIXwF2udz3EKTyF0yw/TG+uJqA+Wn/efcO9HoCN/Nk4UeJwm
	NudmNmhIfbrcLjb85Bmi3M4ymNrmx7scmqNdzpqXNE57tl14+5P2m/2+Ir1mlrVtJKjzlMBWOoG
	K8qw9sYIum84YNB+8emHknCFfroZzVD0=
X-Received: by 2002:a05:6000:26cf:b0:43d:613:4036 with SMTP id
 ffacd0b85a97d-43d642be547mr13803956f8f.37.1775999046355; Sun, 12 Apr 2026
 06:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260411022223.91029-1-fangyu.yu@linux.alibaba.com> <20260411022223.91029-2-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260411022223.91029-2-fangyu.yu@linux.alibaba.com>
From: Guo Ren <guoren@kernel.org>
Date: Sun, 12 Apr 2026 21:03:54 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSXnUA2nAnVE=wMvW-=rcKj6a8f8DFTaSs+uEu6YfLgLA@mail.gmail.com>
X-Gm-Features: AQROBzA6Z2M_85dwJnKtYOBK9MfzLI4lmy3tM3YGVlERgho4gFxSwFBRusnFW8A
Message-ID: <CAJF2gTSXnUA2nAnVE=wMvW-=rcKj6a8f8DFTaSs+uEu6YfLgLA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/riscv: Advertise Svpbmt support to generic page table
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	tjeznach@rivosinc.com, jgg@ziepe.ca, kevin.tian@intel.com, 
	baolu.lu@linux.intel.com, vasant.hegde@amd.com, iommu@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 10:22=E2=80=AFAM <fangyu.yu@linux.alibaba.com> wrot=
e:
>
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> The RISC-V IOMMU can optionally support Svpbmt page-based memory types
> in its page table format. When present,the generic page table code can
> use this capability to encode memory attributes (e.g. MMIO vs normal
> memory) in PTEs.
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/iommu/riscv/iommu.c       | 2 ++
>  include/linux/generic_pt/common.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index c7d0342aa747..e53883935563 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1194,6 +1194,8 @@ static struct iommu_domain *riscv_iommu_alloc_pagin=
g_domain(struct device *dev)
>         cfg. common.features =3D BIT(PT_FEAT_SIGN_EXTEND) |
>                               BIT(PT_FEAT_FLUSH_RANGE) |
>                               BIT(PT_FEAT_RISCV_SVNAPOT_64K);
> +       if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SVPBMT)
> +               cfg.common.features |=3D BIT(PT_FEAT_RISCV_SVPBMT);
>         domain->riscvpt.iommu.nid =3D dev_to_node(iommu->dev);
>         domain->domain.ops =3D &riscv_iommu_paging_domain_ops;
>
> diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt=
/common.h
> index fc5d0b5edadc..dfadf8a5752a 100644
> --- a/include/linux/generic_pt/common.h
> +++ b/include/linux/generic_pt/common.h
> @@ -188,6 +188,7 @@ enum {
>          * Support the 64k contiguous page size following the Svnapot ext=
ension.
>          */
>         PT_FEAT_RISCV_SVNAPOT_64K =3D PT_FEAT_FMT_START,
> +       PT_FEAT_RISCV_SVPBMT,
>
>  };
>
> --
> 2.50.1
>

Reviewed-by: Guo Ren <guoren@kernel.org>


--
Best Regards
 Guo Ren
