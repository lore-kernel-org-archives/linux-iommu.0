Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D8D13D638
	for <iommu@lists.linux.dev>; Mon,  9 Feb 2026 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770646629; cv=pass; b=gf1+LY9k0nYnZyYjytbGRyUlMtI6yfZhUmJvcw3PYFU/l2LeDzSNgL7JswfzNxBWMqF9mX/9VjvQAT4YZ52y3n2cVCEDRBD69wzIy9zHajWfngN0H5EJEaTeq3+HSOAcNqzHqYEQFeaPmVLnMGxsbpYj2zUFGoe768YIBn20fKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770646629; c=relaxed/simple;
	bh=5qi2e7syoMilbkub7qStvacUGyw10chwWIzT4wjfCjU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=p/l8C2/eQf24Jq7jtrkwi4s5JqikJTIs2kYjEyUHmKjFeLkkAdJ2RWkbKo0haFqx2b78quhMkftnoWrTw9Qtv/ApR2E6PzknssHE91SRX/1TFo5xcpaz3djbCZSM5dlyZvy/O3IMOUwfWuOMaE05hUt8+PCWkzqNIoHdicnC2+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=AeDmr6jd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="AeDmr6jd"
ARC-Seal: i=1; a=rsa-sha256; t=1770646618; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iiuqp57FkpLFJcjuZVJAgpva+Q5pnHryJXd0sJWil5stMMM7ASMsAguWNNvKynlx0acbJn1A+Ok8ItZhlY9rjwUrMB2eqHUWC5+NyP8bZWI0bqKRosnVfjV1f9vtmdMC8/xGEVYNHOikFxJMJqZ0Tuz+V+5NqShoC+FTMy4fDT8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770646618; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AysLz6m5ojrMuJyksqJ8iV6GFh4vKQlAeXZbWdph0Iw=; 
	b=D/yVa71NwXdlLMv4/mtybDzePg4UuBSP7AgKSnNwT8mx/n/PRM4Uw9q4z+ChPRrhjmIQGWJy4ziQ9teZ0Ccs1rE2ec6EZa/3ji/NUtGt1/fAMF7wIW216oJbHaChPfgJYvch7q97pkaEbbQthlOeB5s7EfaFnpRzIlOARdBrvpw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770646617;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Content-Transfer-Encoding:From:From:Mime-Version:Subject:Subject:Date:Date:Message-Id:Message-Id:References:Cc:Cc:In-Reply-To:To:To:Reply-To;
	bh=AysLz6m5ojrMuJyksqJ8iV6GFh4vKQlAeXZbWdph0Iw=;
	b=AeDmr6jdcikVYQ7HaIXWDD7tGnYaYFu3aYMpr9KVt5CLHNynnFdbfe6tfvuBH+dT
	Q8pPSeBbcnl+civP5HP8gTVF6Db/nU2CBYVuU+xKgs6Hy7TYK1aTZJKgqw7WESPmizC
	qeN40qWUo4KBrktQLQOrtBhErJMPxyMlBO5lBZrI=
Received: by mx.zohomail.com with SMTPS id 1770646615447347.7260580763517;
	Mon, 9 Feb 2026 06:16:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Daniel Almeida <daniel.almeida@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH] iommu/io-pgtable: Add support for Arm Mali v10+ GPUs page table format
Date: Mon, 9 Feb 2026 11:16:38 -0300
Message-Id: <58767D4C-505C-424B-AD08-C042BAA3FC34@collabora.com>
References: <20260209112542.194140-1-liviu.dudau@arm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Karunika Choo <karunika.choo@arm.com>,
 Liviu Dudau <liviu@dudau.co.uk>, Alice Ryhl <aliceryhl@google.com>,
 rust-for-linux <rust-for-linux@vger.kernel.org>
In-Reply-To: <20260209112542.194140-1-liviu.dudau@arm.com>
To: Liviu Dudau <liviu.dudau@arm.com>
X-Mailer: iPhone Mail (23C71)
X-ZohoMailClient: External




