Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B053178372
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 06:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770012131; cv=pass; b=EbLVBwqlr1LTVm5CtIOY1qK+rB7aQFAqUv3VnnrTYpORRHFORkXL2Xvayy/YpJ8ig/kferROrMeRi5233tTAu33w3cCyuBa6xVUt6zExn9yor9n+mk2dP9sC3iIGBiHnJN1XFcJ6WxlrkOrMNrJBeb3B6moOGtgLjcWEmm5X6Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770012131; c=relaxed/simple;
	bh=1PCVKoGEu5ZKGgsfNA8Godrm165Zgd+zEgQyqYZf1M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnpA/T2nwNJXTVenzeOGKUb6xX3+KmfVjZb7yBRpLXr7SauEVln5ErTFuvKniN0UY2wavIhexXdNrdztuAqalnzODHfV0Ub87hXNN5Fi3n4BKI/at3J6q3ztRy5ItuMLaj4CEkxPW0sT0aHfxFElUwxTgn/vNv+MEg24RQYk+Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=OHnZiBCS; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="OHnZiBCS"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-45f126d47b8so2711188b6e.2
        for <iommu@lists.linux.dev>; Sun, 01 Feb 2026 22:02:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770012128; cv=none;
        d=google.com; s=arc-20240605;
        b=PW+xhtUyIGy5l6RKYmfDl0sOowPda6Cd+SadIEK6xdAlhVioTkcusbByN7Oepw08TI
         c+i0QnDO84DuWhMLtQUn+unRbtP40kSFvxGP+uhazENWPL2kV7qeiLq9g5ivRdwAKzSB
         lrWnZFA/yQ0L7flXs1AeCIhsiQ8ZDPUMjb6lz6KS/AsIH8nhFBrhRWsPqoLTAOpxck9e
         bFsKBr48cZAWvY/yY3jWcve5egSouR9nczyU9/y88tUGQNOWTC3+rKuq/Xb/KngZ9fMU
         6SOgyb5en+q6SNL1VdbNrxOzXe3dVxkgSrIzs5tojxesCivFHZdHP9r3RxMagCLeQ8UW
         8ilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GcxQOk1Ogg7o0Jhu3EeWbmSG4NAptutIfk5zNYKLdfs=;
        fh=IJDGAmIXOTcHu5F/gw47+1QqMPye5LHLkKwpjAzPtRI=;
        b=JgyOcBaxhTD+n0bB4B5QDe0sybHRQjlZ+ZAFW+k4x9+qfKpWiZczILn0uL9HzzXeg6
         +fU7HbKR64qGAM7k8Q2N4oALEqne70L6sAl/tD5WVTYi03J8fy0+Go0NWLapRM4x76fY
         VpqwqH1ZUC/aX9VPop0zJzSjHxsF7Z3u1UZsDGMUXsXJyR4iXxLprW3CssOpyBuR44J5
         /UPfdLI+LY61JUAkB6Ihb03/1fW1/3NLZcyF6Pue2vSu0tNXsuo2REhBFW3e+KozYGnQ
         seWxECHJlwI/aD5PbwK30VyYT+xCmKCtr8MEdjcG2Iv19P5Lm/GJLZ9gvIe24cHeGI60
         4ZvQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1770012128; x=1770616928; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcxQOk1Ogg7o0Jhu3EeWbmSG4NAptutIfk5zNYKLdfs=;
        b=OHnZiBCSB9tPxsfdQWn7b/NiHJIAAsn6CEMr7ZGnYp45eGyLYb5hIEc6+RuIFwhYHb
         XXxDyWLCcsu5fGhszZI9gKFcvZzUkmhTWF16Blc99LPHHIXUh2IlaWzhfiumUvGpnbL9
         REGaKqDUXlqsJmN8eK/fDd6FAlVc7hHwopixkpd1fyYkKLXy0FTOSgRmGP2evO9Is2ft
         T3dkhySWMDJzi4Y/2hmpcHmup3NbCSJ/4kKVbiVCSuIE5/8fGV+fAUenL7ttexxsXGY9
         3Y2luynKNll9jS+cdg9VobDZGRoymP+96DTRxz7rTcZpCChdeqO+kqFSznQL6EpbxUMZ
         q+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770012128; x=1770616928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GcxQOk1Ogg7o0Jhu3EeWbmSG4NAptutIfk5zNYKLdfs=;
        b=wNl8/FeFgl1sUXv8NXUZPjobLUGdeMgUge6+BsvaaELzaITAyimRKHgI/9QGfD/y0w
         aISkxQL0cw7uLsodkXKMbgaBoctLvQL+p35dB/ZlxkgwFBNu1Sz/pOngIPdWWumdURmS
         dpGbdJVq9Q1qNuND6VisoNFQDa4mTWTdrsu9DZkoSzsB88qMGKh/3eWzta0oFlLjFdnb
         DQNwLiIFFUKE33YIqjFD7Us2dGk/R1KU9iuMJBrextJ9sbJ8hqOzyQeWQfqexKswUmjP
         BG40L8UR8reywgkEGgJzD81WqdE9jlv/I83dMWVs15/FIWxzDbGZSuabV3YsB2sja/rl
         Vd2g==
X-Forwarded-Encrypted: i=1; AJvYcCWPj6v13RD5koDM+f8oBPAmIabbodQ3wGt1ukFjlF3Oq61px+3A+ZUFKnebQ60u7ii+4D006A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwI8YmYsLmqJzmQyT9VPQEzZcm3YMTJqwF0ynffXUtbWZ7bEiO9
	JWqZa2Olte4a7aECN7+fqUvso4mjD5MIoflUCAQFXhikvYQJ++ry8euJAjyuLa/emVYu5THyhCG
	T77uq7MrPSv976SzTSQdkLKDreCl2YLRsCRK34yZj5A==
