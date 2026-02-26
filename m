Received: from relay14.grserver.gr (relay14.grserver.gr [157.180.73.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9423283FCF
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 20:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.180.73.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772139121; cv=none; b=iXYsAtFMN7/2vA1lTTYDe0cbh9bf3EKAjVydfqoBgJSOL2lZB9zjQ/xwfpPhUrdtA1k4KhiLubNmSPiut8HfkfgMnwWDBRZLUpOBAc91W/fXyXC39x74x4gIyYVhIb+J1wm+GH9oRdcOS516M6PfHkga6G23vothoNwNr+l/axg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772139121; c=relaxed/simple;
	bh=mVvVZmZu+dUgXqd9kXszClok7IlQfZtX7YPsecEj528=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHv8zbjSJUCct3nJw8/1RGU6QE2noeeBSwZCZGIw6xDVkBJ023B7KaKzO34gXAycTDHcOGZcvyjXoR82QBQjzlLFTyy3EduImh/sQkQ9SR93O4mt+lAFXJIuBA1GJoP9cVKRl4PVjGPO1EnrDu8gY51G9xHW4h+kDoTd21oN5SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=CZ7G/3n+; arc=none smtp.client-ip=157.180.73.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="CZ7G/3n+"
Received: from relay14 (localhost [127.0.0.1])
	by relay14.grserver.gr (Proxmox) with ESMTP id 2C5BC40772
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 20:51:52 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay14.grserver.gr (Proxmox) with ESMTPS id 5D3C94075D
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 20:51:51 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id AB9431FFF07
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 22:51:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1772139111;
	bh=KNSK7n3Oh8nQ2zWudN6sUZc1vOAm3iKI4kbtvKTjP5Y=;
	h=Received:From:Subject:To;
	b=CZ7G/3n+Co6tGJwDUKVTHiqft4qEQz+CK6cw6PE/97TPc5xRYcfRm8TkFdP2kUIBG
	 vQdE0OCFeCcnNnoDv0EJ99y5ibJlUx3sOFmSFY4FsJP5KGT3vZu/on/h+VcaYeRfjE
	 XsfDx1Phl2ZcgNWhAK20IbELhEre0Pc4Yktx9rSk2O7H9Mm5ktoO8vrAkDJgtofocj
	 WdvkXIaoKqMc/TahlE97jZtdUtbrP6x55cJS44U45u8r7BGSKFoQX7DHqSvMRBhkwC
	 OAfkOiHS64f53ifqCGs1CFErxeGQK03+CD1Y88vNBsCvGjjhpvJSNdpyWqq1h1bTTK
	 mru1Pi4QeY5Ag==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.210.179) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pf1-f179.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-81df6a302b1so1566573b3a.2
        for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 12:51:50 -0800 (PST)
X-Gm-Message-State: AOJu0Yzbxefu6uFaKDRCv9BVu2Z4RJrkKe1O5bOdItaOecA7wJR4VYTI
	GEgjpYTE/OdNqryHhejVA9BZwDMY6vf0kpAevXpTWKYgk0PL5ogKA75Y7H3pPf6TM2Ie060AHuo
	9QwjfgDMZGOahU++HkOuyIoguNrRZNKg=
X-Received: by 2002:a17:90b:4c0e:b0:356:41c2:896f with SMTP id
 98e67ed59e1d1-35965c330f3mr442317a91.7.1772139109302; Thu, 26 Feb 2026
 12:51:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260226204400.15573-1-lkml@antheas.dev>
In-Reply-To: <20260226204400.15573-1-lkml@antheas.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 26 Feb 2026 21:51:38 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHjPNgWE4S4RYekiSw7-cTpgLiw0ZZrJ_L1PZuqJa=uUw@mail.gmail.com>
X-Gm-Features: AaiRm52dSqGU1Cyn1nb2XUsCKLJ46CD2a_t7RH3Lbj0OeGo8rSrxsqqOS3CxNSc
Message-ID: 
 <CAGwozwHjPNgWE4S4RYekiSw7-cTpgLiw0ZZrJ_L1PZuqJa=uUw@mail.gmail.com>
Subject: Re: [PATCH v2] iommu: Skip mapping at address 0x0 if it already
 exists
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Vasant Hegde <vasant.hegde@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, dnaim@cachyos.org,
	Mario.Limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <177213911096.2349673.3361514391167423260@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Thu, 26 Feb 2026 at 21:44, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> Commit 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> introduces the shared iommu page table for AMD IOMMU. Some bioses
> contain an identity mapping for address 0x0, which is not parsed
> properly (e.g., certain Strix Halo devices). This causes the DMA
> components of the device to fail to initialize (e.g., the NVMe SSD
> controller), leading to a failed post.
>
> Specifically, on the GPD Win 5, the NVME and SSD GPU fail to mount,
> making collecting errors difficult. While debugging, it was found that
> a -EADDRINUSE error was emitted and its source was traced to
> iommu_iova_to_phys(). After adding some debug prints, it was found that
> phys_addr becomes 0, which causes the code to try to re-map the 0
> address and fail, causing a cascade leading to a failed post. This is
> because the GPD Win 5 contains a 0x0-0x1 identity mapping for DMA
> devices, causing it to be repeated for each device.
>
> The cause of this failure is the following check in
> iommu_create_device_direct_mappings(), where address aliasing is handled
> via the following check:
>
> ```
> phys_addr = iommu_iova_to_phys(domain, addr);
> if (!phys_addr) {
>         map_size += pg_size;
>         continue;
> }
> ````
>
> Obviously, the iommu_iova_to_phys() signature is faulty and aliases
> unmapped and 0 together, causing the allocation code to try to
> re-allocate the 0 address per device. However, it has too many
> instantiations to fix. Therefore, catch ret == -EADDRINUSE from
> iommu_map() and, instead of bailing, skip the mapping.
>
> Fixes: 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>
> ---
> V1: https://lore.kernel.org/lkml/20260221235050.2558321-1-lkml@antheas.dev/
>
> Changes since V1:
>   - Remove closes tag. Turns out there are multiple compounding bugs.
>     See [1]
>   - Remove warn log
>   - Remove the addr check and make skipping universal
>   - Cleanup commit message
>
> [1] https://github.com/CachyOS/linux-cachyos/issues/704
> ---
>  drivers/iommu/iommu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 2ca990dfbb88..0a15c22df94f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1218,6 +1218,14 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
>                                 ret = iommu_map(domain, addr - map_size,
>                                                 addr - map_size, map_size,
>                                                 entry->prot, GFP_KERNEL);
> +                               /*
> +                                * iommu_iova_to_phys() may return 0 for allicated addresses,

*allocated, whoops

> +                                * e.g., for the 0 address, causing iommu_map to fail. Since
> +                                * the intent of the code is to allow aliasing of reserved
> +                                * regions, ignore the EADDRINUSE error.
> +                                */
> +                               if (ret == -EADDRINUSE)
> +                                       ret = 0;
>                                 if (ret)
>                                         goto out;
>                                 map_size = 0;
>
> base-commit: f14faaf3a1fb3b9e4cf2e56269711fb85fba9458
> --
> 2.52.0
>
>

