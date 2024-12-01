Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DAB17C68
	for <iommu@lists.linux.dev>; Sun,  1 Dec 2024 04:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733026826; cv=none; b=WZirHxqm8tFDpWmSkXmrF66jv7PQ3cI/jLr3cAusjLTp9dmJhXtamXq49FG5o92TkJSadJRqd2gyoYpDNjbryupa6kYB/XUzCtjUleCZQGU+vTapPY9h8KupRGAigHCyHLjEP5KJyo+tLhdH1XTl7w/zqKLU0LRwnZXayRVO8Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733026826; c=relaxed/simple;
	bh=VUkUjqL7Rbye/eCuqMhzkEXg8ZZ5YVQQ7/KMUt9x5M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqtH40dt7xe3czgZ9HkydvAeFCS1wkHtogHiXlj8lEDIwP6ZS2nOZK/74e48mr9Yyuj7N1Sur/UVLB1bxD6lCufpOtBY0zklx2VKrXz6qzXyfIQ6FrKGiW41Dxc0OUz3/0EWLvqNmppDF4ovl8X0677zEdiqfEgGu9hX0RDSWTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ijpgIiUy; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ijpgIiUy"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d0c939ab78so4269a12.0
        for <iommu@lists.linux.dev>; Sat, 30 Nov 2024 20:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733026823; x=1733631623; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmPhZNGPE8mMemtgd5DQsk0URwF4+NKg4toOn7tg90Y=;
        b=ijpgIiUy+KkilMS//MOyVPLgVDFGKeAqJDSpo3K3AmToIWGxX+k49fd3+YkFN/xedC
         IgzfSLfQPoedjm4qX7Bt3nl+SRC4p2dqJWJBtmJ3bzhz4qqaGz/w2lkAfdfpN8bBt/xa
         Ks3YwTVlXRWhFFGOlwcfivlxHIWtcMEBGAPZNBggXCzJrbTgqQI2ZdYMw49jqbynaDlA
         CE3iCXi0c6iQ9qBq1sNmu0SlooJhH9KSO+EqoBDCzsjGzvrKVIe8eFlStngBsBQuFLU/
         lt7sIZHG9DjycBp05eDk35E0YpEWEQbom5G1h+A1+r5DUCdYkKOj2Dzude/X7gHDe/vl
         wpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733026823; x=1733631623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmPhZNGPE8mMemtgd5DQsk0URwF4+NKg4toOn7tg90Y=;
        b=l7djXW4g1Mqouq/CEpM7MCip/CRJjSmAAldBK32ujfr59ZQ1c+yXMuLVhSJF6ii9TU
         ET8BENF1dZbUblTPi/7D9LVFvBLD8dPPBlz9YBw1tgY2S+3sounLgv+U2pAFaM6PzD1G
         DqVV8nWg2IV8uHb3LhXRtPcEwE63LiutGu3rJX+clHRG6KgA5pndCcGiM0waAeMlHW4u
         FWawnA5khmEahAFjfEXjqbYXXYoafJnksWRGfBzpWlFFd5YvKytyCPN1MCWuh61QlM7p
         hEzEzVR48HDDNcYv1ITElCls/zGfa5lM4e9DR8fkDb09DRJbZCLQb2Mv2l3lcfMJXpPu
         p7IA==
X-Forwarded-Encrypted: i=1; AJvYcCXndZTO/wEn1KXC/VnG4Mg4kahPxi/ossafhyBoD4fiMSx1BMtaYiFF+GDYG/zq83pdNT0aIg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywm4V+FHmI1rtmglFERV6BxlwXbD0iRSMRdfVkY7cDE7Vct/pca
	NVCuctRu7kT3E4Jw1i5gxL2n4t6FVe0LWyYE7i0BkkMIg8781IncW8Yf/BVbYmRIgySsjhssoQn
	TCLfDwBeeEBYAKOa3g/PwAAud+6uJZaQfSpys
X-Gm-Gg: ASbGncuZTefEgl04hvtb6lUoutiOST+vJ/D/xRxT2Csb89yqCss/HpOa+O8vuz5KlOW
	FD59d/oYRaI2SjolqlhcOxUKSh2KFzfR6XA2CzeWjbxHAg0MX+e/0MuVMbttQb0ui
X-Google-Smtp-Source: AGHT+IHoeM3ZWdsXpysbtXILaOMhF4g1b9pNpRPjgClx7+msxAyieBJRdcI07s8YXo322NaVWIhNiRHRu3rHoGsXDnc=
X-Received: by 2002:a50:cd5d:0:b0:5d0:bd0d:fc06 with SMTP id
 4fb4d7f45d1cf-5d0bd0dfd4emr82853a12.4.1733026822501; Sat, 30 Nov 2024
 20:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241024162516.2005652-1-smostafa@google.com> <20241024162516.2005652-2-smostafa@google.com>