> On 9 Feb 2026, at 08:27, Liviu Dudau <liviu.dudau@arm.com> wrote:
>=20
> =EF=BB=BFFrom: Liviu Dudau <liviu@dudau.co.uk>
>=20
> The Arm Mali v10+ GPU drivers have been (ab)using the ARM_64_LPAE_S1
> format as they are mostly compatible with it and some of the gaps
> left in the code to allow for ARM_MALI_LPAE format (pre-v10 GPUs)
> is helping to paper over differences. In preparation for adding support
> for changes introduced in v15 GPUs, add a format specific for modern
> Mali GPUs.
>=20
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> ---
>=20
> This patch is trying to gauge interest in adding proper support for Arm Ma=
li
> CSF GPUs via the simple approach of extending the generic Arm page table c=
ode
> to add support for the PTE format of the GPUs. In order to test the change=
s
> I've decided to add the phba bits to the arm_lpae_s1_cfg struct to validat=
e
> the allocation and setup of the page table entries, but in the end I'm
> targetting the specific arm_mali_csf_cfg structure that will support
> the GPUs PTEs.
>=20
> I'm interested to learn if this approach is considered sane and what I nee=
d to
> pay attention to when adding a new struct to the io_pgtable_cfg union. The=
 patch
> is intentionally not complete with all the changes that switching to the n=
ew
> struct will entail as I didn't wanted to be dragged into a full code revie=
w, but
> I can add them if wanted.
>=20
>=20
> Best regards,
> Liviu
>=20
> ---
> drivers/iommu/io-pgtable-arm.c | 161 ++++++++++++++++++++++++++++++++-
> drivers/iommu/io-pgtable.c     |   1 +
> include/linux/io-pgtable.h     |  18 ++++
> 3 files changed, 179 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm=
.c
> index 05d63fe92e436..48aea598ab0c9 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -482,6 +482,7 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_=
lpae_io_pgtable *data,
>    arm_lpae_iopte pte;
>=20
>    if (data->iop.fmt =3D=3D ARM_64_LPAE_S1 ||
> +        data->iop.fmt =3D=3D ARM_MALI_CSF ||
>        data->iop.fmt =3D=3D ARM_32_LPAE_S1) {
>        pte =3D ARM_LPAE_PTE_nG;
>        if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
> @@ -569,6 +570,8 @@ static int arm_lpae_map_pages(struct io_pgtable_ops *o=
ps, unsigned long iova,
>        return -EINVAL;
>=20
>    prot =3D arm_lpae_prot_to_pte(data, iommu_prot);
> +    if (data->iop.fmt =3D=3D ARM_MALI_CSF)
> +        prot |=3D cfg->arm_lpae_s1_cfg.pbha;
>    ret =3D __arm_lpae_map(data, iova, paddr, pgsize, pgcount, prot, lvl,
>                 ptep, gfp, mapped);
>    /*
> @@ -864,7 +867,8 @@ static int arm_lpae_read_and_clear_dirty(struct io_pgt=
able_ops *ops,
>        return -EINVAL;
>    if (WARN_ON((iova + size - 1) & ~(BIT(cfg->ias) - 1)))
>        return -EINVAL;
> -    if (data->iop.fmt !=3D ARM_64_LPAE_S1)
> +    if (data->iop.fmt !=3D ARM_64_LPAE_S1 ||
> +        data->iop.fmt !=3D ARM_MALI_CSF)
>        return -EINVAL;
>=20
>    return __arm_lpae_iopte_walk(data, &walk_data, ptep, lvl);
> @@ -1236,6 +1240,155 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *=
cfg, void *cookie)
>    return NULL;
> }
>=20
> +static struct io_pgtable *
> +arm_mali_csf_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> +{
> +    unsigned int max_addr_bits =3D 48;
> +    unsigned long granule, page_sizes;
> +    struct arm_lpae_io_pgtable *data;
> +    typeof(&cfg->arm_lpae_s1_cfg.tcr) tcr =3D &cfg->arm_lpae_s1_cfg.tcr;
> +    int levels, va_bits, pg_shift;
> +    u64 reg;
> +
> +    if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_TTBR1 |
> +                IO_PGTABLE_QUIRK_NO_WARN))
> +        return NULL;
> +
> +    if (!(cfg->pgsize_bitmap & (SZ_4K | SZ_16K)))
> +        return NULL;
> +
> +    if (cfg->pgsize_bitmap & PAGE_SIZE)
> +        granule =3D PAGE_SIZE;
> +    else if (cfg->pgsize_bitmap & ~PAGE_MASK)
> +        granule =3D 1UL << __fls(cfg->pgsize_bitmap & ~PAGE_MASK);
> +    else if (cfg->pgsize_bitmap & PAGE_MASK)
> +        granule =3D 1UL << __ffs(cfg->pgsize_bitmap & PAGE_MASK);
> +    else
> +        granule =3D 0;
> +
> +    switch (granule) {
> +    case SZ_4K:
> +        page_sizes =3D (SZ_4K | SZ_2M | SZ_1G);
> +        break;
> +    case SZ_16K:
> +        page_sizes =3D (SZ_16K | SZ_32M | SZ_64G);
> +        break;
> +    default:
> +        page_sizes =3D 0;
> +    }
> +
> +    cfg->pgsize_bitmap &=3D page_sizes;
> +    cfg->ias =3D min(cfg->ias, max_addr_bits);
> +    cfg->oas =3D min(cfg->oas, max_addr_bits);
> +
> +    data =3D kmalloc(sizeof(*data), GFP_KERNEL);
> +    if (!data)
> +        return NULL;
> +
> +    pg_shift =3D __ffs(cfg->pgsize_bitmap);
> +    data->bits_per_level =3D pg_shift - ilog2(sizeof(arm_lpae_iopte));
> +
> +    va_bits =3D cfg->ias - pg_shift;
> +    levels =3D DIV_ROUND_UP(va_bits, data->bits_per_level);
> +    data->start_level =3D ARM_LPAE_MAX_LEVELS - levels;
> +
> +    /* Calculate the actual size of our pgd (without concatenation) */
> +    data->pgd_bits =3D va_bits - (data->bits_per_level * (levels - 1));
> +
> +    data->iop.ops =3D (struct io_pgtable_ops) {
> +        .map_pages    =3D arm_lpae_map_pages,
> +        .unmap_pages    =3D arm_lpae_unmap_pages,
> +        .iova_to_phys    =3D arm_lpae_iova_to_phys,
> +        .read_and_clear_dirty =3D arm_lpae_read_and_clear_dirty,
> +        .pgtable_walk    =3D arm_lpae_pgtable_walk,
> +    };
> +
> +    /* TCR */
> +    if (cfg->coherent_walk) {
> +        tcr->sh =3D ARM_LPAE_TCR_SH_IS;
> +        tcr->irgn =3D ARM_LPAE_TCR_RGN_WBWA;
> +        tcr->orgn =3D ARM_LPAE_TCR_RGN_WBWA;
> +        if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA)
> +            goto out_free_data;
> +    } else {
> +        tcr->sh =3D ARM_LPAE_TCR_SH_OS;
> +        tcr->irgn =3D ARM_LPAE_TCR_RGN_NC;
> +        if (!(cfg->quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA))
> +            tcr->orgn =3D ARM_LPAE_TCR_RGN_NC;
> +        else
> +            tcr->orgn =3D ARM_LPAE_TCR_RGN_WBWA;
> +    }
> +
> +    switch (ARM_LPAE_GRANULE(data)) {
> +    case SZ_4K:
> +        tcr->tg =3D ARM_LPAE_TCR_TG0_4K;
> +        break;
> +    case SZ_16K:
> +        tcr->tg =3D ARM_LPAE_TCR_TG0_16K;
> +        break;
> +    case SZ_64K:
> +        tcr->tg =3D ARM_LPAE_TCR_TG0_64K;
> +        break;
> +    }
> +
> +    switch (cfg->oas) {
> +    case 32:
> +        tcr->ips =3D ARM_LPAE_TCR_PS_32_BIT;
> +        break;
> +    case 36:
> +        tcr->ips =3D ARM_LPAE_TCR_PS_36_BIT;
> +        break;
> +    case 40:
> +        tcr->ips =3D ARM_LPAE_TCR_PS_40_BIT;
> +        break;
> +    case 42:
> +        tcr->ips =3D ARM_LPAE_TCR_PS_42_BIT;
> +        break;
> +    case 44:
> +        tcr->ips =3D ARM_LPAE_TCR_PS_44_BIT;
> +        break;
> +    case 48:
> +        tcr->ips =3D ARM_LPAE_TCR_PS_48_BIT;
> +        break;
> +    case 52:
> +        tcr->ips =3D ARM_LPAE_TCR_PS_52_BIT;
> +        break;
> +    default:
> +        goto out_free_data;
> +    }
> +
> +    tcr->tsz =3D 64ULL - cfg->ias;
> +
> +    /* MAIRs */
> +    reg =3D (ARM_LPAE_MAIR_ATTR_NC
> +           << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_NC)) |
> +          (ARM_LPAE_MAIR_ATTR_WBRWA
> +           << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_CACHE)) |
> +          (ARM_LPAE_MAIR_ATTR_DEVICE
> +           << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_DEV)) |
> +          (ARM_LPAE_MAIR_ATTR_INC_OWBRWA
> +           << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE)=
);
> +
> +    cfg->arm_lpae_s1_cfg.mair =3D reg;
> +
> +    /* Looking good; allocate a pgd */
> +    data->pgd =3D __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data),
> +                       GFP_KERNEL, cfg, cookie);
> +    if (!data->pgd)
> +        goto out_free_data;
> +
> +    /* Ensure the empty pgd is visible before any actual TTBR write */
> +    wmb();
> +
> +    /* TTBR */
> +    cfg->arm_lpae_s1_cfg.ttbr =3D virt_to_phys(data->pgd);
> +    return &data->iop;
> +
> +out_free_data:
> +    kfree(data);
> +    return NULL;
> +}
> +
> struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns =3D {
>    .caps    =3D IO_PGTABLE_CAP_CUSTOM_ALLOCATOR,
>    .alloc    =3D arm_64_lpae_alloc_pgtable_s1,
> @@ -1265,3 +1418,9 @@ struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_=
init_fns =3D {
>    .alloc    =3D arm_mali_lpae_alloc_pgtable,
>    .free    =3D arm_lpae_free_pgtable,
> };
> +
> +struct io_pgtable_init_fns io_pgtable_arm_mali_csf_init_fns =3D {
> +    .caps    =3D IO_PGTABLE_CAP_CUSTOM_ALLOCATOR,
> +    .alloc    =3D arm_mali_csf_alloc_pgtable,
> +    .free    =3D arm_lpae_free_pgtable,
> +};
> diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
> index 843fec8e8a511..1f43f898a8121 100644
> --- a/drivers/iommu/io-pgtable.c
> +++ b/drivers/iommu/io-pgtable.c
> @@ -20,6 +20,7 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] =3D {
>    [ARM_64_LPAE_S1] =3D &io_pgtable_arm_64_lpae_s1_init_fns,
>    [ARM_64_LPAE_S2] =3D &io_pgtable_arm_64_lpae_s2_init_fns,
>    [ARM_MALI_LPAE] =3D &io_pgtable_arm_mali_lpae_init_fns,
> +    [ARM_MALI_CSF] =3D &io_pgtable_arm_mali_csf_init_fns,
> #endif
> #ifdef CONFIG_IOMMU_IO_PGTABLE_DART
>    [APPLE_DART] =3D &io_pgtable_apple_dart_init_fns,
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 7a1516011ccf7..fc9776f71a963 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -17,6 +17,7 @@ enum io_pgtable_fmt {
>    ARM_MALI_LPAE,
>    APPLE_DART,
>    APPLE_DART2,
> +    ARM_MALI_CSF,
>    IO_PGTABLE_NUM_FMTS,
> };
>=20
> @@ -148,6 +149,8 @@ struct io_pgtable_cfg {
>                u32    tsz:6;
>            }    tcr;
>            u64    mair;
> +            /* ToDo: remove this when switching to arm_mali_csf_cfg struc=
t */
> +            u64    pbha;
>        } arm_lpae_s1_cfg;
>=20
>        struct {
> @@ -175,6 +178,20 @@ struct io_pgtable_cfg {
>            u64    memattr;
>        } arm_mali_lpae_cfg;
>=20
> +        /* ToDo: switch to this structure for Mali CSF GPUs
> +          struct {
> +            u64    transtab;
> +            struct {
> +                u32    pbha:4;
> +                u32    ra:1;
> +                u32    sh:2;
> +                u32    memattr:2;
> +                u32    mode:4;
> +            } transcfg;
> +            u64 memattr;
> +        } arm_mali_csf_cfg;
> +        */
> +
>        struct {
>            u64 ttbr[4];
>            u32 n_ttbrs;
> @@ -320,6 +337,7 @@ extern struct io_pgtable_init_fns io_pgtable_arm_64_lp=
ae_s1_init_fns;
> extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
> extern struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns;
> extern struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns;
> +extern struct io_pgtable_init_fns io_pgtable_arm_mali_csf_init_fns;
> extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns;
> extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v2_init_fns;
> extern struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns;
> --
> 2.52.0
>=20

+cc Alice Ryhl and the rust-for-linux mailing list in light of the Rust abst=
ractions for this component=