X-Gm-Gg: AZuq6aIIXw+aCRG8Ph9DrH5NaKTxG4YZt9ncem4bHC8Dy9lAECrcqoaR3IHTcrbFWHO
	PSSQISls+Nbwkd6fM7XytC7TmL3jPbpRAxamg0VL9WxcfX80QBChTS51aVsvAaz3MsOZ54P2DXc
	4kvAHwUm8D1rC0KUd3PnHgufhtlcwFfo+xEDVR3DMsf+hhuI5G63Cy87IJgmGPN176yCQqaW//l
	d7in0HIuF6zN87mFlvEEOd6Ql1vJLc+7HgMn7yRBlHr0xK4TJ30YabHx3bRy6fJiyd3EG4=
X-Received: by 2002:a05:6820:22a7:b0:662:fc84:fa6b with SMTP id
 006d021491bc7-6630f35f60cmr5159965eaf.49.1770012128041; Sun, 01 Feb 2026
 22:02:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v3-9dbf0a72a51c+302-iommu_pt_riscv_jgg@nvidia.com>
In-Reply-To: <0-v3-9dbf0a72a51c+302-iommu_pt_riscv_jgg@nvidia.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Sun, 1 Feb 2026 22:01:55 -0800
X-Gm-Features: AZwV_Qje4rxoo7R40kPWf455fQUtzOoH5ybCxsGtQwxNUqW6waJoYKR0ZFyVEDA
Message-ID: <CAH2o1u5-VuEUJp2MNb41uxQJk=SR1uZbQkiqQWoLBj-+GXTVkw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Convert riscv to use the generic iommu page table
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, linux-riscv@lists.infradead.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	lihangjing@bytedance.com, Xu Lu <luxu.kernel@bytedance.com>, 
	patches@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Vincent Chen <vincent.chen@sifive.com>, xieyongji@bytedance.com, tjeznach@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 4:00=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> [ Joerg, I think we are good now, please pick it up this cycle ]
>
> This is a fairly straightforward conversion of the RISC-V iommu driver to
> use the now merged generic iommu page table code.
>
> It brings support for SVNAPOT which is a 64K contiguous page. Otherwise i=
t
> should not change the behavior.
>
> The series disables SADE as the dirty tracking support is not implemented
> in the driver and should be done somewhat differently. The generic code
> gets further along though this does not include the format implementation
> of read and clear dirty.
>
> The format implementation should be able to support the 32 bit option, bu=
t
> this does not enable the iommu implementation as there seems to be no use=
r
> today.
>
> It looks like RISCV could support the DYNAMIC_TOP option. It would requir=
e
> some additional work on the core side to interact safely with SIGN_EXTEND=
.
>
> This is on github: https://github.com/jgunthorpe/linux/commits/iommu_pt_r=
iscv
>
> v3:
>  - Rebase to v6.19-rc7
>  - Add missed line in Kconfig
> v2: https://patch.msgid.link/r/0-v2-b11ebca8abb6+c096-iommu_pt_riscv_jgg@=
nvidia.com
>  - Rebase to v6.19-rc1
>  - Fix typo in PT_FEAT_RISCV_SVNAPOT_64K
> v1: https://patch.msgid.link/r/0-v1-d3317b0ee398+50-iommu_pt_riscv_jgg@nv=
idia.com
>
> Jason Gunthorpe (5):
>   iommupt: Add the RISC-V page table format
>   iommu/riscv: Disable SADE
>   iommu/riscv: Use the generic iommu page table
>   iommu/riscv: Enable SVNAPOT support for contiguous ptes
>   iommu/riscv: Allow RISC_VIOMMU to COMPILE_TEST
>
>  drivers/iommu/generic_pt/.kunitconfig        |   1 +
>  drivers/iommu/generic_pt/Kconfig             |  11 +
>  drivers/iommu/generic_pt/fmt/Makefile        |   2 +
>  drivers/iommu/generic_pt/fmt/defs_riscv.h    |  29 ++
>  drivers/iommu/generic_pt/fmt/iommu_riscv64.c |  11 +
>  drivers/iommu/generic_pt/fmt/riscv.h         | 313 +++++++++++++++++++
>  drivers/iommu/riscv/Kconfig                  |   8 +-
>  drivers/iommu/riscv/iommu-bits.h             |   4 +-
>  drivers/iommu/riscv/iommu.c                  | 302 +++---------------
>  include/linux/generic_pt/common.h            |  16 +
>  include/linux/generic_pt/iommu.h             |  11 +
>  11 files changed, 447 insertions(+), 261 deletions(-)
>  create mode 100644 drivers/iommu/generic_pt/fmt/defs_riscv.h
>  create mode 100644 drivers/iommu/generic_pt/fmt/iommu_riscv64.c
>  create mode 100644 drivers/iommu/generic_pt/fmt/riscv.h
>
>
> base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
> --
> 2.43.0
>

Thanks Jason for this change.

All tested, run with NVMe / NICs. No issues. Some minor performance
changes (positive or negative depending on the workload). No issues.
Open issue on QEMU RISC-V IOMMU model - SVNAPOT support is missing.
I've made a local change to fix it, and will post it soon.

Reviewed-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Tested-by: Tomasz Jeznach <tjeznach@rivosinc.com>

Best,
- Tomasz