In-Reply-To: <20241024162516.2005652-2-smostafa@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Sat, 30 Nov 2024 20:20:10 -0800
Message-ID: <CAE2F3rDyj8WohXHTa1H3_gqTndyJL3cUEfBnXCEibNo1oYTt3A@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/io-pgtable-arm: Fix stage-2 map/umap for
 concatenated tables
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 9:26=E2=80=AFAM Mostafa Saleh <smostafa@google.com>=
 wrote:
>
> When calculating the max number of entries in a table, Where
> RM_LPAE_LVL_IDX() understands the concatenated pgds and can return
> an index spanning more than one concatenated table (for ex for 4K
> page size > 512).
> But then, max_entries is calculated as follows:
> max_entries =3D ARM_LPAE_PTES_PER_TABLE(data) - map_idx_start;
>
> This leads to a negative index in the page table, where for:
> - map: do nothing (no OOB) as fortunately all comparisons are signed,
>   but it would return a negative mapped value.
>
> - unmap: it would leak any child tables as it skips the loop over
>   =E2=80=9C__arm_lpae_free_pgtable=E2=80=9D
>
> This bug only happens when map/unmap is requested with a page size
> equals to the first level of the concatenated table (for 40 bits input
> and 4K granule would be 1GB) and can be triggered from userspace with
> VFIO, by choosing a VM IPA in a concatenated table > 0 and using
> huge pages to mmap with the first level size.
>
> For example, I was able to reproduce it with the following command
> with mainline linux and mainline kvmtool:
>
> ./lkvm run --irqchip gicv3 -k {$KERNEL} -p "earlycon" -d {$ROOTFS}  --for=
ce-pci -c \
> `nproc` --debug -m 4096@525312 --vfio-pci 0000:00:03.0  --hugetlbfs  /hug=
epages
>
> Where huge pages with 1GB would be used and using IPA in the second table
> (512GB for 40 bits SMMU and 4K granule).
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-ar=
m.c
> index 0e67f1721a3d..3ecbc024e440 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -199,6 +199,17 @@ static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte=
,
>         return (paddr | (paddr << (48 - 12))) & (ARM_LPAE_PTE_ADDR_MASK <=
< 4);
>  }
>
> +/*
> + * Using an index returned from ARM_LPAE_PGD_IDX(), which can point to
> + * concatenated PGD concatenated, get the max entries of a that table.

I believe the macro that returns an index is called ARM_LPAE_LVL_IDX
not ARM_LPAE_PGD_IDX.

> + */
> +static inline int arm_lpae_max_entries(int i, struct arm_lpae_io_pgtable=
 *data)
> +{
> +       int ptes_per_table =3D ARM_LPAE_PTES_PER_TABLE(data);
> +
> +       return ptes_per_table - (i & (ptes_per_table - 1));
> +}
> +
>  static bool selftest_running =3D false;
>
>  static dma_addr_t __arm_lpae_dma_addr(void *pages)
> @@ -390,7 +401,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable =
*data, unsigned long iova,
>
>         /* If we can install a leaf entry at this level, then do so */
>         if (size =3D=3D block_size) {
> -               max_entries =3D ARM_LPAE_PTES_PER_TABLE(data) - map_idx_s=
tart;
> +               max_entries =3D arm_lpae_max_entries(map_idx_start, data)=
;
>                 num_entries =3D min_t(int, pgcount, max_entries);
>                 ret =3D arm_lpae_init_pte(data, iova, paddr, prot, lvl, n=
um_entries, ptep);
>                 if (!ret)
> @@ -592,7 +603,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpa=
e_io_pgtable *data,
>
>         if (size =3D=3D split_sz) {
>                 unmap_idx_start =3D ARM_LPAE_LVL_IDX(iova, lvl, data);
> -               max_entries =3D ptes_per_table - unmap_idx_start;
> +               max_entries =3D arm_lpae_max_entries(unmap_idx_start, dat=
a);
>                 num_entries =3D min_t(int, pgcount, max_entries);
>         }
>
> @@ -650,7 +661,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgt=
able *data,
>
>         /* If the size matches this level, we're in the right place */
>         if (size =3D=3D ARM_LPAE_BLOCK_SIZE(lvl, data)) {
> -               max_entries =3D ARM_LPAE_PTES_PER_TABLE(data) - unmap_idx=
_start;
> +               max_entries =3D arm_lpae_max_entries(unmap_idx_start, dat=
a);
>                 num_entries =3D min_t(int, pgcount, max_entries);
>
>                 /* Find and handle non-leaf entries */
> --
> 2.47.0.105.g07ac214952-goog
>
>
